<%@ Page Title="Vat And Tax" Language="C#" MasterPageFile="~/payroll_nested.master" AutoEventWireup="true" CodeBehind="vat_tax_index.aspx.cs" Inherits="SigmaERP.vat_tax.vat_tax_index" %>
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
                               <li> <a href="#" class="ds_negevation_inactive Pactive">Vat and Tax</a></li>
                           </ul>               
                  
                </div>
             </div>
        </div>
    
      <%--  <img alt="" class="main_/images" src="/images/hrd.png">--%>
     <div>
         <div class="col-lg-12">
             <div class="row">

                 <div class=" col-md-2">

                 </div>
                 <div class="col-md-2">
                     <a class="ds_Settings_Basic_Text " href="/vat_tax/allowance_calculation_settingsvat.aspx"> <i class="uil uil-megaphone FsiconStyle"></i><br />Allowance Calculation </a>
                     
                 </div>
                    <div class="col-md-2">
                     <a class="ds_Settings_Basic_Text " href="/vat_tax/vat_rate_settings.aspx"><i class="fas fa-money-check-alt FsiconStyle"></i><br />Vat&Tax Rate Settings
                     </a>
                     
                 </div>
                 <div class="col-md-2">
                     <a class="ds_Settings_Basic_Text " href="/vat_tax/taxfreeallowance.aspx"> <i class="uil uil-megaphone FsiconStyle FsiconStyle"></i><br />Tax Free Allowance </a>
                     
                 </div>                 
                   
                 <div class=" col-md-2">
                      <a class="ds_Settings_Basic_Text " href="/vat_tax/rebatable_rate_setting.aspx"> <i class="fas fa-hand-holding-usd FsiconStyle " ></i><br />Rebatable Rate Settings</a>
                 </div>
             </div>   
              <div class="row">

                 <div class=" col-md-2">
                 </div>
                 <div class="col-md-2">
                     <a class="ds_Settings_Basic_Text " href="/vat_tax/vat_tax_years.aspx"> <i class="uil uil-calendar-alt FsiconStyle"></i><br />Tax Years Setup </a>
                     
                 </div> 
                     <div class="col-md-2">
                     <a class="ds_Settings_Basic_Text " href="/vat_tax/vat_tax_investment.aspx"> <i class="uil uil-money-bill-stack iconStyle iconStyle"></i><br />Investment</a>                     
                 </div>   
                  <div class="col-md-2">
                     <a class="ds_Settings_Basic_Text " href="/vat_tax/vat_tax_generation.aspx"><i class="fa-solid fa-money-bill-wheat FsiconStyle"></i><br />Tax Generation </a>                     
                 </div>  
                    <div class="col-md-2">
                     <a class="ds_Settings_Basic_Text " href="/vat_tax/vat_tax_report.aspx"> <i class="fa-solid fa-money-bill-trend-up FsiconStyle"></i><br />Tax Repots</a>                     
                 </div>                              
             </div>                     
             </div>
</div>
</asp:Content>
