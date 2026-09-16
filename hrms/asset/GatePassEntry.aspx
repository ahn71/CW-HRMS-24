<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="GatePassEntry.aspx.cs" Inherits="SigmaERP.hrms.asset.GatePassEntry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #gatePassForm { display: none; }
        .gp-toggle { display: inline-flex; background: var(--asset-bg-soft); border-radius: 10px; padding: 4px; gap: 4px; }
        .gp-toggle button { border: none; background: transparent; padding: 8px 18px; border-radius: 8px; font-weight: 600; font-size: 13px; color: var(--asset-muted); }
        .gp-toggle button.active { background: #fff; color: var(--asset-primary-dark); box-shadow: 0 4px 10px -6px rgba(31,36,48,.35); }
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
                        <div class="asset-hero__icon"><i class="fas fa-id-card"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Gate Pass Entry</h4>
                            <p class="asset-hero__subtitle">Request a gate pass for an employee or visitor to move items in/out</p>
                        </div>
                    </div>
                    <button type="button" id="btnToggleForm" class="btn-asset-toggle" onclick="ToggleForm();">
                        <i class="fas fa-plus"></i> <span id="btnToggleFormText">New Gate Pass</span>
                    </button>
                </div>
            </div>

            <div class="asset-card" id="gatePassForm">
                <div class="asset-card__header">
                    <h6><i class="fas fa-id-card"></i> New Gate Pass Request</h6>
                </div>
                <div class="asset-card__body">
                    <div class="row g-3">
                        <div class="col-12" id="gpForToggle" style="display:none;">
                            <label class="form-label">This pass is for</label><br />
                            <div class="gp-toggle">
                                <button type="button" class="active" data-mode="employee" onclick="SetForMode('employee');">Employee</button>
                                <button type="button" data-mode="visitor" onclick="SetForMode('visitor');">Visitor</button>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 gp-employee-field">
                            <label class="form-label">Requested For</label>
                            <select id="ddlEmployee" class="form-control" style="width:100%" disabled></select>
                            <span class="fs-12 color-light">This gate pass is created under your own name.</span>
                        </div>
                        <div class="col-lg-4 col-md-6 gp-visitor-field" style="display:none;">
                            <label class="form-label">Visitor Name <span class="required-star">*</span></label>
                            <input type="text" id="txtVisitorName" class="form-control" placeholder="Visitor's full name" />
                        </div>
                        <div class="col-lg-4 col-md-6 gp-visitor-field" style="display:none;">
                            <label class="form-label">Visitor Contact</label>
                            <input type="text" id="txtVisitorContact" class="form-control" placeholder="Phone number" />
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Department</label>
                            <select id="ddlDepartment" class="form-control" style="width:100%"></select>
                        </div>

                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Item Name <span class="required-star">*</span></label>
                            <input type="text" id="txtItemName" class="form-control" placeholder="e.g. Dell Laptop" />
                            <span class="text-danger" id="txtItemNameError"></span>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Quantity</label>
                            <input type="number" min="1" id="txtQuantity" class="form-control" value="1" />
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Linked Asset (optional)</label>
                            <select id="ddlAsset" class="form-control" style="width:100%"></select>
                        </div>

                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Serial No</label>
                            <input type="text" id="txtSerialNo" class="form-control" placeholder="Serial / IMEI number" />
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Delivery / Return Type <span class="required-star">*</span></label>
                            <select id="ddlDeliveryReturnType" class="form-control">
                                <option value="Delivery">Delivery (leaving permanently)</option>
                                <option value="Return">Return (bringing back)</option>
                                <option value="Non-Returnable">Non-Returnable</option>
                            </select>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Vehicle No</label>
                            <input type="text" id="txtVehicleNo" class="form-control" placeholder="Optional" />
                        </div>

                        <div class="col-lg-6">
                            <label class="form-label">Purpose <span class="required-star">*</span></label>
                            <input type="text" id="txtPurpose" class="form-control" placeholder="Reason for the gate pass" />
                            <span class="text-danger" id="txtPurposeError"></span>
                        </div>
                        <div class="col-lg-6">
                            <label class="form-label">Destination <span class="required-star">*</span></label>
                            <input type="text" id="txtDestination" class="form-control" placeholder="Where is it going" />
                            <span class="text-danger" id="txtDestinationError"></span>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Remarks</label>
                            <textarea id="txtRemarks" class="form-control" rows="2" placeholder="Optional remarks"></textarea>
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-25">
                        <button type="button" class="btn-asset-primary" onclick="SubmitGatePass();">
                            <i class="fas fa-paper-plane"></i> Submit Request
                        </button>
                        <button type="button" class="btn-asset-outline" onclick="ClearGatePassForm();">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-list-ul"></i> Recent Gate Passes</h6>
                    <div class="d-flex align-items-center gap-2">
                        <div id="filter-form-container"></div>
                        <button type="button" class="btn-asset-outline" onclick="GetRecentGatePasses();"><i class="fas fa-sync-alt"></i> Refresh</button>
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
            <div class="gp-field"><label>Department</label><div id="slipDept">-</div></div>
            <div class="gp-field"><label>Item Name</label><div id="slipItem">-</div></div>
            <div class="gp-field"><label>Quantity</label><div id="slipQty">-</div></div>
            <div class="gp-field"><label>Serial No</label><div id="slipSerial">-</div></div>
            <div class="gp-field"><label>Delivery / Return Type</label><div id="slipType">-</div></div>
            <div class="gp-field"><label>Purpose</label><div id="slipPurpose">-</div></div>
            <div class="gp-field"><label>Destination</label><div id="slipDestination">-</div></div>
            <div class="gp-field"><label>Vehicle No</label><div id="slipVehicle">-</div></div>
            <div class="gp-field"><label>Remarks</label><div id="slipRemarks">-</div></div>
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
        var LoginUserId = '<%= Session["__GetUserId__"]%>';
        var LoginEmpId = '<%= Session["__GetEmpId__"]%>';
        var token = '<%= Session["__UserToken__"] %>';

        var requestUrl = `${rootUrl}/api/GatePass/request`;
        var historyUrl = `${rootUrl}/api/GatePass/history?companyId=${CompanyID}`;
        var empUrl = `${rootUrl}/api/Employee/EmployeeName?CompanyId=${CompanyID}`;
        var deptUrl = `${rootUrl}/api/Department/basicInfo/${CompanyID}`;
        var assetListUrl = `${rootUrl}/api/Asset/list?companyId=${CompanyID}`;
        var companyUrl = `${rootUrl}/api/Company/GetDropdownCompanies?CompanyId=${CompanyID}`;

        var employees = [];
        var assets = [];
        var forMode = 'employee';

        $(document).ready(function () {
            $('#ddlEmployee, #ddlAsset').select2({ placeholder: 'Select...', width: '100%', allowClear: true });
            $('#ddlDepartment').select2({ placeholder: 'Select Department', width: '100%', allowClear: true });

            LoadEmployees();
            LoadDepartments();
            LoadAssets();
            LoadCompanyName();
            GetRecentGatePasses();

            $('#ddlAsset').on('change', function () {
                var assetId = $(this).val();
                var asset = assets.find(function (a) { return (a.assetId != null ? a.assetId : a.id) == assetId; });
                $('#txtSerialNo').val(asset ? (asset.serialNo || '') : '');
            });
        });

        function SetForMode(mode) {
            forMode = mode;
            $('#gpForToggle button').removeClass('active');
            $('#gpForToggle button[data-mode="' + mode + '"]').addClass('active');
            if (mode === 'employee') {
                $('.gp-employee-field').show();
                $('.gp-visitor-field').hide();
            } else {
                $('.gp-employee-field').hide();
                $('.gp-visitor-field').show();
            }
        }

        function ToggleForm() {
            const $form = $('#gatePassForm');
            if ($form.is(':visible')) {
                $form.slideUp(150);
                $('#btnToggleFormText').text('New Gate Pass');
                $('#btnToggleForm i').removeClass('fa-times').addClass('fa-plus');
                ClearGatePassForm();
            } else {
                $form.slideDown(150);
                $('#btnToggleFormText').text('Close');
                $('#btnToggleForm i').removeClass('fa-plus').addClass('fa-times');
            }
        }

        function LoadEmployees() {
            ApiCall(empUrl, token)
                .then(function (response) {
                    employees = (response && response.data) ? response.data : [];
                    var $ddl = $('#ddlEmployee');
                    var me = employees.find(function (e) { return e.empId == LoginEmpId; });

                    if (LoginEmpId && LoginEmpId !== '0' && me) {
                        $ddl.empty().append(`<option value="${me.empId}" selected>${me.fullName}</option>`);
                    } else {
                        $ddl.empty().append('<option value="">No employee profile linked to your account</option>');
                    }
                    $ddl.trigger('change');
                })
                .catch(function (error) {
                    console.error('Error loading employees:', error);
                });
        }

        function LoadDepartments() {
            ApiCall(deptUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    var $ddl = $('#ddlDepartment');
                    $ddl.empty().append('<option value="">-- Select Department --</option>');
                    data.forEach(function (d) {
                        $ddl.append(`<option value="${d.dptId}">${d.dptName}</option>`);
                    });
                })
                .catch(function (error) {
                    console.error('Error loading departments:', error);
                });
        }

        function LoadAssets() {
            ApiCall(assetListUrl, token)
                .then(function (response) {
                    assets = (response && response.data) ? response.data : [];
                    var $ddl = $('#ddlAsset');
                    $ddl.empty().append('<option value="">-- No Linked Asset --</option>');
                    assets.forEach(function (a) {
                        var id = a.assetId != null ? a.assetId : a.id;
                        $ddl.append(`<option value="${id}">${a.assetCode}${a.serialNo ? ' (' + a.serialNo + ')' : ''}</option>`);
                    });
                })
                .catch(function (error) {
                    console.error('Error loading assets:', error);
                });
        }

        var companyName = '';
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

        function ValidateGatePass() {
            var isValid = true;

            if (forMode === 'employee' && !$('#ddlEmployee').val()) {
                Swal.fire({ icon: 'warning', title: 'Warning', text: 'No employee profile is linked to your account, so a gate pass cannot be requested. Please contact HR.' });
                isValid = false;
            }
            if (forMode === 'visitor' && $('#txtVisitorName').val().trim() === '') {
                Swal.fire({ icon: 'warning', title: 'Warning', text: 'Please enter the visitor name.' });
                isValid = false;
            }

            var itemName = $('#txtItemName').val().trim();
            if (itemName === '') {
                $('#txtItemNameError').html('Item Name is required.');
                isValid = false;
            } else {
                $('#txtItemNameError').html('');
            }

            var purpose = $('#txtPurpose').val().trim();
            if (purpose === '') {
                $('#txtPurposeError').html('Purpose is required.');
                isValid = false;
            } else {
                $('#txtPurposeError').html('');
            }

            var destination = $('#txtDestination').val().trim();
            if (destination === '') {
                $('#txtDestinationError').html('Destination is required.');
                isValid = false;
            } else {
                $('#txtDestinationError').html('');
            }

            return isValid;
        }

        function SubmitGatePass() {
            if (!ValidateGatePass()) return;

            var assetId = $('#ddlAsset').val();

            var payload = {
                companyId: CompanyID,
                empId: forMode === 'employee' ? $('#ddlEmployee').val() : null,
                visitorName: forMode === 'visitor' ? $('#txtVisitorName').val().trim() : null,
                visitorContact: forMode === 'visitor' ? $('#txtVisitorContact').val().trim() : null,
                dptId: $('#ddlDepartment').val() || null,
                itemName: $('#txtItemName').val().trim(),
                quantity: parseInt($('#txtQuantity').val() || 1, 10),
                assetId: assetId ? parseInt(assetId, 10) : null,
                serialNo: $('#txtSerialNo').val().trim(),
                purpose: $('#txtPurpose').val().trim(),
                destination: $('#txtDestination').val().trim(),
                vehicleNo: $('#txtVehicleNo').val().trim(),
                deliveryReturnType: $('#ddlDeliveryReturnType').val(),
                remarks: $('#txtRemarks').val().trim(),
                requestedBy: parseInt(LoginUserId, 10)
            };

            ApiCallPost(requestUrl, token, payload)
                .then(function (response) {
                    if (response && response.statusCode && response.statusCode !== 200) { return; }
                    Swal.fire({ icon: 'success', title: 'Submitted', text: 'Gate pass requested successfully. Awaiting approval.' })
                        .then(function () { GetRecentGatePasses(); ToggleForm(); });
                });
        }

        function ClearGatePassForm() {
            SetForMode('employee');
            $('#ddlEmployee').val(LoginEmpId && LoginEmpId !== '0' ? LoginEmpId : '').trigger('change');
            $('#txtVisitorName').val('');
            $('#txtVisitorContact').val('');
            $('#ddlDepartment').val('').trigger('change');
            $('#txtItemName').val('');
            $('#txtQuantity').val(1);
            $('#ddlAsset').val('').trigger('change');
            $('#txtSerialNo').val('');
            $('#ddlDeliveryReturnType').val('Delivery');
            $('#txtVehicleNo').val('');
            $('#txtPurpose').val('');
            $('#txtDestination').val('');
            $('#txtRemarks').val('');
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

        function GetRecentGatePasses() {
            ApiCall(historyUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    bindGatePassTable(data);
                })
                .catch(function (error) {
                    console.error('Error loading gate passes:', error);
                    bindGatePassTable([]);
                });
        }

        function bindGatePassTable(data) {
            if ($('.adv-table').data('footable')) {
                $('.adv-table').data('footable').destroy();
            }
            $('.adv-table').html('');
            $('#filter-form-container').empty();
            $('.adv-table').closest('.asset-card__body').find('.asset-empty').remove();

            if (!data.length) {
                $('.adv-table').after('<div class="asset-empty"><i class="fas fa-inbox"></i>No gate pass requests found yet.</div>');
                return;
            }

            data.forEach(function (row) {
                row.dateTimeDisplay = toDateTimeDisplay(row.gatePassDateTime);
                row.personDisplay = row.empName || row.empId || row.visitorName || 'N/A';
                row.statusBadge = `<span class="asset-badge ${statusBadgeClass(row.status)}">${row.status || 'N/A'}</span>`;
                var canDownload = ['Approved', 'GateOut', 'Completed'].indexOf(row.status) !== -1;
                row.action = `
                    <div class="actions">
                        ${canDownload ? `<a href="javascript:void(0)" data-id="${row.gatePassId}" class="pdf-btn" title="Download PDF"><i class="fas fa-file-pdf"></i></a>` : ''}
                    </div>`;
            });

            var columns = [
                { name: 'gatePassNo', title: 'Gate Pass No', className: 'userDatatable-content' },
                { name: 'dateTimeDisplay', title: 'Date', className: 'userDatatable-content' },
                { name: 'personDisplay', title: 'Employee / Visitor', className: 'userDatatable-content' },
                { name: 'itemName', title: 'Item', className: 'userDatatable-content' },
                { name: 'quantity', title: 'Qty', className: 'userDatatable-content' },
                { name: 'purpose', title: 'Purpose', className: 'userDatatable-content' },
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
            $('#slipDept').text(row.dptName || '-');
            $('#slipItem').text(row.itemName || '-');
            $('#slipQty').text(row.quantity != null ? row.quantity : '-');
            $('#slipSerial').text(row.serialNo || '-');
            $('#slipType').text(row.deliveryReturnType || '-');
            $('#slipPurpose').text(row.purpose || '-');
            $('#slipDestination').text(row.destination || '-');
            $('#slipVehicle').text(row.vehicleNo || '-');
            $('#slipRemarks').text(row.remarks || '-');
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
