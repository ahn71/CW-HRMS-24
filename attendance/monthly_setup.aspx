<%@ Page Title="Month Setup" Language="C#" MasterPageFile="~/attendance_nested.Master" AutoEventWireup="true" CodeBehind="monthly_setup.aspx.cs" Inherits="SigmaERP.attendance.monthly_setup" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
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

            function Cardbox() {
                var CardboxElement = $("#Cardbox");
                var addnewElement = $("#addnew");

                if (addnewElement.html() === "Add New") {
                    CardboxElement.show();

                    addnewElement.text("Close");
                } else {
                    CardboxElement.hide();
                    addnewElement.html("Add New");

                }
            }

        </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.1/css/bootstrap-grid.min.css" integrity="sha512-Aa+z1qgIG+Hv4H2W3EMl3btnnwTQRA47ZiSecYSkWavHUkBF2aPOIIvlvjLCsjapW1IfsGrEO3FU693ReouVTA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        #ContentPlaceHolder1_MainContent_gvMonthSetup th {
            text-align:center;
        }
        .popup_submit {
        background: #f5f5f5;
        padding: 14px 0;
        text-align: center;
        position: sticky;
        bottom: -5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div style="align-items:center; padding:25px 0" class="row align-items-center Rrow">
         <div class="col-md-6">
             <div class="title-header">
                 <h2 style="margin:0" class="m-0">Attendance</h2>
             </div>
         </div>
        <div class="col-md-6 ds_nagevation_bar">
            <div style="margin-top: 0">
                <ul>
                    <li><a href="/default.aspx">Dashboard</a></li>
                    <li>/</li>
                   <li><a href="<%=  Session["__topMenu__"] %>">Attendance</a></li>
                    <li>/</li>
                    <li><a href="#" class="ds_negevation_inactive Mactive">Month Setup</a></li>
                </ul>
            </div>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate><p class="message"  id="lblMessage" clientidmode="Static" runat="server"></p></ContentTemplate>
</asp:UpdatePanel>


    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <Triggers>
           
            <asp:AsyncPostBackTrigger ControlID="hdMonthSetup" />
            <asp:AsyncPostBackTrigger ControlID="btnSave" />
            <asp:AsyncPostBackTrigger ControlID="gvMonthSetup" />
            <asp:AsyncPostBackTrigger ControlID="btnClear" />
            <asp:AsyncPostBackTrigger ControlID="ddlCompanyList" />
        </Triggers>
        <ContentTemplate>


            <div class="main_box m-0 Mbox"  >

                <div class="btn-wrapper mb-2">
                    <div class="dm-button-list d-flex flex-wrap justify-content-end">
                        <button type="button" id="addnew" onclick="Cardbox();" class="btn btn-secondary btn-default btn-squared">Add New</button>
                    </div>
                </div>

                <div class="main_box_body Mbody" style="display: none;" id="Cardbox">
                    <div class="main_box_content mb-5">
                      
                            <div class="row">
                                    <asp:HiddenField ID="hdMonthSetup" ClientIDMode="Static" runat="server" Value="" />


                            <div class="col-lg-3">
                                <p>Company<span class="requerd1">*</span></p>
                                 <asp:DropDownList ID="ddlCompanyList" runat="server" ClientIDMode="Static"  CssClass="form-control select_width" AutoPostBack="True" OnSelectedIndexChanged="ddlCompanyList_SelectedIndexChanged" >
                               </asp:DropDownList>
                            </div>

                            <div class="col-lg-3">
                                <p>Month<span class="requerd1">*</span></p>
                                 <asp:TextBox ID="txtMonthName" runat="server"  ClientIDMode="Static" CssClass="form-control text_box_width" autocomplete="off"></asp:TextBox>

                                 <asp:CalendarExtender ID="txtMonthName_CalendarExtender" Format="MM-yyyy" runat="server" TargetControlID="txtMonthName">
                                        </asp:CalendarExtender>

                            </div>


                            <div class="col-lg-3">
                               <p>From Date<span class="requerd1">*</span></p> 
                                 <asp:TextBox ID="txtFromDate" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width" autocomplete="off"></asp:TextBox>

                                        <asp:CalendarExtender ID="txtFromDate_CalendarExtender" Format="dd-MM-yyyy" runat="server" TargetControlID="txtFromDate">
                                        </asp:CalendarExtender>
                            </div>

                            <div class="col-lg-3">
                                <td>To Date<span class="requerd1">*</span>
                                    <asp:TextBox ID="txtToDate" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width" autocomplete="off"></asp:TextBox>
                                       
                                        <asp:CalendarExtender ID="txtToDate_CalendarExtender" Format="dd-MM-yyyy" runat="server" TargetControlID="txtToDate">
                                        </asp:CalendarExtender>
                                       <div style="transform: translate(-3px, -37px);" class="d-flex justify-content-end">
                                           <asp:Button ID="btnCalculation" runat="server" CssClass="btn btn-success"  Text="Calculation" OnClick="btnCalculation_Click" />
                                       </div>
                                        
                            </div>

                            <div class="col-lg-3">
                               <p>Total No of Days</p> 
                                 <asp:TextBox ID="txtTotalNOofDay" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                              <p>Total Weekend</p>  
                                 <asp:TextBox ID="txtTotalWeekend" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width" Enabled="false"></asp:TextBox>
                            </div>

                            <div class="col-lg-3">
                                <p>Total Holiday</p>
                                <asp:TextBox ID="txtTotalHoliday" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width" ></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <p>Total Working Days</p>
                                <asp:TextBox ID="txtTotalWorkingDays" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width"></asp:TextBox>
                            </div>


<div class="col-lg-3">
                              <p>Expected Payment Date<span class="requerd1">*</span></p>  
                                <asp:TextBox ID="txtExpectedPaymetnDate" ClientIDMode="Static" runat="server" CssClass="form-control text_box_width" autocomplete="off"></asp:TextBox>
                                       
                                        <asp:CalendarExtender ID="txtExpectedPaymetnDate_CalendarExtender" runat="server" TargetControlID="txtExpectedPaymetnDate" Format="dd-MM-yyyy">
                                        </asp:CalendarExtender>
                            </div>

                            <div class="col-lg-3">
                              <p>Month Status<span class="requerd1">*</span></p>  
                                <asp:DropDownList ID="ddlMonthStatus" CssClass="form-control text_box_width" runat="server" >
                                            <asp:ListItem Value="0" Text=" "></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Inactive"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ForeColor="Red" ValidationGroup="save" ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlMonthStatus" ErrorMessage="*"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-lg-3">
                                 <p style="opacity:0">Month Status<span class="requerd1">*</span></p>  
                                   <div class="Rbutton_area" style="text-align:start">                           
                            <asp:Button ID="btnShow" CssClass="Mbutton" runat="server" Text="List All" Visible="False" />
                            <asp:Button ID="btnSave" CssClass="Mbutton" ValidationGroup="save" runat="server" Text="Save" OnClick="btnSave_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="Mbutton" OnClick="btnClear_Click" />
                            <asp:Button ID="Button3" runat="server" Text="Close" PostBackUrl="~/attendance_default.aspx" CssClass="Mbutton" />
                            <asp:Button ID="btnPopup" runat="server" Text="Close"  style="display:none" CssClass="Mbutton" />                          
                        </div> 
                            </div>

                        </div>


                    </div>
                </div>
            </div>


            <%--Table--%>
             <div class="dataTables_wrapper monthly_table_setup show_division_info ">
                            <asp:GridView ID="gvMonthSetup" runat="server" AutoGenerateColumns="False" DataKeyNames="MonthId" HeaderStyle-BackColor="#0057AE"
                                CellPadding="4" AllowPaging="True" ForeColor="#333333" Width="100%"
                                PageSize="12" OnRowCommand="gvMonthSetup_RowCommand" OnRowDeleting="gvMonthSetup_RowDeleting" OnRowEditing="gvMonthSetup_RowEditing" OnPageIndexChanging="gvMonthSetup_PageIndexChanging" OnRowDataBound="gvMonthSetup_RowDataBound">
                                <AlternatingRowStyle BackColor="White" />
                                <PagerStyle CssClass="gridview" />
                                <RowStyle HorizontalAlign="Center" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Month">
                                        <ItemTemplate>
                                            <asp:Label ID="lblMonthName" runat="server" Text='<%# Eval("MonthName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="From">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFromDate" runat="server" Text='<%# Eval("FromDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="To">
                                        <ItemTemplate>
                                            <asp:Label ID="lblToDate" runat="server" Text='<%# Eval("ToDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Total">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalDays" runat="server" Text='<%# Eval("TotalDays") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Holiday">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalHoliday" runat="server" Text='<%# Eval("TotalHoliday") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Working">
                                        <ItemTemplate >
                                            <asp:Label ID="lblTotalWorkingDays" runat="server" Text='<%# Eval("TotalWorkingDays") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    

                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                    <%--                        <asp:Button ID="lnkEdit" runat="server" Font-Bold="true" Text="Edit" CommandName="Edit"   ControlStyle-CssClass="btnForAlterInGV"  CommandArgument='<%#((GridViewRow)Container).RowIndex %>' />--%>

                                            <asp:LinkButton
                                                ID="lnkEdit"
                                                runat="server"
                                                Font-Bold="true"
                                                CommandName="Edit"
                                                CssClass="btnForAlterInGV action-btn"
                                                CommandArgument='<%# ((GridViewRow)Container).RowIndex %>'>
                                          <i class="fa fa-edit"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton
                                                ID="lnkDelete"
                                                runat="server"
                                                CommandName="Delete"
                                                CssClass="btnForDeleteInGV action-btn"
                                                CommandArgument='<%# Eval("MonthID") %>'
                                                OnClientClick="return confirm('Are you sure you want to delete the record?');">
                                                <i class="fa fa-trash"></i>
                                            </asp:LinkButton>



                                        </ItemTemplate>
                                    </asp:TemplateField>

<%--                                    <asp:TemplateField HeaderText="Delete">
                                        <ItemTemplate>
                                          <asp:Button ID="lnkDelete" runat="server" Text="Delete" CommandName="Delete" ControlStyle-CssClass="btnForDeleteInGV"  
                                                OnClientClick="return confirm('Are you sure, you want to delete the record?')"
                                                CommandArgument='<%# Eval("MonthID") %>' />

                                            <asp:LinkButton
                                                ID="lnkDelete"
                                                runat="server"
                                                CommandName="Delete"
                                                CssClass="btnForDeleteInGV"
                                                CommandArgument='<%# Eval("MonthID") %>'
                                                OnClientClick="return confirm('Are you sure you want to delete the record?');">
                                              <i class="fa fa-trash"></i>
                                            </asp:LinkButton>

                                        </ItemTemplate>
                                    </asp:TemplateField>--%>


                                </Columns>
                          
                                <%--  <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />--%>
                                <HeaderStyle BackColor="#2b5e4e" Height="28px" Font-Bold="True" ForeColor="White" />
                                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                                 <%-- <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#E3EAEB" />
                               
                             <%--   <SortedAscendingCellStyle BackColor="#F8FAFA" />
                                <SortedAscendingHeaderStyle BackColor="#246B61" />
                                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                                <SortedDescendingHeaderStyle BackColor="#15524A" /--%>
                            </asp:GridView>
                            <%--<div runat="server" id="divPunismentList" style="width: 500px; height: 599px;"></div>--%>
                        </div>
            <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Drag="True" 
                            DropShadow="True" PopupControlID="PopupWindow" TargetControlID="btnPopup" CancelControlID="btnCancel" PopupDragHandleControlID="divDrag" CacheDynamicResults="False" Enabled="True" >
                        </asp:ModalPopupExtender>

                        <div style="border-radius: 5px;  border: 2px solid #086A99;border-top:0px; font-weight:bold; height:350px; overflow-y:auto; background:#ddd;padding:5px;" id="PopupWindow" >
                            <div id="divDrag" class="boxFotter">
                                 <a ID="btnCancel" href="#"><img class="popup_close" src="../images/icon/cancel.png" alt="" style=" display:none" /></a>
                           <cnter> 
                                <h2 style="margin-top: -3px;">Weekend Date</h2>
                           </cnter>
                                
                             </div>

                            <asp:Panel ID="Panel1" runat="server" BackColor="WhiteSmoke" >

                             <asp:GridView runat="server" ID="gvWeekendDate" AutoGenerateColumns="false"  HeaderStyle-BackColor="Black" HeaderStyle-ForeColor="White" >
                                 <Columns>
                                     <asp:BoundField HeaderText="Date" DataField="WDate" HeaderStyle-BackColor="Black" HeaderStyle-ForeColor="White" />
                                     <asp:BoundField HeaderText="Day" DataField="WDay" HeaderStyle-BackColor="Black" HeaderStyle-ForeColor="White"  />
                                     <asp:TemplateField AccessibleHeaderText="Choose" HeaderText="Chosen"  ItemStyle-HorizontalAlign="center">
                                         <ItemTemplate  >
                                             <asp:CheckBox ID="SelectCheckBox" runat="server"  Checked="false" />
                                           

                                         </ItemTemplate>
                                     </asp:TemplateField>
                                 </Columns>
                             </asp:GridView><br />
                                <div class="popup_submit">
                                    <asp:Button ID="btnSubmit" Width="80px" Text="OK" runat="server" OnClick="btnSubmit_Click" />
                                </div>
                                <br />
                           </asp:Panel>
                          

                          
                           
                        </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
