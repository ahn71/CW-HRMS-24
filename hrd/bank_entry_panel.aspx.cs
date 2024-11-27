using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.hrd
{
    public partial class bank_entry_panel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                classes.commonTask.LoadBranch(ddlCompany);
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }

        protected void chkIspayer_CheckedChanged(object sender, EventArgs e)
        {

        }



        private void savbankInfo()
        {
            bool ispayer = chkIspayer.Checked ? true : false;
            string query = "Insert into hrd_bankinfo (BankName,BankShortName,BankAccount,CompanyId,IsPayer)" +
                " Values('" + txtbankName + "','" + txtbankshortname + "','" + txtBankacount + "','" + ddlCompany.SelectedValue + "',"+ ispayer + ")";
           int result= CRUD.ExecuteReturnID(query);
            if(result>0)
                Console.WriteLine("Data Saved Successfully");
            else
                Console.WriteLine("Data Saved Failed");
        }
        private void updatebankInfo()
        {
            string query= "UPDATE hrd_bankinfo SET BankName = 'New Bank Name', BankShortName = 'NBN',BankAccount = '1234567890', CompanyId = 2," +
                "IsPayer = 1WHERE BankId = 1";

        }
    }
}