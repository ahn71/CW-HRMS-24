using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.hrms
{
    public partial class userRoles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //HttpCookie getCookies = Request.Cookies["userInfo"];
            //if (getCookies != null)
            //{
            //    string companyId = getCookies["__CompanyId__"] ?? string.Empty;
            //    ViewState["__CompanyId__"] = companyId;

            //    // Load branches based on the company ID
            //    classes.commonTask.LoadBranch(ddlBranch, companyId);

            //    // Set the selected value if it exists in the dropdown
            //    if (ddlBranch.Items.FindByValue(companyId) != null)
            //    {
            //        ddlBranch.SelectedValue = companyId;
            //    }
            //}
            //else
            //{
            //    // Handle the case where the cookie is missing
            //    ViewState["__CompanyId__"] = string.Empty; // Or some default action
            //}
        }
    }
}