﻿using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.payroll
{
    public partial class payroll_entry_panel : System.Web.UI.Page
    {
        DataTable dt;

        //View=328 Add=329 update=330
        protected void Page_Load(object sender, EventArgs e)
        {
           
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            lblMessage.InnerText = "";
            if (!IsPostBack) {
                ViewState["__WriteAction__"] = "0";
                // ViewState["__DeletAction__"] = "1";
                ViewState["__ReadAction__"] = "0";
                ViewState["__UpdateAction__"] = "1";

                int[] pagePermission = { 328, 329, 330 };
                int[] userPagePermition = AccessControl.hasPermission(pagePermission);
                if (!userPagePermition.Any())
                    Response.Redirect(Routing.defualtUrl);

                setPrivilege(userPagePermition);
                ViewState["__IsChanged__"] = "no";
                Session["OPERATION_PROGRESS"] = 0;
                Office_IsGarments();
                if (!classes.commonTask.HasBranch())
                {
                    ddlCompanyList.Enabled = false;
                    ddlCompanyList2.Enabled = false;
                }
            }
        }

        

        private void Office_IsGarments()
        {
            try
            {

                if (classes.Payroll.Office_IsGarments())
                {
                    trNightAllowance.Visible = true;
                    TrAttendanceBouns.Visible = true;
                    hfIsGarments.Value = "1";
                }
                else
                {
                    trNightAllowance.Visible = false;
                   // TrAttendanceBouns.Visible = false;
                    hfIsGarments.Value = "0";
                }
            }
            catch { }
        }
        private void setPrivilege(int [] permissions)
        {
            try
            {
                
                //ViewState["__WriteAction__"] = "1";
                //ViewState["__DeletAction__"] = "1";
                //ViewState["__ReadAction__"] = "1";
                //ViewState["__UpdateAction__"] = "1";

                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();

                classes.commonTask.LoadBranch(ddlCompanyList, ViewState["__CompanyId__"].ToString());
                classes.commonTask.LoadBranch(ddlCompanyList2, ViewState["__CompanyId__"].ToString());


               //tring[] AccessPermission = new string[0];
                // AccessPermission = checkUserPrivilege.checkUserPrivilegeForpayrollentrypanel(getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "payroll_entry_panel.aspx", gvSalaryList, btnSave, ViewState["__CompanyId__"].ToString(), ddlCompanyList, ddlCompanyList2);

                if (permissions.Contains(328))
                    ViewState["__ReadAction__"] = "1";
                if (permissions.Contains(329))
                    ViewState["__WriteAction__"] = "1";
                if (permissions.Contains(330))
                    ViewState["__UpdateAction__"] = "1";
                checkInitialPermission();
                ddlCompanyList.SelectedValue = ViewState["__CompanyId__"].ToString();
                ddlCompanyList2.SelectedValue = ViewState["__CompanyId__"].ToString();
                //if (ViewState["__WriteAction__"].ToString().Equals("0"))
                //{
                //    ddlEmpCardNo.Enabled = false;
                //    return;
                //}
                classes.Employee.LoadEmpCardNoForPayroll(ddlEmpCardNo, ddlCompanyList.SelectedValue);
                classes.commonTask.LoadGrade(ddlGrade, ViewState["__CompanyId__"].ToString());
                LoadAllownceSetting();
                trBank.Visible = false;
                trAccount.Visible = false;
               
            }
            catch { }

        }
        protected void ddlCompanyList_SelectedIndexChanged(object sender, EventArgs e)
        {
            classes.Employee.LoadEmpCardNoForPayroll(ddlEmpCardNo, ddlCompanyList.SelectedValue);

        }
        protected void ddlCompanyList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadSalaryInfo(ddlCompanyList2.SelectedValue);

        }
        static DataTable dt_AllowanceSettings=new DataTable ();
        private void LoadAllownceSetting()
        {
            try
            {
                dt_AllowanceSettings = new DataTable();
                sqlDB.fillDataTable("Select acs.SalaryType ,has.BasicAllowance,has.MedicalAllownce,has.FoodAllownce,has.ConvenceAllownce,has.TechnicalAllowance, " +
                    " has.HouseRent,has.OthersAllowance,has.PFAllowance,has.AlCalId,acs.EmpTypeId," +
                    "acs.BasicAllowance as BasicStatus,acs.MedicalAllownce as MedicalStatus,acs.FoodAllownce as FoodStatus,acs.ConvenceAllownce as ConStatus,"+
                    " acs.TechnicalAllowance as TecStatus,acs.HouseRent as HouseStatus,acs.OthersAllowance as OthStatus, acs.ProvidentFund as PFStatus "+
                    " from HRD_AllownceSetting as has inner join Payroll_AllowanceCalculationSetting acs on has.AlCalId=acs.AlCalId where acs.CalculationType='salary'", dt_AllowanceSettings);

                if (dt_AllowanceSettings.Rows.Count == 0) return;
                //lblBasic.Text = dt_AllowanceSettings.Rows[0]["BasicAllowance"].ToString();
                //lblHouseRent.Text = dt_AllowanceSettings.Rows[0]["HouseRent"].ToString();
                //hdfhouserent.Value = dt_AllowanceSettings.Rows[0]["HouseRent"].ToString();
                hdfFoodAllowance.Value = dt_AllowanceSettings.Rows[0]["FoodAllownce"].ToString();
                hdfMedical.Value = dt_AllowanceSettings.Rows[0]["MedicalAllownce"].ToString();
                hdfConveyance.Value = dt_AllowanceSettings.Rows[0]["ConvenceAllownce"].ToString();


                //txtMedical.Text = dt_AllowanceSettings.Rows[0]["MedicalAllownce"].ToString();
                //txtConveyanceAllow.Text = dt_AllowanceSettings.Rows[0]["ConvenceAllownce"].ToString();
                //txtFoodAllowance.Text = dt_AllowanceSettings.Rows[0]["FoodAllownce"].ToString();
              
                


            }
            catch { }
        }
        private void IndividualSalary()
        {
            try
            {
                string query= "select  SalaryCount, EmpAccountNo,BankId,PayerBankId,GrdName,EmpJoinigSalary,EmpPresentSalary,BasicSalary,MedicalAllownce,TechnicalAllownce,HouseRent,EmpTypeId,EmpType," +
                    "ConvenceAllownce,FoodAllownce,AttendanceBonus,PfMember,PfDate,PFAmount,HouseRent_Persent,Medical,PF_Persent,SalaryType,NightAllownce,OverTime,OthersAllownce,DormitoryRent,IsNull(IsSingleRateOT,0) as IsSingleRateOT,IncomeTax from v_EmployeeDetails where SN=" + ddlEmpCardNo.SelectedValue + "";
                dt = new DataTable();
                sqlDB.fillDataTable("select  SalaryCount, EmpAccountNo,BankId,PayerBankId,GrdName,EmpJoinigSalary,EmpPresentSalary,BasicSalary,MedicalAllownce,HouseRent,EmpTypeId,EmpType," +
                    "ConvenceAllownce,FoodAllownce,TechnicalAllownce,AttendanceBonus,PfMember,PfDate,PFAmount,HouseRent_Persent,Medical,PF_Persent,SalaryType,NightAllownce,OverTime,OthersAllownce,DormitoryRent,IsNull(IsSingleRateOT,0) as IsSingleRateOT,IncomeTax from v_EmployeeDetails where SN=" + ddlEmpCardNo.SelectedValue + "", dt);
                if (dt.Rows.Count > 0)
                {
                    lblEmpType.Text = dt.Rows[0]["EmpType"].ToString();
                    hfEmpTypeId.Value = dt.Rows[0]["EmpTypeId"].ToString();
                    //if (dt.Rows[0]["PF_Persent"].ToString().Equals("") || dt.Rows[0]["Medical"].ToString().Equals("") || dt.Rows[0]["HouseRent_Persent"].ToString().Equals(""))
                    //{
                    //    lblMessage.InnerText = "error->Please Set Allowance For This Employee's Designation!";
                    //    txtBasic.Enabled = false;
                    //    return;
                    //}
                    txtBasic.Enabled = true;
                    if (dt.Rows[0]["SalaryCount"].ToString().Equals("True"))
                    {
                        chkPaymentType.SelectedValue = "1";
                    }
                    else if (dt.Rows[0]["SalaryCount"].ToString().Equals("False"))
                    {
                        chkPaymentType.SelectedValue = "0";
                    }
                    else
                    {
                        chkPaymentType.SelectedValue = "2";
                    }
                    
                    if (chkPaymentType.SelectedValue == "1")
                    {

                        trBank.Visible = true;
                        trAccount.Visible = true; 
                        loadBankList();
                        loadPayerList();
                        ddlPayerBank.SelectedValue= (dt.Rows[0]["PayerBankId"].ToString().Equals("")) ? "0" : dt.Rows[0]["PayerBankId"].ToString();
                        ddlBankList.SelectedValue = (dt.Rows[0]["BankId"].ToString().Equals("")) ? "0" : dt.Rows[0]["BankId"].ToString();
                        txtEmpAccNo.Text = dt.Rows[0]["EmpAccountNo"].ToString();
                    }
                    else
                    {
                        
                        txtEmpAccNo.Text = "";
                        trBank.Visible = false;
                        trAccount.Visible = false;
                    }
                    string grade = dt.Rows[0]["GrdName"].ToString();
                    if (grade != "")
                    {
                        ddlGrade.Text = dt.Rows[0]["GrdName"].ToString();
                    }
                    txtJoiningSalary.Text = dt.Rows[0]["EmpJoinigSalary"].ToString();
                    txtPresentSalary.Text = dt.Rows[0]["EmpPresentSalary"].ToString();
                    if (dt.Rows[0]["SalaryType"].ToString() == "Gross")
                    {
                        txtBasic.Text = "0";
                        txtMedical.Text = "0";
                        lblHouseRent.Text = "0";
                        hfTotalHouseRent.Value = "0";
                        txtHouseRent.Text = "0";
                        txtConveyanceAllow.Text = "0";
                        txtFoodAllowance.Text = "0";
                    }
                    else
                    {
                        txtBasic.Text = dt.Rows[0]["BasicSalary"].ToString();
                        txtMedical.Text = dt.Rows[0]["MedicalAllownce"].ToString();
                        lblHouseRent.Text = dt.Rows[0]["HouseRent_Persent"].ToString();
                        hfTotalHouseRent.Value = dt.Rows[0]["HouseRent_Persent"].ToString();

                        txtHouseRent.Text = dt.Rows[0]["HouseRent"].ToString();
                        txtConveyanceAllow.Text = dt.Rows[0]["ConvenceAllownce"].ToString();
                        txtFoodAllowance.Text = dt.Rows[0]["FoodAllownce"].ToString();
                        txtTechnicalAllow.Text = dt.Rows[0]["TechnicalAllownce"].ToString();
                    }
                    
                    lblPF.Text = dt.Rows[0]["PF_Persent"].ToString();
                    txtOthers.Text = dt.Rows[0]["OthersAllownce"].ToString();
                    ddlDormitoryRent.SelectedValue = dt.Rows[0]["DormitoryRent"].ToString();
                    rblSalaryType.SelectedValue = dt.Rows[0]["SalaryType"].ToString();
                    if (dt.Rows[0]["OverTime"].ToString() == "" || dt.Rows[0]["OverTime"].ToString()=="False")
                    {
                        rblOverTime.SelectedValue = "0";
                    }
                    else rblOverTime.SelectedValue ="1";

                    if (dt.Rows[0]["PfMember"].ToString() == "True")
                    {
                        chkPFMember.Checked = true;
                        trPFAmount.Visible = true;
                    }
                    else
                    {
                        chkPFMember.Checked = false;
                        trPFAmount.Visible = false;
                    }
                    if (dt.Rows[0]["IsSingleRateOT"].ToString() == "True")
                        ckbSingleRateOT.Checked = true;
                    else
                        ckbSingleRateOT.Checked = false;

                    if (dt.Rows[0]["PfDate"].ToString().Length == 0)
                    {
                        txtPFDate.Text = "";
                    }
                    else
                    {
                        txtPFDate.Text = Convert.ToDateTime(dt.Rows[0]["PfDate"].ToString()).ToString("d-M-yyyy");
                    }
                    txtPFAmount.Text = dt.Rows[0]["PFAmount"].ToString();
                    hdfSalaryType.Value = dt.Rows[0]["SalaryType"].ToString();
                    SetSalaryType_Constraint();
                    if (dt.Rows[0]["SalaryType"].ToString() != "Gross")
                        SetConstraint(dt.Rows[0]["EmpTypeId"].ToString());
                    txtNightAllowance.Text = dt.Rows[0]["NightAllownce"].ToString();
                    ddlCompanyList.SelectedValue = ddlCompanyList2.SelectedValue;
                    txtTDS.Text= dt.Rows[0]["IncomeTax"].ToString();
                    if (ViewState["__UpdateAction__"].Equals("0"))
                    {
                        btnSave.Enabled = false;
                        btnSave.CssClass = "";
                    }
                    else
                    {
                        btnSave.Enabled = true;
                        btnSave.CssClass = "Pbutton";
                    }
                }
            }
            catch { }
        }
        private void SetSalaryType_Constraint()
        {
            try
            {
                if (rblSalaryType.SelectedValue.Trim().Equals("Scale"))
                {
                    txtBasic.Enabled = true;
                    txtPresentSalary.Enabled = false;
                    txtBasic.Focus();

                    txtHouseRent.Enabled = true;
                    txtConveyanceAllow.Enabled = true;
                    txtFoodAllowance.Enabled = true;
                }
                else
                {
                    txtBasic.Enabled = false;
                    txtPresentSalary.Enabled = true;
                    txtPresentSalary.Focus();
                }
            }
            catch { }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
           
            saveSalary();            
        }

        
        private void saveSalary() 
        {
            try {
                int isVacation = (chkIsvacation.Checked) ? 1 : 0;
                SqlCommand cmd = new SqlCommand("update Personnel_EmpCurrentStatus  Set SalaryCount=@SalaryCount,BankId=@BankId," +
                    "EmpAccountNo=@EmpAccountNo,GrdId=@GrdId,EmpJoinigSalary=@EmpJoinigSalary, PreEmpSalary=@PreEmpSalary, EmpPresentSalary=@EmpPresentSalary, " +
                    " PreBasicSalary=@PreBasicSalary, BasicSalary=@BasicSalary,PreMedicalAllownce=@PreMedicalAllownce,"+
                    " MedicalAllownce=@MedicalAllownce,PreFoodAllownce=@PreFoodAllownce, FoodAllownce=@FoodAllownce,"+
                    "PreConvenceAllownce=@PreConvenceAllownce, ConvenceAllownce=@ConvenceAllownce, PreHouseRent=@PreHouseRent,"+
                    " HouseRent=@HouseRent,PreAttendanceBonus=@PreAttendanceBonus,AttendanceBonus=@AttendanceBonus,NightAllownce=@NightAllownce,OverTime=@OverTime,PreOthersAllownce=@PreOthersAllownce,OthersAllownce=@OthersAllownce,DormitoryRent=@DormitoryRent,IsSingleRateOT=@IsSingleRateOT,IncomeTax=@IncomeTax,PayerBankId=@PayerBankId,IsVacation=@isVacation,TechnicalAllownce=@TechnicalAllownce where SN=@SN", sqlDB.connection);

                cmd.Parameters.AddWithValue("@SN", ddlEmpCardNo.SelectedValue);
                if (chkPaymentType.SelectedValue=="1")
                {
                    cmd.Parameters.AddWithValue("@SalaryCount", 1);
                }
                else if (chkPaymentType.SelectedValue == "0")
                {
                    cmd.Parameters.AddWithValue("@SalaryCount", 0);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@SalaryCount",DBNull.Value);
                }
                            
                cmd.Parameters.AddWithValue("@BankId", ddlBankList.SelectedValue);
                cmd.Parameters.AddWithValue("@EmpAccountNo", txtEmpAccNo.Text);
                cmd.Parameters.AddWithValue("@GrdId", ddlGrade.SelectedValue);
                cmd.Parameters.AddWithValue("@EmpJoinigSalary", txtJoiningSalary.Text);
                cmd.Parameters.AddWithValue("@PreEmpSalary", txtPresentSalary.Text.Trim());
                cmd.Parameters.AddWithValue("@EmpPresentSalary", txtPresentSalary.Text.Trim());
                cmd.Parameters.AddWithValue("@PreBasicSalary", txtBasic.Text.Trim());
                cmd.Parameters.AddWithValue("@BasicSalary", txtBasic.Text.Trim());
                cmd.Parameters.AddWithValue("@PreHouseRent", txtHouseRent.Text.Trim());
                cmd.Parameters.AddWithValue("@HouseRent",txtHouseRent.Text.Trim());
                cmd.Parameters.AddWithValue("@PreConvenceAllownce", txtConveyanceAllow.Text.Trim());
                cmd.Parameters.AddWithValue("@ConvenceAllownce",txtConveyanceAllow.Text.Trim());
                cmd.Parameters.AddWithValue("@PreMedicalAllownce", txtMedical.Text.Trim());
                cmd.Parameters.AddWithValue("@MedicalAllownce", txtMedical.Text.Trim());

                cmd.Parameters.AddWithValue("@PreFoodAllownce", txtFoodAllowance.Text.Trim());
                cmd.Parameters.AddWithValue("@FoodAllownce",txtFoodAllowance.Text.Trim());
                cmd.Parameters.AddWithValue("@PreAttendanceBonus", txtAttenBonus.Text.Trim());
                cmd.Parameters.AddWithValue("@AttendanceBonus", txtAttenBonus.Text.Trim());
                cmd.Parameters.AddWithValue("@NightAllownce",txtNightAllowance.Text.Trim());
                cmd.Parameters.AddWithValue("@OverTime", rblOverTime.SelectedValue);
                cmd.Parameters.AddWithValue("@PreOthersAllownce", txtOthers.Text.Trim());
                cmd.Parameters.AddWithValue("@OthersAllownce", txtOthers.Text.Trim());
                cmd.Parameters.AddWithValue("@DormitoryRent", ddlDormitoryRent.SelectedValue);
                cmd.Parameters.AddWithValue("@PayerBankId", ddlPayerBank.SelectedValue);
                cmd.Parameters.AddWithValue("@isVacation", isVacation);
                cmd.Parameters.AddWithValue("@TechnicalAllownce", txtTechnicalAllow.Text.Trim());

                //if (chkPFMember.Checked)
                //{
                //    cmd.Parameters.AddWithValue("@PfMember", 1);
                //}
                //else
                //{
                //    cmd.Parameters.AddWithValue("@PfMember", 0);
                //}

                //if (txtPFDate.Text.Length == 0) cmd.Parameters.AddWithValue("@PfDate", "");
                //else cmd.Parameters.AddWithValue("@PfDate", convertDateTime.getCertainCulture(txtPFDate.Text.Trim()));
                //if (txtPFAmount.Text.Length == 0)
                //{
                //    cmd.Parameters.AddWithValue("@PFAmount", 0);
                //}
                //else cmd.Parameters.AddWithValue("@PFAmount", txtPFAmount.Text);

                if (ckbSingleRateOT.Checked)
                {
                    cmd.Parameters.AddWithValue("@IsSingleRateOT", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@IsSingleRateOT", 0);
                }
                cmd.Parameters.AddWithValue("@IncomeTax", txtTDS.Text.Trim());
                if (int.Parse(cmd.ExecuteNonQuery().ToString()) > 0)
                {
                    if (ViewState["__WriteAction__"].Equals("0"))
                    {
                        btnSave.Enabled = false;
                        btnSave.CssClass = "";
                    }
                    else
                    {
                        btnSave.Enabled = true;
                        btnSave.CssClass = "Pbutton";
                    }
                    ViewState["__IsChanged__"] = "yes";
                   // lblMessage.InnerText = "success->Successfully Submitted.";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "Messageshow('success','Successfully Submitted.');", true);
                }
                else 
                {
                    ViewState["__IsChanged__"] = "no";
                   // lblMessage.InnerText = "error->Unable to Submit.";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "Messageshow(error,'Unable to Submit.');", true);
                }

            }
            catch {
                ViewState["__IsChanged__"] = "no";
              //  lblMessage.InnerText = "error->Unable to Submit."; 
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "Messageshow(error,'Unable to Submit.');", true);
            }
        
        }

        protected void chkPaymentType_SelectedIndexChanged(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
            if (chkPaymentType.SelectedValue == "1")
            {
                loadBankList();
                loadPayerList();
                trBank.Visible = true;
                trAccount.Visible = true;              
            }
            else
            {
                trBank.Visible = false;
                trAccount.Visible = false;
                txtEmpAccNo.Text = "";
                ddlBankList.SelectedValue = "0";
            }
        }

        protected void chkPFMember_CheckedChanged(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
            if (chkPFMember.Checked)
            {
                trPFAmount.Visible = true;
               // hfPFAmount.Value=new String(lblPF.Text.Where(Char.IsNumber).ToArray());
            }
            else
            {
                trPFAmount.Visible = false;
                //hfPFAmount.Value = "0";
            }
        }

        protected void ddlEmpCardNo_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlEmpCardNo.SelectedIndex != 0)
                IndividualSalary();
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
        }

        private void loadBankList() 
        {
            DataTable dtBank;
            sqlDB.fillDataTable("select * from HRD_BankInfo where isActive=1", dtBank = new DataTable());
            ddlBankList.DataValueField = "BankId";
            ddlBankList.DataTextField = "BankName";
            ddlBankList.DataSource = dtBank;
            ddlBankList.DataBind();
            ddlBankList.Items.Insert(0, new ListItem(string.Empty, "0"));
          
        }

        private void loadPayerList()
        {
            DataTable dtBank;
            sqlDB.fillDataTable("select * from HRD_BankInfo where isActive=1 and IsPayer=1", dtBank = new DataTable());
            ddlPayerBank.DataValueField = "BankId";
            ddlPayerBank.DataTextField = "BankName";
            ddlPayerBank.DataSource = dtBank;
            ddlPayerBank.DataBind();
            ddlPayerBank.Items.Insert(0, new ListItem(string.Empty, "0"));

        }

        private void allClear() 
        {

        }

        private void loadSalaryInfo(string companyId)
        {
            try
            {
                string condition = AccessControl.getDataAccessCondition(companyId,"0");
                string query = "select distinct EmpCardNo,EmpName, max(SN) as SN,EmpType,EmpStatus,EmpTypeId,BasicSalary,MedicalAllownce,TechnicalAllownce,HouseRent , FoodAllownce,ConvenceAllownce, EmpPresentSalary,CompanyId," +
                    " ActiveSalary,IsActive,PFAmount,case when SalaryCount='False' Then 'Cash' Else case when SalaryCount='True' then 'Bank' else 'Check' End End As SalaryCount from v_Personnel_EmpCurrentStatus group by EmpCardNo,EmpName,EmpTypeId,EmpType,BasicSalary,FoodAllownce,TechnicalAllownce,ConvenceAllownce,MedicalAllownce,HouseRent ," +
                    " EmpPresentSalary,EmpStatus,CompanyId,ActiveSalary,IsActive,PFAmount,SalaryCount having EmpStatus in('1','8') AND ActiveSalary='true' AND IsActive='1' AND " + condition + " order by SN";

                SQLOperation.selectBySetCommandInDatatable("select distinct EmpCardNo,EmpName, max(SN) as SN,EmpType,EmpStatus,EmpTypeId,BasicSalary,MedicalAllownce,TechnicalAllownce,HouseRent ,FoodAllownce,ConvenceAllownce,EmpPresentSalary,CompanyId," +
                    " ActiveSalary,IsActive,PFAmount,case when SalaryCount='False' Then 'Cash' Else case when SalaryCount='True' then 'Bank' else 'Check' End End As SalaryCount from v_Personnel_EmpCurrentStatus group by EmpCardNo,EmpName,EmpTypeId,EmpType,DptId,BasicSalary,FoodAllownce,ConvenceAllownce,TechnicalAllownce,MedicalAllownce,HouseRent ," +
                    " EmpPresentSalary,EmpStatus,CompanyId,ActiveSalary,IsActive,PFAmount,SalaryCount having EmpStatus in('1','8') AND ActiveSalary='true' AND IsActive='1' AND "+ condition+ " order by SN ", dt = new DataTable(), sqlDB.connection);
                gvSalaryList.DataSource = dt;
                gvSalaryList.DataBind();
                ViewState["__IsChanged__"] = "no";
            }
            catch { }
        }

        protected void tc1_ActiveTabChanged(object sender, EventArgs e)
        {

            if (tc1.ActiveTabIndex == 1)
            {
                txtFinding.Visible = true;
                if (gvSalaryList.Rows.Count == 0 || ViewState["__IsChanged__"].ToString().Equals("yes")) loadSalaryInfo(ddlCompanyList2.SelectedValue);
            }
            else txtFinding.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
        }

        protected void gvSalaryList_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    if (ViewState["__UpdateAction__"].ToString().Equals("0"))
                    {
                        Button btn = (Button)e.Row.FindControl("btnEdit");
                        btn.Enabled = false;
                        btn.ForeColor = Color.Silver;
                    }

                }
                catch { }
            
        }
        

        protected void gvSalaryList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {

                int rIndex = Convert.ToInt32(e.CommandArgument.ToString());
                string SN = gvSalaryList.DataKeys[rIndex].Values[0].ToString();
                if (e.CommandName == "Alter")
                {            
                    ddlEmpCardNo.SelectedValue = SN;
                    IndividualSalary();               
                    tc1.ActiveTabIndex = 0;
                    txtFinding.Visible = false;
                    btnSave.Enabled = true;
                    btnSave.CssClass = "Pbutton";
                }
            }
            catch { }
        }


        private void SetConstraint(string EmpTypeId)
        {
            try
            {



                // here 0=Percentage 1=Amount 2=Not Count

                // 0=SalaryType, 1=Basic, 2=MedicalAllownce, 3=FoodAllownce, 4=ConvenceAllownce, 5=TechnicalAllowance, 6=HouseRent, 7=OthersAllowance, 8=PFAllowance

                DataRow[] dr ;
                dr = dt_AllowanceSettings.Select("EmpTypeId="+EmpTypeId+"");
                if (dr.Length >=1)
                {

                    ViewState["__AlCalId__"] = dr[0]["AlCalId"].ToString();
                  
                    

                    if (dr[0]["BasicStatus"].ToString() == "0") // 0 =% 
                    {
                        lblBasic.Text = " ( " + dr[0]["BasicAllowance"].ToString() + " % )";
                        lblBasic.ForeColor = System.Drawing.Color.Blue;
                        hdfBasic.Value = dr[0]["BasicAllowance"].ToString();
                    }
                    else if (dr[0]["BasicStatus"].ToString() == "1") // 1 =৳
                    {
                        lblBasic.Text = " ( ৳ )";
                        lblBasic.ForeColor = System.Drawing.Color.Green;
                        if (hfIsGarments.Value == "1")
                        {
                            if (txtBasic.Text.Trim() == "0" || txtBasic.Text.Trim() == " ")
                            {
                                txtBasic.Text = dr[0]["BasicAllowance"].ToString();
                            }
                        }
                    }

                    else  // 2 =x
                    {
                        lblBasic.Text = " ( x )";
                        lblBasic.ForeColor = System.Drawing.Color.Red;
                    }
                    //--------------------------------End Basic Allowance Part---------------------------------------

                    if (dr[0]["MedicalStatus"].ToString() == "0") // 0 =% 
                    {
                        lblMedical.Text = " ( " + dr[0]["MedicalAllownce"].ToString() + " % )";
                        lblMedical.ForeColor = System.Drawing.Color.Blue;
                        hdfMedical.Value = dr[0]["MedicalAllownce"].ToString();
                    }
                    else if (dr[0]["MedicalStatus"].ToString() == "1") // 1 =৳
                    {
                        lblMedical.Text = " ( ৳ )";
                        lblMedical.ForeColor = System.Drawing.Color.Green;
                        txtMedical.Enabled = true;

                        if (txtMedical.Text.Trim() == "0" || txtMedical.Text.Trim() == " ")
                        {
                            txtMedical.Text = dr[0]["TechnicalAllowance"].ToString();
                        }


                    }

                    else  // 2 =x
                    {
                        lblMedical.Text = " ( x )";
                        lblMedical.ForeColor = System.Drawing.Color.Red;
                       
                    }
                    //--------------------------------End Medical Allowance Part---------------------------------------

                    if (dr[0]["FoodStatus"].ToString() == "0") // 0 =% 
                    {
                        lblFood.Text = " ( " + dr[0]["FoodAllownce"].ToString() + " % )";
                        lblFood.ForeColor = System.Drawing.Color.Blue;
                        hdfFoodAllowance.Value = dr[0]["FoodAllownce"].ToString();
                    }
                    else if (dr[0]["FoodStatus"].ToString() == "1") // 1 =৳
                    {
                        lblFood.Text = " ( ৳ )";
                        lblFood.ForeColor = System.Drawing.Color.Green;
                        //if (hfIsGarments.Value == "1")
                        //{
                        if (txtFoodAllowance.Text.Trim() == "0" || txtFoodAllowance.Text.Trim() == " ")
                            txtFoodAllowance.Text = dr[0]["FoodAllownce"].ToString();
                            
                        //}
                    }

                    else  // 2 =x
                    {
                        lblFood.Text = " ( x )";
                        lblFood.ForeColor = System.Drawing.Color.Red;
                      
                    }
                    //--------------------------------End Food Allowance Part---------------------------------------

                    if (dr[0]["ConStatus"].ToString() == "0") // 0 =% 
                    {
                        lblConveyance.Text = " ( " + dr[0]["ConvenceAllownce"].ToString() + " % )";
                        lblConveyance.ForeColor = System.Drawing.Color.Blue;
                        hdfConveyance.Value = dr[0]["ConvenceAllownce"].ToString();
                    }
                    else if (dr[0]["ConStatus"].ToString() == "1") // 1 =৳
                    {
                        lblConveyance.Text = " ( ৳ )";
                        lblConveyance.ForeColor = System.Drawing.Color.Green;
                        //if (hfIsGarments.Value == "1")
                        //{
                        if (txtConveyanceAllow.Text.Trim() == "0" || txtConveyanceAllow.Text.Trim() == " ")
                        {                     
                            txtConveyanceAllow.Text = dr[0]["ConvenceAllownce"].ToString();
                        }
                        //}
                    }

                    else  // 2 =x
                    {
                        lblConveyance.Text = " ( x )";
                        lblConveyance.ForeColor = System.Drawing.Color.Red;
                    }
                    //--------------------------------End Convence Allowance Part---------------------------------------

                    if (dr[0]["TecStatus"].ToString() == "0") // 0 =% 
                    {
                        lblTechnical.Text = " ( " + dr[0]["TechnicalAllowance"].ToString() + " % )";
                        lblTechnical.ForeColor = System.Drawing.Color.Blue;
                        hdfTechnical.Value = dr[0]["TechnicalAllowance"].ToString();
                    }
                    else if (dr[0]["TecStatus"].ToString() == "1") // 1 =৳
                    {
                        lblTechnical.Text = " ( ৳ )";
                        lblTechnical.ForeColor = System.Drawing.Color.Green;
                        txtTechnicalAllow.Enabled = true;

                         if (txtTechnicalAllow.Text.Trim() == "0" || txtTechnicalAllow.Text.Trim() == " ")
                           {
                                txtTechnicalAllow.Text = dr[0]["TechnicalAllowance"].ToString();
                           }


                    }

                    else  // 2 =x
                    {
                        lblTechnical.Text = " ( x )";
                        lblTechnical.ForeColor = System.Drawing.Color.Red;
                    }
                    //--------------------------------End Technical Allowance Part---------------------------------------

                    if (dr[0]["HouseStatus"].ToString() == "0") // 0 =% 
                    {
                        lblHouseRent.Text = " ( " + dr[0]["HouseRent"].ToString() + " % )";
                        lblHouseRent.ForeColor = System.Drawing.Color.Blue;
                        hdfhouserent.Value = dr[0]["HouseRent"].ToString();
                    }
                    else if (dr[0]["HouseStatus"].ToString() == "1") // 1 =৳
                    {
                        lblHouseRent.Text = " ( ৳ )";
                        lblHouseRent.ForeColor = System.Drawing.Color.Green;

                        //if (hfIsGarments.Value == "1")
                        //{
                       if (txtHouseRent.Text.Trim() == "0" || txtHouseRent.Text.Trim() == " ")
                          {
                            txtHouseRent.Text = dr[0]["HouseRent"].ToString();
                         }
                        //}
                    }

                    else  // 2 =x
                    {
                        lblHouseRent.Text = " ( x )";
                        lblHouseRent.ForeColor = System.Drawing.Color.Red;
                    }
                    //--------------------------------End House Rent Allowance Part---------------------------------------

                    if (dr[0]["OthStatus"].ToString() == "0") // 0 =% 
                    {
                        txtOthers.Enabled = false;
                        lblOthers.Text = " ( " + dr[0]["OthersAllowance"].ToString() + " % )";
                        lblOthers.ForeColor = System.Drawing.Color.Blue;
                        hdfOthers.Value = dr[0]["OthersAllowance"].ToString();
                    }
                    else if (dr[0]["OthStatus"].ToString() == "1") // 1 =৳
                    {
                        lblOthers.Text = " ( ৳ )";
                        lblOthers.ForeColor = System.Drawing.Color.Green;
                        txtOthers.Enabled = true;
                        if (txtOthers.Text.Trim() == "0" || txtOthers.Text.Trim() == " ")
                        {
                            txtOthers.Text = dr[0]["OthersAllowance"].ToString();
                        }
                    }

                    else  // 2 =x
                    {
                        txtOthers.Enabled = false;
                        lblOthers.Text = " ( x )";
                        lblOthers.ForeColor = System.Drawing.Color.Red;
                    }
                    //--------------------------------End Others Rent Allowance Part---------------------------------------


                    if (dr[0]["PFStatus"].ToString() == "0") // 0 =% 
                    {
                        lblPF.Text = " ( " + dr[0]["PFAllowance"].ToString() + " % )";
                        lblPF.ForeColor = System.Drawing.Color.Blue;
                        hdfPF.Value = dr[0]["PFAllowance"].ToString();
                    }
                    else if (dr[0]["PFStatus"].ToString() == "1") // 1 =৳
                    {
                        lblPF.Text = " ( ৳ )";
                        lblPF.ForeColor = System.Drawing.Color.Green;

                        //if (hfIsGarments.Value == "1")
                        //{
                        //if (txtPFAmount.Text.Trim() == "0" || txtPFAmount.Text.Trim() == " ")
                        //    {
                                txtPFAmount.Text = dr[0]["PFAllowance"].ToString();
                        //    }
                        //}
                    }

                    else  // 2 =x
                    {
                        lblPF.Text = " ( x )";
                        lblPF.ForeColor = System.Drawing.Color.Red;
                    }
                    //--------------------------------End Provident Fund Allowance Part---------------------------------------


                    hfBasicStatus.Value = dr[0]["BasicStatus"].ToString();
                    hfMedicalStatus.Value = dr[0]["MedicalStatus"].ToString();
                    hfFoodStatus.Value = dr[0]["FoodStatus"].ToString();
                    hfConveyanceStatus.Value = dr[0]["ConStatus"].ToString();
                    hfTechnicalStatus.Value = dr[0]["TecStatus"].ToString();
                    hfHouseStatus.Value = dr[0]["HouseStatus"].ToString();
                    hfOthersStatus.Value = dr[0]["OthStatus"].ToString();
                    hfPFStatus.Value = dr[0]["PFStatus"].ToString();
                }
                else
                {
                    lblMessage.InnerText = "error->Please set the salary constrant before salary set.";
                }
            }
            catch { }
        }      

        private void checkInitialPermission()
        {
            if (ViewState["__WriteAction__"].ToString().Equals("0"))
            {
                btnSave.Enabled = false;
                btnSave.CssClass = "";
            }
            else
            {
                btnSave.Enabled = true;
                btnSave.CssClass = "Pbutton";
            }
        }
     
      
    }
}