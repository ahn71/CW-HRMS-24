﻿<%@ Page Title="Separation Sheet" Language="C#" MasterPageFile="~/personnel_NestedMaster.Master" AutoEventWireup="true" CodeBehind="seperation_sheet.aspx.cs" Inherits="SigmaERP.personnel.seperation_sheet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>   
      
      .tdWidth{
            width:400px;
            height:40px;
        }
    
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12 ds_nagevation_bar">
            <div style="margin-top: 5px">
                <ul>
                    <li><a href="/default.aspx">Dashboard</a></li>
                    <li><a href="#">/</a></li>
                    <li> <a href="<%= Session["__topMenuForPersonnel__"] %>">Employee Information</a></li>
                    <li><a href="#">/</a></li>
                    <li><a href="#" class="ds_negevation_inactive">Seperation Sheet </a></li>
                </ul>
            </div>

        </div>
    </div>
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>  
    <asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate><p class="message"  id="lblMessage" clientidmode="Static" runat="server"></p></ContentTemplate>
</asp:UpdatePanel> 
     <asp:UpdatePanel runat="server" ID="up1">
         <Triggers>             
              <asp:AsyncPostBackTrigger ControlID="ddlMonthName" />
             <asp:AsyncPostBackTrigger ControlID="ddlCompany" />
         </Triggers>
        <ContentTemplate>
    <div class="row Ptrow">

                <div class="employee_box_header PtBoxheader">
                    <h2>Separation List Report</h2>
                </div>
                <div class="employee_box_body">
                    <div class="employee_box_content">

                        <div class="punishment_against">
                            <h1 runat="server" visible="false" id="WarningMessage" style="color: red; text-align: center"></h1>
                            <table runat="server" visible="true" id="tblGenerateType" class="employee_table">
                                <tr id="trCompanyName" runat="server" visible="false">
                                    <td>Company
                                    </td>
                                    <td>:</td>
                                    <td class="tdWidth">
                                        <asp:DropDownList ID="ddlCompany" ClientIDMode="Static" CssClass="form-control select_width" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr runat="server" visible="false">
                                    <td>Shift
                                    </td>
                                    <td>:</td>
                                    <td class="tdWidth">
                                        <asp:DropDownList ID="ddlShiftList" runat="server" ClientIDMode="Static" CssClass="form-control select_width">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Employee Type
                                    </td>
                                    <td>:</td>
                                    <td class="tdWidth">
                                        <asp:RadioButtonList ID="rbEmpList" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rbEmpList_SelectedIndexChanged">
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Month   
                                    </td>
                                    <td>:</td>
                                    <td class="tdWidth">
                                        <asp:DropDownList ID="ddlMonthName" ClientIDMode="Static" CssClass="form-control select_width" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlMonthName_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>

                            </table>
                        </div>

                        <div id="divDepartmentList" runat="server" class="id_card" style="background-color: white; width: 61%;">
                            <div class="id_card_left EilistL">
                                <asp:ListBox ID="lstAll" runat="server" CssClass="lstdata EilistCec" SelectionMode="Multiple"></asp:ListBox>
                            </div>
                            <div class="id_card_center EilistC">
                                <table style="margin-top: 0px;" class="employee_table">
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnAddItem" Class="arrow_button" runat="server" Text=">" OnClick="btnAddItem_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnAddAllItem" Class="arrow_button" runat="server" Text=">>" OnClick="btnAddAllItem_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnRemoveItem" Class="arrow_button" runat="server" Text="<" OnClick="btnRemoveItem_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnRemoveAllItem" Class="arrow_button" runat="server" Text="<<" OnClick="btnRemoveAllItem_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="id_card_right EilistR">
                                <asp:ListBox ID="lstSelected" SelectionMode="Multiple" CssClass="lstdata EilistCec" ClientIDMode="Static" runat="server"></asp:ListBox>
                            </div>
                        </div>

                <div class="punishment_button_area">
                    <table class="emp_button_table">
                        <tbody>
                            <tr>
                                 <th><asp:Button ID="btnpreview" CssClass="css_btn Ptbut" runat="server" ClientIDMode="Static" Text="Preview" OnClick="btnpreview_Click" /></th>
                                <th><asp:Button Visible="false" ID="btnDetails" CssClass="back_button" runat="server" ClientIDMode="Static" Text="Preview Details" OnClick="btnDetails_Click"  /></th>
                                <th><asp:Button ID="btnClose" CssClass="css_btn Ptbut" Text="Close" PostBackUrl="~/default.aspx" runat="server" /></th> 
                                
                         </tr>
                    </tbody>
                  </table>
                </div>

        </div>
      </div>
    </div>
            </ContentTemplate>
         </asp:UpdatePanel>
     <script type="text/javascript">
         $(document).ready(function () {

             loadcardNo();

         });
         function loadcardNo() {
             $("#ddlShiftList").select2();
             $("#ddlMonthName").select2();
         }
         function goToNewTabandWindow(url) {

             window.open(url);
             loadcardNo();

         }
         function EmpTypeValidation(){           
             alert($('#rbEmpList input').index(this));
             if ($('#ContentPlaceHolder1_MainContent_rbEmpList_0').val() == undefined)
             {
                 showMessage('Please Select Employee Type', 'warning');
                 $('#ddlMonthName').prop('disabled', true);
                 return false;
             }
             return true;
         } 

    </script>
</asp:Content>
