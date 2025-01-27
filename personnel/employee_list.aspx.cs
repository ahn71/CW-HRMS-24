﻿using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
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
                
                ViewState["__LineORGroupDependency__"] = classes.commonTask.GroupORLineDependency();
                loadYear();
                setPrivilege(userPagePermition);

               // SearchingInEmployeeList();
                if (ViewState["__LineORGroupDependency__"].ToString().Equals("False"))
                    classes.commonTask.LoadGrouping(ddlGrouping, ViewState["__CompanyId__"].ToString());

                string condition = AccessControl.getDataAccessCondition(ViewState["__CompanyId__"].ToString(),"0");
                string query = "Select EmpDutyType,CompanyId,EmpId, EmpCardNo+' ('+EmpProximityNo+')' as EmpCardNo,EmpName,convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,DptName,DsgName,SftName, convert(varchar(11),EmpShiftStartDate,105) as EmpShiftStartDate,EmpStatusName,EmpType,ISNULL(WeekendType,'Regular') as WeekendType From v_EmployeeDetails where EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and " + condition + " order by DptCode, CustomOrdering";


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

                string query = "Select EmpDutyType,CompanyId, EmpId,EmpCardNo+' ('+EmpProximityNo+')' as EmpCardNo,EmpName,convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,DptName,DsgName,SftName, convert(varchar(11),EmpShiftStartDate,105) as EmpShiftStartDate,EmpStatusName,EmpType,ISNULL(WeekendType,'Regular') as WeekendType From v_EmployeeDetails where ";
                string queryCondition = "";
                DataTable dt = new DataTable();
                // 0.Search by Compnay
                if (ddlCompanyList.SelectedItem.Text.Trim() != "" && (ddlDepartmentList.SelectedIndex == -1 || ddlDepartmentList.SelectedIndex == 0) && (ddlShift.SelectedIndex == -1 || ddlShift.SelectedIndex == 0) && txtFromDate.Text.Trim().Length == 0 && txtToDate.Text.Trim().Length == 0 && txtCardNo.Text.Trim().Length == 0)
                {
                    queryCondition="EmpStatus in ('1','8') and IsActive='1' and ActiveSalary='True' and " + condtidion + " order by DptCode, CustomOrdering";
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