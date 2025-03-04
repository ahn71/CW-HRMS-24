using adviitRuntimeScripting;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.personnel
{
    public partial class ImportEmployeInfo : System.Web.UI.Page
    {
        DataTable dt;
        private DataTable dtNewEmployees = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__dptID__"] = getCookies["__DptId__"].ToString();
                classes.commonTask.LoadBranch(ddlBranch, ViewState["__CompanyId__"].ToString());
                ddlBranch.SelectedValue = ViewState["__CompanyId__"].ToString();
                LoadCompanyInfo();
                InitializeDataTable();
            }

        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            if (fuEmployeesData.HasFile)
            {

                string filePath = Server.MapPath("~/AccessFile/") + fuEmployeesData.FileName;
                fuEmployeesData.SaveAs(filePath);

                DataTable dt = ReadExcel(filePath);
                ReadXL(dt);
            }
        }

        private DataTable ReadExcel(string filePath)
        {
            DataTable dt = new DataTable();

            // Enable EPPlus license (required in newer versions)
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            using (var package = new ExcelPackage(new FileInfo(filePath)))
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets[0];
                int rowCount = worksheet.Dimension.Rows;
                int colCount = worksheet.Dimension.Columns;

                if (rowCount < 2) return dt;


                for (int col = 1; col <= colCount; col++)
                {
                    dt.Columns.Add(worksheet.Cells[1, col].Text.Trim());
                }

                for (int row = 2; row <= rowCount; row++)
                {
                    DataRow dr = dt.NewRow();
                    for (int col = 1; col <= colCount; col++)
                    {
                        dr[col - 1] = worksheet.Cells[row, col].Text.Trim();
                    }
                    dt.Rows.Add(dr);
                }
            }
            return dt;
        }


        public void ReadXL(DataTable dtExcel)
        {
            try
            {

                foreach (DataRow row in dtExcel.Rows)
                {
                    string RegID = row["RegId"].ToString();
                    if (RegID.Trim().Length > 0)
                    {
                        try { int a = int.Parse(RegID); } catch (Exception ex) { continue; }
                    }
                    string Name = row["Name"].ToString();
                    string NameBn = row["BanglaName"].ToString();
                    string Department = row["Department"].ToString();
                    string Group = Department;
                    string Designation = row["Designation"].ToString();
                    string EmpType = row["EmpType"].ToString();
                    string JoiningDate = row["JoiningDate"].ToString();
                    string Gender = row["Gender"].ToString();
                    string NID = row["NID"].ToString();
                    string SalaryType = row["SalaryType"].ToString();
                    string Shift = row["Shift"].ToString();
                    string DutyType = row["DutyType"].ToString();
                    string WeekendType = row["WeekendType"].ToString();
                    string FathersName = row["FathersName"].ToString();
                    string MothersName = row["MothersName"].ToString();
                    string MaritialStatus = row["MaritialStatus"].ToString();
                    string DateOfBirth = row["DateOfBirth"].ToString();
                    string BloodGroup = row["BloodGroup"].ToString();
                    string Religion = row["Religion"].ToString();
                    string LastEducationqualification = row["LastEducationqualification"].ToString();
                    string TotalNumberOfExperience = row["TotalNumberOfExperience"].ToString();
                    string HusbandOrWifeName = row["HusbandOrWifeName"].ToString();
                    string TIN = row["TIN"].ToString();




                    string ContactNumber = row["ContactNumber"].ToString();
                    AutoGenerateEmpId();
                    string jjj = ViewState["__txtEmpCardNo__"].ToString();
                    if (RegID == "")
                        ViewState["__RegID__"] = ViewState["__txtRegistrationId__"].ToString();
                    else
                        ViewState["__RegID__"] = RegID;
                    ViewState["__Name__"] = Name;
                    ViewState["__NameBn__"] = NameBn;
                    ViewState["__NID__"] = NID;
                    ViewState["__ContactNumber__"] = ContactNumber;
                    ViewState["__DptID__"] = getDptID(Department);
                    ViewState["__DptName__"] = Department;
                    ViewState["__DsgID__"] = getDsgID(ViewState["__DptID__"].ToString(), Designation);
                    ViewState["__DsgName__"] = Designation;
                    ViewState["__GID__"] = getGID(ViewState["__DptID__"].ToString(), Group);
                    ViewState["__GrpName__"] = Group;
                    ViewState["__EmpTypeID__"] = (EmpType.ToLower() == "worker") ? "1" : "2";
                    ViewState["__EmpTypename__"] = EmpType.ToLower();
                    ViewState["__Gender__"] = Gender;
                    ViewState["__EmoContactNumber__"] = ContactNumber;
                    if (JoiningDate == "")
                        ViewState["__JoiningDate__"] = DateTime.Now.ToString("yyyy-MM-dd");
                    else
                        ViewState["__JoiningDate__"] = commonTask.ddMMyyyyTo_yyyyMMdd(JoiningDate);
                    ViewState["__salaryType__"] = (SalaryType == "Scale") ? 0 : (SalaryType == "Gross") ? 1 : 2;
                    ViewState["__SalaryTypenme__"] = SalaryType;

                    ViewState["__shift__"] = getShifttID(Shift, ViewState["__DptID__"].ToString());
                    ViewState["__ShfName__"] = Shift;
                    ViewState["__dutyType__"] = (DutyType == "Roster") ? "1" : "0";
                    ViewState["__dutyTypename__"] = DutyType;
                    ViewState["__weekendType__"] = (WeekendType == "Regular") ? "0" : "1";
                    ViewState["__WeekendTypeName__"] = WeekendType;

                    ViewState["__fatherName__"] = FathersName;
                    ViewState["__mothersName__"] = MothersName;
                    ViewState["__maritialStatus__"] = MaritialStatus;
                    if (DateOfBirth == "")
                    {
                        ViewState["__dateOfBirth__"] = DateTime.Now.ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        ViewState["__dateOfBirth__"] = commonTask.ddMMyyyyTo_yyyyMMdd(JoiningDate);
                    }
                    ViewState["__bloodGroup__"] = BloodGroup;
                    ViewState["__religion__"] = getReligionId(Religion);
                    ViewState["__ReligionName"] = Religion;
                    ViewState["__lastEducationQualification__"] = getLasEducationId(LastEducationqualification);
                    ViewState["__LastEducationName__"] = LastEducationqualification;
                    ViewState["__totalNumberOfExperience__"] = TotalNumberOfExperience;
                    ViewState["__HusbandOrWifeName__"] = HusbandOrWifeName;
                    ViewState["__TIN__"] = TIN;


                    bool isImport = ImportEmployeeInfo();

                    if (isImport)
                    {
                        StoreDataInGridview(ViewState["__EmpID__"].ToString(),"Success");
                    }
                    else
                    {
                        StoreDataInGridview(ViewState["__EmpID__"].ToString(),"Failed");
                    }



                }
            }
            catch (Exception ex)
            {

            }


        }

        private void LoadCompanyInfo()
        {
            DataTable dtcom = new DataTable();
            sqlDB.fillDataTable("Select CompanyName,StartCardNo,ShortName,CardNoType,FlatCode,CardNoDigits From HRD_CompanyInfo where CompanyId='" + ddlBranch.SelectedValue + "'", dtcom);
            ViewState["__CardNoType__"] = dtcom.Rows[0]["CardNoType"].ToString();
            ViewState["__FlatCode__"] = dtcom.Rows[0]["FlatCode"].ToString();
            ViewState["__ShortName__"] = dtcom.Rows[0]["ShortName"].ToString();
            ViewState["__StartCardNo__"] = dtcom.Rows[0]["StartCardNo"].ToString();
            ViewState["__CardNoDigits__"] = dtcom.Rows[0]["CardNoDigits"].ToString();
            hdfCardnoDigitsSet.Value = hdfCardnoDigits.Value = dtcom.Rows[0]["CardNoDigits"].ToString();
            //txtAlternativeCard.Style.Add("MaxLength", ViewState["__CardNoDigits__"].ToString().Length.ToString());
            //if (ViewState["__CardNoType__"].ToString().Equals("True"))
            //{
            //    cskDptWise.Checked = true;
            //    cskFlatOrder.Checked = false;
            //    cskDptWise.Visible = true;
            //    txtDptWise.Visible = true;
            //    cskFlatOrder.Visible = true;
            //    txtFlatOrder.Style.Add("Width", "39%");

            //}
            //else
            //{
            //    cskDptWise.Checked = false;
            //    cskFlatOrder.Checked = true;
            //    cskFlatOrder.Visible = false;
            //    txtDptWise.Visible = false;
            //    cskDptWise.Visible = false;
            //    txtFlatOrder.Style.Add("Width", "98%");
            //}
        }
        private void AutoGenerateEmpId()
        {
            try
            {


                DataTable dt = new DataTable();
                int CodeLeanth = ViewState["__FlatCode__"].ToString().Length;
                int startIndex = 8 + CodeLeanth;
                string cmd = "select max(convert(int,substring(EmpCardNo," + startIndex + ",15) ))as MaxCardNo,substring(EmpCardNo," + startIndex + ",15) as EmpCardNo from v_Personnel_EmpCurrentStatus  " +
                  "where CompanyId='" + ddlBranch.SelectedValue + "'  group by substring(EmpCardNo," + startIndex + ",15) having max(convert(int,substring(EmpCardNo," + startIndex + ",15) ))=(select max(convert(int,substring(EmpCardNo," + startIndex + ",15) )) from v_Personnel_EmpCurrentStatus  " +
                  "where CompanyId='" + ddlBranch.SelectedValue + "')";
                sqlDB.fillDataTable(cmd, dt);
                //sqlDB.fillDataTable("select max(convert(int,substring(EmpCardNo," + startIndex + ",15) ))as MaxCardNo from v_Personnel_EmpCurrentStatus   where CompanyId='" + ddlBranch.SelectedValue + "' ", dt);
                if (dt.Rows.Count < 1 || dt.Rows[0]["MaxCardNo"].ToString() == "")
                {
                    ViewState["__txtEmpCardNo__"] =  ViewState["__ShortName__"].ToString() + DateTime.Now.Year + ViewState["__FlatCode__"].ToString() + ViewState["__StartCardNo__"].ToString();
                    ViewState["__txtRegistrationId__"] =  ViewState["__FlatCode__"].ToString() + ViewState["__StartCardNo__"].ToString();
                }
                else
                {
                    string NewCardNo = "";
                    string MaxCardNo = dt.Rows[0]["EmpCardNo"].ToString();
                    if (MaxCardNo.ToString().Length > int.Parse(hdfCardnoDigits.Value))
                        hdfCardnoDigits.Value = MaxCardNo.ToString().Length.ToString();
                    NewCardNo = (int.Parse(MaxCardNo) + 1).ToString();
                    if (hdfCardnoDigits.Value.ToString() == "3")
                    {
                        if (NewCardNo.Length == 1) NewCardNo = "00" + NewCardNo;
                        else if (NewCardNo.Length == 2) NewCardNo = "0" + NewCardNo;
                    }
                    else if (hdfCardnoDigits.Value.ToString() == "4")
                    {
                        if (NewCardNo.Length == 1) NewCardNo = "000" + NewCardNo;
                        else if (NewCardNo.Length == 2) NewCardNo = "00" + NewCardNo;
                        else if (NewCardNo.Length == 3) NewCardNo = "0" + NewCardNo;
                    }
                    else if (hdfCardnoDigits.Value.ToString() == "5")
                    {
                        if (NewCardNo.Length == 1) NewCardNo = "0000" + NewCardNo;
                        else if (NewCardNo.Length == 2) NewCardNo = "000" + NewCardNo;
                        else if (NewCardNo.Length == 3) NewCardNo = "00" + NewCardNo;
                        else if (NewCardNo.Length == 4) NewCardNo = "0" + NewCardNo;
                    }
                    else if (hdfCardnoDigits.Value.ToString() == "6")
                    {
                        if (NewCardNo.Length == 1) NewCardNo = "00000" + NewCardNo;
                        else if (NewCardNo.Length == 2) NewCardNo = "0000" + NewCardNo;
                        else if (NewCardNo.Length == 3) NewCardNo = "000" + NewCardNo;
                        else if (NewCardNo.Length == 4) NewCardNo = "00" + NewCardNo;
                        else if (NewCardNo.Length == 5) NewCardNo = "0" + NewCardNo;
                    }
                    ViewState["__txtEmpCardNo__"] = ViewState["__ShortName__"].ToString() + DateTime.Now.Year + ViewState["__FlatCode__"].ToString() + NewCardNo;
                    ViewState["__txtRegistrationId__"] = ViewState["__FlatCode__"].ToString() + NewCardNo;
                }
            }
            catch { }
        }

        private string getDptID(string DptName)
        {

            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select DptId from HRD_Department where DptName='" + DptName + "'");
            if (dt == null || dt.Rows.Count == 0)
            {
                CRUD.Execute("insert into HRD_Department values('" + classes.commonTask.LoadSL("Select Max(Sl) as SL from HRD_Department", "Department") + "','" + ddlBranch.SelectedValue + "','" + DptName + "',N'','',1,0,0) ");
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable("select DptId from HRD_Department where DptName='" + DptName + "'");
            }
            return dt.Rows[0]["DptId"].ToString();
        }

        private string getShifttID(string shfName, string DptId)
        {

            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select SftId from Hrd_shift where DptName='" + shfName + "' and DptId='" + DptId + "'");
            if (dt == null || dt.Rows.Count == 0)
            {
                CRUD.Execute("insert into Hrd_shift(SftName,companyId,DptId) values('" + shfName + "','" + ddlBranch.SelectedValue + "','" + DptId + "') ");
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable("select SftId from Hrd_shift where SftName='" + shfName + "'");
            }
            return dt.Rows[0]["SftId"].ToString();
        }
        private string getReligionId(string Rname)
        {
            dt = new DataTable();
            string query = " select RId,RName from HRD_Religion where RName='" + Rname + "'";
            dt = CRUD.ExecuteReturnDataTable(query);
            if (dt == null || dt.Rows.Count == 0)
            {

                CRUD.Execute("insert into HRD_Religion(RName) values('" + Rname + "',') ");
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable("select SftId from HRD_Religion where RName='" + Rname + "'");
            }
            return dt.Rows[0]["RId"].ToString();
        }

        private string getLasEducationId(string lastEducation)
        {
            dt = new DataTable();
            string query = "select Qid, QName, CompanyId from HRD_Qualification where QName='" + lastEducation + "' ";
            dt = CRUD.ExecuteReturnDataTable(query);
            if (dt == null || dt.Rows.Count == 0)
            {
                CRUD.Execute("insert into HRD_Qualification(QName) values('" + lastEducation + "',') ");
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable("select Qid from HRD_Qualification where QName='" + lastEducation + "'");
            }
            return dt.Rows[0]["Qid"].ToString();
        }
        private string getDsgID(string DptId, string DsgName)
        {

            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select DsgId from HRD_Designation where DptId='" + DptId + "' and  DsgName='" + DsgName + "'");
            if (dt == null || dt.Rows.Count == 0)
            {
                CRUD.Execute("insert into HRD_Designation(DsgId, DptId, DsgName, DsgStatus, Ordering) values('" + classes.commonTask.LoadSL("Select Max(SL) as SL From HRD_Designation", "Designation") + "', '" + DptId + "','" + DsgName + "',1,0) ");
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable("select DsgId from HRD_Designation where DptId='" + DptId + "' and  DsgName='" + DsgName + "'");
            }
            return dt.Rows[0]["DsgId"].ToString();
        }
        private string getGID(string DptId, string GName)
        {

            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select GID from HRD_Group where DptId='" + DptId + "' and  GName='" + GName + "'");
            if (dt == null || dt.Rows.Count == 0)
            {
                CRUD.Execute("insert into HRD_Group(DptId,CompanyId, GName, IsActive) values('" + DptId + "','" + ddlBranch.SelectedValue + "' ,'" + GName + "',1)");
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable("select GID from HRD_Group where DptId='" + DptId + "' and  GName='" + GName + "'");
            }
            return dt.Rows[0]["GID"].ToString();
        }

        private Boolean ImportEmployeeInfo()
        {
            try
            {

                System.Data.SqlTypes.SqlDateTime getDate;
                getDate = SqlDateTime.Null;
                string EmpId = LoadEmpId();
                ViewState["__EmpID__"] = EmpId;
                SqlCommand cmd = new SqlCommand("saveEmployeeInfo", sqlDB.connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpId", EmpId);
                cmd.Parameters.AddWithValue("@CompanyId", ddlBranch.SelectedValue);
                cmd.Parameters.AddWithValue("@EmpTypeId",Convert.ToInt32(ViewState["__EmpTypeID__"].ToString()));
                cmd.Parameters.AddWithValue("@EmpName", ViewState["__Name__"].ToString());
                cmd.Parameters.AddWithValue("@NickName", ViewState["__Name__"].ToString());
                cmd.Parameters.AddWithValue("@EmpNameBn", ViewState["__NameBn__"].ToString()); // add kora lagbe
                cmd.Parameters.AddWithValue("@EmpCardNo", ViewState["__txtEmpCardNo__"].ToString());
                cmd.Parameters.AddWithValue("@EmpProximityNo", ViewState["__RegID__"].ToString());
                cmd.Parameters.AddWithValue("@PunchType", 0);
                cmd.Parameters.AddWithValue("@RealProximityNo", ViewState["__RegID__"].ToString());
                cmd.Parameters.AddWithValue("@EmpStatus", "1");
                cmd.Parameters.AddWithValue("@SftId", ViewState["__shift__"].ToString());
                cmd.Parameters.AddWithValue("@EmpJoiningDate", ViewState["__JoiningDate__"].ToString());
                cmd.Parameters.AddWithValue("@ShiftTransferDate", ViewState["__JoiningDate__"].ToString());
                cmd.Parameters.AddWithValue("@EarnedLeave",0);
              
               cmd.Parameters.AddWithValue("@EarnedLeaveEffectedFrom", getDate);
               cmd.Parameters.AddWithValue("@EmpPicture", "");
               cmd.Parameters.AddWithValue("@SignatureImage", "");
               cmd.Parameters.AddWithValue("@Type", "");
               cmd.Parameters.AddWithValue("@ExpireDate", getDate);
               cmd.Parameters.AddWithValue("@PreCompanyId", ddlBranch.SelectedValue);
                cmd.Parameters.AddWithValue("@PreEmpTypeId", 0);



                cmd.Parameters.AddWithValue("@PreDptId", ViewState["__DptID__"].ToString());
                cmd.Parameters.AddWithValue("@DptId", ViewState["__DptID__"].ToString());


                cmd.Parameters.AddWithValue("@PreDsgId", ViewState["__DsgID__"].ToString());
                cmd.Parameters.AddWithValue("@DsgId", ViewState["__DsgID__"].ToString());
                cmd.Parameters.AddWithValue("@PreGId", ViewState["__GID__"].ToString());
                cmd.Parameters.AddWithValue("@GId", ViewState["__GID__"].ToString());
                cmd.Parameters.AddWithValue("@PreEmpStatus", "1");


                cmd.Parameters.AddWithValue("@DateofUpdate", DateTime.Now.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@TypeOfChange", "s");
                cmd.Parameters.AddWithValue("@EffectiveMonth", "");
                cmd.Parameters.AddWithValue("@OrderRefNo", "");
                cmd.Parameters.AddWithValue("@OrderRefDate", getDate);
                cmd.Parameters.AddWithValue("@Remarks", "");
                cmd.Parameters.AddWithValue("@ActiveSalary", 1);
                cmd.Parameters.AddWithValue("@EarnLeaveDate", ViewState["__JoiningDate__"].ToString());
                cmd.Parameters.AddWithValue("@IsActive", 1);
                //if (cskFlatOrder.Checked == true)
                //    cmd.Parameters.AddWithValue("@CustomOrdering", txtFlatOrder.Text.Trim());
                //else
                    cmd.Parameters.AddWithValue("@CustomOrdering", 0);

                cmd.Parameters.AddWithValue("@TIN", ViewState["__TIN__"].ToString());  //take from excel
                cmd.Parameters.AddWithValue("@PreSalaryType", ViewState["__salaryType__"].ToString());
                cmd.Parameters.AddWithValue("@SalaryType", ViewState["__salaryType__"].ToString());

                cmd.Parameters.AddWithValue("@PreEmpDutyType", ViewState["__dutyType__"].ToString());
                cmd.Parameters.AddWithValue("@EmpDutyType", ViewState["__dutyType__"].ToString());
                cmd.Parameters.AddWithValue("@AuthorizedPerson", true);
                cmd.Parameters.AddWithValue("@WeekendType", ViewState["__weekendType__"].ToString());

                int result = (int)cmd.ExecuteScalar();



                if (result > 0)
                {
                    CRUD.Execute("Insert into  Personnel_EmpPersonnal (EmpId,Sex,NationIDCardNo,DateOfBirth,BloodGroup,LastEdQualification,NoOfExperience,MaritialStatus,FatherName,MotherName,RId,HusbandOrWifeName) values ('" + EmpId + "','" + ViewState["__Gender__"].ToString() + "','" + ViewState["__NID__"].ToString() + "','" + ViewState["__dateOfBirth__"].ToString() + "','" + ViewState["__bloodGroup__"].ToString() + "','" + ViewState["__lastEducationQualification__"].ToString() + "','" + ViewState["__totalNumberOfExperience__"].ToString() + "','" + ViewState["__maritialStatus__"].ToString() + "','" + ViewState["__fatherName__"].ToString() + "','" + ViewState["__mothersName__"].ToString() + "','" + ViewState["__religion__"].ToString() + "','" + ViewState["__HusbandOrWifeName__"].ToString() + "') ");

                    if (ViewState["__EmoContactNumber__"].ToString() != "")
                    {
                        //saveEmpAddress(EmpId, ViewState["__EmoContactNumber__"].ToString());
                        CRUD.Execute("Insert into Personnel_EmpAddress(EmpId, MobileNo) values('" + EmpId + "', '" + ViewState["__EmoContactNumber__"].ToString() + "') ");
                    }

               

                }
                else {
                    return false;
                  }
               

                return true;

            }
            catch (Exception ex)
            {

                lblMessage.InnerText = "error->" + ex.Message;
                return false;
           
            }
        }

        private string LoadEmpId()
        {
            try
            {
                string EMPID = "";
                DataTable dt = new DataTable();
                sqlDB.fillDataTable("Select Max(SL) as SL From Personnel_EmployeeInfo", dt);
                if (dt.Rows[0]["SL"].ToString() == "")
                {
                    EMPID = "00000001";
                }
                else
                {
                    DataTable dtEMPID = new DataTable();
                    sqlDB.fillDataTable("Select EmpId From Personnel_EmployeeInfo where SL=" + dt.Rows[0]["SL"].ToString() + "", dtEMPID);

                    string ID = int.Parse(dtEMPID.Rows[0]["EmpId"].ToString()).ToString();
                    if (ID.Length == 1) EMPID = "0000000" + (int.Parse(ID) + 1);
                    else if (ID.Length == 2) EMPID = "000000" + (int.Parse(ID) + 1);
                    else if (ID.Length == 3) EMPID = "00000" + (int.Parse(ID) + 1);
                    else if (ID.Length == 4) EMPID = "0000" + (int.Parse(ID) + 1);
                    else if (ID.Length == 5) EMPID = "000" + (int.Parse(ID) + 1);
                    else if (ID.Length == 6) EMPID = "00" + (int.Parse(ID) + 1);
                    else if (ID.Length == 7) EMPID = "0" + (int.Parse(ID) + 1);
                    else if (ID.Length == 8) EMPID = (int.Parse(ID) + 1).ToString();

                }
                return EMPID;
            }
            catch { return ""; }
        }

        private void InitializeDataTable()
        {
            dtNewEmployees.Columns.Add("Status", typeof(string));
            dtNewEmployees.Columns.Add("RegId", typeof(string));
            dtNewEmployees.Columns.Add("Name", typeof(string));
            dtNewEmployees.Columns.Add("BanglaName", typeof(string));
            dtNewEmployees.Columns.Add("Department", typeof(string));
            dtNewEmployees.Columns.Add("Designation", typeof(string));
            dtNewEmployees.Columns.Add("EmpType", typeof(string));
            dtNewEmployees.Columns.Add("SalaryType", typeof(string));
            dtNewEmployees.Columns.Add("Shift", typeof(string));
            dtNewEmployees.Columns.Add("DutyType", typeof(string));
            dtNewEmployees.Columns.Add("WeekendType", typeof(string));
            dtNewEmployees.Columns.Add("JoiningDate", typeof(string));
            dtNewEmployees.Columns.Add("Gender", typeof(string));
            dtNewEmployees.Columns.Add("NID", typeof(string));
            dtNewEmployees.Columns.Add("FathersName", typeof(string));
            dtNewEmployees.Columns.Add("MothersName", typeof(string));
            dtNewEmployees.Columns.Add("MaritalStatus", typeof(string));
            dtNewEmployees.Columns.Add("HusbandOrWifeName", typeof(string));
            dtNewEmployees.Columns.Add("DateOfBirth", typeof(string));
            dtNewEmployees.Columns.Add("BloodGroup", typeof(string));
            dtNewEmployees.Columns.Add("Religion", typeof(string));
            dtNewEmployees.Columns.Add("LastEducationQualification", typeof(string));
            dtNewEmployees.Columns.Add("TotalNumberOfExperience", typeof(int));
            dtNewEmployees.Columns.Add("ContactNumber", typeof(string));
            dtNewEmployees.Columns.Add("TIN", typeof(string));
         
        }

        private void StoreDataInGridview(string EmpId,string status)
        {
            if (dtNewEmployees.Columns.Count == 0)  // Ensure DataTable is initialized
            {
                InitializeDataTable();
            }

            DataRow row = dtNewEmployees.NewRow();
            row["Status"] = status;
            row["RegId"] = ViewState["__RegID__"].ToString(); 
            row["Name"] = ViewState["__Name__"].ToString();
            row["BanglaName"] = ViewState["__NameBn__"].ToString(); 
            row["Department"] = ViewState["__DptName__"].ToString(); ;
            row["Designation"] = ViewState["__DsgName__"].ToString();
            row["EmpType"] = ViewState["__EmpTypename__"].ToString(); ;  
            row["SalaryType"] = ViewState["__SalaryTypenme__"].ToString();
            row["Shift"] = ViewState["__ShfName__"].ToString();
            row["DutyType"] = ViewState["__dutyTypename__"].ToString(); 
            row["WeekendType"] = ViewState["__WeekendTypeName__"].ToString();
            row["JoiningDate"] = ViewState["__JoiningDate__"].ToString(); 
            row["Gender"] = ViewState["__Gender__"].ToString(); 
            row["NID"] = ViewState["__NID__"].ToString(); 
            row["FathersName"] =ViewState["__fatherName__"].ToString(); 
            row["MothersName"] = ViewState["__mothersName__"].ToString(); 
            row["MaritalStatus"] = ViewState["__maritialStatus__"].ToString(); ;
            row["HusbandOrWifeName"] = ViewState["__HusbandOrWifeName__"].ToString(); 
            row["DateOfBirth"] = ViewState["__dateOfBirth__"].ToString();
            row["BloodGroup"] = ViewState["__bloodGroup__"].ToString(); 
            row["Religion"] = ViewState["__ReligionName"].ToString(); 
            row["LastEducationQualification"] = ViewState["__LastEducationName__"].ToString(); 
            row["TotalNumberOfExperience"] = ViewState["__totalNumberOfExperience__"].ToString(); 
            row["ContactNumber"] = ViewState["__ContactNumber__"].ToString(); 
            row["TIN"] = ViewState["__TIN__"].ToString();  
     

            dtNewEmployees.Rows.Add(row);  // ✅ Add row to DataTable

            // Bind to GridView (Optional)
            gvemployeList.DataSource = dtNewEmployees;
            gvemployeList.DataBind();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            ExportGridViewToExcel();
        }
        private void ExportGridViewToExcel()
        {
            using (ExcelPackage excel = new ExcelPackage())
            {
                ExcelWorksheet worksheet = excel.Workbook.Worksheets.Add("Employee Data");

                // Convert GridView to DataTable
                DataTable dt = new DataTable();

                // Add column headers
                foreach (TableCell cell in gvemployeList.HeaderRow.Cells)
                {
                    dt.Columns.Add(cell.Text);
                }

                // Add rows
                foreach (GridViewRow row in gvemployeList.Rows)
                {
                    DataRow dr = dt.NewRow();
                    for (int i = 0; i < row.Cells.Count; i++)
                    {
                        string cellText = row.Cells[i].Text.Trim();

                        // Replace &nbsp; with an empty string
                        if (cellText == "&nbsp;")
                        {
                            cellText = "";
                        }

                        dr[i] = cellText;
                    }
                    dt.Rows.Add(dr);
                }

                // Load DataTable into Excel
                worksheet.Cells["A1"].LoadFromDataTable(dt, true);

                // 🟢 Format SECOND column (Column B) as TEXT to keep leading zeros
                int regColumnIndex = 2; // Column B (1-based index)
                worksheet.Column(regColumnIndex).Style.Numberformat.Format = "@"; // Format as Text

                // Apply styles to the header row
                using (ExcelRange range = worksheet.Cells["A1:Z1"])
                {
                    range.Style.Font.Bold = true;
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    range.Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.LightGray);
                }

                // Auto-fit columns
                worksheet.Cells.AutoFitColumns();

                // Send Excel file to browser for download
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=EmployeeData.xlsx");

                using (MemoryStream ms = new MemoryStream())
                {
                    excel.SaveAs(ms);
                    ms.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }



        // This is required to avoid the "GridView must be placed inside a form tag with runat=server" error
        public override void VerifyRenderingInServerForm(Control control)
        {
            // Do nothing, just override
        }
    }
}