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
using SigmaERP.hrms.BLL;

namespace SigmaERP.hrms.settings
{
    public partial class reportGenerate : System.Web.UI.Page
    {
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                classes.commonTask.loadDepartment(ddlDepartment);
                classes.commonTask.LoadDesignation("0", ddlDesignation);
                classes.commonTask.LoadUnit("0001", ddlUnit);
                classes.commonTask.loadEmpCardNoByCompany(ddlEmployee, "0001");
                LoadDefaultTemplate("Promotion");
                ShowAvailableTokens();
            }
        }

        // ---------------- Cascading dropdowns ----------------
        // Department / Designation / Unit / Employee are all OPTIONAL filters.
        // Leaving one empty ("-- সব --") means "don't filter by this" --
        // this is what lets the same page cover Single Employee, one
        // Department, one Designation/Unit, or literally everyone.

        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e) => LoadEmployees();
        protected void ddlDesignation_SelectedIndexChanged(object sender, EventArgs e) => LoadEmployees();
        protected void ddlUnit_SelectedIndexChanged(object sender, EventArgs e) => LoadEmployees();

        protected void ddlLetterType_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadDefaultTemplate(ddlLetterType.SelectedValue);
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

            BindWithAllOption(ddlEmployee, dt, "name", "employee_id", allLabel: "-- সব কর্মী --");
        }

        private void BindWithAllOption(System.Web.UI.WebControls.DropDownList ddl, DataTable dt, string textField, string valueField, string allLabel = "-- সব --")
        {
            ddl.Items.Clear();
            ddl.Items.Add(new System.Web.UI.WebControls.ListItem(allLabel, ""));
            ddl.DataTextField = textField;
            ddl.DataValueField = valueField;
            ddl.DataSource = dt;
            ddl.DataBind();
        }

        // Available tokens are fixed because the SELECT list below is fixed
        // (not "select *"). Add a new aliased column to BuildEmployeeQuery()
        // and add its {{token}} name here too.
        private void ShowAvailableTokens()
        {
            var tokens = new[] {
                "employee_id","name","designation","department","unit_name",
                "group_name","grade_name","shift_name","company_name",
                "company_address","joining_date","date"
            };
            var display = new List<string>();
            foreach (var t in tokens) display.Add("{{" + t + "}}");
            lblAvailableTokens.Text = string.Join("&nbsp;&nbsp;", display);
        }

        private void LoadDefaultTemplate(string letterType)
        {
            var defaults = new Dictionary<string, string>
            {
                ["Promotion"] = "তারিখ: {{date}}\n\nজনাব/জনাবা {{name}},\nআপনাকে {{designation}} পদ থেকে পদোন্নতি প্রদান করা হলো।\n\n{{company_name}}",
                ["Appointment"] = "তারিখ: {{date}}\n\n{{name}}-কে {{department}} বিভাগে {{designation}} পদে নিয়োগ প্রদান করা হলো।\n\n{{company_name}}",
                ["Dismissal"] = "তারিখ: {{date}}\n\n{{name}}-এর চাকরি {{department}} বিভাগ থেকে অবসায়িত করা হলো।\n\n{{company_name}}",
                ["NightDutyBill"] = "তারিখ: {{date}}\n\n{{name}} ({{employee_id}}) এর রাত্রিকালীন কাজের বিল অনুমোদনের জন্য উপস্থাপন করা হলো।\n\n{{company_name}}",
                ["Custom"] = ""
            };
            txtTemplateBody.Text = defaults.ContainsKey(letterType) ? defaults[letterType] : "";
        }

        // ---------------- Save template ----------------

        protected void btnSaveTemplate_Click(object sender, EventArgs e)
        {
            string query = "INSERT INTO LetterTemplates (TemplateName, LetterType, TemplateBodyHtml, CreatedBy) VALUES ('"
           + txtTemplateName.Text.Trim().Replace("'", "''") + "','"
           + ddlLetterType.SelectedValue.Replace("'", "''") + "','"
           + txtTemplateBody.Text.Replace("'", "''") + "','"
           + (User?.Identity?.Name ?? "system").Replace("'", "''") + "')";

            bool isSave = CRUD.Execute(query);
            litMessage.Text = "<p style='color:green;'>টেমপ্লেট সংরক্ষণ করা হয়েছে।</p>";
        }

        // ---------------- Generate PDF ----------------

        protected void btnGeneratePdf_Click(object sender, EventArgs e)
        {
            DataTable employees = GetEmployees(
                "0001",
                ddlDepartment.SelectedValue,
                ddlDesignation.SelectedValue,
                ddlUnit.SelectedValue,
                ddlEmployee.SelectedValue);

            if (employees.Rows.Count == 0)
            {
                litMessage.Text = "<p style='color:red;'>এই ফিল্টারে কোনো কর্মী পাওয়া যায়নি।</p>";
                return;
            }

            string template = txtTemplateBody.Text;

            byte[] fileBytes;
            string fileName;

            if (employees.Rows.Count == 1)
            {
                var fieldMap = TokenEngine.BuildFieldMap(employees.Rows[0]);

                string html = TokenEngine.Merge(template, fieldMap)
                                         .Replace("\n", "<br/>");

                fileName = $"Letter_{fieldMap["employee_id"]}.pdf";

                fileBytes = GeneratePdfFromApi(html, fileName);
            }
            else
            {
                StringBuilder html = new StringBuilder();

                foreach (DataRow row in employees.Rows)
                {
                    var fieldMap = TokenEngine.BuildFieldMap(row);

                    html.Append(TokenEngine.Merge(template, fieldMap)
                                           .Replace("\n", "<br/>"));

                    html.Append("<div style='page-break-after:always'></div>");
                }

                fileName = $"Letters_{ddlLetterType.SelectedValue}_{DateTime.Now:yyyyMMdd_HHmm}.pdf";

                fileBytes = GeneratePdfFromApi(html.ToString(), fileName);
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
            string sql = @"
                SELECT
                    ei.EmpId                              AS employee_id,
                    ep.EmpName                            AS name,           -- adjust column name if different
                    dsg.DsgName                           AS designation,
                    dpt.DptName                           AS department,
                    unt.UnitName                          AS unit_name,
                    grp.GroupName                         AS group_name,
                    grd.GradeName                         AS grade_name,
                    sft.ShiftName                         AS shift_name,
                    com.CompanyName                       AS company_name,
                    com.CompanyAddress                    AS company_address,
                    cs.JoiningDate                        AS joining_date,   -- adjust if this lives elsewhere
                    CONVERT(VARCHAR(20), GETDATE(), 106)  AS date
                FROM Personnel_EmployeeInfo ei
                INNER JOIN Personnel_EmpPersonnal ep      ON ei.EmpId = ep.EmpId
                INNER JOIN Personnel_EmpCurrentStatus cs  ON ei.EmpId = cs.EmpId AND cs.IsActive = 1
                LEFT JOIN Personnel_EmpAddress ad         ON ei.EmpId = ad.EmpId
                LEFT JOIN Personnel_EmpEducation edu      ON ei.EmpId = edu.EmpId
                LEFT JOIN Personnel_EmpExperience ex      ON ei.EmpId = ex.EmpId   -- fixed (was ei.EmpId = ei.EmpId)
                INNER JOIN HRD_Department dpt             ON cs.DptId = dpt.DptId
                LEFT JOIN HRD_Designation dsg             ON cs.DsgId = dsg.DsgId  -- fixed (was cs.EmpId = dsg.DsgId)
                INNER JOIN HRD_Shift sft                  ON cs.SftId = sft.SftId
                LEFT JOIN HRD_Group grp                   ON cs.GId = grp.GId
                LEFT JOIN HRD_Grade grd                   ON cs.GrdId = grd.GrdId
                INNER JOIN HRD_CompanyInfo com             ON cs.CompanyId = com.CompanyId
                LEFT JOIN HRDUnits unt                    ON cs.UnitId = unt.UnitId
                WHERE cs.CompanyId = @CompanyId";


            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(sql);
            return dt;
        }


        private byte[] GeneratePdfFromApi(string html, string fileName)
        {
            var requestObject = new
            {
                Html = html,
                FileName = fileName
            };

            string json = JsonConvert.SerializeObject(requestObject);

            HttpWebRequest request =
                (HttpWebRequest)WebRequest.Create("https://localhost:7265/api/Pdf/Convert");

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




