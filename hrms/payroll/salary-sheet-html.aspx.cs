using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.hrms.payroll
{
    public partial class salary_sheet_html : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = GetSalaryData();  // ✅ Get data
                RenderSalaryPages(dt);

            }
        }

        private DataTable GetSalaryData()
        {
            string query = @"SELECT EmpProximityNo as Sl,EmpId, EmpName,EmptypeId, Substring(EmpCardNo,10,6) as EmpCardNo , AbsentDay, BasicSalary, HouseRent, MedicalAllownce, AbsentDeduction,  OverTime as TotalOTHour, OTRate, round(OverTimeAmount,0) as TotalOTAmount, AttendanceBonus, DptName, CompanyName, SftName, EmpPresentSalary, Address,HolidayWorkingDays,HolidayTaka,HoliDayBillAmount, DptId, CompanyId, DsgName, TotalSalary, GrdName, GId, GName, PresentDay,WeekendHoliday,FestivalHoliday, PayableDays, Payable,NetPayable, OthersAllownce, ProvidentFund, ProfitTax, LateFine, TiffinDays, TiffinTaka, TiffinBillAmount,CasualLeave,SickLeave,AnnualLeave,OfficialLeave,DormitoryRent,TotalOverTime,TotalOtherOverTime,DaysInMonth,OthersPay,OthersDeduction,ShortLeave,AdvanceDeduction,LateDays,ConvenceAllownce,NightbilAmount,NightBillDays,convert(varchar(10), EmpJoiningDate,105) EmpJoiningDate,Stampdeduct,FoodAllownce,Activeday,EmpNetGross,EmpNameBn, DptNameBn, DsgNameBn, GrdNameBangla  FROM   v_MonthlySalarySheet  where  IsActive='1' and CompanyId  in(0001)   AND YearMonth='2024-01-01' AND FromDate='2024-01-01' AND ToDate='2024-01-31' AND IsSeperationGeneration='0'  ORDER BY CONVERT(int,DptId),convert(int,Gid), CustomOrdering";

            return CRUD.ExecuteReturnDataTable(query); 
        }




        private void RenderSalaryPages(DataTable dt)
        {
            int totalRecords = dt.Rows.Count;
            int slCounter = 1;
            int approxRowsPerPage = 9; // 5 rows per page
            int rowCount = 0;

            string companyName = dt.Rows[0]["CompanyName"].ToString();
            string companyAddress = dt.Rows[0]["Address"].ToString();

            StringBuilder html = new StringBuilder();
            StringBuilder allPages = new StringBuilder();

            string previousDeptId = "";
            string deptName = "";
            bool isFirstPage = true;

            int deptManpower = 0;
            decimal deptGross = 0, deptAbsent = 0, deptLate = 0, deptAdvance = 0, deptOthers = 0, deptNet = 0, deptBonus = 0, deptStamp = 0;

            void StartPage()
            {
                html = new StringBuilder();

                if (isFirstPage)
                {
                    html.Append($@"<div class='title'>{companyName}</div>");
                    html.Append($@"<div class='subtitle'>{companyAddress}</div><br/>");
                    isFirstPage = false;
                }

                html.Append(@"
        <div class='subtitle'>Executive Salary Sheet of Jun-2025 [ 2025-06-01 to 2025-06-30 ]</div>
        <table>
        <thead>
        <tr>
            <th rowspan='2'>SL</th><th rowspan='2'>Emp ID</th><th rowspan='2'>Name</th><th rowspan='2'>Section</th>
            <th rowspan='2'>Designation</th><th rowspan='2'>Join Date</th><th rowspan='2'>Grade</th>
            <th colspan='4'>Gross Salary</th><th rowspan='2'>Gross Salary</th>
            <th colspan='6'>Working Days</th><th colspan='3'>Leave</th><th rowspan='2'>Payable Days</th>
            <th colspan='4'>Deductions</th><th rowspan='2'>Payable Salary</th>
            <th rowspan='2'>Att. Bonus</th><th rowspan='2'>Stamp</th><th rowspan='2'>Net Pay</th>
            <th rowspan='2'>Signature</th><th rowspan='2'>Photo</th>
        </tr>
        <tr>
            <th>Basic</th><th>House Rent</th><th>Transport</th><th>Medical</th>
            <th>W.D</th><th>Weekend</th><th>Holiday</th><th>Present</th><th>Absent</th><th>Late</th>
            <th>CL</th><th>SL</th><th>EL</th><th>Absent</th><th>Late</th><th>Advance</th><th>Others</th>
        </tr>
        </thead>
        <tbody>");
                rowCount = 0;
            }

            void PrintSignatureFooter()
            {
                html.Append(@"
        </tbody>
        </table>
        <div style='margin-top: 50px;'>
            <div class='signature-footer'>
              
                    <p style='text-align: center; border-top: 1px solid #000;'>
                        Prepared By
                    </p>
                    <p style='text-align: center;  border-top: 1px solid #000;'>
                        Checked By
                    </p>
                    <p style='text-align: center; border-top: 1px solid #000;'>
                        Authorized By
                    </p>
             
            </div>
        </div>");
            }

            void PrintDepartmentFooter()
            {
                decimal netPayable = deptNet + deptBonus - deptStamp;

                html.Append($@"
        <tr style='background-color: #f0f0f0;'>
            <td colspan='11'><strong>Manpower: {deptManpower}</strong></td>
            <td><strong>{deptGross:N0}</strong></td>
            <td colspan='8'></td>
            <td><strong>{deptAbsent:N0}</strong></td>
            <td><strong>{deptLate:N0}</strong></td>
            <td><strong>{deptAdvance:N0}</strong></td>
            <td><strong>{deptOthers:N0}</strong></td>
            <td><strong>{deptNet:N0}</strong></td>
            <td><strong>{deptBonus:N0}</strong></td>
            <td><strong>{deptStamp:N0}</strong></td>
            <td><strong>{netPayable:N0}</strong></td>
            <td></td><td></td>
        </tr>");
            }

            void ResetDepartmentTotals()
            {
                deptManpower = 0;
                deptGross = 0;
                deptAbsent = 0;
                deptLate = 0;
                deptAdvance = 0;
                deptOthers = 0;
                deptNet = 0;
                deptBonus = 0;
                deptStamp = 0;
            }

            void EndPageAndAddToControl()
            {
                PrintSignatureFooter();
                html.Append("<div class='page-break'></div>");
                allPages.Append(html.ToString());
            }

            void FinalizeAllPages()
            {
                phSalaryReport.Controls.Add(new Literal { Text = allPages.ToString() });
            }

            // Helper method to check if department is ending
            bool IsDepartmentEnding(int currentIndex)
            {
                if (currentIndex >= totalRecords - 1) return true;

                string currentDeptId = dt.Rows[currentIndex]["DptId"].ToString();
                string nextDeptId = dt.Rows[currentIndex + 1]["DptId"].ToString();

                return currentDeptId != nextDeptId;
            }

            StartPage();

            for (int i = 0; i < totalRecords; i++)
            {
                var row = dt.Rows[i];
                string currentDeptId = row["DptId"].ToString();
                deptName = row["DptName"].ToString();

                bool isNewDept = currentDeptId != previousDeptId;
                bool isLastRecord = i == totalRecords - 1;
                bool isDeptEnding = IsDepartmentEnding(i);

                // Previous department ended, print its footer
                if (isNewDept && deptManpower > 0)
                {
                    PrintDepartmentFooter();
                    rowCount++;

                    // Reset totals for new department
                    ResetDepartmentTotals();
                }

                // New department started
                if (isNewDept)
                {
                    // Check if we can fit department header + at least 1 row
                    // Don't check for department footer here - let it handle naturally
                    if (rowCount + 2 > approxRowsPerPage && rowCount > 0) // header + 1 row minimum
                    {
                        EndPageAndAddToControl();
                        StartPage();
                    }

                    html.Append($@"<tr><td colspan='31' style='text-align:left; font-weight:bold; background-color: #e0e0e0;'>Department: {deptName}</td></tr>");
                    rowCount++;
                    previousDeptId = currentDeptId;
                }

                // Check if we can fit current row
                if (rowCount + 1 > approxRowsPerPage)
                {
                    EndPageAndAddToControl();
                    StartPage();

                    // If we're continuing a department on new page, add department header
                    html.Append($@"<tr><td colspan='31' style='text-align:left; font-weight:bold; background-color: #e0e0e0;'>Department: {deptName} (Continued)</td></tr>");
                    rowCount++;
                }

                // Add employee row
                decimal gross = Convert.ToDecimal(row["EmpPresentSalary"] ?? 0);
                decimal ab = Convert.ToDecimal(row["AbsentDeduction"] ?? 0);
                decimal lt = Convert.ToDecimal(row["LateFine"] ?? 0);
                decimal adv = Convert.ToDecimal(row["AdvanceDeduction"] ?? 0);
                decimal oth = Convert.ToDecimal(row["OthersDeduction"] ?? 0);
                decimal net = Convert.ToDecimal(row["NetPayable"] ?? 0);
                decimal bon = Convert.ToDecimal(row["AttendanceBonus"] ?? 2);
                decimal stm = Convert.ToDecimal(row["Stampdeduct"] ?? 0);

                string cl = row.Table.Columns.Contains("CL") ? row["CL"].ToString() : "0";
                string sl = row.Table.Columns.Contains("SL") ? row["SL"].ToString() : "0";
                string el = row.Table.Columns.Contains("EL") ? row["EL"].ToString() : "0";

                html.Append($@"
        <tr>
            <td>{slCounter++}</td>
            <td>{row["EmpId"]}<br>({row["EmpCardNo"]})</td>
            <td>{row["EmpName"]}</td>
            <td>{row["DptName"]}</td>
            <td>{row["DsgName"]}</td>
            <td>{row["EmpJoiningDate"]}</td>
            <td>{row["GrdName"]}</td>
            <td>{row["BasicSalary"]}</td>
            <td>{row["HouseRent"]}</td>
            <td></td>
            <td>{row["MedicalAllownce"]}</td>
            <td>{gross:N0}</td>
            <td>{row["DaysInMonth"]}</td>
            <td>{row["WeekendHoliday"]}</td>
            <td>{row["FestivalHoliday"]}</td>
            <td>{row["PresentDay"]}</td>
            <td>{row["AbsentDay"]}</td>
            <td>{row["LateDays"]}</td>
            <td>{cl}</td><td>{sl}</td><td>{el}</td>
            <td>{row["PayableDays"]}</td>
            <td>{ab:N0}</td><td>{lt:N0}</td><td>{adv:N0}</td><td>{oth:N0}</td>
            <td>{net:N0}</td><td>{bon:N0}</td><td>{stm:N0}</td><td>{(net + bon - stm):N0}</td>
            <td></td><td></td>
        </tr>");

                // Update department totals
                deptManpower++;
                deptGross += gross;
                deptAbsent += ab;
                deptLate += lt;
                deptAdvance += adv;
                deptOthers += oth;
                deptNet += net;
                deptBonus += bon;
                deptStamp += stm;

                rowCount++;

                // If this is the last record or department is ending, handle department footer
                if (isLastRecord || isDeptEnding)
                {
                    // Check if we have space for department footer
                    if (rowCount + 1 > approxRowsPerPage)
                    {
                        EndPageAndAddToControl();
                        StartPage();

                        // Add department header on new page for context
                        html.Append($@"<tr><td colspan='31' style='text-align:left; font-weight:bold; background-color: #e0e0e0;'>Department: {deptName} (Summary)</td></tr>");
                        rowCount++;
                    }

                    PrintDepartmentFooter();
                    rowCount++;

                    if (isLastRecord)
                    {
                        PrintSignatureFooter();
                        allPages.Append(html.ToString());
                        FinalizeAllPages();
                    }
                    else
                    {
                        ResetDepartmentTotals();
                    }
                }
            }
        }















    }


}
