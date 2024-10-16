﻿<%@ Page Title="Attendance" Language="C#" MasterPageFile="~/attendance_nested.master" AutoEventWireup="true" CodeBehind="attendance_default.aspx.cs" Inherits="SigmaERP.attendance_default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="row">
            <div class="col-md-12">
                <div class="ds_nagevation_bar" style="border-bottom:none;">
                     <div style="margin-top: 5px">
                           <ul>
                               <li><a href="/default.aspx">Dashboard</a></li>
                               <li> <a class="seperator" href="/hrd_default.aspx">/</a></li>
                               <li> <a href="#" class="ds_negevation_inactive Mactive">Attendance</a></li>
                           </ul>               
                     </div>
                </div>
             </div>
        </div>
    <div >
    <div class="col-lg-12">
             <div class="row ">
                 <div class="col-lg-2 ">

                 </div>
                 <div runat="server" id="divMonthSetup" class="col-lg-2 col-md-3 col-sm-6" title="Attendance Month Setup" >
                     <a class="ds_Settings_Basic_Text cardStyle"  href="/attendance/monthly_setup.aspx"> <i class="uil uil-calendar-alt iconStyle"></i><br /> Month Setup </a>
                     
                 </div>
                 <div  runat="server" id="divMonthSetupComp"  class="col-lg-2 col-md-3 col-sm-6" title="Attendance Month Setup" >
                     <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/monthly_setup1.aspx"> <i class="uil uil-calendar-alt iconStyle"></i><br /> Month Setup </a>
                     
                 </div>
                      <div runat="server" id="divAttProcessing" class=" col-lg-2 col-md-3 col-sm-6" title="Machine Data Import">
                      <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/import_data_ahg.aspx"><i class="uil uil-calendar-alt iconStyle"></i><br /> Att. Processing</a>
                 </div> 
                    <div runat="server" id="divAttProcessingNew" class=" col-lg-2 col-md-3 col-sm-6" title="Machine Data Import">
                      <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/AttendanceProcessing.aspx"><i class="uil uil-user-check iconStyle"></i><br /> Att. Processing (New)</a>
                 </div> 
                 <%--<div class="col-lg-2 col-md-3 col-sm-6" title="Daily Logout Setup" >
                     <a class="ds_attendance_Basic_Text" href="/attendance/monthly_logout_setup.aspx"> <img class="image_width_for_module" src="images/common/grade.ico" /><br /> Logout Setup</a>
                     
                 </div>
                 <div class=" col-lg-2 col-md-3 col-sm-6" title="Attendance Late Deduction">
                        <a class="ds_attendance_Basic_Text" href="/attendance/late_deduction.aspx"><img class="image_width_for_module" src="images/common/qualification.ico" /><br />Late Deduction</a>
                 </div>
                   <div class=" col-lg-2 col-md-3 col-sm-6" title="Attendance Late Deduction">
                        <a class="ds_attendance_Basic_Text" href="/attendance/employee-wise_hw_setup.aspx"><img class="image_width_for_module" src="images/common/qualification.ico" /><br />Emp Weekend</a>
                 </div>--%>
                   <div runat="server" id="divManuallyCount" class=" col-lg-2 col-md-3 col-sm-6" title="Attendance Manually Count ">
                      <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/attendance.aspx"><i class="uil uil-stopwatch iconStyle"></i><br />Manually Count</a>
                 </div>

                 <div runat="server" id="divAttendanceList" class=" col-lg-2 col-md-3 col-sm-6" title="All Attendance List">
                      <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/attendance_list.aspx"><i class="uil uil-document-layout-center iconStyle"></i><br />Attendance List</a>                    
                 </div>      
                 
                 <div class="col-lg-2">

                 </div>
             
             </div>

               <div class="row ">
                   <div class="col-lg-2 ">
                   </div>
 

                 <div runat="server" id="divAttSummary"  class=" col-lg-2 col-md-3 col-sm-6 " title="Daily Attendance Summary">
                     <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/attendance_summary.aspx"><i class="uil uil-file-bookmark-alt iconStyle"></i><br />Att Summary </a> 
                 
                 </div>

                   <div runat="server" id="divInOutReport" class=" col-lg-2 col-md-3 col-sm-6 " title="Daily In-Out Report">

                       <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/daily_movement.aspx"><i class="uil uil-signout iconStyle"></i><br />In-Out Report</a>
                   </div>
                   <div  runat="server" id="divManualReport" class=" col-lg-2 col-md-3 col-sm-6 " title="Todays Attendance Stutus">
                    <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/daily_manualAttendance_report.aspx"><i class="uil uil-file-bookmark-alt iconStyle"></i><br />Manual Report</a> 
                 </div>
                     
                    <%--<div class=" col-lg-2 col-md-3 col-sm-6 " title="Daily Early Late Out Report">
                    <a class="ds_attendance_Basic_Text" href="/attendance/early_out_late_out.aspx"><img class="image_width_for_module" src="images/common/businesstype.ico" /><br />Early In-Out</a> 
                 </div>--%>

                 <div runat="server" id="divMonthlyStatus"  class=" col-lg-2 col-md-3 col-sm-6" title="Monthly Attendance Status">
                     <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/monthly_in_out_report.aspx"><i class="uil uil-calender iconStyle"></i><br />Monthly Status</a>                
                 </div>

                   <div class="col-lg-2 ">
                   </div>
             </div>
    
               <div class="row ">
                   <div class="col-lg-2">
                   </div>
                                       
                  <div runat="server" id="divAttReportDaterange" class=" col-lg-2 col-md-3 col-sm-6 " title="Manpower Wise Attendance Report">
                     <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/att_report_daterange.aspx"><i class="uil uil-user-arrows iconStyle"></i><br />Attendance By Date Range</a>
                 </div> 
                   <div runat="server" id="divManpowerWiseAttendance" class=" col-lg-2 col-md-3 col-sm-6 " title="Manpower Wise Attendance Report">
                     <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/attendance_summary_manpower.aspx"><i class="uil uil-user-arrows iconStyle"></i><br />Manpower Wise Attendance</a>
                 </div> 
                 <div runat="server" id="divOvertimeReport" class=" col-lg-2 col-md-3 col-sm-6 " title="Overtime Report">
                     <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/overtime_report.aspx"><i class="uil uil-clock-eight iconStyle"></i><br />Overtime Report</a>
                 </div>  
                 <div runat="server" id="divOutduty" class=" col-lg-2 col-md-3 col-sm-6 " title="Manpower Wise Attendance Report">
                     <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/out_duty_app.aspx"><i class="uil uil-signout iconStyle"></i><br />Outduty</a>
                 </div>
                   <div runat="server" id="divOutdutyList" class=" col-lg-2 col-md-3 col-sm-6 " title="Manpower Wise Attendance Report">
                     <a class="ds_Settings_Basic_Text cardStyle" href="/attendance/out_duty_list.aspx"><i class="uil uil-document-layout-center iconStyle"></i><br />Outduty List</a>
                 </div>
                  
               
                <%-- <div class=" col-lg-2 col-md-3 col-sm-6 " title="Job Card">
                      <a class="ds_attendance_Basic_Text" href="/attendance/job_card_with_summary.aspx"><img class="image_width_for_module" src="images/common/application.ico" /><br />Job Card</a> 
                 </div> --%>
                   <div class="col-lg-2">
                   </div>
             </div>
               <div class="row ">
                   <div class="col-lg-2">
                   </div>
                   <div runat="server" id="divOutdutyApproval" class=" col-lg-2 col-md-3 col-sm-6 " title="Overtime Report">
                     <a class="ds_Settings_Basic_Text" href="/attendance/out_duty_approval.aspx"><i class="uil uil-check-circle iconStyle"></i><br />Outduty Approval</a>
                 </div>
                 <div runat="server" id="divOutdutyReport" class=" col-lg-2 col-md-3 col-sm-6 " title="Overtime Report">
                     <a class="ds_Settings_Basic_Text" href="/attendance/outduty_report.aspx"><i class="uil uil-file-bookmark-alt iconStyle"></i><br />Outduty Report</a>
                 </div>      
                   <div runat="server" id="divAbsentNotification" class=" col-lg-2 col-md-3 col-sm-6 " title="Absent Notification">
                     <a class="ds_Settings_Basic_Text" href="/attendance/absent_notification_log.aspx"><i class="uil uil-snapchat-square iconStyle"></i><br />Absent Notification</a>
                 </div> 
                   <div runat="server" id="divManpowerStatement" class=" col-lg-2 col-md-3 col-sm-6 " title="Manpower Statement">
                     <a class="ds_Settings_Basic_Text" href="/attendance/ManpowerStatement.aspx"><i class="uil uil-file-bookmark-alt iconStyle"></i><br />Manpower Statement</a>
                 </div> 
                     <div class="col-lg-2">

                 </div>
             </div>

        <div class="row ">
                             <div class="col-lg-2">

                 </div>

                 <div runat="server" id="divWeekendSetEmpWise" class="col-lg-2 col-md-3 col-sm-6" title="Weekend Setup" >
                     <a class="ds_attendance_Basic_Text" href="/attendance/weekend-set-emp-wise.aspx"> <i class="uil uil-calendar-alt iconStyle"></i><br /> Weekend Setup </a>
                     
                 </div>
                 <div  runat="server" id="divGeneralDay"  class="col-lg-2 col-md-3 col-sm-6" title="General Day Setup" >
                     <a class="ds_Settings_Basic_Text" href="/attendance/GeneralDay.aspx"> <i class="uil uil-calendar-alt iconStyle"></i><br /> General Day Setup </a>                
                 </div>
            <div  runat="server" id="divWeekendInfoReport"  class="col-lg-2 col-md-3 col-sm-6" title="Weekend Info Report" >
                     <a class="ds_Settings_Basic_Text" href="/attendance/WeekendInfoReport.aspx"> <i class="uil uil-file-bookmark-alt iconStyle"></i><br /> Weekend Info Report </a>                
                 </div>
            <div  runat="server" id="div"  class="col-lg-2 col-md-3 col-sm-6" title="Analysis Report" >
                     <a class="ds_Settings_Basic_Text" href="/attendance/attendance_analysis_report.aspx"> <i class="uil uil-document-layout-center iconStyle"></i><br />Analysis Report </a>                
                 </div>
                                     <div class="col-lg-2">

                 </div>                       
    
             </div>
    
       
    

</div></div>
</asp:Content>
