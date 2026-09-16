<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="MyAssets.aspx.cs" Inherits="SigmaERP.hrms.asset.MyAssets" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-box-open"></i></div>
                        <div>
                            <h4 class="asset-hero__title">My Assets</h4>
                            <p class="asset-hero__subtitle">Review assets assigned to you and acknowledge receiving them</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-clipboard-list"></i> Assigned Assets</h6>
                </div>
                <div class="asset-card__body">
                    <div id="myAssetsList"></div>
                </div>
            </div>

        </div>
    </div>

    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var token = '<%= Session["__UserToken__"] %>';
        var EmpId = '<%= Session["__GetEmpId__"] %>';

        var myAssignmentsUrl = `${rootUrl}/api/AssetAssignment/report/employeeWiseAsset?companyId=${CompanyID}&empId=${EmpId}`;
        var myAcknowledgementsUrl = `${rootUrl}/api/AssetTransaction/acknowledge/mine?companyId=${CompanyID}&employeeId=${EmpId}`;
        var requestAcknowledgeUrl = `${rootUrl}/api/AssetTransaction/acknowledge/request`;

        $(document).ready(function () {
            LoadMyAssets();
        });

        function LoadMyAssets() {
            $.when(ApiCall(myAssignmentsUrl, token), ApiCall(myAcknowledgementsUrl, token))
                .done(function (assignRes, ackRes) {
                    var assignments = (assignRes && assignRes.data) ? assignRes.data : [];
                    var acknowledgements = (ackRes && ackRes.data) ? ackRes.data : [];
                    renderMyAssets(assignments, acknowledgements);
                })
                .fail(function () {
                    renderMyAssets([], []);
                });
        }

        function latestAckForAsset(acknowledgements, assetId) {
            var matches = acknowledgements.filter(function (a) { return a.assetId == assetId; });
            if (!matches.length) return null;
            return matches[0];
        }

        function renderMyAssets(assignments, acknowledgements) {
            var $container = $('#myAssetsList');
            $container.empty();

            if (!assignments.length) {
                $container.html('<div class="asset-empty"><i class="fas fa-inbox"></i>No assets have been assigned to you yet.</div>');
                return;
            }

            var $table = $('<table class="table mb-0 table-borderless"><thead><tr>' +
                '<th>Item</th><th>Serial No</th><th>Issue Date</th><th>Status</th><th>Action</th>' +
                '</tr></thead><tbody></tbody></table>');
            var $tbody = $table.find('tbody');

            assignments.forEach(function (row) {
                var issueDate = row.issueDate ? new Date(row.issueDate).toLocaleDateString() : '';
                var $tr = $('<tr></tr>');
                $tr.append('<td>' + row.itemName + '</td>');
                $tr.append('<td>' + (row.serialNo || '-') + '</td>');
                $tr.append('<td>' + issueDate + '</td>');

                var statusHtml = '';
                var actionHtml = '';

                if (row.receivedConfirmation) {
                    statusHtml = '<span class="asset-badge asset-badge-completed">Received</span>';
                    actionHtml = '-';
                } else {
                    var ack = latestAckForAsset(acknowledgements, row.assetId);
                    if (ack && ack.status === 'Pending') {
                        statusHtml = '<span class="asset-badge asset-badge-pending">Waiting for Admin Approval</span>';
                        actionHtml = '-';
                    } else if (ack && ack.status === 'Rejected') {
                        statusHtml = '<span class="asset-badge asset-badge-inactive">Rejected</span>';
                        actionHtml = '<button type="button" class="btn-asset-outline btn-sm-custom" onclick="AcknowledgeAsset(' + row.assetId + ', this)"><i class="fas fa-redo"></i> Resubmit</button>';
                    } else {
                        statusHtml = '<span class="asset-badge asset-badge-assigned">Awaiting Acknowledgement</span>';
                        actionHtml = '<button type="button" class="btn-asset-primary btn-sm-custom" onclick="AcknowledgeAsset(' + row.assetId + ', this)"><i class="fas fa-check"></i> Acknowledge Receipt</button>';
                    }
                }

                $tr.append('<td>' + statusHtml + '</td>');
                $tr.append('<td>' + actionHtml + '</td>');
                $tbody.append($tr);
            });

            $container.append($table);
        }

        function AcknowledgeAsset(assetId, btn) {
            Swal.fire({
                title: 'Acknowledge Receipt?',
                text: 'Confirm that you have received this asset. It will be sent to admin for approval.',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Yes, Acknowledge'
            }).then(function (result) {
                if (!result.isConfirmed) return;

                var payload = {
                    companyId: CompanyID,
                    assetId: assetId,
                    employeeId: parseInt(EmpId, 10)
                };

                ApiCallPost(requestAcknowledgeUrl, token, payload)
                    .then(function (response) {
                        if (!response || response.statusCode !== 200) { return; }
                        Swal.fire({ icon: 'success', title: 'Submitted', text: 'Your acknowledgement has been sent for admin approval.' })
                            .then(function () { LoadMyAssets(); });
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
