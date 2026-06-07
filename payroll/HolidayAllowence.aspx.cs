using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.payroll
{
    public partial class HolidayAllowence : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                setPrivilege();
                ddlCompanyList.SelectedValue = ViewState["__CompanyId__"].ToString();
                classes.commonTask.loadHolidayList(ddlholidaylist, ViewState["__CompanyId__"].ToString());
                BindHolidayAllowance();
            }



        }
        private void setPrivilege()
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__userId__"] = getUserId;
                string DptId = getCookies["__DptId__"].ToString();
                //string[] AccessPermission = new string[0];
                classes.commonTask.LoadBranch(ddlCompanyList, ViewState["__CompanyId__"].ToString());
               
                // AccessPermission = checkUserPrivilege.checkUserPrivilegeForList(ViewState["__CompanyId__"].ToString(), getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "advance.aspx", ddlCompanyList, gvAdvanceInfo, btnSearch);

                //ViewState["__ReadAction__"] = AccessPermission[0];
                //ViewState["__WriteAction__"] = AccessPermission[1];
                //ViewState["__UpdateAction__"] = AccessPermission[2];
                //ViewState["__DeletAction__"] = AccessPermission[3];



            }
            catch { }
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            saveHolidayAllowence();
        }


        private void saveHolidayAllowence()
        {
            string salaryType = rdoBasic.Checked ? "Basic" : "Gross";
            if (!IsValidInput(salaryType))
                return;

            if (IsDuplicateEntry(salaryType))
            {
                lblMessage.Text = "Allowance already set for this holiday.";
                return;
            }

            InsertHolidayAllowance(salaryType);

            lblMessage.Text = "Saved successfully.";
        }

        private bool IsValidInput(string salaryType)
        {
            if (ddlholidaylist.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select Holiday.";
                return false;
            }

            if (string.IsNullOrEmpty(salaryType))
            {
                lblMessage.Text = "Please select Salary Type.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtMultiplier.Text))
            {
                lblMessage.Text = "Please enter Multiplier.";
                return false;
            }

            return true;
        }

        private bool IsDuplicateEntry(string salaryType)
        {
            string query = @"SELECT COUNT(*)
                     FROM HolidayAllowanceSettings
                     WHERE CompanyId = '" + ViewState["__CompanyId__"].ToString() + @"'
                     AND HolidayId = " + ddlholidaylist.SelectedValue + @"
                     AND SalaryType = '" + salaryType + "'";

            int count =CRUD.ExecuteReturnID(query);

            return count > 0;
        }

        private void InsertHolidayAllowance(string salaryType)
        {
            
            string query = @"INSERT INTO HolidayAllowanceSettings
                    (
                        SalaryType,
                        Multiplier,
                        IsActive,
                        CreatedBy,
                        CreatedAt,
                        CompanyId,
                        HolidayId
                    )
                    VALUES
                    (
                        '" + salaryType + @"',
                        " + txtMultiplier.Text + @",
                        1,
                        " + ViewState["__userId__"].ToString() + @",
                        GETDATE(),
                        '" + ViewState["__CompanyId__"].ToString() + @"',
                        " + ddlholidaylist.SelectedValue + @"
                    )";

            bool isave = CRUD.Execute(query);
           
        }

        private void BindHolidayAllowance()
        {
            string query = @"
        SELECT
            hs.AllowanceID,
            hs.CompanyId,
            CONVERT(VARCHAR(10), hw.HDate, 105) + ' (' + hw.Description + ')' AS Holiday,
            hs.SalaryType,
            hs.Multiplier
        FROM HolidayAllowanceSettings hs
        INNER JOIN tblHolydayWork hw
            ON hs.HolidayId = hw.HCode
        WHERE hs.CompanyId = '" + ViewState["__CompanyId__"].ToString() + @"'
        ORDER BY hw.HDate DESC";
            DataTable dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(query);

            gvHolidayAllowance.DataSource = dt;
            gvHolidayAllowance.DataBind();
        }

 
    }
}