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
            var companyInfo = getComapnyInfo();
            foreach (DataRow row in dtEmployeInfo.Rows)
            {
                html.Append($@"
            
<div style='height:100vh' class='id-card-wrapper'>

<div class='id-card'>
                        <div class='header'>
                            <img src='../EmployeeImages/CompanyLogo/rdLogo.jpg' alt='Company Logo' class='logo'>
                        </div>
                        <div class='photo-container'>
                            <img src='../EmployeeImages/Images/{row["EmpPicture"].ToString()}' alt='Employee Photo' class='photo'>
                        </div>
                        <div class='details'>
                            <div class='name'>{row["EMpName"].ToString()}</div>
                            <div class='designation'>{row["DsgName"].ToString()}</div>
                        </div>
                        <div class='info'>
                            <div class='info-item'><strong>Blood Group:</strong>({row["BloodGroup"].ToString()})</div>
                            <div class='info-item'><strong>Emp. ID No.:</strong> {row["EmpCardNo"].ToString()}</div>
                        </div>
                        <div style='background-color:#0c4ca3 !important; margin-top: 19px !important; padding: 3px !important; display:block !important; color:#ffffff !important;' class='ft'>
                            <i style='color:#ffffff !important;'>Web: www.rdmilk.com</i>
                        </div>
                    </div>

                    <div class='backside_card'>
                        <div class='company-name'>{companyInfo.Name}</div>
                        <div class='address'>
                            <div class='address-title'>Address:</div>
                            <p>{companyInfo.Address}</p>
                            <p>Hotline : {companyInfo.Telephone}</p>
                            <p>Email : corporate@rdmilk.com.bd</p>
                        </div>
                        <div class='signature-section'>
                            <div class='signature-line'>
                                <img src='../EmployeeImages/Signature/={row["SignatureImage"].ToString()}' alt='Signature'>
                                <div class='signature-text'>Authorized Signature</div>
                            </div>
                        </div>
                        <div class='qr-code'>
                            <img style='height:60px' src='../EmployeeImages/CompanyLogo/QR.png' alt='QR Code'>
                        </div>
                        <div class='card-property'>
                            This card is the property of RDFPL
                        </div>
                    </div>

</div>



                ");
            }

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

        private (string Name, string Address, string Telephone) getComapnyInfo()
        {
            try
            {
                string query = "select CompanyName,Address,Telephone from hrd_companyInfo";
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable(query);
                if (dt.Rows.Count > 0) // Check if there are any rows to avoid exceptions.
                {
                    return (
                        dt.Rows[0]["CompanyName"].ToString(),
                        dt.Rows[0]["Address"].ToString(),
                        dt.Rows[0]["Telephone"].ToString()
                    );
                }
                else
                {
                    return (null, null, null);
                }
            }
            catch (Exception ex)
            {

                return (null, null, null);
            }

        }
    }
}