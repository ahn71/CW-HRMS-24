<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="designationSetup.aspx.cs" Inherits="SigmaERP.hrms.settings.DesignationSetup" %>
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
        #ContentPlaceHolder1_MainContent_divDesignationList th {
            text-align: center;
        }

            #ContentPlaceHolder1_MainContent_divDesignationList th:first-child {
                text-align: left;
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
    <div class="">
    	<div class="">
        	<div class="">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" />
                        <asp:AsyncPostBackTrigger ControlID="ddlCompanyName" />
                        <asp:AsyncPostBackTrigger ControlID="dlDepartment" />                         
                    </Triggers>
                    <ContentTemplate>

               <asp:HiddenField ID="hdnbtnStage" runat="server" ClientIDMode="Static" />

      <div class="Dashbord">
         <div class="crm mb-25">
            <div class="container-fulid">
               <div class="card card-Vertical card-default card-md mt-4 mb-4">

                  <div class="card-header d-flex align-items-center">
                     <div class="card-title d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center gap-3">
                           <h4>Designation</h4>
                        </div>



                     </div>
                </div>

                   <div id="Cardbox" class="card-body pb-md-30">
                       <div class="Vertical-form">
                           <div class="row">
                            
                                       <div class="col-lg-4">
                                           <div class="form-group">
                                               <label id="lblHidenUserId" style="display: none"></label>
                                               <label for="ddlCompany" class="color-dark fs-14 fw-500 align-center mb-10">Company Name</label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">

                                                     
                                <asp:DropDownList ID="ddlCompanyName" AutoPostBack="true" runat="server" ClientIDMode="Static"  CssClass="form-control select_width" OnSelectedIndexChanged="ddlCompanyName_SelectedIndexChanged" >
                                                                        
                                </asp:DropDownList>
                                                     

                                                   </div>
                                                   <span class="text-danger" id="ddlcompanyError"></span>
                                               </div>
                                           </div>
                                       </div>

                                       <div class="col-lg-4">
                                           <div class="form-group">
                                               <label for="txtDepartment" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Department Name <span class="text-danger">*</span>
                                               </label>
                                              <asp:DropDownList ID="dlDepartment" runat="server" ClientIDMode="Static"  CssClass="form-control select_width" AutoPostBack="true" OnSelectedIndexChanged="dlDepartment_SelectedIndexChanged">
                                                                        
                                </asp:DropDownList>
                                               <span class="text-danger" id="userNameError"></span>
                                           </div>
                                       </div>     
                                       <div class="col-lg-4">
                                           <div class="form-group">
                                               <label for="txtDesignation" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Designation <span class="text-danger">*</span>
                                               </label>
                                                    <asp:TextBox ID="txtDesignation" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width"></asp:TextBox>
                                           </div>
                                       </div>

                               <asp:Panel ID="trDptCode" runat="server" CssClass="col-lg-4">
                                   <div class="form-group">
                                       <label for="txtDepartmentCode" class="color-dark fs-14 fw-500 align-center mb-10">
                                            বাংলায়
                                       </label>

                                            <asp:TextBox ID="txtDesignationBn" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width" Font-Names="SutonnyMJ"></asp:TextBox>
                                   
                                   </div>
                               </asp:Panel>




                               <div class="col-lg-4">
                                           <div class="form-group">
                                               <label for="dlStatus" class="color-dark fs-14 fw-500 align-center mb-10">
                                                        Short Name  <span class="text-danger">*</span>
                                               </label>
                                                 <asp:TextBox ID="txtDesignationShortName" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width"></asp:TextBox> 
                                           </div>
                                       </div>             
                               <div class="col-lg-4">
                                           <div class="form-group">
                                               <label for="dlStatus" class="color-dark fs-14 fw-500 align-center mb-10">
                                                        Order No  <span class="text-danger">*</span>
                                               </label>
                                                 <asp:TextBox ID="txtOrderNo" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width"></asp:TextBox>
                                           </div>
                                       </div>           
                               <div class="col-lg-4">
                                           <div class="form-group">
                                               <label for="dlStatus" class="color-dark fs-14 fw-500 align-center mb-10">
                                                        Designation Code  <span class="text-danger">*</span>
                                               </label>
                                            <asp:TextBox ID="txtDesignationCode" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width"></asp:TextBox>
                                           </div>
                                       </div>        
                               <div class="col-lg-4">
                                           <div class="form-group">
                                               <label for="dlStatus" class="color-dark fs-14 fw-500 align-center mb-10">
                                                        Status Code  <span class="text-danger">*</span>
                                               </label>
                                            <asp:DropDownList ID="dlStatus" ClientIDMode="Static" CssClass="form-control select_width" runat="server">
                                <asp:ListItem>-select-</asp:ListItem>
                                <asp:ListItem>Active</asp:ListItem>
                                <asp:ListItem>InActive</asp:ListItem>
                            </asp:DropDownList>
                                           </div>
                                       </div>
                               
                               <div class="col-lg-4">
                                           <div class="form-group">
                                               <label style="opacity: 0;" for="formGroupExampleInput"
                                                   class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Name <span
                                                       class="text-danger"></span>
                                               </label>
                                              <asp:Button ID="btnSave" OnClientClick="return validateInputs();"  ClientIDMode="Static" class="btn btn-primary btn-squared px-30" runat="server" Text="Save" OnClick="btnSave_Click" />
                                           </div>
                                       </div>
                           </div>


                       </div>

                   </div>


               </div>

            </div>
         </div>

      </div>

            <div class="row">
               <div class="col-lg-12">
                  <div class="card ">
                     <div class="card-body">
                    <asp:GridView ID="divDesignationList" runat="server" Width="100%" AutoGenerateColumns="False" DataKeyNames="SL,CompanyId,DptId,DsgId"  OnRowCommand="divDesignationList_RowCommand" OnRowDeleting="divDesignationList_RowDeleting" AllowPaging="True" OnPageIndexChanging="divDesignationList_PageIndexChanging" OnRowDataBound="divDesignationList_RowDataBound"  CssClass="gridview-bordered">
                        <HeaderStyle  Font-Bold="True" Font-Size="14px" Height="28px" />
                          <PagerStyle CssClass="gridview Sgridview" Height="40px" />
                       <RowStyle HorizontalAlign="Center" />
                         <Columns>
                            <asp:BoundField DataField="SL"  HeaderText="SL" Visible="false"  ItemStyle-Height="28px" >
                             <ItemStyle Height="28px" />
                             </asp:BoundField>
                            <asp:BoundField DataField="CompanyName" HeaderStyle-HorizontalAlign="Left" HeaderText="Company Name" Visible="true"   ItemStyle-Height="28px" ItemStyle-HorizontalAlign="Left"  >
                             <HeaderStyle HorizontalAlign="Left" />
                             <ItemStyle Height="28px" HorizontalAlign="Left"/>
                             </asp:BoundField>
                            <asp:BoundField DataField="DptName" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center" HeaderText="Department" Visible="true" ItemStyle-Height="28px" >
                             <ItemStyle Height="28px"  />
                             </asp:BoundField>
                            <asp:BoundField DataField="DsgName" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center" HeaderText="Designation" Visible="true"  ItemStyle-Height="28px" >
                             <ItemStyle Height="28px"  />
                             </asp:BoundField>
                              <asp:BoundField DataField="DsgNameBn" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center" HeaderText="পদবী" Visible="true"  ItemStyle-CssClass="fontF"  ItemStyle-Height="28px" >
                             <ItemStyle Height="28px"  />
                             </asp:BoundField>                              
                             <asp:BoundField DataField="DsgShortName" HeaderText="Dsg.ShortName" Visible="true"  ItemStyle-Height="28px" >
                             <ItemStyle Height="28px"  />
                             </asp:BoundField>
                             <asp:BoundField DataField="Ordering" HeaderText="Order No" Visible="true"  ItemStyle-Height="28px" >
                             <ItemStyle Height="28px"  />
                             </asp:BoundField>
                               <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Visible="true">
                                 <ItemTemplate>
                                     <%# 
            Convert.ToInt32(Eval("DsgStatus")) == 1 ? 
            "<span class='badge-leave bg-success'>Active</span>" : 
            "<span class='badge-leave bg-rejected'>Inactive</span>"
                                     %>
                                 </ItemTemplate>
                             </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkAlter" runat="server" CommandName="Alter" CommandArgument="<%#((GridViewRow)Container).RowIndex%>" Font-Bold="true" ForeColor="Green" ><i  class="uil uil-edit"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Delete" >
                                <ItemTemplate>
                                     <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CommandArgument="<%#((GridViewRow)Container).RowIndex%>" Font-Bold="true" ForeColor="Red" OnClientClick="return confirm('Are you sure to delete?');" > <i class="uil uil-trash-alt"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    </div>
                      </div>
                   </div>
                </div>
                    
              </ContentTemplate>
                </asp:UpdatePanel>
				
            </div>
        </div>
    </div>
    <script type="text/javascript">

         //$('#btnNew').click(function () {
         //    clear();
         //});
         function validateInputs() {
             if (validateText('txtDepartment', 1, 60, 'Enter Department Name') == false) return false;
             //if (validateText('txtDepartmentCode', 1, 60, 'Enter Department Code') == false) return false;
             return true;
         }

         function editDepartment(id) {
             var divsn = $('#r_' + id + ' td:first').html();
             var dropdownlistbox = document.getElementById("dlDivision")
             for (var x = 0; x < dropdownlistbox.length; x++) {
                 if (divsn == dropdownlistbox.options[x].text) {
                     dropdownlistbox.options[x].selected = true;

                 }
             }
             //$('#dlDivision').val(divsn);
             var depName = $('#r_' + id + ' td:nth-child(2)').html();
             $('#txtDepartment').val(depName);
             var depNameB = $('#r_' + id + ' td:nth-child(3)').html();
             $('#txtDepartmentBn').val(depNameB);
             //var depCode = $('#r_' + id + ' td:nth-child(4)').html();
             //$('#txtDepartmentCode').val(depCode);
             var depStatus = $('#r_' + id + ' td:nth-child(4)').html();
             $('#dlStatus').val(depStatus);

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

         function deleteSuccess() {
             showMessage('Deleted successfully', 'success');
             $('#btnSave').val('Save');
             $('#hdnbtnStage').val("");
             $('#hdnUpdate').val("");
             //clear();
         }
         function UpdateSuccess() {
             showMessage('Updated successfully', 'success');
             $('#btnSave').val('Save');
             $('#hdnbtnStage').val("");
             $('#hdnUpdate').val("");
            // clear();
         }
         function SaveSuccess() {
             showMessage('Save successfully', 'success');
             $('#btnSave').val('Save');
             $('#hdnbtnStage').val("");
             $('#hdnUpdate').val("");
             //clear();
         }


         function clear() {
             if ($('#upSave').val() == '0') {

                 $('#btnSave').removeClass('css_btn');
                 $('#btnSave').attr('disabled', 'disabled');
             }
             else {
                 $('#btnSave').addClass('css_btn');
                 $('#btnSave').removeAttr('disabled');
             }

             $('#txtDepartment').val('');
             $('#txtDepartmentBn').val('');
             $('#txtDepartmentCode').val('');
             $('#btnSave').val('Save');
             $('#hdnbtnStage').val("");
             $('#hdnUpdate').val("");
             $('#btnDelete').removeClass('css_btn');
             $('#btnDelete').attr('disabled', 'disabled');
             //$('#dlDivision option:selected').text('---Select---');
         }

    </script>
</asp:Content>
