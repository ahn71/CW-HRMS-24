using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.hrms.Leave
{
    public partial class LieuLeaveReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                classes.commonTask.LoadBranch(ddlCompany);
                ddlCompany.SelectedIndex = 1;
                classes.commonTask.LoadDepartmentDDL(ddlDepartment,ddlCompany.SelectedValue.ToString());
                classes.commonTask.LoadDesignationAll("0",ddlDesignation);
                classes.commonTask.loadEmpCardNoByCompany(ddlEmployee, ddlCompany.SelectedValue.ToString());

            }


        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                gvLieuLeaveReport.AllowPaging = false;
                LieuLeaveSummary(ddlEmployee.SelectedValue.ToString(), ddlDepartment.SelectedValue.ToString(), ddlDesignation.SelectedValue.ToString(), ddlCompany.SelectedValue.ToString());

                // Hide SL column
                gvLieuLeaveReport.Columns[0].Visible = false;

                Response.Clear();
                Response.Buffer = true;
                Response.ClearContent();
                Response.ClearHeaders();

                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition",
                    "attachment; filename=LieuLeaveReport_" +
                    DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".xls");

                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);

                using (StringWriter sw = new StringWriter())
                {
                    HtmlTextWriter hw = new HtmlTextWriter(sw);

                    // Only render GridView
                    gvLieuLeaveReport.RenderControl(hw);

                    Response.Write(sw.ToString());
                    Response.Flush();
                    Response.SuppressContent = true;
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                }

                // restore
                gvLieuLeaveReport.Columns[0].Visible = true;
                gvLieuLeaveReport.AllowPaging = true;
                LieuLeaveSummary(ddlEmployee.SelectedValue.ToString(), ddlDepartment.SelectedValue.ToString(), ddlDesignation.SelectedValue.ToString(), ddlCompany.SelectedValue.ToString());
            }
            catch (Exception ex)
            {
                // Log error
                ScriptManager.RegisterStartupScript(this, GetType(), "exportError",
                    "alert('Export failed: " + ex.Message + "');", true);
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            // Required for GridView export
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LieuLeaveSummary(ddlEmployee.SelectedValue.ToString(),ddlDepartment.SelectedValue.ToString(),ddlDesignation.SelectedValue.ToString(),ddlCompany.SelectedValue.ToString());
        }


            private void LieuLeaveSummary(string empId, string dptId, string dsgId,string companyId)
            {
                string query = @"SELECT  cs.EmpId,RIGHT(cs.EmpCardNo, 6) + '(' + ei.EmpProximityNo  + ')' AS EmpCard,ei.EmpName,dpt.DptName, dsg.DsgName,
                    DATEDIFF(DAY, ei.EmpJoiningDate, GETDATE()) AS TotalWorkingDays, DATEDIFF(DAY, ei.EmpJoiningDate, GETDATE()) / 6 AS EarnedLeave,ISNULL(LT.TotalLeaveDays, 0) AS UsedLeave,(DATEDIFF(DAY, ei.EmpJoiningDate, GETDATE()) / 6)   - ISNULL(LT.TotalLeaveDays, 0) AS BalanceLeave FROM Personnel_EmployeeInfo ei 
                INNER JOIN Personnel_EmpCurrentStatus cs ON ei.EmpId = cs.EmpId AND cs.IsActive = 1 INNER JOIN HRD_Department dpt 
                    ON cs.DptId = dpt.DptId INNER JOIN HRD_Designation dsg   ON cs.DsgId = dsg.DsgId LEFT JOIN
                 (
                   SELECT EmpId, SUM(TotalLeaveDays) AS TotalLeaveDays FROM Leave_LeaveApplications lv inner join tblLeaveConfig lc on lv.LeaveTypeId=lc.LeaveId  WHERE lc.ShortName = 'l/l'
                    GROUP BY EmpId  ) LT ON cs.EmpId = LT.EmpId WHERE cs.EmpStatus IN (1,8) AND cs.CompanyId = '" + companyId+"'";

                // Optional Filters
                if (!string.IsNullOrEmpty(empId) && empId!= "0")
                    query += " AND cs.EmpId = '" + empId + "'";

                if (!string.IsNullOrEmpty(dptId) && dptId!= "0")
                    query += " AND cs.DptId = '" + dptId + "'";

                if (!string.IsNullOrEmpty(dsgId) && dsgId!="0")
                    query += " AND cs.DsgId = '" + dsgId + "'";

                DataTable dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable(query);
                if (dt.Rows.Count > 0)
                {
                    gvLieuLeaveReport.DataSource = dt;
                    gvLieuLeaveReport.DataBind();
                }
                
            }

        protected void gvLieuLeaveReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLieuLeaveReport.PageIndex = e.NewPageIndex;
            LieuLeaveSummary(ddlEmployee.SelectedValue.ToString(), ddlDepartment.SelectedValue.ToString(), ddlDesignation.SelectedValue.ToString(), ddlCompany.SelectedValue.ToString());
        }
    }

    }
