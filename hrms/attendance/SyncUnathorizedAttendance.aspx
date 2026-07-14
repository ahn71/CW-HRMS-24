<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="SyncUnathorizedAttendance.aspx.cs" Inherits="SigmaERP.hrms.attendance.SyncUnathorizedAttendance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        .erp-page { padding: 1.5rem; font-family: 'Segoe UI', sans-serif; background: #f5f6fa; min-height: 100vh; }

        /* Page Header */
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e2e8f0;
        }
        .breadcrumb { font-size: 12px; color: #94a3b8; display: flex; align-items: center; gap: 6px; margin-bottom: 6px; }
        .page-title { display: flex; align-items: center; gap: 10px; }
        .page-title h1 { font-size: 18px; font-weight: 600; color: #1e293b; }
        .badge-module {
            font-size: 11px;
            background: #eff6ff;
            color: #2563eb;
            padding: 3px 10px;
            border-radius: 20px;
            font-weight: 500;
            border: 1px solid #bfdbfe;
        }
        .last-sync { font-size: 12px; color: #94a3b8; }

        /* Search Card */
        .search-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,.04);
        }
        .search-card-header {
            font-size: 11px;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: .06em;
            margin-bottom: 1rem;
        }
        .search-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr auto;
            gap: 12px;
            align-items: end;
        }
        .field { display: flex; flex-direction: column; gap: 5px; }
        .field label { font-size: 12px; color: #475569; font-weight: 500; }
        .field input {
            height: 36px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            padding: 0 10px;
            font-size: 13px;
            color: #1e293b;
            outline: none;
            transition: border-color .15s, box-shadow .15s;
            background: #fff;
        }
        .field input:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59,130,246,.12);
        }
        .field input::placeholder { color: #cbd5e1; }
        .btn-row { display: flex; gap: 8px; align-items: center; }
        .btn {
            height: 36px;
            padding: 0 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border: none;
            transition: all .15s;
            white-space: nowrap;
        }
        .btn-search { background: #2563eb; color: #fff; }
        .btn-search:hover { background: #1d4ed8; }
        .btn-sync { background: #16a34a; color: #fff; }
        .btn-sync:hover { background: #15803d; }
        .btn-sync:disabled { opacity: .6; cursor: not-allowed; }
        .btn-clear { background: #fff; border: 1px solid #cbd5e1; color: #475569; }
        .btn-clear:hover { background: #f8fafc; }

        /* Table Card */
        .table-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,.04);
        }
        .table-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: .9rem 1.25rem;
            border-bottom: 1px solid #e2e8f0;
        }
        .toolbar-left { display: flex; align-items: center; gap: 10px; }
        .toolbar-title { font-size: 14px; font-weight: 600; color: #1e293b; }
        .record-count {
            font-size: 12px;
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 2px 10px;
            color: #475569;
        }
        .status-dot { width: 7px; height: 7px; border-radius: 50%; background: #f59e0b; display: inline-block; margin-right: 6px; }
        .status-label { font-size: 12px; color: #64748b; display: flex; align-items: center; }

        table { width: 100%; border-collapse: collapse; font-size: 13px; }
        thead th {
            padding: .65rem 1rem;
            text-align: left;
            font-size: 11px;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: .05em;
            border-bottom: 1px solid #e2e8f0;
            background: #f8fafc;
            white-space: nowrap;
        }
        thead th:first-child { padding-left: 1.25rem; }
        thead th:last-child { padding-right: 1.25rem; }
        tbody tr { border-bottom: 1px solid #f1f5f9; transition: background .1s; }
        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: #f8fafc; }
        tbody td { padding: .75rem 1rem; color: #1e293b; vertical-align: middle; }
        tbody td:first-child { padding-left: 1.25rem; }
        tbody td:last-child { padding-right: 1.25rem; }

        .reg-id { font-weight: 600; color: #2563eb; font-family: 'Consolas', monospace; font-size: 12px; }
        .mono { font-family: 'Consolas', monospace; font-size: 12px; color: #1e293b; }
        .muted { font-family: 'Consolas', monospace; font-size: 12px; color: #64748b; }
        .row-num { font-size: 12px; color: #94a3b8; }

        .empty-state { padding: 3rem; text-align: center; color: #94a3b8; }
        .empty-state .icon { font-size: 32px; margin-bottom: .75rem; display: block; }
        .empty-state p { font-size: 13px; }

        /* Toast */
        #toast {
            position: fixed;
            bottom: 1.5rem;
            right: 1.5rem;
            background: #fff;
            border: 1px solid #bbf7d0;
            border-radius: 8px;
            padding: .75rem 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: #1e293b;
            box-shadow: 0 4px 16px rgba(0,0,0,.1);
            z-index: 9999;
            transform: translateY(120%);
            transition: transform .25s ease;
            min-width: 220px;
        }
        #toast.show { transform: translateY(0); }
        #toast.error { border-color: #fca5a5; }
        .toast-icon-ok { color: #16a34a; font-size: 18px; }
        .toast-icon-err { color: #dc2626; font-size: 18px; }

        /* Spinner */
        .spinner {
            width: 14px; height: 14px;
            border: 2px solid rgba(255,255,255,.3);
            border-top-color: #fff;
            border-radius: 50%;
            animation: spin .6s linear infinite;
            display: none;
        }
        .syncing .spinner { display: inline-block; }
        .syncing .sync-icon { display: none; }
        @keyframes spin { to { transform: rotate(360deg); } }

        @media (max-width: 768px) {
            .search-row { grid-template-columns: 1fr; }
            .btn-row { flex-wrap: wrap; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="src1"></asp:ScriptManager>
<div class="erp-page">

    <!-- Page Header -->
    <div class="page-header">
        <div>        
            <div class="page-title">
                <h1>Unauthorized Attendance Records</h1>
                <span class="badge-module">Sync Module</span>
            </div>
        </div>
        <div class="last-sync">
            Last sync: <span id="lastSyncTime">&mdash;</span>
        </div>
    </div>

    <!-- Search Panel -->
    <div class="search-card">
        <div class="search-card-header">&#x1F50D; Search Filters</div>
        <div class="search-row">
            <div class="field">
                <label for="txtRegId">Registration ID</label>
                <input type="number" id="txtRegId" placeholder="e.g. 10111" />
            </div>
            <div class="field">
                <label for="txtFromDate">From Date</label>
                <input type="date" id="txtFromDate" />
            </div>
            <div class="field">
                <label for="txtToDate">To Date</label>
                <input type="date" id="txtToDate" />
            </div>
            <div class="btn-row">
                <button type="button" class="btn btn-search" onclick="fetchRecords()">
                    &#x1F50E; Search
                </button>
                <button  type="button" class="btn btn-clear" onclick="clearFilters()" title="Clear filters">
                    &#x2715;
                </button>
                <button class="btn btn-sync" id="btnSync" onclick="syncRecords()">
                    <span class="spinner" id="syncSpinner"></span>
                    <span class="sync-icon">&#x21BB;</span>
                    <span id="syncLabel">Sync</span>
                </button>
            </div>
        </div>
    </div>

    <!-- Data Table -->
    <div class="table-card">
        <div class="table-toolbar">
            <div class="toolbar-left">
                <span class="toolbar-title">Punch Records</span>
                <span class="record-count" id="recCount">0 records</span>
            </div>
            <div class="status-label">
                <span class="status-dot"></span> Pending Authorization
            </div>
        </div>
        <div style="overflow-x:auto">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Registration ID</th>
                        <th>Punch Time</th>
                        <th>Created At</th>
                        <th>Source</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <tr>
                        <td colspan="4">
                            <div class="empty-state">
                                <span class="icon">&#x1F4CB;</span>
                                <p>Run a search to load records</p>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Toast Notification -->
<div id="toast">
    <span id="toastIcon"></span>
    <span id="toastMsg">Sync completed</span>
</div>

<script>
    //var BASE_URL = 'https://localhost:44322';
      var BASE_URL = '<%= Session["__RootUrl__"]%>';
    //var BASE_URL = '<%=  System.Configuration.ConfigurationManager.AppSettings["ApiBaseUrl"] %>';

    function getParams() {
        var reg = document.getElementById('txtRegId').value.trim();
        var from = document.getElementById('txtFromDate').value;
        var to = document.getElementById('txtToDate').value;
        var params = [];
        if (reg) params.push('registrationId=' + encodeURIComponent(reg));
        if (from) params.push('fromDate=' + encodeURIComponent(from));
        if (to) params.push('toDate=' + encodeURIComponent(to));
        return params.length ? '?' + params.join('&') : '';
    }

    // Page load e auto fetch
window.onload = function () {
    fetchRecords();
};
    function fetchRecords() {
        var body = document.getElementById('tableBody');
        body.innerHTML = '<tr><td colspan="4"><div class="empty-state"><p>Loading...</p></div></td></tr>';

        var url = BASE_URL + '/api/Attendance/unauthorized-records' + getParams();

        fetch(url)
            .then(function (res) { return res.json(); })
            .then(function (json) {
                if (json.success && Array.isArray(json.data)) {
                    renderTable(json.data);
                } else {
                    body.innerHTML = '<tr><td colspan="4"><div class="empty-state"><span class="icon">&#x26A0;</span><p>' + (json.message || 'No records found') + '</p></div></td></tr>';
                    document.getElementById('recCount').textContent = '0 records';
                }
            })
            .catch(function () {
                body.innerHTML = '<tr><td colspan="4"><div class="empty-state"><span class="icon">&#x1F6AB;</span><p>Could not reach the server. Check the connection.</p></div></td></tr>';
                document.getElementById('recCount').textContent = '0 records';
            });
    }

    function renderTable(data) {
        var body = document.getElementById('tableBody');
        var count = data.length;
        document.getElementById('recCount').textContent = count + (count !== 1 ? ' records' : ' record');

        if (!count) {
            body.innerHTML = '<tr><td colspan="4"><div class="empty-state"><span class="icon">&#x1F4CB;</span><p>No records matched your filters</p></div></td></tr>';
            return;
        }

        var html = '';
        for (var i = 0; i < data.length; i++) {
            var r = data[i];
            html += '<tr>' +
                '<td class="row-num">' + (i + 1) + '</td>' +
                '<td><span class="reg-id">' + r.registrationId + '</span></td>' +
                '<td><span class="mono">' + r.punchTime + '</span></td>' +
                '<td><span class="muted">' + r.createdAt + '</span></td>' +
                '<td><span class="muted">' + r.source + '</span></td>' +
                '</tr>';
        }
        body.innerHTML = html;
    }

    function syncRecords() {
        var btn = document.getElementById('btnSync');
        btn.disabled = true;
        btn.classList.add('syncing');
        document.getElementById('syncLabel').textContent = 'Syncing...';

        var url = BASE_URL + '/api/Attendance/unauthorized-records/delete' + getParams();

        fetch(url, { method: 'DELETE' })
            .then(function (res) { return res.json(); })
            .then(function (json) {
                var ok = json.statusCode === 200;
                showToast(ok, json.message || (ok ? 'Sync Successfully' : 'Sync failed'));
                if (ok) {
                    document.getElementById('lastSyncTime').textContent = new Date().toLocaleTimeString();
                    renderTable([]);
                }
            })
            .catch(function () {
                showToast(false, 'Could not reach the server');
            })
            .finally(function () {
                btn.disabled = false;
                btn.classList.remove('syncing');
                document.getElementById('syncLabel').textContent = 'Sync';
            });
    }

    function showToast(ok, msg) {
        var toast = document.getElementById('toast');
        var icon = document.getElementById('toastIcon');
        document.getElementById('toastMsg').textContent = msg;
        toast.className = ok ? 'show' : 'show error';
        icon.className = ok ? 'toast-icon-ok' : 'toast-icon-err';
        icon.innerHTML = ok ? '&#x2714;' : '&#x2716;';
        clearTimeout(window._toastTimer);
        window._toastTimer = setTimeout(function () {
            toast.classList.remove('show');
        }, 3500);
    }

    function clearFilters() {
        document.getElementById('txtRegId').value = '';
        document.getElementById('txtFromDate').value = '';
        document.getElementById('txtToDate').value = '';
    }
</script>

</asp:Content>

