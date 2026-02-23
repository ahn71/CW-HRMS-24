using OfficeOpenXml;
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
    public partial class IncrementEntitle_Sheet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();

            }
        }


        private void BindData()
        {
            ViewState["__companyId__"] = "";
            ViewState["__fileName__"] = "";
            ViewState["__monthName__"] = "";
            string[] query = Request.QueryString["for"].ToString().Split('-');
            string EmployeeType = query[0].ToString() == "All" ? "" : query[0].ToString();

            ViewState["__companyId__"] = query[1].ToString();
            ViewState["__monthName__"] = query[2].ToString().Replace('/', '-');
            string type = query[3].ToString();
            ViewState["__title__"] = "";
            if (type == "0")
            {
                ViewState["__title__"] = EmployeeType + " Increment Sheet";
                ViewState["__fileName__"] = EmployeeType + "_Increment_Sheet";
            }
            else if (type == "1")
            {
                ViewState["__title__"] = EmployeeType + " Common Increment Sheet";
                ViewState["__fileName__"] = EmployeeType + "_Common_Increment_Sheet";
            }
            else if (type == "2")
            {
                ViewState["__title__"] = EmployeeType + " Special Increment Sheet";
                ViewState["__fileName__"] = EmployeeType + "_Special_Increment_Sheet";
            }
            else if (type == "3" || type == "4")
            {
                ViewState["__title__"] = EmployeeType + " Promotion Sheet";
                ViewState["__fileName__"] = EmployeeType + "_Promotion_Sheet";
            }
            header.InnerHtml = ViewState["__title__"].ToString();
            DataTable dt = new DataTable();
            dt = (DataTable)Session["__eltitleReport__"];

            gvPromotionSheet.DataSource = dt;
            gvPromotionSheet.DataBind();
        }
        private void _BindData()
        {
            ViewState["__companyId__"] = "";
            ViewState["__reportName__"] = "";
            ViewState["__monthName__"] = "";
            ViewState["__type__"] = "";
            string[] query = Request.QueryString["for"].ToString().Split('-');
            ViewState["__reportName__"] = query[0].ToString();
            ViewState["__companyId__"] = query[1].ToString();
            ViewState["__monthName__"] = query[2].ToString().Replace('/', '-');
            ViewState["__type__"] = query[3].ToString();
            string type = ViewState["__type__"].ToString() == "1" ? "Common Increment sheet" : ViewState["__type__"].ToString() == "2" ? "Special Increment sheet" : ViewState["__type__"].ToString() == "0" ? "Increment sheet" : "Promotion Sheet";//Promotion Sheet=(3,4)
            header.InnerHtml = type;
            DataTable dt = new DataTable();
            dt = (DataTable)Session["__eltitleReport__"];
            gventitleList.DataSource = dt;
            gventitleList.DataBind();
        }
        private void _ExportToExcel()
        {
            ExcelPackage.LicenseContext = LicenseContext.Commercial; // Set the license context for EPPlus

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment; filename=" + ViewState["__reportName__"] + ".xlsx");

            using (ExcelPackage package = new ExcelPackage())
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Sheet1");
                worksheet.Cells[1, 1].Value = "SL";
                int colIndexForData = 2;
                for (int i = 1; i < gventitleList.Columns.Count; i++)
                {
                    if (gventitleList.Columns[i].HeaderText.Trim() != string.Empty)
                    {
                        if (gventitleList.Columns[i] is BoundField)
                        {
                            worksheet.Cells[1, colIndexForData].Value = gventitleList.Columns[i].HeaderText;
                            colIndexForData++;
                        }
                    }
                }
                for (int rowIndex = 0; rowIndex < gventitleList.Rows.Count; rowIndex++)
                {
                    worksheet.Cells[rowIndex + 2, 1].Value = rowIndex + 1;

                    colIndexForData = 2;

                    for (int colIndex = 1; colIndex < gventitleList.Columns.Count; colIndex++)
                    {
                        if (gventitleList.Columns[colIndex].HeaderText.Trim() != string.Empty)
                        {
                            if (gventitleList.Columns[colIndex] is BoundField)
                            {
                                string cellValue = gventitleList.Rows[rowIndex].Cells[colIndex].Text.Trim();


                                if (cellValue == "&nbsp;")
                                {
                                    cellValue = null;
                                }


                                worksheet.Cells[rowIndex + 2, colIndexForData].Value = string.IsNullOrEmpty(cellValue) ? null : cellValue;
                                colIndexForData++;
                            }
                        }
                    }
                }
                using (MemoryStream ms = new MemoryStream())
                {
                    package.SaveAs(ms);
                    ms.WriteTo(Response.OutputStream);
                }
                Response.Flush();
                Response.End();
            }
        }

        private void ExportToExcel(string companyName, string address)
        {
            string date = getDate_MMMM_yyyy();
            ExcelPackage.LicenseContext = LicenseContext.Commercial; // Set the license context for EPPlus

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment; filename=" + ViewState["__fileName__"] + ".xlsx");

            //using (ExcelPackage package = new ExcelPackage())
            //{
            //    ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Sheet1");

            //    // Define total columns count for merging headers
            //    int totalColumns = gvPromotionSheet.Columns.Count;
            //    //int totalColumns = 0;
            //    if (gvPromotionSheet.Rows.Count > 0)
            //    {
            //        totalColumns = gvPromotionSheet.Rows[0].Cells.Count;
            //    }

            //    // 1st Header: Company Name
            //    worksheet.Cells[1, 1, 1, totalColumns].Merge = true;
            //    worksheet.Cells[1, 1].Value = $"{companyName}";
            //    worksheet.Cells[1, 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
            //    worksheet.Cells[1, 1].Style.Font.Size = 14;
            //    worksheet.Cells[1, 1].Style.Font.Bold = true;

            //    // 2nd Header: Address
            //    worksheet.Cells[2, 1, 2, totalColumns].Merge = true;
            //    worksheet.Cells[2, 1].Value = $"{address}"; // Replace with actual address
            //    worksheet.Cells[2, 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
            //    worksheet.Cells[2, 1].Style.Font.Size = 12;
            //    worksheet.Cells[2, 1].Style.Font.Italic = true;

            //    // 3rd Header: Report Name
            //    worksheet.Cells[3, 1, 3, totalColumns].Merge = true;
            //    if(date=="")
            //        worksheet.Cells[3, 1].Value = $"{type} Increment Sheet (Individual)"; // Replace dynamically if needed
            //    else
            //       worksheet.Cells[3, 1].Value = $"{type} Increment Sheet for the Month of " + date; // Replace dynamically if needed
            //    worksheet.Cells[3, 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
            //    worksheet.Cells[3, 1].Style.Font.Size = 12;
            //    worksheet.Cells[3, 1].Style.Font.Bold = true;

            //    // Insert an empty row before table headers
            //    int startRow = 5; // Data starts from row 5

            //    // Add Column Headers (Row 5)
            //    worksheet.Cells[startRow, 1].Value = "SL"; // Serial Number column
            //    int colIndexForData = 2;
            //    for (int i = 1; i < gventitleList.Columns.Count; i++)
            //    {
            //        if (gventitleList.Columns[i].HeaderText.Trim() != string.Empty)
            //        {
            //            if (gventitleList.Columns[i] is BoundField)
            //            {
            //                worksheet.Cells[startRow, colIndexForData].Value = gventitleList.Columns[i].HeaderText;
            //                worksheet.Cells[startRow, colIndexForData].Style.Font.Bold = true;
            //                worksheet.Cells[startRow, colIndexForData].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
            //                worksheet.Cells[startRow, colIndexForData].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.LightGray);
            //                colIndexForData++;
            //            }
            //        }
            //    }

            //    // Add Data Rows (Start from Row 6)
            //    for (int rowIndex = 0; rowIndex < gventitleList.Rows.Count; rowIndex++)
            //    {
            //        worksheet.Cells[rowIndex + startRow + 1, 1].Value = rowIndex + 1; // Serial Number

            //        colIndexForData = 2;
            //        for (int colIndex = 1; colIndex < gventitleList.Columns.Count; colIndex++)
            //        {
            //            if (gventitleList.Columns[colIndex].HeaderText.Trim() != string.Empty)
            //            {
            //                if (gventitleList.Columns[colIndex] is BoundField)
            //                {
            //                    string cellValue = gventitleList.Rows[rowIndex].Cells[colIndex].Text.Trim();
            //                    if (cellValue == "&nbsp;")
            //                    {
            //                        cellValue = null;
            //                    }
            //                    worksheet.Cells[rowIndex + startRow + 1, colIndexForData].Value = string.IsNullOrEmpty(cellValue) ? null : cellValue;
            //                    colIndexForData++;
            //                }
            //            }
            //        }
            //    }

            //    // AutoFit columns for better readability
            //    worksheet.Cells.AutoFitColumns();

            //    using (MemoryStream ms = new MemoryStream())
            //    {
            //        package.SaveAs(ms);
            //        ms.WriteTo(Response.OutputStream);
            //    }
            //    Response.Flush();
            //    Response.End();
            //}
            using (ExcelPackage package = new ExcelPackage())
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Sheet1");

                // ✅ Total columns from header row
                int totalColumns = 0;
                if (gvPromotionSheet.HeaderRow != null)
                {
                    totalColumns = gvPromotionSheet.HeaderRow.Cells.Count;
                }

                // 1st Header: Company Name
                worksheet.Cells[1, 1, 1, totalColumns].Merge = true;
                worksheet.Cells[1, 1].Value = companyName;
                worksheet.Cells[1, 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Style.Font.Size = 14;
                worksheet.Cells[1, 1].Style.Font.Bold = true;

                // 2nd Header: Address
                worksheet.Cells[2, 1, 2, totalColumns].Merge = true;
                worksheet.Cells[2, 1].Value = address;
                worksheet.Cells[2, 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1].Style.Font.Size = 12;
                worksheet.Cells[2, 1].Style.Font.Italic = true;

                // 3rd Header: Report Name
                worksheet.Cells[3, 1, 3, totalColumns].Merge = true;
                worksheet.Cells[3, 1].Value = string.IsNullOrEmpty(date)
                    ? $"{ViewState["__title__"].ToString()}"
                    : $"{ViewState["__title__"].ToString()} for the Month of {date}";
                worksheet.Cells[3, 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                worksheet.Cells[3, 1].Style.Font.Size = 12;
                worksheet.Cells[3, 1].Style.Font.Bold = true;

                // Insert an empty row before table headers
                int startRow = 5;

                // ✅ Column Headers
                //worksheet.Cells[startRow, 1].Value = "SL"; // Serial number column
                //worksheet.Cells[startRow, 1].Style.Font.Bold = true;

                for (int colIndex = 0; colIndex < totalColumns; colIndex++)
                {
                    string headerText = gvPromotionSheet.HeaderRow.Cells[colIndex].Text.Trim();
                    if (!string.IsNullOrEmpty(headerText) && headerText != "&nbsp;")
                    {
                        worksheet.Cells[startRow, colIndex + 2].Value = headerText;
                        worksheet.Cells[startRow, colIndex + 2].Style.Font.Bold = true;
                        worksheet.Cells[startRow, colIndex + 2].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                        worksheet.Cells[startRow, colIndex + 2].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.LightGray);
                    }
                }

                // ✅ Data Rows
                for (int rowIndex = 0; rowIndex < gvPromotionSheet.Rows.Count; rowIndex++)
                {
                    // worksheet.Cells[startRow + 1 + rowIndex, 1].Value = rowIndex + 1; // SL

                    for (int colIndex = 0; colIndex < totalColumns; colIndex++)
                    {
                        string cellValue = HttpUtility.HtmlDecode(gvPromotionSheet.Rows[rowIndex].Cells[colIndex].Text.Trim());
                        if (cellValue == "&nbsp;") cellValue = string.Empty;

                        worksheet.Cells[startRow + 1 + rowIndex, colIndex + 2].Value =
                            string.IsNullOrEmpty(cellValue) ? null : cellValue;
                    }
                }

                // AutoFit columns
                worksheet.Cells.AutoFitColumns();

                // ✅ Send to Response
                using (MemoryStream ms = new MemoryStream())
                {
                    package.SaveAs(ms);
                    ms.WriteTo(Response.OutputStream);
                }
                Response.Flush();
                Response.End();
            }

        }



        public override void VerifyRenderingInServerForm(Control control)
        {
            // Required to avoid the runtime error "Control 'GridView1' of type 'GridView' must be placed inside a form tag with runat=server."
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            var companyInfo = getcompnayInfo();
            ExportToExcel(companyInfo.companyName, companyInfo.Address);
        }

        private (string companyName, string Address) getcompnayInfo()
        {
            string query = "select CompanyName,Address  from HRD_CompanyInfo where CompanyId='" + ViewState["__companyId__"].ToString() + "' ";
            DataTable dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(query);
            if (dt.Rows.Count > 0)
            {
                return (dt.Rows[0]["CompanyName"].ToString(), dt.Rows[0]["Address"].ToString());
            }

            return (string.Empty, string.Empty);

        }

        private string getDate_MMMM_yyyy()
        {
            if (string.IsNullOrEmpty(ViewState["__monthName__"]?.ToString()))
                return "";

            string inputDate = ViewState["__monthName__"].ToString();

            DateTime parsedDate = DateTime.ParseExact(
                inputDate,
                "MM-d-yyyy h:mm:ss tt",
                System.Globalization.CultureInfo.InvariantCulture
            );

            return parsedDate.ToString("MMMM-yyyy");
        }

    }
}