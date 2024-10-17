using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.payroll.salary
{
    public partial class QatarReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ViewState["__company__"] = "";
            ViewState["__Month__"] = "";
            getCompanyInfo();

            BindData();
        }

        private void BindData()
        {
            string _for = Request.QueryString["for"].ToString();
            ViewState["__company__"] = Request.QueryString["company"].ToString();
            ViewState["__Month__"] = Request.QueryString["month"].ToString();
            gvBannFord.DataSource = Session["__SalarySheetBankFord__"];
            gvBannFord.DataBind();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            ExportData();
        }



        private void ExportData()
        {
            // Session and ViewState caching
            string bankShortName = Session["__bankShortname__"]?.ToString();
            if (string.IsNullOrEmpty(bankShortName))
            {
                bankShortName = "CBQ and QIB";
            }

            string totalSalaryString = ViewState["__totalSalary__"]?.ToString();
            string registrationID = ViewState["__registrationID__"]?.ToString();
            string establishmentID = ViewState["__establishmentID__"]?.ToString();
            string totalRows = ViewState["__totalRows__"]?.ToString() ?? "0";
            decimal totalSalary = 0;
            int totalRecord = 0;

            // Initialize CSV content
            var csvContent = new StringBuilder();
            csvContent.AppendLine("EMPLOYER EID:,File Creation Date,File Creation Time,Payer EID,Payer QID,Payer Bank Short Name,Total Salaries,Total records:");
            csvContent.AppendLine($"{registrationID},{DateTime.Today:yyyyMMdd},{DateTime.Now:HH:mm},{establishmentID},,{bankShortName},{totalSalaryString},{totalRows}");

            // Column Headers
            var headerValues = new List<string> { "Record ID" };
            foreach (DataControlField header in gvBannFord.Columns)
            {
                headerValues.Add(header.HeaderText);
            }
            csvContent.AppendLine(string.Join(",", headerValues));

            // Process Rows
            foreach (GridViewRow row in gvBannFord.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    var cellValues = new List<string> { (row.RowIndex + 1).ToString() };
                    for (int i = 0; i < row.Cells.Count; i++)
                    {
                        cellValues.Add(ProcessCellText(row.Cells[i].Text));
                    }

                    // Append row to CSV
                    csvContent.AppendLine(string.Join(",", cellValues));

                    // Accumulate salary data
                    if (decimal.TryParse(cellValues[6], out decimal netAmount))
                    {
                        totalSalary += netAmount;
                    }
                    totalRecord++;
                }
            }

            // Output CSV
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=banksheet.csv");
            Response.ContentType = "text/csv";
            Response.Write(csvContent.ToString());
            Response.Flush();
        }

        private string ProcessCellText(string cellText)
        {
            cellText = HttpUtility.HtmlDecode(cellText?.Trim() ?? "");
            return string.IsNullOrWhiteSpace(cellText) || cellText == "&nbsp;" ? "" : cellText.Contains(",") ? $"\"{cellText}\"" : cellText;
        }




        public override void VerifyRenderingInServerForm(Control control)
        {
            // Required for exporting GridView to Excel
        }

        private void getCompanyInfo()
        {
            string query = "select RegistrationID, EstablishmentID from hrd_companyinfo where companyID = '0004'";
            DataTable dt = CRUD.ExecuteReturnDataTable(query);
            ViewState["__registrationID__"] = dt.Rows[0]["RegistrationID"].ToString();
            ViewState["__establishmentID__"] = dt.Rows[0]["EstablishmentID"].ToString();
        }
        private decimal totalSalary = 0; 
        private int totalRows = 0;
        protected void gvBannFord_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                
                decimal salary = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalSalary"));

              
                totalSalary += salary;

           
                totalRows++;
            }
            ViewState["__totalSalary__"] = totalSalary;
            ViewState["__totalRows__"] = totalRows;

        }
    }
}