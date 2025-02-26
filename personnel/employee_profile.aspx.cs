using adviitRuntimeScripting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ComplexScriptingSystem;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;

namespace SigmaERP.personnel
{
    //view=285
    public partial class employee_profile : System.Web.UI.Page
    {
        int[] pagePermission = { 285 };
        DataTable dt;
        string CompanyID = "";
        string query = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            lblMessage.InnerText = "";
            if (!IsPostBack)
            {
                int[] userPagePermition = AccessControl.hasPermission(pagePermission);
                if (!userPagePermition.Any())
                    Response.Redirect(Routing.defualtUrl);

                setPrivilege();
                classes.commonTask.LoadEmpTypeWithAll(rblEmpType);
                classes.commonTask.LoadEmpCardNoByEmpTypeForProfile(ddlCardNo, ddlBranch.SelectedValue, rblEmpType.SelectedValue);
                if (ddlCardNo != null)
                    ddlCardNo.Items.Insert(0, new ListItem("Select For Individual", "0"));
                if (!classes.commonTask.HasBranch())
                    ddlBranch.Enabled = false;
                
            }
            
        }
        private void setPrivilege()
        {
            try
            {
                upSuperAdmin.Value = "1";
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();

                string[] AccessPermission = new string[0];
                classes.commonTask.LoadBranch(ddlBranch,ViewState["__CompanyId__"].ToString());
                //System.Web.UI.HtmlControls.HtmlTable a = tblGenerateType;
                AccessPermission = checkUserPrivilege.checkUserPrivilegeForReport(ViewState["__CompanyId__"].ToString(), getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "employee_profile.aspx", ddlBranch, WarningMessage, tblGenerateType, btnPrintpreview);

          
                ViewState["__ReadAction__"] = AccessPermission[0];
                ddlBranch.SelectedValue = ViewState["__CompanyId__"].ToString();
                classes.commonTask.LoadDepartment(ddlBranch.SelectedValue, lstAll);

         
            }
            catch { }

        }
        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveItem(lstAll, lstSelected);
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true); 
        }

        protected void btnAddAllItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveAll(lstAll, lstSelected);
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true); 
        }

        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveItem(lstSelected, lstAll);
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true); 
        }
        protected void btnRemoveAllItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveAll(lstSelected, lstAll);
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true);
        }

        protected void btnPrintpreview_Click(object sender, EventArgs e)
        {
            string condition = AccessControl.getDataAccessCondition(ViewState["__CompanyId__"].ToString(), "0");
            string DepartmentList = classes.commonTask.getDepartmentList(lstSelected);

            if (ddlCardNo.SelectedValue != "0")
            {
                Response.Redirect("~/personnel/employee_profileview.aspx?Id=" + ddlCardNo.SelectedValue);
            }
            else
            {
                // Remove "in (" and ")" from the string and format correctly
                string cleanedList = DepartmentList.Replace("in (", "").Replace(")", "").Trim();

                // Wrap values properly
                string formattedDepartmentList = "['" + cleanedList.Replace("''", "','") + "']";

                Response.Redirect("~/personnel/employee_profileview.aspx?Id=" + formattedDepartmentList);
            }
        }



        protected void rdball_CheckedChanged(object sender, EventArgs e)
        {
           
            divindivisual.Visible = false;
                
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true);      
        }

        private bool DataFill(string query)
        {
            sqlDB.fillDataTable(query, dt = new DataTable());
            if (dt == null || dt.Rows.Count == 0)
            {
                lblMessage.InnerText = "warning->Data not found!";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true);
                return false;
            }
            return true;
        }

        //protected void rdbindividual_CheckedChanged(object sender, EventArgs e)
        //{            
        //    rdball.Checked = false;
        //    divindivisual.Visible = true;
        //    CompanyID = (ddlBranch.SelectedValue.Equals("0000")) ? ViewState["__CompanyId__"].ToString() : ddlBranch.SelectedValue;
        //    classes.commonTask.LoadEmpCardNoByEmpTypeForProfile(ddlCardNo, CompanyID, rblEmpType.SelectedValue);
        //    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true);
        //}       

    
        protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
        {
               
            divindivisual.Visible = false;    
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true);
        }

        protected void rblEmpType_SelectedIndexChanged(object sender, EventArgs e)
        {
            CompanyID = (ddlBranch.SelectedValue.Equals("0000")) ? ViewState["__CompanyId__"].ToString(): ddlBranch.SelectedValue;
            classes.commonTask.LoadEmpCardNoByEmpTypeForProfile(ddlCardNo, ddlBranch.SelectedValue, rblEmpType.SelectedValue);
            if (ddlCardNo != null)
                ddlCardNo.Items.Insert(0, new ListItem("Select For Individual", "0"));
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "loadcardNo();", true);
        }

        
    }
}