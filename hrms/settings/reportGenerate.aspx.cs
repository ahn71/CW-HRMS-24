using adviitRuntimeScripting;
using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using Newtonsoft.Json;
using System.Text;
using System.Text.RegularExpressions;
using SigmaERP.hrms.BLL;
using DevExpress.XtraRichEdit;

namespace SigmaERP.hrms.settings
{
    public partial class reportGenerate : System.Web.UI.Page
    {
        DataTable dt;
        public string AvailableFieldsJson { get; private set; } = "[]";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Directory.CreateDirectory(Server.MapPath("~/App_Data/RichEditWork"));
                classes.commonTask.loadDepartment(ddlDepartment);
                ddlDepartment.Items.Insert(0, new ListItem("-- All Departments --", ""));
                classes.commonTask.LoadDesignation("0", ddlDesignation);
                ddlDesignation.Items.Insert(0, new ListItem("-- All Designations --", ""));
                classes.commonTask.LoadUnit("0001", ddlUnit);
                ddlUnit.Items.Insert(0, new ListItem("-- All Units --", ""));
                classes.commonTask.loadEmpCardNoByCompany(ddlEmployee, "0001");
                ddlEmployee.Items.Insert(0, new ListItem("-- All Employees --", ""));
                LoadTemplateForLetterType("Promotion");
                LoadAvailableFields();
                LoadRichEditDocument();
            }
            else
            {
                AvailableFieldsJson = ViewState["ReportBuilderAvailableFields"] as string ?? "[]";
            }
        }

        // ---------------- Cascading dropdowns ----------------
        // Department / Designation / Unit / Employee are all OPTIONAL filters.
        // Leaving one empty means "do not filter by this".
        // this is what lets the same page cover Single Employee, one
        // Department, one Designation/Unit, or literally everyone.

        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            classes.commonTask.LoadDesignation(string.IsNullOrEmpty(ddlDepartment.SelectedValue) ? "0" : ddlDepartment.SelectedValue, ddlDesignation);
            ddlDesignation.Items.Insert(0, new ListItem("-- All Designations --", ""));
            LoadEmployees();
        }
        protected void ddlDesignation_SelectedIndexChanged(object sender, EventArgs e) => LoadEmployees();
        protected void ddlUnit_SelectedIndexChanged(object sender, EventArgs e) => LoadEmployees();

        protected void ddlLetterType_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTemplateForLetterType(ddlLetterType.SelectedValue);
            LoadRichEditDocument();
        }



        // Employee list respects whatever Department/Designation/Unit is currently
        // selected, so the "single employee" dropdown narrows itself automatically.
        private void LoadEmployees()
        {
            var dt = GetEmployees(
                "0001",
                ddlDepartment.SelectedValue,
                ddlDesignation.SelectedValue,
                ddlUnit.SelectedValue,
                empId: "");

            BindWithAllOption(ddlEmployee, dt, "name", "employee_id", allLabel: "-- All Employees --");
        }

        private void BindWithAllOption(System.Web.UI.WebControls.DropDownList ddl, DataTable dt, string textField, string valueField, string allLabel = "-- All --")
        {
            ddl.Items.Clear();
            ddl.Items.Add(new System.Web.UI.WebControls.ListItem(allLabel, ""));
            ddl.DataTextField = textField;
            ddl.DataValueField = valueField;
            ddl.DataSource = dt;
            ddl.DataBind();
        }

        // The toolbox is generated from the SELECT aliases. Add a new aliased
        // column in GetEmployees() and it automatically becomes draggable.
        private void LoadAvailableFields()
        {
            DataTable schema = GetEmployees("0001", "", "", "", "");
            var fields = schema == null ? new List<string>() : schema.Columns.Cast<DataColumn>().Select(c => c.ColumnName).ToList();
            AvailableFieldsJson = JsonConvert.SerializeObject(fields);
            ViewState["ReportBuilderAvailableFields"] = AvailableFieldsJson;
        }

        private void LoadDefaultTemplate(string letterType)
        {
            var defaults = new Dictionary<string, string>
            {
                ["Promotion"] = "Date: {{date}}\n\nDear {{name}},\nYou have been promoted from the position of {{designation}}.\n\n{{company_name}}",
                ["Appointment"] = "Date: {{date}}\n\n{{name}} has been appointed as {{designation}} in the {{department}} department.\n\n{{company_name}}",
                ["Dismissal"] = "Date: {{date}}\n\nThe employment of {{name}} in the {{department}} department has been terminated.\n\n{{company_name}}",
                ["NightDutyBill"] = "Date: {{date}}\n\nNight duty bill approval for {{name}} (Employee ID: {{employee_id}}).\n\n{{company_name}}",
                ["Custom"] = ""
            };
            txtTemplateBody.Text = defaults.ContainsKey(letterType) ? defaults[letterType] : "";
            txtTemplateName.Text = string.Empty;
        }

        // Each report type owns one template. Selecting a report type reloads
        // its saved design; if none exists, the standard text is shown instead.
        private void LoadTemplateForLetterType(string letterType)
        {
            string sql = "SELECT TOP 1 TemplateName, TemplateBodyHtml FROM LetterTemplates WHERE LetterType = '"
                         + SqlSafe(letterType) + "'";
            DataTable templates = CRUD.ExecuteReturnDataTable(sql);
            if (templates != null && templates.Rows.Count > 0)
            {
                txtTemplateName.Text = templates.Rows[0]["TemplateName"] == DBNull.Value ? string.Empty : templates.Rows[0]["TemplateName"].ToString();
                txtTemplateBody.Text = templates.Rows[0]["TemplateBodyHtml"] == DBNull.Value ? string.Empty : templates.Rows[0]["TemplateBodyHtml"].ToString();
                return;
            }

            LoadDefaultTemplate(letterType);
        }

        // RichEdit works with an office document internally.  We open the
        // existing HTML template as a document and export it back to HTML on
        // save, so the current preview/PDF/token renderer remains compatible.
        private void LoadRichEditDocument()
        {
            string html = txtTemplateBody.Text ?? string.Empty;
            string documentId = "ReportTemplate_" + ddlLetterType.SelectedValue + "_" + Guid.NewGuid().ToString("N");
            byte[] content = Encoding.UTF8.GetBytes(html);
            richReportEditor.Open(documentId, DocumentFormat.Html, () => new MemoryStream(content));
        }

        private string GetRichEditHtml()
        {
            byte[] content = richReportEditor.SaveCopy(DocumentFormat.Html);
            return Encoding.UTF8.GetString(content);
        }

        // ---------------- Save template ----------------

        protected void btnSaveTemplate_Click(object sender, EventArgs e)
        {
            string letterType = ddlLetterType.SelectedValue;
            string templateName = string.IsNullOrWhiteSpace(txtTemplateName.Text) ? letterType + " Template" : txtTemplateName.Text.Trim();
            string body = GetRichEditHtml();
            txtTemplateBody.Text = body;
            string user = User?.Identity?.Name ?? "system";
            bool isSave = SaveTemplateUnicode(templateName, letterType, body, user);
            litMessage.Text = isSave
                ? "<p style='color:green;'>Template saved successfully.</p>"
                : "<p style='color:#c62828;'>Unable to save the template. Ensure LetterTemplates.TemplateBodyHtml is NVARCHAR(MAX).</p>";
        }

        // Parameterized NVARCHAR values preserve Bengali text. SQL string
        // concatenation converts Bengali characters to question marks.
        private static bool SaveTemplateUnicode(string templateName, string letterType, string body, string user)
        {
            const string sql = @"IF EXISTS (SELECT 1 FROM LetterTemplates WHERE LetterType = @LetterType)
UPDATE LetterTemplates SET TemplateName = @TemplateName, TemplateBodyHtml = @TemplateBodyHtml, CreatedBy = @CreatedBy WHERE LetterType = @LetterType
ELSE
INSERT INTO LetterTemplates (TemplateName, LetterType, TemplateBodyHtml, CreatedBy) VALUES (@TemplateName, @LetterType, @TemplateBodyHtml, @CreatedBy)";

            try
            {
                using (SqlConnection connection = new SqlConnection(Glory.getConnectionString()))
                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.Add("@TemplateName", SqlDbType.NVarChar, 250).Value = templateName ?? string.Empty;
                    command.Parameters.Add("@LetterType", SqlDbType.NVarChar, 50).Value = letterType ?? string.Empty;
                    command.Parameters.Add("@TemplateBodyHtml", SqlDbType.NVarChar, -1).Value = body ?? string.Empty;
                    command.Parameters.Add("@CreatedBy", SqlDbType.NVarChar, 150).Value = user ?? string.Empty;
                    connection.Open();
                    command.ExecuteNonQuery();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }

        // Preview and PDF intentionally use the same renderer, so every filtered
        // employee gets exactly one A4 page in both places.
        protected void btnPreview_Click(object sender, EventArgs e)
        {
            // Keep all exported paragraphs. A logo is often inside a paragraph
            // with no text, which the old cleanup wrongly removed as "empty".
            // Blank paragraphs are also intentional line gaps.
            txtTemplateBody.Text = GetRichEditHtml();
            DataTable employees = GetSelectedEmployees();
            if (employees.Rows.Count == 0)
            {
                litMessage.Text = "<p style='color:red;'>No employees were found for the selected filters.</p>";
                return;
            }

            var pages = new StringBuilder();
            foreach (DataRow employee in employees.Rows)
                pages.Append("<article class='rb-a4-page'>").Append(RenderEmployeeTemplate(txtTemplateBody.Text, employee)).Append("</article>");

            litPreviewPages.Text = pages.ToString();
            litPreviewSummary.Text = employees.Rows.Count + " employee" + (employees.Rows.Count == 1 ? string.Empty : "s") + " / " + employees.Rows.Count + " A4 page" + (employees.Rows.Count == 1 ? string.Empty : "s");
            pnlPreview.Visible = true;
        }

        // ---------------- Generate PDF ----------------

        protected void btnGeneratePdf_Click(object sender, EventArgs e)
        {
            txtTemplateBody.Text = GetRichEditHtml();
            DataTable employees = GetSelectedEmployees();

            if (employees.Rows.Count == 0)
            {
                litMessage.Text = "<p style='color:red;'>No employees were found for the selected filters.</p>";
                return;
            }

            string template = txtTemplateBody.Text;

            byte[] fileBytes;
            string fileName;

            if (employees.Rows.Count == 1)
            {
                var fieldMap = TokenEngine.BuildFieldMap(employees.Rows[0]);
                string html = RenderEmployeeTemplate(template, employees.Rows[0]);

                fileName = $"Letter_{fieldMap["employee_id"]}.pdf";

                fileBytes = GeneratePdfFromApi(BuildPdfHtml(html), fileName);
            }
            else
            {
                StringBuilder html = new StringBuilder();

                foreach (DataRow row in employees.Rows)
                {
                    html.Append("<section class='report-pdf-page'>")
                        .Append(RenderEmployeeTemplate(template, row))
                        .Append("</section>");
                }

                fileName = $"Letters_{ddlLetterType.SelectedValue}_{DateTime.Now:yyyyMMdd_HHmm}.pdf";

                fileBytes = GeneratePdfFromApi(BuildPdfHtml(html.ToString()), fileName);
            }

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", $"attachment; filename={fileName}");
            Response.BinaryWrite(fileBytes);
            Response.Flush();
            Response.End();
        }

        private DataTable GetEmployees(string companyId, string dptId, string dsgId, string unitId, string empId)
        {
            string sql = @"SELECT ei.EmpId AS employee_id, ei.EmpName AS name, dsg.DsgName AS designation, dpt.DptName AS department, unt.UnitName AS unit_name, grp.GName AS group_name, grd.GrdName AS grade_name, sft.SftName AS shift_name, com.CompanyName AS company_name, com.Address AS company_address, ei.EmpJoiningDate AS joining_date, CONVERT(VARCHAR(20), GETDATE(), 106) AS date
                FROM Personnel_EmployeeInfo ei
                INNER JOIN Personnel_EmpPersonnal ep ON ei.EmpId = ep.EmpId
                INNER JOIN Personnel_EmpCurrentStatus cs ON ei.EmpId = cs.EmpId AND cs.IsActive = 1
                INNER JOIN HRD_Department dpt ON cs.DptId = dpt.DptId
                INNER JOIN HRD_Shift sft ON cs.SftId = sft.SftId
                INNER JOIN HRD_CompanyInfo com ON cs.CompanyId = com.CompanyId
                LEFT JOIN HRD_Designation dsg ON cs.DsgId = dsg.DsgId
                LEFT JOIN HRD_Group grp ON cs.GId = grp.GId
                LEFT JOIN HRD_Grade grd ON cs.GrdId = grd.GrdId
                LEFT JOIN HRDUnits unt ON cs.UnitId = unt.UnitId
                WHERE cs.CompanyId = '0001'";

            if (!string.IsNullOrWhiteSpace(dptId)) sql += " AND cs.DptId = '" + SqlSafe(dptId) + "'";
            if (!string.IsNullOrWhiteSpace(dsgId)) sql += " AND cs.DsgId = '" + SqlSafe(dsgId) + "'";
            if (!string.IsNullOrWhiteSpace(unitId)) sql += " AND cs.UnitId = '" + SqlSafe(unitId) + "'";
            if (!string.IsNullOrWhiteSpace(empId)) sql += " AND ei.EmpId = '" + SqlSafe(empId) + "'";


            dt = new DataTable();
            return CRUD.ExecuteReturnDataTable(sql) ?? dt;
        }

        private DataTable GetSelectedEmployees()
        {
            return GetEmployees("0001", ddlDepartment.SelectedValue, ddlDesignation.SelectedValue, ddlUnit.SelectedValue, ddlEmployee.SelectedValue);
        }

        private static string RenderEmployeeTemplate(string template, DataRow employee)
        {
            var safeFieldMap = TokenEngine.BuildFieldMap(employee)
                .ToDictionary(pair => pair.Key, pair => HttpUtility.HtmlEncode(pair.Value));
            string merged = TokenEngine.Merge(template ?? string.Empty, safeFieldMap);
            // Legacy templates may be plain text. RichEdit templates are HTML,
            // where formatting newlines must never be converted to <br/> tags.
            if (!Regex.IsMatch(merged, @"<[a-z][^>]*>", RegexOptions.IgnoreCase))
                merged = merged.Replace("\r\n", "<br/>").Replace("\n", "<br/>");
            return ExtractDocumentBody(merged);
        }

        // RichEdit exports a complete HTML document.  Preview/PDF receives only
        // its document body, while preserving its embedded styles.
        private static string ExtractDocumentBody(string html)
        {
            if (string.IsNullOrWhiteSpace(html)) return string.Empty;

            string styles = string.Concat(Regex.Matches(html, @"<style\b[^>]*>[\s\S]*?</style>", RegexOptions.IgnoreCase)
                .Cast<Match>()
                .Select(match => match.Value));
            Match body = Regex.Match(html, @"<body\b[^>]*>([\s\S]*?)</body>", RegexOptions.IgnoreCase);
            string bodyHtml = body.Success ? body.Groups[1].Value : html;
            return styles + bodyHtml;
        }

        private static string BuildPdfHtml(string content)
        {
            const string printCss = @"<style>
                @page { size: A4; margin: 12mm 15mm; }
                html,body { margin:0; padding:0; color:#172b4d; font-family:Arial,'Noto Sans Bengali',sans-serif; font-size:12pt; line-height:1.35; }
                .report-pdf-page { page-break-after:always; break-after:page; }
                .report-pdf-page:last-child { page-break-after:auto; break-after:auto; }
                p { margin:0 0 7px; line-height:1.35; }
                h1,h2,h3 { margin:0 0 10px; line-height:1.2; }
                table { border-collapse:collapse; margin:6px 0; page-break-inside:auto; break-inside:auto; max-width:100%; }
                tr { page-break-inside:avoid; break-inside:avoid; }
                td,th { vertical-align:top; }
                img { max-width:100% !important; max-height:none !important; height:auto; object-fit:contain; }
            </style>";
            return "<!DOCTYPE html><html><head><meta charset='utf-8' />" + printCss + "</head><body>" + content + "</body></html>";
        }

        private static string SqlSafe(string value) => (value ?? string.Empty).Replace("'", "''");


        private byte[] GeneratePdfFromApi(string html, string fileName)
        {
            var requestObject = new
            {
                Html = html,
                FileName = fileName
            };

            string json = JsonConvert.SerializeObject(requestObject);

            HttpWebRequest request =
                (HttpWebRequest)WebRequest.Create("https://localhost:44322/api/pdf/convert");

            request.Method = "POST";
            request.ContentType = "application/json";

            using (var stream = request.GetRequestStream())
            using (var writer = new StreamWriter(stream))
            {
                writer.Write(json);
            }

            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (MemoryStream ms = new MemoryStream())
            {
                response.GetResponseStream().CopyTo(ms);
                return ms.ToArray();
            }
        }
    }

   


}




