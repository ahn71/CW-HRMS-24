<%@ Page Title="Monthly Attendance Sheet" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="MonthlyAttendanceReportV1.aspx.cs" Inherits="SigmaERP.hrms.attendance.MonthlyAttendanceReportV1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .mar{font-family:Arial,sans-serif;color:#111827;margin:18px auto;padding:0 16px;max-width:1900px}
    .sheet{background:#fff;border:1px solid #e3e7ee;border-radius:6px;padding:16px 18px 22px}
    .report-tools{display:flex;justify-content:flex-end;gap:8px;margin-bottom:10px}
    .report-tools button,.report-tools a{border:1px solid #cbd2dc;background:#f5f7fa;padding:7px 16px;border-radius:4px;cursor:pointer;color:#213b64;text-decoration:none;font:600 13px Arial}
    .report-tools button:hover,.report-tools a:hover{background:#e9eef6}

    .report-head{display:grid;grid-template-columns:1fr 2fr 1fr;align-items:center;text-align:center;margin:0 0 12px}
    .brand{font:26px Georgia,serif;letter-spacing:4px;color:#968443}
    .brand small{display:block;font:bold 11px Georgia,serif;letter-spacing:1px}
    .resort{font-size:19px}
    .heading .company{font-size:16px;font-weight:bold}
    .heading .address{font-size:11px;color:#586579;margin-top:2px}
    .heading h1{font-size:18px;margin:8px 0 3px;text-transform:uppercase;letter-spacing:1px}
    .heading small{color:#557643;font-weight:bold;font-size:12px}

    .meta{display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:10px;padding:8px 0 10px;border-top:2px solid #1f2937;border-bottom:1px solid #1f2937;text-align:center}
    .meta b{display:block;font-size:11px;color:#586579;margin-bottom:3px;text-transform:uppercase}
    .meta strong{font-size:13px}
    .sheet>.meta{margin-bottom:8px}
    .dept-section{margin-bottom:18px}
    .section-title{margin:0 0 6px;padding:6px 10px;font-size:13px;background:#eef1f5;border-left:4px solid #1f2937}
    .dept-section .table-wrap{max-height:none}

    .legend{display:flex;flex-wrap:wrap;justify-content:center;gap:4px 16px;padding:6px;margin:8px 0;font-size:11px;border:1px solid #d4dae3;background:#fafbfc}
    .legend b{display:inline-block;min-width:18px;padding:1px 3px;text-align:center;border:1px solid #cfd6e0;border-radius:3px}

    .table-wrap{width:100%;max-height:640px;overflow:auto;border:1px solid #263449}
    .attendance{border-collapse:collapse;width:100%;min-width:1500px;table-layout:fixed;font-size:11px}
    .attendance th,.attendance td{border:1px solid #9aa4b4;text-align:center;padding:4px 2px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
    .attendance thead th{background:#eef1f5;font-weight:bold;position:sticky;z-index:2}
    .attendance thead tr:nth-child(1) th{top:0;background:#dfe4ec;font-size:12px}
    .attendance thead tr:nth-child(2) th{top:25px}
    .attendance thead tr:nth-child(3) th{top:74px}
    .attendance th.weekday{writing-mode:vertical-rl;transform:rotate(180deg);height:45px;padding:2px;font-weight:500;font-size:10px}
    .attendance th.friday{background:#e3ebfa;color:#31579c}
    .attendance th.sum-head{background:#f6efdc}
    .attendance th.payable,.attendance td.payable{background:#eaf5ee;font-weight:bold}
    .attendance tbody tr:nth-child(even) td{background-color:#fafbfd}
    .attendance tbody tr:hover td{background-color:#fff9d9}
    .attendance tr.group td{background:#e8ebf0!important;text-align:left;font-weight:bold;padding:5px 8px;font-size:12px}
    .attendance td.left{text-align:left;padding-left:5px}
    .attendance td.muted{color:#4b5563}
    .attendance td.status{font-weight:bold}
    .attendance td.sum{font-weight:600}
    .attendance td.zero{color:#b0b7c3;font-weight:normal}
    .present{color:#17643a}
    .late{color:#9a5b00}
    .absent{color:#b42318;background:#fff1ef!important}
    .leave{color:#80520e;background:#fff8e8!important}
    .holiday{color:#31579c;background:#f2f6ff!important}

    .signatures{display:flex;justify-content:space-around;margin-top:60px;font-size:12px}
    .signatures span{border-top:1px solid #1f2937;padding-top:4px;min-width:160px;text-align:center}
    .empty-report{text-align:center;margin:70px auto;padding:28px;border:1px solid #e2e7ef;color:#725d21;max-width:600px;line-height:1.7}

    @media(max-width:850px){.report-head{grid-template-columns:1fr 2fr}.resort{display:none}.mar{padding:0 8px}.meta{grid-template-columns:1fr 1fr}}
    @media print{
        @page{size:A3 landscape;margin:6mm}
        html,body,form#form1{margin:0!important;padding:0!important;width:100%!important;background:#fff!important}
        body>form#form1>nav.navbar,body>form#form1>footer,body>form#form1>.footer-wrapperx,body>.overlay-dark-sidebar,body>.customizer-overlay,body>#overlayer,.report-tools{display:none!important}
        body>form#form1>main{display:block!important;margin:0!important;padding:0!important}
        #ContentPlaceHolder1{display:block!important;margin:0!important;padding:0!important}
        *{-webkit-print-color-adjust:exact;print-color-adjust:exact}
        .mar{max-width:none;margin:0;padding:0}
        .sheet{border:0;padding:0}
        .table-wrap{overflow:visible;max-height:none;border:0}
        .attendance{width:100%;min-width:0;font-size:7px}
        .attendance thead th{position:static}
        .attendance th,.attendance td{padding:2px 1px}
        .attendance th.weekday{height:32px}
        .attendance thead{display:table-header-group}
        .attendance tr{page-break-inside:avoid}
        .brand{font-size:19px}
        /* paper narrower than 850px (e.g. A4) triggers the mobile rule that hides the right logo; keep the full header in print */
        .report-head{grid-template-columns:1fr 2fr 1fr}
        .resort{display:block!important;font-size:19px}
        .meta{grid-template-columns:2fr 1fr 1fr 1fr}
        .signatures{margin-top:40px}
        .dept-section.next{page-break-before:always;break-before:page}
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="mar"><asp:Literal ID="reportContent" runat="server" /></div>
</asp:Content>
