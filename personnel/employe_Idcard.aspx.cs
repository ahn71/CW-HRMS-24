using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.personnel
{
    public partial class employe_Idcard : System.Web.UI.Page
    {
        DataTable dt=new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployeCard();
            }
        }

        private void LoadEmployeCard()

        {
            StringBuilder html = new StringBuilder();
         

            DataTable dtEmployeInfo = (DataTable)Session["__WorkerID__"];
            string rootURL = System.Configuration.ConfigurationManager.AppSettings["rootURLForAPI"];
            string companyId = Session["__GetCompanyId__"].ToString();

           

            var companyInfo = getComapnyInfo();
            html.Append(@"<div class='wrapperx'>
                <div class='grid-container'>");

            foreach (DataRow row in dtEmployeInfo.Rows)
            {
                string jjj = row["EmpJoiningDate"].ToString();
                string signatureFile = row["SignatureImage"]?.ToString();

                DateTime date = DateTime.TryParseExact(row["EmpJoiningDate"].ToString(),
                    new[] { "dd-MM-yyyy", "MM-dd-yyyy", "yyyy-MM-dd", "yyyy/MM/dd", "dd/MM/yyyy", "MM/dd/yyyy" },
                    System.Globalization.CultureInfo.InvariantCulture,
                    System.Globalization.DateTimeStyles.None, out DateTime d) ? d : DateTime.MinValue;

                html.Append($@"
    <div class='id-card-wrapper'>
        
        <!-- FRONT SIDE -->
        <div class='id-card'>
            <div class='card-header'>
                <img src='../EmployeeImages/CompanyLogo/logo.jpeg' 
                     style='width:60px; height:60px; object-fit:contain; 
                     -webkit-print-color-adjust: exact; print-color-adjust: exact;' />
                <img src='{rootURL}/{companyId}/EmployeeImage/{row["EmpPicture"]}' 
                     style='width:76px; height:88px; object-fit:cover; border:1px solid #000;
                     -webkit-print-color-adjust: exact; print-color-adjust: exact;' />
            </div>

            <h2 style='text-align:center; margin:0; font-size:25px; font-weight:normal; 
                color:#0070c0 !important; 
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>{row["AddressBangla"]}</h2>
            
            <h3 style='text-align:center; margin:5px 0 12px 0; font-size:26px; font-weight:bold; 
                text-decoration:underline; color:#215868 !important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>cwiPqcÎ</h3>

            <table class='id-card-table'>
                <tr>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>AvBwW KvW© bs</td>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>: {row["EmpCardNo"]}</td>
                </tr>
                <tr>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>k«wg‡Ki bvg</td>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>:  {row["EmpNameBn"]}</td>
                </tr>
                <tr>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>c`we</td>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>: {row["DsgNameBn"]}</td>
                </tr>
                <tr>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>wefvM / kvLv</td>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>: {row["DptNameBn"]}</td>
                </tr>
                <tr>
                    <td style='color:#4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>‡hvM`v‡bi ZvwiL</td>
                    <td style='color:#4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>: {date:dd-MM-yyyy}</td>
                </tr>
                <tr>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>Bm¨yi ZvwiL</td>
                    <td style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>: {DateTime.Now:dd-MM-yyyy}</td>
                </tr>
            </table>



            <div class='footasr' style=' -webkit-print-color-adjust: exact; print-color-adjust: exact;''>
                <div><img style='height:30px; width:100%; {(string.IsNullOrEmpty(signatureFile) ? "opacity:0;" : "")}' 
             src='{rootURL}/{companyId}/EmployeeSignature/{signatureFile}'/>

                <div style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>
                   k«wg‡Ki ¯^v¶i</div>
              </div>


                <div><img style='height:30px; width:100%; opacity:0;' src='https://localhost:7220/0001/EmployeeSignature/{row["SignatureImage"]}'/> <div style='color: #4e587e!important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important;'>KZ©…c‡¶i ¯^v¶i</div></div>
            </div>
        </div>

        <!-- BACK SIDE -->
        <div class='id-card id-card-back'>
            <h3 style='text-align:center; font-size:16px; margin-bottom:10px; font-family:Cursive; 
                color:#1f4267 !important;
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important; margin-bottom:10px;'>If Found Please Return </br> This Card To-</h3>
            
            

            <p style='text-align:center; font-size:16px; line-height:22px; margin-bottom:15px; 
               color:#0070c0 !important;
               -webkit-print-color-adjust: exact !important; 
               print-color-adjust: exact !important;'>
                কারখানার ঠিকানা<br/>
                গোধার, মির্জাপুর, টাঙ্গাইল।
            </p>

            <p style='font-size:16px; margin-bottom:12px;'>Awdm ‡gvevBj bs : ০১৮৬০-৩১২৩১৮</p>
            
            <h4 style='font-size:16px; margin-bottom:8px; text-decoration:underline; font-weight:bold;'>kÖwg‡Ki ¯’vqx wVKvbv</h4>

            <table class='id-card-table'>
                <tr>
                    <td>MÖvg</td>
                    <td>: {row["PerVillageBangla"]}</td>
                </tr>
                <tr>
                    <td>WvKNi</td>
                    <td>: {row["PerPOBangla"]}</td>
                </tr>
                <tr>
                    <td>_vbv</td>
                    <td>: {row["PerThNameBn"]}</td>
                </tr>
                <tr>
                    <td>‡Rjv</td>
                    <td>: {row["PerDstBangla"]}</td>
                </tr>
                <tr>
                    <td>Riæix †dvb b¤^i</td>
                    <td>: {row["EmergencyPhoneNo"]}</td>
                </tr>
                <tr>
                    <td>Rvt cwitcÎ bs</td>
                    <td>: {row["NationIDCardNo"]}</td>
                </tr>
                <tr>
                    <td>i‡³i Mªc</td>
                    <td>: {row["BloodGroup"]}</td>
                </tr>
            </table>
        </div>
    </div>
");
            }

            html.Append(@"</div></div>");

































            //            foreach (DataRow row in dtEmployeInfo.Rows)
            //            {
            //                html.Append($@"

            //<div style='height:100vh' class='id-card-wrapper'>

            //<div class='id-card'>
            //                        <div class='header'>
            //                            <img src='../EmployeeImages/CompanyLogo/logo.jpeg' alt='Company Logo' class='logo'>
            //                        </div>
            //                        <div class='photo-container'>
            //                            <img src='{rootURL}//{companyId}//EmployeeImage//{row["EmpPicture"].ToString()}' alt='Employee Photo' class='photo'>
            //                        </div>
            //                        <div class='details'>
            //                            <div class='name' style='font-family:SutonnyMJ;'>{row["EmpNameBn"].ToString()}</div>
            //                            <div class='designation' style='font-family:SutonnyMJ;'>{row["DsgNameBn"].ToString()}</div>
            //                        </div>
            //                        <div class='info'>
            //                            <div class='info-item'><strong style='font-family:SutonnyMJ;'>i‡³i Mªc :</strong>({row["BloodGroup"].ToString()})</div>
            //                            <div class='info-item'><strong>Emp. ID No.:</strong> {row["EmpCardNo"].ToString()}</div>
            //                        </div>
            //                        <div style='background-color:#0c4ca3 !important; margin-top: 19px !important; padding: 3px !important; display:block !important; color:#ffffff !important;' class='ft'>
            //                            <i style='color:#ffffff !important;'>Web: www.rdmilk.com</i>
            //                        </div>
            //                    </div>

            //                    <div class='backside_card'>
            //                        <div class='company-name' style='font-family:SutonnyMJ;'>{companyInfo.CompanyNameBangla}</div>
            //                        <div class='address'>
            //                            <div class='address-title' style='font-family:SutonnyMJ;'>KviLvbvi wVKvbv:</div>
            //                            <p style='font-family:SutonnyMJ;'>{companyInfo.AddressBangla}</p>
            //                            <p>Hotline : {companyInfo.Telephone}</p>
            //                        </div>
            //                        <div class='signature-section'>
            //                            <div class='signature-line'>
            //                                <img src='{rootURL}//{companyId}//EmployeeSignature//{row["SignatureImage"].ToString()}' alt='Signature'>
            //                                <div class='signature-text'>Authorized Signature</div>
            //                            </div>
            //                        </div>
            //                        <div class='qr-code'>
            //                            <img style='height:60px' src='../EmployeeImages/CompanyLogo/QR.png' alt='QR Code'>
            //                        </div>
            //                        <div class='card-property'>
            //                            This card is the property of RDFPL
            //                        </div>
            //                    </div>

            //</div>



            //                ");
            //            }

            ltlEmployeeCards.Text = html.ToString();
        }

        private DataTable employeInfo()
        {
            try
            {
                string query = "select ei.EMpName,isnull(ei.EmpPicture,'') as EmpPicture,ep.BloodGroup,dsg.DsgName,ei.EmpCardNo,ei.SignatureImage from Personnel_EmployeeInfo ei inner join  personnel_emppersonnal ep on ei.EmpId=ep.EmpId inner join personnel_EmpCurrentstatus ecs on ep.EmpId=ecs.EmpId inner join hrd_designation dsg on ecs.DsgId=dsg.DsgId where ecs.Isactive=1";
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable(query);
                if (dt.Rows.Count > 0)
                {
                    return dt;

                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {

                return null;
            }


        }

        private (string CompanyName, string CompanyNameBangla, string AddressBangla, string Address, string Telephone) getComapnyInfo()
        {
            try
            {
                string query = "SELECT CompanyName, CompanyNameBangla, AddressBangla, Address, Telephone FROM hrd_companyInfo";
                DataTable dt = CRUD.ExecuteReturnDataTable(query);

                if (dt.Rows.Count > 0)
                {
                    return (
                        dt.Rows[0]["CompanyName"].ToString(),
                        dt.Rows[0]["CompanyNameBangla"].ToString(),
                        dt.Rows[0]["AddressBangla"].ToString(),
                        dt.Rows[0]["Address"].ToString(),
                        dt.Rows[0]["Telephone"].ToString()
                    );
                }

                return (null, null, null, null, null);
            }
            catch
            {
                return (null, null, null, null, null);
            }
        }

    }
}