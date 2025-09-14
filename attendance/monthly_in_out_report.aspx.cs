using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace SigmaERP.attendance
{
    public partial class monthly_in_out_report : System.Web.UI.Page
    {
        string CompanyId="";
        //view=267;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            lblMessage.InnerText = "";
            int[] pagePermission = { 267 };
            if (!IsPostBack)
            {
                RegularRules();
                int[] userPagePermition = AccessControl.hasPermission(pagePermission);
                if (!userPagePermition.Any())
                    Response.Redirect(Routing.defualtUrl);

                classes.commonTask.LoadEmpTypeWithAll(rblEmpType);
                setPrivilege();
                if (!classes.commonTask.HasBranch())
                ddlCompanyName.Enabled = false;
                ddlCompanyName.SelectedValue = ViewState["__CompanyId__"].ToString();
                Session["__MinDigits__"] = "6";
            }
        }

        DataTable dtSetPrivilege;
        private void setPrivilege()
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];

                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__CShortName__"] = getCookies["__CShortName__"].ToString();

               // string[] AccessPermission = new string[0];
                //System.Web.UI.HtmlControls.HtmlTable a = tblGenerateType;
                classes.commonTask.LoadBranch(ddlCompanyName, ViewState["__CompanyId__"].ToString());
                // AccessPermission = checkUserPrivilege.checkUserPrivilegeForReport(ViewState["__CompanyId__"].ToString(), getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "monthly_in_out_report.aspx", ddlCompanyName, WarningMessage, tblGenerateType, btnPreview);
              //  ViewState["__ReadAction__"] = AccessPermission[0];
                classes.commonTask.loadMonthIdByCompany(ddlMonthList, ViewState["__CompanyId__"].ToString());
                classes.commonTask.LoadDepartment(ViewState["__CompanyId__"].ToString(), lstAll);
                classes.commonTask.LoadActiveShiftsForCompany(ViewState["__CompanyId__"].ToString(), ddlPermanentShift);
                classes.commonTask.loadUnit(ddlUnit, ViewState["__CompanyId__"].ToString());
                if (ddlUnit.Items.Count < 3)
                {
                    trUnit.Visible = false;
                }

            }
            catch { }

        }

  
        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
            classes.commonTask.AddRemoveItem(lstAll, lstSelected);
        }

        protected void btnAddAllItem_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
            classes.commonTask.AddRemoveAll(lstAll, lstSelected);
        }

        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
            classes.commonTask.AddRemoveItem(lstSelected, lstAll);
        }

        protected void btnRemoveAllItem_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
            classes.commonTask.AddRemoveAll(lstSelected, lstAll);
        }      

        protected void ddlShiftName_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                lstAll.Items.Clear();
                lstSelected.Items.Clear();
                 CompanyId = (ddlCompanyName.SelectedValue.ToString().Equals("0000")) ? ViewState["__CompanyId__"].ToString() : ddlCompanyName.SelectedValue.ToString();         
                }
            catch { }
        }

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            try
            {//------------------------Validation--------------------------------
                if (rblGenerateType.SelectedIndex == 0)
                {
                    if (ddlMonthList.SelectedValue == "0")
                    {
                        lblMessage.InnerText = "warning-> Please Select Any Month!"; ddlMonthList.Focus();
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                        return;
                    }
                    if (lstSelected.Items.Count == 0)
                    {
                        lblMessage.InnerText = "warning-> Please Select Any Department!"; lstSelected.Focus();
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                        return;
                    }
                }
                else
                {
                    if (ddlMonthList.SelectedValue == "0")
                    {
                        lblMessage.InnerText = "warning-> Please Select Any Month!"; ddlMonthList.Focus();
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                        return;
                    }
                    if (txtCardNo.Text.Trim().Length ==0)
                    {
                        lblMessage.InnerText = "warning-> Please Type Valid Card Number!";
                        txtCardNo.Focus();
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                        return;
                    }
                }
                //----------------------------End-------------------------------
                if (rblReportType.SelectedValue == "3")
                {
                    if (ViewState["__CShortName__"].ToString().Equals("MRC"))// Marico
                        GenerateJobCardReport_Marico();
                    else
                        GenerateJobCardReport();
                }
                else if (rblReportType.SelectedValue == "5")  //regular
                {
                    if (ViewState["__CShortName__"].ToString().Equals("MRC"))// Marico
                        GenerateJobCardReport_Marico();
                    else
                    {
                        if(ViewState["__reportFor__"].ToString() == "jobcard")
                            _GenerateJobCardReportForActualAndCompliance(); // for complaince

                        else
                            GenerateJobCardReportForActualAndCompliance();
                        





                    }
                        


                }
                else if (rblReportType.SelectedValue == "4")
                {
                    GenerateHolidayAndWeekendReport();
                }
                else
                {
                    if (rblLanguage.SelectedValue == "EN")
                        GenerateReportEnglish();
                    else
                        GenerateReportBangla();
                }
            }
            catch { }
        }
        private void GenerateReportEnglish()
        {
            try
            {
                string EmpTypeID = (rblEmpType.SelectedValue == "All") ? "" : " and EmpTypeId= " + rblEmpType.SelectedValue + "";
                string CompanyList = "";
                string ShiftList = "";
                string DepartmentList = "";
                string ReportTitle = "";
                string ReportDate = "";

                if (!Page.IsValid)   // If Java script are desible then 
                {
                    lblMessage.InnerText = "erroe->Please Select From Date And To Date"; return;
                }

                string unitCondition = "";
                if (ddlUnit.SelectedValue != "0")
                {
                    unitCondition = " and UnitId=" + ddlUnit.SelectedValue;
                }

                CompanyList = (ddlCompanyName.SelectedValue.ToString().Equals("0000")) ? ViewState["__CompanyId__"].ToString() : ddlCompanyName.SelectedValue.ToString();
                CompanyList = "in ('" + CompanyList + "')";
                DepartmentList = classes.commonTask.getDepartmentList(lstSelected);




                DataTable dt = new DataTable();

                string[] MY = ddlMonthList.SelectedItem.Value.ToString().Split('-');
                string type = "";
                string ShiftName = "";
                if (ddlPermanentShift.SelectedValue != "0")
                {
                    ShiftName += " and PSftId='" + ddlPermanentShift.SelectedValue + "' ";
                }
                if (rblReportType.SelectedValue == "0")
                {
                    dt = classes.BusinessLogic.get_MonthlyLoginLogOutTime(CompanyList, DepartmentList, MY[0], MY[1], rblGenerateType.SelectedIndex, txtCardNo.Text, EmpTypeID, unitCondition, ShiftName);
                    type = "Log InOut";
                }
                else if (rblReportType.SelectedValue == "1")
                {
                    dt = classes.BusinessLogic.get_Moanthly_Attendance_Sheet(CompanyList, DepartmentList, MY[0], MY[1], rblGenerateType.SelectedIndex, txtCardNo.Text, EmpTypeID, unitCondition, ShiftName);
                    type = "Att Status";
                }
                else
                {
                    dt = classes.BusinessLogic.get_Moanthly_Attendance_Sheet_Summary(CompanyList, DepartmentList, MY[0], MY[1], rblGenerateType.SelectedIndex, txtCardNo.Text, EmpTypeID, unitCondition, ShiftName);


                    dt.Columns["ATTStatus"].ReadOnly = false;
                    foreach (DataRow row in dt.Rows)
                    {

                        if (row["ATTStatus"].ToString() == "H" || row["ATTStatus"].ToString() == "W")
                        {
                            DateTime currentDate = DateTime.ParseExact(row["ATTDate"].ToString(), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                            string empId = row["EmpId"].ToString();

                            // look backward
                            DateTime backDate = currentDate.AddDays(-1);
                            string backStatus = null;
                            while (true)
                            {
                                DataRow[] prev = dt.Select($"EmpId = '{empId}' AND ATTDate = '{backDate:dd-MM-yyyy}'");
                                if (prev.Length == 0) break;
                                backStatus = prev[0]["ATTStatus"].ToString();
                                if (backStatus != "H" && backStatus != "W") break; // stop when non-H/W found
                                backDate = backDate.AddDays(-1);
                            }

                            // look forward
                            DateTime nextDate = currentDate.AddDays(1);
                            string forwardStatus = null;
                            while (true)
                            {
                                DataRow[] next = dt.Select($"EmpId = '{empId}' AND ATTDate = '{nextDate:dd-MM-yyyy}'");
                                if (next.Length == 0) break;
                                forwardStatus = next[0]["ATTStatus"].ToString();
                                if (forwardStatus != "H" && forwardStatus != "W") break;
                                nextDate = nextDate.AddDays(1);
                            }

                            // condition: both sides are "A"
                            if (backStatus == "A" && forwardStatus == "A")
                            {
                                row["ATTStatus"] = "A";
                            }
                        }
                    }
                    type = "Att Summary";
                }


                if (dt.Rows.Count == 0)
                {
                    lblMessage.InnerText = "warning->No Attendance Available";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                    return;
                }
                Session["__MonthlyLoginLogoutReport__"] = dt;

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=MonthlyLoginLogoutReport-" + ddlMonthList.SelectedItem.Value.ToString() + "-" + type + "');", true);  //Open New Tab for Sever side code
            }
            catch { }
        }
    
        private void GenerateReportBangla()
        {
            try
            {
                string EmpTypeID = (rblEmpType.SelectedValue == "All") ? "" : " and EmpTypeId= " + rblEmpType.SelectedValue + "";
                string CompanyList = "";
                string ShiftList = "";
                string DepartmentList = "";
                string ReportTitle = "";
                string ReportDate = "";

                if (!Page.IsValid)   // If Java script are desible then 
                {
                    lblMessage.InnerText = "erroe->Please Select From Date And To Date"; return;
                }

                CompanyList = (ddlCompanyName.SelectedValue.ToString().Equals("0000")) ? ViewState["__CompanyId__"].ToString() : ddlCompanyName.SelectedValue.ToString();
                CompanyList = "in ('" + CompanyList + "')";
                DepartmentList = classes.commonTask.getDepartmentList(lstSelected);

                string unitCondition = "";
                if (ddlUnit.SelectedValue != "0")
                {
                    unitCondition = " and UnitId=" + ddlUnit.SelectedValue;
                }


                DataTable dt = new DataTable();

                string[] MY = ddlMonthList.SelectedItem.Value.ToString().Split('-');
                string type = "";

                if (rblReportType.SelectedIndex == 0)
                {
                    dt = classes.BusinessLogic.get_MonthlyLoginLogOutTimeBangla(CompanyList, DepartmentList, MY[0], MY[1], rblGenerateType.SelectedIndex, txtCardNo.Text, EmpTypeID, unitCondition);
                    type = "Log InOut";
                }
                else if (rblReportType.SelectedIndex == 1)
                {
                    dt = classes.BusinessLogic.get_Moanthly_Attendance_SheetBangla(CompanyList, DepartmentList, MY[0], MY[1], rblGenerateType.SelectedIndex, txtCardNo.Text, EmpTypeID, unitCondition);
                    type = "Att Status";
                }
                else
                {
                    dt = classes.BusinessLogic.get_Moanthly_Attendance_Sheet_SummaryBangla(CompanyList, DepartmentList, MY[0], MY[1], rblGenerateType.SelectedIndex, txtCardNo.Text, EmpTypeID, unitCondition);
                    type = "Att Summary";
                }

                //  sqlDB.fillDataTable("select SftEndTime from HRD_Shift where SftId=" + ddlShiftName.SelectedItem.Value.ToString() + "", dt);







                if (dt.Rows.Count == 0)
                {
                    lblMessage.InnerText = "warning->No Attendance Available";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                    return;
                }
                Session["__MonthlyLoginLogoutReportBangla__"] = dt;

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=MonthlyLoginLogoutReportBangla-" + classes.commonTask.GenerateBanglaMonthNameMY(ddlMonthList.SelectedValue) + "-" + type + "');", true);  //Open New Tab for Sever side code
            }
            catch { }
        }
    

        protected void rblGenerateType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                if (rblGenerateType.SelectedIndex == 0) txtCardNo.Enabled = false;
                else { txtCardNo.Enabled = true; txtCardNo.Focus(); }
            }
            catch { }
        }

        protected void ddlCompanyName_SelectedIndexChanged(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
            CompanyId = (ddlCompanyName.SelectedValue.ToString().Equals("0000")) ? ViewState["__CompanyId__"].ToString() : ddlCompanyName.SelectedValue.ToString();
            classes.commonTask.loadMonthIdByCompany(ddlMonthList,CompanyId) ;
            classes.commonTask.LoadDepartment(CompanyId, lstAll);
            lstSelected.Items.Clear();
          //  classes.commonTask.LoadShift(ddlShiftName, CompanyId, ViewState["__UserType__"].ToString());
          
        }
        private void GenerateJobCardReport_Marico()
        {


            try
            {

                string EmpTypeID = (rblEmpType.SelectedValue == "All") ? "" : " and EmpTypeId= " + rblEmpType.SelectedValue + "";
                string DepartmentList = "";
                if (rblGenerateType.SelectedValue == "0")
                    DepartmentList = classes.commonTask.getDepartmentList(lstSelected);

                string[] Month = ddlMonthList.SelectedValue.Split('-');
                string sql = "";
                DataTable dt = new DataTable();
                if (rblGenerateType.SelectedValue == "1")
                {
                    bool hasEmpCard = AccessControl.hasEmpcardPermission(txtCardNo.Text.Trim(), ddlCompanyName.SelectedValue);

                    if (!hasEmpCard)
                    {
                        lblMessage.InnerText = "warning-> You have no permission on this Employee";
                        txtCardNo.Focus();
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                        return;
                    }

                    sql = " Select EmpId,SubString(EmpCardNo,8,15)+' ( '+EmpProximityNo+' )' as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,case when ODID >0 then ATTStatus+'(OD)' else ATTStatus end as ATTStatus,StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime, 1 as OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,TotalOverTime,TotalDays,PaybleDays From v_tblAttendanceRecord " +
                     " Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "'  order by  ATTDate";
                }                  
                 


                else                    
                    sql = " Select EmpId,SubString(EmpCardNo,8,15)+' ( '+EmpProximityNo+' )' as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,case when ODID >0 then ATTStatus+'(OD)' else ATTStatus end as ATTStatus,StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,1 as OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,TotalOverTime,TotalDays,PaybleDays From v_tblAttendanceRecord " +
                        " Where CompanyId='" + ddlCompanyName.SelectedValue + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + EmpTypeID + "  Order By convert(int,DptId), CustomOrdering,Empid, ATTDate";
                //    sqlDB.fillDataTable("Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, StayTime )-convert(varchar(8),OtherOverTime,114)),'hh:mm:ss') ) else   StayTime end as StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime as TotalOverTime,TotalDays,OtherOverTime,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, OutHour+':'+OutMin+':'+OutSec )-convert(varchar(8),OtherOverTime,114)) +convert(datetime,'00:00:'+OutSec ),'HH:mm:ss')) else   OutHour+':'+OutMin+':'+OutSec end as OutTime From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' Group By EmpId,EmpCardNo,EmpName,SftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime,TotalDays,OtherOverTime order by  ATTDate  ", dt);
                //else sqlDB.fillDataTable("Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, StayTime )-convert(varchar(8),OtherOverTime,114)),'hh:mm:ss') ) else   StayTime end as StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime as TotalOverTime,TotalDays,OtherOverTime,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, OutHour+':'+OutMin+':'+OutSec )-convert(varchar(8),OtherOverTime,114))+convert(datetime,'00:00:'+OutSec ),'HH:mm:ss') ) else   OutHour+':'+OutMin+':'+OutSec end as OutTime From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + EmpTypeID + " Group By EmpId,EmpCardNo,EmpName,SftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime,TotalDays,GId,CustomOrdering ,OtherOverTime Order By convert(int,DptId), CustomOrdering,Empid, ATTDate   ", dt);
                sqlDB.fillDataTable(sql, dt);
                Session["__dtJobCard__"] = dt;
                if (dt.Rows.Count > 0)
                {
                    DataTable dtSummary = new DataTable();
                   

                    if (rblGenerateType.SelectedValue == "1") sqlDB.fillDataTable("Select EmpId,SUM(CASE WHEN StateStatus = 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN StateStatus = 'Casual Leave' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN StateStatus = 'Sick Leave' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN StateStatus = 'Maternity Leave' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN StateStatus = 'Annual Leave' THEN 1 ELSE 0 END) AS 'EL',SUM(CASE WHEN StateStatus = 'Holiday' THEN 1 ELSE 0 END) AS 'Holiday',SUM(CASE WHEN StateStatus = 'Present' THEN 1 ELSE 0 END) AS 'Present',SUM(CASE WHEN StateStatus = 'Weekend' THEN 1 ELSE 0 END) AS 'Weekend',Sum(PaybleDays) AS 'APday' From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' group by EmpId", dtSummary);
                    else sqlDB.fillDataTable("Select EmpId,SUM(CASE WHEN StateStatus = 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN StateStatus = 'Casual Leave' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN StateStatus = 'Sick Leave' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN StateStatus = 'Maternity Leave' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN StateStatus = 'Annual Leave' THEN 1 ELSE 0 END) AS 'EL',SUM(CASE WHEN StateStatus = 'Holiday' THEN 1 ELSE 0 END) AS 'Holiday',SUM(CASE WHEN StateStatus = 'Present' THEN 1 ELSE 0 END) AS 'Present',SUM(CASE WHEN StateStatus = 'Weekend' THEN 1 ELSE 0 END) AS 'Weekend',Sum(PaybleDays) AS 'APday' From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' " + EmpTypeID + " and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " group by EmpId", dtSummary);
                    Session["__dtSummary__"] = dtSummary;
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=JobCardReportActualMarico');", true);  //Open New Tab for Sever side code         
                }
                else
                {
                    lblMessage.InnerText = "warning->No Attendance Available";
                }
            }
            catch { }
        }

        private void GenerateJobCardReport() 
        {

          
            try
            {

                string EmpTypeID = (rblEmpType.SelectedValue == "All") ? "" : " and EmpTypeId= " + rblEmpType.SelectedValue + "";
                string DepartmentList = "";
                if(rblGenerateType.SelectedValue=="0")
                DepartmentList = classes.commonTask.getDepartmentList(lstSelected);

                string unitCondition = "";
                if (ddlUnit.SelectedValue != "0")
                {
                    unitCondition = " and UnitId=" + ddlUnit.SelectedValue;
                }
                string[] Month = ddlMonthList.SelectedValue.Split('-');
                string sql = "";
                DataTable dt = new DataTable();
                if (rblGenerateType.SelectedValue == "1")
                    //sql = "with" +
                    //      " att as (SELECT a.*, s.SftStartTime,s.SftEndTime," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end as OutHour1 ," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec as Out,SUBSTRING(OutHour + ':' + OutMin + ':' + OutSec, 5, 4) OutTemp, case when(s.SftEndTime < convert(time," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec)) then(FORMAT((convert(datetime," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec) - convert(varchar(8), s.SftEndTime, 114)), 'HH:mm:ss')) else '00:00:00' end as ActualOverTime,  case when(case when(s.SftEndTime < convert(time," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec)) then(FORMAT((convert(datetime," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec) - convert(varchar(8), s.SftEndTime, 114)), 'HH:mm:ss')) else '00:00:00' end) > '02:00:00' then 1 else 0 end as exOT from v_tblAttendanceRecord as a inner join HRD_Shift as s on a.SftId = s.SftId)" +
                    sql= " with s as( select SftId, SftStartTime as SftStartTime1 , convert(time(7), dateadd(hour, 9, '2019-01-01 ' + convert(varchar(8), SftStartTime))) as SftEndTime1  from HRD_Shift)," +
                        " att as(SELECT a.*,case when InTime<>'00:00:00' then case when InTime<DATEADD(MINUTE,-30,s.SftStartTime1) then convert(varchar(6), DATEADD(MINUTE, -30, s.SftStartTime1))+case when LEN(InSec)=1 then '0'+InSec else InSec end else case when LEN(InHour)=1 then '0'+InHour else InHour end + ':' + case when LEN(InMin)=1 then '0'+InMin else InMin end + ':' + case when LEN(InSec)=1 then '0'+InSec else InSec end end else '00:00:00' end as InTimeA,SftEndTime1,  OutHour+':'+OutMin+':'+OutSec  as Out,SUBSTRING( OutHour+':'+OutMin+':'+OutSec,5,4) OutTemp," +
                        " case when (s.SftEndTime1< convert(time,OutHour+':'+OutMin+':'+OutSec) or OverTime<>'00:00:00') then CONVERT(time(0), DATEADD(SECOND, DATEDIFF(SECOND, '2018/01/01 '+convert(varchar(8), s.SftEndTime1, 114), '2018/01/01 '+OutHour+':'+OutMin+':'+OutSec), 0))else '00:00:00' end as ActualOverTime,case when(case when (s.SftEndTime1< convert(time,OutHour+':'+OutMin+':'+OutSec) or OverTime<>'00:00:00') " +
                        " then CONVERT(time(0), DATEADD(SECOND, DATEDIFF(SECOND, '2018/01/01 '+convert(varchar(8), s.SftEndTime1, 114), '2018/01/01 '+OutHour+':'+OutMin+':'+OutSec), 0))else '00:00:00' end) > '02:00:00' then 1 else 0 end as exOT from v_tblAttendanceRecord1 as a inner join s on a.SftId = s.SftId ) " +
                        " Select EmpId, SubString(EmpCardNo,8,15)+' ( '+EmpProximityNo+' )' as EmpCardNo,EmpName,SftName,format(ATTDate, 'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,case when LEN(convert(varchar(2),InTimeA))=1 then '0'+convert(varchar(2),InTimeA) else convert(varchar(2),InTimeA) end as InHour,case when LEN(SUBSTRING(InTimeA,4,2))=1 then '0'+SUBSTRING(InTimeA,4,2) else SUBSTRING(InTimeA,4,2) end as InMin,case when LEN(InSec)=1 then '0'+InSec else InSec end as  InSec, OutHour,OutMin,ATTStatus,OverTime,DptId," +
                        " StateStatus,Convert(varchar(11), EmpJoiningDate, 105) as EmpJoiningDate,GrdName,EmpType,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime, case when exOT = '1' then '02:0' + OutTemp else ActualOverTime end as TotalOverTime,TotalDays,OtherOverTime,case when exOT = '1' then format(convert(datetime,'02:0' + OutTemp)+convert(varchar(8), SftEndTime1, 114),'HH:mm:ss') else Out end as OutTime, " +
                        " case when OutHour+':'+OutMin+':'+OutSec<>'00:00:00' then  CONVERT(time(0), DATEADD(SECOND, DATEDIFF(SECOND, '2018/01/01 '+InTimeA, '2018/01/01 '+case when exOT = '1' then format(convert(datetime,'02:0' + OutTemp)+convert(varchar(8), SftEndTime1, 114),'HH:mm:ss') else Out end), 0)) else '00:00:00' end as StayTime" +
                        " From att" +
                        " Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "'  "+ unitCondition + " order by  ATTDate";
                else
                    //sql = "with" +
                    //      " att as (SELECT a.*, s.SftStartTime,s.SftEndTime," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end as OutHour1 ," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec as Out,SUBSTRING(OutHour + ':' + OutMin + ':' + OutSec, 5, 4) OutTemp, case when(s.SftEndTime < convert(time," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec)) then(FORMAT((convert(datetime," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec) - convert(varchar(8), s.SftEndTime, 114)), 'HH:mm:ss')) else '00:00:00' end as ActualOverTime,  case when(case when(s.SftEndTime < convert(time," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec)) then(FORMAT((convert(datetime," +
                    //      " case when(OtherOverTime <> '00:00:00.0000000' and OutHour = '00') then '23' else OutHour end" +
                    //      " + ':' + OutMin + ':' + OutSec) - convert(varchar(8), s.SftEndTime, 114)), 'HH:mm:ss')) else '00:00:00' end) > '02:00:00' then 1 else 0 end as exOT from v_tblAttendanceRecord as a inner join HRD_Shift as s on a.SftId = s.SftId)" +

                    sql = " with s as(select SftId, SftStartTime as SftStartTime1 , convert(time(7), dateadd(hour, 9, '2019-01-01 ' + convert(varchar(8), SftStartTime))) as SftEndTime1  from HRD_Shift)," +
                        " att as(SELECT a.*,case when InTime<>'00:00:00' then case when InTime<DATEADD(MINUTE,-30,s.SftStartTime1) then convert(varchar(6), DATEADD(MINUTE, -30, s.SftStartTime1))+case when LEN(InSec)=1 then '0'+InSec else InSec end else case when LEN(InHour)=1 then '0'+InHour else InHour end + ':' + case when LEN(InMin)=1 then '0'+InMin else InMin end + ':' + case when LEN(InSec)=1 then '0'+InSec else InSec end end else '00:00:00' end as InTimeA,SftEndTime1, OutHour+':'+OutMin+':'+OutSec  as Out,SUBSTRING( OutHour+':'+OutMin+':'+OutSec,5,4) OutTemp,case when (s.SftEndTime1< convert(time,OutHour+':'+OutMin+':'+OutSec) or OverTime<>'00:00:00') then CONVERT(time(0), DATEADD(SECOND, DATEDIFF(SECOND, '2018/01/01 '+convert(varchar(8), s.SftEndTime1, 114), '2018/01/01 '+OutHour+':'+OutMin+':'+OutSec), 0))else '00:00:00' end as ActualOverTime,case when(case when (s.SftEndTime1< convert(time,OutHour+':'+OutMin+':'+OutSec) or OverTime<>'00:00:00') then CONVERT(time(0), DATEADD(SECOND, DATEDIFF(SECOND, '2018/01/01 '+convert(varchar(8), s.SftEndTime1, 114), '2018/01/01 '+OutHour+':'+OutMin+':'+OutSec), 0))else '00:00:00' end) > '02:00:00' then 1 else 0 end as exOT from v_tblAttendanceRecord1 as a inner join s on a.SftId = s.SftId ) " +
                        " Select EmpId, SubString(EmpCardNo,8,15)+' ( '+EmpProximityNo+' )' as EmpCardNo,EmpName,SftName,format(ATTDate, 'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,case when LEN(convert(varchar(2),InTimeA))=1 then '0'+convert(varchar(2),InTimeA) else convert(varchar(2),InTimeA) end as InHour,case when LEN(SUBSTRING(InTimeA,4,2))=1 then '0'+SUBSTRING(InTimeA,4,2) else SUBSTRING(InTimeA,4,2) end as InMin,case when LEN(InSec)=1 then '0'+InSec else InSec end as  InSec,OutHour,OutMin,ATTStatus,OverTime,DptId," +
                        " StateStatus,Convert(varchar(11), EmpJoiningDate, 105) as EmpJoiningDate,GrdName,EmpType,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime, case when exOT = '1' then '02:0' + OutTemp else ActualOverTime end as TotalOverTime,TotalDays,OtherOverTime,case when exOT = '1' then format(convert(datetime,'02:0' + OutTemp)+convert(varchar(8), SftEndTime1, 114),'HH:mm:ss') else Out end as OutTime, " +
                        " case when OutHour+':'+OutMin+':'+OutSec<>'00:00:00' then  CONVERT(time(0), DATEADD(SECOND, DATEDIFF(SECOND, '2018/01/01 '+InTimeA, '2018/01/01 '+case when exOT = '1' then format(convert(datetime,'02:0' + OutTemp)+convert(varchar(8), SftEndTime1, 114),'HH:mm:ss') else Out end), 0)) else '00:00:00' end as StayTime" +
                        " From att" +
                        " Where CompanyId='" + ddlCompanyName.SelectedValue + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + EmpTypeID + " "+ unitCondition + " Order By convert(int,DptId), CustomOrdering,Empid, ATTDate";
              
                
                //    sqlDB.fillDataTable("Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, StayTime )-convert(varchar(8),OtherOverTime,114)),'hh:mm:ss') ) else   StayTime end as StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime as TotalOverTime,TotalDays,OtherOverTime,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, OutHour+':'+OutMin+':'+OutSec )-convert(varchar(8),OtherOverTime,114)) +convert(datetime,'00:00:'+OutSec ),'HH:mm:ss')) else   OutHour+':'+OutMin+':'+OutSec end as OutTime From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' Group By EmpId,EmpCardNo,EmpName,SftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime,TotalDays,OtherOverTime order by  ATTDate  ", dt);
                //else sqlDB.fillDataTable("Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, StayTime )-convert(varchar(8),OtherOverTime,114)),'hh:mm:ss') ) else   StayTime end as StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime as TotalOverTime,TotalDays,OtherOverTime,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, OutHour+':'+OutMin+':'+OutSec )-convert(varchar(8),OtherOverTime,114))+convert(datetime,'00:00:'+OutSec ),'HH:mm:ss') ) else   OutHour+':'+OutMin+':'+OutSec end as OutTime From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + EmpTypeID + " Group By EmpId,EmpCardNo,EmpName,SftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime,TotalDays,GId,CustomOrdering ,OtherOverTime Order By convert(int,DptId), CustomOrdering,Empid, ATTDate   ", dt);
                sqlDB.fillDataTable(sql, dt);

                
                Session["__dtJobCard__"] = dt;

                if (dt.Rows.Count > 0)
                {
                    DataTable dtSummary = new DataTable();
                    //if (rblGenerateType.SelectedValue == "1") sqlDB.fillDataTable("Select EmpId,SUM(CASE WHEN StateStatus = 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN StateStatus = 'C/L' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN StateStatus = 'S/L' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN StateStatus = 'M/L' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN StateStatus = 'E/L' THEN 1 ELSE 0 END) AS 'EL',SUM(CASE WHEN StateStatus = 'Holiday' THEN 1 ELSE 0 END) AS 'Holiday',SUM(CASE WHEN StateStatus = 'Present' THEN 1 ELSE 0 END) AS 'Present',SUM(CASE WHEN StateStatus = 'Weekend' THEN 1 ELSE 0 END) AS 'Weekend',Sum(PaybleDays) AS 'APday' From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' group by EmpId", dtSummary);
                    //else sqlDB.fillDataTable("Select EmpId,SUM(CASE WHEN StateStatus = 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN StateStatus = 'C/L' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN StateStatus = 'S/L' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN StateStatus = 'M/L' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN StateStatus = 'E/L' THEN 1 ELSE 0 END) AS 'EL',SUM(CASE WHEN StateStatus = 'Holiday' THEN 1 ELSE 0 END) AS 'Holiday',SUM(CASE WHEN StateStatus = 'Present' THEN 1 ELSE 0 END) AS 'Present',SUM(CASE WHEN StateStatus = 'Weekend' THEN 1 ELSE 0 END) AS 'Weekend',Sum(PaybleDays) AS 'APday' From  v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' " + EmpTypeID + " and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " group by EmpId", dtSummary);

                   if (rblGenerateType.SelectedValue == "1") sqlDB.fillDataTable("Select EmpId,SUM(CASE WHEN StateStatus= 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN StateStatus = 'Casual Leave' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN StateStatus = 'Sick Leave' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN StateStatus = 'Maternity Leave' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN StateStatus = 'Annual Leave' THEN 1 ELSE 0 END) AS 'EL',SUM(CASE WHEN StateStatus = 'Holiday' THEN 1 ELSE 0 END) AS 'Holiday',SUM(CASE WHEN StateStatus= 'Present' THEN 1 ELSE 0 END) AS 'Present',SUM(CASE WHEN StateStatus = 'Weekend' THEN 1 ELSE 0 END) AS 'Weekend',Sum( CASE WHEN StateStatus= 'Present' then 1 else 0 end ) AS 'APday' From v_tblAttendanceRecord1 Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' group by EmpId", dtSummary);
                    else sqlDB.fillDataTable("Select EmpId,SUM(CASE WHEN StateStatus= 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN StateStatus = 'Casual Leave' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN StateStatus = 'Sick Leave' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN StateStatus = 'Maternity Leave' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN StateStatus = 'Annual Leave' THEN 1 ELSE 0 END) AS 'EL',SUM(CASE WHEN StateStatus = 'Holiday' THEN 1 ELSE 0 END) AS 'Holiday',SUM(CASE WHEN StateStatus= 'Present' THEN 1 ELSE 0 END) AS 'Present',SUM(CASE WHEN StateStatus = 'Weekend' THEN 1 ELSE 0 END) AS 'Weekend',Sum( CASE WHEN StateStatus= 'Present' then 1 else 0 end ) AS 'APday' From  v_tblAttendanceRecord1 Where CompanyId='" + ddlCompanyName.SelectedValue + "' " + EmpTypeID + " and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " group by EmpId", dtSummary);
                    Session["__dtSummary__"] = dtSummary;
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=JobCardReport');", true);  //Open New Tab for Sever side code         
                }
                else
                {
                    lblMessage.InnerText = "warning->No Attendance Available";
                }
            }
            catch { }
        }



        private void _GenerateJobCardReportForActualAndCompliance()  //for complaince
        {


            try
            {

                string EmpTypeID = (rblEmpType.SelectedValue == "All") ? "" : " and EmpTypeId= " + rblEmpType.SelectedValue + "";
                string DepartmentList = "";
                if (rblGenerateType.SelectedValue == "0")
                    DepartmentList = classes.commonTask.getDepartmentList(lstSelected);

                string unitCondition = "";
                if (ddlUnit.SelectedValue != "0")
                {
                    unitCondition = " and UnitId=" + ddlUnit.SelectedValue;
                }
                string ShiftName = "";
                if (ddlPermanentShift.SelectedValue != "0")
                {
                    ShiftName += " and PSftId='" + ddlPermanentShift.SelectedValue + "' ";
                }

                string[] Month = ddlMonthList.SelectedValue.Split('-');
                string sql = "";
                DataTable dt = new DataTable();

                if (rblGenerateType.SelectedValue == "1")
                    sql = @"DECLARE @maxOT VARCHAR(8) = '02:00:00'
DECLARE @maxStayTime VARCHAR(8) = '09:00:00' --for delivery(0043),Admin

;WITH h AS
(
    SELECT CompanyId, HDate, 'H' AS AttStatus, 'Holiday' AS StateStatus
    FROM dbo.tblHolydayWork
)
SELECT 
 TotalOverTime AS actualTotalOverTime, 
    CASE 
        WHEN v.ATTStatus = 'W' OR v.ATTStatus = 'H' 
            THEN '00:00:00' 
        ELSE 
            CASE 
                WHEN TotalOverTime > @maxOT 
                    THEN '02:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec 
                ELSE TotalOverTime 
            END 
    END AS TotalOverTime,
	CASE WHEN h.HDate IS NOT NULL THEN h.StateStatus else  Case when Isnull(IsWeekend,0)=1 then 'Weekend' else v.StateStatus end end  AS  StateStatus,


	CASE WHEN h.HDate IS NOT NULL or Isnull(IsWeekend,0)=1 THEN '0'  else v.PaybleDays  end  AS  PaybleDays,

    CASE 
        WHEN v.DptId IN('0043','0075') AND StayTime > @maxStayTime 
            THEN CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, 0, '09:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec), '2022-01-01 ' + InHour + ':' + InMin + ':' + InSec))
        ELSE 
            CASE 
                WHEN TotalOverTime > @maxOT 
                    THEN CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, '02:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec, '00:00:00'), TotalOverTime)), '00:00:00'), OutHour + ':' + OutMin + ':' + OutSec)) 
                ELSE OutHour + ':' + OutMin + ':' + OutSec 
            END 
    END AS OutTime,

    OutHour,OutMin,OutSec,

    CASE 
        WHEN v.DptId IN('0043','0075') AND StayTime > @maxStayTime 
            THEN '09:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec 
        ELSE 
            CASE 
                WHEN TotalOverTime > @maxOT 
                    THEN CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, '02:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec, '00:00:00'), TotalOverTime)), '00:00:00'), StayTime)) 
                ELSE StayTime 
            END 
    END AS StayTime,
	
    StayTime AS actualStayTime,
    InHour,InMin,InSec,EmpId,
    SUBSTRING(EmpCardNo,8,15)+' ( '+EmpProximityNo+' )' AS EmpCardNo,
    EmpName,SftName,PSftName AS MobileNo,
    FORMAT(ATTDate,'dd-MM-yyyy') AS ATTDate,
    v.DptName,v.DsgName,MonthName,InHour,InMin,OutHour,OutMin,
   Case When h.HDate is not null then h.AttStatus else case  when isnull(v.IsWeekend,0)=1 then 'W' else  
    CASE WHEN  ODID > 0 THEN v.ATTStatus+'(OD)' ELSE v.ATTStatus END end end  AS ATTStatus,
    StayTime,OverTime,v.DptId,
    CONVERT(VARCHAR(11),EmpJoiningDate,105) AS EmpJoiningDate,
    GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,
    CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,
    TotalDays,PaybleDays as PaybleDaysRegular
FROM v_tblAttendanceRecord v
LEFT JOIN h ON h.CompanyId = v.CompanyId AND h.HDate = v.ATTDate
WHERE v.CompanyId='" + ddlCompanyName.SelectedValue + "' and v.EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' " + unitCondition + " order by  ATTDate";


                else
                    sql = @"DECLARE @maxOT VARCHAR(8) = '02:00:00'
DECLARE @maxStayTime VARCHAR(8) = '09:00:00' --for delivery(0043),Admin

;WITH h AS
(
    SELECT CompanyId, HDate, 'H' AS AttStatus, 'Holiday' AS StateStatus
    FROM dbo.tblHolydayWork
)
SELECT 
 TotalOverTime AS actualTotalOverTime, 
    CASE 
        WHEN v.ATTStatus = 'W' OR v.ATTStatus = 'H' 
            THEN '00:00:00' 
        ELSE 
            CASE 
                WHEN TotalOverTime > @maxOT 
                    THEN '02:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec 
                ELSE TotalOverTime 
            END 
    END AS TotalOverTime,
	CASE WHEN h.HDate IS NOT NULL THEN h.StateStatus else  Case when Isnull(IsWeekend,0)=1 then 'Weekend' else v.StateStatus end end  AS  StateStatus,


	CASE WHEN h.HDate IS NOT NULL or Isnull(IsWeekend,0)=1 THEN '0'  else v.PaybleDays  end  AS  PaybleDays,

    CASE 
        WHEN v.DptId IN('0043','0075') AND StayTime > @maxStayTime 
            THEN CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, 0, '09:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec), '2022-01-01 ' + InHour + ':' + InMin + ':' + InSec))
        ELSE 
            CASE 
                WHEN TotalOverTime > @maxOT 
                    THEN CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, '02:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec, '00:00:00'), TotalOverTime)), '00:00:00'), OutHour + ':' + OutMin + ':' + OutSec)) 
                ELSE OutHour + ':' + OutMin + ':' + OutSec 
            END 
    END AS OutTime,

    OutHour,OutMin,OutSec,

    CASE 
        WHEN v.DptId IN('0043','0075') AND StayTime > @maxStayTime 
            THEN '09:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec 
        ELSE 
            CASE 
                WHEN TotalOverTime > @maxOT 
                    THEN CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, '02:0' + SUBSTRING(OutMin,2,1) + ':' + OutSec, '00:00:00'), TotalOverTime)), '00:00:00'), StayTime)) 
                ELSE StayTime 
            END 
    END AS StayTime,
	
    StayTime AS actualStayTime,
    InHour,InMin,InSec,EmpId,
    SUBSTRING(EmpCardNo,8,15)+' ( '+EmpProximityNo+' )' AS EmpCardNo,
    EmpName,SftName,PSftName AS MobileNo,
    FORMAT(ATTDate,'dd-MM-yyyy') AS ATTDate,
    v.DptName,v.DsgName,MonthName,InHour,InMin,OutHour,OutMin,
    Case When h.HDate is not null then h.AttStatus else case  when isnull(v.IsWeekend,0)=1 then 'W' else  
    CASE WHEN  ODID > 0 THEN v.ATTStatus+'(OD)' ELSE v.ATTStatus END end end  AS ATTStatus,
    StayTime,OverTime,v.DptId,
    CONVERT(VARCHAR(11),EmpJoiningDate,105) AS EmpJoiningDate,
    GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,
    CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,
    TotalDays,PaybleDays as PaybleDaysRegular
FROM v_tblAttendanceRecord v
LEFT JOIN h ON h.CompanyId = v.CompanyId AND h.HDate = v.ATTDate
WHERE v.CompanyId='" + ddlCompanyName.SelectedValue + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + EmpTypeID + " " + unitCondition + " " + ShiftName + " Order By convert(int,DptId), CustomOrdering,Empid, ATTDate";
                //    sqlDB.fillDataTable("Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, StayTime )-convert(varchar(8),OtherOverTime,114)),'hh:mm:ss') ) else   StayTime end as StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime as TotalOverTime,TotalDays,OtherOverTime,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, OutHour+':'+OutMin+':'+OutSec )-convert(varchar(8),OtherOverTime,114)) +convert(datetime,'00:00:'+OutSec ),'HH:mm:ss')) else   OutHour+':'+OutMin+':'+OutSec end as OutTime From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' Group By EmpId,EmpCardNo,EmpName,SftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime,TotalDays,OtherOverTime order by  ATTDate  ", dt);
                //else sqlDB.fillDataTable("Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, StayTime )-convert(varchar(8),OtherOverTime,114)),'hh:mm:ss') ) else   StayTime end as StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime as TotalOverTime,TotalDays,OtherOverTime,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, OutHour+':'+OutMin+':'+OutSec )-convert(varchar(8),OtherOverTime,114))+convert(datetime,'00:00:'+OutSec ),'HH:mm:ss') ) else   OutHour+':'+OutMin+':'+OutSec end as OutTime From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + EmpTypeID + " Group By EmpId,EmpCardNo,EmpName,SftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime,TotalDays,GId,CustomOrdering ,OtherOverTime Order By convert(int,DptId), CustomOrdering,Empid, ATTDate   ", dt);
                sqlDB.fillDataTable(sql, dt);
                Session["__dtJobCard__"] = dt;
                if (dt.Rows.Count > 0)
                {
                    DataTable dtSummary = new DataTable();
                    if (rblGenerateType.SelectedValue == "1")
                        sql = @"WITH h AS(
    SELECT CompanyId, HDate, 'H' AS AttStatus, 'Holiday' AS StateStatus
    FROM dbo.tblHolydayWork
)
Select EmpId, SUM(CASE WHEN h.HDate is null and v.StateStatus = 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN v.StateStatus = 'Casual Leave' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN v.StateStatus = 'Sick Leave' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN v.StateStatus = 'Maternity Leave' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN v.StateStatus = 'Annual Leave' THEN 1 ELSE 0 END) AS 'EL',

 SUM(CASE WHEN h.HDate IS NOT NULL THEN 1  ELSE 0 END) AS Holiday,
 SUM(CASE WHEN h.HDate IS NULL AND ISNULL(v.IsWeekend, 0) = 0 AND v.StateStatus = 'Present' THEN 1  ELSE 0 END) AS Present,

  SUM(CASE WHEN h.HDate IS NULL AND(ISNULL(v.IsWeekend, 0) = 1 or v.StateStatus = 'Weekend')THEN 1  ELSE 0  END ) AS Weekend,

 SUM(CASE WHEN h.HDate IS NOT NULL OR ISNULL(v.IsWeekend, 0) = 1 THEN 0  ELSE v.PaybleDays  END) AS APday

From v_tblAttendanceRecord as v left outer join h on v.ATTDate = h.HDate Where v.CompanyId ='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' " + unitCondition + " group by EmpId";



                    else
                        sql = @"WITH h AS
(
    SELECT CompanyId, HDate, 'H' AS AttStatus, 'Holiday' AS StateStatus
    FROM dbo.tblHolydayWork
)
Select EmpId, SUM(CASE WHEN h.HDate is null and  v.StateStatus = 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN v.StateStatus = 'Casual Leave' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN v.StateStatus = 'Sick Leave' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN v.StateStatus = 'Maternity Leave' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN v.StateStatus = 'Annual Leave' THEN 1 ELSE 0 END) AS 'EL',

 SUM(CASE WHEN h.HDate IS NOT NULL THEN 1  ELSE 0 END) AS Holiday,
 SUM(CASE WHEN h.HDate IS NULL AND ISNULL(v.IsWeekend, 0) = 0 AND v.StateStatus = 'Present' THEN 1  ELSE 0 END) AS Present,

  SUM(CASE WHEN h.HDate IS NULL AND(ISNULL(v.IsWeekend, 0) = 1 or v.StateStatus = 'Weekend')THEN 1  ELSE 0  END ) AS Weekend,

 SUM(CASE WHEN h.HDate IS NOT NULL OR ISNULL(v.IsWeekend, 0) = 1 THEN 0  ELSE v.PaybleDays  END) AS APday

From v_tblAttendanceRecord as v left outer join h on v.ATTDate = h.HDate Where v.CompanyId ='" + ddlCompanyName.SelectedValue + "' " + EmpTypeID + " and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + unitCondition + " " + ShiftName + " group by EmpId";
                    sqlDB.fillDataTable(sql, dtSummary);
                    Session["__dtSummary__"] = dtSummary;
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=JobCardReportNew');", true);  //Open New Tab for Sever side code         
                }
                else
                {
                    lblMessage.InnerText = "warning->No Attendance Available";
                }
            }
            catch { }
        }


        private void GenerateJobCardReportForActualAndCompliance()
        {


            try
            {

                string EmpTypeID = (rblEmpType.SelectedValue == "All") ? "" : " and EmpTypeId= " + rblEmpType.SelectedValue + "";
                string DepartmentList = "";
                if (rblGenerateType.SelectedValue == "0")
                    DepartmentList = classes.commonTask.getDepartmentList(lstSelected);

                string unitCondition = "";
                if (ddlUnit.SelectedValue != "0")
                {
                    unitCondition = " and UnitId=" + ddlUnit.SelectedValue;
                }
                string ShiftName = "";
                if (ddlPermanentShift.SelectedValue != "0")
                {
                    ShiftName += " and PSftId='" + ddlPermanentShift.SelectedValue + "' ";
                }

                string[] Month = ddlMonthList.SelectedValue.Split('-');
                string sql = "";
                DataTable dt = new DataTable();

                if (rblGenerateType.SelectedValue == "1")
                    sql = @"DECLARE @maxOT VARCHAR(8) = '02:00:00'
DECLARE @maxStayTime VARCHAR(8) = '09:00:00' --for delivery(0043),Admin
                           select TotalOverTime as actualTotalOverTime, case when ATTStatus='W' or ATTStatus='H' then '00:00:00' else case when TotalOverTime>@maxOT then  '02:0'+SUBSTRING(OutMin,2,1)+':'+OutSec else TotalOverTime end end as TotalOverTime,
						  case when DptId in('0043','0075') and StayTime>@maxStayTime then
						 CONVERT(TIME,  DATEADD(SECOND, DATEDIFF(SECOND, 0, '09:0'+SUBSTRING(OutMin,2,1)+':'+OutSec), '2022-01-01 '+InHour+':'+InMin+':'+InSec))
						   else 
                         case when TotalOverTime>@maxOT then CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, '02:0'+SUBSTRING(OutMin,2,1)+':'+OutSec, '00:00:00'),TotalOverTime)), '00:00:00'),OutHour+':'+OutMin+':'+OutSec)) else OutHour+':'+OutMin+':'+OutSec end End as OutTime
						 ,
                         OutHour,OutMin,OutSec,
						 case when DptId in('0043','0075') and StayTime>@maxStayTime then '09:0'+SUBSTRING(OutMin,2,1)+':'+OutSec else 
						 case when TotalOverTime>@maxOT then CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, '02:0'+SUBSTRING(OutMin,2,1)+':'+OutSec, '00:00:00'),TotalOverTime)), '00:00:00'),StayTime)) else StayTime end end as StayTime			 
						 ,
                        StayTime as actualStayTime,InHour,InMin,InSec,EmpId,SubString(EmpCardNo,8,15)+' ( '+EmpProximityNo+' )' as EmpCardNo,EmpName,SftName ,PSftName as MobileNo,
                        format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,case when ODID >0 then ATTStatus+'(OD)' else ATTStatus end as ATTStatus,
                        StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,
                        GName,MonthId,BreakStartTime,BreakEndTime,TotalDays,PaybleDays From v_tblAttendanceRecord 
                        Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' "+ unitCondition + " " + ShiftName + " order by  ATTDate";
                else
                    sql = @"DECLARE @maxOT VARCHAR(8) = '02:00:00'
DECLARE @maxStayTime VARCHAR(8) = '09:00:00' --for delivery(0043),Admin
                           select TotalOverTime as actualTotalOverTime, case when ATTStatus='W' or ATTStatus='H' then '00:00:00' else case when TotalOverTime>@maxOT then  '02:0'+SUBSTRING(OutMin,2,1)+':'+OutSec else TotalOverTime end end as TotalOverTime,
						  case when DptId in('0043','0075') and StayTime>@maxStayTime then
						 CONVERT(TIME,  DATEADD(SECOND, DATEDIFF(SECOND, 0, '09:0'+SUBSTRING(OutMin,2,1)+':'+OutSec), '2022-01-01 '+InHour+':'+InMin+':'+InSec))
						   else 
                         case when TotalOverTime>@maxOT then CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, '02:0'+SUBSTRING(OutMin,2,1)+':'+OutSec, '00:00:00'),TotalOverTime)), '00:00:00'),OutHour+':'+OutMin+':'+OutSec)) else OutHour+':'+OutMin+':'+OutSec end End as OutTime
						 ,
                         OutHour,OutMin,OutSec,
						 case when DptId in('0043','0075') and StayTime>@maxStayTime then '09:0'+SUBSTRING(OutMin,2,1)+':'+OutSec else 
						 case when TotalOverTime>@maxOT then CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, '02:0'+SUBSTRING(OutMin,2,1)+':'+OutSec, '00:00:00'),TotalOverTime)), '00:00:00'),StayTime)) else StayTime end end as StayTime			 
						 ,
                        StayTime as actualStayTime,InHour,InMin,InSec,EmpId,SubString(EmpCardNo,8,15)+' ( '+EmpProximityNo+' )' as EmpCardNo,EmpName,SftName,PSftName as MobileNo,
                        format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,case when ODID >0 then ATTStatus+'(OD)' else ATTStatus end as ATTStatus,
                        StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,
                        GName,MonthId,BreakStartTime,BreakEndTime,TotalDays,PaybleDays From v_tblAttendanceRecord  Where CompanyId='" + ddlCompanyName.SelectedValue + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + EmpTypeID + " "+ unitCondition + " " + ShiftName + " Order By convert(int,DptId), CustomOrdering,Empid, ATTDate";
                //    sqlDB.fillDataTable("Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, StayTime )-convert(varchar(8),OtherOverTime,114)),'hh:mm:ss') ) else   StayTime end as StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime as TotalOverTime,TotalDays,OtherOverTime,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, OutHour+':'+OutMin+':'+OutSec )-convert(varchar(8),OtherOverTime,114)) +convert(datetime,'00:00:'+OutSec ),'HH:mm:ss')) else   OutHour+':'+OutMin+':'+OutSec end as OutTime From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' Group By EmpId,EmpCardNo,EmpName,SftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime,TotalDays,OtherOverTime order by  ATTDate  ", dt);
                //else sqlDB.fillDataTable("Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, StayTime )-convert(varchar(8),OtherOverTime,114)),'hh:mm:ss') ) else   StayTime end as StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime as TotalOverTime,TotalDays,OtherOverTime,case when (OtherOverTime<>'00:00:00') then ( FORMAT(( convert(datetime, OutHour+':'+OutMin+':'+OutSec )-convert(varchar(8),OtherOverTime,114))+convert(datetime,'00:00:'+OutSec ),'HH:mm:ss') ) else   OutHour+':'+OutMin+':'+OutSec end as OutTime From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + EmpTypeID + " Group By EmpId,EmpCardNo,EmpName,SftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime,TotalDays,GId,CustomOrdering ,OtherOverTime Order By convert(int,DptId), CustomOrdering,Empid, ATTDate   ", dt);
                sqlDB.fillDataTable(sql, dt);

                //dt.Columns["ATTStatus"].ReadOnly = false;
                //foreach (DataRow row in dt.Rows)
                //{
                   
                //    if (row["ATTStatus"].ToString() == "H" || row["ATTStatus"].ToString() == "W")
                //    {
                //        DateTime currentDate = DateTime.ParseExact(row["ATTDate"].ToString(), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                //        string empId = row["EmpId"].ToString();

                //        // look backward
                //        DateTime backDate = currentDate.AddDays(-1);
                //        string backStatus = null;
                //        while (true)
                //        {
                //            DataRow[] prev = dt.Select($"EmpId = '{empId}' AND ATTDate = '{backDate:dd-MM-yyyy}'");
                //            if (prev.Length == 0) break;
                //            backStatus = prev[0]["ATTStatus"].ToString();
                //            if (backStatus != "H" && backStatus != "W") break; // stop when non-H/W found
                //            backDate = backDate.AddDays(-1);
                //        }

                //        // look forward
                //        DateTime nextDate = currentDate.AddDays(1);
                //        string forwardStatus = null;
                //        while (true)
                //        {
                //            DataRow[] next = dt.Select($"EmpId = '{empId}' AND ATTDate = '{nextDate:dd-MM-yyyy}'");
                //            if (next.Length == 0) break;
                //            forwardStatus = next[0]["ATTStatus"].ToString();
                //            if (forwardStatus != "H" && forwardStatus != "W") break;
                //            nextDate = nextDate.AddDays(1);
                //        }

                //        // condition: both sides are "A"
                //        if (backStatus == "A" && forwardStatus == "A")
                //        {
                //            row["ATTStatus"] = "A";
                //        }
                //    }
                //}




                DataTable summaryTable = new DataTable();
                summaryTable.Columns.Add("EmpId", typeof(string));
                summaryTable.Columns.Add("Absent", typeof(int));
                summaryTable.Columns.Add("CL", typeof(int));
                summaryTable.Columns.Add("SL", typeof(int));
                summaryTable.Columns.Add("ML", typeof(int));
                summaryTable.Columns.Add("EL", typeof(int));
                summaryTable.Columns.Add("Holiday", typeof(int));
                summaryTable.Columns.Add("Present", typeof(int));
                summaryTable.Columns.Add("Weekend", typeof(int));
                summaryTable.Columns.Add("APday", typeof(int));

                var empIds = dt.AsEnumerable()
                    .Select(r => r["EmpId"].ToString())
                    .Distinct();

                foreach (var empId in empIds)
                {
                    var empRows = dt.AsEnumerable().Where(r => r["EmpId"].ToString() == empId);

                    DataRow newRow = summaryTable.NewRow();
                    newRow["EmpId"] = empId;
                    newRow["Absent"] = empRows.Count(r => r["StateStatus"].ToString() == "Absent");
                    newRow["CL"] = empRows.Count(r => r["StateStatus"].ToString() == "Casual Leave");
                    newRow["SL"] = empRows.Count(r => r["StateStatus"].ToString() == "Sick Leave");
                    newRow["ML"] = empRows.Count(r => r["StateStatus"].ToString() == "Maternity Leave");
                    newRow["EL"] = empRows.Count(r => r["StateStatus"].ToString() == "Annual Leave");
                    newRow["Holiday"] = empRows.Count(r => r["StateStatus"].ToString() == "Holiday");
                    newRow["Present"] = empRows.Count(r => r["StateStatus"].ToString() == "Present");
                    newRow["Weekend"] = empRows.Count(r => r["StateStatus"].ToString() == "Weekend");
                    newRow["APday"] = empRows.Sum(r => Convert.ToInt32(r["PaybleDays"]));

                    summaryTable.Rows.Add(newRow);

                }
                string mskjfklds = "Hello World";


                Session["__dtJobCard__"] = dt;
                Session["__dtSummary__"] = summaryTable;
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=JobCardReportNew');", true);
                 return;
                if (dt.Rows.Count > 0)
                {
                    DataTable dtSummary = new DataTable();
                    if (rblGenerateType.SelectedValue == "1")
                        sql = "Select EmpId,SUM(CASE WHEN StateStatus = 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN StateStatus = 'Casual Leave' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN StateStatus = 'Sick Leave' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN StateStatus = 'Maternity Leave' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN StateStatus = 'Annual Leave' THEN 1 ELSE 0 END) AS 'EL',SUM(CASE WHEN StateStatus = 'Holiday' THEN 1 ELSE 0 END) AS 'Holiday',SUM(CASE WHEN StateStatus = 'Present' THEN 1 ELSE 0 END) AS 'Present',SUM(CASE WHEN StateStatus = 'Weekend' THEN 1 ELSE 0 END) AS 'Weekend',Sum(PaybleDays) AS 'APday' From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' "+unitCondition+" group by EmpId";
                    else
                        sql = "Select EmpId,SUM(CASE WHEN StateStatus = 'Absent' THEN 1 ELSE 0 END) AS 'Absent',SUM(CASE WHEN StateStatus = 'Casual Leave' THEN 1 ELSE 0 END) AS 'CL',SUM(CASE WHEN StateStatus = 'Sick Leave' THEN 1 ELSE 0 END) AS 'SL',SUM(CASE WHEN StateStatus = 'Maternity Leave' THEN 1 ELSE 0 END) AS 'ML',SUM(CASE WHEN StateStatus = 'Annual Leave' THEN 1 ELSE 0 END) AS 'EL',SUM(CASE WHEN StateStatus = 'Holiday' THEN 1 ELSE 0 END) AS 'Holiday',SUM(CASE WHEN StateStatus = 'Present' THEN 1 ELSE 0 END) AS 'Present',SUM(CASE WHEN StateStatus = 'Weekend' THEN 1 ELSE 0 END) AS 'Weekend',Sum(PaybleDays) AS 'APday' From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' " + EmpTypeID + " and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " "+unitCondition+" "+ ShiftName + " group by EmpId";
                    sqlDB.fillDataTable(sql, dtSummary);
                    Session["__dtSummary__"] = dtSummary;
                     //Open New Tab for Sever side code         
                }
                else
                {
                    lblMessage.InnerText = "warning->No Attendance Available";
                }
            }
            catch(Exception ex) { }
        }
        private void GenerateHolidayAndWeekendReport()
        {


            try
            {

                string EmpTypeID = (rblEmpType.SelectedValue == "All") ? "" : " and EmpTypeId= " + rblEmpType.SelectedValue + "";
                string DepartmentList = "";
                if (rblGenerateType.SelectedValue == "0")
                    DepartmentList = classes.commonTask.getDepartmentList(lstSelected);

                string[] Month = ddlMonthList.SelectedValue.Split('-');


                string unitCondition = "";
                if (ddlUnit.SelectedValue != "0")
                {
                    unitCondition = " and UnitId=" + ddlUnit.SelectedValue;
                }
                string ShiftName = "";
                if (ddlPermanentShift.SelectedValue != "0")
                {
                    ShiftName += " and PSftId='" + ddlPermanentShift.SelectedValue + "' ";
                }

                string cmd = "";

                DataTable dt = new DataTable();
                if  (rblGenerateType.SelectedValue == "1")
                {
                    sqlDB.fillDataTable("Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,PSftName as MobileNo,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime, TotalOverTime,TotalDays From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and EmpCardNo Like'%" + txtCardNo.Text.Trim() + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and (ATTStatus ='W' or ATTStatus='H') " + unitCondition + " Group By EmpId,EmpCardNo,EmpName,SftName,PSftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,TotalOverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,OverTime,TotalDays order by  ATTDate  ", dt);
                }
                else
                {
                    cmd = "Select EmpId,SubString(EmpCardNo,8,15) as EmpCardNo,EmpName,SftName,PSftName as MobileNo,format(ATTDate,'dd-MM-yyyy') as ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,Convert(varchar(11),EmpJoiningDate,105) as EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,TotalOverTime,TotalDays From v_tblAttendanceRecord Where CompanyId='" + ddlCompanyName.SelectedValue + "' and MonthName='" + Month[1] + "-" + Month[0] + "' and DptId " + DepartmentList + " " + EmpTypeID + "  and (ATTStatus ='W' or ATTStatus='H') " + unitCondition + " "+ShiftName+ " Group By EmpId,EmpCardNo,EmpName,SftName,PSftName,ATTDate,DptName,DsgName,MonthName,InHour,InMin,OutHour,OutMin,ATTStatus,StayTime,OverTime,DptId,StateStatus,EmpJoiningDate,GrdName,EmpType,InSec,OutSec,LateTime,OverTimeCheck,CompanyName,Address,GName,MonthId,BreakStartTime,BreakEndTime,TotalOverTime,TotalDays,GId,CustomOrdering  Order By convert(int,DptId),CustomOrdering,Empid, ATTDate";
                    sqlDB.fillDataTable(cmd, dt);
                }
                Session["__dtWHStatus__"] = dt;
                if (dt.Rows.Count > 0)
                {                   
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=HolidayAndWeekendStatus');", true);  //Open New Tab for Sever side code         
                }
                else
                {
                    lblMessage.InnerText = "warning->No Attendance Available";
                }
            }
            catch { }
        }

        protected void ddlUnit_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        private void RegularRules()
        {
            string url = HttpContext.Current.Request.Url.ToString();
            string lastSegment = url.Split('/').Last();
            ViewState["__reportFor__"] = lastSegment;

            if (ViewState["__reportFor__"].ToString() == "jobcard")
            {
                rblReportType.SelectedValue = "5";
                trReportType.Visible = false;
                hdMenu.InnerText = "Job Card";
            }
        }
    }
}