using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
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
            string gg = ViewState["__totalSalary__"].ToString();
            string Qid = "";
            decimal totalSalary = 0;
            int totalRecord = 0;

            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=banksheet.csv");
            Response.ContentType = "text/csv";
            Response.Charset = "";

    
            Response.Write("EMPLOYER EID:,File Creation Date,File Creation Time,Payer EID,Payer QID,Payer Bank Short Name,Total Salaries,Total records:\n");

            Response.Write($"{ViewState["__registrationID__"]},{DateTime.Today:yyyyMMdd},{DateTime.Now:HH:mm},{ViewState["__establishmentID__"]},{Qid},{Session["__bankShortname__"]}," + ViewState["__totalSalary__"] + "," + ViewState["__totalRows__"] + "\n");

       
            var headerValues = new List<string>();
            headerValues.Add("Record ID"); 
            foreach (DataControlField header in gvBannFord.Columns)
            {
                headerValues.Add(header.HeaderText);
            }

          
            Response.Write(string.Join(",", headerValues) + "\n");

        
            if (gvBannFord.DataSource != null)
            {
                gvBannFord.DataBind(); 

               
                foreach (GridViewRow row in gvBannFord.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        var cellValues = new List<string>();

                       
                        cellValues.Add((row.RowIndex + 1).ToString()); 

                      
                        for (int i = 0; i < row.Cells.Count; i++)
                        {
                           
                            string cellText = HttpUtility.HtmlDecode(row.Cells[i].Text.Trim());

                            if (string.IsNullOrWhiteSpace(cellText) || cellText == "&nbsp;")
                            {
                                cellText = ""; 
                            }

                            if (cellText.Contains(","))
                            {
                                cellText = $"\"{cellText}\""; 
                            }

          
                            cellValues.Add(cellText);
                        }

                        Response.Write(string.Join(",", cellValues) + "\n");

                        if (decimal.TryParse(cellValues[6], out decimal netAmount))
                        {
                            totalSalary += netAmount;
                        }

                        totalRecord++;
                    }
                }
            }

            Response.Write("\n");
         
            Response.End();
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