<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="leaveConfiguration.aspx.cs" Inherits="SigmaERP.hrms.Leave.leaveConfiguration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <style>
        #ContentPlaceHolder1_MainContent_gvLeaveConfig td, th {
            text-align: center;
        }

            #ContentPlaceHolder1_MainContent_gvLeaveConfig td:nth-child(4), th:nth-child(4) {
                text-align: left;
                padding-left: 3px;
            }

        #ContentPlaceHolder1_MainContent_gvLeaveConfig th:first-child {
            text-align: left;
            padding-left: 3px;
        }

        #ContentPlaceHolder1_MainContent_gvLeaveConfig td:first-child {
            text-align: left;
            padding-left: 3px;
        }

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
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate><p class="message"  id="lblMessage" clientidmode="Static" runat="server"></p></ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="hdLeaveId" />
            <asp:AsyncPostBackTrigger ControlID="btnSave" />
            <asp:AsyncPostBackTrigger ControlID="ddlCompanyList" />
        </Triggers>

         <ContentTemplate>
      <main class="main-content">
      <div class="Dashbord">
         <div class="crm mb-25">
            <div class="container-fulid">
               <div class="card card-Vertical card-default card-md mt-4 mb-4">
                   <asp:HiddenField ID="hdLeaveId" ClientIDMode="Static" runat="server" Value="" />
                  <div class="card-header d-flex align-items-center">
                     <div class="card-title d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center gap-3">
                           <h4>Leave Configuration</h4>
                        </div>

                     </div>
                  </div>
                   
                  <div  id="Cardbox" class="card-body pb-md-30">
                     <div class="Vertical-form">
                           <div class="row">
                               <div class="col-lg-12">
                                   <div class="row">
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               
                                               <label for="ddlCompanyList" class="color-dark fs-14 fw-500 align-center mb-10">Company</label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                         <asp:DropDownList ID="ddlCompanyList" ClientIDMode="Static"   CssClass=" form-control" runat="server" AutoPostBack="True" style="height: 48px;" OnSelectedIndexChanged="ddlCompanyList_SelectedIndexChanged" >              
                                         </asp:DropDownList>

                                                   </div>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="ddlLeaveTypes" class="color-dark fs-14 fw-500 align-center mb-10">Leave Type<span class="text-danger">*</span></label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                       <asp:DropDownList ID="ddlLeaveTypes" runat="server" ClientIDMode="Static" CssClass="form-control" style="height: 48px;">
                                                       </asp:DropDownList>
                                                   </div>
                                                   <span class="text-danger" id="leaveTypeError"></span>

                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="txtLeaveDays" class="color-dark fs-14 fw-500 align-center mb-10">Leave Days<span class="text-danger">*</span></label>
                                               <div class="support-form__input-id">
                                                 
                                                    <asp:TextBox ID="txtLeaveDays" runat="server" ClientIDMode="Static" CssClass="form-control ih-medium ip-light radius-xs b-light px-15"  ></asp:TextBox>
                                            <span class="text-danger" id="leaveDaysError"></span>
                                                 
                                               </div>
                                           </div>
                                       </div>
                                        <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="txtLeaveNature" class="color-dark fs-14 fw-500 align-center mb-10">Leave Nature<span class="text-danger">*</span></label>
                                               <div class="support-form__input-id">
                                           
                                                       <asp:TextBox ID="txtLeaveNature" runat="server" ClientIDMode="Static" CssClass="form-control ih-medium ip-light radius-xs b-light px-15"></asp:TextBox>
                                                                                                                                              <span class="text-danger" id="leaveNaturesError"></span>

                                                
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12 d-none">
                                           <label for="" class="color-dark fs-14 fw-500">Deduction Allowed<span class="text-danger">*</span></label>
                                           <asp:CheckBox ID="IsDeductionAllowed" CssClass="" runat="server" />
                                       </div>
                                    


                                       <div class="col-lg-6 col-md-6 col-sm-12 d-flex">

                                               <asp:Button ID="btnSave"  ClientIDMode="Static" CssClass="btn btn-primary btn-default btn-squared px-30 m-2" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateForm();"/>
                                               <asp:Button runat="server" ID="btnPreview" Text="Preview" CssClass="btn btn-primary btn-default btn-squared px-30" OnClick="btnPreview_Click" />
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

                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                           <div class="table-responsive">
                              <div class="ad-table-table__header d-flex justify-content-between">
                                  <h4 style="margin-top: 13px;"></h4>
                              <div id="filter-form-container">
                              </div>
                              </div>

                               <div class="loader-size loaderModulesList " style="display: none">
                                   <div class="dm-spin-dots  dot-size dot-sizedot-sizedot-sizedot-size spin-sm">
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                   </div>
                               </div>

                        <div class="show_division_info">
                         <asp:GridView ID="gvLeaveConfig" runat="server" DataKeyNames="LeaveId,CompanyId" AllowPaging="True" AutoGenerateColumns="False" Width="100%" HeaderStyle-ForeColor="White" OnRowCommand="gvLeaveConfig_RowCommand" OnRowDeleting="gvLeaveConfig_RowDeleting" OnRowDataBound="gvLeaveConfig_RowDataBound" CssClass="gridview-bordered">
                                
                                <Columns>
                                    <asp:TemplateField HeaderText="SL">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="LeaveId" HeaderText="LeaveId" Visible="false" />

                                    <asp:BoundField DataField="LeaveName" HeaderText="Name"  />
                                    <asp:BoundField DataField="ShortName" HeaderText="Short"  />
                                    <asp:BoundField DataField="LeaveDays" HeaderText="Days"  />
                                    <asp:BoundField DataField="LeaveNature" HeaderText="Nature" />
                                    <asp:BoundField DataField="IsDeductionAllowed" HeaderText="Deduction" Visible="false"/>

                                     
                                    <%--<asp:ButtonField CommandName="Alter"   ControlStyle-CssClass="btnForAlterInGV"  HeaderText="Alter" ButtonType="Button" Text="Alter" ItemStyle-Width="80px"/>--%>
                                   
                                    <asp:TemplateField HeaderText="Action" ItemStyle-Width="100px">
                                       <ItemTemplate  >
                                           <%-- <asp:Button ID="btnDelete" runat="server" ControlStyle-CssClass="btnForDeleteInGV"  Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("LeaveId")%>'  OnClientClick="return confirm('Are you sure to delete ?')" />--%>
                                           <asp:LinkButton
                                               ID="lnkAlter"
                                               runat="server"
                                               CssClass="edit-btn edit"
                                               CommandName="Alter"
                                               CommandArgument='<%# ((GridViewRow)Container).RowIndex %>'>
                                         <i class="uil uil-edit"></i>
                                           </asp:LinkButton>

                                           <asp:LinkButton
                                               ID="lnkDelete"
                                               runat="server"
                                               CssClass="delete-btn remove "
                                               CommandName="Delete"
                                               CommandArgument='<%# Eval("LeaveId")%>'
                                               OnClientClick="return confirm('Are you sure to delete?')">
                                             <i class="uil uil-trash-alt"></i>
                                           </asp:LinkButton>



                                       </ItemTemplate>
                                   </asp:TemplateField>
                                     
                                </Columns>
                                <HeaderStyle BackColor="#f8f9fb" Height="28px" ForeColor="Black" HorizontalAlign="Left" />
                            </asp:GridView>
                          </div>  
                           </div>
                        </div>

                     </div>
                  </div>
               </div>
            </div>
                <!--Gv start From Thear---->
       
                        
            </div>
         </div>



 </main>
         </ContentTemplate>
    </asp:UpdatePanel>



 










    <script>
        function validateForm() {
            let isValid = true;

            // Validate Company Dropdown
            const companyList = $("#ddlCompanyList");
            if (companyList.val() === null || companyList.val() === "0") {
                alert("Please select a company.");
                isValid = false;
            }

            // Validate Leave Type Dropdown
            const leaveTypes = $("#ddlLeaveTypes");
            const leaveTypeError = $("#leaveTypeError");
            if (leaveTypes.val() === null || leaveTypes.val() === "0") {
                leaveTypeError.text("Please Select Leave Type.");
                isValid = false;
            } else {
                leaveTypeError.text("");
            }

            // Validate Leave Days
            const leaveDays = $("#txtLeaveDays");
            const leaveDaysError = $("#leaveDaysError");
            if (!leaveDays.val() || isNaN(leaveDays.val()) || leaveDays.val() <= 0) {
                leaveDaysError.text("Please enter valid leave days.");
                isValid = false;
            } else {
                leaveDaysError.text("");
            }

            // Validate Leave Nature
            const leaveNature = $("#txtLeaveNature");
            const leaveNatureError = $("#leaveNaturesError");
            if (!leaveNature.val().trim()) {
                leaveNatureError.text("Please enter leave nature.");
                isValid = false;
            } else {
                leaveNatureError.text("");
            }

            // Return validation result
            return isValid;
        }








         function Cardbox() {
             var CardboxElement = $("#Cardbox");
             var addnewElement = $("#addnew");

             if (addnewElement.html() === "Add New") {
                 CardboxElement.show();
                 addnewElement.text("Close");
             } else {
                 /*ClearTextBox()*/;
                 CardboxElement.hide();
                 addnewElement.html("Add New");
                
             }
        }

               function goToNewTabandWindow(url) {
           window.open(url);

       }



    </script>
</asp:Content>
