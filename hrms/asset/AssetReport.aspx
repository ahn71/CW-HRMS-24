<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="AssetReport.aspx.cs" Inherits="SigmaERP.hrms.asset.AssetReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-chart-bar"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Asset Reports</h4>
                            <p class="asset-hero__subtitle">In-servicing status &amp; asset replacement history</p>
                        </div>
                    </div>
                </div>
            </div>

            <ul class="nav asset-tabs" id="reportTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="tab-inservicing-btn" data-bs-toggle="tab" data-bs-target="#tab-inservicing" type="button" role="tab">
                        <i class="fas fa-tools"></i> In-Servicing
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="tab-replace-btn" data-bs-toggle="tab" data-bs-target="#tab-replace" type="button" role="tab">
                        <i class="fas fa-random"></i> Replacement
                    </button>
                </li>
            </ul>

            <div class="tab-content">

                <div class="tab-pane fade show active" id="tab-inservicing" role="tabpanel">
                    <div class="asset-card">
                        <div class="asset-card__header">
                            <h6><i class="fas fa-tools"></i> Assets Currently In Servicing</h6>
                            <div class="d-flex align-items-center gap-2">
                                <div id="inServicingFilterContainer"></div>
                                <button type="button" class="btn-asset-outline" onclick="GetInServicingReport();"><i class="fas fa-sync-alt"></i> Refresh</button>
                            </div>
                        </div>
                        <div class="asset-card__body">
                            <table class="table mb-0 packagesTable table-borderless adv-table" id="tblInServicing"
                                data-sorting="true" data-filtering="true" data-filter-container="#inServicingFilterContainer" data-paging="true" data-paging-size="10"></table>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="tab-replace" role="tabpanel">
                    <div class="asset-card">
                        <div class="asset-card__header">
                            <h6><i class="fas fa-random"></i> Asset Replacement History</h6>
                            <div class="d-flex align-items-center gap-2">
                                <div id="replaceFilterContainer"></div>
                                <button type="button" class="btn-asset-outline" onclick="GetReplaceReport();"><i class="fas fa-sync-alt"></i> Refresh</button>
                            </div>
                        </div>
                        <div class="asset-card__body">
                            <table class="table mb-0 packagesTable table-borderless adv-table" id="tblReplace"
                                data-sorting="true" data-filtering="true" data-filter-container="#replaceFilterContainer" data-paging="true" data-paging-size="10"></table>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var token = '<%= Session["__UserToken__"] %>';

        var inServicingUrl = `${rootUrl}/api/AssetTransaction/report/inServicing?companyId=${CompanyID}`;
        var replaceUrl = `${rootUrl}/api/AssetTransaction/report/replace?companyId=${CompanyID}`;

        $(document).ready(function () {
            GetInServicingReport();
            GetReplaceReport();

            $('#reportTabs button').on('shown.bs.tab', function () {
                $(window).trigger('resize');
            });
        });

        function toDateInputValue(dateStr) {
            if (!dateStr) return '';
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return '';
            return d.toISOString().slice(0, 10);
        }

        function renderFootable($table, data, columns, filterContainer, emptyMessage) {
            if ($table.data('footable')) {
                $table.data('footable').destroy();
            }
            $table.html('');
            $table.closest('.asset-card__body').find('.asset-empty').remove();
            $(filterContainer).empty();

            if (!data || !data.length) {
                $table.after(`<div class="asset-empty"><i class="fas fa-inbox"></i>${emptyMessage}</div>`);
                return;
            }

            try {
                $table.footable({
                    columns: columns,
                    rows: data,
                    filtering: { enabled: true, placeholder: 'Search...', containers: filterContainer },
                    paging: { enabled: true, size: 10 },
                    sorting: true
                });
            } catch (e) {
                console.error('Footable init error:', e);
            }
        }

        function GetInServicingReport() {
            ApiCall(inServicingUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    data.forEach(function (row) {
                        row.serviceDateDisplay = toDateInputValue(row.serviceDate);
                        row.expectedReturnDateDisplay = toDateInputValue(row.expectedReturnDate);
                        row.statusBadge = `<span class="asset-badge asset-badge-inservice">${row.status || 'N/A'}</span>`;
                    });

                    var columns = [
                        { name: 'transactionId', title: 'Ticket #', className: 'userDatatable-content' },
                        { name: 'itemName', title: 'Item', className: 'userDatatable-content' },
                        { name: 'serialNo', title: 'Serial No', className: 'userDatatable-content' },
                        { name: 'empName', title: 'Employee', className: 'userDatatable-content' },
                        { name: 'problem', title: 'Problem', className: 'userDatatable-content' },
                        { name: 'serviceCenterName', title: 'Service Center', className: 'userDatatable-content' },
                        { name: 'serviceDateDisplay', title: 'Service Date', className: 'userDatatable-content' },
                        { name: 'expectedReturnDateDisplay', title: 'Expected Return', className: 'userDatatable-content' },
                        { name: 'statusBadge', title: 'Status', type: 'html', className: 'userDatatable-content' }
                    ];

                    renderFootable($('#tblInServicing'), data, columns, '#inServicingFilterContainer', 'No assets are currently in servicing.');
                })
                .catch(function (error) {
                    console.error('Error loading in-servicing report:', error);
                    renderFootable($('#tblInServicing'), [], [], '#inServicingFilterContainer', 'No assets are currently in servicing.');
                });
        }

        function GetReplaceReport() {
            ApiCall(replaceUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    data.forEach(function (row) {
                        row.replacementDateDisplay = toDateInputValue(row.replacementDate);
                        row.statusBadge = `<span class="asset-badge asset-badge-replaced">${row.status || 'N/A'}</span>`;
                    });

                    var columns = [
                        { name: 'empName', title: 'Employee', className: 'userDatatable-content' },
                        { name: 'oldAssetCode', title: 'Old Asset', className: 'userDatatable-content' },
                        { name: 'oldSerialNo', title: 'Old Serial No', className: 'userDatatable-content' },
                        { name: 'newAssetCode', title: 'New Asset', className: 'userDatatable-content' },
                        { name: 'newSerialNo', title: 'New Serial No', className: 'userDatatable-content' },
                        { name: 'reason', title: 'Reason', className: 'userDatatable-content' },
                        { name: 'replacementDateDisplay', title: 'Replacement Date', className: 'userDatatable-content' },
                        { name: 'statusBadge', title: 'Status', type: 'html', className: 'userDatatable-content' }
                    ];

                    renderFootable($('#tblReplace'), data, columns, '#replaceFilterContainer', 'No asset replacement records found.');
                })
                .catch(function (error) {
                    console.error('Error loading replacement report:', error);
                    renderFootable($('#tblReplace'), [], [], '#replaceFilterContainer', 'No asset replacement records found.');
                });
        }
    </script>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
