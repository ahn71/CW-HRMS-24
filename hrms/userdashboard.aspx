<%@ Page Title="My Dashboard" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" %>

<%--<asp:Content ID="UserDashboardHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .user-dashboard { --ud-navy:#172554; --ud-primary:#3563e9; --ud-muted:#6b7280; --ud-border:#e9edf5; color:#172554; font-family:'Jost',sans-serif; padding:18px 4px 34px; }
        .user-dashboard * { box-sizing:border-box; }
        .ud-welcome { background:linear-gradient(115deg,#182b62,#315ccf); border-radius:18px; color:#fff; padding:25px 29px; margin-bottom:22px; position:relative; overflow:hidden; box-shadow:0 12px 30px rgba(41,79,178,.17); }
        .ud-welcome:after { content:''; position:absolute; width:215px; height:215px; border:35px solid rgba(255,255,255,.08); border-radius:50%; right:-58px; top:-99px; }
        .ud-welcome small { display:block; opacity:.76; letter-spacing:.4px; margin-bottom:4px; font-size:13px; }
        .ud-welcome h2 { color:#fff; font-size:25px; margin:0 0 5px; font-weight:700; }
        .ud-welcome p { margin:0; color:rgba(255,255,255,.82); font-size:14px; }
        .ud-period { position:absolute; right:28px; top:29px; z-index:1; background:rgba(255,255,255,.13); border:1px solid rgba(255,255,255,.2); border-radius:9px; padding:7px 11px; font-size:12px; color:#fff; cursor:pointer; }
        .ud-overview-row { display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:18px; margin-bottom:22px; }
        .ud-stat { background:#fff; border:1px solid var(--ud-border); border-radius:16px; padding:20px; display:flex; align-items:center; gap:15px; box-shadow:0 4px 14px rgba(32,55,110,.04); transition:transform .2s,box-shadow .2s; }
        .ud-stat:hover { transform:translateY(-3px); box-shadow:0 10px 22px rgba(32,55,110,.1); }
        .ud-stat-icon { width:48px; height:48px; border-radius:13px; display:flex; align-items:center; justify-content:center; font-size:22px; flex:0 0 48px; }
        .ud-stat.present .ud-stat-icon { color:#159a6e; background:#e8f8f1; } .ud-stat.absent .ud-stat-icon { color:#e05a68; background:#fff0f2; } .ud-stat.leave .ud-stat-icon { color:#8a5adf; background:#f2edff; }
        .ud-stat-label { display:block; color:var(--ud-muted); font-size:13px; margin-bottom:2px; } .ud-stat-value { font-size:27px; line-height:1; font-weight:700; color:#1d2d59; }
        .ud-panel { background:#fff; border:1px solid var(--ud-border); border-radius:16px; box-shadow:0 4px 14px rgba(32,55,110,.04); margin-bottom:22px; overflow:hidden; }
        .ud-panel-head { padding:19px 21px 15px; display:flex; align-items:center; justify-content:space-between; } .ud-panel-title { margin:0; font-size:17px; font-weight:700; color:#1c2b55; } .ud-panel-note { color:#8490a9; font-size:12px; }
        .ud-quick-menu { position:relative; display:flex; align-items:stretch; justify-content:center; } .ud-quick-toggle { width:100%; height:100%; min-height:88px; border:1px solid #dce5ff; border-radius:16px; padding:17px; display:flex; align-items:center; justify-content:center; background:linear-gradient(135deg,#f6f8ff,#edf2ff); color:#3563e9; cursor:pointer; transition:.2s; box-shadow:0 4px 14px rgba(32,55,110,.04); }
        .ud-quick-toggle:hover,.ud-quick-toggle[aria-expanded="true"] { border-color:#9db5fb; background:#edf2ff; transform:translateY(-2px); } .ud-quick-toggle:focus { outline:3px solid rgba(53,99,233,.18); outline-offset:2px; } .ud-quick-toggle-icon { width:50px; height:50px; border-radius:14px; display:flex; align-items:center; justify-content:center; color:#3563e9; background:#fff; font-size:24px; box-shadow:0 4px 10px rgba(53,99,233,.12); }
        .ud-quick-links { display:none; position:fixed; z-index:9999; inset:0; padding:18px; background:rgba(12,25,61,.45); align-items:center; justify-content:center; } .ud-quick-links.is-open { display:flex; animation:ud-fade-in .18s ease-out; } @keyframes ud-fade-in { from { opacity:0; } to { opacity:1; } }
        .ud-quick-modal-card { width:min(360px,100%); border-radius:16px; padding:17px; background:#fff; box-shadow:0 22px 60px rgba(9,22,57,.3); animation:ud-modal-in .2s ease-out; } @keyframes ud-modal-in { from { transform:translateY(12px) scale(.98); } to { transform:translateY(0) scale(1); } } .ud-modal-head { display:flex; align-items:center; justify-content:space-between; padding:0 3px 11px; border-bottom:1px solid #edf0f6; } .ud-modal-head h3 { margin:0; font-size:17px; color:#1c2b55; } .ud-modal-close { width:30px; height:30px; border:0; border-radius:8px; background:#f1f4fb; color:#657493; cursor:pointer; font-size:20px; line-height:1; } .ud-modal-close:hover { color:#df4d5d; background:#fff0f2; }
        .ud-quick-link { border-radius:10px; padding:12px 10px; margin-top:6px; text-decoration:none !important; color:#23325c !important; display:flex; align-items:center; gap:10px; transition:.16s; } .ud-quick-link:hover { background:#f1f5ff; } .ud-quick-icon { width:38px; height:38px; background:#eaf0ff; color:#3563e9; border-radius:10px; display:flex; align-items:center; justify-content:center; font-size:17px; flex:0 0 38px; } .ud-quick-link:nth-child(2) .ud-quick-icon { color:#10a678; background:#e7f8f1; } .ud-quick-link:nth-child(3) .ud-quick-icon { color:#e68c24; background:#fff3e3; } .ud-quick-link strong { font-size:14px; display:block; line-height:1.2; } .ud-quick-link span span { color:#8d98ae; display:block; font-size:11px; margin-top:2px; }
        .ud-tables { display:grid; grid-template-columns:1.2fr 1fr; gap:22px; align-items:start; }
        .ud-table-wrap { overflow-x:auto; max-height:390px; } .ud-table { width:100%; border-collapse:collapse; min-width:520px; } .ud-table th { background:#f7f9fd; color:#60708f; text-transform:uppercase; letter-spacing:.35px; font-size:11px; font-weight:600; padding:12px 17px; white-space:nowrap; } .ud-table td { border-top:1px solid #eef1f6; padding:12px 17px; font-size:13px; color:#334263; white-space:nowrap; }
        .ud-table tbody tr:hover { background:#fbfcff; } .ud-date { font-weight:600; color:#24365f; } .ud-day { color:#95a0b5; font-size:12px; }
        .ud-badge { font-size:11px; font-weight:600; padding:5px 9px; border-radius:20px; display:inline-block; } .ud-badge.present { color:#13835f; background:#e6f7ef; } .ud-badge.weekend { color:#c17b13; background:#fff3dd; } .ud-badge.leave { color:#8258d0; background:#f1ecff; }
        .ud-leave-name { display:flex; align-items:center; gap:9px; font-weight:600; color:#2d3d64; } .ud-leave-dot { width:9px; height:9px; border-radius:50%; background:#3563e9; } .ud-table tr:nth-child(2) .ud-leave-dot { background:#16a376; } .ud-table tr:nth-child(3) .ud-leave-dot { background:#e28a24; } .ud-table tr:nth-child(4) .ud-leave-dot { background:#8b61d4; }
        .ud-remaining { color:#16845f; font-weight:700; } .ud-avail { color:#596a8e; }
        @media(max-width:1199px) { .ud-overview-row { grid-template-columns:repeat(2,1fr); } }
        @media(max-width:991px) { .ud-tables { grid-template-columns:1fr; } }
        @media(max-width:767px) { .user-dashboard { padding-top:10px; } .ud-welcome { padding:22px 18px; } .ud-welcome h2 { font-size:21px; } .ud-period { position:static; display:inline-block; margin-top:13px; } .ud-overview-row { grid-template-columns:1fr; } .ud-stat { padding:17px; } .ud-quick-links { right:auto; left:0; top:calc(100% + 8px); width:100%; } .ud-panel-head { padding:17px 15px 13px; } .ud-table th,.ud-table td { padding-left:14px; padding-right:14px; } }
    </style>
</asp:Content>--%>

<asp:Content ID="UserDashboardBody" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- Body-level fallback keeps the dashboard styled if a deployment omits the master's head placeholder. --%>
    <style>
        .user-dashboard{font-family:Jost,Arial,sans-serif;color:#172554;padding:18px 4px 34px}.ud-welcome{background:linear-gradient(115deg,#182b62,#315ccf);border-radius:18px;color:#fff;padding:25px 29px;margin-bottom:22px;box-shadow:0 12px 30px rgba(41,79,178,.17)}.ud-welcome h2{color:#fff;margin:0;font-size:25px}.ud-welcome p,.ud-welcome small{color:rgba(255,255,255,.82)}.ud-overview-row{display:grid;grid-template-columns:repeat(5,minmax(0,1fr));gap:18px;margin-bottom:22px}.ud-stat,.ud-panel{background:#fff;border:1px solid #e9edf5;border-radius:16px;box-shadow:0 4px 14px rgba(32,55,110,.06)}.ud-stat{padding:20px;display:flex;align-items:center;gap:15px}.ud-stat-icon{width:48px;height:48px;border-radius:13px;display:flex;align-items:center;justify-content:center;font-size:22px}.present .ud-stat-icon{background:#e8f8f1;color:#159a6e}.absent .ud-stat-icon{background:#fff0f2;color:#e05a68}.late .ud-stat-icon{background:#fef3c7;color:#b45309}.leave .ud-stat-icon{background:#f2edff;color:#8a5adf}.ud-stat-label{display:block;color:#6b7280;font-size:13px}.ud-stat-value{font-size:27px;font-weight:700}.ud-quick-toggle{width:100%;min-height:88px;border:1px solid #dce5ff;border-radius:16px;padding:17px;display:flex;align-items:center;gap:13px;background:#edf2ff;color:#23325c;cursor:pointer}.ud-quick-toggle-icon,.ud-quick-icon{display:flex;align-items:center;justify-content:center;background:#fff;color:#3563e9;border-radius:11px}.ud-quick-toggle-icon{width:47px;height:47px;font-size:21px}.ud-chevron{margin-left:auto}.ud-quick-links{display:none;position:fixed;z-index:9999;inset:0;padding:18px;background:rgba(12,25,61,.48);align-items:center;justify-content:center}.ud-quick-links.is-open{display:flex}.ud-quick-modal-card{width:min(440px,100%);background:#fff;border-radius:18px;padding:21px;box-shadow:0 22px 60px rgba(9,22,57,.3)}.ud-modal-head{display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #edf0f6;padding-bottom:13px}.ud-modal-head h3{margin:0}.ud-modal-close{border:0;border-radius:8px;padding:2px 10px;font-size:22px;cursor:pointer}.ud-quick-link{display:flex;align-items:center;gap:10px;padding:13px 10px;margin-top:7px;border-radius:10px;color:#23325c!important;text-decoration:none!important}.ud-quick-link:hover{background:#f1f5ff}.ud-quick-icon{width:38px;height:38px;background:#eaf0ff;font-size:17px}.ud-panel{margin-bottom:22px;overflow:hidden}.ud-panel-head{padding:19px 21px 15px;display:flex;justify-content:space-between}.ud-panel-title{margin:0;font-size:17px}.ud-panel-note,.ud-day{color:#8490a9}.ud-tables{display:grid;grid-template-columns:1.2fr 1fr;gap:22px}.ud-table-wrap{overflow:auto;max-height:390px}.ud-table{width:100%;border-collapse:collapse;min-width:580px}.ud-table th{background:#f7f9fd;color:#60708f;padding:12px 17px;font-size:11px;text-transform:uppercase}.ud-table td{padding:12px 17px;border-top:1px solid #eef1f6;color:#334263}.ud-table .ud-day{font-size:11px}.ud-table-compact{min-width:460px}.ud-table-compact th{padding:9px 12px;font-size:10px}.ud-table-compact td{padding:9px 12px;font-size:12px}.ud-table-compact .ud-leave-name{font-size:12.5px}.ud-badge{padding:5px 9px;border-radius:20px;font-size:11px}.ud-badge.present{background:#e6f7ef;color:#13835f}.ud-badge.weekend{background:#fff3dd;color:#c17b13}.ud-badge.leave{background:#f1ecff;color:#8258d0}.ud-badge.late{background:#fef3c7;color:#b45309}.ud-badge.absent{background:#fff0f2;color:#c9394a}@media(max-width:1199px){.ud-overview-row{grid-template-columns:repeat(3,1fr)}}@media(max-width:991px){.ud-tables{grid-template-columns:1fr}.ud-overview-row{grid-template-columns:repeat(2,1fr)}}@media(max-width:767px){.ud-overview-row{grid-template-columns:1fr}.ud-welcome{padding:22px 18px}.user-dashboard{padding-top:10px}}
    </style>
    <style>
        /* Quick Links: anchored dropdown panel (not a fixed full-screen modal) so it can never be
           intercepted by the theme's other fixed-position overlays (#overlayer, .customizer-overlay, etc). */
        .ud-quick-menu{position:relative;display:flex;align-items:stretch;justify-content:center}
        .ud-quick-toggle{width:100%;height:100%;min-height:88px;border:1px solid #dce5ff;border-radius:16px;padding:17px;display:flex;align-items:center;justify-content:center;background:linear-gradient(135deg,#f6f8ff,#edf2ff);color:#3563e9;cursor:pointer;transition:.2s;box-shadow:0 4px 14px rgba(32,55,110,.04)}
        .ud-quick-toggle:hover,.ud-quick-toggle[aria-expanded="true"]{border-color:#9db5fb;background:#edf2ff;transform:translateY(-2px)}
        .ud-quick-toggle:focus{outline:3px solid rgba(53,99,233,.18);outline-offset:2px}
        .ud-quick-toggle-icon{width:50px;height:50px;border-radius:14px;display:flex;align-items:center;justify-content:center;color:#3563e9;background:#fff;font-size:24px;box-shadow:0 4px 10px rgba(53,99,233,.12)}
        .ud-quick-panel{display:none;position:absolute;top:calc(100% + 8px);right:0;width:min(230px,82vw);background:#fff;border-radius:14px;padding:8px;border:1px solid #edf0f6;box-shadow:0 16px 38px rgba(9,22,57,.18);z-index:500}
        .ud-quick-panel.ud-quick-open{display:block;animation:udQuickPanelIn .15s ease-out}
        @keyframes udQuickPanelIn{from{opacity:0;transform:translateY(-6px)}to{opacity:1;transform:translateY(0)}}
        .ud-quick-panel-head{display:flex;align-items:center;justify-content:space-between;padding:4px 6px 7px;margin-bottom:2px;border-bottom:1px solid #edf0f6}
        .ud-quick-panel-head span{font-size:11px;font-weight:700;color:#1c2b55;text-transform:uppercase;letter-spacing:.4px}
        .ud-quick-panel-close{width:22px;height:22px;border:0;border-radius:7px;background:#f1f4fb;color:#657493;cursor:pointer;font-size:15px;line-height:1}
        .ud-quick-panel-close:hover{color:#df4d5d;background:#fff0f2}
        .ud-quick-panel .ud-quick-link{padding:8px;gap:8px;margin-top:2px}
        .ud-quick-panel .ud-quick-icon{width:30px;height:30px;font-size:14px;flex:0 0 30px}
        .ud-quick-panel .ud-quick-link strong{display:block;font-size:12.5px;line-height:1.25}
        .ud-quick-panel .ud-quick-link span span{display:block;font-size:10.5px;color:#8d98ae;margin-top:1px}
        @media(max-width:767px){.ud-quick-panel{right:0;left:auto}}
    </style>
    <div class="user-dashboard">
        <section class="ud-welcome">
            <small>EMPLOYEE SELF SERVICE</small>
            <h2>Good morning, <%= Session["__GetUserFullName__"] %>!</h2>
            <p>Here is a quick view of your attendance and leave information.</p>
            <select class="ud-period" id="dashboardMonth" aria-label="Select month"></select>
        </section>

        <section class="ud-overview-row" aria-label="Attendance overview">
            <article class="ud-stat present"><div class="ud-stat-icon"><i class="uil uil-user-check"></i></div><div><span class="ud-stat-label">Present Days</span><span class="ud-stat-value" id="statPresent">0</span></div></article>
            <article class="ud-stat absent"><div class="ud-stat-icon"><i class="uil uil-user-times"></i></div><div><span class="ud-stat-label">Absent Days</span><span class="ud-stat-value" id="statAbsent">0</span></div></article>
            <article class="ud-stat late"><div class="ud-stat-icon"><i class="uil uil-clock-nine"></i></div><div><span class="ud-stat-label">Late Days</span><span class="ud-stat-value" id="statLate">0</span></div></article>
            <article class="ud-stat leave"><div class="ud-stat-icon"><i class="uil uil-calendar-alt"></i></div><div><span class="ud-stat-label">Leave Taken</span><span class="ud-stat-value" id="statLeaveTaken">0</span></div></article>
            <div class="ud-quick-menu">
                <button type="button" class="ud-quick-toggle" id="quickLinksToggle" aria-label="Open quick links" aria-expanded="false" aria-controls="quickLinksList"><span class="ud-quick-toggle-icon"><i class="uil uil-th-large"></i></span></button>
                <div class="ud-quick-panel" id="quickLinksList" role="menu" aria-label="Quick links">
                    <div class="ud-quick-panel-head"><span>Quick Links</span><button type="button" class="ud-quick-panel-close" id="quickLinksClose" aria-label="Close quick links">&times;</button></div>
                    <a class="ud-quick-link" role="menuitem" href="<%= ResolveUrl("~/hrms/Leave/leaveApplication.aspx") %>"><span class="ud-quick-icon"><i class="uil uil-file-plus-alt"></i></span><span><strong>Leave Application</strong><span>Apply for a new leave</span></span></a>
                    <a class="ud-quick-link" role="menuitem" href="<%= ResolveUrl("~/attendance/att_report_daterange.aspx") %>"><span class="ud-quick-icon"><i class="uil uil-chart-line"></i></span><span><strong>Attendance Report</strong><span>View attendance history</span></span></a>
                    <a class="ud-quick-link" role="menuitem" href="<%= ResolveUrl("~/attendance/job_card.aspx") %>"><span class="ud-quick-icon"><i class="uil uil-clipboard-notes"></i></span><span><strong>Job Card Report</strong><span>Review work-time details</span></span></a>
                </div>
            </div>
        </section>

        <div class="ud-tables">
            <section class="ud-panel">
                <div class="ud-panel-head"><h3 class="ud-panel-title">Attendance Status</h3><span class="ud-panel-note" id="attendanceRange">1st to today</span></div>
                <div class="ud-table-wrap"><table class="ud-table"><thead><tr><th>Date</th><th>Day</th><th>Shift</th><th>In</th><th>Out</th><th>Status</th></tr></thead><tbody id="attendanceRows"></tbody></table></div>
            </section>
            <section class="ud-panel">
                <div class="ud-panel-head"><h3 class="ud-panel-title">Leave Status</h3><span class="ud-panel-note">Current leave balance</span></div>
                <div class="ud-table-wrap"><table class="ud-table ud-table-compact"><thead><tr><th>Leave Type</th><th>Assigned</th><th>Taken</th><th>Remaining</th></tr></thead><tbody id="leaveRows"></tbody></table></div>
            </section>
        </div>
    </div>
    <script>
        (function () {
            var quickLinksToggle = document.getElementById('quickLinksToggle'), quickLinksList = document.getElementById('quickLinksList'), quickLinksClose = document.getElementById('quickLinksClose');
            function openQuickLinks() { quickLinksToggle.setAttribute('aria-expanded', 'true'); quickLinksList.classList.add('ud-quick-open'); }
            function closeQuickLinks() { quickLinksToggle.setAttribute('aria-expanded', 'false'); quickLinksList.classList.remove('ud-quick-open'); }
            quickLinksToggle.addEventListener('click', function (event) {
                event.stopPropagation();
                if (quickLinksList.classList.contains('ud-quick-open')) { closeQuickLinks(); } else { openQuickLinks(); }
            });
            quickLinksClose.addEventListener('click', function (event) { event.stopPropagation(); closeQuickLinks(); });
            document.addEventListener('click', function (event) {
                if (quickLinksList.classList.contains('ud-quick-open') && !quickLinksList.contains(event.target) && event.target !== quickLinksToggle) { closeQuickLinks(); }
            });
            document.addEventListener('keydown', function (event) { if (event.key === 'Escape') closeQuickLinks(); });

            var rootUrl = '<%= Session["__RootUrl__"] %>';
            var companyId = '<%= Session["__GetCompanyId__"] %>';
            var empId = '<%= Session["__GetEmpId__"] %>';
            var token = '<%= Session["__UserToken__"] %>';
            var leaveBalanceUrl = rootUrl + '/api/Leave/leaveBalanceV1';
            var attendanceJobCardUrl = rootUrl + '/api/Attendance/attendance/jobcard';

            var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
            var days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
            var now = new Date(), year = now.getFullYear(), month = now.getMonth(), today = now.getDate();
            var dashboardMonth = document.getElementById('dashboardMonth');
            for (var m = 0; m < months.length; m++) { dashboardMonth.options.add(new Option(months[m] + ' ' + year, m, false, m === month)); }

            function pad2(n) { return String(n).padStart(2, '0'); }

            function formatTime12(h, m, s) {
                var hourNum = parseInt(h, 10), minNum = parseInt(m, 10), secNum = parseInt(s, 10);
                if (!hourNum && !minNum && !secNum) return '';
                var period = hourNum >= 12 ? 'PM' : 'AM';
                var hour12 = hourNum % 12;
                if (hour12 === 0) hour12 = 12;
                return pad2(hour12) + ':' + pad2(minNum) + ' ' + period;
            }

            function ApiCall(url, params) {
                return new Promise(function (resolve, reject) {
                    $.ajax({
                        url: url,
                        type: 'GET',
                        data: params,
                        headers: { 'Authorization': 'Bearer ' + token, 'Content-Type': 'application/json' },
                        success: function (data) { resolve(data); },
                        error: function (xhr, status, error) { reject({ status: status, error: error }); }
                    });
                });
            }

            function loadLeaveBalance() {
                var leaveDate = year + '-' + pad2(month + 1) + '-' + pad2(today);
                ApiCall(leaveBalanceUrl, { companyId: companyId, empId: empId, leaveDate: leaveDate }).then(function (response) {
                    var rowsHtml = '', totalTaken = 0;
                    if (response.statusCode === 200 && response.data && response.data.length > 0) {
                        response.data.forEach(function (item) {
                            totalTaken += Number(item.takenDays) || 0;
                            rowsHtml += '<tr><td><span class="ud-leave-name"><i class="ud-leave-dot"></i>' + item.leaveName + '</span></td><td class="ud-avail">' + item.assignedDays + ' days</td><td>' + item.takenDays + ' days</td><td class="ud-remaining">' + item.remainingDays + ' days</td></tr>';
                        });
                    } else {
                        rowsHtml = '<tr><td colspan="4" class="ud-panel-note">No leave data found</td></tr>';
                    }
                    document.getElementById('leaveRows').innerHTML = rowsHtml;
                    document.getElementById('statLeaveTaken').textContent = totalTaken;
                }).catch(function () {
                    document.getElementById('leaveRows').innerHTML = '<tr><td colspan="4" class="ud-panel-note">Failed to load leave data</td></tr>';
                });
            }

            function loadAttendance(selectedYear, selectedMonth) {
                var monthName = selectedYear + '-' + pad2(selectedMonth + 1);
                document.getElementById('attendanceRange').textContent = months[selectedMonth] + ' ' + selectedYear;
                ApiCall(attendanceJobCardUrl, { companyId: companyId, empId: empId, monthName: monthName }).then(function (response) {
                    var rowsHtml = '', present = 0, absent = 0, late = 0;
                    if (response.statusCode === 200 && response.data && response.data.length > 0) {
                        response.data.forEach(function (item) {
                            if (item.StateStatus === 'Present') present++;
                            if (item.StateStatus === 'Absent') absent++;
                            if (item.ATTStatus === 'L' || (item.LateTime && item.LateTime !== '00:00:00')) late++;

                            var dateParts = item.ATTDate.split('-');
                            var rowDate = new Date(dateParts[2], dateParts[1] - 1, dateParts[0]);
                            var inTime = formatTime12(item.InHour, item.InMin, item.InSec);
                            var outTime = formatTime12(item.OutHour, item.OutMin, item.OutSec);

                            var badgeClass = 'absent', badgeText = item.StateStatus;
                            if (item.StateStatus === 'Present') { badgeClass = (item.ATTStatus === 'L') ? 'late' : 'present'; badgeText = (item.ATTStatus === 'L') ? 'Late' : 'Present'; }
                            else if (item.StateStatus === 'Holiday') { badgeClass = 'weekend'; badgeText = 'Holiday'; }

                            rowsHtml += '<tr><td class="ud-date">' + item.ATTDate + '</td><td class="ud-day">' + days[rowDate.getDay()] + '</td><td>' + (item.SftName || '') + '</td><td>' + inTime + '</td><td>' + outTime + '</td><td><span class="ud-badge ' + badgeClass + '">' + badgeText + '</span></td></tr>';
                        });
                    } else {
                        rowsHtml = '<tr><td colspan="6" class="ud-panel-note">No attendance data found</td></tr>';
                    }
                    document.getElementById('attendanceRows').innerHTML = rowsHtml;
                    document.getElementById('statPresent').textContent = present;
                    document.getElementById('statAbsent').textContent = absent;
                    document.getElementById('statLate').textContent = late;
                }).catch(function () {
                    document.getElementById('attendanceRows').innerHTML = '<tr><td colspan="6" class="ud-panel-note">Failed to load attendance data</td></tr>';
                });
            }

            dashboardMonth.addEventListener('change', function () { loadAttendance(year, Number(dashboardMonth.value)); });

            loadLeaveBalance();
            loadAttendance(year, month);
        }());
    </script>
</asp:Content>
