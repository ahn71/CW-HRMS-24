<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="companySetup.aspx.cs" Inherits="SigmaERP.hrms.settings.companySetup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
            /*#ContentPlaceHolder1_MainContent_gvLeaveConfig td, th {
                text-align: center;
            }*/

           

            .uil-trash-alt {
                color: red;
                padding: 5px;
            }

            /*.gridview-bordered tr {
                border: 1px solid #ddd; 
            }*/



            .gridview-bordered th,
            .gridview-bordered td {
                padding: 8px; /* Add padding for better readability */
                text-align: left; /* Align text to the left */
                /*border: 1px solid #ddd;*/ /* Cell borders */
            }

            .gridview-bordered th {
                background-color: #f4f4f4; /* Light header background */
                font-weight: bold;
                color:#404040;
              
            }

            .address-header {
                width: 300px;
                text-align: left;
            }

            .address-item {
                width: 300px;
                white-space: normal; /* Allows text to wrap */
                word-wrap: break-word; /* Ensures long words break properly */
            }
            .userDatatable table td{
                white-space:unset !important;
            }
            .logo-defult-iamge{
                width:100px;
                height:100px;
            }
            .gridview-bordered{
                color:#0A0A0A;
               


            }
            .gridview-bordered tr:hover{
                background-color:#f4f4f4 !important;
            }
            .gridview-bordered .email {
                font-size:14px;
                font-style:italic;
            }
            

            .gridview-bordered tr{
                padding: 20px;
            }


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>    
<%--    <asp:HiddenField ID="hdfID" ClientIDMode="Static" runat="server" Value="0" />--%>
     <asp:HiddenField ID="upSave" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="upupdate" runat="server" ClientIDMode="Static" />   

    <asp:UpdatePanel ID="uplMessage" runat="server">
        <ContentTemplate>
            <p class="message" id="lblMessage" clientidmode="Static" runat="server"></p>
        </ContentTemplate>
    </asp:UpdatePanel>
         
    <div runat="server" id="divMsg"></div>

         <main class="main-content">
        <div class="Dashbord">
        
                     <div class="crm mb-25">
                     <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="rblOfficeType" />
                                <asp:AsyncPostBackTrigger ControlID="rblCardNoType" />                               
                                <asp:AsyncPostBackTrigger ControlID="gvCompanyInfo" />
                              
                            </Triggers>
                            <ContentTemplate>
                <div class="container-fulid">
                    <div class="card card-Vertical card-default card-md mt-4 mb-4">
                        <asp:HiddenField ID="hdLeaveId" ClientIDMode="Static" runat="server" Value="" />
                        <div class="card-header d-flex align-items-center">
                            <div class="card-title d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <h4>Company Setup</h4>
                                </div>

                            </div>
                        </div>
                       
                                <div id="Cardbox" class="card-body pb-md-30">
                                    <div class="Vertical-form">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="row">

                                                    <div class="col-xl-2 col-lg-2 col-md-6 col-sm-12 d-none">
                                                        <div class="form-group">
                                                            <label for="txtCompanyId" class="color-dark fs-14 fw-500 align-center mb-10">Company ID <span class="text-danger">*</span></label>
                                                            <asp:TextBox ID="txtCompanyId" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 ih-medium ip-light radius-xs b-light px-15" Enabled="False"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <!-- Company Type -->
                                                    <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 d-none">
                                                        <div class="form-group">
                                                            <label class="color-dark fs-14 fw-500 align-center mb-10">Company Type <span class="text-danger">*</span></label>
                                                            <asp:RadioButtonList ID="rblOfficeType" runat="server" RepeatDirection="Horizontal" CssClass="form-check form-check-inline" AutoPostBack="true" OnSelectedIndexChanged="rblOfficeType_SelectedIndexChanged">
                                                                <asp:ListItem Selected="True" Value="1">Head Office</asp:ListItem>
                                                                <asp:ListItem Value="0">Branch Office</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                    </div>

                                                    <div runat="server" id="trHeadOffice" visible="false">
                                                        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 " runat="server">
                                                            <div class="form-group">
                                                                <label for="ddlHeadOffice" class="color-dark fs-14 fw-500 align-center mb-10">
                                                                    Head Office <span class="text-danger">*</span>
                                                                </label>
                                                                <asp:DropDownList ID="ddlHeadOffice" runat="server" ClientIDMode="Static"
                                                                    CssClass="form-control ih-medium ip-light radius-xs b-light px-15">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>



                                                    <!-- Company Name -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtCompanyName" class="color-dark fs-14 fw-500 align-center mb-10">Company Name <span class="text-danger">*</span></label>
                                                            <asp:TextBox ID="txtCompanyName" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <!-- Short Name -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtShortName" class="color-dark fs-14 fw-500 align-center mb-10">Short Name <span class="text-danger">*</span></label>
                                                            <asp:TextBox ID="txtShortName" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15" Style="text-transform: uppercase;" MaxLength="3"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <!-- Company Name in Bangla -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtCompanyNameBangla" class="color-dark fs-14 fw-500 align-center mb-10">কোম্পানীর নাম <span class="text-danger"></span></label>
                                                            <asp:TextBox ID="txtCompanyNameBangla" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15" Font-Names="SutonnyMJ"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <!-- Address -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtAddress" class="color-dark fs-14 fw-500 align-center mb-10">Address</label>
                                                            <asp:TextBox ID="txtAddress" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <!-- Address in Bangla -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtAddressBangla" class="color-dark fs-14 fw-500 align-center mb-10">ঠিকানা <span class="text-danger"></span></label>
                                                            <asp:TextBox ID="txtAddressBangla" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15" TextMode="MultiLine" Font-Names="SutonnyMJ"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtCountry" class="color-dark fs-14 fw-500 align-center mb-10">Country</label>
                                                            <asp:TextBox ID="txtCountry" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <!-- Telephone -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtTelephone" class="color-dark fs-14 fw-500 align-center mb-10">Phone</label>
                                                            <asp:TextBox ID="txtTelephone" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <!-- Fax -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtFax" class="color-dark fs-14 fw-500 align-center mb-10">Fax</label>
                                                            <asp:TextBox ID="txtFax" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <!-- Default Currency -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="ddlDefaultCurrency" class="color-dark fs-14 fw-500 align-center mb-10">Default Currency</label>
                                                            <asp:DropDownList ID="ddlDefaultCurrency" runat="server" ClientIDMode="Static" CssClass="form-control ih-medium ip-light radius-xs b-light px-15">
                                                                <asp:ListItem Value="Taka">Taka</asp:ListItem>
                                                                <asp:ListItem Value="Rupee">Rupee</asp:ListItem>
                                                                <asp:ListItem Value="Riyal">Riyal</asp:ListItem>
                                                                <asp:ListItem Value="Dollar">Dollar</asp:ListItem>
                                                                <asp:ListItem Value="Pound">Pound</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <!-- Registration Info -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtRegistrationInfos" class="color-dark fs-14 fw-500 align-center mb-10">Registration No</label>
                                                            <asp:TextBox ID="txtRegistrationInfos" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <!-- Establishment Info -->
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="txtEstablesed" class="color-dark fs-14 fw-500 align-center mb-10">Establishment No</label>
                                                            <asp:TextBox ID="txtEstablesed" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="ddlBusinessType" class="color-dark fs-14 fw-500 align-center mb-10">Business Type</label>
                                                            <asp:DropDownList ID="ddlBusinessType" ClientIDMode="Static" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 select_width" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 d-none">
                                                        <div class="form-group">
                                                            <label for="ddlMultipleBranch" class="color-dark fs-14 fw-500 align-center mb-10">Multiple Branch?</label>
                                                            <asp:DropDownList ID="ddlMultipleBranch" ClientIDMode="Static" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 select_width" runat="server">
                                                                <asp:ListItem>No</asp:ListItem>
                                                                <asp:ListItem>Yes</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="ddlCardNoDigit" class="color-dark fs-14 fw-500 align-center mb-10">Card No Digits</label>
                                                            <asp:DropDownList ID="ddlCardNoDigit" ClientIDMode="Static" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 select_width" runat="server">
                                                                <asp:ListItem Value="3">3</asp:ListItem>
                                                                <asp:ListItem Value="4">4</asp:ListItem>
                                                                <asp:ListItem Value="5">5</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                   
                                                     
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 d-none">
                                                                <div class="form-group">
                                                                    <label for="ddlWeekend" class="color-dark fs-14 fw-500 align-center mb-10">Weekend</label>
                                                                    <asp:DropDownList ID="ddlWeekend" ClientIDMode="Static" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 select_width" runat="server">
                                                                        <asp:ListItem>Friday</asp:ListItem>
                                                                        <asp:ListItem>Saturday</asp:ListItem>
                                                                        <asp:ListItem>Sunday</asp:ListItem>
                                                                        <asp:ListItem>Monday</asp:ListItem>
                                                                        <asp:ListItem>Tuesday</asp:ListItem>
                                                                        <asp:ListItem>Wednesday</asp:ListItem>
                                                                        <asp:ListItem>Thursday</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>

                                                            <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                                <div class="form-group">
                                                                    <label for="ddlCmpStatus" class="color-dark fs-14 fw-500 align-center mb-10">Status</label>
                                                                    <asp:DropDownList ID="ddlCmpStatus" ClientIDMode="Static" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 select_width" runat="server">
                                                                        <asp:ListItem Value="1">Active</asp:ListItem>
                                                                        <asp:ListItem Value="0">Inactive</asp:ListItem>
                                                                        <asp:ListItem Value="2">Expired</asp:ListItem>
                                                                        <asp:ListItem Value="3">Suspended</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                                <div class="form-group">
                                                                    <label for="ddlMachine" class="color-dark fs-14 fw-500 align-center mb-10">Att Machine</label>
                                                                    <asp:DropDownList ID="ddlMachine" ClientIDMode="Static" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 select_width" runat="server">
                                                                        <asp:ListItem Value="zkbiotime">ZK Biotime</asp:ListItem>
                                                                        <asp:ListItem Value="ZK">ZK</asp:ListItem>
                                                                        <asp:ListItem Value="RMS">RMS</asp:ListItem>
                                                                        <asp:ListItem Value="HIKVISION">HIKVISION</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                                <div class="form-group">
                                                                    <label for="txtCompanyEmail" class="color-dark fs-14 fw-500 align-center mb-10">Email</label>
                                                                    <asp:TextBox ID="txtCompanyEmail" TextMode="Email" placeholder="company@gmail.com" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 text_box_width"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                                <div class="form-group">
                                                                    <label for="txtComments" class="color-dark fs-14 fw-500 align-center mb-10">Re-marks</label>
                                                                    <asp:TextBox ID="txtComments" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 text_box_width" TextMode="MultiLine"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                     <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                                <div class="form-group">
                                                                    <label for="rblCardNoType" class="color-dark fs-14 fw-500 align-center mb-10">Card No Type</label>
                                                                    <asp:RadioButtonList ID="rblCardNoType" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rblCardNoType_SelectedIndexChanged">
                                                                        <asp:ListItem Selected="True" Value="0">Flat</asp:ListItem>
                                                                        <asp:ListItem Value="1">Department Wise</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </div>
                                                            <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12" runat="server" id="tdFladCode">
                                                            <div class="form-group">
                                                            <label for="txtFladCode" class="color-dark fs-14 fw-500 align-center mb-10">Flat Code</label>
                                                            <asp:TextBox ID="txtFladCode" Font-Bold="true" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 text_box_width" Style="width: 25%; float: left; color: red;" MaxLength="2">99</asp:TextBox>
                                                            <asp:TextBox ID="txtStartCardNo" ClientIDMode="Static" Font-Bold="true" placeholder="Start Card No" runat="server" CssClass="form-control ih-medium ip-light radius-xs b-light px-15 text_box_width" Width="71%" MaxLength="5"></asp:TextBox>
                                                            </div>
                                                            </div>
                                                     <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                                                        <div style="text-align: center;">
                                                            <asp:Image ID="imgProfile" class="logo-defult-iamge" ClientIDMode="Static" runat="server" ImageUrl="~/images/profileImages/Logo.png" />
                                                            <asp:FileUpload ID="FileUpload2" Style="" runat="server" onchange="previewFile()" ClientIDMode="Static" />
                                                        </div>

                                                    </div>    
                                                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12" style="margin-top: -35px;">
                                                        <div>
                                                                <asp:Button ID="btnSave" ClientIDMode="Static" OnClientClick="return InputValidation();" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                        </div>

                                                    </div>
                                                        </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                
                                </div>




                                </div>
                </div>
                 </ContentTemplate>
    </asp:UpdatePanel>
                    </div>
                     <div class="crm mb-25">
                     <asp:UpdatePanel ID="UpdatePanel2" runat="server">   
                         <Triggers>
                          <asp:PostBackTrigger ControlID="btnSave" />
                         </Triggers>
                    <ContentTemplate>
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

                               <asp:GridView ID="gvCompanyInfo" runat="server" AutoGenerateColumns="False" Width="100%" AllowPaging="True" PageSize="5" DataKeyNames="ID,CompanyId" OnPageIndexChanging="gvCompanyInfo_PageIndexChanging" OnRowCommand="gvCompanyInfo_RowCommand" OnRowDataBound="gvCompanyInfo_RowDataBound" OnRowDeleting="gvCompanyInfo_RowDeleting" CssClass="gridview-bordered">

                                   <PagerStyle CssClass="gridview Sgridview" Height="40px" />
                                   <Columns>
                                       <asp:TemplateField HeaderText="SL">
                                           <ItemTemplate>
                                               <%# Container.DataItemIndex + 1 %>
                                           </ItemTemplate>
                                           <ItemStyle HorizontalAlign="Center" />
                                       </asp:TemplateField>
                                       <asp:BoundField DataField="CompanyId" HeaderText="CompanyId" Visible="false" />
                                       <asp:TemplateField HeaderText="Company">
                                           <ItemTemplate>
                                               <div style="display: flex; align-items: center;">
                                                   <img src='<%# "/EmployeeImages/CompanyLogo/" + Eval("CompanyLogo") %>'
                                                       alt="Logo" style="width: 40px; height: 40px; margin-right: 10px;" />
                                                   <div>
                                                    <span><%# Eval("CompanyName") %></span><br />
                                                   <span class="email"><%# Eval("Email") %></span>
                                                   </div>
                                                  
                                               </div>
                                           </ItemTemplate>
                                       </asp:TemplateField>
                                       <asp:BoundField
                                           DataField="Address"
                                           HeaderText="Address"
                                           HeaderStyle-HorizontalAlign="Left"
                                           ItemStyle-Width="300px"
                                           ItemStyle-Wrap="true"
                                           HeaderStyle-CssClass="address-header"
                                           ItemStyle-CssClass="address-item" />

                                       <asp:BoundField DataField="Country" ItemStyle-HorizontalAlign="Center" HeaderText="Country" Visible="true" />
                                       <asp:BoundField DataField="Telephone" ItemStyle-HorizontalAlign="Center" HeaderText="Phone" Visible="true" />
                                       <asp:BoundField DataField="StartCardNo" HeaderText="Card" ItemStyle-HorizontalAlign="Center" Visible="false" />
                                       <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Visible="true">
                                           <ItemTemplate>
                                               <%# 
            Convert.ToInt32(Eval("Status")) == 1 ? 
            "<span class='badge-leave bg-success'>Active</span>" :
            Convert.ToInt32(Eval("Status")) == 0 ? 
            "<span class='badge-leave bg-rejected'>Inactive</span>" :
            Convert.ToInt32(Eval("Status")) == 2 ? 
            "<span class='badge-leave bg-warning'>Expired</span>" :
            Convert.ToInt32(Eval("Status")) == 3 ? 
            "<span class='badge-leave bg-onlyme'>Suspended</span>" :
            ""
                                               %>
                                           </ItemTemplate>
                                       </asp:TemplateField>

                                       <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                           <HeaderTemplate>
                                               Action
                                           </HeaderTemplate>
                                           <ItemTemplate>
                                               <asp:LinkButton ID="btnAlter" runat="server" CssClass="" CommandName="Alter"
                                                   CommandArgument='<%# Container.DataItemIndex %>'>
                                                  <i  class="uil uil-edit"></i> 
                                               </asp:LinkButton>
                                               <asp:LinkButton ID="btnDelete" runat="server" CssClass="" CommandName="Delete"
                                                   OnClientClick="return confirm('Are you sure, you want to delete the record?');"
                                                   CommandArgument='<%# Container.DataItemIndex %>'>
                                                 <i class="uil uil-trash-alt"></i>
                                               </asp:LinkButton>
                                           </ItemTemplate>
                                       </asp:TemplateField>
                                          <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                           <HeaderTemplate>
                                                
                                           </HeaderTemplate>
                                           <ItemTemplate>
                                               <asp:Button ID="btnSrtupPackages" runat="server" ControlStyle-CssClass="btn btn-primary btn-sm" Text="Package" CommandName="Setup"
                                                   CommandArgument='<%# Container.DataItemIndex %>' />
                                           </ItemTemplate>
                                       </asp:TemplateField>
                                   </Columns>
                               </asp:GridView>
                           </div>
                        </div>

                     </div>
                  </div>
               </div>
            </div>
                   
               </ContentTemplate>
                    </asp:UpdatePanel>
             
                    </div>
            </div>
         </main>
     

     <script type="text/javascript">
        function previewFile() {
            try {
                var preview = document.querySelector('#imgProfile');
                var file = document.querySelector('#FileUpload2').files[0];

                var reader = new FileReader();

                reader.onloadend = function () {
                    preview.src = reader.result;
                }

                if (file) {
                    reader.readAsDataURL(file);
                } else {
                    preview.src = "";
                }
                var imagename = $('#FileUpload2').val();
                $('#HiddenField1').val(imagename);
            }
            catch (exception) {
                lblMessage.innerText = exception;
            }

        }
        function InputValidation() {
            var value = $('select#ddlCardNoDigit option:selected').val();
            if (validateText('txtCompanyName', 1, 100, "Please Enter Company Name") == false) return false;
            if (validateText('txtShortName', 3, 10, "Please Enter Sort Name of Company (Must be 3 Character)") == false) return false;
            //if (validateText('txtCompanyNameBangla', 1, 100, "Please Enter Company Name in Bangla") == false) return false;
            if (validateText('txtAddress', 1, 300, "Please Enter Company Address") == false) return false;
            //if (validateText('txtAddressBangla', 1, 100, "Please Enter Company Addrerss in Bangla") == false) return false;
            if (validateText('txtStartCardNo', value, value, "Enter Start Card Number (Must be " + value + " Character)") == false) return false;
            
            return true;
        }
        function Success()
        {
            showMessage('Successfully Saved','success');
        }
        function updSuccess()
        {
            showMessage('Successfully Update','success');
        }
        function delSuccess() {
            showMessage('Successfully Deleted','success');
        }
        function Warning() {
            showMessage('Frist Set a Head Office','warning');
        }
        //function AllClear()
        //{
        //    $("#txtCompanyName").val("");
        //    $("#txtShortName").val("");
        //    $("#txtAddress").val("");
        //    $("#txtAddressBangla").val("");
        //    $("#txtComments").val("");
        //    $("#txtCompanyId").val("");
        //    $("#txtCompanyNameBangla").val("");
        //    $("#txtCountry").val("");
        //    $("#txtFax").val("");
        //    $("#txtTelephone").val("");
        //    $("#txtStartCardNo").val("");
        //    $("#rblOfficeType").val('1');
        //    $("#txtCompanyName").val("");
        //}
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

</asp:Content>
