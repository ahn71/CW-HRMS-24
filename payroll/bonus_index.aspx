<%@ Page Title="Bonus" Language="C#" MasterPageFile="~/payroll_nested.master" AutoEventWireup="true" CodeBehind="bonus_index.aspx.cs" Inherits="SigmaERP.payroll.bonus_index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <div class="row">
            <div class="col-md-12">
               <div class="ds_nagevation_bar" style="border-bottom:none;">
                   
                           <ul>
                               <li><a href="/default.aspx">Dasboard</a></li>
                               <li> <a class="seperator" href="#">/</a></li>
                               <li> <a href="/payroll_default.aspx">Payroll</a></li>
                               <li> <a class="seperator" href="#">/</a></li>
                               <li> <a href="#" class="ds_negevation_inactive Pactive">Bouns</a></li>
                           </ul>               
                    
                </div>
             </div>
        </div>
    
      <%--  <img alt="" class="main_/imagess" src="/imagess/hrd.png">--%>
    <div>
         <div class="col-lg-12 ">
             <div class="row rowCenter">
                 
                 <div class="col-md-2" title="Bonus Setup">
                     <a runat="server" id="aBonusSetup" class="ds_Settings_Basic_Text " href="/payroll/bonus_setup.aspx"> <i class="fa-solid fa-money-check-dollar FsiconStyle"></i><br /> <span>Bonus Setup</span></a>
                     <a runat="server" id="aBonusSetupc" class="ds_Settings_Basic_Text " href="/payroll/bonus_setupc.aspx"> <i class="fa-solid fa-money-check-dollar FsiconStyle"></i><br /> <span>Bonus Setup</span></a>
                     
                 </div>
                 <div class=" col-md-2" title="Bonus Month Setup">
                        <a runat="server" id="aBonusMonthSetup" class="ds_Settings_Basic_Text " href="/payroll/bonus_monyh_setup.aspx"><i class="fa-regular fa-calendar-days FsiconStyle"></i><br /><span>B. Month Setup</span></a>
                     <a runat="server" id="aBonusMonthSetupc" class="ds_Settings_Basic_Text " href="/payroll/bonus_month_setupc.aspx"><i class="fa-regular fa-calendar-days FsiconStyle"></i><br /><span>B. Month Setup</span></a>
                 </div>
                 <div class=" col-md-2" title="Bonus Generate">
                      <a runat="server" id="aBonusGenerate" class="ds_Settings_Basic_Text " href="/payroll/bonus_generation.aspx"><i class="fa-solid fa-circle-dollar-to-slot FsiconStyle"></i><br /><span>B. Generate</span></a>
                     <a runat="server" id="aBonusGeneratec" class="ds_Settings_Basic_Text " href="/payroll/bonus_generationc.aspx"><i class="fa-solid fa-circle-dollar-to-slot FsiconStyle"></i><br /><span>B. Generate</span></a>
                 </div>
                   <div class=" col-md-2" title="Bonus Rise & Fall">
                      <a runat="server" id="aBonusRiseFall" class="ds_Settings_Basic_Text " href="/payroll/bonus_increase_decrease.aspx"><i class="fa-solid fa-money-bill-trend-up FsiconStyle"></i><br /><span>B. Rise & Fall</span></a>
                       
                       
                 </div>
     
             </div>

               <div class="row rowCenter">

        

                 <div class=" col-md-2" title="Bonus Sheet">
                      <a runat="server" id="aBonusSheet" class="ds_Settings_Basic_Text " href="/payroll/bonus_sheet_Report.aspx"><i class="fas fa-receipt FsiconStyle"></i><br /><span>Bonus Sheet</span></a>    
                     <a runat="server" id="aBonusSheetc" class="ds_Settings_Basic_Text " href="/payroll/bonus_sheet_Reportc.aspx"><i class="fas fa-receipt FsiconStyle"></i><br /><span>Bonus Sheet</span></a>                    
                 </div>
                 <div runat="server" id="aBonusSummary" class=" col-md-2" title="Bonus Summary">
                     <a class="ds_Settings_Basic_Text " href="/payroll/bonus_summary_report.aspx"><i class="fas fa-money-check FsiconStyle"></i><br /><span>B. Summary</span></a> 
                 
                 </div>
                 <div class=" col-md-2" title="Bonus Miss Sheet">
                     <a runat="server" id="aBonusMissSheet" class="ds_Settings_Basic_Text " href="/payroll/bonus_miss_sheet_Report.aspx"><i class="uil uil-money-bill-slash FsiconStyle"></i><br />B. Miss Sheet</a>                     
                 </div>     
                   <div class="col-md-2">

                   </div>
 
             </div>
</div>
        </div>
</asp:Content>
