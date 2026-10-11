<%@ Page Title="Employee List" Language="C#" MasterPageFile="~/personnel_NestedMaster.Master" AutoEventWireup="true" CodeBehind="employee_information.aspx.cs" Inherits="SigmaERP.personnel.employee_information" %>
<%@ Register Assembly="AjaxControlToolkit"  Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .punishment_against1 {
  overflow: hidden;
  
  margin-right:15px;
  margin:0 auto;
  margin-bottom:10px;
}
        .auto-style1 {
            width: 214px;
        }
        .auto-style2 {
            width: 108px;
        }
         .tdWidth{
            width:400px;
            height:45px;
        }

        /* ===== Employee information report: responsive layout (design only) ===== */
        .emp-info-form .punishment_against {
            width: 100%;
            max-width: 660px;
            margin: 0 auto 10px;
            padding: 12px 16px;
            background: #fff;
            border: 1px solid #e3e3e3;
            border-radius: 6px;
            overflow: visible;
        }
        .emp-info-form .employee_table {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
        }
        .emp-info-form .employee_table > tbody > tr > td {
            padding: 6px 0;
            height: auto;
            vertical-align: middle;
        }
        .emp-info-form .employee_table > tbody > tr > td:first-child {
            width: 30%;
            max-width: none;
            padding-right: 8px;
            font-weight: 600;
            color: #333;
            line-height: 1.3;
        }
        .emp-info-form .employee_table > tbody > tr > td:nth-child(2) {
            width: 14px;
            text-align: center;
        }
        .emp-info-form .employee_table > tbody > tr > td.tdWidth {
            width: auto;
        }
        .emp-info-form .employee_table .form-control:not(.select2-hidden-accessible) {
            width: 100% !important;
            max-width: 100%;
            margin: 0;
            box-sizing: border-box;
        }
        /* select2: block-level so it never drops below the label at any zoom */
        .emp-info-form .employee_table .select2-container {
            display: block;
            width: 100% !important;
            max-width: 100%;
            vertical-align: middle;
        }
        .emp-info-form .employee_table .select2-container .select2-selection--single {
            height: 34px;
        }
        .emp-info-form .employee_table .select2-container .select2-selection--single .select2-selection__rendered {
            line-height: 32px;
        }
        .emp-info-form .employee_table .select2-container .select2-selection--single .select2-selection__arrow {
            height: 32px;
        }

        /* RadioButtonLists */
        .emp-info-form .employee_table td table {
            width: auto;
        }
        .emp-info-form .employee_table td table tbody {
            display: flex;
            flex-wrap: wrap;
        }
        .emp-info-form .employee_table td table tr {
            display: flex;
            flex-wrap: wrap;
        }
        .emp-info-form .employee_table td table td {
            display: flex;
            align-items: center;
            padding: 3px 14px 3px 0;
            white-space: nowrap;
        }
        .emp-info-form .employee_table td table td input {
            margin: 0;
        }
        .emp-info-form .employee_table td table td label {
            font-weight: normal;
            margin: 0 0 0 5px;
        }

        /* Designation picker */
        .emp-info-form .emp-dsg-picker {
            display: flex;
            align-items: stretch;
            gap: 12px;
            width: 100%;
            max-width: 660px;
            margin: 10px auto;
            padding: 12px 16px;
            background: #fff;
            border: 1px solid #e3e3e3;
            border-radius: 6px;
        }
        .emp-info-form .emp-dsg-picker .id_card_left,
        .emp-info-form .emp-dsg-picker .id_card_right {
            float: none;
            flex: 1 1 0;
            width: auto;
            min-width: 0;
            margin: 0;
        }
        .emp-info-form .emp-dsg-picker p {
            margin: 0 0 5px;
            font-weight: 600;
        }
        .emp-info-form .emp-dsg-picker .lstdata {
            width: 100%;
        }
        .emp-info-form .emp-dsg-picker .id_card_center {
            float: none;
            flex: 0 0 auto;
            width: auto;
            margin: 0;
            display: flex;
            align-items: center;
        }
        .emp-info-form .emp-dsg-picker .id_card_center table {
            margin: 0 !important;
            width: auto;
        }
        .emp-info-form .emp-dsg-picker .arrow_button {
            min-width: 44px;
            margin: 3px 0;
        }

        /* Buttons */
        .emp-info-form .button_area {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 8px;
            width: 100%;
            max-width: 660px;
            margin: 0 auto;
        }
        .emp-info-form .button_area .css_btn {
            margin: 0;
            min-width: 90px;
        }

        @media (max-width: 575px) {
            .emp-info-form .employee_table,
            .emp-info-form .employee_table > tbody,
            .emp-info-form .employee_table > tbody > tr,
            .emp-info-form .employee_table > tbody > tr > td {
                display: block;
                width: 100% !important;
            }
            .emp-info-form .employee_table > tbody > tr > td:nth-child(2) {
                display: none;
            }
            .emp-info-form .employee_table > tbody > tr > td:first-child {
                padding: 6px 0 2px;
            }
            .emp-info-form .emp-dsg-picker {
                flex-direction: column;
            }
            .emp-info-form .emp-dsg-picker .id_card_center {
                justify-content: center;
            }
            .emp-info-form .emp-dsg-picker .id_card_center table tr {
                display: inline-block;
            }
            .emp-info-form .emp-dsg-picker .arrow_button {
                margin: 0 3px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
                  <div class="col-md-12 ">
               <div class="ds_nagevation_bar">
                   <ul>
                       <li><a href="/default.aspx">Dashboard</a></li>
                       <li><a href="#">/</a></li>
                       <li> <a href="<%= Session["__topMenuForPersonnel__"] %>">Personnel</a></li>
                       <li><a href="#">/</a></li>
                       <li><a href="#" class="ds_negevation_inactive Ptactive">Employees List</a></li>
                   </ul>
               </div>
          
             </div>
       </div>
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate><p class="message"  id="lblMessage" clientidmode="Static" runat="server"></p></ContentTemplate>
</asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlDepartment" />
            <asp:AsyncPostBackTrigger ControlID="ddlCompany" />
            
        </Triggers>
        <ContentTemplate>
    <div class="row Ptrow">
        <div class="employee_box_header PtBoxheader">
            <h2>Employee List Report</h2>
        </div>
        <div class="employee_box_body">
            <div class="employee_box_content">
        <div class="punishment_against1 emp-info-form">
                <div class="punishment_against">  
                    <h1  runat="server" visible="false" id="WarningMessage"  style="color:red; text-align:center"></h1>                  
                  <table runat="server" id="tblGenerateType" class="employee_table">                 
                        <tbody>
                             <tr id="trCompany" visible="false" runat="server">
                            <td >
                                Company
                            </td>
                            <td>
                                :
                            </td>
                            <td class="tdWidth">
                               <asp:DropDownList ID="ddlCompany" ClientIDMode="Static" CssClass="form-control select_width" runat="server" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged" AutoPostBack="True">
                                   
                                </asp:DropDownList>                                
                            </td>
                            
                        </tr>
                             <tr >
                                <td>
                                Department
                            </td>
                            <td>
                                :
                            </td>
                            <td class="tdWidth">
                               <asp:DropDownList ID="ddlDepartment" AutoPostBack="true" ClientIDMode="Static" CssClass="form-control select_width" runat="server" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                                   
                                </asp:DropDownList>
                                
                            </td>
                            </tr>  
                        <tr runat="server" visible="false">
                            <td>Card No</td>
                             <td>:</td>
                             <td  runat="server"  class="tdWidth">
                                  <asp:DropDownList ID="ddlCardNo" ClientIDMode="Static" CssClass="form-control select_width"  runat="server"></asp:DropDownList>
                                  <asp:TextBox ID="txtCardNo" Visible="false" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width"></asp:TextBox>                                
                            </td>
                             <td></td>
                        </tr>    
                            <tr>
                                <td>Employee Type</td>
                                <td>:</td>
                                <td>
                                    <asp:RadioButtonList runat="server" ID="rblEmpType" AutoPostBack="true" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblEmpType_SelectedIndexChanged" >
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                           <tr>
                                <td>Language</td>
                                <td>:</td>
                                <td class="tdWidth"><asp:RadioButtonList ID="rblLanguage"  RepeatDirection="Horizontal"  runat="server"  > 
                                     <asp:ListItem Value="EN" Selected="True" >English</asp:ListItem>   
                                    <asp:ListItem Value="BN" >Bangla</asp:ListItem>                                  
                                                                                                                                                          
                                     </asp:RadioButtonList>
                                </td>
                            </tr> 
                            <tr>
                                <td>Report Type</td>
                                <td>:</td>
                                <td class="tdWidth"><asp:RadioButtonList ID="rdblSearchEmployee"  RepeatColumns="5" runat="server"  AutoPostBack="True" OnSelectedIndexChanged="rdblSearchEmployee_SelectedIndexChanged">                                 
                                         <asp:ListItem Selected="True">Basic</asp:ListItem>
                                         <asp:ListItem >Designation</asp:ListItem>
                                         <asp:ListItem>District</asp:ListItem>
                                         <asp:ListItem>Joining</asp:ListItem>
                                         <asp:ListItem>Religion</asp:ListItem>                                      
                                     </asp:RadioButtonList>
                                </td>
                            </tr>
                     <tr id="trStatus" runat="server">
                            <td>
                                Status
                            </td>
                            <td>
                                :
                            </td>
                            <td >
                               <asp:DropDownList ID="ddlEmpStatus" ClientIDMode="Static" CssClass="form-control select_width" runat="server">
                                   
                                </asp:DropDownList>
                                
                            </td>
                        </tr> 
                            <tr id="trFdate" runat="server">
                                <td>
                                    From Date
                                </td>
                                <td>
                                :
                            </td>
                                <td>
                                    <asp:TextBox ID="dtpFromDate" CssClass="form-control text_box_width" runat="server"></asp:TextBox>
                                     <asp:CalendarExtender ID="CalendarExtender2" Format=dd-MM-yyyy runat="server" TargetControlID="dtpFromDate"></asp:CalendarExtender>
                                </td>
                            </tr>   
                            <tr id="trTdate" runat="server">
                                <td>
                                    To Date
                                </td>
                                <td>
                                :
                            </td>
                                <td >
                                    <asp:TextBox ID="dtpTodate" CssClass="form-control text_box_width" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender1" Format=dd-MM-yyyy runat="server" TargetControlID="dtpTodate"></asp:CalendarExtender>
                                </td>
                            </tr> 
                           
                            <tr id="trDistrict" runat="server">
                                <td>
                                District
                            </td>
                            <td>
                                :
                            </td>
                            <td >
                               <asp:DropDownList ID="ddlDistrict" ClientIDMode="Static" CssClass="form-control select_width" runat="server" >
                                   
                                </asp:DropDownList>
                                
                            </td>
                            </tr>  
                             <tr id="trReligion" runat="server">
                                <td>
                                Religion
                            </td>
                            <td>
                                :
                            </td>
                            <td >
                               <asp:DropDownList ID="ddlReligion"  ClientIDMode="Static" CssClass="form-control select_width" runat="server" >
                                   
                                </asp:DropDownList>
                                
                            </td>
                            </tr>  
                               
                      
                    </tbody>
                  </table>
                </div>
                   <div id="divdesignation" visible="false" runat="server" class="id_card emp-dsg-picker">
                    <div class="id_card_left EilistL">
                        <p>Available Designation</p>
                        <asp:ListBox ID="lstAll" runat="server" CssClass="lstdata EilistCec" SelectionMode="Multiple"></asp:ListBox>
                    </div>
                    <div class="id_card_center EilistC">
                        <table class="emp-dsg-buttons">                     
                              <tr>
                                    <td>
                                        <asp:Button ID="btnAddItem" Class="arrow_button" runat="server" Text=">" OnClick="btnAddItem_Click"   />
                                    </td>
                               </tr>
                            <tr>
                                    <td>
                                        <asp:Button ID="btnAddAllItem" Class="arrow_button" runat="server" Text=">>" OnClick="btnAddAllItem_Click"   />
                                    </td>
                               </tr>
                            <tr>
                                    <td>
                                        <asp:Button ID="btnRemoveItem" Class="arrow_button" runat="server" Text="<" OnClick="btnRemoveItem_Click"  />
                                    </td>
                               </tr>
                            <tr>
                                    <td>
                                        <asp:Button ID="btnRemoveAllItem" Class="arrow_button" runat="server" Text="<<" OnClick="btnRemoveAllItem_Click"   />
                                    </td>
                               </tr>
                        </table>
                    </div>
                    <div class="id_card_right EilistR">
                        <p>Selected Designation</p>
                          <asp:ListBox ID="lstSelected" SelectionMode="Multiple" CssClass="lstdata EilistCec"  ClientIDMode="Static" runat="server"></asp:ListBox>
                    </div>
                </div>
                <div class="button_area Rbutton_area">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/lock.png.jpg" Height="60px" Width="60px" Visible="false" />                              
                    <asp:Button ID="btnPreview" ClientIDMode="Static" CssClass="css_btn Ptbut" runat="server"  Text="Preview" OnClick="btnPreview_Click" />
                    <asp:Button ID="btnClose" CssClass="css_btn Ptbut" runat="server" Text="Close" PostBackUrl="~/personnel_defult.aspx" />
                    <asp:Button ID="Button1" CssClass="css_btn Ptbut" runat="server" Text="Clear" />
                </div>

        </div>
      </div>
    </div>
            </ContentTemplate>
        </asp:UpdatePanel>
     <script type="text/javascript">
         $(document).ready(function () {
             $("#ddlCardNo").select2();
             $("#ddlDepartment").select2();
             $("#ddlDistrict").select2();


         });
         function loadcardNo() {
             $("#ddlCardNo").select2();
             $("#ddlDepartment").select2();
             $("#ddlDistrict").select2();
            
         }
         function goToNewTabandWindow(url) {

             window.open(url);
             loadcardNo();

         }
         function InputBoxNew() {             
            
             $("#ddlCardNo").val('0');
             loadcardNo();
            // $('#txtCardNo').val('');
         }
    </script>
</asp:Content>
