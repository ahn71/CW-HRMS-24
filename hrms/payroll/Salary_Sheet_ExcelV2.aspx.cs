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
                string employeeType = Server.UrlDecode(Request.QueryString["EmployeeType"]);
                ViewState["__employeeType__"] = employeeType;
                BindData();

            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {

        }

        protected void gvBackendSalaryList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }
        protected void gvAgentSalaryList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        private void BindData()
        {
            dt = new DataTable();
            dt = (DataTable)Session["__SalarySheet__"];



            if (ViewState["__employeeType__"].ToString() == "3")
            {
                DataTable reportDt = AgentFillSalaryReportTable(dt);
                ViewState["SalaryData"] = reportDt;
                gvAgentSalaryList.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
                gvAgentSalaryList.DataSource = reportDt;
                gvAgentSalaryList.DataBind();
                gvAgentSalaryList.Visible = true;
            }
            else if (ViewState["__employeeType__"].ToString() == "2")
            {
                DataTable reportDt = FillPermamentSalaryReportTable(dt);
                ViewState["SalaryData"] = reportDt;
                gvPermamentSalarySheet.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
                gvPermamentSalarySheet.DataSource = reportDt;
                gvPermamentSalarySheet.DataBind();
                gvPermamentSalarySheet.Visible = true;
            }
            else
            {
                DataTable reportDt = FillBackendSalaryReportTable(dt);
                ViewState["SalaryData"] = reportDt;
                gvBackendSalaryList.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
                gvBackendSalaryList.DataSource = reportDt;
                gvBackendSalaryList.DataBind();
                gvBackendSalaryList.Visible = true;
            }


        }


        private DataTable CreateBackendSalaryReportTable()
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
            dt.Columns.Add("Total Working Hour", typeof(decimal));
            dt.Columns.Add("Return Parcel  Deduction", typeof(decimal));

            return dt;
        }




        private DataTable CreateAgendSalaryReportTable()
        {
            try
            {
                DataTable dt = new DataTable();

                dt.Columns.Add("ID");
                dt.Columns.Add("Name");
                dt.Columns.Add("Department");
                dt.Columns.Add("Designation");
                dt.Columns.Add("KPI Achieve Days", typeof(decimal));
                dt.Columns.Add("Absent Count", typeof(decimal));

                dt.Columns.Add("Extra Duty Miniute", typeof(decimal));
                dt.Columns.Add("Total Working Hour", typeof(decimal));
                dt.Columns.Add("OT Extra Duty Count", typeof(decimal));
                dt.Columns.Add("OT Extra Duty Count Miniute", typeof(decimal));

                dt.Columns.Add("Gross Salary", typeof(decimal));
                dt.Columns.Add("Attendance Bonus", typeof(decimal));
                dt.Columns.Add("Total Working Hour Salary", typeof(decimal));
                dt.Columns.Add("Total Extra Duty Minute Amount", typeof(decimal));
                dt.Columns.Add("Total OT Extra Duty Count Amount", typeof(decimal));
                dt.Columns.Add("Total OT KPI Amount", typeof(decimal));
                dt.Columns.Add("Total KPI Amount", typeof(decimal));
                dt.Columns.Add("Absent Deduction", typeof(decimal));
                dt.Columns.Add("Return Parcel", typeof(decimal));
                dt.Columns.Add("Final Payable Amount", typeof(decimal));

                return dt;
            }
            catch (Exception ex)
            {

                throw;
            }

        }


        private DataTable CreatePermamentSalaryReportTable()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("ID");
            dt.Columns.Add("Name");
            dt.Columns.Add("Department");
            dt.Columns.Add("Status");

            dt.Columns.Add("Gross Salary", typeof(decimal));
            dt.Columns.Add("NTR", typeof(decimal));
            dt.Columns.Add("Absent Count", typeof(decimal));
            dt.Columns.Add("OT Extra Duty Count", typeof(decimal));
            dt.Columns.Add("Deduction (Min)", typeof(decimal));
            dt.Columns.Add("Extra (Min)", typeof(decimal));
            dt.Columns.Add("OT Days", typeof(decimal));
            dt.Columns.Add("Hold Salary need to adjust", typeof(decimal));
            dt.Columns.Add("KPI Achieved", typeof(decimal));
            dt.Columns.Add("Daily Income", typeof(decimal));
            dt.Columns.Add("Per Min Income", typeof(decimal));
            dt.Columns.Add("Total OT Extra Duty Count amount", typeof(decimal));
            dt.Columns.Add("Total OT Extra min Duty", typeof(decimal));
            dt.Columns.Add("Absent deduction", typeof(decimal));
            dt.Columns.Add("Total Deduction Min amount", typeof(decimal));
            dt.Columns.Add("Return Parcel Deduction", typeof(decimal));
            dt.Columns.Add("Final Payable Amount", typeof(decimal));

            return dt;
        }


        private DataTable FillBackendSalaryReportTable(DataTable sourceDt)
        {
            DataTable dt = CreateBackendSalaryReportTable();

            foreach (DataRow dr in sourceDt.Rows)
            {
                var attendance = JsonConvert.DeserializeObject<Dictionary<string, object>>(
dr["Additional"].ToString());

                decimal grossSalary = Convert.ToDecimal(dr["EmpPresentSalary"]);
                decimal daysInMonth = Convert.ToDecimal(dr["DaysInMonth"]);

                decimal dailyIncome = daysInMonth == 0 ? 0 : grossSalary / daysInMonth;
                decimal perMinIncome = dailyIncome / 480; // 8 Hour = 480 Min

                decimal deductionMinute = Convert.ToDecimal(attendance["LateMinutes"]);
                decimal deductionMinuteAmount = deductionMinute * perMinIncome;
                decimal KPIAmount = Convert.ToDecimal(attendance["KPIAMount"]);
                decimal mobileBillDeduction = Convert.ToDecimal(attendance["MobileBillDeduct"]);

                decimal totalExtraOtCount = (((grossSalary /26m)/2)*2) * (Convert.ToDecimal(attendance["HolidayDutyDays"]) + Convert.ToDecimal(attendance["WeekendDutyDays"]));
                decimal totalLateDeductionPerMinit = Math.Round(perMinIncome, 2) * deductionMinute;

                decimal finalPaySalary = grossSalary - Convert.ToDecimal(dr["AdvanceDeduction"]) + KPIAmount + totalExtraOtCount - Convert.ToDecimal(dr["AbsentDeduction"]) - totalLateDeductionPerMinit - mobileBillDeduction;

                dt.Rows.Add(
                    dr["EmpCardNo"],                  // ID
                    dr["EmpName"],                   // Name
                    dr["DptName"],                   // Department
                    dr["DsgName"],                   // Designation
                    grossSalary,                     // Gross Salary
                    dr["AbsentDay"],// Absent Count
                    Convert.ToDecimal(attendance["WeekendDutyDays"]),// OT Extra Duty Count
                    dr["lwp"],                               // NTR / Duty Adjust
                    deductionMinute,               // Deduction Min
                    Convert.ToDecimal(attendance["HolidayDutyDays"]),      // OT Days
                    dr["AdvanceDeduction"],          // Deduction / Loan
                    KPIAmount,// KPI Achieved
                    Math.Round(dailyIncome, 2),      // Daily Income
                    Math.Round(perMinIncome, 2),     // Per Min Income
                    totalExtraOtCount,             // OT Amount
                    dr["AbsentDeduction"],           // Absent Deduction
                    totalLateDeductionPerMinit, //latededuction
                    mobileBillDeduction,            // Mobile Bill Deduction
                    finalPaySalary                 // Final Payable Amount
                );
            }

            return dt;
        }

        private DataTable AgentFillSalaryReportTable(DataTable sourceDt)
        {
            DataTable dt = CreateAgendSalaryReportTable();

            const decimal HourlyRate = 46m;
            decimal perMinuteIncome = HourlyRate / 60m;

            foreach (DataRow dr in sourceDt.Rows)
            {
                var attendance = JsonConvert.DeserializeObject<Dictionary<string, object>>(
                    dr["Additional"].ToString());


                decimal totalWorkingHour = Convert.ToDecimal(attendance["TotalWorkingHour"]);
                decimal grantOTMinutes = Convert.ToDecimal(attendance["GrantOTMinutes"]);

                decimal weekendDutyMinutes = Convert.ToDecimal(attendance["WeekendDutyMinutes"]);
                decimal holidayDutyMinutes = Convert.ToDecimal(attendance["HolidayDutyMinutes"]);

                decimal lateMinutes = Convert.ToDecimal(attendance["LateMinutes"]);
                decimal kpiScore = Convert.ToDecimal(attendance["KPIScore"]);
                decimal returnParcelDeduction = Convert.ToDecimal(attendance["ReturnPercelDedc"]);

     


                // Total OT Minutes
                decimal otMinutes = weekendDutyMinutes + holidayDutyMinutes;

                // Convert OT Minutes to Hours
                decimal otHours = otMinutes / 60m;

                // Salary for Total Working Hours
                decimal workingHourSalary = totalWorkingHour * HourlyRate;

                // Salary for Extra Duty (Without OT)
                decimal extraDutyAmount = Math.Round(grantOTMinutes * perMinuteIncome);

                // Salary for OT Extra Duty
                decimal otExtraDutyAmount =Math.Round(otMinutes * perMinuteIncome);

                // Late Deduction Amount
                decimal lateDeductionAmount = lateMinutes * perMinuteIncome;

                // KPI Working Hours
                decimal totalKpiHours = totalWorkingHour + (grantOTMinutes / 60m);

                // KPI Amount
                decimal kpiAmount = totalKpiHours * kpiScore;

                // OT KPI Hours
                decimal otKpiHours = otMinutes / 60m;

                // OT KPI Amount
                decimal otKpiAmount = otKpiHours * kpiScore;

                // Total Deduction
                decimal totalDeduction = Convert.ToDecimal(dr["AbsentDeduction"]) + lateDeductionAmount;

                // Final Payable Salary
                decimal finalPaySalary = Convert.ToDecimal(dr["AttendanceBonus"]) + workingHourSalary + extraDutyAmount
                    + otExtraDutyAmount + kpiAmount + otKpiAmount - totalDeduction - returnParcelDeduction;
                dt.Rows.Add(
                    dr["EmpCardNo"],            // Employee ID
                    dr["EmpName"],              // Employee Name
                    dr["DptName"],              // Department / LOB
                    0,                          // Status

                    kpiScore,                   // KPI Achieved
                    dr["AbsentDay"],            // Absent Days

                    grantOTMinutes,             // Extra Duty Minutes (Without OT)
                    totalWorkingHour,           // Total Working Hours

                    otHours,                    // OT Extra Duty Hours
                    otMinutes,                  // OT Extra Duty Minutes

                    HourlyRate,                 // Per Hour Income

                    dr["AttendanceBonus"],      // Attendance Bonus

                    workingHourSalary,          // Working Hour Salary
                    extraDutyAmount,            // Extra Duty Amount
                    otExtraDutyAmount,          // OT Extra Duty Amount

                    otKpiAmount,                // OT KPI Amount
                    kpiAmount,                  // KPI Amount

                    Convert.ToDecimal(dr["AbsentDeduction"]),             // Total Deduction
                    returnParcelDeduction,      // Return Parcel Deduction

                    finalPaySalary              // Final Payable Salary
                );
            }

            return dt;
        }


        private DataTable FillPermamentSalaryReportTable(DataTable sourceDt)
        {
            DataTable dt = CreatePermamentSalaryReportTable();

            foreach (DataRow dr in sourceDt.Rows)
            {
                var attendance = JsonConvert.DeserializeObject<Dictionary<string, object>>(dr["Additional"].ToString());

                decimal grossSalary = Convert.ToDecimal(dr["EmpPresentSalary"]);
                decimal daysInMonth = Convert.ToDecimal(dr["DaysInMonth"]);

                decimal dailyIncome = grossSalary / 30;
                decimal perMinIncome = Math.Round(dailyIncome / 9 / 60m, 1);

                decimal deductionMinute = Convert.ToDecimal(attendance["LateMinutes"]);
                decimal totalLateDeductionPerMinit = Math.Round(perMinIncome, 2) * deductionMinute;
                decimal KPIAmount = Convert.ToDecimal(attendance["KPIAMount"]);
                decimal mobileBillDeduction = Convert.ToDecimal(attendance["MobileBillDeduct"]);
                decimal holdSalaryNeedToAdjust = 0m;
                decimal returnParcelDeduction = Convert.ToDecimal(attendance["ReturnPercelDedc"]);
                decimal extraDutyMinute = Convert.ToDecimal(attendance["GrantOTMinutes"]);  //db  theke asbe 
                decimal extraDutyMinuteAmount = perMinIncome * extraDutyMinute * 0.65m * 1.5m;
                decimal totalOtExtraDutyAmount = dailyIncome * 0.65m * 1.5m * (Convert.ToDecimal(attendance["WeekendDutyDays"]) + Convert.ToDecimal(attendance["HolidayDutyDays"]));

                decimal totalDeductionMinAmount = perMinIncome * Convert.ToDecimal(attendance["LateMinutes"]);

                decimal finalPaySalary = grossSalary + KPIAmount + totalOtExtraDutyAmount + extraDutyMinuteAmount - Convert.ToDecimal(dr["AbsentDeduction"]) - totalDeductionMinAmount - returnParcelDeduction;
                ;

                dt.Rows.Add(
                    dr["EmpCardNo"],                                                  // ID
                    dr["EmpName"],                                                    // Name
                    dr["DptName"],                                                    // Department
                    "Active",                                                         // Status
                    grossSalary,                                                      // Gross Salary
                    dr["lwp"],                                                                // lwp NTR
                    dr["AbsentDay"],                                                  // Absent Count
                    (Convert.ToDecimal(attendance["WeekendDutyDays"]),                // OT Extra Duty Count
                    Convert.ToDecimal(attendance["LateMinutes"]),                     // Deduction (Min)
                    extraDutyMinute,                                                  // Extra (Min)

                    Convert.ToDecimal(attendance["HolidayDutyDays"]),                 // OT Days
                    holdSalaryNeedToAdjust,                                           // Hold Salary need to adjust
                    KPIAmount,                                                        // KPI Achieved
                    dailyIncome,                                                      // Daily Income
                    perMinIncome,                                                     // Per Min Income
                    totalOtExtraDutyAmount,                                           // Total OT Extra Duty Count amount
                    extraDutyMinuteAmount,                                            // Total OT Extra min Duty
                    dr["AbsentDeduction"],                                            // Absent deduction
                    totalLateDeductionPerMinit,                                          // Total Deduction Min amount
                    returnParcelDeduction,                                            // Return Parcel Deduction
                    finalPaySalary                                                    // Final Payable Amount
              ));
            }

            return dt;
        }

        protected void gvPermamentSalarySheet_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }
    }
}