<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="AssetRecognitionApproval.aspx.cs" Inherits="SigmaERP.hrms.asset.AssetRecognitionApproval" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-user-check"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Asset Recognition Approval</h4>
                            <p class="asset-hero__subtitle">Review and approve employees' asset receipt acknowledgements</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-hourglass-half"></i> Pending Acknowledgements</h6>
                </div>
                <div class="asset-card__body">
                    <div id="pendingList"></div>
                </div>
            </div>

        </div>
    </div>

    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var token = '<%= Session["__UserToken__"] %>';

        var pendingUrl = `${rootUrl}/api/AssetTransaction/acknowledge/pending?companyId=${CompanyID}`;
        var approveUrl = `${rootUrl}/api/AssetTransaction/acknowledge/approve`;
        var rejectUrl = `${rootUrl}/api/AssetTransaction/acknowledge/reject`;

        $(document).ready(function () {
            LoadPending();
        });

        function LoadPending() {
            ApiCall(pendingUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    renderPending(data);
                })
                .catch(function () {
                    renderPending([]);
                });
        }

        function renderPending(data) {
            var $container = $('#pendingList');
            $container.empty();

            if (!data.length) {
                $container.html('<div class="asset-empty"><i class="fas fa-check-circle"></i>No pending acknowledgement requests.</div>');
                return;
            }

            var $table = $('<table class="table mb-0 table-borderless"><thead><tr>' +
                '<th>Employee</th><th>Item</th><th>Serial No</th><th>Requested On</th><th>Remarks</th><th>Action</th>' +
                '</tr></thead><tbody></tbody></table>');
            var $tbody = $table.find('tbody');

            data.forEach(function (row) {
                var reqDate = row.requestDate ? new Date(row.requestDate).toLocaleString() : '';
                var $tr = $('<tr></tr>');
                $tr.append('<td>' + (row.empName || row.empId || '-') + '</td>');
                $tr.append('<td>' + row.itemName + '</td>');
                $tr.append('<td>' + (row.serialNo || '-') + '</td>');
                $tr.append('<td>' + reqDate + '</td>');
                $tr.append('<td>' + (row.remarks || '-') + '</td>');
                $tr.append(
                    '<td>' +
                    '<button type="button" class="btn-asset-primary btn-sm-custom" onclick="DecideAcknowledge(' + row.transactionId + ', true)"><i class="fas fa-check"></i> Approve</button> ' +
                    '<button type="button" class="btn-asset-outline btn-sm-custom" onclick="DecideAcknowledge(' + row.transactionId + ', false)"><i class="fas fa-times"></i> Reject</button>' +
                    '</td>'
                );
                $tbody.append($tr);
            });

            $container.append($table);
        }

        function DecideAcknowledge(transactionId, approve) {
            Swal.fire({
                title: approve ? 'Approve this request?' : 'Reject this request?',
                text: approve ? 'This will confirm the asset as received by the employee.' : 'The employee can resubmit after this.',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: approve ? 'Yes, Approve' : 'Yes, Reject'
            }).then(function (result) {
                if (!result.isConfirmed) return;

                var payload = { transactionId: transactionId };
                var url = approve ? approveUrl : rejectUrl;

                ApiCallUpdateWithoutId(url, token, payload)
                    .then(function () {
                        Swal.fire({ icon: 'success', title: approve ? 'Approved' : 'Rejected' })
                            .then(function () { LoadPending(); });
                    });
            });
        }
    </script>

    <style>
        .btn-sm-custom {
            padding: 6px 14px;
            font-size: 12.5px;
        }
    </style>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
