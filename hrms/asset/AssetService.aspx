<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="AssetService.aspx.cs" Inherits="SigmaERP.hrms.asset.AssetService" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-tools"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Asset Service / Repair</h4>
                            <p class="asset-hero__subtitle">Send assets for servicing and complete service transactions</p>
                        </div>
                    </div>
                </div>
            </div>

            <ul class="nav asset-tabs" id="serviceTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="tab-send-btn" data-bs-toggle="tab" data-bs-target="#tab-send" type="button" role="tab">
                        <i class="fas fa-truck-loading"></i> Send to Service
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="tab-complete-btn" data-bs-toggle="tab" data-bs-target="#tab-complete" type="button" role="tab">
                        <i class="fas fa-check-circle"></i> Complete Service
                    </button>
                </li>
            </ul>

            <div class="tab-content">

                <!-- Send to Service -->
                <div class="tab-pane fade show active" id="tab-send" role="tabpanel">
                    <div class="asset-card">
                        <div class="asset-card__header">
                            <h6><i class="fas fa-truck-loading"></i> Send Asset to Service Center</h6>
                        </div>
                        <div class="asset-card__body">
                            <div class="row g-3">
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Asset <span class="required-star">*</span></label>
                                    <select id="ddlServiceAsset" class="form-control" style="width:100%"></select>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Employee</label>
                                    <select id="ddlServiceEmp" class="form-control" style="width:100%"></select>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Service Center</label>
                                    <select id="ddlServiceCenter" class="form-control" style="width:100%"></select>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Service Date</label>
                                    <input type="date" id="txtServiceDate" class="form-control" />
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Expected Return Date</label>
                                    <input type="date" id="txtExpectedReturnDate" class="form-control" />
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Problem <span class="required-star">*</span></label>
                                    <textarea id="txtProblem" class="form-control" rows="2" placeholder="Describe the problem"></textarea>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Remarks</label>
                                    <textarea id="txtSendRemarks" class="form-control" rows="2" placeholder="Optional remarks"></textarea>
                                </div>
                            </div>
                            <div class="mt-25">
                                <button type="button" class="btn-asset-primary" onclick="SendToService();">
                                    <i class="fas fa-paper-plane"></i> Send to Service
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Complete Service -->
                <div class="tab-pane fade" id="tab-complete" role="tabpanel">
                    <div class="asset-card">
                        <div class="asset-card__header">
                            <h6><i class="fas fa-check-circle"></i> Complete Service Transaction</h6>
                        </div>
                        <div class="asset-card__body">
                            <div class="row g-3">
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Asset In Service</label>
                                    <select id="ddlCompleteAsset" class="form-control" style="width:100%"></select>
                                    <span class="fs-12 color-light">Pick an asset currently in service to auto-load its ticket.</span>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Transaction ID <span class="required-star">*</span></label>
                                    <input type="number" id="txtTransactionId" class="form-control" placeholder="Transaction Id" />
                                </div>
                                <div class="col-12" id="completeTicketInfo" style="display:none;">
                                    <div class="asset-badge asset-badge-inservice" id="completeTicketInfoText"></div>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Actual Return Date</label>
                                    <input type="date" id="txtActualReturnDate" class="form-control" />
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Status</label>
                                    <select id="ddlCompleteStatus" class="form-control">
                                        <option value="Completed">Completed</option>
                                        <option value="Replaced">Replaced</option>
                                        <option value="Pending">Pending</option>
                                    </select>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Replacement Asset</label>
                                    <select id="ddlReplacementAsset" class="form-control" style="width:100%"></select>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Replacement Date</label>
                                    <input type="date" id="txtReplacementDate" class="form-control" />
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Remarks</label>
                                    <textarea id="txtCompleteRemarks" class="form-control" rows="2" placeholder="Optional remarks"></textarea>
                                </div>
                            </div>
                            <div class="mt-25">
                                <button type="button" class="btn-asset-primary" onclick="CompleteService();">
                                    <i class="fas fa-check"></i> Complete Service
                                </button>
                            </div>
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

        var serviceCreateUrl = `${rootUrl}/api/AssetTransaction/service/create`;
        var serviceCompleteUrl = `${rootUrl}/api/AssetTransaction/service/complete`;
        var inServicingUrl = `${rootUrl}/api/AssetTransaction/report/inServicing?companyId=${CompanyID}`;

        var assetListUrl = `${rootUrl}/api/Asset/list?companyId=${CompanyID}`;
        var empUrl = `${rootUrl}/api/Employee/EmployeeName?CompanyId=${CompanyID}`;
        var serviceCenterBasicInfoUrl = `${rootUrl}/api/ServiceCenter/basicInfo?companyId=${CompanyID}`;

        var inServicingList = [];

        $(document).ready(function () {
            $('#ddlServiceAsset, #ddlReplacementAsset, #ddlCompleteAsset').select2({ placeholder: 'Select Asset', width: '100%' });
            $('#ddlServiceEmp').select2({ placeholder: 'Select Employee', width: '100%' });
            $('#ddlServiceCenter').select2({ placeholder: 'Select a service center', width: '100%', allowClear: true });

            var today = new Date().toISOString().slice(0, 10);
            $('#txtServiceDate').val(today);
            $('#txtActualReturnDate').val(today);

            LoadAssets();
            LoadEmployees();
            LoadServiceCenters();
            LoadInServicingList();

            $('#ddlCompleteAsset').on('change', function () {
                FillCompleteTicketFromAsset($(this).val());
            });
        });

        function LoadAssets() {
            ApiCall(assetListUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    var options = '<option value="">-- Select Asset --</option>';
                    data.forEach(function (a) {
                        var id = a.assetId != null ? a.assetId : a.id;
                        options += `<option value="${id}">${a.assetCode}${a.serialNo ? ' (' + a.serialNo + ')' : ''}</option>`;
                    });
                    $('#ddlServiceAsset, #ddlReplacementAsset').html(options);
                })
                .catch(function (error) {
                    console.error('Error loading assets:', error);
                });
        }

        function LoadEmployees() {
            ApiCall(empUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    var options = '<option value="">-- Select Employee --</option>';
                    data.forEach(function (e) {
                        options += `<option value="${e.empId}">${e.fullName}</option>`;
                    });
                    $('#ddlServiceEmp').html(options);
                })
                .catch(function (error) {
                    console.error('Error loading employees:', error);
                });
        }

        function LoadServiceCenters() {
            ApiCall(serviceCenterBasicInfoUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    var $ddl = $('#ddlServiceCenter');
                    $ddl.empty().append('<option value="">-- No Service Center --</option>');
                    data.forEach(function (s) {
                        $ddl.append(`<option value="${s.id}">${s.name}</option>`);
                    });
                })
                .catch(function (error) {
                    console.error('Error loading service centers:', error);
                });
        }

        function LoadInServicingList() {
            ApiCall(inServicingUrl, token)
                .then(function (response) {
                    inServicingList = (response && response.data) ? response.data : [];
                    var $ddl = $('#ddlCompleteAsset');
                    $ddl.empty().append('<option value="">-- Select Asset --</option>');
                    inServicingList.forEach(function (t) {
                        $ddl.append(`<option value="${t.assetId}">${t.itemName || ''}${t.serialNo ? ' (' + t.serialNo + ')' : ''} — Ticket #${t.transactionId}</option>`);
                    });
                })
                .catch(function (error) {
                    console.error('Error loading in-servicing list:', error);
                });
        }

        function FillCompleteTicketFromAsset(assetId) {
            $('#txtTransactionId').val('');
            $('#completeTicketInfo').hide();
            if (!assetId) return;

            var ticket = inServicingList.find(function (t) { return t.assetId == assetId; });
            if (!ticket) return;

            $('#txtTransactionId').val(ticket.transactionId);
            $('#completeTicketInfoText').text(
                `Ticket #${ticket.transactionId} — ${ticket.serviceCenterName || 'no service center'}, problem: ${ticket.problem || 'N/A'}.`
            );
            $('#completeTicketInfo').show();
        }

        function SendToService() {
            var assetId = $('#ddlServiceAsset').val();
            var problem = $('#txtProblem').val().trim();

            if (!assetId) {
                Swal.fire({ icon: 'warning', title: 'Warning', text: 'Please select an Asset.' });
                return;
            }
            if (problem === '') {
                Swal.fire({ icon: 'warning', title: 'Warning', text: 'Please describe the problem.' });
                return;
            }

            var empVal = $('#ddlServiceEmp').val();
            var serviceCenterVal = $('#ddlServiceCenter').val();

            var payload = {
                companyId: CompanyID,
                assetId: parseInt(assetId, 10),
                employeeId: empVal ? parseInt(empVal, 10) : null,
                problem: problem,
                serviceCenterId: serviceCenterVal ? parseInt(serviceCenterVal, 10) : null,
                serviceDate: $('#txtServiceDate').val() ? new Date($('#txtServiceDate').val()).toISOString() : null,
                expectedReturnDate: $('#txtExpectedReturnDate').val() ? new Date($('#txtExpectedReturnDate').val()).toISOString() : null,
                remarks: $('#txtSendRemarks').val().trim()
            };

            ApiCallPost(serviceCreateUrl, token, payload)
                .then(function (response) {
                    if (response && response.statusCode && response.statusCode !== 200) { return; }
                    Swal.fire({ icon: 'success', title: 'Sent', text: 'Asset sent to service successfully.' })
                        .then(function () {
                            $('#ddlServiceAsset, #ddlServiceEmp, #ddlServiceCenter').val('').trigger('change');
                            $('#txtProblem, #txtSendRemarks, #txtExpectedReturnDate').val('');
                            LoadAssets();
                            LoadInServicingList();
                        });
                });
        }

        function CompleteService() {
            var transactionId = $('#txtTransactionId').val();

            if (!transactionId) {
                Swal.fire({ icon: 'warning', title: 'Warning', text: 'Please enter the Transaction Id.' });
                return;
            }

            var replacementAssetId = $('#ddlReplacementAsset').val();

            var payload = {
                transactionId: parseInt(transactionId, 10),
                actualReturnDate: $('#txtActualReturnDate').val() ? new Date($('#txtActualReturnDate').val()).toISOString() : null,
                replacementAssetId: replacementAssetId ? parseInt(replacementAssetId, 10) : null,
                replacementDate: $('#txtReplacementDate').val() ? new Date($('#txtReplacementDate').val()).toISOString() : null,
                status: $('#ddlCompleteStatus').val(),
                remarks: $('#txtCompleteRemarks').val().trim()
            };

            ApiCallUpdateWithoutId(serviceCompleteUrl, token, payload)
                .then(function () {
                    Swal.fire({ icon: 'success', title: 'Completed', text: 'Service transaction completed successfully.' })
                        .then(function () {
                            $('#txtTransactionId, #txtCompleteRemarks, #txtReplacementDate').val('');
                            $('#ddlReplacementAsset, #ddlCompleteAsset').val('').trigger('change');
                            $('#completeTicketInfo').hide();
                            LoadAssets();
                            LoadInServicingList();
                        });
                })
                .catch(function () {
                    Swal.fire({ icon: 'error', title: 'Error', text: 'Failed to complete the service transaction.' });
                });
        }
    </script>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
