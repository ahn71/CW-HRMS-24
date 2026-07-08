using adviitRuntimeScripting;
using ComplexScriptingSystem;
using OfficeOpenXml;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.personnel
{
    public partial class employee_list1 : System.Web.UI.Page
    {
        private const string ImportPreviewViewStateKey = "__EmployeeImportPreview__";
        private const string ImportCompaniesViewStateKey = "__EmployeeImportCompanies__";
        private const string ImportDepartmentsViewStateKey = "__EmployeeImportDepartments__";
        private const string ImportDesignationsViewStateKey = "__EmployeeImportDesignations__";
        private const string ImportGroupsViewStateKey = "__EmployeeImportGroups__";
        private const string ImportShiftsViewStateKey = "__EmployeeImportShifts__";
        private const string ImportEmployeeTypesViewStateKey = "__EmployeeImportEmployeeTypes__";
        private const string ImportEmployeeStatusViewStateKey = "__EmployeeImportEmployeeStatus__";
        private const string ImportUnitsViewStateKey = "ImportUnitsViewStateKey";

        private class EmployeeImportItem
        {
            public string CompanyId { get; set; }
            public string EmpTypeId { get; set; }
            public string DptId { get; set; }
            public string DsgId { get; set; }
            public string GId { get; set; }
            public string SftId { get; set; }
            public string EmpstatusId { get; set; }
            public string UnitId { get; set; }

            public DataRow Row { get; set; }
        }

        //View=269 , Edit=271 , Transfer=272 , Delete=273


  
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            lblMessage.InnerText = "";

         

            int[] pagePermission = { 269, 271, 272, 273 };
            if (!IsPostBack)
            {
                ViewState["__ReadAction__"] = "0";
                ViewState["__WriteAction__"] = "0";
                ViewState["__UpdateAction__"] = "0";
                ViewState["__DeletAction__"] = "0";

                int[] userPagePermition = AccessControl.hasPermission(pagePermission);
                if (!userPagePermition.Any())
                    Response.Redirect(Routing.defualtUrl);
                HttpCookie getCookies = Request.Cookies["userInfo"];
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();

                string CompanyId = ViewState["__CompanyId__"].ToString();
                classes.commonTask.LoadBranch(ddlCompanyList, ViewState["__CompanyId__"].ToString());
                classes.commonTask.LoadUnit(ViewState["__CompanyId__"].ToString(), ddlUnit);
                ViewState["__LineORGroupDependency__"] = classes.commonTask.GroupORLineDependency();
                loadYear();
                setPrivilege(userPagePermition);

                classes.commonTask.LoadShift(ddlShift, ViewState["__CompanyId__"].ToString());
               // SearchingInEmployeeList();
                if (ViewState["__LineORGroupDependency__"].ToString().Equals("False"))
                    classes.commonTask.LoadGrouping(ddlGrouping, ViewState["__CompanyId__"].ToString());

                string condition = AccessControl.getDataAccessCondition(ViewState["__CompanyId__"].ToString(),"0");
                string query = "Select EmpDutyType,CompanyId,EmpId, EmpCardNo+' ('+EmpProximityNo+')' as EmpCardNo,EmpName,convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,UnitName,DptName,DsgName,SftName, convert(varchar(11),EmpShiftStartDate,105) as EmpShiftStartDate,EmpStatusName,EmpType,ISNULL(WeekendType,'Regular') as WeekendType From v_EmployeeDetails where EmpStatus in ('1','8') and IsActive='1' and " + condition + " order by DptCode, CustomOrdering";


                 LoadAllEmployeeList(query);
                if (!classes.commonTask.HasBranch())
                    ddlCompanyList.Enabled = false;
                ddlCompanyList.SelectedValue = ViewState["__CompanyId__"].ToString();
                if (Session["IsRedirect"] != null)
                {
                    if (Session["pageNumber"] != null)
                    {
                        gvForApprovedList.PageIndex = (int)Session["pageNumber"];
                        gvForApprovedList.DataBind();
                    }                    
                }
                Session["IsRedirect"] = null;
                Session["pageNumber"] = gvForApprovedList.PageIndex;
            }
        }
        private void loadYear()
        {
            try
            {
                DataTable dt = new DataTable();
                sqlDB.fillDataTable("select distinct FORMAT(EmpJoiningDate,'yyyy')as year from v_EmployeeDetails order by year DESC", dt = new DataTable());
                ddlChoseYear.DataTextField = "year";
                ddlChoseYear.DataValueField = "year";
                ddlChoseYear.DataSource = dt;
                ddlChoseYear.DataBind();
                // ddlChoseYear.SelectedIndex = 0;
                ddlChoseYear.Items.Insert(0, new ListItem(string.Empty, ""));
            }
            catch { }
        }
        private void setPrivilege(int [] permissions)
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__dptID__"] = getCookies["__DptId__"].ToString();
                ViewState["__empId__"] = getCookies["__getEmpId__"].ToString();


                //string[] AccessPermission = new string[0];
                //AccessPermission = checkUserPrivilege.checkUserPrivilegeForList(ViewState["__CompanyId__"].ToString(), getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "Employee.aspx", ddlCompanyList, gvForApprovedList, btnSearch);

                if (permissions.Contains(269))
                    ViewState["__ReadAction__"] = "1";
                if (permissions.Contains(271))
                    ViewState["__UpdateAction__"] = "1";
                if (permissions.Contains(272))
                    ViewState["__WriteAction__"] = "1";  //transfer
                if (permissions.Contains(273))
                    ViewState["__DeletAction__"] = "1";

                //loadDepartMents();
                classes.commonTask.loadDepartmentListByCompany(ddlDepartmentList, ViewState["__CompanyId__"].ToString());





            }
            catch { }
        }

        private void LoadAllEmployeeList(string cmd)
        {
            try
            {
                DataTable dt = new DataTable();
                sqlDB.fillDataTable(cmd, dt);

                gvForApprovedList.DataSource = dt;
                gvForApprovedList.DataBind();
                pTotalEmployee.InnerText = "Total Running -> " + dt.Rows.Count.ToString();

            }
            catch
            { }
        }
        /*Nayem.......
       .............For Searching............*/
        private void SearchingInEmployeeList()
        {
            try
            {
                if (ddlCompanyList.SelectedItem.Text.Trim() == "")
                {
                    ddlCompanyList.SelectedValue = ViewState["__CompanyId__"].ToString();
                }
                if (txtCardNo.Text.Trim() != "")
                {
                    if (txtCardNo.Text.Length < 4)
                    { lblMessage.InnerText = "warning-> Please Type Employee Card No Minimum 4 Character!"; return; }
                }
            
                if (txtFromDate.Text.Trim().Length != 0 || txtToDate.Text.Trim().Length != 0)
                {
                    string[] dates = txtFromDate.Text.Trim().Split('-');
                    ViewState["__FDate__"] = dates[2] + "-" + dates[1] + "-" + dates[0];
                    dates = txtToDate.Text.Trim().Split('-');
                    ViewState["__TDate__"] = dates[2] + "-" + dates[1] + "-" + dates[0];
                    ddlChoseYear.SelectedIndex = 0;
                }
                if (txtCardNo.Text.Trim() == "" && ddlCompanyList.Text.Trim() != "" && ddlShift.SelectedIndex < 1 && (ddlDepartmentList.SelectedIndex == -1 || ddlDepartmentList.SelectedIndex == 0) && ((txtToDate.Text.Trim() != "" && txtFromDate.Text.Trim() != "") || ddlChoseYear.SelectedItem.Text.Trim() != ""))
                {
                    lblMessage.InnerText = "warning-> Please, Select a Department.";
                    return;
                }

                string condtidion = AccessControl.getDataAccessCondition(ddlCompanyList.SelectedValue,"0");
                
                

                string query = "Select EmpDutyType,CompanyId, EmpId,EmpCardNo+' ('+EmpProximityNo+')' as EmpCardNo,EmpName,convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,UnitName,DptName,DsgName,SftName, convert(varchar(11),EmpShiftStartDate,105) as EmpShiftStartDate,EmpStatusName,EmpType,ISNULL(WeekendType,'Regular') as WeekendType From v_EmployeeDetails where ";
                string queryCondition = "";
                DataTable dt = new DataTable();
                // 0.Search by Compnay
                if (ddlCompanyList.SelectedItem.Text.Trim() != "" && (ddlDepartmentList.SelectedIndex == -1 || ddlDepartmentList.SelectedIndex == 0) && (ddlShift.SelectedIndex == -1 || ddlShift.SelectedIndex == 0) && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && txtCardNo.Text.Trim().Length == 0)
                {
                    queryCondition="EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and " + condtidion + " order by DptCode, CustomOrdering";
                }

                if (ddlCompanyList.SelectedItem.Text.Trim() != "" && (ddlDepartmentList.SelectedIndex == -1 || ddlDepartmentList.SelectedIndex == 0) && (ddlShift.SelectedIndex == -1 || ddlShift.SelectedIndex == 0) && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && txtCardNo.Text.Trim().Length == 0)
                {
                    queryCondition = "EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and " + condtidion + " order by DptCode, CustomOrdering";
                }


                //1. Search by Company, CardNo.
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && (ddlDepartmentList.SelectedIndex == -1 || ddlDepartmentList.SelectedIndex == 0) && (ddlShift.SelectedIndex == -1 || ddlShift.SelectedIndex == 0) && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && txtCardNo.Text.Trim().Length > 0 && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and " + condtidion + " and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') order by DptCode, CustomOrdering";
                }
                    
                //2. Search by Company,Department,Card No
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && (ddlShift.SelectedIndex == -1 || ddlShift.SelectedIndex == 0) && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && txtCardNo.Text.Trim().Length > 0 && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') order by DptCode, CustomOrdering";
                }
                   
                // 3. Search by Company,Department,Shift  
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && txtCardNo.Text.Trim().Length == 0 && ddlChoseYear.SelectedItem.Text.Trim() == "" && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' order by DptCode, CustomOrdering";
                }
                   
                // 4. Search by Company,Department,Shift,CardNo 
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && txtCardNo.Text.Trim().Length > 0 && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() != "") && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') order by DptCode, CustomOrdering";
                }
                   
                //5. Search by Company,Department,Shift,CardNo,From Date,To Date
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && txtCardNo.Text.Trim().Length > 0 && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "')and EmpJoiningDate>='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "' order by DptCode, CustomOrdering";
                }
             
                //6. Search by Company,Department,Shift,CardNo,Year
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && ddlChoseYear.SelectedItem.Text.Trim() != "" && txtCardNo.Text.Trim().Length > 0 && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = "EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') and FORMAT(EmpJoiningDate,'yyyy')='" + ddlChoseYear.SelectedValue + "' order by DptCode, CustomOrdering";
                }
                 
                //7. Search by Company,Department,Shift,Year
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && ddlChoseYear.SelectedItem.Text.Trim() != "" && txtCardNo.Text.Trim().Length == 0 && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and FORMAT(EmpJoiningDate,'yyyy')='" + ddlChoseYear.SelectedValue + "' order by DptCode, CustomOrdering";
                }
                 
                //8. Search by Company,Department,Shift,From date,To Date
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and EmpJoiningDate>='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "' order by DptCode, CustomOrdering";
                }
                 
                //9. Search by Company, Department
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedItem.Text.Trim() == "" && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && txtCardNo.Text.Trim().Length == 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() == "") && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "' order by DptCode, CustomOrdering";
                }
                 
                //10. Search by Company, CardNo,From date,To date
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && (ddlDepartmentList.SelectedIndex == -1 || ddlDepartmentList.SelectedIndex == 0) && (ddlShift.SelectedIndex == -1 || ddlShift.SelectedIndex == 0) && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && txtCardNo.Text.Trim().Length > 0 && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and " + condtidion + " and EmpJoiningDate >='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "' and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') order by DptCode, CustomOrdering";
                }
                  
                //11. Search by Company,Department,Year
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && (ddlShift.SelectedIndex == -1 || ddlShift.SelectedIndex == 0) && ddlChoseYear.SelectedItem.Text.Trim() != "" && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and  FORMAT(EmpJoiningDate,'yyyy')='" + ddlChoseYear.SelectedValue + "' order by DptCode, CustomOrdering";
                }
                
                //12.  Search by Company, Shift
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && ddlDepartmentList.SelectedItem.Text.Trim() == "" && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && txtCardNo.Text.Trim().Length == 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() != "") && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and " + condtidion + " and SftId='" + ddlShift.SelectedValue + "' order by DptCode, CustomOrdering";
                }
                   
                //13.  Search by Company, Shift,Card No
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && ddlDepartmentList.SelectedItem.Text.Trim() == "" && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && txtCardNo.Text.Trim().Length > 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() != "") && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and " + condtidion + " and SftId='" + ddlShift.SelectedValue + "' and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') order by DptCode, CustomOrdering";
                }
                  
                //14. Search by Company, Department, FromDate,ToDate
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedItem.Text.Trim() == "" && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && txtCardNo.Text.Trim().Length == 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() != "") && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "' and EmpJoiningDate >='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "' order by DptCode, CustomOrdering";
                }
                  
                //15. Search by Company, Department, FromDate,ToDate,Card no.
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedItem.Text.Trim() == "" && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && txtCardNo.Text.Trim().Length > 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() != "") && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "' and EmpJoiningDate >='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "'and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') order by DptCode, CustomOrdering";
                }
                  
                //16. Seardh by Company,FromDate,ToDate
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() == "" && ddlShift.SelectedItem.Text.Trim() == "" && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && txtCardNo.Text.Trim().Length == 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() != "") && (ddlGrouping.SelectedIndex == -1 || ddlGrouping.SelectedItem.Text.Trim() == ""))
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and " + condtidion + " and EmpJoiningDate >='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "' order by DptCode, CustomOrdering";

                }

                //------------------------------------------            
                // 4. Search by Company,Department,Shift,Grouping 
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && txtCardNo.Text.Trim().Length == 0 && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() == "") && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "' and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " order by DptCode,CustomOrdering";
                }
                

                          // 4. Search by Company,Department,Shift,Grouping ,CardNo
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && txtCardNo.Text.Trim().Length > 0 && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() != "") && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') order by DptCode,CustomOrdering";
                }
                   


                 //5. Search by Company,Department,Shift,CardNo,From Date,To Date,Grouping
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && txtCardNo.Text.Trim().Length > 0 && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "')and EmpJoiningDate>='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "' order by DptCode,CustomOrdering";
                }
                 
                //6. Search by Company,Department,Shift,CardNo,Year,Grouping
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && ddlChoseYear.SelectedItem.Text.Trim() != "" && txtCardNo.Text.Trim().Length > 0 && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') and FORMAT(EmpJoiningDate,'yyyy')='" + ddlChoseYear.SelectedValue + "' order by DptCode,CustomOrdering";
                }
             
                //7. Search by Company,Department,Shift,Year,Grouping
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && ddlChoseYear.SelectedItem.Text.Trim() != "" && txtCardNo.Text.Trim().Length == 0 && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and FORMAT(EmpJoiningDate,'yyyy')='" + ddlChoseYear.SelectedValue + "' order by DptCode, CustomOrdering";
                }
                   
                //8. Search by Company,Department,Shift,From date,To Date,Grouping
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedIndex>0 && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "'and SftId='" + ddlShift.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and EmpJoiningDate>='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "' order by DptCode,CustomOrdering";
                }
                  


                   // 4. Search by Company,Department,Grouping 
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedItem.Text.Trim() == "" && txtCardNo.Text.Trim().Length == 0 && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() == "") && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " order by DptCode,CustomOrdering";
                }
                   

                          // 4. Search by Company,Department,Grouping ,CardNo
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedItem.Text.Trim() == "" && txtCardNo.Text.Trim().Length > 0 && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && (ddlChoseYear.SelectedIndex == 0 || ddlChoseYear.SelectedItem.Text.Trim() != "") && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') order by DptCode,CustomOrdering";
                }
                   


                 //5. Search by Company,Department,CardNo,From Date,To Date,Grouping
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedItem.Text.Trim() == "" && txtCardNo.Text.Trim().Length > 0 && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "')and EmpJoiningDate>='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "' order by DptCode,CustomOrdering";
                }
                 
                //6. Search by Company,Department,CardNo,Year,Grouping
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedItem.Text.Trim() == "" && ddlChoseYear.SelectedItem.Text.Trim() != "" && txtCardNo.Text.Trim().Length > 0 && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and (EmpCardNo like'%" + txtCardNo.Text.Trim() + "' or EmpProximityNo='" + txtCardNo.Text.Trim() + "') and FORMAT(EmpJoiningDate,'yyyy')='" + ddlChoseYear.SelectedValue + "' order by DptCode,CustomOrdering";
                }
                    
                //7. Search by Company,Department,Year,Grouping
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedItem.Text.Trim() == "" && ddlChoseYear.SelectedItem.Text.Trim() != "" && txtCardNo.Text.Trim().Length == 0 && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and FORMAT(EmpJoiningDate,'yyyy')='" + ddlChoseYear.SelectedValue + "' order by DptCode, CustomOrdering";
                }
               
                //8. Search by Company,Department,From date,To Date,Grouping
                else if (ddlCompanyList.SelectedItem.Text.Trim() != "" && ddlDepartmentList.SelectedItem.Text.Trim() != "" && ddlShift.SelectedItem.Text.Trim() == "" && txtFromDate.Text.Trim().Length > 0 && txtToDate.Text.Trim().Length > 0 && ddlGrouping.SelectedItem.Text.Trim() != "")
                {
                    queryCondition = " EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True'  and CompanyId='" + ddlCompanyList.SelectedValue + "'and DptId='" + ddlDepartmentList.SelectedValue + "' and GId=" + ddlGrouping.SelectedValue + " and EmpJoiningDate>='" + ViewState["__FDate__"].ToString() + "' and EmpJoiningDate<='" + ViewState["__TDate__"].ToString() + "' order by DptCode,CustomOrdering";
                }
                if (ddlUnit.SelectedIndex > 0)
                {
                    queryCondition = " UnitId="+ddlUnit.SelectedValue+" and " + queryCondition;
                }
                query += queryCondition;
                sqlDB.fillDataTable(query,dt=new DataTable());

                //-----------------------------------------
                if (dt.Rows.Count == 0)
                {
                    lblMessage.InnerText = "warning->Data not found";
                    gvForApprovedList.DataSource = null;
                    gvForApprovedList.DataBind();
                    return;
                }
                gvForApprovedList.DataSource = dt;
                gvForApprovedList.DataBind();

            }
            catch { }
        }
        private void allClear()
        {
            lblMessage.InnerText = "";
            ddlChoseYear.SelectedIndex = 0;
            ddlCompanyList.SelectedIndex = 0;
            ddlDepartmentList.SelectedIndex = -1;
            ddlShift.SelectedIndex = -1;
            txtToDate.Text = "";
            txtFromDate.Text = "";
            txtCardNo.Text = "";
        }
        protected void gvForApprovedList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                
                int rIndex = Convert.ToInt32(e.CommandArgument.ToString());
                string getId = gvForApprovedList.DataKeys[rIndex].Values[0].ToString();
                string CompanyId = gvForApprovedList.DataKeys[rIndex].Values[1].ToString();

                if (e.CommandName == "Edit")
                {
                    Response.Redirect("~/hrms/employees/add?EmpId=" + getId + "&CompanyId=" + CompanyId + "&Edit=True &Transfer=False");
                }
                if (e.CommandName == "Transfer")
                {
                    Response.Redirect("~/hrms/employees/add?EmpId=" + getId + "&CompanyId=" + CompanyId + "&Edit=False &Transfer=True");
                }
                if (e.CommandName == "Profile")
                {


                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/personnel/employee_profileview.aspx?Id=" + getId + "');", true);

                }
                else if (e.CommandName == "Remove")
                {
                    DataTable dt;
                    //string EmpCardno = gvEmployeeList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text.ToString();
                    //sqlDB.fillDataTable("Select EmpCardNo From Personnel_EmpCurrentStatus where EmpId='" + getId + "'", dt = new DataTable());
                    ////string EmpCardno = dt.Rows[0].ItemArray[0].ToString();
                    DeleteEmployee(getId);
                    gvForApprovedList.Rows[rIndex].Visible = false;
                }
            }
            catch { }
        }
        private void DeleteEmployee(string EmpId)
        {
            try
            {
                SqlCommand deletecmd = new SqlCommand("Delete From Personnel_EmployeeInfo where EmpId='" + EmpId + "'", sqlDB.connection);
                int result = (int)deletecmd.ExecuteNonQuery();
               if (result > 0)
                {
                    lblMessage.InnerText = "success-> Successfully Deleted.";       
                }
            }
            catch { }
        }

        protected void ddlCompanyList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCompanyList.SelectedValue == "0000")
            {
                ddlCompanyList.SelectedValue = ViewState["__CompanyId__"].ToString();
            }
           // classes.commonTask.LoadShift(ddlShift, ddlCompanyList.SelectedValue.ToString());
            classes.commonTask.loadDepartmentListByCompany(ddlDepartmentList, ddlCompanyList.SelectedValue.ToString());
          //  SearchingInEmployeeList();
        }

        protected void ddlDepartmentList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ViewState["__LineORGroupDependency__"].ToString().Equals("True"))
            {
               string CompanyId = (ddlCompanyList.SelectedValue.ToString().Equals("0000")) ? ViewState["__CompanyId__"].ToString() : ddlCompanyList.SelectedValue;
                classes.commonTask.LoadGrouping(ddlGrouping, CompanyId, ddlDepartmentList.SelectedValue);
            }
            classes.commonTask.LoadInitialShiftByDepartment(ddlShift, ddlCompanyList.SelectedValue, ddlDepartmentList.SelectedValue);
            SearchingInEmployeeList();
        }

        protected void ddlShift_SelectedIndexChanged(object sender, EventArgs e)
        {
            SearchingInEmployeeList();
        }

        protected void ddlChoseYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCardNo.Text = "";
            txtFromDate.Text = "";
            txtToDate.Text = "";
            SearchingInEmployeeList();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchingInEmployeeList();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            allClear();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadAllEmployeeList("Select CompanyId,EmpId, EmpCardNo+' ('+EmpProximityNo+')' as EmpCardNo,EmpName,convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,DptName,DsgName,SftName, convert(varchar(11),EmpShiftStartDate,105) as EmpShiftStartDate,EmpStatusName,EmpType From v_EmployeeDetails where EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and CompanyId='" + ViewState["__CompanyId__"].ToString() + "' order by EmpCardNo"); 
            loadYear();
            allClear();
        }

        protected void gvForApprovedList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                SearchingInEmployeeList();
            }
            catch { }
            gvForApprovedList.PageIndex = e.NewPageIndex;
            Session["pageNumber"] = e.NewPageIndex;
            gvForApprovedList.DataBind();
        }

        protected void gvForApprovedList_RowDataBound(object sender, GridViewRowEventArgs e)
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
        
                Button btn ;
                try
                {
                    if (ViewState["__DeletAction__"].ToString().Equals("0"))
                    {
                        btn = new Button();
                        btn = (Button)e.Row.FindControl("btnView");
                        btn.Enabled = false;
                        btn.OnClientClick = "return false";
                        btn.ForeColor = Color.Silver;
                    }

                }
                catch { }
                try
                {
                    if (ViewState["__UpdateAction__"].ToString().Equals("0"))
                    {
                        btn = new Button();
                        btn = (Button)e.Row.FindControl("btnEdit");
                        btn.Enabled = false;
                        btn.ForeColor = Color.Silver;
                    }

                }
                catch { }
                try
                {
                    if (ViewState["__UpdateAction__"].ToString().Equals("0"))
                    {
                        btn = new Button();
                        btn = (Button)e.Row.FindControl("btnTransfer");
                        btn.Enabled = false;
                        btn.ForeColor = Color.Silver;
                    }

                }
                catch { }
            
        }

        protected void ddlGrouping_SelectedIndexChanged(object sender, EventArgs e)
        {
            SearchingInEmployeeList();
        }

        [WebMethod]       
        public static  object LoadEmpInfo()
        {
            //employee_list1 emplst = new employee_list1();
            //emplst.SearchingInEmployeeList();
            return 1;
        }

        protected void ddlUnit_SelectedIndexChanged(object sender, EventArgs e)
        {
            SearchingInEmployeeList();
        }

        protected void btnPreviewUpload_Click(object sender, EventArgs e)
        {
            try
            {
                if (!fuEmployeeExcel.HasFile)
                {
                    lblMessage.InnerText = "warning-> Please choose an Excel file.";
                    return;
                }

                string extension = Path.GetExtension(fuEmployeeExcel.FileName).ToLower();
                if (extension != ".xlsx" && extension != ".xls")
                {
                    lblMessage.InnerText = "warning-> Please upload a valid Excel file.";
                    return;
                }

                lblUploadFileName.Text = fuEmployeeExcel.FileName;
                DataTable excelData = ReadEmployeeImportExcel();
                DataTable previewData = BuildEmployeeImportPreview(excelData);
                ViewState[ImportPreviewViewStateKey] = previewData;
                BindEmployeeImportPreview();
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showEmployeeImportModal", "showEmployeeImportModal();", true);
            }
            catch (Exception ex)
            {
                lblMessage.InnerText = "error->" + ex.Message;
            }
        }

        protected void gvEmployeeImportPreview_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "RemoveImportRow") return;

            DataTable previewData = ViewState[ImportPreviewViewStateKey] as DataTable;
            if (previewData == null) return;

            SyncEmployeeImportPreviewFromGrid(previewData, false);

            string importRowId = e.CommandArgument.ToString();
            foreach (DataRow row in previewData.Rows)
            {
                if (row["ImportRowId"].ToString() == importRowId)
                {
                    previewData.Rows.Remove(row);
                    break;
                }
            }

            ViewState[ImportPreviewViewStateKey] = previewData;
            BindEmployeeImportPreview();
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showEmployeeImportModal", "showEmployeeImportModal();", true);
        }

        protected void gvEmployeeImportPreview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            DataRowView row = (DataRowView)e.Row.DataItem;
            DropDownList ddlCompany = (DropDownList)e.Row.FindControl("ddlImportCompany");
            DropDownList ddlEmpType = (DropDownList)e.Row.FindControl("ddlImportEmpType");
            DropDownList ddlDepartment = (DropDownList)e.Row.FindControl("ddlImportDepartment");
            DropDownList ddlDesignation = (DropDownList)e.Row.FindControl("ddlImportDesignation");
            DropDownList ddlGroup = (DropDownList)e.Row.FindControl("ddlImportGroup");
            DropDownList ddlShift = (DropDownList)e.Row.FindControl("ddlImportShift");
            DropDownList ddlEmpstatus = (DropDownList)e.Row.FindControl("ddlEmpstatus");
            DropDownList ddlUnitRow = (DropDownList)e.Row.FindControl("ddlImportUnit");

            BindImportDropdown(ddlCompany, ViewState[ImportCompaniesViewStateKey] as DataTable, "CompanyName", "CompanyId", row["CompanyId"].ToString());
            BindImportDropdown(ddlEmpType, ViewState[ImportEmployeeTypesViewStateKey] as DataTable, "EmpType", "EmpTypeId", row["EmpTypeId"].ToString());
            BindImportDropdown(ddlDepartment, ViewState[ImportDepartmentsViewStateKey] as DataTable, "DptName", "DptId", row["DptId"].ToString());
            BindImportDropdown(ddlDesignation, ViewState[ImportDesignationsViewStateKey] as DataTable, "DsgName", "DsgId", row["DsgId"].ToString());
            BindImportDropdown(ddlGroup, ViewState[ImportGroupsViewStateKey] as DataTable, "GName", "GId", row["GId"].ToString());
            BindImportDropdown(ddlShift, ViewState[ImportShiftsViewStateKey] as DataTable, "SftName", "SftId", row["SftId"].ToString());
            BindImportDropdown(ddlEmpstatus, ViewState[ImportEmployeeStatusViewStateKey] as DataTable, "EmpStatusName", "EmpStatus", row["EmpStatusId"].ToString());
            BindImportDropdown(ddlUnitRow, ViewState[ImportUnitsViewStateKey] as DataTable, "UnitName", "UnitId", row["UnitId"].ToString());

            MarkImportErrorCellIfBlank(e.Row, ddlCompany, 2);
            MarkImportErrorCellIfBlank(e.Row, ddlEmpType, 3);
            MarkImportErrorCellIfBlank(e.Row, ddlDepartment, 7);
            MarkImportErrorCellIfBlank(e.Row, ddlDesignation, 8);
            MarkImportErrorCellIfBlank(e.Row, ddlGroup, 9);
            MarkImportErrorCellIfBlank(e.Row, ddlShift, 10);
            MarkImportErrorCellIfBlank(e.Row, ddlEmpstatus, 13);
            MarkImportErrorCellIfBlank(e.Row, ddlUnitRow,19);
        }

        protected void btnSubmitEmployeeImport_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable previewData = ViewState[ImportPreviewViewStateKey] as DataTable;
                if (previewData == null || previewData.Rows.Count == 0)
                {
                    lblMessage.InnerText = "warning-> No employee data found for submit.";
                    return;
                }

                List<EmployeeImportItem> importItems = CollectEmployeeImportItemsFromGrid(previewData);

                if (HasEmployeeImportErrors(previewData))
                {
                    lblImportSummary.Text = "Please select all required dropdown values before submit.";
                    BindEmployeeImportPreview();
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showEmployeeImportModal", "showEmployeeImportModal();", true);
                    return;
                }

                int success = 0;
                foreach (EmployeeImportItem item in importItems)
                {
                    if (ImportPreviewEmployee(item)) success++;
                }

                ViewState[ImportPreviewViewStateKey] = null;
                gvEmployeeImportPreview.DataSource = null;
                gvEmployeeImportPreview.DataBind();
                lblMessage.InnerText = "success-> " + success + " employee(s) imported successfully.";
                btnRefresh_Click(sender, e);
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "hideEmployeeImportModal", "hideEmployeeImportModal();", true);
            }
            catch (Exception ex)
            {
                lblMessage.InnerText = "error->" + ex.Message;
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showEmployeeImportModal", "showEmployeeImportModal();", true);
            }
        }

        private DataTable ReadEmployeeImportExcel()
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            DataTable dt = new DataTable();

            using (ExcelPackage package = new ExcelPackage(fuEmployeeExcel.PostedFile.InputStream))
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.FirstOrDefault();
                if (worksheet == null || worksheet.Dimension == null) return dt;

                Dictionary<int, string> headers = new Dictionary<int, string>();
                for (int col = 1; col <= worksheet.Dimension.Columns; col++)
                {
                    string columnName = GetImportColumnName(worksheet.Cells[1, col].Text);
                    if (columnName.Length == 0) columnName = "Column" + col;
                    if (!dt.Columns.Contains(columnName)) dt.Columns.Add(columnName);
                    headers[col] = columnName;
                }

                for (int row = 2; row <= worksheet.Dimension.Rows; row++)
                {
                    DataRow dr = dt.NewRow();
                    bool hasValue = false;
                    for (int col = 1; col <= worksheet.Dimension.Columns; col++)
                    {
                        string value = worksheet.Cells[row, col].Text.Trim();
                        if (value.Length > 0) hasValue = true;
                        dr[headers[col]] = value;
                    }
                    if (hasValue) dt.Rows.Add(dr);
                }
            }

            return dt;
        }

        private DataTable BuildEmployeeImportPreview(DataTable excelData)
        {
            DataTable preview = CreateEmployeeImportPreviewTable();
            DataTable companyTable = LoadLookupTable("select CompanyName,CompanyId,ShortName from HRD_CompanyInfo order by CompanyName");
            DataTable departmentTable = LoadLookupTable("select DptName,DptId,CompanyId from HRD_Department where DptStatus=1 order by DptName");
            DataTable employeeTypeTable = LoadLookupTable("select EmpType,EmpTypeId from HRD_EmployeeType order by EmpType");
            DataTable designationTable = LoadLookupTable("select DsgName,DsgId,DptId from HRD_Designation where DsgStatus=1 order by DsgName");
            DataTable groupTable = LoadLookupTable("select GName,GId,DptId,CompanyId from HRD_Group where IsActive=1 order by GName");
            DataTable shiftTable = LoadLookupTable("select SftName,SftId,DptId,CompanyId from HRD_Shift where IsActive=1 order by SftName");
            DataTable empStatusTable = LoadLookupTable("select EmpStatus,EmpStatusName from HRD_EmpStatus order by EmpStatus");
            DataTable unitTable = LoadLookupTable("select UnitName,UnitId from HRDUnits order by UnitName");

            ViewState[ImportCompaniesViewStateKey] = companyTable;
            ViewState[ImportDepartmentsViewStateKey] = departmentTable;
            ViewState[ImportEmployeeTypesViewStateKey] = employeeTypeTable;
            ViewState[ImportDesignationsViewStateKey] = designationTable;
            ViewState[ImportGroupsViewStateKey] = groupTable;
            ViewState[ImportShiftsViewStateKey] = shiftTable;
            ViewState[ImportEmployeeStatusViewStateKey] = empStatusTable;
            ViewState[ImportUnitsViewStateKey] = unitTable;

            Dictionary<string, string> companies = BuildLookupDictionary(companyTable, "CompanyName", "CompanyId", null);
            Dictionary<string, string> departments = BuildLookupDictionary(departmentTable, "DptName", "DptId", "CompanyId");
            Dictionary<string, string> employeeTypes = BuildLookupDictionary(employeeTypeTable, "EmpType", "EmpTypeId", null);
            Dictionary<string, string> designations = BuildLookupDictionary(designationTable, "DsgName", "DsgId", "DptId");
            Dictionary<string, string> groups = BuildLookupDictionary(groupTable, "GName", "GId", "DptId");
            Dictionary<string, string> shifts = BuildLookupDictionary(shiftTable, "SftName", "SftId", "DptId");
            Dictionary<string, string> tblStatus = BuildLookupDictionary(empStatusTable, "EmpStatusName", "EmpStatus", null);
            Dictionary<string, string> units = BuildLookupDictionary(unitTable, "UnitName", "UnitId", null);


            int importRowId = 1;
            foreach (DataRow excelRow in excelData.Rows)
            {
                string dptname = excelRow["Department"].ToString();
                DataRow row = preview.NewRow();
                row["ImportRowId"] = importRowId;
                row["ExcelRowNo"] = importRowId + 1;
                importRowId++;
                row["CompanyName"] = GetExcelValue(excelRow, "CompanyName");
                row["EmpType"] = GetExcelValue(excelRow, "EmpType");
                row["SalaryType"] = GetExcelValue(excelRow, "SalaryType");
                row["FullName"] = GetExcelValue(excelRow, "FullName");
                row["NameBangla"] = GetExcelValue(excelRow, "NameBangla");
                row["Department"] = GetExcelValue(excelRow, "Department");
                row["Designation"] = GetExcelValue(excelRow, "Designation");
                row["Group"] = GetExcelValue(excelRow, "Group");
                row["Shift"] = GetExcelValue(excelRow, "Shift");
                string excelCardNo = GetExcelValue(excelRow, "EmpCardNo");
                row["EmpCardNo"] = "Auto Generate";
                row["RegID"] = excelCardNo.Length > 0 ? excelCardNo : GetExcelValue(excelRow, "RegID");
                row["EmpStatus"] = GetExcelValue(excelRow, "EmpStatus");
                row["Type"] = GetExcelValue(excelRow, "Type");
                row["DutyType"] = GetExcelValue(excelRow, "DutyType");
                row["WeekendType"] = GetExcelValue(excelRow, "WeekendType");
                row["JoiningDate"] = GetExcelValue(excelRow, "JoiningDate");
                row["CompanyName"] = GetExcelValue(excelRow, "CompanyName");
                row["UnitName"] = GetExcelValue(excelRow, "UnitName");
                string jjjj = row["DutyType"].ToString();
                List<string> errorFields = new List<string>();
                List<string> errors = new List<string>();
                string companyId = ViewState["__CompanyId__"].ToString();
                string dptId = FindChildLookupId(departments, companyId, row["Department"].ToString());
                string empTypeId = FindLookupId(employeeTypes, row["EmpType"].ToString());
                string dsgId = FindChildLookupId(designations, dptId, row["Designation"].ToString());
                string groupId = FindChildLookupId(groups, dptId, row["Group"].ToString());
                string shiftId = FindChildLookupId(shifts, dptId, row["Shift"].ToString());
                string empStatusId = FindImportEmpStatusId(empStatusTable, tblStatus, row["EmpStatus"].ToString());
                string unitId = FindLookupId(units, row["UnitName"].ToString());
                AddImportError(errorFields, errors, "CompanyName", companyId, row["CompanyName"].ToString());
                AddImportError(errorFields, errors, "Department", dptId, row["Department"].ToString());
                AddImportError(errorFields, errors, "Designation", dsgId, row["Designation"].ToString());
                AddImportError(errorFields, errors, "Group", groupId, row["Group"].ToString());
                AddImportError(errorFields, errors, "Shift", shiftId, row["Shift"].ToString());
                AddImportError(errorFields, errors, "EmpType", empTypeId, row["EmpType"].ToString());
                AddImportError(errorFields, errors, "EmpStatus", empStatusId, row["EmpStatus"].ToString());
                AddImportError(errorFields, errors, "UnitName", unitId, row["UnitName"].ToString());

                row["CompanyId"] = companyId;
                row["DptId"] = dptId;
                row["DsgId"] = dsgId;
                row["GId"] = groupId;
                row["SftId"] = shiftId;
                row["EmpTypeId"] = empTypeId;
                row["SalaryTypeId"] = GetSalaryTypeId(row["SalaryType"].ToString());
                row["EmpStatusId"] = empStatusId;
                row["DutyType"] = row["DutyType"].ToString();
                row["WeekendType"] = row["WeekendType"].ToString();
                row["UnitId"] = unitId;
                row["ErrorFields"] = string.Join(",", errorFields);
                row["ErrorMessage"] = string.Join("; ", errors);
                string jjjjs = row["DutyType"].ToString();
                preview.Rows.Add(row);
            }

            return preview;
        }

        private DataTable CreateEmployeeImportPreviewTable()
        {
            DataTable dt = new DataTable();
            string[] columns = { "ImportRowId", "ExcelRowNo", "CompanyName", "EmpType", "SalaryType", "FullName", "NameBangla", "Department", "Designation", "Group", "Shift", "EmpCardNo", "RegID", "EmpStatus", "Type", "DutyType", "WeekendType", "JoiningDate", "CompanyId", "DptId", "DsgId", "GId", "SftId", "EmpTypeId", "SalaryTypeId", "EmpStatusId", "DutyTypeId", "WeekendTypeId", "ErrorFields", "ErrorMessage","UnitName", "UnitId" };
            foreach (string column in columns) dt.Columns.Add(column);
            return dt;
        }

        private DataTable LoadLookupTable(string query)
        {
            using (SqlCommand cmd = new SqlCommand(query, sqlDB.connection))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    return dt;
                }
            }
        }

        private Dictionary<string, string> BuildLookupDictionary(DataTable table, string textColumn, string valueColumn, string parentColumn)
        {
            Dictionary<string, string> data = new Dictionary<string, string>();
            foreach (DataRow row in table.Rows)
            {
                string key = NormalizeImportKey(row[textColumn].ToString());
                if (parentColumn != null) key = row[parentColumn].ToString() + "|" + key;
                if (!data.ContainsKey(key)) data.Add(key, row[valueColumn].ToString());
            }
            return data;
        }

        private string FindLookupId(Dictionary<string, string> lookup, string name)
        {
            string key = NormalizeImportKey(name);
            return lookup.ContainsKey(key) ? lookup[key] : "";
        }

        private string FindImportEmpStatusId(DataTable empStatusTable, Dictionary<string, string> lookup, string empStatus)
        {
            string id = FindLookupId(lookup, empStatus);
            if (id.Length > 0) return id;

            string key = NormalizeImportKey(empStatus);
            foreach (DataRow row in empStatusTable.Rows)
            {
                string value = row["EmpStatus"].ToString();
                if (value == empStatus || NormalizeImportKey(value) == key) return value;
            }

            string fallbackId = GetEmpStatusId(empStatus);
            foreach (DataRow row in empStatusTable.Rows)
            {
                if (row["EmpStatus"].ToString() == fallbackId) return fallbackId;
            }

            return "";
        }

        private string FindChildLookupId(Dictionary<string, string> lookup, string parentId, string name)
        {
            if (parentId.Length == 0) return "";
            string key = parentId + "|" + NormalizeImportKey(name);
            if (lookup.ContainsKey(key)) return lookup[key];

            string commonKey = "0|" + NormalizeImportKey(name);
            return lookup.ContainsKey(commonKey) ? lookup[commonKey] : "";
        }

        private void BindEmployeeImportPreview()
        {
            DataTable previewData = ViewState[ImportPreviewViewStateKey] as DataTable;
            gvEmployeeImportPreview.DataSource = previewData;
            gvEmployeeImportPreview.DataBind();
            btnSubmitEmployeeImport.Enabled = previewData != null && previewData.Rows.Count > 0;
            lblImportSummary.Text = previewData == null ? "" : "Rows: " + previewData.Rows.Count + " | Problem rows: " + CountEmployeeImportErrors(previewData);
        }

        private bool HasEmployeeImportErrors(DataTable previewData)
        {
            return CountEmployeeImportErrors(previewData) > 0;
        }

        private int CountEmployeeImportErrors(DataTable previewData)
        {
            int count = 0;
            foreach (DataRow row in previewData.Rows)
            {
                if (row["ErrorFields"].ToString().Length > 0) count++;
            }
            return count;
        }

        private List<EmployeeImportItem> CollectEmployeeImportItemsFromGrid(DataTable previewData)
        {
            List<EmployeeImportItem> items = new List<EmployeeImportItem>();
            SyncEmployeeImportPreviewFromGrid(previewData, true, items);
            ViewState[ImportPreviewViewStateKey] = previewData;
            return items;
        }

        private void SyncEmployeeImportPreviewFromGrid(DataTable previewData, bool validate, List<EmployeeImportItem> items = null)
        {
            foreach (GridViewRow gridRow in gvEmployeeImportPreview.Rows)
            {
                string importRowId = gvEmployeeImportPreview.DataKeys[gridRow.RowIndex].Value.ToString();
                DataRow row = previewData.Select("ImportRowId='" + importRowId.Replace("'", "''") + "'").FirstOrDefault();
                if (row == null) continue;

                DropDownList ddlCompany = (DropDownList)gridRow.FindControl("ddlImportCompany");
                DropDownList ddlEmpType = (DropDownList)gridRow.FindControl("ddlImportEmpType");
                DropDownList ddlDepartment = (DropDownList)gridRow.FindControl("ddlImportDepartment");
                DropDownList ddlDesignation = (DropDownList)gridRow.FindControl("ddlImportDesignation");
                DropDownList ddlGroup = (DropDownList)gridRow.FindControl("ddlImportGroup");
                DropDownList ddlShift = (DropDownList)gridRow.FindControl("ddlImportShift");
                DropDownList ddlEmpstatus = (DropDownList)gridRow.FindControl("ddlEmpstatus");
                DropDownList ddlUnitRow = (DropDownList)gridRow.FindControl("ddlImportUnit");

                List<string> errorFields = new List<string>();
                List<string> errors = new List<string>();
                if (validate)
                {
                    ValidateSelectedDropdown(errorFields, errors, "CompanyName", ddlCompany);
                    ValidateSelectedDropdown(errorFields, errors, "EmpType", ddlEmpType);
                    ValidateSelectedDropdown(errorFields, errors, "Department", ddlDepartment);
                    ValidateSelectedDropdown(errorFields, errors, "Designation", ddlDesignation);
                    ValidateSelectedDropdown(errorFields, errors, "Group", ddlGroup);
                    ValidateSelectedDropdown(errorFields, errors, "Shift", ddlShift);
                    ValidateSelectedDropdown(errorFields, errors, "EmpStatus", ddlEmpstatus);
                    ValidateSelectedDropdown(errorFields, errors, "UnitName", ddlUnitRow);
                }
                row["UnitId"] = ddlUnitRow.SelectedValue;
                row["CompanyId"] = ddlCompany.SelectedValue;
                row["EmpTypeId"] = ddlEmpType.SelectedValue;
                row["DptId"] = ddlDepartment.SelectedValue;
                row["DsgId"] = ddlDesignation.SelectedValue;
                row["GId"] = ddlGroup.SelectedValue;
                row["SftId"] = ddlShift.SelectedValue;
                row["EmpStatusId"] = ddlEmpstatus.SelectedValue;
                row["ErrorFields"] = string.Join(",", errorFields);
                row["ErrorMessage"] = string.Join("; ", errors);

                if (items != null)
                {
                    items.Add(new EmployeeImportItem
                    {
                        CompanyId = ddlCompany.SelectedValue,
                        EmpTypeId = ddlEmpType.SelectedValue,
                        DptId = ddlDepartment.SelectedValue,
                        DsgId = ddlDesignation.SelectedValue,
                        GId = ddlGroup.SelectedValue,
                        SftId = ddlShift.SelectedValue,
                        EmpstatusId = ddlEmpstatus.SelectedValue,
                        UnitId = ddlUnitRow.SelectedValue,
                        Row = row
                    });
                }
            }
        }

        private void ValidateSelectedDropdown(List<string> errorFields, List<string> errors, string fieldName, DropDownList ddl)
        {
            if (ddl != null && ddl.SelectedValue.Length > 0) return;
            errorFields.Add(fieldName);
            errors.Add(fieldName + " required");
        }

        private void BindImportDropdown(DropDownList ddl, DataTable source, string textField, string valueField, string selectedValue)
        {
            if (ddl == null || source == null) return;

            ddl.DataTextField = textField;
            ddl.DataValueField = valueField;
            ddl.DataSource = source;
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("", ""));

            if (selectedValue.Length > 0 && ddl.Items.FindByValue(selectedValue) != null)
            {
                ddl.SelectedValue = selectedValue;
            }

            ddl.Attributes["onchange"] = "clearEmployeeImportCellError(this)";
        }

        private bool ImportPreviewEmployee(EmployeeImportItem item)
        {
            DataRow row = item.Row;
            System.Data.SqlTypes.SqlDateTime nullDate = System.Data.SqlTypes.SqlDateTime.Null;
            string empId = LoadEmployeeImportEmpId();
            string joiningDate = GetImportDate(row["JoiningDate"].ToString());
            string empCardNo = GenerateEmployeeImportCardNo(item.CompanyId);
            row["EmpCardNo"] = empCardNo;
            row["RegID"] = row["RegID"].ToString().Length > 0 ? row["RegID"].ToString() : row["EmpCardNo"].ToString();
            string weekednType = row["WeekendType"].ToString();
            string dutyType = row["DutyType"].ToString();

            using (SqlCommand cmd = new SqlCommand("saveEmployeeInfo", sqlDB.connection))
            {
                

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpId", empId);
                cmd.Parameters.AddWithValue("@CompanyId", item.CompanyId);
                cmd.Parameters.AddWithValue("@EmpTypeId", Convert.ToInt32(item.EmpTypeId));
                cmd.Parameters.AddWithValue("@EmpName", row["FullName"].ToString());
                cmd.Parameters.AddWithValue("@NickName", row["FullName"].ToString());
                cmd.Parameters.AddWithValue("@EmpNameBn", row["NameBangla"].ToString());
                cmd.Parameters.AddWithValue("@EmpCardNo", empCardNo);
                cmd.Parameters.AddWithValue("@EmpProximityNo", row["RegID"].ToString());
                cmd.Parameters.AddWithValue("@PunchType", 0);
                cmd.Parameters.AddWithValue("@RealProximityNo", row["RegID"].ToString());
                cmd.Parameters.AddWithValue("@EmpStatus", row["EmpStatusId"].ToString());
                cmd.Parameters.AddWithValue("@SftId", item.SftId);
                cmd.Parameters.AddWithValue("@EmpJoiningDate", joiningDate);
                cmd.Parameters.AddWithValue("@ShiftTransferDate", joiningDate);
                cmd.Parameters.AddWithValue("@EarnedLeave", 0);
                cmd.Parameters.AddWithValue("@EarnedLeaveEffectedFrom", nullDate);
                cmd.Parameters.AddWithValue("@EmpPicture", "");
                cmd.Parameters.AddWithValue("@SignatureImage", "");
                cmd.Parameters.AddWithValue("@Type", row["Type"].ToString());
                cmd.Parameters.AddWithValue("@ExpireDate", nullDate);
                cmd.Parameters.AddWithValue("@PreCompanyId", item.CompanyId);
                cmd.Parameters.AddWithValue("@PreEmpTypeId", Convert.ToInt32(item.EmpTypeId));
                cmd.Parameters.AddWithValue("@PreDptId", item.DptId);
                cmd.Parameters.AddWithValue("@DptId", item.DptId);
                cmd.Parameters.AddWithValue("@PreDsgId", item.DsgId);
                cmd.Parameters.AddWithValue("@DsgId", item.DsgId);
                cmd.Parameters.AddWithValue("@PreGId", item.GId);
                cmd.Parameters.AddWithValue("@GId", item.GId);
                cmd.Parameters.AddWithValue("@PreEmpStatus", row["EmpStatusId"].ToString());
                cmd.Parameters.AddWithValue("@DateofUpdate", DateTime.Now.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@TypeOfChange", "s");
                cmd.Parameters.AddWithValue("@EffectiveMonth", "");
                cmd.Parameters.AddWithValue("@OrderRefNo", "");
                cmd.Parameters.AddWithValue("@OrderRefDate", nullDate);
                cmd.Parameters.AddWithValue("@Remarks", "");
                cmd.Parameters.AddWithValue("@ActiveSalary", 1);
                cmd.Parameters.AddWithValue("@EarnLeaveDate", joiningDate);
                cmd.Parameters.AddWithValue("@IsActive", 1);
                cmd.Parameters.AddWithValue("@CustomOrdering", 0);
                cmd.Parameters.AddWithValue("@TIN", "");
                cmd.Parameters.AddWithValue("@PreSalaryType", row["SalaryTypeId"].ToString());
                cmd.Parameters.AddWithValue("@SalaryType", row["SalaryTypeId"].ToString());
                cmd.Parameters.AddWithValue("@PreEmpDutyType", row["DutyType"].ToString());
                cmd.Parameters.AddWithValue("@EmpDutyType", row["DutyType"].ToString());
                cmd.Parameters.AddWithValue("@AuthorizedPerson", true);
                cmd.Parameters.AddWithValue("@WeekendType", row["WeekendType"].ToString());
                cmd.Parameters.AddWithValue("@Weekend", "");
                cmd.Parameters.AddWithValue("@UnitId", item.UnitId.Length > 0 ? item.UnitId : "0");
                cmd.Parameters.AddWithValue("@CreatedBy", item.UnitId.Length > 0 ? item.UnitId : "0");

                object result = cmd.ExecuteScalar();
                return result != null && Convert.ToInt32(result) > 0;
            }
        }

        private string GenerateEmployeeImportCardNo(string companyId)
        {
            companyId = (companyId ?? "").Trim();
            if (companyId.Length == 0) return "";

            DataTable company = new DataTable();
            sqlDB.fillDataTable("Select StartCardNo,ShortName,FlatCode,CardNoDigits From HRD_CompanyInfo where CompanyId='" + companyId + "'", company);
            if (company.Rows.Count == 0) return "";

            string shortName = company.Rows[0]["ShortName"].ToString();
            string flatCode = company.Rows[0]["FlatCode"].ToString();
            string startCardNo = company.Rows[0]["StartCardNo"].ToString();
            int cardNoDigits = 0;
            int.TryParse(company.Rows[0]["CardNoDigits"].ToString(), out cardNoDigits);

            DataTable dt = new DataTable();
            int startIndex = 8 + flatCode.Length;
            string cmd = "select max(convert(int,substring(EmpCardNo," + startIndex + ",15) ))as MaxCardNo,substring(EmpCardNo," + startIndex + ",15) as EmpCardNo from v_Personnel_EmpCurrentStatus  " +
                "where CompanyId='" + companyId + "'  group by substring(EmpCardNo," + startIndex + ",15) having max(convert(int,substring(EmpCardNo," + startIndex + ",15) ))=(select max(convert(int,substring(EmpCardNo," + startIndex + ",15) )) from v_Personnel_EmpCurrentStatus  " +
                "where CompanyId='" + companyId + "')";
            sqlDB.fillDataTable(cmd, dt);

            string newCardNo = startCardNo;
            if (dt.Rows.Count > 0 && dt.Rows[0]["MaxCardNo"].ToString().Length > 0)
            {
                string maxCardNo = dt.Rows[0]["EmpCardNo"].ToString();
                if (maxCardNo.Length > cardNoDigits) cardNoDigits = maxCardNo.Length;
                newCardNo = (int.Parse(maxCardNo) + 1).ToString();
            }

            if (cardNoDigits > 0) newCardNo = newCardNo.PadLeft(cardNoDigits, '0');
            return shortName + DateTime.Now.Year + flatCode + newCardNo;
        }

        private string LoadEmployeeImportEmpId()
        {
            DataTable dt = new DataTable();
            sqlDB.fillDataTable("Select Max(SL) as SL From Personnel_EmployeeInfo", dt);
            if (dt.Rows[0]["SL"].ToString() == "") return "00000001";

            DataTable dtEMPID = new DataTable();
            sqlDB.fillDataTable("Select EmpId From Personnel_EmployeeInfo where SL=" + dt.Rows[0]["SL"].ToString(), dtEMPID);
            int nextId = int.Parse(dtEMPID.Rows[0]["EmpId"].ToString()) + 1;
            return nextId.ToString().PadLeft(8, '0');
        }

        private string GetCurrentCompanyId()
        {
            if (ddlCompanyList.SelectedValue.Length > 0 && ddlCompanyList.SelectedValue != "0000") return ddlCompanyList.SelectedValue;
            return ViewState["__CompanyId__"].ToString();
        }

        private string GetExcelValue(DataRow row, string columnName)
        {
            string normalizedColumn = GetImportColumnName(columnName);
            return row.Table.Columns.Contains(normalizedColumn) ? row[normalizedColumn].ToString().Trim() : "";
        }

        private string GetImportColumnName(string columnName)
        {
            string key = NormalizeImportKey(columnName);
            if (key == "department" || key == "departmentt" || key == "departmen.t") return "Department";
            if (key == "companyname" || key == "company") return "CompanyName";
            if (key == "designation") return "Designation";
            if (key == "group") return "Group";
            if (key == "shift") return "Shift";
            if (key == "emptype") return "EmpType";
            if (key == "salarytype") return "SalaryType";
            if (key == "fullname" || key == "name") return "FullName";
            if (key == "namebangla" || key == "banglaname") return "NameBangla";
            if (key == "empcardno") return "EmpCardNo";
            if (key == "regid" || key == "registrationid") return "RegID";
            if (key == "empstatus") return "EmpStatus";
            if (key == "type") return "Type";
            if (key == "dutytype") return "DutyType";
            if (key == "weekendtype") return "WeekendType";
            if (key == "joiningdate") return "JoiningDate";
            if (key == "unitname" || key == "unit") return "UnitName";
            return key;
        }

        private string NormalizeImportKey(string value)
        {
            return new string((value ?? "").Trim().ToLower().Where(char.IsLetterOrDigit).ToArray());
        }

        private void AddImportError(List<string> errorFields, List<string> errors, string fieldName, string id, string value)
        {
            if (id.Length > 0) return;
            errorFields.Add(fieldName);
            errors.Add(fieldName + " not found: " + value);
        }

        private void MarkImportErrorCellIfBlank(GridViewRow row, DropDownList ddl, int cellIndex)
        {
            if (ddl == null || ddl.SelectedValue.Length == 0) row.Cells[cellIndex].CssClass = "import-error-cell";
        }

        private string GetSalaryTypeId(string salaryType)
        {
            string value = salaryType.Trim().ToLower();
            if (value == "scale" || value == "0") return "0";
            if (value == "gross" || value == "1") return "1";
            return "2";
        }

        private string GetEmpStatusId(string empStatus)
        {
            string value = empStatus.Trim().ToLower();
            if (value == "" || value == "active" || value == "running") return "1";
            if (value == "inactive") return "0";
            return empStatus;
        }

        private string GetDutyTypeId(string dutyType)
        {
            string value = dutyType.Trim().ToLower();
            return value == "roster" || value == "1" ? "1" : "0";
        }

        private string GetWeekendTypeId(string weekendType)
        {
            string value = weekendType.Trim().ToLower();
            return value == "special" || value == "1" ? "1" : "0";
        }

        private string GetImportDate(string dateText)
        {
            DateTime date;
            string[] formats = { "dd-MM-yyyy", "d-M-yyyy", "dd/MM/yyyy", "d/M/yyyy", "yyyy-MM-dd", "M/d/yyyy", "MM/dd/yyyy" };
            if (DateTime.TryParseExact(dateText, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out date) || DateTime.TryParse(dateText, out date))
            {
                return date.ToString("yyyy-MM-dd");
            }
            return DateTime.Now.ToString("yyyy-MM-dd");
        }

        //private void loadDepartMents()
        //{
        //    if (Session["__dataAceesLevel__"].ToString() == "4")
        //    {
        //        classes.commonTask.loadDepartmentListByCompany(ddlDepartmentList, ViewState["__CompanyId__"].ToString(), Session["__dataAccesPemission__"].ToString());

        //    }
        //    else if (Session["__dataAceesLevel__"].ToString() == "3")
        //    {

        //        classes.commonTask.loadDepartmentListByCompany(ddlDepartmentList, ViewState["__CompanyId__"].ToString(), "");
        //    }
        //    else if (Session["__dataAceesLevel__"].ToString() == "2")
        //    {
        //        classes.commonTask.loadDepartmentListByCompany(ddlDepartmentList, ViewState["__CompanyId__"].ToString(), ViewState["__dptID__"].ToString());

        //    }
        //    //classes.commonTask.loadDepartmentListByCompany(ddlDepartmentList, ViewState["__CompanyId__"].ToString());
        //}
    }
}
