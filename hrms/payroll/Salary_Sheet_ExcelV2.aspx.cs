using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.hrms.payroll
{
    public partial class Salary_Sheet_ExcelV2 : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {

        }

        protected void gvSalaryReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        private void BindData()
        {
            dt = new DataTable();
            dt = (DataTable)Session["__SalarySheet__"];
            DataTable reportDt = FillSalaryReportTable(dt);
            ViewState["SalaryData"] = reportDt;

            gvSalaryReport.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            gvSalaryReport.DataSource = reportDt;
            gvSalaryReport.DataBind();

        }


        private DataTable CreateSalaryReportTable()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("ID");
            dt.Columns.Add("Name");
            dt.Columns.Add("Department");
            dt.Columns.Add("Designation");
            dt.Columns.Add("Gross Salary", typeof(decimal));
            dt.Columns.Add("Absent Count", typeof(decimal));
            dt.Columns.Add("OT Extra Duty Count", typeof(decimal));
            dt.Columns.Add("NTR/ Duty Adjust", typeof(decimal));
            dt.Columns.Add("Deduction (Min)", typeof(decimal));
            dt.Columns.Add("OT Days", typeof(decimal));
            dt.Columns.Add("Deduction/ Loan", typeof(decimal));
            dt.Columns.Add("KPI Achieved", typeof(decimal));
            dt.Columns.Add("Daily Income", typeof(decimal));
            dt.Columns.Add("Per Min Income", typeof(decimal));
            dt.Columns.Add("Total OT Extra Duty Count Amount", typeof(decimal));
            dt.Columns.Add("Absent Deduction", typeof(decimal));
            dt.Columns.Add("Total Deduction Min Amount", typeof(decimal));
            dt.Columns.Add("Mobile Bill Deduction", typeof(decimal));
            dt.Columns.Add("Final Payable Amount", typeof(decimal));

            return dt;
        }


        private DataTable FillSalaryReportTable(DataTable sourceDt)
        {
            DataTable dt = CreateSalaryReportTable();

            foreach (DataRow dr in sourceDt.Rows)
            {
                var attendance = JsonConvert.DeserializeObject<Dictionary<string, object>>(
dr["Additional"].ToString());
           
                decimal grossSalary = Convert.ToDecimal(dr["EmpPresentSalary"]);
                decimal daysInMonth = Convert.ToDecimal(dr["DaysInMonth"]);

                decimal dailyIncome = daysInMonth == 0 ? 0 : grossSalary / daysInMonth;
                decimal perMinIncome = dailyIncome / 480; // 8 Hour = 480 Min

                decimal deductionMinute = 0;
                decimal deductionMinuteAmount = deductionMinute * perMinIncome;
                decimal KPIAmount = 0;
                decimal mobileBillDeduction = 0;

                decimal totalExtraOtCount = ((grossSalary * 0.65m * 1.5m) / 30) * (Convert.ToDecimal(attendance["HolidayDutyDays"]) + Convert.ToDecimal(attendance["HolidayDutyDays"]));
                decimal totalLateDeductionPerMinit = Math.Round(perMinIncome, 2) * Convert.ToDecimal(attendance["LateMinutes"]);

                decimal finalPaySalary = grossSalary -Convert.ToDecimal(dr["AdvanceDeduction"])+ KPIAmount+ totalExtraOtCount-Convert.ToDecimal(dr["AbsentDeduction"])- totalLateDeductionPerMinit- mobileBillDeduction;

                dt.Rows.Add(
                    dr["EmpCardNo"],                  // ID
                    dr["EmpName"],                   // Name
                    dr["DptName"],                   // Department
                    dr["DsgName"],                   // Designation
                    grossSalary,                     // Gross Salary
                    dr["AbsentDay"],// Absent Count
                    Convert.ToDecimal(attendance["WeekendDutyDays"]),// OT Extra Duty Count
                    0,                               // NTR / Duty Adjust
                    Convert.ToDecimal(attendance["LateMinutes"]),               // Deduction Min
                    Convert.ToDecimal(attendance["HolidayDutyDays"]) ,      // OT Days
                    dr["AdvanceDeduction"],          // Deduction / Loan
                    0,                               // KPI Achieved
                    Math.Round(dailyIncome, 2),      // Daily Income
                    Math.Round(perMinIncome, 2),     // Per Min Income
                    totalExtraOtCount,             // OT Amount
                    dr["AbsentDeduction"],           // Absent Deduction
                    totalLateDeductionPerMinit, //latededuction
                    mobileBillDeduction,                               // Mobile Bill Deduction
                    finalPaySalary                 // Final Payable Amount
                );
            }

            return dt;
        }
    }
}