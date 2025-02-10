using adviitRuntimeScripting;
using ComplexScriptingSystem;
using Newtonsoft.Json;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.hrms.settings
{
    public partial class companySetup : System.Web.UI.Page
    {
        static string imageName;
        string HeadOfficeId;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            divMsg.InnerText = "";
            lblMessage.InnerText = "";
            if (!IsPostBack)
            {
                //ViewState["__ReadAction__"] = "0";
                //ViewState["__WriteAction__"] = "0";
                //ViewState["__UpdateAction__"] = "0";
                //ViewState["__DeletAction__"] = "0";

                //int[] pagePermission = { 235, 236, 237, 238 };
                //int[] userPagePermition = AccessControl.hasPermission(pagePermission);
                //if (!userPagePermition.Any())
                //    Response.Redirect(Routing.defualtUrl);
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                //ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "CompanyInfo.aspx", gvCompanyInfo, btnSave);
                //setPrivilege(userPagePermition);
                loadCompanyInfoInfo();
                LoadCompanyId();
                LoadBusinessType();
                ViewState["__BranchType__"] = classes.commonTask.HasBranch();
                if (ViewState["__BranchType__"].ToString().Equals("False"))
                {
                    if (gvCompanyInfo.Rows.Count > 0)
                    {
                        btnSave.Enabled = false;

                    }
                    rblOfficeType.Enabled = false;
                }
            }
        }

        private void LoadBusinessType()
        {
            try
            {
                DataTable dt = new DataTable();
                sqlDB.fillDataTable("select * from HRD_BusinessType where IsActive='1'", dt);
                ddlBusinessType.DataValueField = "BId";
                ddlBusinessType.DataTextField = "BTypeName";
                ddlBusinessType.DataSource = dt;
                ddlBusinessType.DataBind();
                ddlBusinessType.Items.Insert(0, new ListItem(string.Empty, "0"));
            }
            catch (Exception ex)
            {
                lblMessage.InnerText = "error->" + ex.Message;
            }
        }
        private void setPrivilege(int[] permission)
        {
            try
            {
                //upupdate.Value = "1";               
                //upSave.Value = "1";
                //ViewState["__WriteAction__"] = "1";
                //ViewState["__DeletAction__"] = "1";
                //ViewState["__ReadAction__"] = "1";
                //ViewState["__UpdateAction__"] = "1";
                //HttpCookie getCookies = Request.Cookies["userInfo"];
                //string getUserId = getCookies["__getUserId__"].ToString();
                //ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                //ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                string[] AccessPermission = new string[0];
                //AccessPermission = checkUserPrivilege.checkUserPrivilegeForSettigs(getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "CompanyInfo.aspx", gvCompanyInfo, btnSave);

                //if (permission.Contains(235))
                //    ViewState["__ReadAction__"] = "1";
                //if (permission.Contains(236))
                //    ViewState["__WriteAction__"] = "1";
                //if (permission.Contains(237))
                //    ViewState["__UpdateAction__"] = "1";
                //if (permission.Contains(238))
                //    ViewState["__DeletAction__"] = "1";
                checkInitialPermission();


            }
            catch { }
        }
        private void LoadCompanyId()
        {
            try
            {
                string SL = "", ID = ""; ;
                DataTable dt = new DataTable();
                sqlDB.fillDataTable("Select Max(CompanyId) as CompanyId From HRD_CompanyInfo", dt);
                if (dt.Rows[0]["CompanyId"].ToString() == "")
                {
                    SL = "0001";
                }
                ID = (int.Parse(dt.Rows[0]["CompanyId"].ToString())).ToString();
                if (ID.Length == 1) SL = "000" + (int.Parse(ID) + 1);
                else if (ID.Length == 2) SL = "00" + (int.Parse(ID) + 1);
                else if (ID.Length == 3) SL = "0" + (int.Parse(ID) + 1);
                else if (ID.Length == 4) SL = (int.Parse(ID) + 1).ToString();
                txtCompanyId.Text = SL;
            }
            catch { }
        }
        private void AlterCompanyInfo(int ID)
        {
            try
            {
                DataTable dt = new DataTable();
                sqlDB.fillDataTable("Select ID, CompanyId,CompanyType, CompanyName,HeadOfficeId, CompanyNameBangla, Address, AddressBangla, Country, Telephone, Fax, DefaultCurrency, BusinessType, MultipleBranch, Comments, CompanyLogo,StartCardNo,Weekend,ShortName,CardNoType,FlatCode,CardNoDigits,AttMachineName,RegistrationId,EstablishmentId,Status,Email from HRD_CompanyInfo where ID=" + ID + " ", dt);
                if (dt.Rows.Count == 0)
                {
                    if (upSave.Value == "0")
                    {
                        btnSave.CssClass = "";
                        btnSave.Enabled = false;
                    }
                    return;
                }
                ViewState["ID"] = dt.Rows[0]["ID"].ToString();

                txtCompanyId.Text = dt.Rows[0]["CompanyId"].ToString();
                // rblOfficeType.SelectedValue = dt.Rows[0]["CompanyType"].ToString();
                if (dt.Rows[0]["CompanyType"].ToString() != "True") //for Branch
                {
                    rblOfficeType.SelectedValue = "0";
                    loadHeadOffice();
                    trHeadOffice.Visible = true;
                    ddlHeadOffice.SelectedValue = dt.Rows[0]["HeadOfficeId"].ToString();
                }
                else { rblOfficeType.SelectedValue = "1"; trHeadOffice.Visible = false; }
                txtCompanyName.Text = dt.Rows[0]["CompanyName"].ToString();
                txtCompanyNameBangla.Text = dt.Rows[0]["CompanyNameBangla"].ToString();
                txtAddress.Text = dt.Rows[0]["Address"].ToString();
                txtAddressBangla.Text = dt.Rows[0]["AddressBangla"].ToString();
                txtCountry.Text = dt.Rows[0]["Country"].ToString();
                txtTelephone.Text = dt.Rows[0]["Telephone"].ToString();
                txtFax.Text = dt.Rows[0]["Fax"].ToString();
                ddlDefaultCurrency.Text = dt.Rows[0]["DefaultCurrency"].ToString();
                ddlBusinessType.SelectedValue = dt.Rows[0]["BusinessType"].ToString();
                ddlMultipleBranch.Text = dt.Rows[0]["MultipleBranch"].ToString();
                txtComments.Text = dt.Rows[0]["Comments"].ToString();
                imageName = dt.Rows[0]["CompanyLogo"].ToString();

                string rootUrl = Session["__RootUrl__"]?.ToString();
                string companyId = Session["__GetCompanyId__"].ToString();
                string url = rootUrl + "/" + dt.Rows[0]["CompanyId"].ToString() + "/" + "CompanyLogo" + "/" + Path.GetFileName(dt.Rows[0]["CompanyLogo"].ToString());

                //string url = @"/EmployeeImages/CompanyLogo/" + Path.GetFileName(dt.Rows[0]["CompanyLogo"].ToString());
                imgProfile.ImageUrl = url;
                txtShortName.Text = dt.Rows[0]["ShortName"].ToString();
                ddlWeekend.Text = dt.Rows[0]["Weekend"].ToString();
                ddlCmpStatus.SelectedValue = dt.Rows[0]["Status"].ToString();
                ViewState["OldStatus"] = dt.Rows[0]["Status"].ToString();
                txtCompanyEmail.Text = dt.Rows[0]["Email"].ToString();
                ddlCardNoDigit.SelectedValue = dt.Rows[0]["CardNoDigits"].ToString();
                txtStartCardNo.Text = dt.Rows[0]["StartCardNo"].ToString();
                ddlMachine.SelectedValue = dt.Rows[0]["AttMachineName"].ToString();
                txtRegistrationInfos.Text = dt.Rows[0]["RegistrationId"].ToString();
                txtEstablesed.Text = dt.Rows[0]["EstablishmentId"].ToString();
                if (dt.Rows[0]["CardNoType"].ToString().Equals("True"))
                {
                    rblCardNoType.SelectedValue = "1";
                    txtFladCode.Text = "99";
                    txtFladCode.Visible = false;
                    txtStartCardNo.Style.Add("Width", "97%");
                    lblFladCode.InnerText = "Start Card No";
                }
                else
                {
                    rblCardNoType.SelectedValue = "0";

                    txtFladCode.Text = dt.Rows[0]["FlatCode"].ToString().Equals("") ? "99" : dt.Rows[0]["FlatCode"].ToString();
                    txtFladCode.Visible = true;
                    txtStartCardNo.Style.Add("Width", "71%");
                    lblFladCode.InnerText = "Flat Code";
                }
                if (upupdate.Value == "0")
                {
                    btnSave.Text = "Update";
                
                    btnSave.Enabled = false;
                }
                else
                {
                    btnSave.Text = "Update";

                    btnSave.Enabled = true;
                }

            }
            catch (Exception ex)
            {
                lblMessage.InnerText = "error->" + ex.Message;
            }
        }
        private void loadHeadOffice()
        {
            DataTable dt = new DataTable();
            sqlDB.fillDataTable("Select  CompanyId, CompanyName from HRD_CompanyInfo where CompanyType='1' ", dt);
            if (dt.Rows.Count < 1)
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "Warning();", true);
                //divMsg.InnerText = "First Set a Head Office!";
                //divMsg.Style.Add("color", "Red");
                rblOfficeType.SelectedValue = "1";
                //trHeadOffice.Visible = false;
                return;
            }
            ddlHeadOffice.DataValueField = "CompanyId";
            ddlHeadOffice.DataTextField = "CompanyName";
            ddlHeadOffice.DataSource = dt;
            ddlHeadOffice.DataBind();
            ddlHeadOffice.Items.Insert(0, new ListItem(string.Empty, "0000"));
            trHeadOffice.Visible = true;

        }
        private void loadCompanyInfoInfo()
        {
            try
            {
                DataTable dt = new DataTable();
                if (ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()).Equals("Super Admin") || ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()).Equals("Master Admin"))
                {
                    sqlDB.fillDataTable("Select ID, CompanyId, CompanyName, CompanyNameBangla, Address, AddressBangla, Country, Telephone, Fax, DefaultCurrency, BTypeName,  MultipleBranch,  Comments, CompanyLogo,StartCardNo,ComType,AttMachineName from v_HRD_CompanyInfo ", dt);
                }
                else
                {
                    sqlDB.fillDataTable(@"SELECT ID, CompanyId, CompanyName,  CompanyNameBangla, Address, AddressBangla, Country, Telephone, Fax,  DefaultCurrency,  Btype.BTypeName,   MultipleBranch,   Comments,  CompanyLogo,StartCardNo,cmptype.ComType,AttMachineName,Status,Email  FROM 
                     Hrd_CompanyInfo AS cmpi 
                     LEFT JOIN 
                     HRD_CompanyType AS cmptype ON cmpi.CompanyType = cmptype.ComTypeId LEFT JOIN 
                     HRD_BusinessType AS Btype ON cmpi.BusinessType = Btype.BId", dt);

                    //sqlDB.fillDataTable("Select ID, CompanyId, CompanyName, CompanyNameBangla, Address, AddressBangla, Country, Telephone, Fax, DefaultCurrency, BTypeName,  MultipleBranch,  Comments, CompanyLogo,StartCardNo,ComType,AttMachineName from v_HRD_CompanyInfo where CompanyId='" + ViewState["__CompanyId__"].ToString() + "' ", dt);

                }

                gvCompanyInfo.DataSource = dt;
                gvCompanyInfo.DataBind();

            }
            catch (Exception ex)
            {
                lblMessage.InnerText = "error->" + ex.Message;
            }
        }
        private Boolean saveCompanyInfo()
        {
            try
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO HRD_CompanyInfo (CompanyId, CompanyType, HeadOfficeId, CompanyName, CompanyNameBangla, Address, AddressBangla, Country, Telephone, Fax, DefaultCurrency, BusinessType, MultipleBranch, Comments, CompanyLogo, StartCardNo, Weekend, Status,Email, ShortName, CardNoType, FlatCode, CardNoDigits, AttMachineName, RegistrationId, EstablishmentId) " +
                    "VALUES (@CompanyId, @CompanyType, @HeadOfficeId, @CompanyName, @CompanyNameBangla, @Address, @AddressBangla, @Country, @Telephone, @Fax, @DefaultCurrency, @BusinessType, @MultipleBranch, @Comments, @CompanyLogo, @StartCardNo, @Weekend, @Status,@Email, @ShortName, @CardNoType, @FlatCode, @CardNoDigits, @AttMachineName, @RegistrationId, @EstablishmentId)",
                    sqlDB.connection);

                cmd.Parameters.AddWithValue("@CompanyId", txtCompanyId.Text.Trim());
                cmd.Parameters.AddWithValue("@CompanyType", rblOfficeType.SelectedValue);
                string HeadOfficeId = (rblOfficeType.SelectedValue != "0") ? txtCompanyId.Text.Trim() : ddlHeadOffice.SelectedValue;
                cmd.Parameters.AddWithValue("@HeadOfficeId", HeadOfficeId);
                cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text.Trim());
                cmd.Parameters.AddWithValue("@CompanyNameBangla", txtCompanyNameBangla.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@AddressBangla", txtAddressBangla.Text.Trim());
                cmd.Parameters.AddWithValue("@Country", txtCountry.Text.Trim());
                cmd.Parameters.AddWithValue("@Telephone", txtTelephone.Text.Trim());
                cmd.Parameters.AddWithValue("@Fax", txtFax.Text.Trim());
                cmd.Parameters.AddWithValue("@DefaultCurrency", ddlDefaultCurrency.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@BusinessType", ddlBusinessType.Text.Trim());
                cmd.Parameters.AddWithValue("@MultipleBranch", ddlMultipleBranch.Text == "Yes" ? 1 : 0);
                cmd.Parameters.AddWithValue("@Comments", txtComments.Text.Trim());
                cmd.Parameters.AddWithValue("@CompanyLogo", FileUpload2.HasFile ? "logo" + txtCompanyId.Text.Trim() + ".PNG" : "");
                cmd.Parameters.AddWithValue("@StartCardNo", txtStartCardNo.Text);
                cmd.Parameters.AddWithValue("@Weekend", ddlWeekend.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Status", ddlCmpStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@Email", txtCompanyEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@ShortName", txtShortName.Text.ToUpper());
                cmd.Parameters.AddWithValue("@CardNoType", rblCardNoType.SelectedValue);
                cmd.Parameters.AddWithValue("@FlatCode", rblCardNoType.SelectedValue == "0" ? txtFladCode.Text.Trim() : "0");
                cmd.Parameters.AddWithValue("@CardNoDigits", ddlCardNoDigit.SelectedValue);
                cmd.Parameters.AddWithValue("@AttMachineName", ddlMachine.SelectedValue);
                cmd.Parameters.AddWithValue("@RegistrationId", txtRegistrationInfos.Text.Trim());
                cmd.Parameters.AddWithValue("@EstablishmentId", txtEstablesed.Text.Trim());

                int result = cmd.ExecuteNonQuery();
                if (result > 0)
                {

                    string rootUrl = Session["__RootUrl__"]?.ToString();
                    string apiUrl = rootUrl + "/api/Company/company/create";


                    string token = Session["__UserToken__"]?.ToString();

                    List<string> empImageBase64 = commonTask.ConvertFilesToBase64(FileUpload2);

                    string response = commonTask.PostDocument(apiUrl, "logo", txtCompanyId.Text.Trim(), empImageBase64, token);


                    //saveImg();
                    AllClear();
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "Success();", true);
                    return true;
                }
                else
                {
                    divMsg.InnerText = "Unable to save";
                    return false;
                }
            }
            catch (Exception ex)
            {
                divMsg.InnerText = "error->" + ex.Message;
                return false;
            }
        }

        



        //private Boolean saveCompanyInfo()
        //{
        //    try
        //    {
        //        System.Data.SqlTypes.SqlDateTime getDate;
        //        getDate = SqlDateTime.Null;
        //        SqlCommand cmd = new SqlCommand("Insert into  HRD_CompanyInfo (CompanyId, CompanyType, HeadOfficeId, CompanyName, CompanyNameBangla, Address, AddressBangla, Country, Telephone, Fax, DefaultCurrency, BusinessType, MultipleBranch, Comments, CompanyLogo,StartCardNo,Weekend,Status,ShortName,CardNoType,FlatCode,CardNoDigits,AttMachineName,RegistrationId,EstablishmentId)  values (@CompanyId,@CompanyType,@HeadOfficeId, @CompanyName, @CompanyNameBangla, @Address, @AddressBangla, @Country, @Telephone, @Fax, @DefaultCurrency, @BusinessType,  @MultipleBranch, @Comments, @CompanyLogo,@StartCardNo,@Weekend, @Status,@Email ,@ShortName,@CardNoType,@FlatCode,@CardNoDigits,@AttMachineName,@RegistrationId,@EstablishmentId) ", sqlDB.connection);

        //        cmd.Parameters.AddWithValue("@CompanyId", txtCompanyId.Text.Trim());
        //        cmd.Parameters.AddWithValue("@CompanyType", rblOfficeType.SelectedValue);
        //        HeadOfficeId = (rblOfficeType.SelectedValue != "0") ? txtCompanyId.Text.Trim() : ddlHeadOffice.SelectedValue;
        //        cmd.Parameters.AddWithValue("@HeadOfficeId", HeadOfficeId.ToString());
        //        cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text.Trim());
        //        cmd.Parameters.AddWithValue("@CompanyNameBangla", txtCompanyNameBangla.Text.Trim());
        //        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
        //        cmd.Parameters.AddWithValue("@AddressBangla", txtAddressBangla.Text.Trim());
        //        cmd.Parameters.AddWithValue("@Country", txtCountry.Text.Trim());
        //        cmd.Parameters.AddWithValue("@Telephone", txtTelephone.Text.Trim());
        //        cmd.Parameters.AddWithValue("@Fax", txtFax.Text.Trim());
        //        cmd.Parameters.AddWithValue("@DefaultCurrency", ddlDefaultCurrency.SelectedItem.Text);
        //        cmd.Parameters.AddWithValue("@BusinessType", ddlBusinessType.Text.Trim());
        //        if (ddlMultipleBranch.Text == "Yes")
        //        {
        //            cmd.Parameters.AddWithValue("@MultipleBranch", 1);
        //        }
        //        else
        //        {
        //            cmd.Parameters.AddWithValue("@MultipleBranch", 0);
        //        }
        //        cmd.Parameters.AddWithValue("@Comments", txtComments.Text.Trim());
        //        if (FileUpload1.HasFile == true)
        //        {
        //            cmd.Parameters.AddWithValue("@CompanyLogo", "logo" + txtCompanyId.Text.Trim() + ".PNG");
        //        }
        //        else
        //        {
        //            cmd.Parameters.AddWithValue("@CompanyLogo", "");
        //        }
        //        cmd.Parameters.AddWithValue("@StartCardNo", txtStartCardNo.Text);
        //        cmd.Parameters.AddWithValue("@Weekend", ddlWeekend.SelectedItem.Text);
        //        cmd.Parameters.AddWithValue("@Status", ddlCmpStatus.SelectedValue);
        //        cmd.Parameters.AddWithValue("@Email", txtCompanyEmail.Text);
        //        cmd.Parameters.AddWithValue("@ShortName", txtShortName.Text.ToUpper());
        //        cmd.Parameters.AddWithValue("@CardNoType", rblCardNoType.SelectedValue);
        //        if (rblCardNoType.SelectedValue == "0")
        //            cmd.Parameters.AddWithValue("@FlatCode", txtFladCode.Text.Trim());
        //        else cmd.Parameters.AddWithValue("@FlatCode", 0);
        //        cmd.Parameters.AddWithValue("@CardNoDigits", ddlCardNoDigit.SelectedValue);
        //        cmd.Parameters.AddWithValue("@AttMachineName", ddlMachine.SelectedValue);
        //        cmd.Parameters.AddWithValue("@RegistrationId", txtRegistrationInfos.Text.Trim());
        //        cmd.Parameters.AddWithValue("@EstablishmentId", txtEstablesed.Text.Trim());



        //        int result = (int)cmd.ExecuteNonQuery();
        //        if (result > 0)
        //        {
        //            saveImg();
        //            AllClear();
        //            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "Success();", true);
        //            return true;
        //        }
        //        else
        //        {
        //            divMsg.InnerText = "Unable to save";
        //            return false;
        //        }



        //    }
        //    catch (Exception ex)
        //    {
        //        divMsg.InnerText = "error->" + ex.Message;
        //        return false;
        //    }
        //}
        private void saveImg()
        {
            try
            {

                string filename = "logo" + txtCompanyId.Text.Trim() + ".PNG";
                FileUpload2.SaveAs(Server.MapPath("/EmployeeImages/CompanyLogo/" + filename));



            }
            catch { }
        }

    

        private Boolean updateCompanyInfo()
        {
            try
            {
                string logoFileName = string.Empty;
                ////if (FileUpload2.HasFile)
                ////{
                ////    logoFileName = "logo" + txtCompanyId.Text.Trim() + ".PNG";
                ////    string savePath = Server.MapPath("/EmployeeImages/CompanyLogo/") + logoFileName;
                ////    if (File.Exists(savePath))
                ////    {
                ////        File.Delete(savePath);
                ////    }
                ////    FileUpload2.SaveAs(savePath);
                ////}
                ////else
                ////{
                ////    logoFileName = GetExistingLogoFileName(txtCompanyId.Text.Trim());
                ////}
         
                SqlCommand cmd = new SqlCommand(@"
            UPDATE HRD_CompanyInfo 
            SET 
                CompanyId = @CompanyId,
                CompanyType = @CompanyType,
                HeadOfficeId = @HeadOfficeId,
                CompanyName = @CompanyName,
                CompanyNameBangla = @CompanyNameBangla,
                Address = @Address,
                AddressBangla = @AddressBangla,
                Country = @Country,
                Telephone = @Telephone,
                Fax = @Fax,
                DefaultCurrency = @DefaultCurrency,
                BusinessType = @BusinessType,
                MultipleBranch = @MultipleBranch,
                Comments = @Comments,
                CompanyLogo = @CompanyLogo, -- Include the logo
                StartCardNo = @StartCardNo,
                Weekend = @Weekend,
                Status = @Status,
                Email = @Email,
                ShortName = @ShortName,
                CardNoType = @CardNoType,
                FlatCode = @FlatCode,
                CardNoDigits = @CardNoDigits,
                AttMachineName = @AttMachineName,
                RegistrationId = @RegistrationId,
                EstablishmentId = @EstablishmentId
            WHERE ID = @ID", sqlDB.connection);

                string id = ViewState["ID"] != null ? ViewState["ID"].ToString() : string.Empty;
                cmd.Parameters.AddWithValue("@ID", id);
                cmd.Parameters.AddWithValue("@CompanyId", txtCompanyId.Text.Trim());
                cmd.Parameters.AddWithValue("@CompanyType", rblOfficeType.SelectedValue);
                string headOfficeId = (rblOfficeType.SelectedValue != "0") ? txtCompanyId.Text.Trim() : ddlHeadOffice.SelectedValue;
                cmd.Parameters.AddWithValue("@HeadOfficeId", headOfficeId);
                cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text.Trim());
                cmd.Parameters.AddWithValue("@CompanyNameBangla", txtCompanyNameBangla.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@AddressBangla", txtAddressBangla.Text.Trim());
                cmd.Parameters.AddWithValue("@Country", txtCountry.Text.Trim());
                cmd.Parameters.AddWithValue("@Telephone", txtTelephone.Text.Trim());
                cmd.Parameters.AddWithValue("@Fax", txtFax.Text.Trim());
                cmd.Parameters.AddWithValue("@DefaultCurrency", ddlDefaultCurrency.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@BusinessType", ddlBusinessType.Text.Trim());
                cmd.Parameters.AddWithValue("@MultipleBranch", ddlMultipleBranch.Text == "Yes" ? 1 : 0);
                cmd.Parameters.AddWithValue("@Comments", txtComments.Text.Trim());
                cmd.Parameters.AddWithValue("@CompanyLogo", logoFileName); // Set the logo file name
                cmd.Parameters.AddWithValue("@StartCardNo", txtStartCardNo.Text.Trim());
                cmd.Parameters.AddWithValue("@Weekend", ddlWeekend.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@Status", ddlCmpStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@Email", txtCompanyEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@ShortName", txtShortName.Text.ToUpper());
                cmd.Parameters.AddWithValue("@CardNoType", rblCardNoType.SelectedValue);
                cmd.Parameters.AddWithValue("@FlatCode", rblCardNoType.SelectedValue == "0" ? txtFladCode.Text.Trim() : "0");
                cmd.Parameters.AddWithValue("@CardNoDigits", ddlCardNoDigit.SelectedValue);
                cmd.Parameters.AddWithValue("@AttMachineName", ddlMachine.SelectedValue);
                cmd.Parameters.AddWithValue("@RegistrationId", txtRegistrationInfos.Text.Trim());
                cmd.Parameters.AddWithValue("@EstablishmentId", txtEstablesed.Text.Trim());
                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {

                    string rootUrl = Session["__RootUrl__"]?.ToString();
                    string apiCompanyUrl = rootUrl + "/api/Company/company/create";


                    string token = Session["__UserToken__"]?.ToString();

                    List<string> empImageBase64 = commonTask.ConvertFilesToBase64(FileUpload2);

                    string response = commonTask.PostDocument(apiCompanyUrl, "logo", txtCompanyId.Text.Trim(), empImageBase64, token);


                    string oldStatus = ViewState["OldStatus"] != null ? ViewState["OldStatus"].ToString() : "0";
                    if (ddlCmpStatus.SelectedValue != oldStatus)
                    {
                        SaveCompanyStatusLog();
                    }  
                    loadCompanyInfoInfo();
                    AllClear();
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "updSuccess();", true);
                    return true;
                }
                else
                {
                    divMsg.InnerText = "error->Unable to save";
                    return false;
                }
            }
            catch (Exception ex)
            {
                divMsg.InnerText = "error->" + ex.Message;
                divMsg.Style.Add("color", "Red");
                return false;
            }
        }

        private bool SaveCompanyStatusLog()
        {
            try
            {
                // Retrieve the old status or default to "0"
                string oldStatus = ViewState["OldStatus"] != null ? ViewState["OldStatus"].ToString() : "0";

                // Parse old and new status safely
                if (!byte.TryParse(oldStatus, out byte oldStatusByte)) oldStatusByte = 0;
                if (!byte.TryParse(ddlCmpStatus.SelectedValue, out byte newStatusByte)) return false;

                // Proceed only if the status has changed
                if (newStatusByte != oldStatusByte)
                {
                    using (SqlCommand cmd = new SqlCommand(
                        "INSERT INTO HRDCompanyStatusLogs (CompanyId, OldStatus, NewStatus, ChangedBy, ChangedAt, Remarks) " +
                        "VALUES (@CompanyId, @OldStatus, @NewStatus, @ChangedBy, @ChangedAt, @Remarks)",
                        sqlDB.connection))
                    {
                        int changedBy = int.Parse(Session["__GetUserId__"].ToString());

                        // Add parameters to the SQL command
                        cmd.Parameters.AddWithValue("@CompanyId", txtCompanyId.Text.Trim());
                        cmd.Parameters.AddWithValue("@OldStatus", oldStatusByte);
                        cmd.Parameters.AddWithValue("@NewStatus", newStatusByte);
                        cmd.Parameters.AddWithValue("@ChangedBy", changedBy);
                        cmd.Parameters.AddWithValue("@ChangedAt", DateTime.Now);
                        cmd.Parameters.AddWithValue("@Remarks",
                            string.IsNullOrWhiteSpace(txtComments.Text.Trim()) ? DBNull.Value : (object)txtComments.Text.Trim());

                        // Execute the command and check the result
                        return cmd.ExecuteNonQuery() > 0;
                    }
                }

                // If no change in status, return false
                return false;
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("An error occurred: " + ex.Message);
                return false; // Return false on error
            }
        }
        private string GetExistingLogoFileName(string companyId)
        {
            string logoFileName = string.Empty;

            string query = "SELECT CompanyLogo FROM HRD_CompanyInfo WHERE CompanyId = @CompanyId";

            using (SqlCommand cmd = new SqlCommand(query, sqlDB.connection))
            {
                cmd.Parameters.AddWithValue("@CompanyId", companyId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        logoFileName = reader["CompanyLogo"].ToString();
                    }
                }
            }

            return logoFileName;
        }





        protected void btnSave_Click(object sender, EventArgs e)
        {
            
                if (btnSave.Text == "Save")
                {
                    saveCompanyInfo();
                }
                else
                {
                    updateCompanyInfo();
                }

                // Refresh data after saving or updating
                loadCompanyInfoInfo();
            
        }

    

        private void Delete(int ID)
        {
            try
            {

                SqlCommand cmd = new SqlCommand("Delete From HRD_CompanyInfo where ID=" + ID + "", sqlDB.connection);
                cmd.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "delSuccess();", true);
                AllClear();
                loadCompanyInfoInfo();


            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("An error occurred: " + ex.Message);

            }
        }
        private void AllClear()
        {
            try
            {
                txtAddress.Text = "";
                txtAddressBangla.Text = "";
                txtComments.Text = "";
                txtCompanyId.Text = "";
                txtCompanyName.Text = "";
                txtCompanyNameBangla.Text = "";
                txtCountry.Text = "";
                rblOfficeType.SelectedValue = "1";
                trHeadOffice.Visible = false;
                ddlBusinessType.SelectedValue = "0";
                // ddlDefaultCurrency.SelectedItem.Text = "";
                txtFax.Text = "";
                //txtFinancialYearForm.Text = "";
                //txtFinancialYearTo.Text = "";
                txtTelephone.Text = "";
                txtStartCardNo.Text = "";
                txtShortName.Text = "";
                btnSave.Text = "Save";
                imgProfile.ImageUrl = "~/images/profileImages/Logo.png";
                LoadCompanyId();
                if (ViewState["__BranchType__"].ToString().Equals("False") && gvCompanyInfo.Rows.Count > 0)
                {
                    btnSave.Enabled = false;
                    btnSave.CssClass = "";
                }


            }
            catch { }
        }

        protected void gvCompanyInfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Attributes["onmouseover"] = "javascript:SetMouseOver(this)";
                    e.Row.Attributes["onmouseout"] = "javascript:SetMouseOut(this)";
                }
            }
            catch { }


            try
            {
                if (ViewState["__DeletAction__"].ToString().Equals("0"))
                {
                    Button btnDelete = (Button)e.Row.FindControl("btnDelete");
                    btnDelete.Enabled = false;
                    btnDelete.OnClientClick = "return false";
                    btnDelete.ForeColor = Color.Silver;

                }

            }
            catch { }
            try
            {
                if (ViewState["__UpdateAction__"].ToString().Equals("0"))
                {
                    Button btnAlter = (Button)e.Row.FindControl("btnAlter");
                    btnAlter.Enabled = false;
                    btnAlter.ForeColor = Color.Silver;

                }

            }
            catch { }

        }

        protected void gvCompanyInfo_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                loadCompanyInfoInfo();
                gvCompanyInfo.PageIndex = e.NewPageIndex;
                gvCompanyInfo.DataBind();
            }
            catch { }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            AllClear();
        }



        protected void rblOfficeType_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (rblOfficeType.SelectedValue == "0") loadHeadOffice();
            else trHeadOffice.Visible = false;
        }

        protected void rblCardNoType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rblCardNoType.SelectedValue == "1")
            {
                txtFladCode.Visible = false;
                txtStartCardNo.Style.Add("Width", "97%");
                lblFladCode.InnerText = "Start Card No";
                txtStartCardNo.Visible = true;
            }
            else
            {
                txtFladCode.Visible = true;

                txtStartCardNo.Style.Add("Width", "71%");
                lblFladCode.InnerText = "Flat Code";
                txtStartCardNo.Visible = true;
            }
        }
        private bool deleteValidation(string CompanyId)
        {
            DataTable dt = new DataTable();
            sqlDB.fillDataTable("Select CompanyId from Personnel_EmpCurrentStatus  where CompanyId=" + CompanyId + "", dt);
            if (dt.Rows.Count > 0)
                return false;
            else return true;
        }

        private void checkInitialPermission()
        {
            if (ViewState["__WriteAction__"].ToString().Equals("1"))
            {
                btnSave.Enabled = true;
                btnSave.CssClass = "Rbutton";
            }
            else
            {
                btnSave.Enabled = false;
                btnSave.CssClass = "";
            }


        }

        protected void gvCompanyInfo_RowCommand1(object sender, GridViewCommandEventArgs e)
        {
            try
            {


                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;

                int index = row.RowIndex;
                if (e.CommandName == "Alter")
                {
                    // Corrected: Gets the index relative to the current page

                    // Ensure the DataKeys exist
                    if (gvCompanyInfo.DataKeys.Count > index)
                    {
                        string ID = gvCompanyInfo.DataKeys[index].Values["ID"].ToString();
                        string CompanyId = gvCompanyInfo.DataKeys[index].Values["CompanyId"].ToString();

                        // Call your method with the correct ID
                        AlterCompanyInfo(int.Parse(ID));

                        if (deleteValidation(CompanyId))
                        {
                            rblCardNoType.Enabled = true;
                            ddlCardNoDigit.Enabled = true;
                            txtStartCardNo.Enabled = true;
                        }
                        else
                        {
                            rblCardNoType.Enabled = false;
                            ddlCardNoDigit.Enabled = false;
                            txtStartCardNo.Enabled = false;
                        }
                    }
                }
                else if (e.CommandName == "Remove")
                {
                    string value = gvCompanyInfo.DataKeys[index].Values[1].ToString();
                    if (deleteValidation(gvCompanyInfo.DataKeys[index].Values[1].ToString()))
                    {
                        Delete(Convert.ToInt32(gvCompanyInfo.DataKeys[index].Values[0].ToString()));
                    }
                    else
                        lblMessage.InnerText = "error->Warning! Can't delete this Company.";


                }
                else if (e.CommandName == "Setup")
                {
                    var companyId = gvCompanyInfo.DataKeys[index].Values[1].ToString();
                    Response.Redirect("~/hrms/packages/userPackagesSetup.aspx?companyId=" + companyId);

                }
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("An error occurred: " + ex.Message);

            }
        }
    }
}