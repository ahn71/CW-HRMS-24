<%@ Page Title="Payroll" Language="C#" MasterPageFile="~/payroll_nested.master" AutoEventWireup="true" CodeBehind="payroll_default.aspx.cs" Inherits="SigmaERP.payroll_nested1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    

     <div class="row">
            <div class="col-md-12">
                <div class="ds_nagevation_bar" style="border-bottom:none;">
                     <div style="margin-top: 5px">
                           <ul>
                               <li><a href="/default.aspx">Dasboard</a></li>
                               <li> <a class="seperator" href="#">/</a></li>
                               <li> <a href="#" class="ds_negevation_inactive Pactive">Payroll</a></li>
                           </ul>               
                     </div>
                </div>
             </div>
        </div>
    
      <%--  <img alt="" class="main_images" src="images/hrd.png">--%>
    <div>
         <div class="col-lg-12">
             <div class="row rowCenter">
                 <div runat="server" id="divBonus" class="col-md-2">
                     <a class="ds_Settings_Basic_Text " href="/payroll/bonus_index.aspx"> <i class="uil uil-cog iconStyle"></i><br /> Bonus</a>
                     
                 </div>
                 <div runat="server" id="divAdvance" class=" col-md-2">
                        <a class="ds_Settings_Basic_Text " href="/payroll/advance/advance_index.aspx"><img class="image_width_for_module" src="images/common/designation.ico" /><br />Advance</a>
                 </div>
                 <div runat="server" id="divSalary" class=" col-md-2">
                      <a class="ds_Settings_Basic_Text " href="/payroll/salary_index.aspx"><img class="image_width_for_module" src="images/common/grade.ico" /><br />Salary</a>
                 </div>
                 <div runat="server" id="divSignatureEntry" class=" col-md-2">
                      <a class="ds_Settings_Basic_Text " href="/hrd/Signatures.aspx" target="_blank"><img class="image_width_for_module" src="images/common/grade.ico" /><br />Signature</a>
                 </div>
                 
             </div>
             <div class="row rowCenter">

                 <div runat="server" id="divPF" class="col-md-2">
                     <a class="ds_Settings_Basic_Text " href="/pf/pf_index.aspx"> <img class="image_width_for_module" src="images/common/department.ico" /><br /> Provident Fund</a>
                     
                 </div>
                 <div runat="server" id="divVat" class=" col-md-2">
                        <a class="ds_Settings_Basic_Text " href="/vat_tax/vat_tax_index.aspx"><img class="image_width_for_module" src="images/common/designation.ico" /><br />Vat&Tax</a>
                 </div>  
                     

                 <div class="col-lg-2">

                 </div>
 
             </div>


</div></div>

</asp:Content>
