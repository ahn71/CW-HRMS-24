<%@ Page Title="Bonus Month Setup" Language="C#" MasterPageFile="~/payroll_nested.Master" AutoEventWireup="true" CodeBehind="bonus_monyh_setup.aspx.cs" Inherits="SigmaERP.payroll.bonud_monyh_setup" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=JetBrains+Mono:wght@400;600&display=swap" rel="stylesheet">
    <script type="text/javascript">
        var oldgridcolor;
        function SetMouseOver(element) {
            oldgridcolor = element.style.backgroundColor;
            element.style.backgroundColor = '#e8f4fd';
            element.style.cursor = 'pointer';
        }
        function SetMouseOut(element) {
            element.style.backgroundColor = oldgridcolor;
        }
    </script>
    <style type="text/css">
        :root {
            --primary: #1a56db;
            --primary-dark: #1340a8;
            --primary-light: #e8f0fe;
            --accent: #0ea5e9;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --surface: #ffffff;
            --surface-2: #f8fafc;
            --surface-3: #f1f5f9;
            --border: #e2e8f0;
            --border-dark: #cbd5e1;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --text-muted: #94a3b8;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
            --shadow-md: 0 4px 12px rgba(0,0,0,0.08), 0 2px 4px rgba(0,0,0,0.04);
            --shadow-lg: 0 10px 30px rgba(0,0,0,0.10), 0 4px 8px rgba(0,0,0,0.05);
            --radius: 12px;
            --radius-sm: 8px;
        }

        * {
            box-sizing: border-box;
        }

        body, .main_box, .main_box_body, .main_box_content,
        input, select, button, textarea, label {
            font-family: 'Plus Jakarta Sans', sans-serif !important;
        }

        /* ── Page wrapper ── */
        .bms-page-wrap {
            background: var(--surface-2);
            min-height: 100vh;
            padding: 0 0 40px;
        }

        /* ── Breadcrumb ── */
        .bms-breadcrumb {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 14px 0 18px;
            font-size: 13px;
            color: var(--text-muted);
        }

            .bms-breadcrumb a {
                color: var(--text-secondary);
                text-decoration: none;
                font-weight: 500;
                transition: color 0.2s;
            }

                .bms-breadcrumb a:hover {
                    color: var(--primary);
                }

            .bms-breadcrumb .sep {
                color: var(--border-dark);
                font-size: 16px;
            }

            .bms-breadcrumb .active {
                color: var(--primary);
                font-weight: 600;
            }

        /* ── Card wrapper ── */
        .bms-card {
            background: var(--surface);
            border-radius: var(--radius);
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border);
            overflow: hidden;
        }

        /* ── Card header ── */
        .bms-card-header {
            background: linear-gradient(135deg, #1a56db 0%, #1340a8 50%, #0d2d7a 100%);
            padding: 22px 28px;
            display: flex;
            align-items: center;
            gap: 14px;
            position: relative;
            overflow: hidden;
        }

            .bms-card-header::before {
                content: '';
                position: absolute;
                top: -40px;
                right: -40px;
                width: 160px;
                height: 160px;
                background: rgba(255,255,255,0.05);
                border-radius: 50%;
            }

            .bms-card-header::after {
                content: '';
                position: absolute;
                bottom: -60px;
                right: 60px;
                width: 200px;
                height: 200px;
                background: rgba(255,255,255,0.03);
                border-radius: 50%;
            }

        .bms-card-header-icon {
            width: 44px;
            height: 44px;
            background: rgba(255,255,255,0.15);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            backdrop-filter: blur(4px);
            flex-shrink: 0;
        }

        .bms-card-header h2 {
            margin: 0;
            color: #fff;
            font-size: 18px;
            font-weight: 700;
            letter-spacing: -0.3px;
        }

        .bms-card-header p {
            margin: 2px 0 0;
            color: rgba(255,255,255,0.65);
            font-size: 12.5px;
        }

        /* ── Message bar ── */
        .message {
            margin: 16px 24px 0;
            padding: 12px 16px;
            border-radius: var(--radius-sm);
            font-size: 13.5px;
            font-weight: 500;
            background: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
            display: none;
        }

            .message:not(:empty) {
                display: block;
            }

        /* ── Tab container overrides ── */
        .bms-tab-wrap {
            padding: 20px 24px 24px;
        }

        .fancy.fancy-green .ajax__tab_header {
            border-bottom: 2px solid var(--border);
            margin-bottom: 0;
            display: flex;
            gap: 4px;
        }

        .fancy.fancy-green .ajax__tab_tab {
            padding: 10px 22px !important;
            font-size: 13.5px !important;
            font-weight: 600 !important;
            color: var(--text-secondary) !important;
            background: transparent !important;
            border: none !important;
            border-bottom: 2px solid transparent !important;
            margin-bottom: -2px !important;
            border-radius: 0 !important;
            cursor: pointer;
            transition: color 0.2s, border-color 0.2s;
            font-family: 'Plus Jakarta Sans', sans-serif !important;
        }

            .fancy.fancy-green .ajax__tab_active .ajax__tab_tab,
            .fancy.fancy-green .ajax__tab_tab:hover {
                color: var(--primary) !important;
                border-bottom-color: var(--primary) !important;
                background: transparent !important;
            }

        .fancy.fancy-green .ajax__tab_body {
            background: transparent !important;
            border: none !important;
            padding: 20px 0 0 !important;
        }

        /* ── Attendance checkbox — OUTSIDE tabs ── */
        .bms-attendance-toggle {
            display: flex;
            align-items: center;
            gap: 10px;
            background: linear-gradient(135deg, #fffbeb, #fef3c7);
            border: 1px solid #fcd34d;
            border-radius: var(--radius-sm);
            padding: 11px 16px;
            margin: 0 24px 16px;
            width: calc(100% - 48px);
        }

            .bms-attendance-toggle input[type=checkbox] {
                width: 17px;
                height: 17px;
                accent-color: var(--warning);
                cursor: pointer;
                flex-shrink: 0;
            }

            .bms-attendance-toggle label {
                font-size: 13.5px;
                font-weight: 600;
                color: #92400e;
                cursor: pointer;
                margin: 0;
            }

        .bms-att-badge {
            margin-left: auto;
            background: #fcd34d;
            color: #78350f;
            font-size: 11px;
            font-weight: 700;
            padding: 2px 8px;
            border-radius: 20px;
            letter-spacing: 0.3px;
        }

        /* ── Attendance status pills ── */
        .bms-att-status-row {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            padding: 10px 24px 4px;
            justify-content: center;
        }

            .bms-att-status-row .att-pill {
                display: flex;
                align-items: center;
                gap: 6px;
                background: var(--surface-3);
                border: 1px solid var(--border);
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
                color: var(--text-secondary);
                cursor: pointer;
                transition: all 0.2s;
            }

                .bms-att-status-row .att-pill:hover {
                    background: var(--primary-light);
                    border-color: var(--primary);
                    color: var(--primary);
                }

        /* ── Filter row ── */
        .bms-filter-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 20px;
        }

        .bms-field-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

            .bms-field-group label {
                font-size: 12.5px;
                font-weight: 600;
                color: var(--text-secondary);
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

                .bms-field-group label span.req {
                    color: var(--danger);
                    margin-left: 2px;
                }

            .bms-field-group select {
                width: 100%;
                padding: 9px 14px;
                border: 1.5px solid var(--border);
                border-radius: var(--radius-sm);
                font-size: 14px;
                color: var(--text-primary);
                background: var(--surface);
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%2394a3b8' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 12px center;
                transition: border-color 0.2s, box-shadow 0.2s;
                cursor: pointer;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
            }

                .bms-field-group select:focus {
                    outline: none;
                    border-color: var(--primary);
                    box-shadow: 0 0 0 3px rgba(26,86,219,0.12);
                }

        /* ── Status label ── */
        .bms-status-label {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 20px;
            background: var(--primary-light);
            color: var(--primary);
            margin-bottom: 14px;
        }

        /* ── GridView styling ── */
        .bms-grid-wrap {
            border-radius: var(--radius-sm);
            overflow: hidden;
            border: 1px solid var(--border);
            box-shadow: var(--shadow-sm);
            margin-bottom: 20px;
        }

        /* Tab1 grid */
        #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList {
            width: 100% !important;
            border-collapse: collapse !important;
            border: none !important;
            font-size: 13.5px;
        }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList th {
                background: #1a56db !important;
                color: #fff !important;
                font-weight: 600 !important;
                padding: 11px 14px !important;
                font-size: 12.5px !important;
                letter-spacing: 0.3px;
                border: none !important;
            }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList td {
                padding: 10px 14px !important;
                border-bottom: 1px solid var(--border) !important;
                border-right: none !important;
                border-left: none !important;
                background: #fff !important;
                color: var(--text-primary) !important;
                vertical-align: middle !important;
            }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList tr:last-child td {
                border-bottom: none !important;
            }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList tr:hover td {
                background: #f0f6ff !important;
            }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList th:nth-child(3),
            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList th:nth-child(4),
            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList td:nth-child(3),
            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList td:nth-child(4) {
                text-align: center !important;
            }

            /* Textboxes inside grid */
            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList input[type=text] {
                text-align: center !important;
                width: 70px !important;
                font-weight: 700 !important;
                color: var(--danger) !important;
                border: 1.5px solid var(--border) !important;
                border-radius: 6px !important;
                padding: 5px 8px !important;
                font-family: 'JetBrains Mono', monospace !important;
                font-size: 13px !important;
                background: #fef2f2 !important;
                transition: border-color 0.2s, box-shadow 0.2s !important;
            }

                #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList input[type=text]:focus {
                    outline: none !important;
                    border-color: var(--danger) !important;
                    box-shadow: 0 0 0 3px rgba(239,68,68,0.12) !important;
                }

            /* Checkbox inside grid */
            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab1_gvBonusMonthList input[type=checkbox] {
                width: 16px;
                height: 16px;
                accent-color: var(--primary);
                cursor: pointer;
            }

        /* Tab2 grid */
        #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSetupedList {
            width: 100% !important;
            border-collapse: collapse !important;
            border: none !important;
            font-size: 13.5px;
        }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSetupedList th {
                background: #1a56db !important;
                color: #fff !important;
                font-weight: 600 !important;
                padding: 11px 14px !important;
                font-size: 12.5px !important;
                letter-spacing: 0.3px;
                border: none !important;
            }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSetupedList td {
                padding: 10px 14px !important;
                border-bottom: 1px solid var(--border) !important;
                border-right: none !important;
                border-left: none !important;
                background: #fff !important;
                color: var(--text-primary) !important;
                vertical-align: middle !important;
            }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSetupedList tr:last-child td {
                border-bottom: none !important;
            }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSetupedList tr:hover td {
                background: #f0f6ff !important;
            }

            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSetupedList th:first-child,
            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSetupedList th:nth-child(3),
            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSetupedList td:first-child,
            #ContentPlaceHolder1_ContentPlaceHolder1_tc1_tab2_gvSetupedList td:nth-child(3) {
                text-align: center !important;
            }

        /* ── Generate type row ── */
        .bms-generate-row {
            background: var(--surface-3);
            border-radius: var(--radius-sm);
            border: 1px solid var(--border);
            padding: 14px 18px;
            display: flex;
            align-items: center;
            gap: 24px;
            flex-wrap: wrap;
            margin-bottom: 18px;
            font-size: 13.5px;
            font-weight: 600;
            color: var(--text-secondary);
        }

            .bms-generate-row .rbl-wrap {
                display: flex;
                gap: 16px;
            }

            .bms-generate-row input[type=radio] {
                accent-color: var(--primary);
                width: 15px;
                height: 15px;
                cursor: pointer;
            }

            .bms-generate-row label {
                font-weight: 500;
                color: var(--text-primary);
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 6px;
            }

        /* ── Action buttons ── */
        .bms-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 20px;
        }

        .bms-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 10px 28px;
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
            font-family: 'Plus Jakarta Sans', sans-serif !important;
            letter-spacing: 0.2px;
        }

        .bms-btn-primary {
            background: linear-gradient(135deg, #1a56db, #1340a8);
            color: #fff;
            box-shadow: 0 2px 8px rgba(26,86,219,0.35);
        }

            .bms-btn-primary:hover {
                background: linear-gradient(135deg, #1340a8, #0d2d7a);
                box-shadow: 0 4px 14px rgba(26,86,219,0.45);
                transform: translateY(-1px);
            }

        .bms-btn-danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: #fff;
            box-shadow: 0 2px 8px rgba(239,68,68,0.3);
        }

            .bms-btn-danger:hover {
                background: linear-gradient(135deg, #dc2626, #b91c1c);
                box-shadow: 0 4px 14px rgba(239,68,68,0.4);
                transform: translateY(-1px);
            }

        /* ── Hide old structures we no longer need visually ── */
        .leftBox, .rightBox {
            display: none !important;
        }

        /* ── Divider ── */
        .bms-divider {
            height: 1px;
            background: var(--border);
            margin: 18px 0;
        }

        /* ── Inline attendance checkbox beside radio buttons ── */
        .bms-divider-v {
            display: inline-block;
            width: 1px;
            height: 22px;
            background: var(--border-dark);
            margin: 0 6px;
            vertical-align: middle;
        }

        .chk-att-inline input[type=checkbox] {
            width: 16px;
            height: 16px;
            accent-color: var(--warning);
            cursor: pointer;
            vertical-align: middle;
        }

        .chk-att-label {
            font-size: 13.5px !important;
            font-weight: 600 !important;
            color: #92400e !important;
            cursor: pointer;
            margin: 0 !important;
            vertical-align: middle;
        }

        /* ── Empty state ── */
        .bms-empty {
            text-align: center;
            padding: 40px 20px;
            color: var(--text-muted);
            font-size: 14px;
        }

        span {
            margin-top: -10px !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- ── Breadcrumb ── --%>
    <div class="bms-breadcrumb">
        <a href="/default.aspx">🏠 Dashboard</a>
        <span class="sep">›</span>
        <a href="<%= Session["__bonusURl__"] %>">Bonus</a>
        <span class="sep">›</span>
        <span>Bonus Month Setup</span>
    </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <%-- ── Message panel ── --%>
    <asp:UpdatePanel ID="uplMessage" runat="server">
        <ContentTemplate>
            <p class="message" id="lblMessage" clientidmode="Static" runat="server"></p>
        </ContentTemplate>
    </asp:UpdatePanel>



    <%-- ── Main card ── --%>
    <div class="bms-card">


        <%-- Body --%>
        <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
            <Triggers>

                <asp:PostBackTrigger ControlID="chkAttendnaceStatus" />
            </Triggers>
            <ContentTemplate>




                <div class="bms-tab-wrap">
                    <asp:TabContainer ID="tc1" runat="server" CssClass="fancy fancy-green"
                        AutoPostBack="true" OnActiveTabChanged="tc1_ActiveTabChanged" ActiveTabIndex="0">

                        <%-- ════ TAB 1 ════ --%>
                        <asp:TabPanel ID="tab1" runat="server" TabIndex="0">
                            <HeaderTemplate>Bonus Month Setup</HeaderTemplate>
                            <ContentTemplate>

                                <%-- Filter row --%>
                                <div class="bms-filter-row">
                                    <div class="bms-field-group">
                                        <label>Select Company <span class="req">*</span></label>
                                        <asp:DropDownList ID="ddlComapnyList" runat="server"
                                            ClientIDMode="Static"
                                            AutoPostBack="True"
                                            OnSelectedIndexChanged="ddlComapnyList_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="bms-field-group">
                                        <label>Select Bonus Name <span class="req">*</span></label>
                                        <asp:DropDownList ID="dlSelectBonusYearAndType" runat="server"
                                            ClientIDMode="Static"
                                            AutoPostBack="True"
                                            OnSelectedIndexChanged="dlSelectBonusYearAndType_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <%-- Status label --%>
                                <asp:Label ID="lblStatus" runat="server" Font-Bold="True" CssClass="bms-status-label"></asp:Label>

                                <%-- Grid --%>
                                <div class="bms-grid-wrap">
                                    <asp:GridView runat="server" ID="gvBonusMonthList"
                                        AutoGenerateColumns="False"
                                        DataKeyNames="SL"
                                        OnRowDataBound="gvSetupedList_RowDataBound"
                                        GridLines="None"
                                        BorderWidth="0"
                                        CellPadding="0"
                                        CellSpacing="0">
                                        <Columns>
                                            <asp:BoundField DataField="SlabType" HeaderText="Slab Type">
                                                <ItemStyle Font-Bold="True" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="EquivalentMonth" HeaderText="Equivalent Month">
                                                <ItemStyle Font-Bold="True" />
                                            </asp:BoundField>
                                        <asp:TemplateField HeaderText="Equivalent Days">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEquivalentdays" runat="server" TextMode="SingleLine"
                                                        Text='<%#(Eval("EquivalentDays").ToString())%>'
                                                        AutoComplete="off" MaxLength="3"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Chosen">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkChosen" runat="server"
                                                        Checked='<%#bool.Parse(Eval("Chosen").ToString())%>'
                                                        AutoPostBack="true" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Per. (%)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtPercentage" runat="server" TextMode="SingleLine"
                                                        Text='<%#(Eval("Percentage").ToString())%>'
                                                        AutoComplete="off" MaxLength="3"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle BackColor="#1a56db" ForeColor="White" Font-Bold="True" />
                                        <RowStyle BackColor="White" />
                                        <AlternatingRowStyle BackColor="#f8fafc" />
                                        <SelectedRowStyle BackColor="#dbeafe" ForeColor="#1e3a8a" Font-Bold="True" />
                                    </asp:GridView>
                                </div>



                                <%-- Hidden popup button (unchanged) --%>
                                <asp:Button ID="btnPopup" runat="server" Style="display: none;" Text="Close" />

                            </ContentTemplate>
                        </asp:TabPanel>

                        <%-- ════ TAB 2 ════ --%>
                        <asp:TabPanel runat="server" ID="tab2" TabIndex="1" Height="550px">
                            <HeaderTemplate>Setup List</HeaderTemplate>
                            <ContentTemplate>
                                <div class="bms-grid-wrap">
                                    <asp:GridView RowStyle-Height="36px" runat="server" Width="100%"
                                        ID="gvSetupedList"
                                        AutoGenerateColumns="False"
                                        GridLines="None"
                                        BorderWidth="0"
                                        CellPadding="0"
                                        CellSpacing="0"
                                        OnRowDataBound="gvSetupedList_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderStyle-Width="60px">
                                                <HeaderTemplate>SL</HeaderTemplate>
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                                <ItemStyle ForeColor="#1a56db" Font-Bold="true" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="BonusType" HeaderText="Bonus Title" ItemStyle-Font-Bold="true">
                                                <ItemStyle Width="469px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="SetupedDate" HeaderText="Setup Date" ItemStyle-Font-Bold="true">
                                                <ItemStyle Width="200px" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                        </Columns>
                                        <HeaderStyle BackColor="#1a56db" ForeColor="White" Font-Bold="True" />
                                        <RowStyle BackColor="White" />
                                        <AlternatingRowStyle BackColor="#f8fafc" />
                                        <SelectedRowStyle BackColor="#dbeafe" ForeColor="#1e3a8a" Font-Bold="True" />
                                    </asp:GridView>
                                </div>
                            </ContentTemplate>
                        </asp:TabPanel>

                    </asp:TabContainer>
                    <div runat="server" id="footer">
                        <table id="tblGenreateType" runat="server" visible="False" style="width: 100%; margin-bottom: 0;">
                            <tr runat="server">
                                <td runat="server">
                                    <div class="bms-generate-row">
                                        <span>Bonus Generate On :</span>
                                        <asp:RadioButtonList ID="rblGenerateType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="rbl-wrap">
                                            <asp:ListItem Value="Gross Salary">Gross Salary</asp:ListItem>
                                            <asp:ListItem Selected="True">Basic Salary</asp:ListItem>
                                        </asp:RadioButtonList>
                                        <span class="bms-divider-v"></span>
                                        <asp:CheckBox runat="server"
                                            ID="chkAttendnaceStatus"
                                            OnCheckedChanged="chkAttendnaceStatus_CheckedChanged"
                                            AutoPostBack="true"
                                            CssClass="chk-att-inline" />
                                        <label>Depends On Attendance Status</label>


                                    </div>

                                </td>

                            </tr>

                        </table>
                        <div runat="server" id="attStatusList" visible="false" class="bms-att-status-row" style="padding: 10px 24px 4px;">
                            <span class="att-pill">
                                <asp:CheckBox runat="server" ID="chkP" Text="P" />
                            </span>
                            <span class="att-pill">
                                <asp:CheckBox runat="server" ID="chkA" Text="A" />
                            </span>
                            <span class="att-pill">
                                <asp:CheckBox runat="server" ID="chkW" Text="W" />
                            </span>
                            <span class="att-pill">
                                <asp:CheckBox runat="server" ID="chkH" Text="H" />
                            </span>
                            <span class="att-pill">
                                <asp:CheckBox runat="server" ID="chkL" Text="L" />
                            </span>
                        </div>
                    </div>

                </div>


                <%-- Action buttons --%>
                <div class="bms-actions" runat="server" id="btnSection">
                    <asp:Button runat="server" ID="btnSet" Text="✔ Set"
                        CssClass="bms-btn bms-btn-primary"
                        OnClick="btnSet_Click" />
                    <asp:Button runat="server" ID="btnDelete" Text="✕ Delete"
                        CssClass="bms-btn bms-btn-danger"
                        OnClientClick="return confirm('Are you sure you want to delete?');"
                        OnClick="btnDelete_Click" />
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
