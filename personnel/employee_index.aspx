﻿<%@ Page Title="Employee Information" Language="C#" MasterPageFile="~/personnel_NestedMaster.master" AutoEventWireup="true" CodeBehind="employee_index.aspx.cs" Inherits="SigmaERP.personnel.EmpInfo_Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <div class="row">
            <div class="col-md-12">
                <div class="ds_nagevation_bar" style="border-bottom:none;">
                   
                           <ul>
                               <li><a href="/default.aspx">Dasboard</a></li>
                               <li> <a class="seperator" href="#">/</a></li>
                               <li> <a href="/personnel_defult.aspx">Personnel</a></li>
                               <li> <a class="seperator" href="#">/</a></li>
                               <li> <a href="#" class="ds_negevation_inactive Ptactive">Employee Information</a></li>
                           </ul>               
                    
                </div>
             </div>
        </div>
    <div>
    <div class="col-lg-12">
        <div class="row">
            <div class=" col-lg-2"></div>
            <div runat="server" id="divEmployeeEntry" class="col-lg-2 col-md-3 col-sm-6" title="New Employee Entry">
                <a class="ds_Settings_Basic_Text" href="/personnel/employee.aspx">
                    <img class="image_width_for_module" src="../images/common/addemployee.ico"/><br />
                    Employee Entry Panel</a>

            </div>
            <div runat="server" id="divEmployeeList" class=" col-lg-2 col-md-3 col-sm-6" title="All Employee Details">
                <a class="ds_Settings_Basic_Text" href="/personnel/employee_list.aspx">
                    <img class="image_width_for_module" src="../images/common/businesstype.ico" /><br />
                    All Employee List</a>
            </div>
            <div runat="server" id="divPendingWorker" class=" col-lg-2 col-md-3 col-sm-6" title="All Employee Details">
                <a class="ds_Settings_Basic_Text" href="/personnel/employee-list-allowing-compliance.aspx">
                    <img class="image_width_for_module" src="../images/common/businesstype.ico" /><br />
                    Pending Worker List</a>
            </div>
            <div runat="server" id="divEmployeeProfileReport" class=" col-lg-2 col-md-3 col-sm-6" title="Employee Profile">
                <a class="ds_Settings_Basic_Text" href="/personnel/employee_profile.aspx">
                    <img class="image_width_for_module" src="../images/common/grade.ico" /><br />
                    Employee Profile Report</a>
            </div>
           
            <div class="col-lg-2" ></div>
        </div>



        <div class="row">

            <div  class=" col-lg-2"></div>
             <div runat="server" id="divEmployeeListReport" class=" col-lg-2 col-md-3 col-sm-6" title="Employee List Report">
                <a class="ds_Settings_Basic_Text" href="/personnel/employee_information.aspx">
                    <img class="image_width_for_module" src="../images/common/businesstype.ico" /><br />
                    Employee List Report</a>
            </div>
            <div runat="server" id="divSeparation" class=" col-lg-2 col-md-3 col-sm-6" title="Employee Seperation">
                <a class="ds_Settings_Basic_Text" href="/personnel/separation.aspx">
                    <img class="image_width_for_module" src="../images/common/add document.ico" /><br />
                    Seperation Entry Panel</a>

            </div>
            <div runat="server" id="divSeparationComp" class=" col-lg-2 col-md-3 col-sm-6" title="Employee Seperation">
                <a class="ds_Settings_Basic_Text" href="/personnel/separationc.aspx">
                    <img class="image_width_for_module" src="../images/common/add document.ico" /><br />
                    Seperation Entry Panel</a>

            </div>
            <div runat="server" id="divSeparationReport" class=" col-lg-2 col-md-3 col-sm-6" title="Employee Seperation Report">
                <a class="ds_Settings_Basic_Text" href="/personnel/seperation_sheet.aspx">
                    <img class="image_width_for_module" src="../images/common/businesstype.ico" /><br />
                    Seperation List Report</a>
            </div>
            <div runat="server" id="divSeparationReportComp" class=" col-lg-2 col-md-3 col-sm-6" title="Employee Seperation Report">
                <a class="ds_Settings_Basic_Text" href="/personnel/seperation_sheetc.aspx">
                    <img class="image_width_for_module" src="../images/common/businesstype.ico" /><br />
                    Seperation List Report</a>
            </div>
            
            <div runat="server" id="divManPowerStatusReport" class=" col-lg-2 col-md-3 col-sm-6" title="Provident Fund Report">

                <a class="ds_Settings_Basic_Text" href="/personnel/man_power_status.aspx">
                    <img class="image_width_for_module" src="../images/common/businesstype.ico" /><br />
                    Man Power Status Report</a>
            </div>
            
            <div class=" col-lg-2 "></div>
        </div>
        <div class="row">

            <div class=" col-lg-2 "></div>
             <div  runat="server" id="divMonthlyManPowerReport"  class=" col-lg-2 col-md-3 col-sm-6" title="Provident Fund Report">

                <a class="ds_Settings_Basic_Text" href="/personnel/monthly_manpower.aspx">
                    <img class="image_width_for_module" src="../images/common/businesstype.ico" /><br />
                    Monthly Man Power Report</a>
            </div>
            <div runat="server" id="divContactListReport" class=" col-lg-2 col-md-3 col-sm-6" title="Blood Group Report">

                <a class="ds_Settings_Basic_Text" href="/personnel/EmpContactReport.aspx">
                    <img class="image_width_for_module" src="../images/common/Allowance.ico" /><br />
                    Contact List Report </a>
            </div>
            <div runat="server" id="divIDCardReport" class=" col-lg-2 col-md-3 col-sm-6" title="Staff ID Card">
                <a class="ds_Settings_Basic_Text" href="/personnel/staff_id_card.aspx">
                    <img class="image_width_for_module" src="../images/common/employee detail.ico" /><br />
                      ID Card Report</a>

            </div>
          <%--  <div class=" col-lg-2 col-md-3 col-sm-6" title="Worker ID Card">

                <a class="ds_personnel_Basic_Text" href="/personnel/worker_id_card.aspx">
                    <img class="image_width_for_module" src="../images/common/employee detail.ico" /><br />
                    Worker ID Card Report</a>
            </div>--%>
            <div runat="server" id="divBloodGroup" class=" col-lg-2 col-md-3 col-sm-6" title="Blood Group Report">
                <a class="ds_Settings_Basic_Text" href="/personnel/blood_group.aspx">
                    <img class="image_width_for_module" src="../images/common/add document.ico" /><br />
                    Blood Group Report</a>
            </div>
           
            <div class=" col-lg-2 "></div>
        </div>
        </div>
        </div>
</asp:Content>
