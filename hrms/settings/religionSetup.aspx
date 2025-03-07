﻿<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="religionSetup.aspx.cs" Inherits="SigmaERP.hrms.settings.religionSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
         <script src="../scripts/jquery-1.8.2.js"></script>
        <script type="text/javascript">

            var oldgridcolor;
            function SetMouseOver(element) {
                oldgridcolor = element.style.backgroundColor;
                element.style.backgroundColor = '#ffeb95';
                element.style.cursor = 'pointer';
                // element.style.textDecoration = 'underline';
            }
            function SetMouseOut(element) {
                element.style.backgroundColor = oldgridcolor;
                // element.style.textDecoration = 'none';

            }

     </script>
    <style>
        #ContentPlaceHolder1_MainContent_gvQualificationList th:nth-child(4), th:nth-child(3) {
            text-align:center;
        }
        #ContentPlaceHolder1_MainContent_gvQualificationList th:nth-child(1),td:nth-child(1),th:nth-child(2),td:nth-child(2){
            padding-left:3px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate><p class="message"  id="lblMessage" clientidmode="Static" runat="server"></p></ContentTemplate>
</asp:UpdatePanel>
    <asp:HiddenField ID="hdnUpdate" runat="server" ClientIDMode="Static" />
    
     <asp:HiddenField ID="upSave" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="upupdate" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="updelete" runat="server" ClientIDMode="Static" />
    <div class="main_box RBox">
    <%--<div class="main_box">--%>
    	<div class="main_box_header RBoxheader">
            <h2>Religion Panel</h2>
        </div>
    	<div class="main_box_body Rbody">
        	<div class="main_box_content">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSave" />
                               <asp:AsyncPostBackTrigger ControlID="gvQualificationList" />
                            </Triggers>
                            <ContentTemplate>
                <div class="input_division_info">
                    <table class="division_table">
                        <tr>
                            <td>
                                Religion <span class="requerd1">*</span>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtReligion" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width" MaxLength="20"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                বাংলায় 
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtReligionBn" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width fontF" MaxLength="30"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="button_area Rbutton_area">
                    <a href="#" onclick="window.history.back()" class="Rbutton">Back</a>
                    <asp:Button ID="btnNew" ClientIDMode="Static" CssClass="Rbutton"  runat="server" Text="New"  OnClick="btnNew_Click1"/>
                    <asp:Button ID="btnSave" ClientIDMode="Static" CssClass="Rbutton"  runat="server" Text="Save" OnClientClick="return validateInputs();" OnClick="btnSave_Click"  />
                    <asp:Button ID="btnClose" ClientIDMode="Static" CssClass="Rbutton" PostBackUrl="~/hrd_default.aspx"  runat="server" Text="Close" />
                </div>
             </ContentTemplate>
                        </asp:UpdatePanel>

				 <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" />
                         
                        <asp:AsyncPostBackTrigger ControlID="gvQualificationList" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:HiddenField ID="hdnbtnStage" runat="server" ClientIDMode="Static" />
                <div class="show_division_info">
                    <asp:GridView ID="gvQualificationList" runat="server" DataKeyNames="RId" AllowPaging="True" PageSize="15"  AutoGenerateColumns="False" Width="100%" HeaderStyle-BackColor="Black" HeaderStyle-ForeColor="White" OnRowCommand="gvQualificationList_RowCommand" OnRowDataBound="gvQualificationList_RowDataBound" OnRowDeleting="gvQualificationList_RowDeleting"  >
                             <RowStyle HorizontalAlign="Center" />
                              <PagerStyle CssClass="gridview Sgridview" Height="40px" />
                             <Columns>
                                 <asp:BoundField DataField="RName" HeaderText="Religion" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                 <asp:BoundField DataField="RNameBn" HeaderText="বাংলায়" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="fontF" />



                                 <asp:TemplateField HeaderText="Edit" ItemStyle-Width="100px">
                                     <ItemTemplate>
                                         <asp:Button ID="btnAlter" runat="server" ControlStyle-CssClass="btnForAlterInGV" Text="Edit" CommandName="Alter" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' />
                                     </ItemTemplate>
                                 </asp:TemplateField>
                                 <%--<asp:ButtonField CommandName="Alter"   ControlStyle-CssClass="btnForAlterInGV"  HeaderText="Alter" ButtonType="Button" Text="Alter" ItemStyle-Width="80px"/>--%>

                                 <asp:TemplateField HeaderText="Delete" ItemStyle-Width="100px">
                                     <ItemTemplate>
                                         <asp:Button ID="btnDelete" runat="server" ControlStyle-CssClass="btnForDeleteInGV" Text="Delete" CommandName="Delete" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' OnClientClick="return confirm('Are you sure to delete ?')" />
                                     </ItemTemplate>
                                 </asp:TemplateField>

                             </Columns>
                             <HeaderStyle BackColor="#0057AE" Height="28px" />
                         </asp:GridView>
                </div>
                        </ContentTemplate>
                </asp:UpdatePanel>

				
            </div>
        </div>
    <%--</div>--%>
    </div>
     <script type="text/javascript">

         //$('#dlDivision').change(function () {



         $('#btnNew').click(function () {
             clear();
         });
         function validateInputs() {
             if (validateText('txtReligion', 1, 60, 'Enter Religion') == false) return false;
             return true;
         }

         function editQualification(id) {
             var divsn = $('#r_' + id + ' td:first').html();

             $('#txtReligion').val(divsn);
             if ($('#updelete').val() == '1') {
                 $('#btnDelete').addClass('css_btn');
                 $('#btnDelete').removeAttr('disabled');
             }
             if ($('#upupdate').val() == '1') {
                 $('#btnSave').val('Update');
                 $('#btnSave').addClass('css_btn');
                 $('#btnSave').removeAttr('disabled');
             }
             else {
                 $('#btnSave').val('Update');
                 $('#btnSave').removeClass('css_btn');
                 $('#btnSave').attr('disabled', 'disabled');
             }
             $('#hdnbtnStage').val(1);
             $('#hdnUpdate').val(id);
         }

         //function deleteSuccess() {
         //    showMessage('Deleted successfully', 'success');
         //    $('#btnSave').val('Save');
         //    $('#hdnbtnStage').val("");
         //    $('#hdnUpdate').val("");
         //    clear();
         //}
         //function UpdateSuccess() {
         //    showMessage('Updated successfully', 'success');
         //    $('#btnSave').val('Save');
         //    $('#hdnbtnStage').val("");
         //    $('#hdnUpdate').val("");
         //    clear();
         //}
         //function SaveSuccess() {
         //    showMessage('Save successfully', 'success');
         //    $('#btnSave').val('Save');
         //    $('#hdnbtnStage').val("");
         //    $('#hdnUpdate').val("");
         //    clear();
         //}


         function clear() {
             if ($('#upSave').val() == '0') {

                 $('#btnSave').removeClass('css_btn');
                 $('#btnSave').attr('disabled', 'disabled');
             }
             else {
                 $('#btnSave').addClass('css_btn');
                 $('#btnSave').removeAttr('disabled');
             }

             $('#txtReligion').val('');
             $('#btnSave').val('Save');
             $('#hdnbtnStage').val("");
             $('#hdnUpdate').val("");
             $('#btnDelete').removeClass('css_btn');
             $('#btnDelete').attr('disabled', 'disabled');
         }

    </script>
</asp:Content>
