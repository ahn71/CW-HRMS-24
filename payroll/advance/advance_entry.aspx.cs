using adviitRuntimeScripting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using ComplexScriptingSystem;
using SigmaERP.classes;

namespace SigmaERP.payroll.advance
{
    public partial class advance_entry : System.Web.UI.Page
    {
        // Status {0=Due/Current Loan,1=Paid,2=Cash Refund,3=Waived }
        DataTable dt;
        DataTable dtSetPrivilege;
        string query = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            lblMessage.InnerText = "";
            if (!IsPostBack)
            {
                txtFromDate.Text = "01-" + DateTime.Now.ToString("MM-yyyy");
                txtToDate.Text = DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month) + "-" + DateTime.Now.ToString("MM-yyyy");
                ViewState["__LineORGroupDependency__"] = classes.commonTask.GroupORLineDependency();
                setPrivilege();
                if (ViewState["__LineORGroupDependency__"].ToString().Equals("False"))
                    classes.commonTask.LoadGrouping(ddlGrouping, ViewState["__CompanyId__"].ToString());
                
                ddlCompanyList.SelectedValue = ViewState["__CompanyId__"].ToString();
                loadYear(ddlCompanyList.SelectedValue);
                
                if (!classes.commonTask.HasBranch())
                    ddlCompanyList.Enabled = false;

                loadExistsLoan();               
            }
        }

        private void loadYear(string CompanyId)
        {
            try
            {
                sqlDB.fillDataTable("select distinct Year(DeductFrom) as Year from Payroll_LoanInfo where  CompanyId='"+ CompanyId + "' and Status=0 and ISNULL(IsDeleted,0)=0  order by Year(DeductFrom)  desc", dt = new DataTable());
                ddlChoseYear.DataTextField = "Year";
                ddlChoseYear.DataValueField = "Year";
                ddlChoseYear.DataSource = dt;
                ddlChoseYear.DataBind();
                ddlChoseYear.SelectedIndex = 0;
                ddlChoseYear.Items.Insert(0, new ListItem(string.Empty, "0"));
            }
            catch { }
        }
        private void setPrivilege()
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                string DptId = getCookies["__DptId__"].ToString();
                string[] AccessPermission = new string[0];
                AccessPermission = checkUserPrivilege.checkUserPrivilegeForList(ViewState["__CompanyId__"].ToString(), getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "advance.aspx", ddlCompanyList, gvAdvanceInfo, btnSearch);

                ViewState["__ReadAction__"] = AccessPermission[0];
                ViewState["__WriteAction__"] = AccessPermission[1];
                ViewState["__UpdateAction__"] = AccessPermission[2];
                ViewState["__DeletAction__"] = AccessPermission[3];
                classes.commonTask.loadDepartmentListByCompany(ddlDepartmentList, ViewState["__CompanyId__"].ToString());
               



            }
            catch { }
        }
      
        private void loadExistsLoan()
        {
            try
            {
                string CompanyId = (ddlCompanyList.SelectedIndex<1)? ViewState["__CompanyId__"].ToString():ddlCompanyList.SelectedValue ;
                //query = "select SUBSTRING(ei.EmpCardNo,8,6)+' ('+ei.EmpProximityNo+')' as EmpCardNo,ei.EmpId,ei.EmpName, LoanID,LoanAmount,InstallmentAmount,format(DeductFrom,'MM-yyyy') as DeductFrom,Isnull(li.PaidAmount,0) as PaidAmount,li.LoanAmount- Isnull(li.PaidAmount,0) as DueAmount from Payroll_LoanInfo as li inner join Personnel_EmployeeInfo as ei on li.EmpId=ei.EmpId where li.CompanyId='" + CompanyId + "' and  li.Status=0 and ISNULL(IsDeleted,0)=0 ";

                query = "SELECT SUBSTRING(ei.EmpCardNo, 8, 6) + ' (' + ei.EmpProximityNo + ')' AS EmpCardNo,ei.EmpId, ei.EmpName,li.LoanID,li.LoanAmount,li.InstallmentAmount,FORMAT(DeductFrom, 'MM-yyyy') AS DeductFrom, IsNull(SUM(lmd.Amount),0) AS PaidAmount,li.LoanAmount - IsNull(SUM(lmd.Amount),0) AS DueAmount FROM Payroll_LoanInfo AS li INNER JOIN Personnel_EmployeeInfo AS ei ON li.EmpId = ei.EmpId LEFT JOIN Payroll_LoanMonthlySetup AS lmd ON li.LoanID = lmd.LoanID and lmd.IsPaid = 1" +
                    " WHERE li.CompanyId = '" + CompanyId + "' AND li.Status = 0 AND ISNULL(li.IsDeleted, 0) = 0 GROUP BY ei.EmpCardNo, ei.EmpProximityNo, ei.EmpId, ei.EmpName, li.LoanID, li.LoanAmount, li.InstallmentAmount, DeductFrom, PaidAmount";
                sqlDB.fillDataTable(query, dt = new DataTable());
                gvAdvanceInfo.DataSource = dt;
                gvAdvanceInfo.DataBind();
            }
            catch { }
        }

        protected void gvAdvanceInfo_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                loadExistsLoan();
                gvAdvanceInfo.PageIndex = e.NewPageIndex;
                gvAdvanceInfo.DataBind();

            }
            catch (Exception ex)
            {

            }
        }
             





   


      protected void gvAdvanceInfo_RowDataBound(object sender, GridViewRowEventArgs e)
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
        }
        protected void ddlCompanyList_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                lblMessage.InnerText = "";             
                if (ddlCompanyList.SelectedValue == "0000")
                {
                    ddlCompanyList.SelectedValue = ViewState["__CompanyId__"].ToString();
                }               
                classes.commonTask.loadDepartmentListByCompany(ddlDepartmentList, ddlCompanyList.SelectedValue.ToString());
               
            }
            catch { }
        }
        protected void ddlDivisionName_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ViewState["__LineORGroupDependency__"].ToString().Equals("True"))
            {
                string CompanyId = (ddlCompanyList.SelectedValue.ToString().Equals("0000")) ? ViewState["__CompanyId__"].ToString() : ddlCompanyList.SelectedValue;
                classes.commonTask.LoadGrouping(ddlGrouping, CompanyId, ddlDepartmentList.SelectedValue);
            }            

        }
        protected void ddlChoseYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtFromDate.Text = "";
            txtToDate.Text = "";

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                loadExistsLoan();
            }
            catch { }
        }

        protected void gvAdvanceInfo_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("alter"))
            {
                Response.Redirect("/payroll/advance/advance_entry_final.aspx?Action=alter&&EmpId=" + e.CommandArgument.ToString(), false);
            }
            else if (e.CommandName.Equals("refund"))
            {
                Response.Redirect("/payroll/advance/advance_entry_final.aspx?Action=refund&&EmpId=" + e.CommandArgument.ToString(), false);
            }
            else if (e.CommandName.Equals("waive"))
            {
                Response.Redirect("/payroll/advance/advance_entry_final.aspx?Action=waive&&EmpId=" + e.CommandArgument.ToString(), false);
            }
            else if (e.CommandName.Equals("paid"))
            {
                Response.Redirect("/payroll/advance/advance_entry_final.aspx?Action=paid&&EmpId=" + e.CommandArgument.ToString(), false);
            }
            else if(e.CommandName.Equals("remove"))
            {
                int rIndex =int.Parse( e.CommandArgument.ToString());
                string loanID = gvAdvanceInfo.DataKeys[rIndex].Values[0].ToString();
                if (!deleteValidation(loanID))
                {
                    lblMessage.InnerText = "warning-> This record cannot delete.";
                }
                else
                {
                    if (CRUD.Execute("Delete Payroll_LoanInfo Where LoanID=" + loanID))
                    {
                        lblMessage.InnerText = "success-> Deleted.";
                        gvAdvanceInfo.Rows[rIndex].Visible = false;

                    }                       
                }
            }
        }
        private bool deleteValidation(string loanID) {
            try {
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable("select * from Payroll_LoanInfo where LoanID="+ loanID + " and IsNull(PaidAmount,0)>0");
                if (dt.Rows.Count > 0)
                    return false;
                return true;
            } catch(Exception ex ) { return false; }
        }

    }
}