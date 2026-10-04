<%@ Page Title="Monthwise Leave Summary Report" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="MonthwiseLeaveSummaryReport.aspx.cs" Inherits="SigmaERP.hrms.Leave.MonthwiseLeaveSummaryReport" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
<style>
    .mlsr{font-family:Arial,sans-serif;color:#1f2937;margin:22px auto;padding:0 16px;max-width:1700px}
    .mlsr .report-toolbar{display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px;margin-bottom:14px}
    .mlsr .toolbar-left h2{margin:0;font-size:19px;color:#1e293b}
    .mlsr .toolbar-left .muted{font-size:12px;color:#6b7280}
    .mlsr .toolbar-right{display:flex;gap:8px}
    .mlsr .btn{border:none;border-radius:6px;padding:9px 18px;font:600 13px Arial;cursor:pointer;color:#fff;box-shadow:0 1px 2px rgba(0,0,0,.15)}
    .mlsr a.btn{display:inline-block;text-decoration:none}
    .mlsr .btn-excel{background:#1d7a46}
    .mlsr .btn-excel:hover{background:#166238}
    .mlsr .btn-pdf{background:#b3261e}
    .mlsr .btn-pdf:hover{background:#8f1e18}
    .mlsr .btn-print{background:#253e61}
    .mlsr .btn-print:hover{background:#1b2e49}
    .mlsr .sheet{background:#fff;border:1px solid #e3e7ee;border-radius:6px;padding:16px 18px 22px}
    .mlsr .resort{font-size:19px}
    .mlsr table.leave-summary th.lv,.mlsr table.leave-summary td.lv{min-width:44px}
    .mlsr .report-head{display:grid;grid-template-columns:1fr 2fr 1fr;align-items:center;text-align:center;margin:0 0 12px}
    .mlsr .brand{font:26px Georgia,serif;letter-spacing:4px;color:#968443}
    .mlsr .brand small{display:block;font:bold 11px Georgia,serif;letter-spacing:1px}
    .mlsr .heading .company{font-size:16px;font-weight:bold}
    .mlsr .heading .address{font-size:11px;color:#586579;margin-top:2px}
    .mlsr .heading h1{font-size:18px;margin:8px 0 3px;text-transform:uppercase;letter-spacing:1px}
    .mlsr .heading small{color:#557643;font-weight:bold;font-size:12px}
    .mlsr .meta{display:grid;grid-template-columns:1.5fr 1fr 2fr 1fr;gap:10px;padding:8px 0 10px;margin-bottom:10px;border-top:2px solid #1f2937;border-bottom:1px solid #1f2937;text-align:center}
    .mlsr .meta b{display:block;font-size:11px;color:#586579;margin-bottom:3px;text-transform:uppercase}
    .mlsr .meta strong{font-size:13px}
    .mlsr .signatures{display:flex;justify-content:space-around;margin-top:60px;font-size:12px}
    .mlsr .signatures span{border-top:1px solid #1f2937;padding-top:4px;min-width:160px;text-align:center}
    .mlsr .table-wrap{width:100%;max-height:640px;overflow:auto;border:1px solid #d7deea}
    .mlsr table.leave-summary{border-collapse:collapse;width:100%;min-width:1100px;font-size:12px}
    .mlsr table.leave-summary th,.mlsr table.leave-summary td{border:1px solid #d7deea;text-align:center;padding:6px 8px;white-space:nowrap}
    .mlsr table.leave-summary td.left,.mlsr table.leave-summary th.left{text-align:left}
    .mlsr table.leave-summary thead th{position:sticky;top:0;background:#eef1f6;font-weight:700;z-index:2}
    .mlsr table.leave-summary thead tr:first-child th{top:0;background:#e3e8f1}
    .mlsr table.leave-summary thead tr:nth-child(2) th{top:31px}
    .mlsr table.leave-summary th.grp-availed{background:#fdf3e0}
    .mlsr table.leave-summary th.grp-total{background:#e4f0fb}
    .mlsr table.leave-summary th.grp-balance{background:#e6f5ea}
    .mlsr table.leave-summary tbody tr:nth-child(even){background:#fafbfd}
    .mlsr table.leave-summary tbody tr:hover{background:#f0f4fb}
    .mlsr .pagination-bar{display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px;margin-top:12px;font-size:12.5px;color:#374151}
    .mlsr .page-size select{padding:4px 6px;border:1px solid #cbd2dc;border-radius:4px}
    .mlsr .page-nav{display:flex;gap:4px}
    .mlsr .page-btn{border:1px solid #cbd2dc;background:#fff;border-radius:4px;padding:5px 10px;cursor:pointer;font-size:12px;color:#1f2937}
    .mlsr .page-btn:hover:not(:disabled){background:#eef1f6}
    .mlsr .page-btn.active{background:#1e293b;color:#fff;border-color:#1e293b}
    .mlsr .page-btn:disabled{opacity:.4;cursor:not-allowed}
    .mlsr .empty-report{text-align:center;margin:70px auto;padding:28px;border:1px solid #e2e7ef;color:#725d21;max-width:600px}
    @media(max-width:850px){.mlsr{padding:0 8px}.mlsr table.leave-summary{font-size:10.5px}.mlsr .report-head{grid-template-columns:1fr 2fr}.mlsr .resort{display:none}.mlsr .meta{grid-template-columns:1fr 1fr}}
    @media print{
        @page{size:A3 landscape;margin:8mm}
        html,body,form#form1{margin:0!important;padding:0!important;width:100%!important;background:#fff!important}
        body>form#form1>nav.navbar,body>form#form1>footer,body>form#form1>.footer-wrapperx,body>.overlay-dark-sidebar,body>.customizer-overlay,body>#overlayer,.mlsr .report-toolbar,.mlsr .pagination-bar{display:none!important}
        body>form#form1>main{display:block!important;margin:0!important;padding:0!important}
        #ContentPlaceHolder1{display:block!important;margin:0!important;padding:0!important}
        .mlsr{max-width:none;margin:0;padding:0}
        .mlsr .sheet{border:0;padding:0}
        .mlsr table.leave-summary th.lv{min-width:34px}
        *{-webkit-print-color-adjust:exact;print-color-adjust:exact}
        .mlsr .table-wrap{overflow:visible;max-height:none;border:0}
        .mlsr table.leave-summary{min-width:0}
        .mlsr table.leave-summary thead th{position:static}
        .mlsr table.leave-summary thead{display:table-header-group}
        .mlsr table.leave-summary tr{page-break-inside:avoid}
        .mlsr table.leave-summary tbody tr.data-row{display:table-row!important}
        .mlsr .brand{font-size:19px}
        /* paper narrower than 850px (e.g. A4) triggers the mobile rule that hides the right logo; keep the full header in print */
        .mlsr .report-head{grid-template-columns:1fr 2fr 1fr}
        .mlsr .resort{display:block!important;font-size:19px}
        .mlsr .meta{grid-template-columns:1.5fr 1fr 2fr 1fr}
        /* signatures once, after the last row, never split across pages */
        .mlsr .signatures{display:flex!important;margin-top:50px;page-break-inside:avoid;break-inside:avoid}
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:Panel ID="pnlFilter" runat="server">
    <main class="main-content">
        <div class="Dashbord">
            <div class="crm mb-25">
                <div class="container-fulid">
                    <div class="card card-Vertical card-default card-md mt-4 mb-4">
                        <div class="card-header d-flex align-items-center">
                            <div class="card-title d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <h4>Monthwise Leave Summary Report</h4>
                                </div>
                            </div>
                        </div>
                        <div class="main_box_body_leave Lbody">
                            <div class="main_box_content_leave">
                                <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <div class="bonus_generation" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; width: 80%; margin: 0px auto; padding:20px">
                                            <asp:Label ID="lblMessage" runat="server" CssClass="message" ForeColor="Red" style="display:block;text-align:center;margin-bottom:10px"></asp:Label>
                                            <table class="division_table_leave1" style="margin: 0px auto">
                                                <tr>
                                                    <td>Company</td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlCompanyName" runat="server" CssClass="form-control select_width" Width="96%" AutoPostBack="True" OnSelectedIndexChanged="ddlCompanyName_SelectedIndexChanged"></asp:DropDownList>
                                                    </td>
                                                    <td>Employee Type</td>
                                                    <td>
                                                        <asp:RadioButtonList runat="server" ID="rblEmpType" RepeatDirection="Horizontal"></asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Year &nbsp;</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlYear" CssClass="form-control select_width" Width="96%"></asp:DropDownList>
                                                    </td>
                                                    <td>Month &nbsp;</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlMonth" CssClass="form-control select_width" Width="96%"></asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Card No. &nbsp;</td>
                                                    <td colspan="3">
                                                        <asp:TextBox ID="txtCardNo" runat="server" PlaceHolder="Leave empty for department-wise summary" CssClass="form-control text_box_width_import" Width="60%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <div id="workerlist" runat="server" class="id_card" style="background-color: white; width: 99%;">
                                                <div class="id_card_left EilistL">
                                                    <asp:ListBox ID="lstAll" runat="server" CssClass="lstdata EilistCec p-2" SelectionMode="Multiple"></asp:ListBox>
                                                </div>
                                                <div class="id_card_center EilistC">
                                                    <table style="margin-top: 0px;" class="employee_table">
                                                        <tr><td><asp:Button ID="btnAddItem" CssClass="arrow_button" runat="server" Text=">" OnClick="btnAddItem_Click" CausesValidation="false" /></td></tr>
                                                        <tr><td><asp:Button ID="btnAddAllItem" CssClass="arrow_button" runat="server" Text=">>" OnClick="btnAddAllItem_Click" CausesValidation="false" /></td></tr>
                                                        <tr><td><asp:Button ID="btnRemoveItem" CssClass="arrow_button" runat="server" Text="<" OnClick="btnRemoveItem_Click" CausesValidation="false" /></td></tr>
                                                        <tr><td><asp:Button ID="btnRemoveAllItem" CssClass="arrow_button" runat="server" Text="<<" OnClick="btnRemoveAllItem_Click" CausesValidation="false" /></td></tr>
                                                    </table>
                                                </div>
                                                <div class="id_card_right EilistR">
                                                    <asp:ListBox ID="lstSelected" SelectionMode="Multiple" CssClass="lstdata EilistCec" runat="server"></asp:ListBox>
                                                </div>
                                            </div>
                                            <div style="text-align:center;margin-top:18px">
                                                <asp:Button ID="btnPreview" runat="server" CssClass="btn btn-primary btn-default btn-squared px-30" Text="Preview Report" OnClick="btnPreview_Click" />
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Panel>
<div class="mlsr"><asp:Literal ID="reportContent" runat="server" /></div>
<script type="text/javascript">
    function goToNewTabandWindow(url) {
        window.open(url, '_blank');
    }
</script>
</asp:Content>
