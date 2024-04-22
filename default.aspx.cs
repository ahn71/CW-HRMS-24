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
                        Response.Redirect("~/hrms/UI/auth/login.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/hrms/dashboard.aspx");
                        if (Session["__IsCompliance__"].ToString().Equals("True"))
                        {
                            try
                            {

                                divSettings.Visible = false;
                                divTools.Visible = false;

                            }
                            catch { Response.Redirect("~/default.aspx"); }
                        }
                        else if (Session["__UserNameText__"].ToString() == "common")
                        {
                            try
                            {                               

                                divSettings.Visible = false;
                                divPersonnel.Visible = false;
                                divTools.Visible = false;
                                divPayroll.Visible = false;

                            }
                            catch { Response.Redirect("~/default.aspx"); }
                        }
                    }
                }
                catch { }
            }
        }
    }


}
