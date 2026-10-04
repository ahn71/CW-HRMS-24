using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Text.RegularExpressions;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using OfficeOpenXml;
using OfficeOpenXml.Style;

namespace SigmaERP.hrms.attendance
{
    public partial class MonthlyAttendanceReportV1 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!AccessControl.hasPermission(new[] { 267 }).Any())
            {
                Response.Redirect(Routing.defualtUrl);
                return;
            }
            // Data is prepared by attendance/monthly_in_out_report.aspx (AttendnaceSummaryReport_V1)
            DataTable data = Session["__MonthlyAttendanceV1__"] as DataTable;
            if (data == null || data.Rows.Count == 0 || !(Session["__MonthlyAttendanceV1Month__"] is DateTime))
            {
                reportContent.Text = "<div class='empty-report'>No attendance or leave data was found for the selected filters.<br/>Please generate the report again from the Monthly Attendance Report page.</div>";
                return;
            }
            DateTime month = (DateTime)Session["__MonthlyAttendanceV1Month__"];
            if (string.Equals(Request.QueryString["export"], "excel", StringComparison.OrdinalIgnoreCase))
            {
                ExportExcel(data, month);
                return;
            }
            RenderReport(data, month);
        }

        private static readonly string[] SignatureLabels = { "HOD", "Human Resources Manager", "Revenue and Credit Manager", "Financial Controller", "Pubudu Fernando\nCluster General Manager" };

        private void ExportExcel(DataTable data, DateTime month)
        {
            int days = DateTime.DaysInMonth(month.Year, month.Month);
            DateTime lastDay = month.AddDays(days - 1);
            var summary = GetSummaryColumns(data);
            DataRow first = data.Rows[0];

            var headers = new List<string> { "SL", "Employee ID", "Employee Name", "Department", "Designation" };
            for (int day = 1; day <= days; day++) headers.Add(new DateTime(month.Year, month.Month, day).ToString("dd\nddd", CultureInfo.InvariantCulture));
            headers.Add("Payable Days");
            foreach (string column in summary) headers.Add(SummaryTitle(column));
            headers.Add("Remarks");
            int cols = headers.Count;
            int payableCol = 5 + days + 1;

            string meta = "Duration: " + month.ToString("d-MMM-yyyy", CultureInfo.InvariantCulture) + " to " + lastDay.ToString("d-MMM-yyyy", CultureInfo.InvariantCulture)
                + "      Month: " + month.ToString("MMMM yyyy", CultureInfo.InvariantCulture) + "      Total Days: " + days + "      Employees: " + data.Rows.Count;

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (var package = new ExcelPackage())
            {
                var ws = package.Workbook.Worksheets.Add("Attendance");
                int row = ReportExcelHeader.Write(ws, cols, Value(first, "CompanyName", "Company"), Value(first, "Address", ""), "Monthly Attendance Sheet", "Human Resources Division", meta);

                // Legend, same as the preview
                var legend = new List<string> { "P = Present", "L = Late", "A = Absent", "W = Weekend", "PH = Public Holiday" };
                DataTable leaves = Session["__MonthlyAttendanceV1Leaves__"] as DataTable;
                if (leaves != null)
                    foreach (DataRow lv in leaves.Rows) legend.Add(LeaveLabel(Value(lv, "ShortName", "")) + " = " + Value(lv, "LeaveName", ""));
                var legendCell = ws.Cells[row, 1, row, cols];
                legendCell.Merge = true;
                legendCell.Value = string.Join("     ", legend);
                legendCell.Style.Font.Size = 9;
                legendCell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                row += 2;

                int headerRow = row;
                for (int c = 0; c < cols; c++) ws.Cells[headerRow, c + 1].Value = headers[c];
                ReportExcelHeader.StyleTableHeader(ws.Cells[headerRow, 1, headerRow, cols]);
                ws.Row(headerRow).Height = 30;

                int serial = 0;
                foreach (DataRow dataRow in data.Rows)
                {
                    row++;
                    ws.Cells[row, 1].Value = ++serial;
                    ws.Cells[row, 2].Value = Value(dataRow, "EmpCardNo", Value(dataRow, "EmpId", ""));
                    ws.Cells[row, 3].Value = Value(dataRow, "EmpName", "");
                    ws.Cells[row, 4].Value = Value(dataRow, "DptName", "");
                    ws.Cells[row, 5].Value = Value(dataRow, "DsgName", "");
                    for (int d = 1; d <= days; d++) ws.Cells[row, 5 + d].Value = DayStatus(dataRow, d);
                    ws.Cells[row, payableCol].Value = Number(Value(dataRow, "TotalPayAbleDays", "0"));
                    for (int s = 0; s < summary.Count; s++) ws.Cells[row, payableCol + 1 + s].Value = Number(Value(dataRow, summary[s], "0"));
                }

                var table = ws.Cells[headerRow, 1, row, cols];
                ReportExcelHeader.Borders(table);
                ws.Cells[headerRow + 1, 1, row, cols].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                ws.Cells[headerRow + 1, 3, row, 5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                ws.View.FreezePanes(headerRow + 1, 4);

                ws.Column(1).Width = 5;
                ws.Column(2).Width = 12;
                ws.Column(3).Width = 26;
                ws.Column(4).Width = 18;
                ws.Column(5).Width = 18;
                for (int d = 1; d <= days; d++) ws.Column(5 + d).Width = 5;
                ws.Column(payableCol).Width = 9;
                for (int s = 0; s < summary.Count; s++) ws.Column(payableCol + 1 + s).Width = 7;
                ws.Column(cols).Width = 14;

                ReportExcelHeader.WriteSignatures(ws, row + 4, cols, SignatureLabels);

                ws.PrinterSettings.Orientation = eOrientation.Landscape;
                ws.PrinterSettings.FitToPage = true;
                ws.PrinterSettings.FitToWidth = 1;
                ws.PrinterSettings.FitToHeight = 0;

                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("Content-Disposition", "attachment; filename=MonthlyAttendance-" + month.ToString("yyyy-MM", CultureInfo.InvariantCulture) + ".xlsx");
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

        private void RenderReport(DataTable data, DateTime month)
        {
            int days = DateTime.DaysInMonth(month.Year, month.Month);
            DateTime lastDay = month.AddDays(days - 1);
            var summary = GetSummaryColumns(data);
            DataRow first = data.Rows[0];
            string company = Value(first, "CompanyName", "Company");
            string address = Value(first, "Address", "");
            var html = new StringBuilder();
            string exportUrl = Request.Url.AbsolutePath + (Request.Url.Query.Length > 0 ? Request.Url.Query + "&" : "?") + "export=excel";

            html.Append("<div class='report-tools'><a href='").Append(HttpUtility.HtmlAttributeEncode(exportUrl)).Append("'>Export to Excel</a><button type='button' onclick='window.print()'>Print report</button></div>");
            html.Append("<div class='sheet'>");
            html.Append("<header class='report-head'><div class='brand'>SAYEMAN<small>ESTD. 1964</small></div><div class='heading'><div class='company'>").Append(E(company)).Append("</div>");
            if (address.Length > 0) html.Append("<div class='address'>").Append(E(address)).Append("</div>");
            html.Append("<h1>Monthly Attendance Sheet</h1><small>Human Resources Division</small></div><div class='brand resort'>SAYEMAN<small>BEACH RESORT</small></div></header>");

            // Overall info, shown once in the top header
            html.Append("<div class='meta'><div><b>Duration</b><strong>")
                .Append(month.ToString("d-MMM-yyyy", CultureInfo.InvariantCulture)).Append(" &nbsp;to&nbsp; ").Append(lastDay.ToString("d-MMM-yyyy", CultureInfo.InvariantCulture))
                .Append("</strong></div><div><b>Month</b><strong>").Append(month.ToString("MMMM yyyy", CultureInfo.InvariantCulture))
                .Append("</strong></div><div><b>Total Days</b><strong>").Append(days).Append("</strong></div><div><b>Employees</b><strong>").Append(data.Rows.Count).Append("</strong></div></div>");

            html.Append("<div class='legend'><span><b class='present'>P</b> Present</span><span><b>L</b> Late</span><span><b class='absent'>A</b> Absent</span><span><b class='holiday'>W</b> Weekend</span><span><b class='holiday'>PH</b> Public Holiday</span>");
            DataTable leaves = Session["__MonthlyAttendanceV1Leaves__"] as DataTable;
            if (leaves != null)
                foreach (DataRow lv in leaves.Rows)
                    html.Append("<span><b class='leave'>").Append(E(LeaveLabel(Value(lv, "ShortName", "")))).Append("</b> ").Append(E(Value(lv, "LeaveName", ""))).Append("</span>");
            html.Append("</div>");

            // Section wise: all employees of one section together, then the next section
            var sections = data.AsEnumerable()
                .Select((row, i) => new { row, i })
                .GroupBy(x => Value(x.row, "DptName", ""))
                .OrderBy(g => g.Min(x => x.i))
                .ToList();
            bool firstSection = true;
            foreach (var section in sections)
            {
                var rows = section.Select(x => x.row).ToList();
                html.Append("<section class='dept-section").Append(firstSection ? "" : " next").Append("'>");
                html.Append("<div class='section-title'>Section: <strong>").Append(E(section.Key.Length > 0 ? section.Key : "N/A")).Append("</strong></div>");
                AppendSectionTable(html, rows, month, days, lastDay, summary);
                html.Append("</section>");
                firstSection = false;
            }
            html.Append("<footer class='signatures'><span>HOD</span><span>Human Resources Manager</span><span>Revenue and Credit Manager</span><span>Financial Controller</span><span>Pubudu Fernando<br/>Cluster General Manager</span></footer></div>");
            reportContent.Text = html.ToString();
        }

        private void AppendSectionTable(StringBuilder html, List<DataRow> rows, DateTime month, int days, DateTime lastDay, List<string> summary)
        {
            html.Append("<div class='table-wrap'><table class='attendance'><colgroup><col style='width:34px'/><col style='width:105px'/><col style='width:150px'/><col style='width:120px'/>");
            for (int d = 1; d <= days; d++) html.Append("<col style='width:26px'/>");
            html.Append("<col style='width:58px'/>");
            // widen summary columns so longer titles (e.g. LWP) are not cut off
            foreach (string column in summary) html.Append("<col style='width:").Append(Math.Max(34, 14 + SummaryTitle(column).Length * 9)).Append("px'/>");
            html.Append("<col style='width:90px'/></colgroup>");

            html.Append("<thead><tr><th rowspan='3'>SL</th><th rowspan='3'>Emp ID</th><th rowspan='3'>Employee Name</th><th rowspan='3'>Designation</th><th colspan='").Append(days).Append("'>")
                .Append(month.ToString("d MMMM yyyy", CultureInfo.InvariantCulture)).Append(" to ").Append(lastDay.ToString("d MMMM yyyy", CultureInfo.InvariantCulture))
                .Append("</th><th rowspan='3' class='payable'>Payable<br/>Days</th>");
            if (summary.Count > 0) html.Append("<th colspan='").Append(summary.Count).Append("'>Attendance &amp; Leave Summary</th>");
            html.Append("<th rowspan='3'>Remarks</th></tr><tr>");
            for (int d = 1; d <= days; d++)
            {
                DateTime date = new DateTime(month.Year, month.Month, d);
                html.Append("<th class='weekday").Append(date.DayOfWeek == DayOfWeek.Friday ? " friday" : "").Append("'>").Append(date.ToString("ddd", CultureInfo.InvariantCulture)).Append("</th>");
            }
            foreach (string column in summary) html.Append("<th rowspan='2' class='sum-head'>").Append(E(SummaryTitle(column))).Append("</th>");
            html.Append("</tr><tr>");
            for (int d = 1; d <= days; d++)
            {
                DateTime date = new DateTime(month.Year, month.Month, d);
                html.Append("<th class='daynum").Append(date.DayOfWeek == DayOfWeek.Friday ? " friday" : "").Append("'>").Append(d).Append("</th>");
            }
            html.Append("</tr></thead><tbody>");

            int index = 0;
            foreach (DataRow row in rows)
            {
                html.Append("<tr><td>").Append(++index).Append("</td><td>").Append(E(Value(row, "EmpCardNo", Value(row, "EmpId", ""))))
                    .Append("</td><td class='left'>").Append(E(Value(row, "EmpName", ""))).Append("</td><td class='left muted'>").Append(E(Value(row, "DsgName", ""))).Append("</td>");
                for (int d = 1; d <= days; d++)
                {
                    string status = DayStatus(row, d);
                    html.Append("<td class='status ").Append(StatusClass(status)).Append("'>").Append(E(status)).Append("</td>");
                }
                html.Append("<td class='payable'>").Append(E(Value(row, "TotalPayAbleDays", "0"))).Append("</td>");
                foreach (string column in summary)
                {
                    string count = Value(row, column, "0");
                    html.Append("<td class='sum").Append(count == "0" ? " zero" : "").Append("'>").Append(E(count)).Append("</td>");
                }
                html.Append("<td></td></tr>");
            }
            html.Append("</tbody></table></div>");
        }

        private static string Value(DataRow row, string column, string fallback)
        { return row.Table.Columns.Contains(column) && row[column] != DBNull.Value ? Convert.ToString(row[column]) : fallback; }
        private static string DayStatus(DataRow row, int day)
        {
            string value = Value(row, day.ToString("00", CultureInfo.InvariantCulture), Value(row, day.ToString(CultureInfo.InvariantCulture), ""));
            return DecodeStatus(value);
        }
        private static List<string> GetSummaryColumns(DataTable data)
        {
            var fixedColumns = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
            { "EmpId", "EmpCardNo", "EmpName", "DsgName", "DptId", "DptName", "SftId", "SftName", "GName", "CompanyId", "CompanyName", "Address", "DptCode", "CustomOrdering", "TotalPayAbleDays" };
            var summary = data.Columns.Cast<DataColumn>().Select(c => c.ColumnName)
                .Where(name => !fixedColumns.Contains(name) && !Regex.IsMatch(name, "^\\d{1,2}$"))
                .ToList();
            var order = new[] { "P", "L", "A", "W", "H", "PH" };
            summary = order.Where(name => summary.Contains(name, StringComparer.OrdinalIgnoreCase))
                .Concat(summary.Where(name => !order.Contains(name, StringComparer.OrdinalIgnoreCase)))
                .ToList();
            return summary;
        }
        private static string SummaryTitle(string column)
        {
            if (column.Equals("H", StringComparison.OrdinalIgnoreCase)) return "PH";
            return LeaveLabel(column.StartsWith("LV_", StringComparison.OrdinalIgnoreCase) ? column.Substring(3) : column);
        }
        // Leave without pay is configured as "LWPL"; the report shows it as "LWP"
        private static string LeaveLabel(string shortName)
        {
            return (shortName ?? "").Trim().Equals("LWPL", StringComparison.OrdinalIgnoreCase) ? "LWP" : shortName;
        }
        private static string E(string value) { return HttpUtility.HtmlEncode(value ?? ""); }
        private static string DecodeStatus(string raw)
        {
            decimal numericCode;
            string value = (raw ?? "").Trim();
            if (!decimal.TryParse(value, NumberStyles.Number, CultureInfo.InvariantCulture, out numericCode))
                return value.Equals("H", StringComparison.OrdinalIgnoreCase) ? "PH" : value;
            int code = decimal.ToInt32(decimal.Truncate(numericCode));
            switch (code)
            {
                case 112: return "P";
                case 97: return "A";
                case 119: return "W";
                case 104: return "PH";
                case 108: return "L";
                case 226: return "Lv";
                default: return "";
            }
        }
        private static string StatusClass(string value)
        {
            switch ((value ?? "").Trim().ToUpperInvariant())
            {
                case "": return "";
                case "P": case "PRESENT": return "present";
                case "L": return "late";
                case "A": case "ABSENT": return "absent";
                case "W": case "O": case "WO": case "OFF": case "H": case "PH": return "holiday";
                default: return "leave"; // any configured leave initial (CL, SL, AL, Lv ...)
            }
        }
    }
}
