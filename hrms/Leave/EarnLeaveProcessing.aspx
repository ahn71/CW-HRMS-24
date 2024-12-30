<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="EarnLeaveProcessing.aspx.cs" Inherits="SigmaERP.hrms.Leave.EarnLeaveProcessing" %>
<%@ Register Assembly="ComplexScriptingWebControl" Namespace="ComplexScriptingWebControl" TagPrefix="cc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
          .uil-trash-alt{
            color:red;
            padding:5px;
        }

      .gridview-bordered tr {
        border: 1px solid #ddd; /* Adjust color as needed */
    }

    .gridview-bordered th, 
    .gridview-bordered td {
        padding: 8px; /* Add padding for better readability */
        text-align: left; /* Align text to the left */
        border: 1px solid #ddd; /* Cell borders */
    }

    .gridview-bordered th {
        background-color: #f4f4f4; /* Light header background */
        font-weight: bold;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="false" ></asp:ScriptManager>
    <asp:UpdatePanel ID="uplMessage" runat="server">
        <ContentTemplate>
            <p class="message" id="lblMessage" clientidmode="Static" runat="server"></p>
        </ContentTemplate>
    </asp:UpdatePanel>


      <div class="main_box Lbox">
        <div class="main_box_header LBoxheader">
            <h2 >Earn Leave Generation (Actual)</h2>
        </div>
    	<div class="main_box_body Pbody">
            <div class="main_box_content">
                <asp:UpdatePanel ID="up2" runat="server" UpdateMode="Conditional">
                        <Triggers>                           
                            <asp:AsyncPostBackTrigger ControlID="ddlCompanyList" />
                            <asp:PostBackTrigger  ControlID="btnGenerate"/>
                            <%--<asp:AsyncPostBackTrigger ControlID="btnGenerate" />--%>                          
                        </Triggers>
                        <ContentTemplate>
                           <div class="bonus_generation" style="width: 66%; margin: 0px auto;">   
                              
                                <table runat="server" visible="true" id="tblGenerateType"  style="width:60%; margin:0px auto">                              
                                    <tr>
                                         <td>
                                            Company
                                        </td>
                                      
                                        <td  >
                                            <asp:DropDownList ID="ddlCompanyList" runat="server"  CssClass="form-control select_width" ClientIDMode="Static"  ></asp:DropDownList>
                                        </td>
                                       
                                    </tr>
                                    <tr>
                                        <td>Generate Month
                                        </td>
                                        <td>
                                            <asp:TextBox CssClass="form-control text_box_width"  ClientIDMode="Static" ID="txtGenerateMonth" runat="server" autocomplete="off"></asp:TextBox>
                                            <asp:CalendarExtender ID="txtGenerateMonth_CalendarExtender" Format="dd-MM-yyyy" runat="server" TargetControlID="txtGenerateMonth">
                                            </asp:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            
                                        </td>
                                        <td>
                                           <asp:TextBox ID="txtEmpCardNo"  ClientIDMode="Static" runat="server" CssClass="form-control text_box_width" PLaceHolder="Type card no to individual generation" ></asp:TextBox>
                                        </td>
                                    </tr>                             

                                    <tr>
                                        <td>
                                           
                                        </td>
                                        <td>
                                            <asp:Image ID="imgLoading" runat="server" ImageUrl="~/images/loading.gif" ClientIDMode="Static"  />
                                        </td>
                                    </tr>
                                </table> 
                                           <asp:Button ID="btnGenerate" CssClass="btn btn-primary btn-default btn-squared px-30" ClientIDMode="Static" runat="server" Text="Generate"  OnClick="btnGenerate_Click" />
                            </div>   
                            <br />
                            <div  style="width: 38.5%; margin: 0px auto; overflow: hidden">
                                <div style="width: 50%; margin: 0px auto; overflow: hidden">
                        
                                    </div>
                            </div>        
                            <br />
                            <asp:Label runat="server" Visible="false" ID="lblErrorMsg" ClientIDMode="Static"></asp:Label>
                  <div class="bonus_generation" style="width: 66%; margin: 0px auto;">   
                            <asp:GridView runat="server" ID="gvEarnLeaveGenerationList" CssClass="gridview-bordered" DataKeyNames="CompanyID,GenerateDate" AutoGenerateColumns="false" HeaderStyle-Height="28px" Width="100%" OnRowCommand="gvEarnLeaveGenerationList_RowCommand" >
                                            <Columns>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                    <HeaderTemplate>SL</HeaderTemplate>
                                                    <ItemTemplate >
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="GenerateMonth" HeaderText="Generate Month" />                                                                                              
                                                 <asp:TemplateField HeaderText="Delete"  HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                  <ItemTemplate >
                                     <%-- <asp:Button ID="btnRemove" runat="server" CommandName="Remove" Width="55px" Height="30px" Font-Bold="true" ForeColor="red" Text="Delete" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' />--%>

                                      <asp:LinkButton
                                          ID="lnkRemove"
                                          runat="server"
                                          CommandName="Remove"

                                          CommandArgument='<%# ((GridViewRow)Container).RowIndex %>'
                                          CssClass="btnForRemove" OnClientClick="return confirm('Are you sure to delete?')">
                                             <i class="uil uil-trash-alt"></i>

                                      </asp:LinkButton>

                                  </ItemTemplate>
                              </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                </div>
                     </ContentTemplate>
                    </asp:UpdatePanel> 
            </div>
        </div>
    </div>


    
   <script type="text/javascript">

       $(document).ready(function () {
            
           $(document).on("keypress", "body", function (e) {
               if (e.keyCode == 13) e.preventDefault();
               // alert('deafault prevented');
             
           });          
       });    
   
       $('#imgLoading').hide();
   
   
    function validation()
    {
        if ($('#txtGenerateMonth').val().trim().length == 0) {
            showMessage("warning->Please Select Date ");
            $('#txtGenerateMonth').focus();
            return false;
        }
    }  
    function processing()
    {           
       $('#imgLoading').show();
        return true;
    }
    function ProcessingEnd(total) {
        showMessage("success->Successfully payroll generated of " + total + "");
        $('#imgLoading').hide();
        load();
    }
    function ProcessingEror(total) {
        showMessage("error->" + total + "");
        $('#imgLoading').hide();
        load();
    }
    function goToNewTabandWindow(url) {       
        window.open(url);
        ProcessingEnd();
    }

</script>
</asp:Content>
