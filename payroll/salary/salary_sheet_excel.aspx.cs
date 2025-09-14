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
    public partial class salary_sheet_excel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                string paymentType = Request.QueryString["PaymentType"]?.ToString();
                string company = Request.QueryString["company"].ToString();

                if (!string.IsNullOrEmpty(paymentType) && paymentType.Equals("Bkash", StringComparison.OrdinalIgnoreCase))
                {
                    bankContainer.Visible = false;
                    bkashContainer.Visible = true;

                    // Example - you can also fetch from DB
                    lblCompanyName.Text = company;
                    lblBkashWallet.Text = "Bkash Wallet Number";
                }
                else
                {
                    bankContainer.Visible = true;
                    bkashContainer.Visible = false;
                }


                bindData();
            }

        }

        private void bindData()
        {
            DataTable dt = (DataTable)Session["__salarySheetExcel__"];
            gvSalarySheetExcel.DataSource = dt;
            gvSalarySheetExcel.DataBind();
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            string _for = Request.QueryString["for"].ToString();
            string company = Request.QueryString["company"].ToString();
            string PaymentType = Request.QueryString["PaymentType"].ToString();

            string letterRef = txtLetterRef.Text.Trim();
            string date = txtDate.Text.Trim();
            string bank = txtBankName.Text.Trim();
            string branch = txtBranch.Text.Trim();
            string month = txtMonth.Text.Trim();
            string accountNo = txtAccountNo.Text.Trim();

            decimal totalPayable = 0;

            DataTable dt = GetDataTableFromGridView(gvSalarySheetExcel);

            var filteredColumns = dt.Columns.Cast<DataColumn>()
                .Where(c => !c.ColumnName.Trim().Equals("SL", StringComparison.OrdinalIgnoreCase))
                .ToList();

            // ✅ First calculate total payable
            foreach (DataRow row in dt.Rows)
            {
                foreach (var column in filteredColumns)
                {
                    string cellValue = row[column.ColumnName].ToString();
                    if (column.ColumnName.Trim().Equals("Net Payable", StringComparison.OrdinalIgnoreCase) &&
                        decimal.TryParse(cellValue, out decimal netPay))
                    {
                        totalPayable += netPay;
                    }
                }
            }

            // ✅ Header text based on PaymentType
            string headerText = "";

            if (PaymentType == "Bkash")
            {
                string bkashWallet = accountNo;
                headerText = $@"
            <b>{company}</b><br/>
            <b>Bkash Wallet No: {bkashWallet}</b><br/><br/>";
            }
            else
            {
                headerText = $@"
            {letterRef} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date: {date}<br/>
            To <br/>
            The Manager<br/>
            {bank}<br/>
            {branch}<br/>
            Sub: Advice<br/><br/>
            Muhtaram,<br/>
            Assalamu Alaikum,<br/><br/>
            We are sending herewith the list of following workers for disbursement of their wages for the month of {month}. 
            An amount of Tk-{totalPayable.ToString("N2")} may please be credited to their individual salary account mentioned against their respective names 
            by debiting our current account no {accountNo}.
            ";
            }

            // ✅ Excel export starts here
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + _for + "_" + DateTimeOffset.Now.ToUnixTimeMilliseconds() + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                hw.Write("<style>table, th, td {width:80%; border: 1px solid gray; border-collapse: collapse; }</style>");
                hw.Write("<tr><td colspan='" + (filteredColumns.Count + 1) + "' style='border:none; font-size:14px; line-height:22px;'>");
                hw.Write(headerText);
                hw.Write("</td></tr><br/>");

                hw.Write("<table border='1' style='border-collapse: collapse; width:80%;'>");
                hw.Write("<tr><th>SL</th>");
                foreach (var column in filteredColumns)
                {
                    hw.Write("<th>" + column.ColumnName + "</th>");
                }
                hw.Write("</tr>");

                int sl = 1;
                foreach (DataRow row in dt.Rows)
                {
                    hw.Write("<tr>");
                    hw.Write("<td>" + sl++ + "</td>");
                    foreach (var column in filteredColumns)
                    {
                        string cellValue = row[column.ColumnName].ToString();
                        if (column.ColumnName.ToLower().Contains("account"))
                        {
                            hw.Write("<td style='mso-number-format:\"\\@\";'>" + cellValue + "</td>");
                        }
                        else
                        {
                            hw.Write("<td>" + cellValue + "</td>");
                        }
                    }
                    hw.Write("</tr>");
                }

                // ✅ Total Row
                hw.Write("<tr>");
                hw.Write("<td colspan='" + filteredColumns.Count + "'><b>Total:</b></td>");
                hw.Write("<td style='mso-number-format:0;'><b>" + totalPayable.ToString("N2") + "</b></td>");
                hw.Write("</tr>");
                hw.Write("</table>");

                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }












        //protected void btnExport_Click(object sender, EventArgs e)
        //{
        //    string _for = Request.QueryString["for"].ToString();
        //    string company = Request.QueryString["company"].ToString();
        //    string month = Request.QueryString["month"].ToString();

        //    Response.Clear();
        //    Response.Buffer = true;
        //    Response.AddHeader("content-disposition", "attachment;filename="+ _for+"_"+ DateTimeOffset.Now.ToUnixTimeMilliseconds().ToString() + ".xls");
        //    Response.Charset = "";
        //    Response.ContentType = "application/vnd.ms-excel";

        //    using (StringWriter sw = new StringWriter())
        //    {
        //        HtmlTextWriter hw = new HtmlTextWriter(sw);
        //        DataTable dt = GetDataTableFromGridView(gvSalarySheetExcel);

        //        hw.Write("<style>table, th, td { border: 1px solid black; border-collapse: collapse; }</style>");
        //        hw.Write("<table>");


        //        int columnCount = dt.Columns.Count + 1;




        //        // Write custom header lines in the middle without borders
        //        hw.Write("<table>");
        //        hw.Write("<tr><td colspan='" + columnCount + "' style='text-align:center; border:none;'><b>"+company+ "</b></td></tr>");
        //        hw.Write("<tr><td colspan='" + columnCount + "' style='text-align:center; border:none;'><b>Salary Sheet for the Month of "+ month + "</b></td></tr>");
        //        hw.Write("<tr><td colspan='" + columnCount + "' style='border:none;'>&nbsp;</td></tr>"); // Empty row for spacing

        //        hw.Write("<tr>");
        //        hw.Write("<th>SL</th>"); 
        //        foreach (DataColumn column in dt.Columns)
        //        {
        //            hw.Write("<th>" + column.ColumnName + "</th>");
        //        }
        //        hw.Write("</tr>");
        //        var groupedData = dt.AsEnumerable()
        //      .GroupBy(row => row.Field<string>("Department"))
        //      .Select(g => new
        //      {
        //          Department = g.Key,
        //          Rows = g.CopyToDataTable(),
        //          Sum = g.Sum(row => Convert.ToDecimal(row["Net Payable"]))
        //      });
        //        //if (_for == "SalarySheet")
        //        //{
        //        //     groupedData = dt.AsEnumerable()
        //        // .GroupBy(row => row.Field<string>("Department"))
        //        // .Select(g => new
        //        // {
        //        //     Department = g.Key,
        //        //     Rows = g.CopyToDataTable(),
        //        //     Sum = g.Sum(row => Convert.ToDecimal(row["Net Payable"]))
        //        // });


        //        //}

        //        foreach (var group in groupedData)
        //        {

        //            hw.Write("<tr><td colspan='" + (dt.Columns.Count + 1) + "'><b>Department: " + group.Department + "</b></td></tr>");
        //            int sl = 1;
        //            foreach (DataRow dataRow in group.Rows.Rows)
        //            {
        //                hw.Write("<tr>");
        //                hw.Write("<td style='mso-number-format:0;'>" + sl++ + "</td>");
        //                foreach (var item in dataRow.ItemArray)
        //                {
        //                    hw.Write("<td>" + item.ToString() + "</td>");
        //                }
        //                hw.Write("</tr>");
        //            }

        //            hw.Write("<tr>");
        //            hw.Write("<td colspan='" + dt.Columns.Count + "'><b>Total:</b></td>");
        //            hw.Write("<td style='mso-number-format:0;'><b>" + group.Sum.ToString("N2") + "</b></td>");
        //            hw.Write("</tr>");

        //            hw.Write("<tr><td colspan='" + (dt.Columns.Count + 1) + "'>&nbsp;</td></tr>");
        //        }

        //        hw.Write("</table>");

        //        Response.Output.Write(sw.ToString());
        //        Response.Flush();
        //        Response.End();
        //    }

        //}

        public override void VerifyRenderingInServerForm(Control control)
        {
            // Verifies that the control is rendered
        }

 

        private DataTable GetDataTableFromGridView(GridView gridView)
        {
            DataTable dt = new DataTable();
            foreach (TableCell cell in gridView.HeaderRow.Cells)
            {
                dt.Columns.Add(cell.Text);
            }
            foreach (GridViewRow row in gridView.Rows)
            {
                DataRow dr = dt.NewRow();
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    dr[i] = row.Cells[i].Text;
                }
                dt.Rows.Add(dr);
            }

            return dt;
        }


    }
}