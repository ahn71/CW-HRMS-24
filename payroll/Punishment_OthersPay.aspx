<%@ Page Title="Punishment and Other's Pay" Language="C#" MasterPageFile="~/payroll_nested.master" AutoEventWireup="true" CodeBehind="Punishment_OthersPay.aspx.cs" Inherits="SigmaERP.payroll.Punishment_OthersPay" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<script src="../scripts/jquery-1.8.2.js"></script>--%>
    <!-- SheetJS: client-side Excel reader (used by the Adjustment-tab Excel import) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

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
        /* ============ Adjustment / Other's Pay - Modern Design ============ */

        .Mbox.PBoxheader-wrap {
            border-radius: 12px;
            overflow: hidden;
        }

        .PBoxheader {
            background: linear-gradient(135deg, #ffa500, #ff8c00) !important;
            border-radius: 10px 10px 0 0;
        }

            .PBoxheader h2 {
                color: #ffffff !important;
                font-weight: 600;
                font-size: 19px;
                margin: 0;
                padding: 4px 0;
                letter-spacing: 0.3px;
            }

        .Pbody {
            background: #ffffff;
            border-radius: 0 0 12px 12px;
            padding: 10px 6px 20px 6px;
        }

        /* Tab container look - full reset so header doesn't collapse/overflow below */
        .fancy-green.ajax__tab_container {
            width: 100% !important;
        }

        .fancy-green .ajax__tab_header {
            width: 100% !important;
            height: auto !important;
            background: transparent !important;
            border: none !important;
            border-bottom: 2px solid #ffe3b0 !important;
            margin: 0 0 18px 0 !important;
            padding: 0 !important;
        }

        .fancy-green .ajax__tab_outer {
            width: 100% !important;
            height: auto !important;
        }

        .fancy-green .ajax__tab_body {
            border: none !important;
            padding: 0 !important;
        }

        /* the <ul> that holds the tab items */
        .fancy-green .ajax__tab_header ul {
            display: flex !important;
            flex-wrap: wrap !important;
            list-style: none !important;
            margin: 0 !important;
            padding: 0 !important;
            float: none !important;
            width: auto !important;
        }

            .fancy-green .ajax__tab_header ul li {
                display: block !important;
                float: none !important;
                width: auto !important;
                height: auto !important;
                background: none !important;
                border: none !important;
                margin: 0 6px 0 0 !important;
                padding: 0 !important;
            }

        .fancy-green .ajax__tab_tab {
            display: block !important;
            box-sizing: border-box !important;
            font-weight: 600 !important;
            font-size: 14px !important;
            padding: 12px 24px !important;
            color: #718096 !important;
            background: #f7fafc !important;
            border: 1px solid transparent !important;
            border-bottom: 3px solid transparent !important;
            border-radius: 8px 8px 0 0 !important;
            white-space: nowrap !important;
            cursor: pointer;
            transition: color 0.2s ease-in-out, background-color 0.2s ease-in-out, border-color 0.2s ease-in-out;
        }

            .fancy-green .ajax__tab_tab:hover {
                color: #ff8c00 !important;
                background: #fff6e6 !important;
            }

        .fancy-green .ajax__tab_active .ajax__tab_tab,
        .fancy-green .ajax__tab_active a.ajax__tab_tab {
            color: #ff8c00 !important;
            background: #ffffff !important;
            border: 1px solid #ffd699 !important;
            border-bottom: 3px solid #ff8c00 !important;
        }

        .fancy-green .ajax__tab_hover .ajax__tab_tab {
            color: #ff8c00 !important;
        }

        /* Keep content area from collapsing/jumping while the UpdatePanel
           reloads on tab switch (AutoPostBack) */
        .fancy-green .ajax__tab_body {
            min-height: 420px !important;
        }

        /* Message/alert bar - convert to a fixed toast so it doesn't push
           the tab/button/input content up-down when it shows or hides
           during an async postback (this was the main cause of the shake) */
        .message {
            position: fixed !important;
            top: 18px !important;
            right: 18px !important;
            left: auto !important;
            z-index: 9999 !important;
            max-width: 380px !important;
            margin: 0 !important;
            min-height: 0 !important;
        }

            .message:empty {
                display: none !important;
            }

        /* Reserve stable space for the form + buttons so an async postback
           (tab click, dropdown change, submit) can't collapse/expand the
           box and make the content appear to jump */
        .adj-form-grid {
            min-height: 92px;
        }

        .em_button_table_wrap {
            min-height: 46px;
        }

        /* Prevent the browser from auto-scrolling to compensate for any
           residual height change above the fold during partial postbacks */
        html {
            overflow-anchor: none;
        }

        /* Some skins render tab text inside nested spans/divs that force a fixed
           small height, causing the label to wrap and spill below the tab box */
        .fancy-green .ajax__tab_tab span,
        .fancy-green .ajax__tab_tab div {
            display: inline !important;
            height: auto !important;
            line-height: normal !important;
            padding: 0 !important;
            margin: 0 !important;
            background: none !important;
            float: none !important;
        }

        /* ---- Form grid (row/column based input layout) ---- */
        .adj-form-grid {
            display: flex;
            flex-wrap: wrap;
            margin: 18px -12px 8px -12px;
        }

            .adj-form-grid .form-col {
                box-sizing: border-box;
                padding: 0 12px;
                margin-bottom: 20px;
                width: 33.333%;
            }

        @media (max-width: 992px) {
            .adj-form-grid .form-col {
                width: 50%;
            }
        }

        @media (max-width: 600px) {
            .adj-form-grid .form-col {
                width: 100%;
            }
        }

        .adj-form-grid .form-label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        .adj-form-grid .form-field-wrap {
            position: relative;
        }

        .adj-form-grid .form-control,
        .adj-form-grid .select_width,
        .adj-form-grid .text_box_width {
            width: 100% !important;
            border: 1.5px solid #e2e8f0 !important;
            border-radius: 8px !important;
            padding: 6px 12px !important;
            font-size: 14px !important;
            color: #2d3748 !important;
            background-color: #f9fafb !important;
            transition: all 0.2s ease-in-out;
            box-sizing: border-box;
        }

            .adj-form-grid .form-control:focus,
            .adj-form-grid .select_width:focus,
            .adj-form-grid .text_box_width:focus {
                border-color: #ffa500 !important;
                background-color: #ffffff !important;
                box-shadow: 0 0 0 3px rgba(255,165,0,0.15) !important;
                outline: none !important;
            }

        .adj-form-grid .radio-inline-group {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 9px 2px;
        }

            .adj-form-grid .radio-inline-group input[type="radio"] {
                accent-color: #ffa500;
                width: 16px;
                height: 16px;
                margin-right: 6px;
                cursor: pointer;
                vertical-align: middle;
            }

            .adj-form-grid .radio-inline-group label {
                font-size: 14px;
                color: #2d3748;
                cursor: pointer;
                margin: 0;
            }

        .adj-form-grid .checkbox-row {
            display: flex;
            align-items: center;
            padding: 9px 2px;
        }

            .adj-form-grid .checkbox-row input[type="checkbox"] {
                accent-color: #ffa500;
                width: 18px;
                height: 18px;
                cursor: pointer;
            }

        /* Buttons */
        .em_button_table_wrap {
            margin: 6px 0 26px 0;
            display: flex;
            gap: 12px;
        }

        .Pbutton {
            border: none !important;
            border-radius: 8px !important;
            padding: 10px 26px !important;
            font-size: 14px !important;
            font-weight: 600 !important;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
        }

            .Pbutton.btn-primary-adj {
                background: linear-gradient(135deg, #ffa500, #ff8c00) !important;
                color: #ffffff !important;
                box-shadow: 0 3px 10px rgba(255,140,0,0.3);
            }

                .Pbutton.btn-primary-adj:hover {
                    background: linear-gradient(135deg, #ff9800, #f57c00) !important;
                    transform: translateY(-1px);
                    box-shadow: 0 5px 14px rgba(255,140,0,0.4);
                }

            .Pbutton.btn-secondary-adj {
                background: #edf2f7 !important;
                color: #4a5568 !important;
                border: 1.5px solid #e2e8f0 !important;
            }

                .Pbutton.btn-secondary-adj:hover {
                    background: #e2e8f0 !important;
                }

        /* GridView */
        .gvdisplay1 {
            width: 100% !important;
            border-collapse: collapse !important;
            border-radius: 10px;
            overflow: hidden;
            font-size: 13.5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }

            .gvdisplay1 th {
                background: linear-gradient(135deg, #ffa500, #ff8c00) !important;
                color: #ffffff !important;
                font-weight: 600 !important;
                height: 40px !important;
                padding: 8px 10px !important;
                text-align: center;
            }

            .gvdisplay1 td {
                padding: 2px 10px !important;
                border-bottom: 1px solid #edf2f7 !important;
                color: #2d3748;
            }

            .gvdisplay1 tr:nth-child(even) td {
                background-color: #f9fafb;
            }

            .gvdisplay1 tr:hover td {
                background-color: #fff6e6;
            }

            .gvdisplay1 a {
                text-decoration: none;
                padding: 4px 10px;
                border-radius: 6px;
                font-size: 13px;
            }

        /* Combined Action column - icon buttons */
        .action-cell {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .action-icon-btn {
            display: inline-flex !important;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            border-radius: 8px;
            text-decoration: none !important;
            transition: all 0.15s ease-in-out;
            font-size: 14px !important;
        }

            .action-icon-btn.edit-icon {
                background: #e6fffa;
                color: #16a34a !important;
            }

                .action-icon-btn.edit-icon:hover {
                    background: #16a34a;
                    color: #ffffff !important;
                    transform: translateY(-1px);
                }

            .action-icon-btn.delete-icon {
                background: #fef2f2;
                color: #e53e3e !important;
            }

                .action-icon-btn.delete-icon:hover {
                    background: #e53e3e;
                    color: #ffffff !important;
                    transform: translateY(-1px);
                }

            .action-icon-btn svg {
                width: 16px;
                height: 16px;
                fill: currentColor;
                pointer-events: none;
            }

        /* Navigation bar */
        .ds_nagevation_bar ul {
            display: flex;
            gap: 6px;
            list-style: none;
            padding: 10px 4px;
            margin: 0;
            font-size: 13.5px;
            color: #718096;
        }

            .ds_nagevation_bar ul li a {
                color: #718096;
                text-decoration: none;
            }

                .ds_nagevation_bar ul li a.Pactive,
                .ds_nagevation_bar ul li a:hover {
                    color: #ff8c00;
                    font-weight: 600;
                }

        /* ============ Excel Import (Adjustment tab) - compact, inline with buttons ============ */
        .adj-excel-inline {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-left: auto;
            padding-left: 12px;
            border-left: 1.5px solid #e2e8f0;
        }

            .adj-excel-inline input[type="file"] {
                font-size: 12px;
                max-width: 190px;
            }

        .adj-btn-sm {
            padding: 7px 18px !important;
            font-size: 13px !important;
        }

        /* Popup modal (shared: error/success + excel preview) */
        .adj-modal-overlay {
            display: none;
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            right: 0 !important;
            bottom: 0 !important;
            width: 100vw !important;
            height: 100vh !important;
            margin: 0 !important;
            background: rgba(0, 0, 0, 0.45);
            z-index: 99999;
            align-items: center !important;
            justify-content: center !important;
        }

            .adj-modal-overlay.show {
                display: flex !important;
            }

        /* Excel preview modal (bigger box) */
        .adj-preview-box {
            background: #fff;
            border-radius: 12px;
            max-width: 950px;
            width: 95%;
            max-height: 85vh;
            padding: 20px 24px;
            margin: 0 !important;
            box-shadow: 0 10px 35px rgba(0,0,0,0.25);
            text-align: left;
            display: flex;
            flex-direction: column;
        }

        .adj-preview-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

            .adj-preview-header .adj-preview-title {
                font-size: 17px;
                font-weight: 600;
                color: #2d3748;
            }

        .adj-preview-close {
            background: none;
            border: none;
            font-size: 22px;
            cursor: pointer;
            color: #888;
            line-height: 1;
        }

            .adj-preview-close:hover {
                color: #333;
            }

        .adj-preview-body {
            overflow-y: auto;
        }

        .adj-missing-msg {
            color: #b45309;
            background: #fffbeb;
            border: 1px solid #fde68a;
            border-radius: 6px;
            padding: 8px 10px;
            font-size: 13px;
            margin-bottom: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-12">
            <div class="ds_nagevation_bar">
                <ul>
                    <li><a href="/default.aspx">Dasboard</a></li>

                    <li><a class="seperator" href="#">/</a></li>
                    <li><a href="/payroll/salary_index.aspx">Salary</a></li>
                    <li><a class="seperator" href="#">/</a></li>
                    <li><a href="#" class="ds_negevation_inactive Pactive">Adjustment Panel</a></li>
                </ul>
            </div>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="uplMessage" runat="server">
        <ContentTemplate>
            <p class="message" id="lblMessage" clientidmode="Static" runat="server"></p>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>


            <div class="main_box Mbox">
                <div class="main_box_header PBoxheader">
                    <h2>Adjustment Panel</h2>
                </div>
                <div class="main_box_body Pbody">
                    <div class="main_box_content">
                        <%--<input type="text" class="form-control" visible="false" id="txtFinding" runat="server" style="margin-left: 0px; width: 99%; text-align:center"  placeholder="Search by anythings" />--%>
                        <div class="em_personal_info" id="divEmpPersonnelInfo" style="margin: 0px">

                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                <Triggers>
                                </Triggers>
                                <ContentTemplate>

                                    <asp:TabContainer ID="tc1" runat="server" CssClass="fancy fancy-green" AutoPostBack="true" OnActiveTabChanged="tc1_ActiveTabChanged" ActiveTabIndex="0">
                                        <asp:TabPanel runat="server" TabIndex="0" ID="tab1" HeaderText="Adjustment">
                                            <ContentTemplate>
                                                <asp:UpdatePanel runat="server" ID="up1" UpdateMode="Conditional">
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddlEmpCardNo" />
                                                        <asp:AsyncPostBackTrigger ControlID="ddlCompanyList" />

                                                        <asp:AsyncPostBackTrigger ControlID="btnSave" />
                                                        <asp:AsyncPostBackTrigger ControlID="btnAdjImportSubmit" />

                                                    </Triggers>
                                                    <ContentTemplate>

                                                        <div class="adj-form-grid">

                                                            <div class="form-col">
                                                                <span class="form-label">Company</span>
                                                                <div class="form-field-wrap">
                                                                    <asp:DropDownList ID="ddlCompanyList" runat="server" OnSelectedIndexChanged="ddlCompanyList_SelectedIndexChanged" ClientIDMode="Static" AutoPostBack="true" CssClass="form-control select_width">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>

                                                            <div class="form-col">
                                                                <span class="form-label">Card No</span>
                                                                <div class="form-field-wrap">
                                                                    <asp:DropDownList runat="server" ID="ddlEmpCardNo" ClientIDMode="Static" AutoPostBack="false" CssClass="form-control select_width"></asp:DropDownList>
                                                                </div>
                                                            </div>

                                                            <div class="form-col">
                                                                <span class="form-label">Adjustment Type</span>
                                                                <div class="form-field-wrap radio-inline-group">
                                                                    <asp:RadioButtonList runat="server" ID="rdType" RepeatDirection="Horizontal">
                                                                        <asp:ListItem Value="Addition">Addition</asp:ListItem>
                                                                        <asp:ListItem Value="Deduction">Deduction</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </div>

                                                            <div class="form-col">
                                                                <span class="form-label">Purpose Name</span>
                                                                <div class="form-field-wrap">
                                                                    <asp:DropDownList runat="server" ID="ddlPurpuse" CssClass="form-control">
                                                                        <asp:ListItem Value="Mobile Bill deduction">Mobile bill Deduction</asp:ListItem>
                                                                        <asp:ListItem Value="Retrun percel deduction">Retrun percel Deduction</asp:ListItem>
                                                                        <asp:ListItem Value="Others Ddeduction">Others Ddeduction</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>

                                                            <div class="form-col">
                                                                <span class="form-label">Amount</span>
                                                                <div class="form-field-wrap">
                                                                    <asp:TextBox ID="txtPAmount" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width">0</asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="form-col">
                                                                <span class="form-label">Month Name</span>
                                                                <div class="form-field-wrap">
                                                                    <asp:TextBox ID="txtmonthname" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width"></asp:TextBox>
                                                                    <asp:CalendarExtender ID="CalendarExtender3" Format="MM-yyyy" runat="server" TargetControlID="txtmonthname"></asp:CalendarExtender>
                                                                </div>
                                                            </div>

                                                        </div>

                                                        <div class="em_button_table_wrap">

                                                            <%--  <asp:Button ID="btnNew" Class="Pbutton" runat="server" Text="New" />   --%>

                                                            <asp:Button ID="btnSave" CssClass="Pbutton btn-primary-adj" ClientIDMode="Static" runat="server" OnClientClick="return validateInputspunishment();" Text="Submit" OnClick="btnSave_Click" />

                                                            <asp:Button ID="btnClose" CssClass="Pbutton btn-secondary-adj" runat="server" Text="Close" PostBackUrl="/payroll/salary_index.aspx" />

                                                            <span class="adj-excel-inline">
                                                                <input type="file" id="fuAdjExcel" accept=".xlsx,.xls" />
                                                                <button type="button" id="btnAdjLoad" class="Pbutton btn-secondary-adj adj-btn-sm">Import Excel</button>
                                                            </span>

                                                            <asp:HiddenField ID="hdnAdjImportJson" runat="server" ClientIDMode="Static" />
                                                            <asp:Button ID="btnAdjImportSubmit" runat="server" ClientIDMode="Static" Text="ImportSubmit" style="display:none;" OnClick="btnAdjImportSubmit_Click" />

                                                        </div>

                                                        <asp:GridView runat="server" ID="gvpunishment" CssClass="gvdisplay1" DataKeyNames="PSN,CompanyId,EmpId" AutoGenerateColumns="false" HeaderStyle-BackColor="#ffa500" HeaderStyle-Height="28px" HeaderStyle-ForeColor="White" PageSize="25" Width="100%" OnRowCommand="gvpunishment_RowCommand">
                                                            <Columns>
                                                               <asp:BoundField DataField="CompanyName" HeaderText="Company" ItemStyle-HorizontalAlign="Center"  Visible="false" />
                                                                <asp:TemplateField HeaderText="Emp Card No">
                                                                    <ItemTemplate>
                                                                        <%# Eval("EmpCardNo").ToString().Length >= 13
                                                                       ? Eval("EmpCardNo").ToString().Substring(7, 6) + "(" + Eval("EmpProximityNo") + ")"
                                                                       : Eval("EmpCardNo") + "(" + Eval("EmpProximityNo") + ")" %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="EmpName" HeaderStyle-HorizontalAlign="Left" HeaderText="Name" />
                                                                <asp:BoundField DataField="PName" HeaderText="Adjusmtment Name" ItemStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="AdjustmentType" HeaderText="Adjusmtment Type" ItemStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="PAmount" HeaderText="Adjusmtment Amount" ItemStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="MonthName" HeaderText="Month"  DataFormatString="{0:MMM-yyyy}"   HtmlEncode="false"  ItemStyle-HorizontalAlign="Center" />
                                                                <asp:TemplateField HeaderText="Action">
                                                                    <ItemTemplate>
                                                                        <div class="action-cell">
                                                                            <asp:LinkButton ID="lnkAlter" runat="server" CssClass="action-icon-btn edit-icon" ToolTip="Edit" CommandName="Alter" CommandArgument="<%#((GridViewRow)Container).RowIndex%>">
                                                <svg viewBox="0 0 24 24"><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34a.9959.9959 0 0 0-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/></svg>
                                                </asp:LinkButton>
                                                                            <asp:LinkButton ID="lnkDelete" runat="server" CssClass="action-icon-btn delete-icon" ToolTip="Delete" CommandName="deleterow" CommandArgument="<%#((GridViewRow)Container).RowIndex%>" OnClientClick="return confirm('Are you sure to delete?');">
                                                <svg viewBox="0 0 24 24"><path d="M6 7h12l-1 13.5a1.5 1.5 0 0 1-1.5 1.5h-7a1.5 1.5 0 0 1-1.5-1.5L6 7zm3-3h6l1 2H8l1-2zM4 6h16"/></svg>
                                                </asp:LinkButton>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </ContentTemplate>

                                        </asp:TabPanel>






                                        <asp:TabPanel runat="server" ID="tab2" TabIndex="1" HeaderText="Other's Pay">
                                            <ContentTemplate>
                                                <asp:UpdatePanel runat="server" ID="up2" UpdateMode="Conditional">
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddlEmpCardNo2" />
                                                        <asp:AsyncPostBackTrigger ControlID="ddlCompanyList2" />

                                                        <asp:AsyncPostBackTrigger ControlID="btnSave2" />

                                                    </Triggers>
                                                    <ContentTemplate>

                                                        <div class="adj-form-grid">

                                                            <div class="form-col">
                                                                <span class="form-label">Company</span>
                                                                <div class="form-field-wrap">
                                                                    <asp:DropDownList ID="ddlCompanyList2" runat="server" OnSelectedIndexChanged="ddlCompanyList2_SelectedIndexChanged" ClientIDMode="Static" AutoPostBack="true" CssClass="form-control select_width">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>

                                                            <div class="form-col">
                                                                <span class="form-label">Card No</span>
                                                                <div class="form-field-wrap">
                                                                    <asp:DropDownList runat="server" ID="ddlEmpCardNo2" ClientIDMode="Static" AutoPostBack="false" CssClass="form-control select_width"></asp:DropDownList>
                                                                </div>
                                                            </div>

                                                            <div class="form-col">
                                                                <span class="form-label">Purpose</span>
                                                                <div class="form-field-wrap">
                                                                    <asp:TextBox ID="txtpurpose" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width" onKeyUp="SalaryCalculation();" AutoComplete="off"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="form-col">
                                                                <span class="form-label">Amount</span>
                                                                <div class="form-field-wrap">
                                                                    <asp:TextBox ID="txtotherpayAmount" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width">0</asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="form-col">
                                                                <span class="form-label">Active</span>
                                                                <div class="form-field-wrap checkbox-row">
                                                                    <asp:CheckBox ID="checkActive" runat="server" Checked="true" ClientIDMode="Static" AutoPostBack="false" />
                                                                </div>
                                                            </div>

                                                        </div>

                                                        <div class="em_button_table_wrap">

                                                            <asp:Button ID="Button1" CssClass="Pbutton btn-secondary-adj" runat="server" Text="New" />

                                                            <asp:Button ID="btnSave2" CssClass="Pbutton btn-primary-adj" ClientIDMode="Static" runat="server" OnClientClick="return validateInputsotherspay();" Text="Submit" OnClick="btnSave2_Click" />

                                                            <asp:Button ID="Button3" CssClass="Pbutton btn-secondary-adj" runat="server" Text="Close" PostBackUrl="~/personnel_defult.aspx" />

                                                        </div>
                                                        <asp:GridView runat="server" ID="gvotherspay" CssClass="gvdisplay1" DataKeyNames="OPSN,CompanyId,EmpId" AutoGenerateColumns="false" HeaderStyle-BackColor="#ffa500" HeaderStyle-Height="28px" HeaderStyle-ForeColor="White" PageSize="25" Width="100%" OnRowCommand="gvotherspay_RowCommand">
                                                            <Columns>
                                                                <asp:BoundField DataField="CompanyName" HeaderText="Company" ItemStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="EmpCardNo" HeaderText="Card No" ItemStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="EmpName" HeaderStyle-HorizontalAlign="Left" HeaderText="Name" />
                                                                <asp:BoundField DataField="OPpurpose" HeaderText="Purpose" ItemStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="OtherPay" HeaderText="Amount" ItemStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="IsActive" HeaderText="Enable" ItemStyle-HorizontalAlign="Center" />
                                                                <asp:TemplateField HeaderText="Action">
                                                                    <ItemTemplate>
                                                                        <div class="action-cell">
                                                                            <asp:LinkButton ID="lnkAlter" runat="server" CssClass="action-icon-btn edit-icon" ToolTip="Edit" CommandName="Alter" CommandArgument="<%#((GridViewRow)Container).RowIndex%>">
                                                <svg viewBox="0 0 24 24"><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34a.9959.9959 0 0 0-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/></svg>
                                                </asp:LinkButton>
                                                                            <asp:LinkButton ID="lnkDelete" runat="server" CssClass="action-icon-btn delete-icon" ToolTip="Delete" CommandName="deleterow" CommandArgument="<%#((GridViewRow)Container).RowIndex%>" OnClientClick="return confirm('Are you sure to delete?');">
                                                <svg viewBox="0 0 24 24"><path d="M6 7h12l-1 13.5a1.5 1.5 0 0 1-1.5 1.5h-7a1.5 1.5 0 0 1-1.5-1.5L6 7zm3-3h6l1 2H8l1-2zM4 6h16"/></svg>
                                                </asp:LinkButton>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </ContentTemplate>

                                        </asp:TabPanel>
                                    </asp:TabContainer>

                                </ContentTemplate>
                            </asp:UpdatePanel>


                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <!-- ============ Excel Preview Modal (Bulk Adjustment Import) ============ -->
    <div id="adjExcelPreviewOverlay" class="adj-modal-overlay">
        <div class="adj-preview-box">
            <div class="adj-preview-header">
                <div class="adj-preview-title">Excel Preview - Adjustment</div>
                <button type="button" id="btnAdjClosePreview" class="adj-preview-close">&times;</button>
            </div>

            <div id="adjMissingMsgWrap" class="adj-missing-msg" style="display:none;"></div>

            <div style="text-align:right; margin-bottom:10px;">
                <button type="button" id="btnAdjSubmit" class="Pbutton btn-primary-adj adj-btn-sm" style="display:none;">Submit</button>
            </div>

            <div class="adj-preview-body">
                <div id="adjResultTableWrapper"></div>
            </div>
        </div>
    </div>

    <script type="text/javascript">

        $(document).ready(function () {
            //$("#ddlBankList").select2();
            $(document).on("keyup", '.form-control', function () {
                searchTable($(this).val(), 'ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSalaryList', '');
            });
            $(document).on("keypress", "body", function (e) {
                if (e.keyCode == 13) e.preventDefault();
                // alert('deafault prevented');

            });
            $("#ddlEmpCardNo").select2();
            $("#ddlEmpCardNo2").select2();
        });

        function load() {
            $("#ddlEmpCardNo").select2();
            $("#ddlEmpCardNo2").select2();
        }
        function Messageshow(messagetype, message) {
            showMessage(message, messagetype);
            load();
        }
        function goToNewTab(url) {
            $("#ddlEmpCardNo").select2();
            $("#ddlEmpCardNo").select2();
            window.open(url);
        }

        function validateInputspunishment() {
            if ($('#ddlCompanyList option:selected').text().length == 0) {
                showMessage("warning->Please Select Company ");
                $('#ddlCompanyList').focus();
                return false;
            }
            if ($('#ddlEmpCardNo option:selected').text().length == 0) {
                showMessage("warning->Please Select Card No ");
                $('#ddlEmpCardNo').focus();
                return false;
            }
            if (validateText('txtpunishment', 1, 60, 'Enter Punishment Name') == false) return false;
            if (validateText('txtPAmount', 1, 6, 'Enter Punishment Amount') == false) return false;
            if (validateText('txtmonthname', 1, 7, 'Select Month Name') == false) return false;
            return true;
        }
        function validateInputsotherspay() {
            if ($('#ddlCompanyList2 option:selected').text().length == 0) {
                showMessage("warning->Please Select Company ");
                $('#ddlCompanyList2').focus();
                return false;
            }
            if ($('#ddlEmpCardNo2 option:selected').text().length == 0) {
                showMessage("warning->Please Select Card No ");
                $('#ddlEmpCardNo2').focus();
                return false;
            }
            if (validateText('txtpurpose', 1, 60, 'Enter Purpose Name') == false) return false;
            if (validateText('txtotherpayAmount', 1, 6, 'Enter Other pay Amount') == false) return false;
            return true;
        }







        function ShowdivEmpAddress() {
            $('#divEmpInfo').hide();
            $('#div_emp_save').hide();
            $('#divEmpAddress').show();
            $('#divEmpPersonnelInfo').hide();
        }
        function AllHidewithoutEmployeediv() {
            $('#divEmpInfo').show();
            $('#div_emp_save').show();
            $('#divEmpAddress').hide();
            $('#divEmpPersonnelInfo').hide();
            $('#divEmpExperience').hide();
            $('#divEmpEducation').hide();
        }
        function divEmpExperienceList() {
            if ($('#ddlEmpCardNo option:selected').text().length == 0) {
                showMessage('Please Select Employee Card No', 'warning');
                return false;
            }

            return true;
        }



        function SaveSuccess() {
            showMessage("Successfully saved", "success");
        }
        function UnableSave() {
            $("#ddlEmpCardNo").select2();
            showMessage("Unable to save", "error");
        }
        function UpdateSuccess() {
            showMessage("Successfully Updated", "success");
        }
        function UnableUpdate() {
            showMessage("Unable to Update", "error");
        }

    </script>

    <!-- ============ Excel Import logic (Adjustment tab bulk upload) ============ -->
    <script type="text/javascript">
        (function () {
            // ---------------- Values coming from server-side Session ----------------
            var TOKEN = '<%= Session["__UserToken__"] %>';
            var ROOT_URL = '<%= Session["__RootUrl__"] %>';

            // NOTE: assumed to be the same Employee lookup API used elsewhere in this system.
            // Confirm the route/response field names match; adjust if different.
            var EMPLOYEE_LOOKUP_URL = ROOT_URL + "/api/Employee/by-card-numbers?companyId=";

            var REQUIRED_COLUMNS = ["EmpCardNum", "AdjusmentType", "AdjustmentName", "Amount", "MontName"];

            var fuAdjExcel = document.getElementById("fuAdjExcel");
            var btnAdjLoad = document.getElementById("btnAdjLoad");
            var btnAdjSubmit = document.getElementById("btnAdjSubmit");
            var adjExcelPreviewOverlay = document.getElementById("adjExcelPreviewOverlay");
            var btnAdjClosePreview = document.getElementById("btnAdjClosePreview");
            var adjResultTableWrapper = document.getElementById("adjResultTableWrapper");
            var adjMissingMsgWrap = document.getElementById("adjMissingMsgWrap");

            // Move the modal to be a direct child of <body>. Deeply nested layouts (master
            // pages, UpdatePanels, transformed ancestors) can break position:fixed centering;
            // re-parenting guarantees it centers against the real viewport every time.
            if (adjExcelPreviewOverlay.parentElement !== document.body) {
                document.body.appendChild(adjExcelPreviewOverlay);
            }

            var currentFoundRows = [];
            var currentEmployeeMap = {};

            function getSelectedCompanyId() {
                var ddl = document.getElementById("ddlCompanyList");
                return ddl ? ddl.value : "";
            }

            function showExcelPreviewModal() {
                adjExcelPreviewOverlay.classList.add("show");
            }

            function hideExcelPreviewModal() {
                adjExcelPreviewOverlay.classList.remove("show");
            }

            btnAdjClosePreview.addEventListener("click", hideExcelPreviewModal);
            adjExcelPreviewOverlay.addEventListener("click", function (e) {
                if (e.target === adjExcelPreviewOverlay) hideExcelPreviewModal();
            });

            btnAdjLoad.addEventListener("click", function () {
                adjResultTableWrapper.innerHTML = "";
                adjMissingMsgWrap.style.display = "none";
                adjMissingMsgWrap.innerHTML = "";
                btnAdjSubmit.style.display = "none";
                currentFoundRows = [];
                currentEmployeeMap = {};

                var companyId = getSelectedCompanyId();
                if (!companyId) {
                    showMessage("warning->Please Select Company first");
                    return;
                }

                var file = fuAdjExcel.files[0];
                if (!file) {
                    showMessage("warning->Please select an Excel file");
                    return;
                }

                btnAdjLoad.disabled = true;
                btnAdjLoad.textContent = "Processing...";

                readAdjExcelFile(file)
                    .then(function (rows) {
                        if (!rows.length) {
                            throw new Error("No data found in the Excel file.");
                        }

                        var cardNumbers = uniqueValues(rows.map(function (r) { return String(r.EmpCardNum).trim(); }));

                        return fetchEmployeesByCardNumbers(cardNumbers, companyId).then(function (employeeMap) {
                            var foundRows = rows.filter(function (r) { return !!employeeMap[r.EmpCardNum]; });
                            var missingCards = cardNumbers.filter(function (c) { return !employeeMap[c]; });
                            var missingRows = rows.filter(function (r) { return missingCards.indexOf(r.EmpCardNum) !== -1; });

                            currentFoundRows = foundRows;
                            currentEmployeeMap = employeeMap;

                            renderAdjPreviewTable(foundRows, employeeMap);
                            btnAdjSubmit.style.display = foundRows.length ? "inline-block" : "none";

                            if (missingCards.length) {
                                showAdjMissingMessage(missingCards.length, missingRows);
                            }

                            showExcelPreviewModal();
                        });
                    })
                    .catch(function (err) {
                        console.error(err);
                        showMessage("error->" + (err.message || "Something went wrong while processing the Excel file."));
                    })
                    .finally(function () {
                        btnAdjLoad.disabled = false;
                        btnAdjLoad.textContent = "Load & Process";
                    });
            });

            btnAdjSubmit.addEventListener("click", function () {
                if (!currentFoundRows.length) {
                    showMessage("warning->Nothing to submit");
                    return;
                }

                var payload = currentFoundRows.map(function (row) {
                    var emp = currentEmployeeMap[row.EmpCardNum];
                    return {
                        EmpId: emp.empId,
                        PName: row.AdjustmentName,
                        PAmount: parseFloat(row.Amount) || 0,
                        MonthName: toMonthNameString(row.MontName),
                        AdjustmentType: row.AdjusmentType
                    };
                });

                btnAdjSubmit.disabled = true;
                btnAdjSubmit.textContent = "Submitting...";

                // Put the JSON into the hidden field, then trigger the real ASP.NET
                // server button (btnAdjImportSubmit) so it does a normal postback.
                // The code-behind (btnAdjImportSubmit_Click) reads hdnAdjImportJson.Value,
                // deserializes it, and inserts the rows - no separate REST API needed.
                document.getElementById("hdnAdjImportJson").value = JSON.stringify(payload);
                document.getElementById("btnAdjImportSubmit").click();

                // The modal stays open with a "Submitting..." state through the async
                // postback. The code-behind should call, on success:
                //   ScriptManager.RegisterStartupScript(this, GetType(), "adjImportDone",
                //     "hideAdjExcelPreviewModalFromServer();", true);
                // (helper defined below) so the modal closes and the button resets.
            });

            // Exposed so the code-behind can close the modal + reset the button after
            // the postback completes (see comment above).
            window.hideAdjExcelPreviewModalFromServer = function () {
                hideExcelPreviewModal();
                btnAdjSubmit.disabled = false;
                btnAdjSubmit.textContent = "Submit";
                currentFoundRows = [];
                currentEmployeeMap = {};
            };

            function showAdjMissingMessage(count, missingRows) {
                adjMissingMsgWrap.innerHTML = "";
                adjMissingMsgWrap.style.display = "block";

                var textSpan = document.createElement("span");
                textSpan.textContent = count + " card number(s) not found. ";
                adjMissingMsgWrap.appendChild(textSpan);

                var downloadBtn = document.createElement("button");
                downloadBtn.type = "button";
                downloadBtn.textContent = "Download Missing List";
                downloadBtn.className = "Pbutton btn-secondary-adj adj-btn-sm";
                downloadBtn.style.marginLeft = "8px";
                downloadBtn.addEventListener("click", function () {
                    downloadMissingAdjExcel(missingRows);
                });
                adjMissingMsgWrap.appendChild(downloadBtn);
            }

            function downloadMissingAdjExcel(missingRows) {
                var exportData = missingRows.map(function (row) {
                    return {
                        EmpCardNum: row.EmpCardNum,
                        AdjusmentType: row.AdjusmentType,
                        AdjustmentName: row.AdjustmentName,
                        Amount: row.Amount,
                        MontName: toMonthNameString(row.MontName)
                    };
                });

                var worksheet = XLSX.utils.json_to_sheet(exportData);
                var wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, worksheet, "Missing Employees");
                XLSX.writeFile(wb, "Missing_Adjustment_Employees.xlsx");
            }

            function uniqueValues(arr) {
                return arr.filter(function (v, i) { return arr.indexOf(v) === i; });
            }

            function readAdjExcelFile(file) {
                return new Promise(function (resolve, reject) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        try {
                            var data = new Uint8Array(e.target.result);
                            var workbook = XLSX.read(data, { type: "array", cellDates: true });
                            var sheet = workbook.Sheets[workbook.SheetNames[0]];
                            var rows = XLSX.utils.sheet_to_json(sheet, { defval: "" });

                            if (rows.length === 0) {
                                resolve([]);
                                return;
                            }

                            var headers = Object.keys(rows[0]);
                            var missing = REQUIRED_COLUMNS.filter(function (col) { return headers.indexOf(col) === -1; });
                            if (missing.length) {
                                reject(new Error("Missing column(s) in Excel file: " + missing.join(", ")));
                                return;
                            }

                            var parsedRows = rows
                                .filter(function (r) { return String(r.EmpCardNum).trim() !== ""; })
                                .map(function (r) {
                                    return {
                                        EmpCardNum: String(r.EmpCardNum).trim(),
                                        AdjusmentType: String(r.AdjusmentType).trim(),
                                        AdjustmentName: String(r.AdjustmentName).trim(),
                                        Amount: String(r.Amount).trim(),
                                        MontName: r.MontName
                                    };
                                });

                            resolve(parsedRows);
                        } catch (err) {
                            reject(err);
                        }
                    };

                    reader.onerror = function () {
                        reject(new Error("Could not read the Excel file."));
                    };

                    reader.readAsArrayBuffer(file);
                });
            }

            function fetchEmployeesByCardNumbers(cardNumbers, companyId) {
                return fetch(EMPLOYEE_LOOKUP_URL + companyId, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "Bearer " + TOKEN
                    },
                    body: JSON.stringify({ cardNumbers: cardNumbers })
                })
                    .catch(function () {
                        throw new Error("Could not connect to the Employee API.");
                    })
                    .then(function (response) {
                        if (!response.ok) {
                            throw new Error("Employee lookup failed (status " + response.status + ").");
                        }
                        return response.json();
                    })
                    .then(function (json) {
                        var list = Array.isArray(json) ? json : (json.data || json.result || []);

                        var map = {};
                        list.forEach(function (emp) {
                            var cardNo = emp.empCard;
                            if (cardNo) {
                                map[String(cardNo).trim()] = {
                                    empId: emp.empId || "",
                                    name: emp.empName || "N/A",
                                    department: emp.dptName || "N/A",
                                    designation: emp.dsgName || "N/A"
                                };
                            }
                        });
                        return map;
                    });
            }

            function renderAdjPreviewTable(rows, employeeMap) {
                if (!rows.length) {
                    adjResultTableWrapper.innerHTML = "";
                    return;
                }

                var html = "<table class='gvdisplay1'><thead><tr>" +
                    "<th>Card No</th><th>Name</th><th>Adjustment Type</th><th>Adjustment Name</th>" +
                    "<th>Amount</th><th>Month</th>" +
                    "</tr></thead><tbody>";

                rows.forEach(function (row) {
                    var emp = employeeMap[row.EmpCardNum];
                    html += "<tr>" +
                        "<td>" + escapeHtml(row.EmpCardNum) + "</td>" +
                        "<td>" + escapeHtml(emp.name) + "</td>" +
                        "<td>" + escapeHtml(row.AdjusmentType) + "</td>" +
                        "<td>" + escapeHtml(row.AdjustmentName) + "</td>" +
                        "<td>" + escapeHtml(row.Amount) + "</td>" +
                        "<td>" + escapeHtml(toMonthNameString(row.MontName)) + "</td>" +
                        "</tr>";
                });

                html += "</tbody></table>";
                adjResultTableWrapper.innerHTML = html;
            }

            // Converts a date/text month value into "MM-yyyy" (matches the CalendarExtender format used on the form).
            function toMonthNameString(value) {
                var d = null;

                if (value instanceof Date) {
                    d = value;
                } else if (value !== null && value !== undefined && String(value).trim() !== "") {
                    var parsed = new Date(value);
                    if (!isNaN(parsed.getTime())) {
                        d = parsed;
                    }
                }

                if (!d) {
                    return value == null ? "" : String(value).trim();
                }

                var mm = String(d.getMonth() + 1).padStart(2, "0");
                var yyyy = d.getFullYear();
                return mm + "-" + yyyy;
            }

            function escapeHtml(str) {
                var div = document.createElement("div");
                div.textContent = str == null ? "" : String(str);
                return div.innerHTML;
            }
        })();
    </script>

</asp:Content>
