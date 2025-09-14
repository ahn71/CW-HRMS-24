using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    HttpCookie getCookies = Request.Cookies["userInfo"];
                    if (getCookies == null || getCookies.Value == "")
                    {
                      //  Response.Redirect("~/ControlPanel/Login.aspx");
                       // Response.Redirect("~/hrms/UI/auth/login.aspx");
                        Response.RedirectToRoute(Routing.LoginRouteName);
                    }
                    else
                    {

                        var accessLevel = Session["__UserDataAccessLevel__"] != null ? Session["__UserDataAccessLevel__"].ToString() : "";

                        if (accessLevel == "1")
                        {
                            Response.RedirectToRoute(Routing.UserDashboardRoutName); 
                        }
                        else
                        {
                            // Redirect to dashboard or other route
                            Response.RedirectToRoute(Routing.dashboardRoutName);
                        }

                              
                        
                    }
                }
                catch(Exception ex) { }
            }
        }
    }


}
