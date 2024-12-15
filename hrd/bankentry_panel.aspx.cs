using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.hrd
{
    public partial class bankentry_panel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                classes.commonTask.LoadBranch(ddlCompany);
                ddlCompany.SelectedIndex = 1;
              
                loadBanklist(ddlCompany.SelectedValue);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (btnSave.Text == "Save")
            {
                savbankInfo();
                loadBanklist(ddlCompany.SelectedValue);
            }
            else
            {
                updatebankInfo(ViewState["__bankId__"].ToString());
                loadBanklist(ddlCompany.SelectedValue);
                btnSave.Text = "Save";
            }
        }

        protected void chkIspayer_CheckedChanged(object sender, EventArgs e)
        {
            if (chkIspayer.Checked)
            {
                bnkacount.Visible = true;
            }
        }

        protected void gvbanklist_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName== "Alter")
            {
                ViewState["__bankId__"] = "0";
                int rIndex = Convert.ToInt32(e.CommandArgument.ToString());
                string id = gvbanklist.DataKeys[rIndex].Values[0].ToString();
                ViewState["__bankId__"] = id;
                loadBankInfoForEdit(id);
                btnSave.Text = "Update";
            }


        }


        private void savbankInfo()
        {
            int isPayer = chkIspayer.Checked ? 1 : 0;
            string query = "Insert into hrd_bankinfo (BankName,BankShortName,BankAccount,CompanyId,IsPayer)" +
                " Values('" + txtbankName.Text.Trim().ToString() + "','" + txtbankshortname.Text.Trim().ToString() + "','" + txtBankacount.Text.Trim().ToString() + "','" + ddlCompany.SelectedValue.ToString() + "'," + isPayer + ")";
            bool result = CRUD.Execute(query);
            if (result)
                Console.WriteLine("Data Saved Successfully");
            else
                Console.WriteLine("Data Saved Failed");
        }
        private void updatebankInfo(string bankId)
        {
            int isPayer = chkIspayer.Checked ? 1 : 0;
            string query = "UPDATE hrd_bankinfo SET BankName = '"+txtbankName.Text+"', BankShortName = '"+txtbankshortname.Text+"',BankAccount = '"+ txtBankacount.Text.Trim().ToString() + "', CompanyId = "+ddlCompany.SelectedValue+"," +
                "IsPayer = "+ isPayer + " WHERE BankId ="+ bankId;
            CRUD.Execute(query);


        }

        private void loadBanklist(string compnayID)
        {
            string query = "Select * from hrd_bankinfo where companyID= " + compnayID;
            DataTable dt = CRUD.ExecuteReturnDataTable(query);
            gvbanklist.DataSource = dt;
            gvbanklist.DataBind();
    
        }

        protected void chkActive_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkActive = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkActive.NamingContainer;
            string bankId = gvbanklist.DataKeys[row.RowIndex].Value.ToString();
            //bool isActive = false;
            int isActive = chkActive.Checked ? 1 : 0;
            //if (chkActive.Checked)
            //{
            //    isActive = true;
            //}
            string query = "update hrd_bankinfo SET IsActive=" + isActive + " where BankId=" + bankId;
            CRUD.Execute(query);
        }


        private void loadBankInfoForEdit(string bankId)
        {
            string query = "Select * from hrd_bankinfo  Where BankID="+bankId;
            DataTable dt = CRUD.ExecuteReturnDataTable(query);
            txtbankName.Text = dt.Rows[0]["BankName"].ToString();
            txtbankshortname.Text = dt.Rows[0]["BankShortName"].ToString();
            ddlCompany.SelectedValue = dt.Rows[0]["CompanyId"].ToString();

            if (bool.Parse(dt.Rows[0]["IsPayer"].ToString()) == true)
            {
                chkIspayer.Checked = true;
                bnkacount.Visible = true;
                txtBankacount.Text = dt.Rows[0]["BankAccount"].ToString();

            }
        }

        private void clear()
        {
            txtbankName.Text = "";
            txtbankshortname.Text = "";
            txtBankacount.Text = "";
            chkIspayer.Checked = false;
            
        }
    }
}