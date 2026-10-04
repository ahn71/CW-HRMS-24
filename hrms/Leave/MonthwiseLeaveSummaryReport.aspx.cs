using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SigmaERP.classes;
using OfficeOpenXml;
using OfficeOpenXml.Style;

namespace SigmaERP.hrms.Leave
{
    public partial class MonthwiseLeaveSummaryReport : System.Web.UI.Page
    {
        // EmpStatus stays static/non-UI, matching the original query's intent.
        private const string EmpStatusFilter = "1, 8";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["view"] == "1")
            {
                pnlFilter.Visible = false;
                RunReport();
                return;
            }

            if (!IsPostBack)
            {
                InitFilterForm();
            }
        }

        private void InitFilterForm()
        {
            try
            {
                HttpCookie cookies = Request.Cookies["userInfo"];
                string companyId = cookies != null && cookies["__CompanyId__"] != null ? cookies["__CompanyId__"] : "0001";
                ViewState["__CompanyId__"] = companyId;

                commonTask.LoadEmpTypeWithAll(rblEmpType);
                commonTask.LoadBranch(ddlCompanyName, companyId);
                if (!commonTask.HasBranch()) ddlCompanyName.Enabled = false;
                ddlCompanyName.SelectedValue = "0000";

                commonTask.LoadDepartment(companyId, lstAll);
                LoadYears(companyId);
                LoadMonths();
            }
            catch { }
        }

        private void LoadYears(string companyId)
        {
            ddlYear.Items.Clear();
            var years = new List<int>();
            DataTable dt = CRUD.ExecuteReturnDataTable("SELECT DISTINCT YEAR(LeaveStartDate) AS Yr FROM Leave_LeaveApplications WHERE CompanyId='" + companyId.Replace("'", "''") + "'");
            if (dt != null)
                foreach (DataRow row in dt.Rows) years.Add(Convert.ToInt32(row["Yr"]));
            if (!years.Contains(DateTime.Today.Year)) years.Add(DateTime.Today.Year);
            years.Sort();
            years.Reverse();
            foreach (int y in years) ddlYear.Items.Add(new ListItem(y.ToString(CultureInfo.InvariantCulture), y.ToString(CultureInfo.InvariantCulture)));
            ddlYear.SelectedValue = DateTime.Today.Year.ToString(CultureInfo.InvariantCulture);
        }

        private void LoadMonths()
        {
            ddlMonth.Items.Clear();
            for (int m = 1; m <= 12; m++)
                ddlMonth.Items.Add(new ListItem(new DateTime(2000, m, 1).ToString("MMMM", CultureInfo.InvariantCulture), m.ToString(CultureInfo.InvariantCulture)));
            ddlMonth.SelectedValue = DateTime.Today.Month.ToString(CultureInfo.InvariantCulture);
        }

        protected void ddlCompanyName_SelectedIndexChanged(object sender, EventArgs e)
        {
            string companyId = ddlCompanyName.SelectedValue == "0000" ? ViewState["__CompanyId__"].ToString() : ddlCompanyName.SelectedValue;
            lstAll.Items.Clear();
            lstSelected.Items.Clear();
            commonTask.LoadDepartment(companyId, lstAll);
            LoadYears(companyId);
        }

        protected void btnAddItem_Click(object sender, EventArgs e) { commonTask.AddRemoveItem(lstAll, lstSelected); }
        protected void btnAddAllItem_Click(object sender, EventArgs e) { commonTask.AddRemoveAll(lstAll, lstSelected); }
        protected void btnRemoveItem_Click(object sender, EventArgs e) { commonTask.AddRemoveItem(lstSelected, lstAll); }
        protected void btnRemoveAllItem_Click(object sender, EventArgs e) { commonTask.AddRemoveAll(lstSelected, lstAll); }

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            string cardNo = txtCardNo.Text.Trim();

            if (cardNo.Length == 0 && lstSelected.Items.Count == 0)
            {
                lblMessage.Text = "Please select at least one Department, or enter a Card No for an individual employee.";
                return;
            }

            string companyId = ddlCompanyName.SelectedValue == "0000" ? ViewState["__CompanyId__"].ToString() : ddlCompanyName.SelectedValue;

            var url = new StringBuilder();
            url.Append(Request.Url.AbsolutePath).Append("?view=1");
            url.Append("&year=").Append(HttpUtility.UrlEncode(ddlYear.SelectedValue));
            url.Append("&month=").Append(HttpUtility.UrlEncode(ddlMonth.SelectedValue));
            url.Append("&companyId=").Append(HttpUtility.UrlEncode(companyId));
            if (rblEmpType.SelectedValue != "All") url.Append("&empType=").Append(HttpUtility.UrlEncode(rblEmpType.SelectedValue));

            if (cardNo.Length > 0)
            {
                url.Append("&cardNo=").Append(HttpUtility.UrlEncode(cardNo));
            }
            else
            {
                string deptIds = string.Join(",", lstSelected.Items.Cast<ListItem>().Select(i => i.Value));
                url.Append("&deptIds=").Append(HttpUtility.UrlEncode(deptIds));
            }

            string script = "goToNewTabandWindow('" + url.ToString().Replace("'", "\\'") + "');";
            ScriptManager.RegisterStartupScript(this, GetType(), "openReport", script, true);
        }

        private void RunReport()
        {
            int year;
            int month;
            if (!int.TryParse(Request.QueryString["year"], out year) || year < 2000 || year > 2100)
                year = DateTime.Today.Year;
            if (!int.TryParse(Request.QueryString["month"], out month) || month < 1 || month > 12)
                month = DateTime.Today.Month;

            string companyId = Request.QueryString["companyId"];
            if (string.IsNullOrWhiteSpace(companyId)) companyId = "0001";

            string[] deptIds = (Request.QueryString["deptIds"] ?? "").Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            int empTypeId;
            string empTypeClause = int.TryParse(Request.QueryString["empType"], out empTypeId) ? " AND EmpTypeID = " + empTypeId : "";

            string cardNo = Request.QueryString["cardNo"];
            string cardEmpId = null;
            if (!string.IsNullOrWhiteSpace(cardNo))
            {
                cardEmpId = Employee.getEmpIdByCardNo(companyId, cardNo);
                if (string.IsNullOrEmpty(cardEmpId))
                {
                    reportContent.Text = "<div class='empty-report'>No employee found for Card No '" + E(cardNo) + "'.</div>";
                    return;
                }
            }

            DateTime fromDate = new DateTime(year, 1, 1);
            DateTime toDate = new DateTime(year, month, DateTime.DaysInMonth(year, month));

            DataTable data = CRUD.ExecuteReturnDataTable(BuildQuery(year, fromDate, toDate, companyId, deptIds, empTypeClause, cardEmpId));

            if (data == null || data.Rows.Count == 0)
            {
                reportContent.Text = "<div class='empty-report'>No leave data was found for the selected filters.</div>";
                return;
            }

            ApplyLieuLeave(data);
            if (string.Equals(Request.QueryString["export"], "excel", StringComparison.OrdinalIgnoreCase))
            {
                ExportExcel(data, year, month, fromDate, toDate);
                return;
            }
            RenderReport(data, year, month, fromDate, toDate);
        }

        // Lieu leave: 1 day earned for every 6 days since joining (as of today).
        // Returns true when the employee still has lieu leave left to take.
        private static bool VerifyLieuLeave(DateTime? joiningDate, double spentDays, out int earnedDays, out double balanceDays)
        {
            DateTime today = DateTime.Today;
            DateTime joining = (joiningDate ?? today).Date;

            int totalWorkingDays = Math.Max(0, (int)(today - joining).TotalDays);
            earnedDays = totalWorkingDays / 6;
            balanceDays = Math.Max(0, earnedDays - spentDays);
            return balanceDays > 0;
        }

        private static void ApplyLieuLeave(DataTable data)
        {
            var lieu = GetLeaveTypeColumns(data).FirstOrDefault(lt => lt.ShortName.Replace(" ", "").Equals("l/l", StringComparison.OrdinalIgnoreCase));
            if (lieu == null || !data.Columns.Contains(lieu.Remaining)) return;

            DataColumn assignedCol = data.Columns[lieu.Assigned];
            DataColumn remainingCol = data.Columns[lieu.Remaining];
            assignedCol.ReadOnly = false;
            remainingCol.ReadOnly = false;

            foreach (DataRow row in data.Rows)
            {
                DateTime? joiningDate = row["JoiningDateRaw"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["JoiningDateRaw"]);
                double spentDays = row["LieuUsedDays"] == DBNull.Value ? 0 : Convert.ToDouble(row["LieuUsedDays"]);

                int earnedDays;
                double balanceDays;
                VerifyLieuLeave(joiningDate, spentDays, out earnedDays, out balanceDays);

                row[assignedCol] = Convert.ChangeType(earnedDays, assignedCol.DataType, CultureInfo.InvariantCulture);
                row[remainingCol] = Convert.ChangeType(balanceDays, remainingCol.DataType, CultureInfo.InvariantCulture);
            }
        }

        private static string ToSqlInList(IEnumerable<string> values)
        {
            var list = values.Where(v => !string.IsNullOrWhiteSpace(v)).Select(v => "''" + v.Trim().Replace("'", "''''") + "''").ToList();
            return list.Count > 0 ? string.Join(",", list) : "''''";
        }

        private static string ToSqlLiteral(string value)
        {
            return "''" + (value ?? "").Replace("'", "''''") + "''";
        }

        private static string BuildQuery(int year, DateTime fromDate, DateTime toDate, string companyId, string[] deptIds, string empTypeClause, string cardEmpId)
        {
            string from = fromDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            string to = toDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);

            string companyInList = ToSqlInList(new[] { companyId });
            string scopeClause = cardEmpId != null
                ? " AND EmpId = " + ToSqlLiteral(cardEmpId)
                : " AND DptId IN (" + ToSqlInList(deptIds) + ")";

            return @"DECLARE @Year INT = " + year + @"; DECLARE @FromDate DATE = '" + from + @"'; DECLARE @ToDate DATE = '" + to + @"'; DECLARE @LeaveColumns NVARCHAR(MAX); DECLARE @SQL NVARCHAR(MAX);
SELECT @LeaveColumns = STUFF((SELECT ',MAX(CASE WHEN ShortName = ''' + REPLACE(LC.ShortName, '''', '''''') + ''' THEN AssignedDays END) AS[' + REPLACE(LC.ShortName, ']', ']]') + '_Assigned], MAX(CASE WHEN ShortName = ''' + REPLACE(LC.ShortName, '''', '''''') + ''' THEN TakenDays END) AS[' + REPLACE(LC.ShortName, ']', ']]') + '_Taken], MAX(CASE WHEN ShortName = ''' + REPLACE(LC.ShortName, '''', '''''') + ''' THEN RemainingDays END) AS[' + REPLACE(LC.ShortName, ']', ']]') + '_Remaining]' FROM tblLeaveConfig LC WHERE NULLIF(LTRIM(RTRIM(LC.ShortName)), '') IS NOT NULL ORDER BY LC.LeaveId FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '');
SET @SQL = N'
WITH CLTable AS (SELECT * FROM (VALUES(''01 - 01'', ''01 - 31'', 10),(''02 - 01'', ''02 - 28'', 9),(''03 - 01'', ''03 - 31'', 8),(''04 - 01'',''05 - 15'',7),(''05 - 16'',''06 - 15'',6),(''06 - 16'',''07 - 15'',5),(''07 - 16'',''08 - 15'',4),(''08 - 16'',''10 - 15'',3),(''10 - 16'',''11 - 30'',2),(''12 - 01'',''12 - 31'',1)) AS x(StartDate, EndDate, Days)),
SLTable AS (SELECT* FROM (VALUES(''01 - 01'',''01 - 31'',14),(''02 - 01'',''02 - 15'',13),(''02 - 16'',''03 - 15'',12),(''03 - 16'',''03 - 31'',11),(''04 - 01'',''04 - 30'',10),(''05 - 01'',''05 - 31'',9),(''06 - 01'',''06 - 30'',8),(''07 - 01'',''07 - 31'',7),(''08 - 01'',''08 - 15'',6),(''08 - 16'',''09 - 15'',5),(''09 - 16'',''09 - 30'',4),(''10 - 01'',''10 - 31'',3),(''11 - 01'',''11 - 30'',2),(''12 - 01'',''12 - 31'',1)) AS x(StartDate, EndDate, Days)),
pEL AS (SELECT EmpID, ISNULL(SUM(ReserveEeanLeaveDays), 0) AS PreviousEL FROM Earnleave_Reserved WHERE ReserveFor >= DATEFROMPARTS(@Year - 1, 1, 1) AND ReserveFor<DATEFROMPARTS(@Year, 1, 1) GROUP BY EmpID),
bEL AS (SELECT EmpID, ISNULL(SUM(EarnLeaveDays), 0) AS EarnedEL FROM Earnleave_BalanceDetailsLog WHERE GenerateDate >= DATEFROMPARTS(@Year, 1, 1) AND GenerateDate<DATEFROMPARTS(@Year +1, 1, 1) GROUP BY EmpID),
ed AS (SELECT* FROM v_EmployeeDetails WHERE IsActive = 1 AND CompanyId IN (" + companyInList + @") AND EmpStatus IN(" + EmpStatusFilter + @")" + scopeClause + empTypeClause + @"),
LeaveTaken AS (SELECT LVA.EmpId, LVA.LeaveTypeId, SUM(ISNULL(LVA.TotalLeaveDays, 0)) AS TakenDays FROM Leave_LeaveApplications LVA WHERE LVA.IsDeleted = 0 AND LVA.ApprovalStatus = ''1'' AND LVA.LeaveStartDate >= @FromDate AND LVA.LeaveStartDate < DATEADD(DAY, 1, @ToDate) GROUP BY LVA.EmpId, LVA.LeaveTypeId),
LieuUsed AS (SELECT LVA.EmpId, SUM(ISNULL(LVA.TotalLeaveDays, 0)) AS UsedDays FROM Leave_LeaveApplications LVA INNER JOIN tblLeaveConfig LLC ON LLC.LeaveId = LVA.LeaveTypeId WHERE LVA.IsDeleted = 0 AND LVA.ApprovalStatus = ''1'' AND REPLACE(LOWER(LLC.ShortName), '' '', '''') = ''l/l'' GROUP BY LVA.EmpId),
LeaveCalculation AS (SELECT ed.EmpId, ed.EmpName, CONVERT(VARCHAR(10), ed.EmpJoiningDate, 105) AS JoiningDate, CAST(ed.EmpJoiningDate AS DATE) AS JoiningDateRaw, ISNULL(LU.UsedDays, 0) AS LieuUsedDays, ed.EmpCardNo, ed.EmpProximityNo, ed.Sex, ed.DptId, ed.DptName, ed.DsgId, ed.DsgName, ed.CompanyId, ed.CompanyName, ed.SftId, ed.Address, LC.LeaveId, LC.ShortName, LC.LeaveName,
    CASE WHEN LOWER(LC.ShortName) = ''c / l'' THEN CASE WHEN YEAR(ed.EmpJoiningDate) = @Year THEN ISNULL(clmap.Days, 0) ELSE ISNULL(LC.LeaveDays, 0) END
         WHEN LOWER(LC.ShortName) = ''s / l'' THEN CASE WHEN YEAR(ed.EmpJoiningDate) = @Year THEN ISNULL(slmap.Days, 0) ELSE ISNULL(LC.LeaveDays, 0) END
         WHEN LOWER(LC.ShortName) = ''el'' THEN ISNULL(pEL.PreviousEL, 0) + ISNULL(bEL.EarnedEL, 0)
         ELSE ISNULL(LC.LeaveDays, 0) END AS AssignedDays,
    ISNULL(LT.TakenDays, 0) AS TakenDays,
    CASE WHEN LOWER(LC.ShortName) = ''c / l'' THEN (CASE WHEN YEAR(ed.EmpJoiningDate) = @Year THEN ISNULL(clmap.Days, 0) ELSE ISNULL(LC.LeaveDays, 0) END - ISNULL(LT.TakenDays, 0))
         WHEN LOWER(LC.ShortName) = ''s / l'' THEN (CASE WHEN YEAR(ed.EmpJoiningDate) = @Year THEN ISNULL(slmap.Days, 0) ELSE ISNULL(LC.LeaveDays, 0) END - ISNULL(LT.TakenDays, 0))
         WHEN LOWER(LC.ShortName) = ''el'' THEN (ISNULL(pEL.PreviousEL, 0) + ISNULL(bEL.EarnedEL, 0) - ISNULL(LT.TakenDays, 0))
         ELSE (ISNULL(LC.LeaveDays, 0) - ISNULL(LT.TakenDays, 0)) END AS RemainingDays
    FROM ed
    LEFT JOIN CLTable clmap ON CONVERT(VARCHAR(5), ed.EmpJoiningDate, 110) BETWEEN clmap.StartDate AND clmap.EndDate
    LEFT JOIN SLTable slmap ON CONVERT(VARCHAR(5), ed.EmpJoiningDate, 110) BETWEEN slmap.StartDate AND slmap.EndDate
    CROSS JOIN tblLeaveConfig LC
    LEFT JOIN LeaveTaken LT ON LT.EmpId = ed.EmpId AND LT.LeaveTypeId = LC.LeaveId
    LEFT JOIN bEL ON bEL.EmpID = ed.EmpId
    LEFT JOIN pEL ON pEL.EmpID = ed.EmpId
    LEFT JOIN LieuUsed LU ON LU.EmpId = ed.EmpId)
SELECT EmpId, EmpName, JoiningDate, JoiningDateRaw, LieuUsedDays, EmpCardNo, EmpProximityNo, Sex, DptId, DptName, DsgId, DsgName, CompanyId, CompanyName, SftId, Address, ' + @LeaveColumns + ' FROM LeaveCalculation
GROUP BY EmpId, EmpName, JoiningDate, JoiningDateRaw, LieuUsedDays, EmpCardNo, EmpProximityNo, Sex, DptId, DptName, DsgId, DsgName, CompanyId, CompanyName, SftId, Address
ORDER BY CASE WHEN ISNUMERIC(DptId) = 1 THEN CONVERT(INT, DptId) ELSE 999999 END, EmpId;';
EXEC sp_executesql @SQL, N'@Year INT, @FromDate DATE, @ToDate DATE', @Year = @Year, @FromDate = @FromDate, @ToDate = @ToDate;";
        }

        private class LeaveTypeColumns
        {
            public string ShortName;
            public string Assigned;
            public string Taken;
            public string Remaining;
        }

        private static List<LeaveTypeColumns> GetLeaveTypeColumns(DataTable data)
        {
            var result = new List<LeaveTypeColumns>();
            foreach (DataColumn col in data.Columns)
            {
                if (!col.ColumnName.EndsWith("_Assigned", StringComparison.OrdinalIgnoreCase)) continue;
                string shortName = col.ColumnName.Substring(0, col.ColumnName.Length - "_Assigned".Length);
                result.Add(new LeaveTypeColumns
                {
                    ShortName = shortName,
                    Assigned = shortName + "_Assigned",
                    Taken = shortName + "_Taken",
                    Remaining = shortName + "_Remaining"
                });
            }
            return result;
        }

        private void RenderReport(DataTable data, int year, int month, DateTime fromDate, DateTime toDate)
        {
            var leaveTypes = GetLeaveTypeColumns(data);
            DataRow first = data.Rows[0];
            string company = Value(first, "CompanyName", "Company");
            string address = Value(first, "Address", "");
            string department = string.Join(", ", data.AsEnumerable().Select(r => Value(r, "DptName", "")).Where(s => s.Length > 0).Distinct());
            string monthLabel = new DateTime(year, month, 1).ToString("MMMM yyyy", CultureInfo.InvariantCulture);
            string periodLabel = fromDate.ToString("dd-MMM-yyyy", CultureInfo.InvariantCulture) + " to " + toDate.ToString("dd-MMM-yyyy", CultureInfo.InvariantCulture);
            string fileTag = "MonthwiseLeaveSummary-" + year + "-" + month.ToString("00", CultureInfo.InvariantCulture);

            var html = new StringBuilder();

            html.Append("<div class='report-toolbar'>");
            html.Append("<div class='toolbar-left'><h2>Monthwise Leave Summary Report</h2><span class='muted'>Generated on ").Append(DateTime.Now.ToString("dd-MMM-yyyy hh:mm tt", CultureInfo.InvariantCulture)).Append("</span></div>");
            string exportUrl = Request.Url.AbsolutePath + Request.Url.Query + "&export=excel";
            html.Append("<div class='toolbar-right'><a href='").Append(HttpUtility.HtmlAttributeEncode(exportUrl)).Append("' class='btn btn-excel'>Export Excel</a>");
            html.Append("<button type='button' id='btnExportPdf' class='btn btn-pdf'>Export PDF</button><button type='button' class='btn btn-print' onclick='window.print()'>Print</button></div>");
            html.Append("</div>");

            html.Append("<div class='sheet'>");
            html.Append("<header class='report-head'><div class='brand'>SAYEMAN<small>ESTD. 1964</small></div><div class='heading'><div class='company'>").Append(E(company)).Append("</div>");
            if (address.Length > 0) html.Append("<div class='address'>").Append(E(address)).Append("</div>");
            html.Append("<h1>Monthwise Leave Summary Report</h1><small>Month: ").Append(E(monthLabel)).Append("</small></div><div class='brand resort'>SAYEMAN<small>BEACH RESORT</small></div></header>");

            html.Append("<div class='meta'><div><b>Duration</b><strong>").Append(E(periodLabel))
                .Append("</strong></div><div><b>Month</b><strong>").Append(E(monthLabel))
                .Append("</strong></div><div><b>Department</b><strong>").Append(E(department.Length > 0 ? department : "All"))
                .Append("</strong></div><div><b>Employees</b><strong>").Append(data.Rows.Count).Append("</strong></div></div>");

            html.Append("<div class='table-wrap'><table id='leaveSummaryTable' class='leave-summary'><thead>");
            html.Append("<tr>");
            html.Append("<th rowspan='2'>SL</th><th rowspan='2'>ID</th><th rowspan='2' class='left'>Name</th><th rowspan='2'>Joining Date</th><th rowspan='2' class='left'>Designation</th><th rowspan='2' class='left'>Department</th>");
            html.Append("<th colspan='").Append(leaveTypes.Count).Append("' class='grp-total'>Entitle</th>");
            html.Append("<th colspan='").Append(leaveTypes.Count).Append("' class='grp-availed'>Availed</th>");
            html.Append("<th colspan='").Append(leaveTypes.Count).Append("' class='grp-balance'>Balance</th>");
            html.Append("</tr><tr>");
            foreach (var lt in leaveTypes) html.Append("<th class='grp-total lv'>").Append(E(LeaveHeader(lt.ShortName))).Append("</th>");
            foreach (var lt in leaveTypes) html.Append("<th class='grp-availed lv'>").Append(E(LeaveHeader(lt.ShortName))).Append("</th>");
            foreach (var lt in leaveTypes) html.Append("<th class='grp-balance lv'>").Append(E(LeaveHeader(lt.ShortName))).Append("</th>");
            html.Append("</tr></thead><tbody>");

            int index = 0;
            foreach (DataRow row in data.Rows)
            {
                string cardNo = Value(row, "EmpCardNo", "");
                string proximity = Value(row, "EmpProximityNo", "");
                string id = proximity.Length > 0 ? (cardNo + " (" + proximity + ")") : (cardNo.Length > 0 ? cardNo : Value(row, "EmpId", ""));

                html.Append("<tr class='data-row'><td>").Append(++index).Append("</td>");
                html.Append("<td>").Append(E(id)).Append("</td>");
                html.Append("<td class='left'>").Append(E(Value(row, "EmpName", ""))).Append("</td>");
                html.Append("<td>").Append(E(Value(row, "JoiningDate", ""))).Append("</td>");
                html.Append("<td class='left'>").Append(E(Value(row, "DsgName", ""))).Append("</td>");
                html.Append("<td class='left'>").Append(E(Value(row, "DptName", ""))).Append("</td>");
                foreach (var lt in leaveTypes) html.Append("<td>").Append(E(Value(row, lt.Assigned, "0"))).Append("</td>");
                foreach (var lt in leaveTypes) html.Append("<td>").Append(E(Value(row, lt.Taken, "0"))).Append("</td>");
                foreach (var lt in leaveTypes) html.Append("<td>").Append(E(Value(row, lt.Remaining, "0"))).Append("</td>");
                html.Append("</tr>");
            }

            html.Append("</tbody></table></div>");

            html.Append("<div class='pagination-bar'>");
            html.Append("<div class='page-size'>Rows per page: <select id='pageSizeSelect'><option value='25'>25</option><option value='50' selected>50</option><option value='100'>100</option><option value='0'>All</option></select></div>");
            html.Append("<div class='page-info' id='pageInfo'></div>");
            html.Append("<div class='page-nav' id='pageNav'></div>");
            html.Append("</div>");

            // signatures once, after the last row (last page)
            html.Append("<footer class='signatures'><span>HOD</span><span>Human Resources Manager</span><span>Revenue and Credit Manager</span><span>Financial Controller</span><span>Pubudu Fernando<br/>Cluster General Manager</span></footer>");
            html.Append("</div>");

            html.Append("<script>(function(){\n" +
                "var table=document.getElementById('leaveSummaryTable');\n" +
                "if(!table)return;\n" +
                "var rows=Array.prototype.slice.call(table.querySelectorAll('tbody tr.data-row'));\n" +
                "var pageSize=50,currentPage=1;\n" +
                "function totalPages(){return pageSize===0?1:Math.max(1,Math.ceil(rows.length/pageSize));}\n" +
                "function render(){\n" +
                "  var pages=totalPages();\n" +
                "  if(currentPage>pages)currentPage=pages;\n" +
                "  var start=pageSize===0?0:(currentPage-1)*pageSize;\n" +
                "  var end=pageSize===0?rows.length:start+pageSize;\n" +
                "  rows.forEach(function(row,i){row.style.display=(i>=start&&i<end)?'':'none';});\n" +
                "  document.getElementById('pageInfo').textContent=rows.length===0?'No records':('Showing '+(start+1)+'\\u2013'+Math.min(end,rows.length)+' of '+rows.length+' employees');\n" +
                "  renderNav(pages);\n" +
                "}\n" +
                "function renderNav(pages){\n" +
                "  var nav=document.getElementById('pageNav');\n" +
                "  nav.innerHTML='';\n" +
                "  if(pages<=1)return;\n" +
                "  function addBtn(label,page,disabled,active){\n" +
                "    var b=document.createElement('button');\n" +
                "    b.type='button';b.textContent=label;b.className='page-btn'+(active?' active':'');\n" +
                "    if(disabled)b.disabled=true;\n" +
                "    b.addEventListener('click',function(){currentPage=page;render();});\n" +
                "    nav.appendChild(b);\n" +
                "  }\n" +
                "  addBtn('\\u00ab Prev',currentPage-1,currentPage===1,false);\n" +
                "  var startP=Math.max(1,currentPage-2),endP=Math.min(pages,startP+4);\n" +
                "  startP=Math.max(1,endP-4);\n" +
                "  for(var p=startP;p<=endP;p++)addBtn(String(p),p,false,p===currentPage);\n" +
                "  addBtn('Next \\u00bb',currentPage+1,currentPage===pages,false);\n" +
                "}\n" +
                "var sizeSelect=document.getElementById('pageSizeSelect');\n" +
                "sizeSelect.addEventListener('change',function(){pageSize=parseInt(sizeSelect.value,10)||0;currentPage=1;render();});\n" +
                "render();\n" +
                "var btnPdf=document.getElementById('btnExportPdf');\n" +
                "if(btnPdf)btnPdf.addEventListener('click',function(){\n" +
                "  if(typeof window.jspdf==='undefined'){alert('PDF export library failed to load.');return;}\n" +
                "  var doc=new window.jspdf.jsPDF({orientation:'landscape',unit:'pt',format:'a3'});\n" +
                "  var W=doc.internal.pageSize.getWidth(),H=doc.internal.pageSize.getHeight(),M=40;\n" +
                "  function brand(x,sub){doc.setTextColor(150,132,67);doc.setFont('times','normal');doc.setFontSize(22);doc.text('SAYEMAN',x,48,{align:'center'});doc.setFont('times','bold');doc.setFontSize(9);doc.text(sub,x,61,{align:'center'});}\n" +
                "  function header(){\n" +
                "    brand(M+80,'ESTD. 1964');brand(W-M-80,'BEACH RESORT');\n" +
                "    doc.setTextColor(17,24,39);doc.setFont('helvetica','bold');doc.setFontSize(14);doc.text(" + JsString(company) + ",W/2,34,{align:'center'});\n" +
                "    doc.setFont('helvetica','normal');doc.setFontSize(9);doc.setTextColor(88,101,121);doc.text(" + JsString(address) + ",W/2,47,{align:'center'});\n" +
                "    doc.setFont('helvetica','bold');doc.setFontSize(14);doc.setTextColor(17,24,39);doc.text('MONTHWISE LEAVE SUMMARY REPORT',W/2,66,{align:'center'});\n" +
                "    doc.setFont('helvetica','normal');doc.setFontSize(10);doc.text(" + JsString("Month: " + monthLabel + "   |   Period: " + periodLabel + "   |   Employees: " + data.Rows.Count) + ",W/2,82,{align:'center'});\n" +
                "    doc.setDrawColor(31,41,55);doc.setLineWidth(1.2);doc.line(M,92,W-M,92);\n" +
                "  }\n" +
                "  function signatures(){\n" +
                "    var labels=['HOD','Human Resources Manager','Revenue and Credit Manager','Financial Controller',['Pubudu Fernando','Cluster General Manager']],y=H-40,n=labels.length;\n" +
                "    doc.setFont('helvetica','normal');doc.setFontSize(10);doc.setTextColor(17,24,39);doc.setDrawColor(31,41,55);doc.setLineWidth(0.8);\n" +
                "    labels.forEach(function(t,i){var x=M+(W-2*M)*(2*i+1)/(2*n);doc.line(x-75,y-13,x+75,y-13);doc.text(t,x,y,{align:'center'});});\n" +
                "  }\n" +
                "  doc.autoTable({html:'#leaveSummaryTable',includeHiddenHtml:true,margin:{top:104,bottom:40,left:M,right:M},styles:{fontSize:6,cellPadding:2},headStyles:{fillColor:[37,62,97]},didParseCell:function(d){if(d.column.index>=6){d.cell.styles.minCellWidth=26;d.cell.styles.overflow='visible';}},didDrawPage:function(){header();}});\n" +
                "  // signatures only at the bottom of the last page; start a new page if the table left no room\n" +
                "  doc.setPage(doc.internal.getNumberOfPages());\n" +
                "  if(doc.lastAutoTable.finalY>H-80){doc.addPage();header();}\n" +
                "  signatures();\n" +
                "  doc.save('" + fileTag + ".pdf');\n" +
                "});\n" +
                "})();</script>");

            reportContent.Text = html.ToString();
        }

        private void ExportExcel(DataTable data, int year, int month, DateTime fromDate, DateTime toDate)
        {
            var leaveTypes = GetLeaveTypeColumns(data);
            DataRow first = data.Rows[0];
            string department = string.Join(", ", data.AsEnumerable().Select(r => Value(r, "DptName", "")).Where(s => s.Length > 0).Distinct());
            string monthLabel = new DateTime(year, month, 1).ToString("MMMM yyyy", CultureInfo.InvariantCulture);
            string periodLabel = fromDate.ToString("dd-MMM-yyyy", CultureInfo.InvariantCulture) + " to " + toDate.ToString("dd-MMM-yyyy", CultureInfo.InvariantCulture);
            string meta = "Duration: " + periodLabel + "      Month: " + monthLabel + "      Department: " + (department.Length > 0 ? department : "All") + "      Employees: " + data.Rows.Count;

            var fixedHeaders = new[] { "SL", "ID", "Name", "Joining Date", "Designation", "Department" };
            int n = leaveTypes.Count;
            int cols = fixedHeaders.Length + n * 3;

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (var package = new ExcelPackage())
            {
                var ws = package.Workbook.Worksheets.Add("Leave Summary");
                int row = ReportExcelHeader.Write(ws, cols, Value(first, "CompanyName", "Company"), Value(first, "Address", ""), "Monthwise Leave Summary Report", "Month: " + monthLabel, meta) + 1;

                // Two header rows, same as the preview: fixed columns span both, leave groups on top, leave names below
                int headerRow = row;
                for (int c = 0; c < fixedHeaders.Length; c++)
                {
                    ws.Cells[headerRow, c + 1, headerRow + 1, c + 1].Merge = true;
                    ws.Cells[headerRow, c + 1].Value = fixedHeaders[c];
                }
                string[] groups = { "Entitle", "Availed", "Balance" };
                for (int g = 0; g < groups.Length && n > 0; g++)
                {
                    int from = fixedHeaders.Length + g * n + 1;
                    ws.Cells[headerRow, from, headerRow, from + n - 1].Merge = true;
                    ws.Cells[headerRow, from].Value = groups[g];
                    for (int i = 0; i < n; i++) ws.Cells[headerRow + 1, from + i].Value = LeaveHeader(leaveTypes[i].ShortName);
                }
                ReportExcelHeader.StyleTableHeader(ws.Cells[headerRow, 1, headerRow + 1, cols]);
                row = headerRow + 1;

                int index = 0;
                foreach (DataRow dataRow in data.Rows)
                {
                    row++;
                    string cardNo = Value(dataRow, "EmpCardNo", "");
                    string proximity = Value(dataRow, "EmpProximityNo", "");
                    ws.Cells[row, 1].Value = ++index;
                    ws.Cells[row, 2].Value = proximity.Length > 0 ? (cardNo + " (" + proximity + ")") : (cardNo.Length > 0 ? cardNo : Value(dataRow, "EmpId", ""));
                    ws.Cells[row, 3].Value = Value(dataRow, "EmpName", "");
                    ws.Cells[row, 4].Value = Value(dataRow, "JoiningDate", "");
                    ws.Cells[row, 5].Value = Value(dataRow, "DsgName", "");
                    ws.Cells[row, 6].Value = Value(dataRow, "DptName", "");
                    for (int i = 0; i < n; i++)
                    {
                        ws.Cells[row, 7 + i].Value = Number(Value(dataRow, leaveTypes[i].Assigned, "0"));
                        ws.Cells[row, 7 + n + i].Value = Number(Value(dataRow, leaveTypes[i].Taken, "0"));
                        ws.Cells[row, 7 + 2 * n + i].Value = Number(Value(dataRow, leaveTypes[i].Remaining, "0"));
                    }
                }

                ReportExcelHeader.Borders(ws.Cells[headerRow, 1, row, cols]);
                ws.Cells[headerRow + 2, 1, row, cols].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                ws.Cells[headerRow + 2, 3, row, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                ws.Cells[headerRow + 2, 5, row, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                ws.View.FreezePanes(headerRow + 2, 4);

                double[] widths = { 5, 16, 26, 12, 20, 20 };
                for (int c = 0; c < widths.Length; c++) ws.Column(c + 1).Width = widths[c];
                for (int c = fixedHeaders.Length + 1; c <= cols; c++) ws.Column(c).Width = 7;

                ReportExcelHeader.WriteSignatures(ws, row + 4, cols, "HOD", "Human Resources Manager", "Revenue and Credit Manager", "Financial Controller", "Pubudu Fernando\nCluster General Manager");

                ws.PrinterSettings.Orientation = eOrientation.Landscape;
                ws.PrinterSettings.FitToPage = true;
                ws.PrinterSettings.FitToWidth = 1;
                ws.PrinterSettings.FitToHeight = 0;

                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("Content-Disposition", "attachment; filename=MonthwiseLeaveSummary-" + year + "-" + month.ToString("00", CultureInfo.InvariantCulture) + ".xlsx");
                Response.BinaryWrite(package.GetAsByteArray());
                Response.End();
            }
        }

        // Numeric values go to Excel as numbers so they can be summed
        private static object Number(string value)
        {
            decimal number;
            return decimal.TryParse(value, NumberStyles.Number, CultureInfo.InvariantCulture, out number) ? (object)number : value;
        }

        // "C / L" -> "CL", "AN/L" -> "AL", "l/l" -> "LL", "LWP" -> "LWP"
        private static string LeaveHeader(string shortName)
        {
            string compact = new string((shortName ?? "").Where(c => !char.IsWhiteSpace(c)).ToArray()).ToUpperInvariant();
            // leave without pay ("LWP", "LWPL", "LWP/L", "WP/L" ...) is always shown as "LWP"
            if (compact.Replace("/", "").StartsWith("LWP") || compact.Replace("/", "") == "WPL") return "LWP";
            if (compact.IndexOf('/') < 0) return compact;
            var parts = compact.Split(new[] { '/' }, StringSplitOptions.RemoveEmptyEntries);
            string header = parts.Length == 0 ? compact : string.Concat(parts.Take(parts.Length - 1).Select(p => p.Substring(0, 1))) + parts[parts.Length - 1];
            return header == "WL" ? "LWP" : header;
        }

        private static string JsString(string value)
        {
            return "'" + (value ?? "").Replace("\\", "\\\\").Replace("'", "\\'") + "'";
        }

        private static string Value(DataRow row, string column, string fallback)
        {
            return row.Table.Columns.Contains(column) && row[column] != DBNull.Value ? Convert.ToString(row[column]) : fallback;
        }

        private static string E(string value) { return HttpUtility.HtmlEncode(value ?? ""); }
    }
}
