﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using adviitRuntimeScripting;
using ComplexScriptingSystem;
using System.Data;
using System.Data.SqlClient;
using SigmaERP.classes;
using System.Drawing;
using SigmaERP.hrms.BLL;

namespace SigmaERP.personnel
{
    public partial class separation : System.Web.UI.Page
    {
        DataTable dt;
        SqlCommand cmd;
        string query = "";

        // Separation Entry=280,
        //Current Separation  List=281
        //Separation Activation =282
        //Separation Activation Log=283
        protected void Page_Load(object sender, EventArgs e)
        {

            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            lblMessage.InnerText = "";
            if (!IsPostBack)
            {

                ViewState["__SeparationEntry=__"] = "0";
                ViewState["__CurrentSeparationList__"] = "0";
                ViewState["__SeparationActivation__"] = "0";
                ViewState["__SeparationActivationLog__"] = "0";

                int[] pagePermission = { 280, 281, 282, 283 };
                int[] userPagePermition = AccessControl.hasPermission(pagePermission);
                if (!userPagePermition.Any())
                    Response.Redirect(Routing.defualtUrl);
                setPrivilege();
               
                loadSeparationInfo();
               // classes.Employee.LoadEmpCardNo_ForSeperation
                classes.commonTask.loadSeparationType(ddlSeparationType);
                btnDelete.CssClass = "";
                btnDelete.Visible= false;
                if (!classes.commonTask.HasBranch())
                {
                    ddlCompany.Enabled = false;
                    ddlSearchCompany.Enabled = false;
                }

                classes.Employee.LoadEmpCardNo_ForSeperation(ddlEmpCardNo,ddlCompany.SelectedValue);
                if (userPagePermition.Contains(280))
                {
                    tabPanel1.Visible = true;
                }
                else
                {
                    tabPanel1.Visible = false;
                }



                if (userPagePermition.Contains(281))
                    load_CurrentSeperationList();
                if (userPagePermition.Contains(282))
                    load_SeperationListForActivation();
                else
                    tabSeperationActivation.Visible = false;
                if (userPagePermition.Contains(283))
                    load_SeperationActivation_Log();
                else
                    TabPanel2.Visible = false;

            }
        }
        private void setPrivilege()
        {
            try
            {
               
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__G_UserId__"] = getUserId;
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                classes.commonTask.LoadBranch(ddlCompany, ViewState["__CompanyId__"].ToString());
                string[] AccessPermission = new string[0];
                // AccessPermission = checkUserPrivilege.checkUserPrivilegeForSettigs(ViewState["__CompanyId__"].ToString(), getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "separation.aspx", ddlCompany, gvSeparationList, btnSave);

             

                //if (ViewState["__ReadAction__"].ToString().Equals("0"))
                //{
                //    gvCurrentSeperationList.Visible = false;
                //}

                tabSeperationActivation.Visible = true;
               ddlSearchCompany.DataTextField = "Text";
               ddlSearchCompany.DataValueField = "Value";;
               ddlSearchCompany.DataSource = ddlCompany.Items;
               ddlSearchCompany.DataBind();

               ddlCompanyListActive.DataTextField = "Text";
               ddlCompanyListActive.DataValueField = "Value"; ;
               ddlCompanyListActive.DataSource = ddlCompany.Items;
               ddlCompanyListActive.DataBind();

               ddlCompanyCurrentList.DataTextField = "Text";
               ddlCompanyCurrentList.DataValueField = "Value"; ;
               ddlCompanyCurrentList.DataSource = ddlCompany.Items;
               ddlCompanyCurrentList.DataBind();


               ddlCompanyListActiveLog.DataTextField = "Text";
               ddlCompanyListActiveLog.DataValueField = "Value"; ;
               ddlCompanyListActiveLog.DataSource = ddlCompany.Items;
               ddlCompanyListActiveLog.DataBind();


               ddlCompany.SelectedValue = ViewState["__CompanyId__"].ToString();
               ddlSearchCompany.SelectedValue = ViewState["__CompanyId__"].ToString();
               ddlCompanyCurrentList.SelectedValue = ViewState["__CompanyId__"].ToString();
               ddlCompanyListActive.SelectedValue = ViewState["__CompanyId__"].ToString();
               ddlCompanyListActiveLog.SelectedValue = ViewState["__CompanyId__"].ToString(); 
               

            }
            catch { }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
                        
            if (ddlSeparationType.SelectedValue == "50")
            {
                lblMessage.InnerText = "warning->Please Select Separation Type";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                return;
            }
            if (btnSave.Text.Trim().Equals("Save")) 
            {
                string [] EmpCards = ddlEmpCardNo.SelectedValue.ToString().Split('|');
                ViewState["__G_EmpId__"] = EmpCards[0];
                ViewState["__G_EmpCardNo__"] = EmpCards[1];
                ViewState["__G_EmpTypeId__"] = EmpCards[2];
                saveEmpSeparation();
            }               
            else updateEmpSeparation();
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true);
        }

        private void saveEmpSeparation()
        {
            try
            {
               // SQLOperation.selectBySetCommandInDatatable("select EmpId from Personnel_EmployeeInfo where EmpCardNo=" + txtEmpCardNo.Text.Trim() + "", dt = new DataTable(), sqlDB.connection);
                cmd = new SqlCommand("insert into Personnel_EmpSeparation (EmpId,EmpCardNo,EffectiveDate,SeparationType,Remarks,EmpTypeId,EntryDate,IsActive,UserId) values (@EmpId,@EmpCardNo,@EffectiveDate,@SeparationType,@Remarks,@EmpTypeId,@EntryDate,@IsActive,@UserId)", sqlDB.connection);
                cmd.Parameters.AddWithValue("@EmpId", ViewState["__G_EmpId__"].ToString());
                cmd.Parameters.AddWithValue("@EmpCardNo", ViewState["__G_EmpCardNo__"].ToString());
                cmd.Parameters.AddWithValue("@EffectiveDate",convertDateTime.getCertainCulture(txtEffectiveDate.Text));
                cmd.Parameters.AddWithValue("@SeparationType",ddlSeparationType.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@Remarks",txtRemarks.Text.Trim());
                cmd.Parameters.AddWithValue("@EmpTypeId", ViewState["__G_EmpTypeId__"].ToString());
                cmd.Parameters.AddWithValue("@EntryDate",convertDateTime.getCertainCulture(DateTime.Now.ToString("dd-MM-yyyy")));
                //if (txtEffectiveDate.Text.Trim() == DateTime.Now.ToString("dd-MM-yyyy")) cmd.Parameters.AddWithValue("@IsActive",1);
                //else cmd.Parameters.AddWithValue("@IsActive", 0);
                cmd.Parameters.AddWithValue("@IsActive", 0);
                cmd.Parameters.AddWithValue("UserId", ViewState["__G_UserId__"].ToString());
                int result = cmd.ExecuteNonQuery();
                if (result==1)
                {
                  
                    //string[] getMonth=txtEffectiveDate.Text.Split('-');
                    //SqlCommand delcmd = new SqlCommand("Delete From tblAttendanceRecord where ATTDate>'" + getMonth[2] + "-" + getMonth[1] + "-" + getMonth[0] + "'and EmpId='" + ViewState["__G_EmpId__"].ToString() + "'", sqlDB.connection);
                    //delcmd.ExecuteNonQuery();
                    //cmd = new SqlCommand("Update Personnel_EmpCurrentStatus set EmpStatus=" + ddlSeparationType.SelectedValue.ToString() + " where EmpId='" + ViewState["__G_EmpId__"].ToString() + "'", sqlDB.connection);
                    //cmd.ExecuteNonQuery();
                    //cmd = new SqlCommand("Update Personnel_EmployeeInfo set EmpStatus=" + ddlSeparationType.SelectedValue.ToString() + " where EmpId='" + ViewState["__G_EmpId__"].ToString() + "'", sqlDB.connection);
                    //cmd.ExecuteNonQuery();
                    loadSeparationInfo();
                    classes.Employee.LoadEmpCardNo_ForSeperation(ddlEmpCardNo, ddlCompany.SelectedValue);
                    lblMessage.InnerText = "success->Successfully Saved";
                    
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "ClearInputBox();", true);
                }
            }
            catch (Exception ex)
            {
                lblMessage.InnerText = ex.Message;
            }
        }

        private void updateEmpSeparation()
        {
            try
            {
                if (!IsSeparationNotActivated(ViewState["__SeparationId__"].ToString()))
                {
                    lblMessage.InnerText = "warning-> You can't edit this separation, because it's activated already!";
                    return;
                }

                cmd = new SqlCommand("update Personnel_EmpSeparation set  EffectiveDate=@EffectiveDate,SeparationType=@SeparationType,Remarks=@Remarks,IsActive=@IsActive where EmpSeparationId=" + ViewState["__SeparationId__"].ToString() + "", sqlDB.connection);
                cmd.Parameters.AddWithValue("@EffectiveDate", convertDateTime.getCertainCulture(txtEffectiveDate.Text));
                cmd.Parameters.AddWithValue("@SeparationType", ddlSeparationType.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                //if (txtEffectiveDate.Text.Trim() == DateTime.Now.ToString("dd-MM-yyyy")) cmd.Parameters.AddWithValue("@IsActive", 1);
                //else cmd.Parameters.AddWithValue("@IsActive", 0);
                cmd.Parameters.AddWithValue("@IsActive", 0);
                int result = cmd.ExecuteNonQuery();
                if (result == 1)
                {
                    string[] getMonth = txtEffectiveDate.Text.Split('-');
                    //SqlCommand delcmd = new SqlCommand("Delete From tblAttendanceRecord where ATTDate>'" + getMonth[2] + "-" + getMonth[1] + "-" + getMonth[0] + "'and EmpId='" + ViewState["__G_EmpId__"].ToString() + "'", sqlDB.connection);
                    //delcmd.ExecuteNonQuery();

                    //cmd = new SqlCommand("Update Personnel_EmpCurrentStatus set EmpStatus=" + ddlSeparationType.SelectedValue.ToString() + " where EmpCardNo='" + ViewState["__G_EmpCardNo__"] .ToString()+ "' and EmpTypeId=" + ViewState["__G_EmpTypeId__"].ToString()+ "", sqlDB.connection);
                    //cmd.ExecuteNonQuery();
                    //cmd = new SqlCommand("Update Personnel_EmployeeInfo set EmpStatus=" + ddlSeparationType.SelectedValue.ToString() + " where EmpCardNo='" + ViewState["__G_EmpCardNo__"].ToString() + "' and EmpTypeId=" + ViewState["__G_EmpTypeId__"].ToString().ToString()+ "", sqlDB.connection);
                    //cmd.ExecuteNonQuery();
                    loadSeparationInfo();
                    classes.Employee.LoadEmpCardNoWithName(ddlEmpCardNo, ViewState["__G_EmpTypeId__"].ToString());
                    lblMessage.InnerText = "success->Successfully Updated";

                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "ClearInputBox();", true);
                    btnSave.Text = "Save";
                    //if (ViewState["__WriteAction__"].Equals("0"))
                    //{
                    //    btnSave.Enabled = false;
                    //    btnSave.CssClass = "";
                    //}
                    //else
                    //{
                    //    btnSave.Enabled = true;
                    //    btnSave.CssClass = "css_btn Ptbut";
                    //}
                    ddlEmpCardNo.Enabled = true;
                    ddlSeparationType.SelectedIndex = 0;
                    txtEffectiveDate.Text = "";
                    txtRemarks.Text = "";
                }
            }
            catch (Exception ex)
            {
                lblMessage.InnerText = ex.Message;
                loadSeparationInfo();
            }
        }

        private void loadSeparationInfo()
        {
            try
            {
                SQLOperation.selectBySetCommandInDatatable("select EmpSeparationId,EmpId,EmpCardNo,EmpName,EmpTypeId,convert(varchar(11),EffectiveDate,105) as EffectiveDate,EmpStatusName,EmpType,convert(varchar(11),EntryDate,105) as EntryDate,Remarks  from v_Personnel_EmpSeparation where IsActive='false' ", dt = new DataTable(), sqlDB.connection);
                string nnn = "select EmpSeparationId,EmpId,EmpCardNo,EmpName,EmpTypeId,convert(varchar(11),EffectiveDate,105) as EffectiveDate,EmpStatusName,EmpType,convert(varchar(11),EntryDate,105) as EntryDate,Remarks  from v_Personnel_EmpSeparation where IsActive='false'";
                gvSeparationList.DataSource = dt;
                gvSeparationList.DataBind();
            }
            catch { }
        }      

        protected void gvSeparationList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                
                if (e.CommandName == "Alter")
                {
                    string EmpSeparationId = gvSeparationList.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[0].ToString();
                    if (!IsSeparationNotActivated(EmpSeparationId))
                    {
                        lblMessage.InnerText = "warning-> You can't edit this separation, because it's activated already!";
                        return;
                    }
                    string a = gvSeparationList.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[1].ToString();
                   
                  //  txtEmpCardNo.Text = gvSeparationList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;
                    txtEffectiveDate.Text = gvSeparationList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[5].Text;
                    txtRemarks.Text = gvSeparationList.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[2].ToString();

                    if (gvSeparationList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[6].Text.ToLower().Equals("dismissed")) ddlSeparationType.SelectedValue = "3"; 
                    else if (gvSeparationList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[6].Text.ToLower().Equals("resigned")) ddlSeparationType.SelectedValue = "4";
                    else if (gvSeparationList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[6].Text.ToLower().Equals("terminate")) ddlSeparationType.SelectedValue = "5";
                    else if (gvSeparationList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[6].Text.ToLower().Equals("discharged")) ddlSeparationType.SelectedValue = "6";
                    else if (gvSeparationList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[6].Text.ToLower().Equals("unauthorized")) ddlSeparationType.SelectedValue = "7";
                    btnSave.Text = "Update";
                    //if (ViewState["__UpdateAction__"].ToString().Equals("1"))
                    //{
                    //    btnSave.Enabled = true;
                    //    btnSave.CssClass = "css_btn Ptbut";
                    //}
                    //if (ViewState["__DeletAction__"].ToString().Equals("0"))
                    //if (ViewState["__DeletAction__"].ToString().Equals("0"))
                    //{
                    //    btnDelete.Visible = true;
                    //    btnDelete.CssClass = "css_btn Ptbut";
                    //}
                    ViewState["__G_EmpId__"] = gvSeparationList.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[3].ToString();
                    ViewState["__G_EmpCardNo__"] = gvSeparationList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;
                    ViewState["__G_EmpTypeId__"] = gvSeparationList.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[1].ToString();
                    ViewState["__SeparationId__"] = EmpSeparationId;
                   // 00000005|AHG2016010004|2
                  //  int aa = ddlEmpCardNo.Items.Count;
                  //  string ddlValue=ViewState["__G_EmpId__"].ToString()+"|"+ViewState["__G_EmpCardNo__"].ToString()+"|"+ViewState["__G_EmpTypeId__"].ToString();
                   // ddlEmpCardNo.SelectedIndex = 1;
                  //  ddlEmpCardNo.SelectedItem.Value = ddlValue;
                  //  ddlEmpCardNo.SelectedValue = ddlValue;
                    ddlEmpCardNo.Enabled = false;
                }
                else if (e.CommandName == "Remove")
                {
                    string EmpSeparationId = gvSeparationList.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[0].ToString();
                    if (!IsSeparationNotActivated(EmpSeparationId))
                    {
                        lblMessage.InnerText = "warning-> You can't delete this separation, because it's activated already!";
                        return;
                    }
                        if (SQLOperation.forDeleteRecordByIdentifier("Personnel_EmpSeparation", "EmpSeparationId", gvSeparationList.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[0].ToString(), sqlDB.connection))
                        {
                            classes.Employee.LoadEmpCardNo_ForSeperation(ddlEmpCardNo, ddlCompany.SelectedValue);
                            lblMessage.InnerText = "success-> Successfully Deleted.";
                            gvSeparationList.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Visible = false;
                        }
                   
                                       
  
                }
                
            }
            catch { }
        }
        private bool IsSeparationNotActivated(string EmpSeparationId)
        {
            try
            {
                dt = new DataTable();
                sqlDB.fillDataTable("select EmpSeparationId from Personnel_EmpSeparation where EmpSeparationId=" + EmpSeparationId + " and IsActive=0", dt);
                if (dt != null && dt.Rows.Count > 0)
                    return true;
                return false;
            }
            catch (Exception ex){ return false; }
        }
        protected void gvSeparationList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                loadSeparationInfo();
            }
            catch { }
            gvSeparationList.PageIndex = e.NewPageIndex;
            Session["pageNumber"] = e.NewPageIndex;
            gvSeparationList.DataBind();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
            btnSave.Text = "Save";
            ddlEmpCardNo.Enabled = true;
        }

        protected void btnFind_Click(object sender, EventArgs e)
        {
            try
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                if(txtSearchEmp.Text.Trim()=="")
                {
                    lblMessage.InnerText = "warning->Please type valid card no.";
                    txtSearchEmp.Focus();
                    return;
                }
                
                SQLOperation.selectBySetCommandInDatatable("select EmpSeparationId,EmpId,EmpCardNo,EmpName,EmpTypeId,convert(varchar(11),EffectiveDate,105) as EffectiveDate,EmpStatusName,EmpType,convert(varchar(11),EntryDate,105) as EntryDate,Remarks  from v_Personnel_EmpSeparation where CompanyId='" + ddlSearchCompany.SelectedValue + "' and EmpCardNo like '%" + txtSearchEmp.Text.Trim() + "' And IsActive='false'", dt = new DataTable(), sqlDB.connection);

                gvSeparationList.DataSource = dt;
                gvSeparationList.DataBind();
                if (dt.Rows.Count == 0)
                    lblMessage.InnerText = "warning->"+txtSearchEmp.Text+" Not Found";
            }
            catch { }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            txtSearchEmp.Text = "";
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
            
            loadSeparationInfo();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {                
                SqlCommand cmd = new SqlCommand("Delete From Personnel_EmpSeparation where EmpSeparationId=" + ViewState["__SeparationId__"].ToString() + "", sqlDB.connection);
                int result = cmd.ExecuteNonQuery();
                if (result==1)
                {
                    cmd = new SqlCommand("Update Personnel_EmpCurrentStatus set EmpStatus=1 where EmpCardNo='" + ViewState["__G_EmpCardNo__"].ToString() + "' and EmpTypeId=" + ViewState["__G_EmpTypeId__"].ToString() + "", sqlDB.connection);
                    cmd.ExecuteNonQuery();
                    cmd = new SqlCommand("Update Personnel_EmployeeInfo set EmpStatus=1 where EmpCardNo='" + ViewState["__G_EmpCardNo__"].ToString() + "' and EmpTypeId=" + ViewState["__G_EmpTypeId__"].ToString() + "", sqlDB.connection);
                    cmd.ExecuteNonQuery();
                    loadSeparationInfo();
                   
                    lblMessage.InnerText = "success->Successfully Deleted";

                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "ClearInputBox();", true);
                    btnDelete.Visible = false;
                    btnDelete.CssClass = "";
                    ddlEmpCardNo.Enabled = true;
                }
            }
            catch { }
        }

        private void load_CurrentSeperationList()
        {
            
            try
            {
                string CompanyId = (ddlCompanyCurrentList.SelectedValue == "0000") ? ViewState["__CompanyId__"].ToString() : ddlCompanyCurrentList.SelectedValue;
                string condition = AccessControl.getDataAccessCondition(CompanyId,"0");
                dt = new DataTable();

                //string query = "select EmpId,Substring(EmpCardNo,8,10) as EmpCardNo,EmpName,Convert(varchar,EffectiveDate,100) as  EffectiveDate,EmpStatus,EmpStatusName," +
                //    " EmpType,EmpTypeId,Convert(varchar,EntryDate,100) as  EntryDate,(FirstName+' '+LastName) as UserName,Remarks from v_Personnel_EmpSeparation " +
                //    "where IsActive='True' and  " + condition + "";
                if (txtCardNoSpFilter.Text.Trim().Length > 0)
                {
                    condition += "and pecs.EmpCardNo like'%" + txtCardNoSpFilter.Text.Trim() + "'";
                }

                string query = @"SELECT 
                            pes.EmpId,
                            SUBSTRING(pecs.EmpCardNo, 8, 10) AS EmpCardNo,
                            pei.EmpName,
                            CONVERT(VARCHAR, pes.EffectiveDate, 100) AS EffectiveDate,
                            pecs.EmpStatus,
                            es.EmpStatusName,
                            Etyp.EmpType,
                            pes.EmpTypeId,
                            CONVERT(VARCHAR, pes.EntryDate, 100) AS EntryDate,
                            pes.UserId,
                            CASE 
                                WHEN ISNULL(creator.EmpName, '') = '' THEN (us.FirstName + ' ' + us.LastName)
                                ELSE creator.EmpName
                            END AS UserName,
                            pes.Remarks
                        FROM 
                            Personnel_EmpSeparation AS pes
                        INNER JOIN 
                            Personnel_EmpCurrentStatus AS pecs ON pes.EmpId = pecs.EmpId
                        LEFT JOIN 
                            Users AS us ON pes.UserId = us.UserId
                        INNER JOIN 
                            Personnel_EmployeeInfo AS pei ON pes.EmpId = pei.EmpId
                        INNER JOIN 
                            HRD_EmployeeType AS Etyp ON pes.EmpTypeId = Etyp.EmpTypeId
                        INNER JOIN 
                            Hrd_EmpStatus AS es ON pecs.EmpStatus = es.EmpStatus
                        LEFT JOIN 
                            Personnel_EmployeeInfo AS creator ON creator.EmpId = us.ReferenceID 
	                        where pes.IsActive=1 and pecs."+condition+"";
                sqlDB.fillDataTable(query, dt);               
                gvCurrentSeperationList.DataSource = dt;
                gvCurrentSeperationList.DataBind();
            }
            catch { }
        }

        private void load_SeperationListForActivation()
        {
            try
            {
                string dateRange = "";
                if (txtFromDate.Text.Length != 0 && txtToDate.Text.Length != 0)
                {
                    string[] Fdate = txtFromDate.Text.Trim().Split('-');
                    string[] Tdate = txtToDate.Text.Trim().Split('-');
                    dateRange = " and EffectiveDate>='"+ Fdate [2]+ "-"+ Fdate [1]+ "-"+ Fdate [0]+ "' and EffectiveDate<='" + Tdate[2] + "-" + Tdate[1] + "-" + Tdate[0] + "' ";
                }
                string CompanyId = (ddlCompanyListActive.SelectedValue == "0000") ? ViewState["__CompanyId__"].ToString(): ddlCompanyListActive.SelectedValue;
                string condition = AccessControl.getDataAccessCondition(CompanyId,"0");
                dt = new DataTable();
                if (txtEmpCardNo.Text.Trim().Length == 0)
                    query = " select  EmpSeparationId,EmpId,Substring(EmpCardNo,8,10) as EmpCardNo,EmpName,EmpType,DptName,DsgName,EmpStatusName, convert(VARCHAR(10),EffectiveDate, 105) AS EffectiveDate, convert(VARCHAR(10), GETDATE(), 105) AS CurrentDate  " +
                    "from v_Personnel_EmpSeparation  " +
                    "where EmpSeparationId in ( select max(EmpSeparationId) from v_Personnel_EmpSeparation  where CompanyId='" + CompanyId + "' group by EmpId) " +
                    "and Empid not In(select EmpId from Personnel_EmpCurrentStatus where CompanyId='" + CompanyId + "' and EmpStatus=1 and IsActive=1) " + dateRange +
                    " and  "+ condition + " order by EffectiveDate desc,EmpSeparationId desc";
                else
                    query = " select  EmpSeparationId,EmpId,Substring(EmpCardNo,8,10) as EmpCardNo,EmpName,EmpType,DptName,DsgName,EmpStatusName, convert(VARCHAR(10),EffectiveDate, 105) AS EffectiveDate, convert(VARCHAR(10), GETDATE(), 105) AS CurrentDate  " +
                    "from v_Personnel_EmpSeparation  " +
                    "where EmpSeparationId in ( select max(EmpSeparationId) from v_Personnel_EmpSeparation  where CompanyId='" + CompanyId + "' and EmpCardNo like'%" + txtEmpCardNo.Text.Trim() + "' group by EmpId) " +
                    "and Empid not In(select EmpId from Personnel_EmpCurrentStatus where CompanyId='" + CompanyId + "' and EmpCardNo like'%" + txtEmpCardNo.Text.Trim() + "' and EmpStatus=1 and IsActive=1) " +
                    " and  "+ condition + " order by EffectiveDate desc,EmpSeparationId desc";

                sqlDB.fillDataTable(query, dt);

                gvCurrentSeperationListForActivation.DataSource = dt;
                gvCurrentSeperationListForActivation.DataBind();
            }
            catch { }
        }
        private void load_SeperationActivation_Log()
        {
            try
            {
                string CompanyId = (ddlCompanyListActiveLog.SelectedValue == "0000") ? ViewState["__CompanyId__"].ToString() : ddlCompanyListActiveLog.SelectedValue;
                string condition = AccessControl.getDataAccessCondition(CompanyId, "0");
                dt = new DataTable();
                if (txtCardnoActive.Text.Trim().Length == 0)
                {
                    //this query for testing 

                    //query = "select SUBSTRING(v_EmployeeDetails.EmpCardNo,8,10) as EmpCardNo ,v_EmployeeDetails.EmpName,EmpType,DptName,DsgName,format(ActiveDate,'dd-MM-yyyy') as ActiveDate, CASE WHEN ISNULL(creator.EmpName, '') = '' THEN (us.FirstName + ' ' + us.LastName) ELSE creator.EmpName END AS UName, Remark from Personnel_SeparationActivation_Log as psal inner join v_EmployeeDetails on psal.EmpId=v_EmployeeDetails.EmpId inner join Users as us  on psal.UserId=us.UserId left join Personnel_EmployeeInfo AS creator ON creator.EmpId = us.ReferenceID  where v_EmployeeDetails.CompanyId= " + condition + " order by ActiveDate desc";

                    query = @"select SUBSTRING(pei.EmpCardNo,8,10) as EmpCardNo ,pei.EmpName,Etyp.EmpType,dpt.DptName,dsg.DsgName,format(ActiveDate,'dd-MM-yyyy') as ActiveDate, CASE WHEN ISNULL(creator.EmpName, '') = '' THEN (us.FirstName + ' ' + us.LastName) ELSE creator.EmpName END AS UName, Remark from Personnel_SeparationActivation_Log as psal inner join Personnel_EmployeeInfo as pei on psal.EmpId=pei.EmpId inner join Users as us  on psal.UserId=us.UserId left join Personnel_EmpCurrentStatus as pecs on psal.EmpId=pecs.EmpId  left join Personnel_EmployeeInfo AS creator ON creator.EmpId = us.ReferenceID INNER JOIN 
                      HRD_EmployeeType AS Etyp ON pei.EmpTypeId = Etyp.EmpTypeId
				      Inner Join HRD_Designation as dsg on pecs.DsgId=dsg.DsgId
					  Inner Join HRD_Department as dpt on pecs.DptId=dpt.DptId where pei."+ condition + " order by ActiveDate desc";

                    sqlDB.fillDataTable(query, dt);
                }
                else
                {
                    query = @"select SUBSTRING(pei.EmpCardNo,8,10) as EmpCardNo ,pei.EmpName,Etyp.EmpType,dpt.DptName,dsg.DsgName,format(ActiveDate,'dd-MM-yyyy') as ActiveDate, CASE WHEN ISNULL(creator.EmpName, '') = '' THEN (us.FirstName + ' ' + us.LastName) ELSE creator.EmpName END AS UName, Remark from Personnel_SeparationActivation_Log as psal inner join Personnel_EmployeeInfo as pei on psal.EmpId=pei.EmpId inner join Users as us  on psal.UserId=us.UserId left join Personnel_EmpCurrentStatus as pecs on psal.EmpId=pecs.EmpId  left join Personnel_EmployeeInfo AS creator ON creator.EmpId = us.ReferenceID INNER JOIN 
                      HRD_EmployeeType AS Etyp ON pei.EmpTypeId = Etyp.EmpTypeId
				      Inner Join HRD_Designation as dsg on pecs.DsgId=dsg.DsgId
					  Inner Join HRD_Department as dpt on pecs.DptId=dpt.DptId where pei." + condition + " and pei.EmpCardNo like'%" + txtCardnoActive.Text.Trim() + "' order by ActiveDate desc";

                    //query = "select SUBSTRING(EmpCardNo,8,10) as EmpCardNo ,EmpName,EmpType,DptName,DsgName,format(ActiveDate,'dd-MM-yyyy') as ActiveDate," +
                    //    "FirstName+' '+LastName as UName,Remark from Personnel_SeparationActivation_Log inner join v_EmployeeDetails on " +
                    //    "Personnel_SeparationActivation_Log.EmpId=v_EmployeeDetails.EmpId inner join UserAccount " +
                    //    " on Personnel_SeparationActivation_Log.UserId=UserAccount.UserId " +
                    //    "where  EmpCardNo like'%" + txtCardnoActive.Text.Trim() + "' and  " + condition + " " +
                    //    "order by ActiveDate desc";
                    sqlDB.fillDataTable(query, dt);

                   
                }
                gvSeparationActivitionLog.DataSource = dt;
                gvSeparationActivitionLog.DataBind();
            }
            catch { }
        }
        protected void gvSeparationList_RowDataBound(object sender, GridViewRowEventArgs e)
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

                    //if (ViewState["__UpdateAction__"].ToString().Equals("0"))
                    //{
                    //    Button btnAlter = new Button();
                    //    btnAlter = (Button)e.Row.FindControl("btnAlter");
                    //    btnAlter.Enabled = false;
                    //    btnAlter.ForeColor = Color.Silver;
                    //}

                }
                catch { }
            
        }

        protected void gvCurrentSeperationList_RowDataBound(object sender, GridViewRowEventArgs e)
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
            
        }

        protected void ddlCompanyListActive_SelectedIndexChanged(object sender, EventArgs e)
        {
            load_SeperationListForActivation();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            load_SeperationListForActivation();
        }

        protected void ddlCompanyCurrentList_SelectedIndexChanged(object sender, EventArgs e)
        {
            load_CurrentSeperationList();
        }

        protected void gvCurrentSeperationListForActivation_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                load_SeperationListForActivation();
            }
            catch { }
            gvCurrentSeperationListForActivation.PageIndex = e.NewPageIndex;
            gvCurrentSeperationListForActivation.DataBind();
        }

        protected void gvCurrentSeperationList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                load_CurrentSeperationList();
            }
            catch { }
            gvCurrentSeperationList.PageIndex = e.NewPageIndex;
            gvCurrentSeperationList.DataBind();
        }

        protected void gvCurrentSeperationListForActivation_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Active") 
            {
                int rIndex = Convert.ToInt32(e.CommandArgument.ToString());
                string EmpSeparationID = gvCurrentSeperationListForActivation.DataKeys[rIndex].Values[0].ToString();
                string EmpID = gvCurrentSeperationListForActivation.DataKeys[rIndex].Values[1].ToString();
                TextBox txtActiveDate = gvCurrentSeperationListForActivation.Rows[rIndex].FindControl("txtActiveDate") as TextBox;
                TextBox txtRemarks = gvCurrentSeperationListForActivation.Rows[rIndex].FindControl("txtRemarks") as TextBox;
                if (SeparationActivation(EmpID))
                    saveSeparationActivation_Log(EmpID,EmpSeparationID,txtActiveDate.Text.Trim(),txtRemarks.Text.Trim());
                else
                    lblMessage.InnerText="Error-> Unable to Active !";

            }
        }

        private bool SeparationActivation(string EmpId)
        {
            try
            {
                SqlCommand cmd2;
                cmd = new SqlCommand("Update  Personnel_EmployeeInfo set EmpStatus=1 where EmpId='" + EmpId + "'", sqlDB.connection);
                cmd2 = new SqlCommand("Update  Personnel_EmpCurrentStatus set EmpStatus=1 where SN= (select Max(SN) from Personnel_EmpCurrentStatus where EmpId='" + EmpId + "')", sqlDB.connection);
                

                if (int.Parse(cmd.ExecuteNonQuery().ToString()) == 1 && int.Parse(cmd2.ExecuteNonQuery().ToString())==1)
                    return true;
                else
                    return false;             
                
            }
            catch (Exception ex)
            {
                lblMessage.InnerText = ex.Message;
                return false;
            }
        }
        
        private void saveSeparationActivation_Log(string EmpId,string SeparationID,string ActiveDate,string Remark)
        {
            try
            {
                
                cmd = new SqlCommand("insert into Personnel_SeparationActivation_Log (EmpId,EmpSeparationId,ActiveDate,Remark,UserId) values (@EmpId,@EmpSeparationId,@ActiveDate,@Remark,@UserId)", sqlDB.connection);
                cmd.Parameters.AddWithValue("@EmpId", EmpId);
                cmd.Parameters.AddWithValue("@EmpSeparationId", SeparationID);
                cmd.Parameters.AddWithValue("@ActiveDate", convertDateTime.getCertainCulture(ActiveDate));
                cmd.Parameters.AddWithValue("@Remark", Remark);               
                cmd.Parameters.AddWithValue("UserId", ViewState["__G_UserId__"].ToString());
                int result = cmd.ExecuteNonQuery();
                if (result == 1)
                {
                    lblMessage.InnerText = "success->Successfully Actived";
                    load_SeperationListForActivation();
                    load_SeperationActivation_Log();
                }                 

            }
            catch (Exception ex)
            {
                lblMessage.InnerText = ex.Message;
            }
        }

        protected void gvSeparationActivitionLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

                     try
            {
                 load_SeperationActivation_Log();
            }
            catch { }
            gvSeparationActivitionLog.PageIndex = e.NewPageIndex;
            gvSeparationActivitionLog.DataBind();
        }

        protected void ddlCompanyListActiveLog_SelectedIndexChanged(object sender, EventArgs e)
        {
             load_SeperationActivation_Log();
        }

        protected void btnSearchLog_Click(object sender, EventArgs e)
        {
            load_SeperationActivation_Log();
        }

  

        protected void gvCurrentSeperationListForActivation_RowDataBound(object sender, GridViewRowEventArgs e)
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
         
                Button btn;
               
                try
                {
                    //if (ViewState["__WriteAction__"].ToString().Equals("0"))
                    //{
                    //    btn = new Button();
                    //    btn = (Button)e.Row.FindControl("btnActive");
                    //    btn.Enabled = false;
                    //    btn.ForeColor = Color.Silver;
                    //}

                }
                catch { }
            }


        protected void btnSplSearch_Click(object sender, EventArgs e)
        {
            load_CurrentSeperationList();
        }
    }
}