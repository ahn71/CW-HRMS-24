﻿<%@ Page Title="Advance Info Report" Language="C#" MasterPageFile="~/payroll_nested.Master" AutoEventWireup="true" CodeBehind="advance_info.aspx.cs" Inherits="SigmaERP.payroll.advance_info" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <div class="row">
        <div class="col-md-12">
            <div class="ds_nagevation_bar">
                <ul>
                    <li><a href="/default.aspx">Dasboard</a></li>
                   
                    <li><a class="seperator" href="#">/</a></li>
                 <li><a href="<%= Session["__topMenuAdvance__"] %>">Advance</a></li>
                    <li><a class="seperator" href="#">/</a></li>
                    <li><a href="#" class="ds_negevation_inactive Pactive">Advance Reports</a></li>
                </ul>
            </div>
        </div>
    </div>

    <asp:UpdatePanel ID="uplMessage" runat="server">
        <ContentTemplate>
            <p class="message" id="lblMessage" clientidmode="Static" runat="server"></p>
        </ContentTemplate>
    </asp:UpdatePanel>
     <div class="main_box Mbox">
        <div class="main_box_header PBoxheader">
            <h2>Advance Info Reports</h2>
        </div>
        <div class="main_box_body Pbody">
            <div class="main_box_content">

                <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlCompanyName" />                   
                        <asp:AsyncPostBackTrigger ControlID="rblGenerateType" />
                        <asp:AsyncPostBackTrigger ControlID="ddlSelectMonth" />
                    </Triggers>
                    <ContentTemplate>
                        <div class="bonus_generation" style="width: 61%; margin: 0px auto;">
                            <h1 runat="server" visible="false" id="WarningMessage" style="color: red; text-align: center">You Have Not Any Access Permission!</h1>
                             <table runat="server" visible="true" id="tblGenerateType" class="division_table_leave1">
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:RadioButtonList ID="rblReportType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                            <asp:ListItem Selected="True" Value="allInfo">All Advance Info</asp:ListItem> 
                                            <asp:ListItem Value="allDetails">All Advance Details</asp:ListItem>
                                            <%--<asp:ListItem  Value="summary">Summary</asp:ListItem>--%>
                                            

                                        </asp:RadioButtonList>
                                    </td>
                                    <td></td>
                                    <td>
                                       
                                    </td>
                                </tr>                                
                                <tr id="trForCompanyList" runat="server">
                                    <td>Company</td>
                                    <td>
                                        <asp:DropDownList ID="ddlCompanyName" runat="server" ClientIDMode="Static" CssClass="form-control select_width"  AutoPostBack="True" OnSelectedIndexChanged="ddlCompanyName_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="display:none" >
                                         
                                        <asp:DropDownList ID="ddlSelectMonth" runat="server" ClientIDMode="Static" CssClass="form-control select_width" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                    <td>Gererate Type</td>
                                    <td>
                                        <asp:RadioButtonList ID="rblGenerateType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="rblGenerateType_SelectedIndexChanged">
                                            <asp:ListItem Selected="True" Text="All" Value="0"></asp:ListItem>
                                            <asp:ListItem Selected="False" Text="Individual" Value="1"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td>Shift</td>
                                    <td>
                                        <asp:DropDownList Visible="true" ID="ddlShiftName" runat="server" ClientIDMode="Static" CssClass="form-control select_width"  AutoPostBack="True" OnSelectedIndexChanged="ddlShiftName_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    
                                    <td>Emp.Type</td>
                                    <td>
                                        <asp:RadioButtonList ID="rblEmpType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                            
                                        </asp:RadioButtonList>
                                    </td>
                                    <td>Card No</td>

                                    <td>
                                        <asp:TextBox ID="txtEmpCardNo" runat="server"  ClientIDMode="Static" PlaceHolder="For Certain Advanced Info" CssClass="form-control text_box_width_import" Enabled="False"></asp:TextBox>

                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:Panel id="pnl1" runat="server" >
                   <div id="divDepartmentList" runat="server" class="id_card" style="background-color: white; width: 61%;">
                                <div class="id_card_left EilistL">
                                    <asp:ListBox ID="lstAll" runat="server" CssClass="lstdata EilistCec" style="height:270px !important" SelectionMode="Multiple"></asp:ListBox>
                                </div>
                                <div class="id_card_center EilistC">
                                    <table style="margin-top: 60px;" class="employee_table">                  
                              <tr>
                                    <td>
                                        <asp:Button ID="btnAddItem" Class="arrow_button" runat="server" Text=">" OnClick="btnAddItem_Click"  />
                                    </td>
                               </tr>
                            <tr>
                                    <td>
                                        <asp:Button ID="btnAddAllItem" Class="arrow_button" runat="server" Text=">>" OnClick="btnAddAllItem_Click"  />
                                    </td>
                               </tr>
                            <tr>
                                    <td>
                                        <asp:Button ID="btnRemoveItem" Class="arrow_button" runat="server" Text="<" OnClick="btnRemoveItem_Click"  />
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
                                    <asp:ListBox ID="lstSelected" SelectionMode="Multiple" CssClass="lstdata EilistCec" style="height:270px !important" ClientIDMode="Static" runat="server"></asp:ListBox>
                                </div>
                </div>
                            </asp:Panel>
                <div class="payroll_generation_button">
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        
                                        <span style=" font-family:'Times New Roman'; font-size:20px; color:green;font-weight:bold; width:139px; float:left">
                                            <asp:Label runat="server" ID="lblProcess" text="wait processing"></asp:Label>
                                        <img style="width:26px;height:24px;cursor:pointer; margin-right:-56px" src="/images/wait.gif"  />  
                                    </ProgressTemplate>
                                </asp:UpdateProgress>

                    <asp:Button ID="btnPreview" runat="server" CssClass="Pbutton" Text="Preview" OnClick="btnPreview_Click"  />
                    <asp:Button ID="Button3" runat="server" Text="Close" PostBackUrl="~/payroll_default.aspx" CssClass="Pbutton" />
                </div>
                
            </div>
                        </ContentTemplate>
                </asp:UpdatePanel>
        </div>
    </div>
     </div>

    <script type="text/javascript">
        function InputValidationBasket() {
            try {

                if ($('#txtEmpCardNo').val().trim().length < 4) {
                    showMessage('Please select To Date', 'error');
                    $('#txtToDate').focus(); return true;
                }
                return true;
            }
            catch (exception) {
                showMessage(exception, error)
            }
        }

        function CloseWindowt() {
            window.close();
        }

        function goToNewTabandWindow(url) {
            window.open(url);

        }

        function getSalaryMonth() {

            var val = document.getElementById('ddlMonthID').value;
            document.getElementById('txtMonthId').value = val;

        }

        function CloseWindowt() {
            window.close();
        }

        function goToNewTabandWindow(url) {
            window.open(url);

        }



    </script>
</asp:Content>
