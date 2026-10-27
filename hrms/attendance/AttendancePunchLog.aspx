<%@ Page Title="Attendance Punch Log" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="AttendancePunchLog.aspx.cs" Inherits="SigmaERP.hrms.attendance.AttendancePunchLog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pl-page { padding: 1.5rem; font-family: 'Segoe UI', sans-serif; background: #f5f6fa; min-height: 100vh; }
        .pl-page *, .pl-page *::before, .pl-page *::after { box-sizing: border-box; }

        /* Header */
        .pl-header { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; margin-bottom: 1.25rem; }
        .pl-title { display: flex; align-items: center; gap: 12px; }
        .pl-title-icon {
            width: 42px; height: 42px; border-radius: 10px; display: flex; align-items: center; justify-content: center;
            background: linear-gradient(135deg, #2563eb, #7c3aed); color: #fff; font-size: 20px; box-shadow: 0 4px 12px rgba(37,99,235,.25);
        }
        .pl-title h1 { font-size: 19px; font-weight: 600; color: #1e293b; margin: 0; }
        .pl-title p { font-size: 12px; color: #94a3b8; margin: 2px 0 0; }
        .pl-badge { font-size: 11px; background: #eff6ff; color: #2563eb; padding: 3px 10px; border-radius: 20px; font-weight: 500; border: 1px solid #bfdbfe; }

        /* Stat tiles */
        .pl-stats { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; margin-bottom: 1rem; }
        .pl-stat { background: #fff; border: 1px solid #e2e8f0; border-radius: 12px; padding: .9rem 1.1rem; box-shadow: 0 1px 3px rgba(0,0,0,.04); }
        .pl-stat span { font-size: 11px; color: #64748b; text-transform: uppercase; letter-spacing: .05em; font-weight: 600; }
        .pl-stat strong { display: block; font-size: 20px; color: #1e293b; margin-top: 4px; font-weight: 600; }
        .pl-stat.blue { border-left: 4px solid #2563eb; }
        .pl-stat.green { border-left: 4px solid #16a34a; }
        .pl-stat.violet { border-left: 4px solid #7c3aed; }
        .pl-stat strong.small { font-size: 14px; line-height: 28px; }

        /* Filter card */
        .pl-card { background: #fff; border: 1px solid #e2e8f0; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,.04); }
        .pl-filter { padding: 1.1rem 1.25rem; margin-bottom: 1rem; }
        .pl-filter-head { font-size: 11px; font-weight: 600; color: #64748b; text-transform: uppercase; letter-spacing: .06em; margin-bottom: .9rem; }
        .pl-filter-row { display: grid; grid-template-columns: 1.4fr 1fr 1fr auto; gap: 12px; align-items: end; }
        .pl-field { display: flex; flex-direction: column; gap: 5px; }
        .pl-field label { font-size: 12px; color: #475569; font-weight: 500; margin: 0; }
        .pl-field input, .pl-field select {
            height: 38px; border: 1px solid #cbd5e1; border-radius: 8px; padding: 0 10px; font-size: 13px; color: #1e293b;
            outline: none; background: #fff; transition: border-color .15s, box-shadow .15s; width: 100%;
        }
        .pl-field input:focus, .pl-field select:focus { border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59,130,246,.12); }
        .pl-btns { display: flex; gap: 8px; }
        .pl-btn {
            height: 38px; padding: 0 16px; border-radius: 8px; font-size: 13px; font-weight: 500; cursor: pointer; border: none;
            display: inline-flex; align-items: center; gap: 6px; white-space: nowrap; transition: all .15s;
        }
        .pl-btn-primary { background: #2563eb; color: #fff; }
        .pl-btn-primary:hover { background: #1d4ed8; }
        .pl-btn-primary:disabled { opacity: .65; cursor: not-allowed; }
        .pl-btn-light { background: #fff; border: 1px solid #cbd5e1; color: #475569; }
        .pl-btn-light:hover { background: #f8fafc; }

        /* Table card */
        .pl-toolbar { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px; padding: .9rem 1.25rem; border-bottom: 1px solid #e2e8f0; }
        .pl-toolbar-left { display: flex; align-items: center; gap: 10px; }
        .pl-toolbar-title { font-size: 14px; font-weight: 600; color: #1e293b; }
        .pl-count { font-size: 12px; background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 20px; padding: 2px 10px; color: #475569; }
        .pl-toolbar-right { display: flex; align-items: center; gap: 10px; }
        .pl-search { position: relative; }
        .pl-search input {
            height: 36px; width: 280px; border: 1px solid #cbd5e1; border-radius: 8px; padding: 0 12px 0 32px; font-size: 13px; outline: none;
        }
        .pl-search input:focus { border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59,130,246,.12); }
        .pl-search::before { content: '\1F50D'; position: absolute; left: 10px; top: 50%; transform: translateY(-50%); font-size: 12px; opacity: .55; }
        .pl-size { height: 36px; border: 1px solid #cbd5e1; border-radius: 8px; padding: 0 8px; font-size: 13px; background: #fff; }

        .pl-table-wrap { position: relative; overflow-x: auto; min-height: 260px; }
        .pl-table { width: 100%; border-collapse: collapse; font-size: 13px; margin: 0; }
        .pl-table thead th {
            position: sticky; top: 0; padding: .7rem 1rem; text-align: left; font-size: 11px; font-weight: 600; color: #64748b;
            text-transform: uppercase; letter-spacing: .05em; border-bottom: 1px solid #e2e8f0; background: #f8fafc; white-space: nowrap;
        }
        .pl-table tbody tr { border-bottom: 1px solid #f1f5f9; transition: background .1s; }
        .pl-table tbody tr:nth-child(even) { background: #fcfdff; }
        .pl-table tbody tr:hover { background: #f1f5ff; }
        .pl-table td { padding: .7rem 1rem; color: #1e293b; vertical-align: middle; white-space: nowrap; }
        .pl-table th:first-child, .pl-table td:first-child { padding-left: 1.25rem; }

        .pl-sl { color: #94a3b8; font-size: 12px; }
        .pl-emp { display: flex; align-items: center; gap: 10px; }
        .pl-avatar {
            width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 12px; font-weight: 600; color: #fff; flex-shrink: 0;
        }
        .pl-emp-name { font-weight: 500; }
        .pl-prox { font-family: Consolas, monospace; font-size: 12px; color: #2563eb; font-weight: 600; background: #eff6ff; padding: 2px 8px; border-radius: 6px; }
        .pl-muted { color: #64748b; }
        .pl-date { font-size: 12px; color: #475569; }
        .pl-time { font-family: Consolas, monospace; font-size: 12px; font-weight: 600; color: #0f766e; background: #f0fdfa; padding: 2px 8px; border-radius: 6px; }
        .pl-src { font-size: 11px; font-weight: 500; padding: 3px 10px; border-radius: 20px; border: 1px solid; }
        .pl-src.c0 { background: #f0fdf4; color: #15803d; border-color: #bbf7d0; }
        .pl-src.c1 { background: #fff7ed; color: #c2410c; border-color: #fed7aa; }
        .pl-src.c2 { background: #f5f3ff; color: #6d28d9; border-color: #ddd6fe; }
        .pl-src.c3 { background: #ecfeff; color: #0e7490; border-color: #a5f3fc; }
        mark.pl-hl { background: #fef08a; padding: 0; border-radius: 2px; }

        .pl-empty { padding: 3.5rem 1rem; text-align: center; color: #94a3b8; }
        .pl-empty .icon { font-size: 34px; display: block; margin-bottom: .6rem; }
        .pl-empty p { font-size: 13px; margin: 0; }

        /* Loader */
        .pl-loader {
            position: absolute; inset: 0; background: rgba(255,255,255,.75); backdrop-filter: blur(1px);
            display: none; align-items: center; justify-content: center; flex-direction: column; gap: 10px; z-index: 5;
        }
        .pl-loader.show { display: flex; }
        .pl-spinner { width: 42px; height: 42px; border: 4px solid #dbeafe; border-top-color: #2563eb; border-radius: 50%; animation: plspin .7s linear infinite; }
        .pl-loader span { font-size: 13px; color: #475569; font-weight: 500; }
        .pl-progress { position: absolute; top: 0; left: 0; height: 3px; width: 0; background: linear-gradient(90deg, #2563eb, #7c3aed); z-index: 6; }
        .pl-progress.run { animation: plbar 1.4s ease-in-out infinite; }
        @keyframes plspin { to { transform: rotate(360deg); } }
        @keyframes plbar { 0% { left: 0; width: 0; } 50% { left: 20%; width: 60%; } 100% { left: 100%; width: 0; } }

        /* Footer / pager */
        .pl-footer { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px; padding: .8rem 1.25rem; border-top: 1px solid #e2e8f0; }
        .pl-info { font-size: 12px; color: #64748b; }
        .pl-pager { display: flex; gap: 4px; flex-wrap: wrap; }
        .pl-pager button {
            min-width: 32px; height: 32px; padding: 0 8px; border: 1px solid #e2e8f0; background: #fff; border-radius: 6px;
            font-size: 12px; color: #475569; cursor: pointer;
        }
        .pl-pager button:hover:not(:disabled) { background: #eff6ff; border-color: #bfdbfe; color: #2563eb; }
        .pl-pager button.active { background: #2563eb; border-color: #2563eb; color: #fff; }
        .pl-pager button:disabled { opacity: .45; cursor: not-allowed; }
        .pl-pager .dots { padding: 0 4px; line-height: 32px; color: #94a3b8; }

        /* Toast */
        #plToast {
            position: fixed; bottom: 1.5rem; right: 1.5rem; background: #fff; border: 1px solid #fca5a5; border-radius: 8px;
            padding: .75rem 1rem; font-size: 13px; color: #1e293b; box-shadow: 0 4px 16px rgba(0,0,0,.1); z-index: 9999;
            transform: translateY(150%); transition: transform .25s ease; max-width: 360px;
        }
        #plToast.show { transform: translateY(0); }

        @media (max-width: 992px) {
            .pl-filter-row { grid-template-columns: 1fr 1fr; }
            .pl-search input { width: 200px; }
        }
        @media (max-width: 600px) {
            .pl-page { padding: 1rem; }
            .pl-filter-row, .pl-stats { grid-template-columns: 1fr; }
            .pl-toolbar-right { width: 100%; }
            .pl-search { flex: 1; }
            .pl-search input { width: 100%; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="pl-page">

    <div class="pl-header">
        <div class="pl-title">
            <div class="pl-title-icon">&#x23F1;</div>
            <div>
                <h1>Attendance Punch Log</h1>
                <p>Device / external punch records of active employees</p>
            </div>
        </div>
        <span class="pl-badge">Attendance</span>
    </div>

    <div class="pl-stats">
        <div class="pl-stat blue"><span>Total Punches</span><strong id="stTotal">0</strong></div>
        <div class="pl-stat green"><span>Date Range</span><strong class="small" id="stRange">&mdash;</strong></div>
        <div class="pl-stat violet"><span>Department</span><strong class="small" id="stDept">All</strong></div>
    </div>

    <div class="pl-card pl-filter">
        <div class="pl-filter-head">&#x1F50E; Search Filters</div>
        <div class="pl-filter-row">
            <div class="pl-field">
                <label for="ddlDepartment">Department</label>
                <asp:DropDownList ID="ddlDepartment" runat="server" ClientIDMode="Static"></asp:DropDownList>
            </div>
            <div class="pl-field">
                <label for="txtFromDate">From Date</label>
                <asp:TextBox ID="txtFromDate" runat="server" ClientIDMode="Static" TextMode="Date"></asp:TextBox>
            </div>
            <div class="pl-field">
                <label for="txtToDate">To Date</label>
                <asp:TextBox ID="txtToDate" runat="server" ClientIDMode="Static" TextMode="Date"></asp:TextBox>
            </div>
            <div class="pl-btns">
                <button type="button" class="pl-btn pl-btn-primary" id="btnSearch" onclick="plSearch()">&#x1F50D; Search</button>
                <button type="button" class="pl-btn pl-btn-light" onclick="plReset()" title="Reset filters">&#x21BA; Reset</button>
            </div>
        </div>
    </div>

    <div class="pl-card">
        <div class="pl-toolbar">
            <div class="pl-toolbar-left">
                <span class="pl-toolbar-title">Punch Records</span>
                <span class="pl-count" id="plCount">0 records</span>
            </div>
            <div class="pl-toolbar-right">
                <div class="pl-search">
                    <input type="text" id="plSearchAny" placeholder="Search anything... name, card, dept, time" autocomplete="off" />
                </div>
                <select class="pl-size" id="plPageSize" onchange="plLoad(1)">
                    <option value="25">25</option>
                    <option value="50" selected="selected">50</option>
                    <option value="100">100</option>
                    <option value="500">500</option>
                </select>
            </div>
        </div>

        <div class="pl-table-wrap">
            <div class="pl-progress" id="plProgress"></div>
            <div class="pl-loader" id="plLoader">
                <div class="pl-spinner"></div>
                <span>Loading punch records...</span>
            </div>
            <table class="pl-table">
                <thead>
                    <tr>
                        <th>SL</th>
                        <th>Employee</th>
                        <th>Card No</th>
                        <th>Department</th>
                        <th>Designation</th>
                        <th>Punch Date</th>
                        <th>Punch Time</th>
                        <th>Source</th>
                    </tr>
                </thead>
                <tbody id="plBody">
                    <tr><td colspan="8"><div class="pl-empty"><span class="icon">&#x1F4CB;</span><p>Select filters and click Search</p></div></td></tr>
                </tbody>
            </table>
        </div>

        <div class="pl-footer">
            <div class="pl-info" id="plInfo">Showing 0 of 0</div>
            <div class="pl-pager" id="plPager"></div>
        </div>
    </div>
</div>

<div id="plToast"></div>

<script>
    var plState = { page: 1, total: 0, request: null, timer: null, search: '' };
    var plColors = ['#2563eb', '#7c3aed', '#0d9488', '#ea580c', '#db2777', '#4f46e5', '#16a34a', '#ca8a04'];
    var plSources = {};

    function plEsc(s) {
        return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
            return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
        });
    }

    function plHl(s) {
        var text = plEsc(s), q = plState.search;
        if (!q) return text;
        var re = new RegExp('(' + plEsc(q).replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + ')', 'ig');
        return text.replace(re, '<mark class="pl-hl">$1</mark>');
    }

    function plInitials(name) {
        var p = String(name || '').trim().split(/\s+/);
        return ((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase() || '?';
    }

    function plColor(name) {
        var h = 0, s = String(name || '');
        for (var i = 0; i < s.length; i++) h = (h * 31 + s.charCodeAt(i)) >>> 0;
        return plColors[h % plColors.length];
    }

    function plSourceClass(src) {
        var k = String(src || '').toLowerCase();
        if (!(k in plSources)) plSources[k] = Object.keys(plSources).length % 4;
        return 'c' + plSources[k];
    }

    function plFmtDate(v) {
        if (!v) return '';
        var d = new Date(v + 'T00:00:00');
        return d.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
    }

    function plLoading(on) {
        document.getElementById('plLoader').classList.toggle('show', on);
        document.getElementById('plProgress').classList.toggle('run', on);
        document.getElementById('btnSearch').disabled = on;
    }

    function plToast(msg) {
        var t = document.getElementById('plToast');
        t.textContent = msg;
        t.classList.add('show');
        clearTimeout(window._plToastTimer);
        window._plToastTimer = setTimeout(function () { t.classList.remove('show'); }, 3500);
    }

    function plSearch() { plLoad(1); }

    function plReset() {
        var today = new Date();
        var iso = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        document.getElementById('ddlDepartment').selectedIndex = 0;
        document.getElementById('txtFromDate').value = iso;
        document.getElementById('txtToDate').value = iso;
        document.getElementById('plSearchAny').value = '';
        plLoad(1);
    }

    function plLoad(page) {
        var from = document.getElementById('txtFromDate').value;
        var to = document.getElementById('txtToDate').value;
        if (!from || !to) { plToast('Please select From Date and To Date.'); return; }
        if (from > to) { plToast('From Date can not be greater than To Date.'); return; }

        var ddl = document.getElementById('ddlDepartment');
        plState.page = page;
        plState.search = document.getElementById('plSearchAny').value.trim();

        // drop a slower previous request so late responses don't overwrite newer results
        if (plState.request) plState.request.abort();
        plLoading(true);

        plState.request = $.ajax({
            type: 'POST',
            url: 'AttendancePunchLog.aspx/GetPunchLogs',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            data: JSON.stringify({
                dptId: ddl.value || '0',
                fromDate: from,
                toDate: to,
                search: plState.search,
                page: page,
                pageSize: parseInt(document.getElementById('plPageSize').value, 10)
            }),
            success: function (res) {
                var r = res.d;
                if (!r.success) { plToast(r.message || 'Could not load records.'); plRender([], 0, 1, 50); return; }
                plRender(r.rows, r.total, r.page, r.pageSize);
                document.getElementById('stRange').textContent = plFmtDate(from) + ' to ' + plFmtDate(to);
                var dText = ddl.options[ddl.selectedIndex] ? ddl.options[ddl.selectedIndex].text : '';
                document.getElementById('stDept').textContent = (!ddl.value || ddl.value === '0') ? 'All' : dText;
            },
            error: function (xhr, status) {
                if (status === 'abort') return;
                plToast('Could not reach the server. Please try again.');
                plRender([], 0, 1, 50);
            },
            complete: function (xhr, status) {
                if (status !== 'abort') { plLoading(false); plState.request = null; }
            }
        });
    }

    function plRender(rows, total, page, size) {
        plState.total = total;
        var body = document.getElementById('plBody');
        document.getElementById('plCount').textContent = total.toLocaleString() + (total === 1 ? ' record' : ' records');
        document.getElementById('stTotal').textContent = total.toLocaleString();

        if (!rows.length) {
            body.innerHTML = '<tr><td colspan="8"><div class="pl-empty"><span class="icon">&#x1F50E;</span><p>No punch records matched your filters</p></div></td></tr>';
            document.getElementById('plInfo').textContent = 'Showing 0 of 0';
            document.getElementById('plPager').innerHTML = '';
            return;
        }

        var start = (page - 1) * size;
        var html = [];
        for (var i = 0; i < rows.length; i++) {
            var r = rows[i];
            html.push('<tr>' +
                '<td class="pl-sl">' + (start + i + 1) + '</td>' +
                '<td><div class="pl-emp"><div class="pl-avatar" style="background:' + plColor(r.empName) + '">' + plEsc(plInitials(r.empName)) + '</div>' +
                    '<span class="pl-emp-name">' + plHl(r.empName) + '</span></div></td>' +
                '<td><span class="pl-prox">' + plHl(r.proximityNo) + '</span></td>' +
                '<td>' + plHl(r.dptName) + '</td>' +
                '<td class="pl-muted">' + plHl(r.dsgName) + '</td>' +
                '<td class="pl-date">' + plEsc(r.punchDate) + '</td>' +
                '<td><span class="pl-time">' + plEsc(r.punchTime) + '</span></td>' +
                '<td>' + (r.punchSource ? '<span class="pl-src ' + plSourceClass(r.punchSource) + '">' + plHl(r.punchSource) + '</span>' : '<span class="pl-muted">&mdash;</span>') + '</td>' +
                '</tr>');
        }
        body.innerHTML = html.join('');
        document.getElementById('plInfo').textContent = 'Showing ' + (start + 1).toLocaleString() + ' - ' +
            (start + rows.length).toLocaleString() + ' of ' + total.toLocaleString();
        plPager(page, Math.ceil(total / size));
    }

    function plPager(page, pages) {
        var el = document.getElementById('plPager');
        if (pages <= 1) { el.innerHTML = ''; return; }
        var h = '<button type="button" ' + (page === 1 ? 'disabled' : '') + ' onclick="plLoad(' + (page - 1) + ')">&lsaquo; Prev</button>';
        var last = 0;
        for (var p = 1; p <= pages; p++) {
            if (p === 1 || p === pages || Math.abs(p - page) <= 2) {
                if (last && p - last > 1) h += '<span class="dots">&hellip;</span>';
                h += '<button type="button" class="' + (p === page ? 'active' : '') + '" onclick="plLoad(' + p + ')">' + p + '</button>';
                last = p;
            }
        }
        h += '<button type="button" ' + (page === pages ? 'disabled' : '') + ' onclick="plLoad(' + (page + 1) + ')">Next &rsaquo;</button>';
        el.innerHTML = h;
    }

    $(function () {
        // search-any runs on the server, debounced so typing doesn't fire a query per key
        $('#plSearchAny').on('input', function () {
            clearTimeout(plState.timer);
            plState.timer = setTimeout(function () { plLoad(1); }, 450);
        }).on('keydown', function (e) {
            if (e.key === 'Enter') { e.preventDefault(); clearTimeout(plState.timer); plLoad(1); }
        });
        $('#txtFromDate, #txtToDate').on('keydown', function (e) { if (e.key === 'Enter') { e.preventDefault(); plLoad(1); } });
        plLoad(1);
    });
</script>
</asp:Content>
