<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="AssetRequestApproval.aspx.cs" Inherits="SigmaERP.hrms.asset.AssetRequestApproval" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-hand-holding-heart"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Asset Request Approval</h4>
                            <p class="asset-hero__subtitle">Review and approve or reject employees' asset requests</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-hourglass-half"></i> Pending Requests</h6>
                    <div class="d-flex align-items-center gap-2">
                        <div id="filter-form-container"></div>
                        <button type="button" class="btn-asset-outline" onclick="GetPendingRequests();"><i class="fas fa-sync-alt"></i> Refresh</button>
                    </div>
                </div>
                <div class="asset-card__body">
                    <table class="table mb-0 packagesTable table-borderless adv-table"
                        data-sorting="true" data-filtering="true" data-filter-container="#filter-form-container" data-paging="true" data-paging-size="10">
                    </table>
                </div>
            </div>

        </div>
    </div>

    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var token = '<%= Session["__UserToken__"] %>';

        var pendingUrl = `${rootUrl}/api/AssetRequest/pending?companyId=${CompanyID}`;
        var approveUrl = `${rootUrl}/api/AssetRequest/approve`;
        var rejectUrl = `${rootUrl}/api/AssetRequest/reject`;

        $(document).ready(function () {
            GetPendingRequests();
        });

        function toDateTimeDisplay(dateStr) {
            if (!dateStr) return '';
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return '';
            return d.toLocaleString();
        }

        function GetPendingRequests() {
            ApiCall(pendingUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    bindRequestTable(data);
                })
                .catch(function (error) {
                    console.error('Error loading pending asset requests:', error);
                    bindRequestTable([]);
                });
        }

        function bindRequestTable(data) {
            if ($('.adv-table').data('footable')) {
                $('.adv-table').data('footable').destroy();
            }
            $('.adv-table').html('');
            $('#filter-form-container').empty();
            $('.adv-table').closest('.asset-card__body').find('.asset-empty').remove();

            if (!data.length) {
                $('.adv-table').after('<div class="asset-empty"><i class="fas fa-check-circle"></i>No pending asset requests. All caught up!</div>');
                return;
            }

            data.forEach(function (row) {
                row.requestDateDisplay = toDateTimeDisplay(row.requestDate);
                row.action = `
                    <div class="actions">
                        <a href="javascript:void(0)" data-id="${row.requestId}" class="approve-btn" title="Approve"><i class="fas fa-check-circle"></i></a>
                        <a href="javascript:void(0)" data-id="${row.requestId}" class="reject-btn" title="Reject"><i class="fas fa-times-circle"></i></a>
                    </div>`;
            });

            var columns = [
                { name: 'empName', title: 'Employee', className: 'userDatatable-content' },
                { name: 'itemName', title: 'Item', className: 'userDatatable-content' },
                { name: 'quantity', title: 'Qty', className: 'userDatatable-content' },
                { name: 'reason', title: 'Reason', className: 'userDatatable-content' },
                { name: 'requestDateDisplay', title: 'Requested On', className: 'userDatatable-content' },
                { name: 'action', title: 'Action', sortable: false, filterable: false, type: 'html', className: 'userDatatable-content' }
            ];

            try {
                $('.adv-table').footable({
                    columns: columns,
                    rows: data,
                    filtering: { enabled: true, placeholder: 'Search employee, item...', containers: '#filter-form-container' },
                    paging: { enabled: true, size: 10 },
                    sorting: true
                });
            } catch (e) {
                console.error('Footable init error:', e);
            }

            $('.adv-table').off('click', '.approve-btn').on('click', '.approve-btn', function () {
                var id = $(this).data('id');
                DecideAssetRequest(id, true);
            });

            $('.adv-table').off('click', '.reject-btn').on('click', '.reject-btn', function () {
                var id = $(this).data('id');
                DecideAssetRequest(id, false);
            });
        }

        function DecideAssetRequest(requestId, isApproved) {
            Swal.fire({
                title: isApproved ? 'Approve this request?' : 'Reject this request?',
                input: 'text',
                inputPlaceholder: 'Remarks (optional)',
                icon: isApproved ? 'question' : 'warning',
                showCancelButton: true,
                confirmButtonColor: isApproved ? '#17a869' : '#d33',
                confirmButtonText: isApproved ? 'Yes, approve it' : 'Yes, reject it'
            }).then(function (result) {
                if (!result.isConfirmed) return;

                var payload = {
                    requestId: parseInt(requestId, 10),
                    adminRemarks: result.value || ''
                };

                ApiCallPost(isApproved ? approveUrl : rejectUrl, token, payload)
                    .then(function () {
                        Swal.fire({
                            icon: 'success',
                            title: isApproved ? 'Approved' : 'Rejected',
                            text: `Asset request ${isApproved ? 'approved' : 'rejected'} successfully.`
                        }).then(function () { GetPendingRequests(); });
                    })
                    .catch(function () {
                        Swal.fire({ icon: 'error', title: 'Error', text: 'Failed to process this request.' });
                    });
            });
        }
    </script>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
