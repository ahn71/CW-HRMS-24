using System;
using System.Collections.Generic;
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
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=LieuLeaveReport_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.ms-excel";

                using (StringWriter sw = new StringWriter())
                {
                    HtmlTextWriter hw = new HtmlTextWriter(sw);

                    // Remove paging for export
                    gvLieuLeaveReport.AllowPaging = false;
                    BindGrid(); // Rebind without paging

                    gvLieuLeaveReport.RenderControl(hw);

                    // Restore paging
                    gvLieuLeaveReport.AllowPaging = true;

                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();
                }
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
                string query = @"SELECT  cs.EmpId,ei.EmpName,dpt.DptName, dsg.DsgName,
        DATEDIFF(DAY, ei.EmpJoiningDate, GETDATE()) AS TotalWorkingDays, DATEDIFF(DAY, ei.EmpJoiningDate, GETDATE()) / 6 AS EarnedLeave,ISNULL(LT.TotalLeaveDays, 0) AS UsedLeave,(DATEDIFF(DAY, ei.EmpJoiningDate, GETDATE()) / 6)   - ISNULL(LT.TotalLeaveDays, 0) AS BalanceLeave FROM Personnel_EmployeeInfo ei 
    INNER JOIN Personnel_EmpCurrentStatus cs ON ei.EmpId = cs.EmpId AND cs.IsActive = 1 INNER JOIN HRD_Department dpt 
        ON cs.DptId = dpt.DptId INNER JOIN HRD_Designation dsg   ON cs.DsgId = dsg.DsgId LEFT JOIN
    (
        SELECT EmpId, SUM(TotalLeaveDays) AS TotalLeaveDays 
        FROM Leave_LeaveApplications 
        WHERE LeaveTypeId = '3046'
        GROUP BY EmpId 
    ) LT ON cs.EmpId = LT.EmpId 

    WHERE cs.EmpStatus IN (1,8)
      AND cs.CompanyId = '"+companyId+"'";

    // Optional Filters
    if (!string.IsNullOrEmpty(empId))
        query += " AND cs.EmpId = '" + empId + "'";

    if (!string.IsNullOrEmpty(dptId))
        query += " AND cs.DptId = '" + dptId + "'";

    if (!string.IsNullOrEmpty(dsgId))
        query += " AND cs.DsgId = '" + dsgId + "'";

                // Execute query
            }

        }

    }
