<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="AssetRequest.aspx.cs" Inherits="SigmaERP.hrms.asset.AssetRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-hand-paper"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Request Asset</h4>
                            <p class="asset-hero__subtitle">Request an asset you need. Your request will be sent to admin for approval</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-paper-plane"></i> New Request</h6>
                </div>
                <div class="asset-card__body">
                    <div class="row g-3">
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Asset Item <span class="required-star">*</span></label>
                            <select id="ddlRequestItem" class="form-control" style="width:100%"></select>
                            <span class="text-danger" id="ddlRequestItemError"></span>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Quantity <span class="required-star">*</span></label>
                            <input type="number" id="txtRequestQty" class="form-control" min="1" value="1" />
                            <span class="text-danger" id="txtRequestQtyError"></span>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Reason</label>
                            <textarea id="txtRequestReason" class="form-control" rows="2" placeholder="Why do you need this asset?"></textarea>
                        </div>
                    </div>
                    <div class="mt-25">
                        <button type="button" class="btn-asset-primary" onclick="SubmitAssetRequest();">
                            <i class="fas fa-paper-plane"></i> Submit Request
                        </button>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-clipboard-list"></i> My Requests</h6>
                </div>
                <div class="asset-card__body">
                    <div id="myRequestsList"></div>
                </div>
            </div>

        </div>
    </div>

    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var token = '<%= Session["__UserToken__"] %>';
        var EmpId = '<%= Session["__GetEmpId__"] %>';

        var itemListUrl = `${rootUrl}/api/AssetItem/list?companyId=${CompanyID}`;
        var createRequestUrl = `${rootUrl}/api/AssetRequest/create`;
        var myRequestsUrl = `${rootUrl}/api/AssetRequest/mine?companyId=${CompanyID}&empId=${EmpId}`;

        $(document).ready(function () {
            $('#ddlRequestItem').select2({ placeholder: 'Select Asset Item', width: '100%' });
            LoadAssetItems();
            LoadMyRequests();
        });

        function LoadAssetItems() {
            ApiCall(itemListUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    var options = '<option value="">-- Select Asset Item --</option>';
                    data.forEach(function (item) {
                        var id = item.itemId != null ? item.itemId : item.id;
                        options += `<option value="${id}">${item.itemName}</option>`;
                    });
                    $('#ddlRequestItem').html(options).trigger('change');
                })
                .catch(function (error) {
                    console.error('Error loading asset items:', error);
                });
        }

        function SubmitAssetRequest() {
            var itemId = $('#ddlRequestItem').val();
            var quantity = parseInt($('#txtRequestQty').val(), 10);
            var reason = $('#txtRequestReason').val().trim();

            $('#ddlRequestItemError, #txtRequestQtyError').html('');

            var hasError = false;
            if (!itemId) { $('#ddlRequestItemError').html('Please select an asset item.'); hasError = true; }
            if (!quantity || quantity < 1) { $('#txtRequestQtyError').html('Enter a valid quantity.'); hasError = true; }
            if (hasError) return;

            var payload = {
                companyId: CompanyID,
                empId: EmpId,
                itemId: parseInt(itemId, 10),
                quantity: quantity,
                reason: reason
            };

            ApiCallPost(createRequestUrl, token, payload)
                .then(function (response) {
                    if (response && response.statusCode && response.statusCode !== 200) { return; }
                    Swal.fire({ icon: 'success', title: 'Submitted', text: 'Your asset request has been sent for admin approval.' })
                        .then(function () {
                            $('#txtRequestQty').val(1);
                            $('#txtRequestReason').val('');
                            $('#ddlRequestItem').val('').trigger('change');
                            LoadMyRequests();
                        });
                })
                .catch(function () {
                    Swal.fire({ icon: 'error', title: 'Error', text: 'Failed to submit your request.' });
                });
        }

        function LoadMyRequests() {
            ApiCall(myRequestsUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    renderMyRequests(data);
                })
                .catch(function () {
                    renderMyRequests([]);
                });
        }

        function statusBadge(status) {
            if (status === 'Approved') return '<span class="asset-badge asset-badge-completed">Approved</span>';
            if (status === 'Rejected') return '<span class="asset-badge asset-badge-inactive">Rejected</span>';
            return '<span class="asset-badge asset-badge-pending">Pending</span>';
        }

        function renderMyRequests(data) {
            var $container = $('#myRequestsList');
            $container.empty();

            if (!data.length) {
                $container.html('<div class="asset-empty"><i class="fas fa-inbox"></i>You have not requested any assets yet.</div>');
                return;
            }

            var $table = $('<table class="table mb-0 table-borderless"><thead><tr>' +
                '<th>Item</th><th>Qty</th><th>Reason</th><th>Requested On</th><th>Status</th><th>Admin Remarks</th>' +
                '</tr></thead><tbody></tbody></table>');
            var $tbody = $table.find('tbody');

            data.forEach(function (row) {
                var reqDate = row.requestDate ? new Date(row.requestDate).toLocaleString() : '';
                var $tr = $('<tr></tr>');
                $tr.append('<td>' + row.itemName + '</td>');
                $tr.append('<td>' + row.quantity + '</td>');
                $tr.append('<td>' + (row.reason || '-') + '</td>');
                $tr.append('<td>' + reqDate + '</td>');
                $tr.append('<td>' + statusBadge(row.status) + '</td>');
                $tr.append('<td>' + (row.adminRemarks || '-') + '</td>');
                $tbody.append($tr);
            });

            $container.append($table);
        }
    </script>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
