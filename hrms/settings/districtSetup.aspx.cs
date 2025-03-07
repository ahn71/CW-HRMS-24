﻿using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace SigmaERP.hrms.settings
{
    public partial class districtSetup : System.Web.UI.Page
    {
        //permission(View=219 add=220 Edit=221 Delete =222)
        string sqlcmd = "";
        protected void Page_Load(object sender, EventArgs e)
        {


            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            lblMessage.InnerText = "";
            if (!IsPostBack)
            {
                ViewState["__ReadAction__"] = "0";
                ViewState["__WriteAction__"] = "0";
                ViewState["__UpdateAction__"] = "0";
                ViewState["__DeletAction__"] = "0";
                int[] pagePermission = { 219, 220, 221, 222 };
                int[] userPagePermition = AccessControl.hasPermission(pagePermission);
                if (!userPagePermition.Any())
                    Response.Redirect(Routing.defualtUrl);
                setPrivilege(userPagePermition);

                txtDistrictName.Focus();
                loadDistrict_Config();
            }
        }
        private void setPrivilege(int[] permission)
        {
            try
            {

                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                string[] AccessPermission = new string[0];
                AccessPermission = checkUserPrivilege.checkUserPrivilegeForSettigs(getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "district_Config.aspx", gvDistrictList, btnSave);

                if (permission.Contains(219))
                    ViewState["__ReadAction__"] = "1";
                if (permission.Contains(220))
                    ViewState["__WriteAction__"] = "1";
                if (permission.Contains(221))
                    ViewState["__UpdateAction__"] = "1";
                if (permission.Contains(222))
                    ViewState["__DeletAction__"] = "1";
                checkInitialPermission();

            }
            catch { }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (btnSave.Text == "Update") UpdateDistrict_Config();
            else SaveDistrict_Config();
        }
        private void SaveDistrict_Config()
        {
            try
            {
                string[] getColumns = { "Division", "DstName", "DstBangla" };
                string[] getValues = { dlDivision.SelectedValue, txtDistrictName.Text.Trim(), txtDistrictNameBn.Text.Trim() };
                if (SQLOperation.forSaveValue("HRD_District", getColumns, getValues, sqlDB.connection) == true)
                {
                    AllClear();
                    loadDistrict_Config();
                    lblMessage.InnerText = "success->Successfully Saved";
                }

            }
            catch (Exception ex)
            {
                lblMessage.InnerText = ex.Message;

            }
        }
        private void UpdateDistrict_Config()
        {
            try
            {
                string[] getColumns = { "Division", "DstName", "DstBangla" };
                string[] getValues = { dlDivision.SelectedValue, txtDistrictName.Text.Trim(), txtDistrictNameBn.Text.Trim() };
                string getIdentifierValue = ViewState["__DstId__"].ToString();
                if (SQLOperation.forUpdateValue("HRD_District", getColumns, getValues, "DstId", getIdentifierValue, sqlDB.connection) == true)
                {
                    loadDistrict_Config();
                    AllClear();
                    lblMessage.InnerText = "success->Successfully Updated";
                }

            }
            catch (Exception ex)
            {
                lblMessage.InnerText = ex.Message;

            }
        }
        private void AllClear()
        {
            hdnbtnStage.Value = "";
            hdnUpdate.Value = "";
            txtDistrictName.Text = "";
            txtDistrictNameBn.Text = "";
            if (ViewState["__WriteAction__"].Equals("0"))
            {
                btnSave.Enabled = false;
                btnSave.CssClass = "";
            }
            else
            {
                btnSave.Enabled = true;
                btnSave.CssClass = "Rbutton";
            }
            btnSave.Text = "Save";
        }


        private void loadDistrict_Config()
        {

            sqlcmd = "SELECT * FROM HRD_District where Division='" + dlDivision.SelectedItem.Text.Trim() + "'";
            DataTable dt = new DataTable();
            sqlDB.fillDataTable(sqlcmd, dt);
            gvDistrictList.DataSource = dt;
            gvDistrictList.DataBind();

        }

        protected void dlDivision_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDistrict_Config();
        }

        protected void gvDistrictList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rIndex = Convert.ToInt32(e.CommandArgument.ToString());
            ViewState["__DstId__"] = gvDistrictList.DataKeys[rIndex].Values[0].ToString();
            if (e.CommandName == "Alter")
            {
                txtDistrictName.Text = gvDistrictList.Rows[rIndex].Cells[1].Text.ToString();
                txtDistrictNameBn.Text = (gvDistrictList.Rows[rIndex].Cells[2].Text.ToString().Equals("&nbsp;")) ? "" : gvDistrictList.Rows[rIndex].Cells[2].Text.ToString();
                if (ViewState["__UpdateAction__"].Equals("0"))
                {
                    btnSave.Enabled = false;
                    btnSave.CssClass = "";
                }
                else
                {
                    btnSave.Enabled = true;
                    btnSave.CssClass = "Rbutton";
                }
                btnSave.Text = "Update";
            }
            else if (e.CommandName == "Delete")
            {
                if (SQLOperation.forDeleteRecordByIdentifier("HRD_District", "DstId", ViewState["__DstId__"].ToString(), sqlDB.connection))
                {
                    lblMessage.InnerText = "success->Successfully Deleted";
                    AllClear();
                    // clear();
                }
            }

        }

        protected void gvDistrictList_RowDataBound(object sender, GridViewRowEventArgs e)
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
            if (ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()).Equals("Admin") || ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()).Equals("Viewer"))
            {
                try
                {
                    if (ViewState["__DeletAction__"].ToString().Equals("0"))
                    {
                        Button lnkDelete = (Button)e.Row.FindControl("btnDelete");
                        lnkDelete.Enabled = false;
                        lnkDelete.OnClientClick = "return false";
                        lnkDelete.ForeColor = Color.Silver;
                    }

                }
                catch { }
                try
                {
                    if (ViewState["__UpdateAction__"].ToString().Equals("0"))
                    {
                        Button lnkDelete = (Button)e.Row.FindControl("btnAlter");
                        lnkDelete.Enabled = false;
                        lnkDelete.ForeColor = Color.Silver;
                    }

                }
                catch { }
            }
        }

        protected void gvDistrictList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            loadDistrict_Config();
        }

        protected void gvDistrictList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            loadDistrict_Config();
            gvDistrictList.PageIndex = e.NewPageIndex;
            gvDistrictList.DataBind();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            AllClear();
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
    }
}