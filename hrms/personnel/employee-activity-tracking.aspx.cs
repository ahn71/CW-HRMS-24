using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace SigmaERP.hrms.personnel
{
    public partial class employee_activity_tracking : Page
    {
        protected string MapPointsJson = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetDefaultFilter();
                BindEmptyState();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadActivity();
        }

        private void SetDefaultFilter()
        {
            DateTime today = DateTime.Today;
            txtFromDate.Text = today.ToString("yyyy-MM-dd");
            txtToDate.Text = today.ToString("yyyy-MM-dd");
            txtFromTime.Text = "00:00";
            txtToTime.Text = "23:59";
        }

        private void LoadActivity()
        {
            HideMessage();

            string companyId = GetCompanyId();
            string employeeSearch = txtEmployee.Text.Trim();

            if (string.IsNullOrEmpty(employeeSearch))
            {
                ShowMessage("Please enter employee id or card no.");
                BindEmptyState();
                return;
            }

            DateTime fromDateTime;
            DateTime toDateTime;
            if (!TryGetDateTime(txtFromDate.Text, txtFromTime.Text, out fromDateTime) ||
                !TryGetDateTime(txtToDate.Text, txtToTime.Text, out toDateTime))
            {
                ShowMessage("Please select valid from and to date/time.");
                BindEmptyState();
                return;
            }

            if (fromDateTime > toDateTime)
            {
                ShowMessage("From date/time must be before to date/time.");
                BindEmptyState();
                return;
            }

            DataTable dt = GetActivityData(companyId, employeeSearch, fromDateTime, toDateTime);
            BindActivity(dt);
        }

        private DataTable GetActivityData(string companyId, string employeeSearch, DateTime fromDateTime, DateTime toDateTime)
        {
            string query = @"
SELECT
    act.EmpID,
    act.acitivityTime,
    TRY_CONVERT(decimal(18, 8), act.latitude) AS Latitude,
    TRY_CONVERT(decimal(18, 8), act.loglitude) AS Longitude,
    act.companyId,
    ISNULL(emp.EmpName, '') AS EmpName,
    ISNULL(emp.EmpCardNo, act.EmpID) AS EmpCardNo,
    ISNULL(emp.DptName, '') AS DptName,
    ISNULL(emp.DsgName, '') AS DsgName
FROM attendanceEmployeeActivitis act
LEFT JOIN v_Personnel_EmpCurrentStatus emp
    ON emp.EmpId = act.EmpID
    AND emp.CompanyId = act.companyId
    AND emp.IsActive = 1
WHERE act.companyId = @CompanyId
    AND act.acitivityTime >= @FromDateTime
    AND act.acitivityTime <= @ToDateTime
    AND (
        act.EmpID = @EmployeeSearch
        OR emp.EmpCardNo LIKE @EmployeeLike
        OR emp.EmpName LIKE @EmployeeLike
    )
    AND TRY_CONVERT(decimal(18, 8), act.latitude) IS NOT NULL
    AND TRY_CONVERT(decimal(18, 8), act.loglitude) IS NOT NULL
ORDER BY act.acitivityTime ASC;";

            DataTable dt = new DataTable();
            using (SqlConnection connection = new SqlConnection(Glory.getConnectionString()))
            using (SqlCommand command = new SqlCommand(query, connection))
            using (SqlDataAdapter adapter = new SqlDataAdapter(command))
            {
                command.Parameters.Add("@CompanyId", SqlDbType.VarChar, 50).Value = companyId;
                command.Parameters.Add("@FromDateTime", SqlDbType.DateTime).Value = fromDateTime;
                command.Parameters.Add("@ToDateTime", SqlDbType.DateTime).Value = toDateTime;
                command.Parameters.Add("@EmployeeSearch", SqlDbType.VarChar, 50).Value = employeeSearch;
                command.Parameters.Add("@EmployeeLike", SqlDbType.NVarChar, 150).Value = "%" + employeeSearch + "%";

                adapter.Fill(dt);
            }

            AddDisplayColumns(dt);
            return dt;
        }

        private void AddDisplayColumns(DataTable dt)
        {
            if (!dt.Columns.Contains("ActivityTimeText"))
            {
                dt.Columns.Add("ActivityTimeText", typeof(string));
            }
            if (!dt.Columns.Contains("LatitudeText"))
            {
                dt.Columns.Add("LatitudeText", typeof(string));
            }
            if (!dt.Columns.Contains("LongitudeText"))
            {
                dt.Columns.Add("LongitudeText", typeof(string));
            }

            foreach (DataRow row in dt.Rows)
            {
                row["ActivityTimeText"] = Convert.ToDateTime(row["acitivityTime"]).ToString("dd-MMM-yyyy hh:mm tt");
                row["LatitudeText"] = Convert.ToDecimal(row["Latitude"]).ToString("0.00000000", CultureInfo.InvariantCulture);
                row["LongitudeText"] = Convert.ToDecimal(row["Longitude"]).ToString("0.00000000", CultureInfo.InvariantCulture);
            }
        }

        private void BindActivity(DataTable dt)
        {
            gvActivity.DataSource = dt;
            gvActivity.DataBind();

            litTotalPoints.Text = dt.Rows.Count.ToString();

            if (dt.Rows.Count == 0)
            {
                litEmployeeName.Text = "-";
                litFirstSeen.Text = "-";
                litLastSeen.Text = "-";
                MapPointsJson = "[]";
                ShowMessage("No movement data found for this employee and duration.");
                return;
            }

            DataRow first = dt.Rows[0];
            DataRow last = dt.Rows[dt.Rows.Count - 1];

            string employeeName = first["EmpName"].ToString();
            string employeeCard = first["EmpCardNo"].ToString();
            litEmployeeName.Text = string.IsNullOrEmpty(employeeName)
                ? employeeCard
                : employeeName + " (" + employeeCard + ")";

            litFirstSeen.Text = first["ActivityTimeText"].ToString();
            litLastSeen.Text = last["ActivityTimeText"].ToString();
            MapPointsJson = BuildMapJson(dt);
        }

        private string BuildMapJson(DataTable dt)
        {
            List<MapPoint> points = new List<MapPoint>();
            foreach (DataRow row in dt.Rows)
            {
                points.Add(new MapPoint
                {
                    ActivityTime = row["ActivityTimeText"].ToString(),
                    Latitude = Convert.ToDecimal(row["Latitude"]),
                    Longitude = Convert.ToDecimal(row["Longitude"])
                });
            }

            return new JavaScriptSerializer().Serialize(points);
        }

        private void BindEmptyState()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ActivityTimeText");
            dt.Columns.Add("LatitudeText");
            dt.Columns.Add("LongitudeText");
            dt.Columns.Add("EmpCardNo");
            dt.Columns.Add("DptName");
            dt.Columns.Add("DsgName");

            gvActivity.DataSource = dt;
            gvActivity.DataBind();

            litEmployeeName.Text = "-";
            litTotalPoints.Text = "0";
            litFirstSeen.Text = "-";
            litLastSeen.Text = "-";
            MapPointsJson = "[]";
        }

        private bool TryGetDateTime(string dateText, string timeText, out DateTime value)
        {
            value = DateTime.MinValue;
            DateTime date;
            TimeSpan time;

            if (!DateTime.TryParseExact(dateText, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out date))
            {
                return false;
            }

            if (string.IsNullOrWhiteSpace(timeText))
            {
                timeText = "00:00";
            }

            if (!TimeSpan.TryParse(timeText, out time))
            {
                return false;
            }

            value = date.Date.Add(time);
            return true;
        }

        private string GetCompanyId()
        {
            object company = Session["__GetCompanyId__"];
            return company == null ? "0001" : company.ToString();
        }

        private void ShowMessage(string message)
        {
            pnlMessage.Visible = true;
            litMessage.Text = Server.HtmlEncode(message);
        }

        private void HideMessage()
        {
            pnlMessage.Visible = false;
            litMessage.Text = string.Empty;
        }

        private class MapPoint
        {
            public string ActivityTime { get; set; }
            public decimal Latitude { get; set; }
            public decimal Longitude { get; set; }
        }
    }
}
