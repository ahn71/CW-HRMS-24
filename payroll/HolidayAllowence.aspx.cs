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
            string salaryType = rdoBasic.Checked ? "Basic" : "Gross";
            if (btnsave.Text == "Update")
                UpdateHolidayAllowance(salaryType);

            saveHolidayAllowence(salaryType);
        }


        private void saveHolidayAllowence(string salaryType)
        {
           
            if (!IsValidInput(salaryType))
                return;

            if (IsDuplicateEntry(salaryType))
            {
                lblMessage.Text = "Allowance already set for this holiday.";
                return;
            }

            InsertHolidayAllowance(salaryType);

            AlertSuccess("Holiday Allowance সফলভাবে সংরক্ষণ হয়েছে।");
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

            if (ddHolidayType.SelectedValue==null)
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

            int count = CRUD.ExecuteReturnID(query);

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
                        HolidayId,HolidayType
                    )
                    VALUES
                    (
                        '" + salaryType + @"',
                       '0',
                        1,
                        " + ViewState["__userId__"].ToString() + @",
                        GETDATE(),
                        '" + ViewState["__CompanyId__"].ToString() + @"',
                        " + ddlholidaylist.SelectedValue + ",'"+ddHolidayType.SelectedValue.ToString()+"')";

            bool isave = CRUD.Execute(query);

        }

        private void BindHolidayAllowance()
        {
            string query = @"
        SELECT
            hs.AllowanceID,hs.HolidayType,
            hs.CompanyId,
            CONVERT(VARCHAR(10), hw.HDate, 105) + ' (' + hw.Description + ')' AS Holiday,
            hs.SalaryType,hs.IsActive,
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

        protected void chkIsActive_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chk.NamingContainer;

            int allowanceId = Convert.ToInt32(
                gvHolidayAllowance.DataKeys[row.RowIndex].Value
            );

            string query = @"UPDATE HolidayAllowanceSettings
                     SET IsActive = " + (chk.Checked ? 1 : 0) + @",
                         UpdatedBy = " + ViewState["__userId__"].ToString()+ @",
                         UpdatedAt = GETDATE()
                     WHERE AllowanceID = " + allowanceId;

            bool isave = CRUD.Execute(query);

            BindHolidayAllowance();
        }



        private void ShowAlert(string type, string title, string message)
        {
            string script = $"showAlert('{type}', '{title}', '{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "swal", script, true);
        }

        // ── Shortcut Methods ──────────────────────────
        private void AlertSuccess(string message) =>
            ShowAlert("success", "সফল হয়েছে!", message);

        private void AlertError(string message) =>
            ShowAlert("error", "সমস্যা হয়েছে!", message);

        private void AlertWarning(string message) =>
            ShowAlert("warning", "সতর্কতা", message);

        private void AlertInfo(string message) =>
            ShowAlert("info", "তথ্য", message);

        protected void gvHolidayAllowance_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DataItem থেকে IsActive নাও
                bool isActive = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "IsActive"));

                // Row এ class set করো
                e.Row.CssClass = isActive ? "row-active" : "row-inactive";
            }
        }

        protected void gvHolidayAllowance_RowCommand(object sender, GridViewCommandEventArgs e)
        {
             int id = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "EditRow")
                {
                    LoadDataForEdit(id);
                }
        }


        private void LoadDataForEdit(int id)
        {
            string query = @"SELECT *
                     FROM HolidayAllowanceSettings
                     WHERE AllowanceID = " + id;

            DataTable dt = CRUD.ExecuteReturnDataTable(query);

            if (dt.Rows.Count > 0)
            {
                ddlholidaylist.SelectedValue = dt.Rows[0]["HolidayId"].ToString();
                if (dt.Rows[0]["SalaryType"].ToString() == "Basic")
                {
                    rdoBasic.Checked = true;
                    rdoGross.Checked = false;
                }
                else
                {
                    rdoBasic.Checked = false;
                    rdoGross.Checked = true;
                }
               
               // txtMultiplier.Text = dt.Rows[0]["Multiplier"].ToString();
                ddHolidayType.SelectedValue = dt.Rows[0]["HolidayType"].ToString();
                ViewState["EditID"] = id;

                btnsave.Text = "Update";
            }
        }

        private void UpdateHolidayAllowance(string salaryType)
        {
            if (ViewState["EditID"] == null)
                return;

            int id = Convert.ToInt32(ViewState["EditID"]);

            string query = @"UPDATE HolidayAllowanceSettings
                     SET SalaryType = '" + salaryType + @"',
                         HolidayId = " + ddlholidaylist.SelectedValue + @",
                         Multiplier = '0',
                         IsActive = '1'  ,
                         UpdatedBy = " + ViewState["__userId__"].ToString() + @",
                         UpdatedAt = GETDATE()
                     WHERE AllowanceID = " + id;

            bool isave = CRUD.Execute(query);

            ClearForm();
            btnsave.Text = "Add";
            BindHolidayAllowance();

            lblMessage.Text = "Updated successfully.";
        }

        private void ClearForm()
        {
            ddlholidaylist.SelectedIndex = 0;
            ViewState["EditID"] = null;
            btnsave.Text = "Save";
        }
    } 
       
}



