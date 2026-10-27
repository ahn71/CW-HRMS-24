using SigmaERP.hrms.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.hrms
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["__GetUserId__"] == null)
                {
                    HttpContext.Current.Response.Redirect("/hrms/login");
                }
                // "only me" users have their own dashboard; the logo, back buttons and default redirects all point here
                if (Session["__UserDataAccessLevel__"]?.ToString() == "1")
                {
                    Response.RedirectToRoute(SigmaERP.classes.Routing.UserDashboardRoutName);
                    return;
                }
                AccessControl.getDataAccessPermission(Session["__GetUserId__"].ToString());
            }
        }
    }
}