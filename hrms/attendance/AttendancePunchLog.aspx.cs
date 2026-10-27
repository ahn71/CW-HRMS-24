using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;

namespace SigmaERP.hrms.attendance
{
    public partial class AttendancePunchLog : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            if (!IsPostBack)
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                if (getCookies == null)
                {
                    Response.Redirect(Routing.defualtUrl);
                    return;
                }
                classes.commonTask.loadDepartmentListByCompanyWithAll(ddlDepartment, getCookies["__CompanyId__"].ToString());
                txtFromDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                txtToDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
        }

        // Server-side paging + search so only one page of punches leaves the database
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object GetPunchLogs(string dptId, string fromDate, string toDate, string search, int page, int pageSize)
        {
            HttpCookie getCookies = HttpContext.Current.Request.Cookies["userInfo"];
            if (getCookies == null) return new { success = false, message = "Session expired. Please login again." };

            DateTime from, to;
            if (!DateTime.TryParseExact(fromDate, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out from)
                || !DateTime.TryParseExact(toDate, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out to))
                return new { success = false, message = "Please select a valid From Date and To Date." };
            if (from > to) return new { success = false, message = "From Date can not be greater than To Date." };

            if (page < 1) page = 1;
            if (pageSize < 1 || pageSize > 1000) pageSize = 50;

            string query = @"select ei.EmpName, ei.EmpProximityNo, dpt.DptName, dsg.DsgName, a.PunchTime, a.PunchSource, count(*) over() as TotalRows
                from tblAttExternalPunchRecords a
                inner join Personnel_EmployeeInfo ei on a.EmpId = ei.EmpId
                inner join Personnel_EmpCurrentStatus cs on ei.EmpId = cs.EmpId and cs.IsActive = 1
                inner join HRD_Department dpt on cs.DptId = dpt.DptId
                inner join HRD_Designation dsg on cs.DsgId = dsg.DsgId
                where cs.EmpStatus in (1,8) and cs.CompanyId = @CompanyId
                    and a.PunchTime >= @FromDate and a.PunchTime < @ToDate" + AccessControl.getEmpAccessCondition("cs.EmpId");
            if (!string.IsNullOrEmpty(dptId) && dptId != "0")
                query += " and cs.DptId = @DptId";
            if (!string.IsNullOrWhiteSpace(search))
                query += @" and (ei.EmpName like @Search or ei.EmpProximityNo like @Search or dpt.DptName like @Search
                    or dsg.DsgName like @Search or a.PunchSource like @Search or convert(varchar(19), a.PunchTime, 120) like @Search)";
            query += " order by a.PunchTime desc offset @Skip rows fetch next @Take rows only";

            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection con = new SqlConnection(Glory.getConnectionString()))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.CommandTimeout = 120;
                    cmd.Parameters.AddWithValue("@CompanyId", getCookies["__CompanyId__"].ToString());
                    cmd.Parameters.AddWithValue("@FromDate", from);
                    cmd.Parameters.AddWithValue("@ToDate", to.AddDays(1));
                    if (!string.IsNullOrEmpty(dptId) && dptId != "0")
                        cmd.Parameters.AddWithValue("@DptId", dptId);
                    if (!string.IsNullOrWhiteSpace(search))
                        cmd.Parameters.AddWithValue("@Search", "%" + search.Trim() + "%");
                    cmd.Parameters.AddWithValue("@Skip", (page - 1) * pageSize);
                    cmd.Parameters.AddWithValue("@Take", pageSize);
                    new SqlDataAdapter(cmd).Fill(dt);
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }

            var rows = new List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new
                {
                    empName = r["EmpName"].ToString(),
                    proximityNo = r["EmpProximityNo"].ToString(),
                    dptName = r["DptName"].ToString(),
                    dsgName = r["DsgName"].ToString(),
                    punchDate = r["PunchTime"] == DBNull.Value ? "" : Convert.ToDateTime(r["PunchTime"]).ToString("dd-MMM-yyyy", CultureInfo.InvariantCulture),
                    punchTime = r["PunchTime"] == DBNull.Value ? "" : Convert.ToDateTime(r["PunchTime"]).ToString("hh:mm:ss tt", CultureInfo.InvariantCulture),
                    punchSource = r["PunchSource"].ToString()
                });
            }
            int total = dt.Rows.Count > 0 ? Convert.ToInt32(dt.Rows[0]["TotalRows"]) : 0;
            return new { success = true, total = total, page = page, pageSize = pageSize, rows = rows };
        }
    }
}
