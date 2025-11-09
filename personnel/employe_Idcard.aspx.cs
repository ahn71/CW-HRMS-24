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

            foreach (DataRow row in dtEmployeInfo.Rows)
            {
                html.Append($@"
<div class='id-card-wrapper' style='display:flex; gap:20px; margin-bottom:25px; font-family:SutonnyMJ;'>
    <!-- FRONT SIDE -->
    <div style='width:320px; height:480px; border:1px solid #000; padding:12px; box-sizing:border-box;'>
        <div style='display:flex; justify-content:space-between; align-items:center; margin-bottom:8px;'>
            <img src='../EmployeeImages/CompanyLogo/logo.jpeg' style='width:60px; height:60px; object-fit:contain;' />
            <img src='{rootURL}/{companyId}/EmployeeImage/{row["EmpPicture"]}' 
                 style='width:85px; height:105px; object-fit:cover; border:1px solid #000;' />
        </div>

        <h2 style='text-align:center; margin:0; font-size:20px; font-weight:bold;'>H.we.Avi w¯úwbs wgjm wjt</h2>
        <h3 style='text-align:center; margin:5px 0 12px 0; font-size:18px; text-decoration:underline;'>cwiPqcÎ</h3>

        <table style='width:100%; font-size:14px; border-collapse:collapse;'>
            <tr><td style='padding:3px 6px; width:40%;'>AvBwW KvW© bs</td><td style='padding:3px 6px;'>: {row["EmpCardNo"]}</td></tr>
            <tr><td style='padding:3px 6px;'>k«wg‡Ki bvg</td><td style='padding:3px 6px;'>: {row["EmpNameBn"]}</td></tr>
            <tr><td style='padding:3px 6px;'>c`we</td><td style='padding:3px 6px;'>: {row["DsgNameBn"]}</td></tr>
            <tr><td style='padding:3px 6px;'>wefvM/kvLv</td><td style='padding:3px 6px;'>: {row["DptNameBn"]}</td></tr>
            <tr><td style='padding:3px 6px;'>‡hvM`v‡bi ZvwiL</td><td style='padding:3px 6px;'>: {Convert.ToDateTime(row["EmpJoiningDate"]).ToString("dd-MM-yyyy")}</td></tr>
            <tr><td style='padding:3px 6px;'>Bm¨yi ZvwiL</td><td style='padding:3px 6px;'>: {DateTime.Now.ToString("dd-MM-yyyy")}</td></tr>
        </table>

        <div style='display:flex; justify-content:space-around; margin-top:35px; font-size:13px;'>
            <div style='text-align:center;'>
                <div style='border-top:1px solid #000; width:110px; margin:auto;'>k«wg‡Ki ¯^v¶i/div>
            </div>
            <div style='text-align:center;'>
                <div style='border-top:1px solid #000; width:110px; margin:auto;'>KZ©…c‡¶i ¯^v¶i</div>
            </div>
        </div>
    </div>

    <!-- BACK SIDE -->
    <div style='width:320px; height:480px; border:1px solid #000; padding:15px; box-sizing:border-box; font-family:SutonnyMJ;'>
        <h3 style='text-align:center; font-size:18px; margin-bottom:3px;'>If Found Please</h3>
        <h3 style='text-align:center; font-size:18px; margin-bottom:12px;'>Return This Card To-</h3>

        <p style='text-align:center; font-size:16px; line-height:22px; margin-bottom:15px;'>
            কারখানার ঠিকানা <br/>
            গোধার, মির্জাপুর, টাঙ্গাইল।
        </p>

        <p style='font-size:14px; margin-bottom:12px;'>
            অফিস মোবাইল নং : ০১৮৬০-৩১২৩১৮
        </p>

        <h4 style='font-size:16px; margin-bottom:8px; text-decoration:underline;'>শ্রমিকের স্থায়ী ঠিকানা</h4>

        <table style='width:100%; font-size:14px; border-collapse:collapse;'>
            <tr><td style='padding:2px 6px; width:40%;'>গ্রাম</td><td style='padding:2px 6px;'>: {row["PerVillageBangla"]}</td></tr>
            <tr><td style='padding:2px 6px;'>ডাকঘর</td><td style='padding:2px 6px;'>: {row["PerPOBangla"]}</td></tr>
            <tr><td style='padding:2px 6px;'>থানা</td><td style='padding:2px 6px;'>: {row["PerThNameBn"]}</td></tr>
            <tr><td style='padding:2px 6px;'>জেলা</td><td style='padding:2px 6px;'>: {row["PerDstBangla"]}</td></tr>
        </table>

        <p style='font-size:14px; margin-top:14px;'>জরুরী ফোন নম্বর : {row["EmergencyPhoneNo"]}</p>
        <p style='font-size:14px;'>জাতি পরিচয় পত্র নং : {row["NationIDCardNo"]}</p>
        <p style='font-size:14px;'>রক্তের গ্রুপ : {row["BloodGroup"]}</p>
    </div>
</div>
");
            }


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