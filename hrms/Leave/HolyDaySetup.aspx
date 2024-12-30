<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="HolyDaySetup.aspx.cs" Inherits="SigmaERP.hrms.Leave.HolyDaySetup" %>


 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
        <style>
        #ContentPlaceHolder1_MainContent_gvHoliday th, td {
            text-align:center;
        }
         #ContentPlaceHolder1_MainContent_gvHoliday th:nth-child(2), td:nth-child(2) {
            text-align:left;
            padding-left:3px;
        }

            .uil-trash-alt {
                color: red;
                padding: 5px;
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

     <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">

    <Triggers>
    <asp:AsyncPostBackTrigger ControlID="btnSave" />
                            
    <asp:AsyncPostBackTrigger ControlID="ddlCompanyList" />
    </Triggers>
    <ContentTemplate>

    <div class="main_box Lbox">
    <div class="main_box_header_leave LBoxheader">
    <h2>Holiday Setting (Actual)</h2>
    </div>
    <div class="main_box_body_leave Lbody">
        <div class="main_box_content_leave" id="divElementContainer" runat="server">
    <div class="input_division_info">
        <div class="row">
            <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="form-group">

                    <label for="ddlCompanyList" class="color-dark fs-14 fw-500 align-center mb-10">Company Name<span class="requerd1">*</span></label>
                    <div class="support-form__input-id">
                      <div class="dm-select ">
                            <asp:DropDownList ID="ddlCompanyList" ClientIDMode="Static" CssClass="form-control select_width" Width="96%" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCompanyList_SelectedIndexChanged">
                        </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="form-group">

                    <label for="ddlCompanyList" class="color-dark fs-14 fw-500 align-center mb-10">Date<span class="requerd1">*</span></label>
                    <div class="support-form__input-id">
                        
                            <asp:TextBox ID="txtDate" ClientIDMode="Static" runat="server" Width="96%" CssClass="form-control text_box_width" autocomplete="off"></asp:TextBox>
                            <asp:CalendarExtender runat="server" Format="dd-MM-yyyy"
                                PopupButtonID="imgDate" Enabled="True"
                                TargetControlID="txtDate" ID="CExtApplicationDate">
                            </asp:CalendarExtender>

                     <%--       <asp:RegularExpressionValidator ID="RegularExpressionValida" runat="server"
                                ControlToValidate="txtDate" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/((0[1-9])|([1-31]))\/((19|20)\d\d)$" Display="Dynamic" ValidationGroup="save" SetFocusOnError="true" ErrorMessage="invalid date">*</asp:RegularExpressionValidator>--%>

                    </div>
                </div>
            </div>
             <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="form-group">

                    <label for="ddlCompanyList" class="color-dark fs-14 fw-500 align-center mb-10">Description<span class="requerd1">*</span></label>
                    <div class="support-form__input-id">
                        
                         <asp:TextBox ID="txtDescription" ClientIDMode="Static" runat="server" Width="96%" CssClass="form-control text_box_width" autocomplete="off"></asp:TextBox>
                        <asp:RequiredFieldValidator ForeColor="Red" ValidationGroup="save" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDescription" ErrorMessage="*"></asp:RequiredFieldValidator>

                        
                    </div>
                </div>
            </div>

                         <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="form-group">

                    <label for="ddlCompanyList" style="visibility:hidden" class="color-dark fs-14 fw-500 align-center mb-10"><span class="requerd1"></span>Save</label>
                    <div class="support-form__input-id">
       <asp:Button ID="btnSave" CssClass="btn btn-primary btn-default btn-squared px-30 m-2" ValidationGroup="save" runat="server" Text="Save" OnClick="btnSave_Click" />
                    </div>
                </div>
            </div>
        </div>
  
        </div>

        <div class="show_division_info">
            <%--<div id="ShiftConfig" class="datatables_wrapper" runat="server" style="width:100%; height:auto; max-height:500px;overflow:auto;overflow-x:hidden;"></div>--%>
            <asp:GridView ID="gvHoliday" runat="server" Width="100%" AutoGenerateColumns="false" DataKeyNames="HCode"  HeaderStyle-Height="28px" HeaderStyle-Font-Bold="true" OnPageIndexChanging="gvHoliday_PageIndexChanging" OnRowCommand="gvHoliday_RowCommand" OnRowDeleting="gvHoliday_RowDeleting" AllowPaging="True" PageSize="20" OnRowDataBound="gvHoliday_RowDataBound" CssClass="gridview-bordered">
                <RowStyle HorizontalAlign="Center" />
                <PagerStyle CssClass="gridview" />
                <Columns>

                    <asp:BoundField DataField="HDate" HeaderText="Date" ItemStyle-Height="28px" />

                    <asp:BoundField DataField="Description" HeaderText="Description" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <%--<asp:Button ID="btnAlter" runat="server" CommandName="Alter" ControlStyle-CssClass="btnForAlterInGV"  CommandArgument="<%#((GridViewRow)Container).RowIndex%>" Text="Edit"  />--%>

                            <!-- LinkButton for Alter -->
                            <asp:LinkButton
                                ID="lnkAlter"
                                runat="server"
                                CommandName="Alter"
                                CssClass="edit-btn edit"
                                CommandArgument="<%# ((GridViewRow)Container).RowIndex %>">
    <i class="uil uil-edit"></i>
                            </asp:LinkButton>

                            <!-- LinkButton for Delete -->
                            <asp:LinkButton
                                ID="lnkDelete"
                                runat="server"
                                CommandName="Delete"
                                CssClass="delete-btn remove"
                                CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                OnClientClick="return confirm('Are you sure to delete?');">
    <i class="uil uil-trash-alt"></i>
                            </asp:LinkButton>

                        </ItemTemplate>
                    </asp:TemplateField>

<%--                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" CommandName="Delete" ControlStyle-CssClass="btnForDeleteInGV" CommandArgument="<%#((GridViewRow)Container).RowIndex%>" Text="Delete"  OnClientClick="return confirm('Are you sure to delete?');" />
                        </ItemTemplate>

                    </asp:TemplateField>--%>

                </Columns>
                <HeaderStyle BackColor="#5EC1FF" Height="28px" />
            </asp:GridView>

        </div>


    </div>
    </div>
    </div>
     </ContentTemplate>
      </asp:UpdatePanel>

</asp:Content>
