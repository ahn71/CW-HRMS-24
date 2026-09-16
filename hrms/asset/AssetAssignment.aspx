<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="AssetAssignment.aspx.cs" Inherits="SigmaERP.hrms.asset.AssetAssignment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-exchange-alt"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Asset Assignment</h4>
                            <p class="asset-hero__subtitle">Assign assets to employees, confirm receiving &amp; process returns</p>
                        </div>
                    </div>
                </div>
            </div>

            <ul class="nav asset-tabs" id="assignTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="tab-assign-btn" data-bs-toggle="tab" data-bs-target="#tab-assign" type="button" role="tab">
                        <i class="fas fa-hand-holding"></i> Assign Asset
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="tab-receive-btn" data-bs-toggle="tab" data-bs-target="#tab-receive" type="button" role="tab">
                        <i class="fas fa-clipboard-check"></i> Confirm Receive
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="tab-return-btn" data-bs-toggle="tab" data-bs-target="#tab-return" type="button" role="tab">
                        <i class="fas fa-undo"></i> Return Asset
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="tab-history-btn" data-bs-toggle="tab" data-bs-target="#tab-history" type="button" role="tab">
                        <i class="fas fa-list-ul"></i> Assignment History
                    </button>
                </li>
            </ul>

            <div class="tab-content">

                <!-- Assign -->
                <div class="tab-pane fade show active" id="tab-assign" role="tabpanel">
                    <div class="asset-card">
                        <div class="asset-card__header">
                            <h6><i class="fas fa-hand-holding"></i> Assign Asset to Employee</h6>
                        </div>
                        <div class="asset-card__body">
                            <div class="row g-3">
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Asset <span class="required-star">*</span></label>
                                    <select id="ddlAssignAsset" class="form-control" style="width:100%"></select>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Employee <span class="required-star">*</span></label>
                                    <select id="ddlAssignEmp" class="form-control" style="width:100%"></select>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Issue Date</label>
                                    <input type="date" id="txtIssueDate" class="form-control" />
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Remarks</label>
                                    <textarea id="txtAssignRemarks" class="form-control" rows="2" placeholder="Optional remarks"></textarea>
                                </div>
                            </div>
                            <div class="mt-25">
                                <button type="button" class="btn-asset-primary" onclick="AssignAsset();">
                                    <i class="fas fa-paper-plane"></i> Assign Asset
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Confirm Receive -->
                <div class="tab-pane fade" id="tab-receive" role="tabpanel">
                    <div class="asset-card">
                        <div class="asset-card__header">
                            <h6><i class="fas fa-clipboard-check"></i> Confirm Asset Receive</h6>
                        </div>
                        <div class="asset-card__body">
                            <div class="row g-3">
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Asset</label>
                                    <select id="ddlReceiveAsset" class="form-control" style="width:100%"></select>
                                    <span class="fs-12 color-light">Pick the asset to auto-load its latest assignment.</span>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Assignment ID <span class="required-star">*</span></label>
                                    <input type="number" id="txtAssignmentId" class="form-control" placeholder="Assignment Id" />
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Received Date</label>
                                    <input type="date" id="txtReceivedDate" class="form-control" />
                                </div>
                                <div class="col-12" id="receiveAssignmentInfo" style="display:none;">
                                    <div class="asset-badge asset-badge-assigned" id="receiveAssignmentInfoText"></div>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Remarks</label>
                                    <textarea id="txtReceiveRemarks" class="form-control" rows="2" placeholder="Optional remarks"></textarea>
                                </div>
                            </div>
                            <div class="mt-25">
                                <button type="button" class="btn-asset-primary" onclick="ConfirmReceive();">
                                    <i class="fas fa-check"></i> Confirm Receive
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Return -->
                <div class="tab-pane fade" id="tab-return" role="tabpanel">
                    <div class="asset-card">
                        <div class="asset-card__header">
                            <h6><i class="fas fa-undo"></i> Return Asset</h6>
                        </div>
                        <div class="asset-card__body">
                            <div class="row g-3">
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Asset <span class="required-star">*</span></label>
                                    <select id="ddlReturnAsset" class="form-control" style="width:100%"></select>
                                    <span class="fs-12 color-light">Selecting the asset auto-fills its current holder.</span>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Employee <span class="required-star">*</span></label>
                                    <select id="ddlReturnEmp" class="form-control" style="width:100%"></select>
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Return Date</label>
                                    <input type="date" id="txtReturnDate" class="form-control" />
                                </div>
                                <div class="col-lg-4 col-md-6">
                                    <label class="form-label">Asset Condition</label>
                                    <select id="ddlAssetCondition" class="form-control">
                                        <option value="Good">Good</option>
                                        <option value="Minor Damage">Minor Damage</option>
                                        <option value="Major Damage">Major Damage</option>
                                        <option value="Not Working">Not Working</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Remarks</label>
                                    <textarea id="txtReturnRemarks" class="form-control" rows="2" placeholder="Optional remarks"></textarea>
                                </div>
                            </div>
                            <div class="mt-25">
                                <button type="button" class="btn-asset-primary" onclick="ReturnAsset();">
                                    <i class="fas fa-undo"></i> Return Asset
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Assignment History -->
                <div class="tab-pane fade" id="tab-history" role="tabpanel">
                    <div class="asset-card">
                        <div class="asset-card__header">
                            <h6><i class="fas fa-list-ul"></i> Assignment History</h6>
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
        </div>
    </div>

    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var token = '<%= Session["__UserToken__"] %>';

        var assignUrl = `${rootUrl}/api/AssetAssignment/assign`;
        var confirmReceiveUrl = `${rootUrl}/api/AssetAssignment/confirmReceive`;
        var returnUrl = `${rootUrl}/api/AssetAssignment/return`;

        var assetListUrl = `${rootUrl}/api/Asset/list?companyId=${CompanyID}`;
        var empUrl = `${rootUrl}/api/Employee/EmployeeName?CompanyId=${CompanyID}`;
        var activeAssignmentBaseUrl = `${rootUrl}/api/AssetAssignment/active`;
        var historyUrl = `${rootUrl}/api/AssetAssignment/report/employeeWiseAsset?companyId=${CompanyID}`;

        var employees = [];

        $(document).ready(function () {
            $('#ddlAssignAsset, #ddlReturnAsset, #ddlReceiveAsset').select2({ placeholder: 'Select Asset', width: '100%' });
            $('#ddlAssignEmp, #ddlReturnEmp').select2({ placeholder: 'Select Employee', width: '100%' });

            var today = new Date().toISOString().slice(0, 10);
            $('#txtIssueDate').val(today);
            $('#txtReceivedDate').val(today);
            $('#txtReturnDate').val(today);

            LoadAssets();
            LoadEmployees();

            $('#ddlReceiveAsset').on('change', function () {
                LoadActiveAssignmentForReceive($(this).val());
            });

            $('#ddlReturnAsset').on('change', function () {
                LoadActiveAssignmentForReturn($(this).val());
            });

            $('#tab-history-btn').on('shown.bs.tab', function () {
                GetAssignmentHistory();
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
                    $('#ddlAssignAsset, #ddlReturnAsset, #ddlReceiveAsset').html(options);
                })
                .catch(function (error) {
                    console.error('Error loading assets:', error);
                });
        }

        function LoadEmployees() {
            ApiCall(empUrl, token)
                .then(function (response) {
                    employees = (response && response.data) ? response.data : [];
                    var options = '<option value="">-- Select Employee --</option>';
                    employees.forEach(function (e) {
                        options += `<option value="${e.empId}">${e.fullName}</option>`;
                    });
                    $('#ddlAssignEmp, #ddlReturnEmp').html(options);
                })
                .catch(function (error) {
                    console.error('Error loading employees:', error);
                });
        }

        function getEmployeeName(empId) {
            var found = employees.find(function (e) { return e.empId == empId; });
            return found ? found.fullName : empId;
        }

        function LoadActiveAssignmentForReceive(assetId) {
            $('#txtAssignmentId').val('');
            $('#receiveAssignmentInfo').hide();
            if (!assetId) return;

            ApiCall(`${activeAssignmentBaseUrl}/${assetId}`, token)
                .then(function (response) {
                    var assignment = response && response.data;
                    if (!assignment) return;
                    $('#txtAssignmentId').val(assignment.assignmentId);
                    var statusText = assignment.receivedConfirmation ? 'already confirmed received' : 'awaiting receive confirmation';
                    $('#receiveAssignmentInfoText').text(
                        `Assignment #${assignment.assignmentId} — issued to ${getEmployeeName(assignment.empId)} on ${toDateInputValue(assignment.issueDate)} (${statusText}).`
                    );
                    $('#receiveAssignmentInfo').show();
                })
                .catch(function () {
                    $('#receiveAssignmentInfoText').text('No active assignment found for this asset.');
                    $('#receiveAssignmentInfo').show();
                });
        }

        function LoadActiveAssignmentForReturn(assetId) {
            if (!assetId) return;

            ApiCall(`${activeAssignmentBaseUrl}/${assetId}`, token)
                .then(function (response) {
                    var assignment = response && response.data;
                    if (!assignment || !assignment.empId) return;
                    $('#ddlReturnEmp').val(assignment.empId).trigger('change');
                })
                .catch(function () {
                    console.warn('No active assignment found for the selected asset.');
                });
        }

        function toDateInputValue(dateStr) {
            if (!dateStr) return '';
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return '';
            return d.toISOString().slice(0, 10);
        }

        function AssignAsset() {
            var assetId = $('#ddlAssignAsset').val();
            var empId = $('#ddlAssignEmp').val();

            if (!assetId || !empId) {
                Swal.fire({ icon: 'warning', title: 'Warning', text: 'Please select both Asset and Employee.' });
                return;
            }

            var payload = {
                companyId: CompanyID,
                assetId: parseInt(assetId, 10),
                empId: empId,
                issueDate: $('#txtIssueDate').val() ? new Date($('#txtIssueDate').val()).toISOString() : null,
                remarks: $('#txtAssignRemarks').val().trim()
            };

            ApiCallPost(assignUrl, token, payload)
                .then(function (response) {
                    if (response && response.statusCode && response.statusCode !== 200) { return; }
                    Swal.fire({ icon: 'success', title: 'Assigned', text: 'Asset assigned successfully.' })
                        .then(function () {
                            $('#ddlAssignAsset, #ddlAssignEmp').val('').trigger('change');
                            $('#txtAssignRemarks').val('');
                            LoadAssets();
                        });
                });
        }

        function ConfirmReceive() {
            var assignmentId = $('#txtAssignmentId').val();

            if (!assignmentId) {
                Swal.fire({ icon: 'warning', title: 'Warning', text: 'Please enter the Assignment Id.' });
                return;
            }

            var payload = {
                assignmentId: parseInt(assignmentId, 10),
                receivedDate: $('#txtReceivedDate').val() ? new Date($('#txtReceivedDate').val()).toISOString() : null,
                remarks: $('#txtReceiveRemarks').val().trim()
            };

            ApiCallUpdateWithoutId(confirmReceiveUrl, token, payload)
                .then(function () {
                    Swal.fire({ icon: 'success', title: 'Confirmed', text: 'Asset receive confirmed successfully.' })
                        .then(function () {
                            $('#txtAssignmentId').val('');
                            $('#txtReceiveRemarks').val('');
                            $('#receiveAssignmentInfo').hide();
                            $('#ddlReceiveAsset').val('').trigger('change');
                        });
                });
        }

        function ReturnAsset() {
            var assetId = $('#ddlReturnAsset').val();
            var employeeId = $('#ddlReturnEmp').val();

            if (!assetId || !employeeId) {
                Swal.fire({ icon: 'warning', title: 'Warning', text: 'Please select both Asset and Employee.' });
                return;
            }

            var payload = {
                companyId: CompanyID,
                assetId: parseInt(assetId, 10),
                employeeId: parseInt(employeeId, 10),
                returnDate: $('#txtReturnDate').val() ? new Date($('#txtReturnDate').val()).toISOString() : null,
                assetCondition: $('#ddlAssetCondition').val(),
                remarks: $('#txtReturnRemarks').val().trim()
            };

            ApiCallPost(returnUrl, token, payload)
                .then(function (response) {
                    if (response && response.statusCode && response.statusCode !== 200) { return; }
                    Swal.fire({ icon: 'success', title: 'Returned', text: 'Asset returned successfully.' })
                        .then(function () {
                            $('#ddlReturnAsset, #ddlReturnEmp').val('').trigger('change');
                            $('#txtReturnRemarks').val('');
                            LoadAssets();
                        });
                });
        }

        function GetAssignmentHistory() {
            ApiCall(historyUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    bindHistoryTable(data);
                })
                .catch(function (error) {
                    console.error('Error loading assignment history:', error);
                    bindHistoryTable([]);
                });
        }

        function bindHistoryTable(data) {
            var $table = $('#tab-history .adv-table');
            if ($table.data('footable')) {
                $table.data('footable').destroy();
            }
            $table.html('');
            $('#tab-history .asset-empty').remove();
            $('#tab-history #filter-form-container').empty();

            if (!data.length) {
                $table.after('<div class="asset-empty"><i class="fas fa-inbox"></i>No assignment history found.</div>');
                return;
            }

            data.forEach(function (row) {
                row.issueDateDisplay = toDateInputValue(row.issueDate);
                row.statusBadge = `<span class="asset-badge asset-badge-assigned">${row.status || 'N/A'}</span>`;
            });

            var columns = [
                { name: 'empId', title: 'Employee ID', className: 'userDatatable-content' },
                { name: 'empName', title: 'Employee Name', className: 'userDatatable-content' },
                { name: 'dptName', title: 'Department', className: 'userDatatable-content' },
                { name: 'itemName', title: 'Item', className: 'userDatatable-content' },
                { name: 'serialNo', title: 'Serial No', className: 'userDatatable-content' },
                { name: 'issueDateDisplay', title: 'Issue Date', className: 'userDatatable-content' },
                { name: 'statusBadge', title: 'Asset Status', type: 'html', className: 'userDatatable-content' }
            ];

            try {
                $table.footable({
                    columns: columns,
                    rows: data,
                    filtering: { enabled: true, placeholder: 'Search employee, item, serial no...', containers: '#tab-history #filter-form-container' },
                    paging: { enabled: true, size: 10 },
                    sorting: true
                });
            } catch (e) {
                console.error('Footable init error:', e);
            }
        }
    </script>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
