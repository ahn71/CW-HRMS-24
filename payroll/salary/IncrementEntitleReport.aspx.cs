using Newtonsoft.Json.Linq;
using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.payroll.salary
{
    public partial class IncrementEntitleReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                commonTask.LoadDepartmentDDL(ddlDepartment, ViewState["__CompanyId__"].ToString());
                classes.Employee.LoadEmpCardNoForPayroll(ddlEmpCard, ViewState["__CompanyId__"].ToString());
              
            }
           
        }
        private void getResponse(string empcard,string deptId)
        {
            string formatDate = txtDate.Text;
            string baseUrl = "https://localhost:7220/api/Salary/employeInfos/salaryIncrement/2024-01-01";
            string queryParams = "";

            if (empcard != "0" && !string.IsNullOrEmpty(empcard))
            {
                queryParams += $"?empCard={empcard}";
            }

            if (deptId != "0" && !string.IsNullOrEmpty(deptId))
            {
                if (string.IsNullOrEmpty(queryParams))
                {
                    queryParams += $"?deptId={deptId}";
                }
                else
                {
                    queryParams += $"&deptId={deptId}";
                }
            }

            string url = baseUrl + queryParams;
            string jsonData = getapiData(url);
            var json = JObject.Parse(jsonData);
            var data = json["data"];

            // Create DataTable
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("empId", typeof(string));
            dataTable.Columns.Add("empName", typeof(string));
            dataTable.Columns.Add("empCardNo", typeof(string));
            dataTable.Columns.Add("preEmpSalary", typeof(decimal));
            dataTable.Columns.Add("empPresentSalary", typeof(decimal));
            dataTable.Columns.Add("preIncrementAmount", typeof(decimal));
            dataTable.Columns.Add("incrementAmount", typeof(decimal));
            dataTable.Columns.Add("preBasicSalary", typeof(decimal));
            dataTable.Columns.Add("basicSalary", typeof(decimal));
            dataTable.Columns.Add("preMedicalAllownce", typeof(decimal));
            dataTable.Columns.Add("medicalAllownce", typeof(decimal));
            dataTable.Columns.Add("preFoodAllownce", typeof(decimal));
            dataTable.Columns.Add("foodAllownce", typeof(decimal));
            dataTable.Columns.Add("preConvenceAllownce", typeof(decimal));
            dataTable.Columns.Add("convenceAllownce", typeof(decimal));
            dataTable.Columns.Add("preHouseRent", typeof(decimal));
            dataTable.Columns.Add("houseRent", typeof(decimal));
            dataTable.Columns.Add("preTechnicalAllownce", typeof(decimal));
            dataTable.Columns.Add("technicalAllownce", typeof(decimal));
            dataTable.Columns.Add("departmentId", typeof(string));
            dataTable.Columns.Add("departmentName", typeof(string));
            dataTable.Columns.Add("designationName", typeof(string));
            dataTable.Columns.Add("lastIncrementMonth", typeof(string));
            dataTable.Columns.Add("empJoiningDate", typeof(string));
            dataTable.Columns.Add("isActive", typeof(int));

            foreach (var item in data)
            {
                DataRow row = dataTable.NewRow();
                row["empId"] = item["empId"];
                row["empName"] = item["empName"];
                row["empCardNo"] = item["empCardNo"];
                row["preEmpSalary"] = item["preEmpSalary"];
                row["empPresentSalary"] = item["empPresentSalary"];
                row["preIncrementAmount"] = item["preIncrementAmount"];
                row["incrementAmount"] = item["incrementAmount"];
                row["preBasicSalary"] = item["preBasicSalary"];
                row["basicSalary"] = item["basicSalary"];
                row["preMedicalAllownce"] = item["preMedicalAllownce"];
                row["medicalAllownce"] = item["medicalAllownce"];
                row["preFoodAllownce"] = item["preFoodAllownce"];
                row["foodAllownce"] = item["foodAllownce"];
                row["preConvenceAllownce"] = item["preConvenceAllownce"];
                row["convenceAllownce"] = item["convenceAllownce"];
                row["preHouseRent"] = item["preHouseRent"];
                row["houseRent"] = item["houseRent"];
                row["preTechnicalAllownce"] = item["preTechnicalAllownce"];
                row["technicalAllownce"] = item["technicalAllownce"];

                row["departmentId"] = item["departmentId"];
                row["departmentName"] = item["departmentName"];
                row["designationName"] = item["designationName"];
                row["empJoiningDate"] = item["empJoiningDate"];
                row["lastIncrementMonth"] = item["lastIncrementMonth"];

                row["isActive"] = item["isActive"];
                dataTable.Rows.Add(row);
            }

            ViewState["__IncrementEntittleData__"] = dataTable;
            gvEmplye.DataSource = dataTable;
            gvEmplye.DataBind();
            // Output the DataTable (for demonstration purposes)
            foreach (DataRow row in dataTable.Rows)
            {
                foreach (DataColumn col in dataTable.Columns)
                {
                    Console.Write($"{row[col]} ");
                }
                Console.WriteLine();
            }
        }

        private string getapiData(string url)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            WebRequest webrequest = WebRequest.Create(url);
            webrequest.Method = "GET";

            HttpWebResponse httpWebResponse = null;
            try
            {
                httpWebResponse = (HttpWebResponse)webrequest.GetResponse();

                using (Stream stream = httpWebResponse.GetResponseStream())
                {
                    StreamReader sr = new StreamReader(stream);
                    string response = sr.ReadToEnd();
                    sr.Close();
                    return response;
                }

            }
            catch (WebException ex)
            {

                Console.WriteLine("Error: " + ex.Message);
                return "Api Error";
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getResponse(ddlEmpCard.SelectedValue, ddlDepartment.SelectedValue);
        }

        private void ExportToExcel()
        {
            DataTable dt = (DataTable)ViewState["__IncrementEntittleData__"];
            GridView gv = new GridView();
            gv.DataSource = dt;
            gv.DataBind();
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", $"attachment;filename=EntitleReport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            Response.ContentEncoding = System.Text.Encoding.UTF8;

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    sw.WriteLine("<table>");
                    sw.WriteLine("<tr><td colspan='3'><b>Employee report of January</b></td></tr>");
                    sw.WriteLine("</table>");
                    sw.WriteLine("<br />");

                    gv.RenderControl(hw);
                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();
                }
            }
        }

       
        public override void VerifyRenderingInServerForm(Control control)
        {
            // No code needed here - just a required override for GridView rendering
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            ExportToExcel();
        }
    }
}