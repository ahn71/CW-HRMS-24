using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.personnel
{
    public partial class employee_profileview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)  
            {
                // Define an array of IDs
                string[] ids = { Request.QueryString["Id"].ToString()};

                foreach (string id in ids)
                {
                    loadEmpProfile(id);
                }
            }

        }

        private void loadEmpProfile(string empId)
        {
            DataTable dt = new DataTable();
            string query = @"select ved.EmpId, Empname,EmpCardNo,ved.FatherName,ved.mothername,ved.nationality,EMpProximityNo,Dsgname,DptName,EmpStatus,isnull(EmpPicture,'')as EmpPicture,SalaryType,EmpjoiningDate,Empstatusname,BloodGroup,ved.companyname,sftname,DateOfBirth,sex,type,rname,ea.Previllage,ea.pervillage,ea.Email,ea.prePostbox,ea.PerPostBox,isnull(thna_pre.ThaName,'') as PresntThana,isnull(thna_per.ThaName,'') as PermamnetThana,isnull(ee.Degree,'') as Degree,Isnull(ee.Year,'') as Year,Isnull(ee.Institute,'')as Institute,Isnull(ee.Result,'') as Result,Address,isnull(hdpre.dstname, '') as PreCity,isnull(hrdper.dstname, '') as PerCity,gname,ved.mobileNo,NationIDCardNo,ec.ContactName,ec.EmergencyAddress,ec.EmpRelation,ec.EmergencyPhoneNo,ec.Gender,ec.Age,ec.JobDescription
   from v_EmployeeDetails ved  left join Personnel_EmpAddress ea on ved.EmpId = ea.EmpId  left join Personnel_EmpEducation ee on ved.EmpId = ee.EmpId left join Personnel_EmpExperience eex on ved.EmpId = eex.EmpId left join hrdthanainfo thna_pre on ea.PreThanaId = thna_pre.thaId left join hrdthanainfo thna_per on ea.PerThanaId = thna_per.ThaId left join Hrd_District hdpre on ea.PreCity = hdpre.DstID left join Hrd_District hrdper on ea.percity = hrdper.DstID left join Personnel_EmergencyContact ec on ved.EmpId=ec.empId where ved.EmpId = '" + empId + "'";
            dt = CRUD.ExecuteReturnDataTable(query);
            string divInfo = "Profile Not Found";

            string image = dt.Rows[0]["EmpPicture"].ToString();
            if (image == "")
            {
             

                image = "../EmployeeImages/Images/rdNoImage.png";
            }
            else
            {
                string companyId = Session["__GetCompanyId__"].ToString();
                string rootUrl = Session["__RootUrl__"]?.ToString();

                string url = rootUrl + "/" + companyId + "/" + "EmployeeImage" + "/" + dt.Rows[0]["EmpPicture"].ToString();

                image = url;
            }

            divInfo = @"
<div class='employee-section'>
<table class='table py-5'>
    <tr>
        <td style='width:15%'>
            <div class='profile-header col-lg-2'>
                <img src=' " + image+ @"' alt='no image here'>
            </div>
        </td>
        <td style='width:85%'>
              <div class='profile-details col-lg-10'>
                <h2 class='mt-2'>" + dt.Rows[0]["Empname"] + @"</h2>
                  <p>" + dt.Rows[0]["Dsgname"] + @"</p>                 
                 <p><strong>Mobile:</strong> " + dt.Rows[0]["mobileNo"] + @"</p>
                 <p><strong>Email:</strong> " + dt.Rows[0]["Email"] + @"</p>
            </div>
        </td>
    </tr>
</table>
<div class='col-lg-12 d-flex justify-content-end'>
    <div class='person-info'>
        <button type='button' class='btn btn-success' onclick='window.print();' id='btnDownload'>
            <i class='fa fa-download'></i> Download
        </button>
    </div>
</div>
<div class='row'>
    <div class='col-md-12'>
        <div class='card'>
            <div style='background-color: #003873 !important;' class='card-header text-white'>
                Basic Information
            </div>
            <div class='card-body'>
                <table style='width: 100%;'>
                    <tr>

                        <td style='width:50%'>
                            <p><strong>Employee ID:</strong> " + dt.Rows[0]["EmpId"] + @"</p>
                         <p><strong>Employee Card:</strong>" + dt.Rows[0]["EmpCardNo"] + @"</p>
                         <p><strong>Department:</strong> " + dt.Rows[0]["DptName"] + @"</p>
                          <p><strong>Group: Type:</strong> " + dt.Rows[0]["gname"] + @"</p>
                           <p><strong>Shift Type:</strong> " + dt.Rows[0]["sftname"] + @"</p>
                        <p><strong>Joining Date:</strong> " + Convert.ToDateTime(dt.Rows[0]["EmpjoiningDate"]).ToString("dd-MM-yyyy") + @"</p>

                        <p><strong>EmpStatus:</strong>  " + dt.Rows[0]["Empstatusname"] + @"</p>
                        <p><strong>Salary Type:</strong> " + dt.Rows[0]["SalaryType"] + @"</p>
                        <p><strong>EmpProximityNo :</strong> " + dt.Rows[0]["EMpProximityNo"] + @"</p>

                           <p><strong>Date of Birth Type:</strong> " + Convert.ToDateTime(dt.Rows[0]["DateOfBirth"]).ToString("dd-MM-yyyy") + @"</p>
                       </td>
                         
                    <td style='width:50%'>
                        <p><strong>Blood Group:</strong> " + dt.Rows[0]["BloodGroup"] + @"</p>
                    

                        <p><strong>Father Name:</strong> " + dt.Rows[0]["FatherName"] + @"</p>
                        <p><strong>Mother Name :</strong> " + dt.Rows[0]["mothername"] + @"</p>
                        <p><strong>Nationality :</strong> " + dt.Rows[0]["nationality"] + @"</p>
                        <p><strong>Company Name:</strong> " + dt.Rows[0]["companyname"] + @"</p>
                       
                      
                        <p><strong>Gender Type:</strong> " + dt.Rows[0]["sex"] + @"</p>
                        <p><strong>Religion:</strong> " + dt.Rows[0]["rname"] + @"</p>
                        <p><strong>Employee Type:</strong> " + dt.Rows[0]["type"] + @"</p>
                        <p><strong>NationIDCardNo:</strong> " + dt.Rows[0]["NationIDCardNo"] + @"</p>
                        </td>

                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<table style='width: 100%;'>
    <tr>
        <td>
            <div class='col-md-12 p-0'>
                <div class='card'>
                    <div class='card-header bg-custom text-white'>
                        Present Address
                    </div>
                    <div class='card-body'>
                         <p><strong>Village:</strong>  " + dt.Rows[0]["Previllage"] + @"</p>
                            <p><strong>Post-Office:</strong> " + dt.Rows[0]["prePostbox"] + @"</p>
                            <p><strong>Thana:</strong> " + dt.Rows[0]["PermamnetThana"] + @"</p>
                            <p><strong>Zip Code:</strong> " + dt.Rows[0]["PerCity"] + @"</p>
                    </div>
                </div>
            </div>
        </td>
        <td>
            <div class='col-md-12 p-0'>
                <div class='card'>
                    <div class='card-header bg-custom text-white'>
                        Permanent Address
                    </div>
                    <div class='card-body'>
                       <p><strong>Street:</strong>  " + dt.Rows[0]["pervillage"] + @"</p>
                        <p><strong>City:</strong>  " + dt.Rows[0]["PerPostBox"] + @"</p>
                        <p><strong>State:</strong> " + dt.Rows[0]["PermamnetThana"] + @"</p>
                        <p><strong>State:</strong> " + dt.Rows[0]["PerCity"] + @"</p>
               
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>
<div class='col-md-12 p-0'>
    <div class='card'>
        <div class='card-header bg-custom text-white'>
            Emergency Contact
        </div>
        <div class='card-body'>
            <table style='width: 100%;'>
                <tr>
                    <td style='width:50%'>
                        <p><strong>Contact Name:</strong>" + dt.Rows[0]["ContactName"] + @" </p>
                        <p><strong>Relation:</strong> " + dt.Rows[0]["EmpRelation"] + @"</p>
                        <p><strong>Job Description:</strong> " + dt.Rows[0]["JobDescription"] + @"</p>
                    </td>
                    <td style='width:50%'>
                         <p><strong>Address:</strong> " + dt.Rows[0]["EmergencyAddress"] + @"</p>
                        <p><strong>Mobile No:</strong> " + dt.Rows[0]["EmergencyPhoneNo"] + @"</p>
                        <p><strong>Gender:</strong> " + dt.Rows[0]["Gender"] + @"</p>
                        <p><strong>Age:</strong> " + dt.Rows[0]["Age"] + @"</p>
                    </td>
                </tr>
            </table>            
        </div>
    </div>
</div>";
            string eduQuery = "Select Degree, Year, Institute, Result from Personnel_EmpEducation where EmpId='"+ empId + "'";
            DataTable eduDt = CRUD.ExecuteReturnDataTable(eduQuery);

            if (eduDt.Rows.Count > 0)  // Only add education section if data exists
            {
                divInfo += @"
    <div class='col-md-12 my-4 p-0'>
        <h2 class='py-3'>Educational Qualifications</h2>
        <table class='table table-bordered table-striped table-hover mt-3'>
            <thead class='table-blue'>
                <tr>
                    <th scope='col'>#</th>
                    <th scope='col'>Degree</th>
                    <th scope='col'>Institution</th>
                    <th scope='col'>Year of Graduation</th>
                    <th scope='col'>Grade/CGPA</th>
                </tr>
            </thead>
            <tbody>";

                for (int i = 0; i < eduDt.Rows.Count; i++)
                {
                    divInfo += @"
        <tr>
            <th scope='row'>" + (i + 1) + @"</th>
            <td>" + eduDt.Rows[i]["Degree"] + @"</td>
            <td>" + eduDt.Rows[i]["Institute"] + @"</td>
            <td>" + eduDt.Rows[i]["Year"] + @"</td>
            <td>" + eduDt.Rows[i]["Result"] + @"</td>
        </tr>
";
                }

                divInfo += @"
       </tbody>
    </table>
    </div>
</div>

";


                string expeQuery = "select Companyname, Designation, Responsibility, YearOfExp, JoiningDate, ResignDate, SpecialQualification from Personnel_EmpExperience where empID='"+ empId + "'";
                DataTable exdt = CRUD.ExecuteReturnDataTable(expeQuery);

                if (exdt.Rows.Count > 0)  // Only add experience section if data exists
                {
                    divInfo += @"
    <div class='col-md-12 my-4 p-0'>
        <h2 class='py-3'>Employee Experience</h2>
        <table class='table table-bordered table-striped table-hover mt-3'>
            <thead class='table-blue'>
                <tr>
                    <th scope='col'>#</th>
                    <th scope='col'>Name of Company</th>
                    <th scope='col'>Designation</th>
                    <th scope='col'>Responsibility</th>
                    <th scope='col'>Year of Experience</th>
                    <th scope='col'>Joining Date</th>
                    <th scope='col'>Resign Date</th>
                    <th scope='col'>Special Qualification</th>
                </tr>
            </thead>
            <tbody>";

                    for (int i = 0; i < exdt.Rows.Count; i++)
                    {
                        divInfo += @"
        <tr>
            <th scope='row'>" + (i + 1) + @"</th>
            <td>" + exdt.Rows[i]["Companyname"] + @"</td>
            <td>" + exdt.Rows[i]["Designation"] + @"</td>
            <td>" + exdt.Rows[i]["Responsibility"] + @"</td>
            <td>" + exdt.Rows[i]["YearOfExp"] + @"</td>
            <td>" + exdt.Rows[i]["JoiningDate"] + @"</td>
            <td>" + exdt.Rows[i]["ResignDate"] + @"</td>
            <td>" + exdt.Rows[i]["SpecialQualification"] + @"</td>
        </tr>";
                    }

                    divInfo += @"
       </tbody>
    </table>
</div>



";
                }


                   

            }

            divProfileView.Controls.Add(new LiteralControl(divInfo));
        }
    }
}
