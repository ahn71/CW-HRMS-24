<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="GatePassHistory.aspx.cs" Inherits="SigmaERP.hrms.asset.GatePassHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .gp-slip { width: 760px; max-width: 100%; background: #fff; padding: 34px; font-family: Arial, Helvetica, sans-serif; color: #1f2430; }
        .gp-slip .gp-head { display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 3px solid #4f6df5; padding-bottom: 14px; margin-bottom: 18px; }
        .gp-slip .gp-head h2 { margin: 0; font-size: 20px; color: #1f2430; }
        .gp-slip .gp-head p { margin: 2px 0 0; font-size: 12px; color: #7b8394; }
        .gp-slip .gp-no { text-align: right; font-size: 12px; color: #7b8394; }
        .gp-slip .gp-no strong { display: block; font-size: 15px; color: #4f6df5; }
        .gp-slip .gp-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px 26px; margin-bottom: 18px; }
        .gp-slip .gp-field label { display: block; font-size: 10.5px; text-transform: uppercase; letter-spacing: .4px; color: #7b8394; margin-bottom: 2px; }
        .gp-slip .gp-field div { font-size: 13.5px; font-weight: 600; }
        .gp-slip .gp-status-row { display: flex; justify-content: space-between; align-items: center; padding: 10px 14px; background: #f4f6fb; border-radius: 10px; margin-bottom: 22px; }
        .gp-slip .gp-sign-row { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 18px; margin-top: 46px; }
        .gp-slip .gp-sign-row div { border-top: 1px solid #d8dce8; padding-top: 6px; font-size: 11.5px; color: #7b8394; text-align: center; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-history"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Gate Pass History</h4>
                            <p class="asset-hero__subtitle">Search and review all gate pass records with their current status</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-filter"></i> Filters</h6>
                </div>
                <div class="asset-card__body">
                    <div class="row g-3 align-items-end">
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">From Date</label>
                            <input type="date" id="txtFromDate" class="form-control" />
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">To Date</label>
                            <input type="date" id="txtToDate" class="form-control" />
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Status</label>
                            <select id="ddlStatusFilter" class="form-control">
                                <option value="">All Statuses</option>
                                <option value="Pending">Pending</option>
                                <option value="Approved">Approved</option>
                                <option value="Rejected">Rejected</option>
                                <option value="GateOut">Gate Out</option>
                                <option value="Completed">Completed</option>
                            </select>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <button type="button" class="btn-asset-primary w-100" onclick="GetHistory();">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-list-ul"></i> Gate Pass History</h6>
                    <div id="filter-form-container"></div>
                </div>
                <div class="asset-card__body">
                    <table class="table mb-0 packagesTable table-borderless adv-table"
                        data-sorting="true" data-filtering="true" data-filter-container="#filter-form-container" data-paging="true" data-paging-size="10">
                    </table>
                </div>
            </div>

        </div>
    </div>

    <!-- Hidden printable Gate Pass slip used to generate the PDF -->
    <div id="gpSlip" class="gp-slip" style="position:absolute; left:-9999px; top:0;">
        <div class="gp-head">
            <div>
                <h2 id="slipCompanyName">Company</h2>
                <p>Gate Pass Slip</p>
            </div>
            <div class="gp-no">
                Gate Pass No
                <strong id="slipGatePassNo">-</strong>
                <span id="slipDateTime"></span>
            </div>
        </div>
        <div class="gp-grid">
            <div class="gp-field"><label>Employee / Visitor</label><div id="slipPerson">-</div></div>
            <div class="gp-field"><label>Serial No</label><div id="slipSerial">-</div></div>
            <div class="gp-field"><label>Item Name</label><div id="slipItem">-</div></div>
            <div class="gp-field"><label>Quantity</label><div id="slipQty">-</div></div>
            <div class="gp-field"><label>Purpose</label><div id="slipPurpose">-</div></div>
            <div class="gp-field"><label>Destination</label><div id="slipDestination">-</div></div>
        </div>
        <div class="gp-status-row">
            <div><label style="font-size:10.5px;color:#7b8394;text-transform:uppercase;">Status</label><div id="slipStatus" style="font-weight:700;">-</div></div>
            <div><label style="font-size:10.5px;color:#7b8394;text-transform:uppercase;">Approved By</label><div id="slipApprover" style="font-weight:700;">-</div></div>
        </div>
        <div class="gp-sign-row">
            <div>Requested By</div>
            <div>Approved By</div>
            <div>Security Guard</div>
        </div>
    </div>

    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var token = '<%= Session["__UserToken__"] %>';

        var historyBaseUrl = `${rootUrl}/api/GatePass/history`;
        var companyUrl = `${rootUrl}/api/Company/GetDropdownCompanies?CompanyId=${CompanyID}`;

        var companyName = '';

        $(document).ready(function () {
            LoadCompanyName();
            GetHistory();
        });

        function LoadCompanyName() {
            ApiCall(companyUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    var found = data.find(function (c) { return c.companyId == CompanyID; });
                    companyName = found ? found.companyName : '';
                    $('#slipCompanyName').text(companyName || 'Gate Pass');
                })
                .catch(function () { });
        }

        function toDateTimeDisplay(dateStr) {
            if (!dateStr) return '';
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return '';
            return d.toLocaleString();
        }

        function statusBadgeClass(status) {
            var map = {
                'Pending': 'asset-badge-pending',
                'Approved': 'asset-badge-active',
                'Rejected': 'asset-badge-inactive',
                'GateOut': 'asset-badge-inservice',
                'Completed': 'asset-badge-completed'
            };
            return map[status] || 'asset-badge-assigned';
        }

        function GetHistory() {
            var params = [`companyId=${CompanyID}`];
            var fromDate = $('#txtFromDate').val();
            var toDate = $('#txtToDate').val();
            var status = $('#ddlStatusFilter').val();

            if (fromDate) params.push(`fromDate=${fromDate}`);
            if (toDate) params.push(`toDate=${toDate}`);
            if (status) params.push(`status=${status}`);

            var url = `${historyBaseUrl}?${params.join('&')}`;

            ApiCall(url, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    bindHistoryTable(data);
                })
                .catch(function (error) {
                    console.error('Error loading gate pass history:', error);
                    bindHistoryTable([]);
                });
        }

        function bindHistoryTable(data) {
            if ($('.adv-table').data('footable')) {
                $('.adv-table').data('footable').destroy();
            }
            $('.adv-table').html('');
            $('#filter-form-container').empty();
            $('.adv-table').closest('.asset-card__body').find('.asset-empty').remove();

            if (!data.length) {
                $('.adv-table').after('<div class="asset-empty"><i class="fas fa-inbox"></i>No gate pass records found for this filter.</div>');
                return;
            }

            data.forEach(function (row) {
                row.dateTimeDisplay = toDateTimeDisplay(row.gatePassDateTime);
                row.personDisplay = row.empName || row.empId || row.visitorName || 'N/A';
                row.statusBadge = `<span class="asset-badge ${statusBadgeClass(row.status)}">${row.status || 'N/A'}</span>`;
                var canDownload = ['Approved', 'GateOut', 'Completed'].indexOf(row.status) !== -1;
                row.action = `
                    <div class="actions">
                        ${canDownload ? `<a href="javascript:void(0)" data-id="${row.gatePassId}" class="pdf-btn" title="Download PDF"><i class="fas fa-file-pdf"></i></a>` : '<span class="fs-12 color-light">&mdash;</span>'}
                    </div>`;
            });

            var columns = [
                { name: 'gatePassNo', title: 'Gate Pass No', className: 'userDatatable-content' },
                { name: 'dateTimeDisplay', title: 'Date', className: 'userDatatable-content' },
                { name: 'personDisplay', title: 'Employee / Visitor', className: 'userDatatable-content' },
                { name: 'itemName', title: 'Item', className: 'userDatatable-content' },
                { name: 'quantity', title: 'Qty', className: 'userDatatable-content' },
                { name: 'purpose', title: 'Purpose', className: 'userDatatable-content' },
                { name: 'destination', title: 'Destination', className: 'userDatatable-content' },
                { name: 'approvedByName', title: 'Approved By', className: 'userDatatable-content' },
                { name: 'statusBadge', title: 'Status', type: 'html', className: 'userDatatable-content' },
                { name: 'action', title: 'Action', sortable: false, filterable: false, type: 'html', className: 'userDatatable-content' }
            ];

            try {
                $('.adv-table').footable({
                    columns: columns,
                    rows: data,
                    filtering: { enabled: true, placeholder: 'Search...', containers: '#filter-form-container' },
                    paging: { enabled: true, size: 10 },
                    sorting: true
                });
            } catch (e) {
                console.error('Footable init error:', e);
            }

            $('.adv-table').off('click', '.pdf-btn').on('click', '.pdf-btn', function () {
                var id = $(this).data('id');
                var row = data.find(function (d) { return d.gatePassId == id; });
                if (row) DownloadGatePassPdf(row);
            });
        }

        function DownloadGatePassPdf(row) {
            $('#slipGatePassNo').text(row.gatePassNo || '-');
            $('#slipDateTime').text(toDateTimeDisplay(row.gatePassDateTime));
            $('#slipPerson').text(row.empName || row.empId || row.visitorName || '-');
            $('#slipItem').text(row.itemName || '-');
            $('#slipQty').text(row.quantity != null ? row.quantity : '-');
            $('#slipSerial').text(row.serialNo || '-');
            $('#slipPurpose').text(row.purpose || '-');
            $('#slipDestination').text(row.destination || '-');
            $('#slipStatus').text(row.status || '-');
            $('#slipApprover').text(row.approvedByName || '-');

            var element = document.getElementById('gpSlip');
            html2pdf()
                .from(element)
                .set({
                    margin: 0.3,
                    filename: `GatePass-${row.gatePassNo || row.gatePassId}.pdf`,
                    html2canvas: { scale: 2, letterRendering: true },
                    jsPDF: { unit: 'in', format: 'a4', orientation: 'portrait' }
                })
                .save();
        }
    </script>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
