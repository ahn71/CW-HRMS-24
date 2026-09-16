<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="AssetList.aspx.cs" Inherits="SigmaERP.hrms.asset.AssetList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #assetForm { display: none; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-laptop"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Asset Register</h4>
                            <p class="asset-hero__subtitle">Track every company asset &mdash; purchase, warranty &amp; depreciation details</p>
                        </div>
                    </div>
                    <button type="button" id="btnToggleForm" class="btn-asset-toggle" onclick="ToggleForm();">
                        <i class="fas fa-plus"></i> <span id="btnToggleFormText">Add New Asset</span>
                    </button>
                </div>
            </div>

            <div class="asset-card" id="assetForm">
                <div class="asset-card__header">
                    <h6><i class="fas fa-clipboard-list"></i> <span id="formTitle">Add Asset</span></h6>
                </div>
                <div class="asset-card__body">
                    <input type="hidden" id="hdnAssetId" value="" />
                    <div class="row g-3">
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Asset Code <span class="required-star">*</span></label>
                            <input type="text" id="txtAssetCode" class="form-control" placeholder="e.g. AST-0001" />
                            <span class="text-danger" id="txtAssetCodeError"></span>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Asset Item <span class="required-star">*</span></label>
                            <select id="ddlItem" class="form-control" style="width:100%"></select>
                            <span class="text-danger" id="ddlItemError"></span>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Supplier</label>
                            <select id="ddlSupplier" class="form-control" style="width:100%"></select>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Serial No</label>
                            <input type="text" id="txtSerialNo" class="form-control" placeholder="Serial number" />
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Purchase Date</label>
                            <input type="date" id="txtPurchaseDate" class="form-control" />
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Purchase Price</label>
                            <input type="number" step="0.01" id="txtPurchasePrice" class="form-control" placeholder="0.00" />
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Depreciation % / Month</label>
                            <input type="number" step="0.01" id="txtDepreciation" class="form-control" placeholder="0.00" />
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Status</label>
                            <select id="ddlStatus" class="form-control">
                                <option value="Available">Available</option>
                                <option value="Assigned">Assigned</option>
                                <option value="In Service">In Service</option>
                                <option value="Replaced">Replaced</option>
                                <option value="Damaged">Damaged</option>
                                <option value="Retired">Retired</option>
                                <option value="Disposed">Disposed</option>
                            </select>
                            <span class="fs-12 color-light">Only assets with status "Available" can be assigned to an employee.</span>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Warranty Start Date</label>
                            <input type="date" id="txtWarrantyStart" class="form-control" />
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label">Warranty End Date</label>
                            <input type="date" id="txtWarrantyEnd" class="form-control" />
                        </div>
                        <div class="col-lg-6">
                            <label class="form-label">Remarks</label>
                            <input type="text" id="txtRemarks" class="form-control" placeholder="Optional remarks" />
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-25">
                        <button type="button" class="btn-asset-primary" onclick="ValidateAndSaveAsset();">
                            <i class="fas fa-save"></i> <span id="btnSaveAssetText">Save Asset</span>
                        </button>
                        <button type="button" class="btn-asset-outline" onclick="ClearAssetForm();">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-list-ul"></i> Asset List</h6>
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

    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var token = '<%= Session["__UserToken__"] %>';

        var createUrl = `${rootUrl}/api/Asset/create`;
        var updateUrl = `${rootUrl}/api/Asset/update`;
        var deleteUrl = `${rootUrl}/api/Asset/delete`;
        var listUrl = `${rootUrl}/api/Asset/list?companyId=${CompanyID}`;
        var itemListUrl = `${rootUrl}/api/AssetItem/list?companyId=${CompanyID}`;
        var supplierBasicInfoUrl = `${rootUrl}/api/Supplier/basicInfo?companyId=${CompanyID}`;

        var assetItems = [];
        var assetRows = [];
        var suppliers = [];

        $(document).ready(function () {
            $('#ddlItem').select2({ placeholder: 'Select an asset item', width: '100%' });
            $('#ddlSupplier').select2({ placeholder: 'Select a supplier', width: '100%', allowClear: true });
            $.when(LoadAssetItems(), LoadSuppliers()).always(function () {
                GetAssets();
            });
        });

        function LoadSuppliers() {
            return ApiCall(supplierBasicInfoUrl, token)
                .then(function (response) {
                    suppliers = (response && response.data) ? response.data : [];
                    var $ddl = $('#ddlSupplier');
                    $ddl.empty().append('<option value="">-- No Supplier --</option>');
                    suppliers.forEach(function (s) {
                        $ddl.append(`<option value="${s.id}">${s.name}</option>`);
                    });
                })
                .catch(function (error) {
                    console.error('Error loading suppliers:', error);
                });
        }

        function getSupplierName(supplierId) {
            var found = suppliers.find(function (s) { return s.id == supplierId; });
            return found ? found.name : '';
        }

        function ToggleForm() {
            const $form = $('#assetForm');
            if ($form.is(':visible')) {
                $form.slideUp(150);
                $('#btnToggleFormText').text('Add New Asset');
                $('#btnToggleForm i').removeClass('fa-times').addClass('fa-plus');
                ClearAssetForm();
            } else {
                $form.slideDown(150);
                $('#btnToggleFormText').text('Close');
                $('#btnToggleForm i').removeClass('fa-plus').addClass('fa-times');
            }
        }

        function ExpandForm() {
            $('#assetForm').slideDown(150);
            $('#btnToggleFormText').text('Close');
            $('#btnToggleForm i').removeClass('fa-plus').addClass('fa-times');
            $('html, body').animate({ scrollTop: $('#assetForm').offset().top - 100 }, 300);
        }

        function LoadAssetItems() {
            return ApiCall(itemListUrl, token)
                .then(function (response) {
                    assetItems = (response && response.data) ? response.data : [];
                    var $ddl = $('#ddlItem');
                    $ddl.empty().append('<option value="">-- Select Item --</option>');
                    assetItems.forEach(function (it) {
                        var id = it.itemId != null ? it.itemId : it.id;
                        $ddl.append(`<option value="${id}">${it.itemName}</option>`);
                    });
                })
                .catch(function (error) {
                    console.error('Error loading asset items:', error);
                });
        }

        function getItemName(itemId) {
            var found = assetItems.find(function (i) { return (i.itemId != null ? i.itemId : i.id) == itemId; });
            return found ? found.itemName : itemId;
        }

        function statusBadgeHtml(status) {
            var map = {
                'Available': 'asset-badge-active',
                'Assigned': 'asset-badge-assigned',
                'In Service': 'asset-badge-inservice',
                'Replaced': 'asset-badge-replaced',
                'Retired': 'asset-badge-retired',
                'Damaged': 'asset-badge-inactive',
                'Disposed': 'asset-badge-retired'
            };
            var cls = map[status] || 'asset-badge-assigned';
            return `<span class="asset-badge ${cls}">${status || 'N/A'}</span>`;
        }

        function ValidateAndSaveAsset() {
            var assetCode = $('#txtAssetCode').val().trim();
            var itemId = $('#ddlItem').val();
            var isValid = true;

            if (assetCode === '') {
                $('#txtAssetCodeError').html('Asset Code is required.');
                isValid = false;
            } else {
                $('#txtAssetCodeError').html('');
            }

            if (!itemId) {
                $('#ddlItemError').html('Please select an asset item.');
                isValid = false;
            } else {
                $('#ddlItemError').html('');
            }

            if (!isValid) return;

            var payload = {
                companyId: CompanyID,
                assetCode: assetCode,
                itemId: parseInt(itemId, 10),
                supplierId: $('#ddlSupplier').val() ? parseInt($('#ddlSupplier').val(), 10) : null,
                serialNo: $('#txtSerialNo').val().trim(),
                purchaseDate: $('#txtPurchaseDate').val() ? new Date($('#txtPurchaseDate').val()).toISOString() : null,
                purchasePrice: parseFloat($('#txtPurchasePrice').val() || 0),
                depreciationPercentPerMonth: parseFloat($('#txtDepreciation').val() || 0),
                warrantyStartDate: $('#txtWarrantyStart').val() ? new Date($('#txtWarrantyStart').val()).toISOString() : null,
                warrantyEndDate: $('#txtWarrantyEnd').val() ? new Date($('#txtWarrantyEnd').val()).toISOString() : null,
                status: $('#ddlStatus').val(),
                remarks: $('#txtRemarks').val().trim()
            };

            var id = $('#hdnAssetId').val();

            if (id) {
                ApiCallUpdate(updateUrl, token, payload, id)
                    .then(function () {
                        Swal.fire({ icon: 'success', title: 'Updated', text: 'Asset updated successfully.' })
                            .then(function () { GetAssets(); ToggleForm(); });
                    })
                    .catch(function () {
                        Swal.fire({ icon: 'error', title: 'Error', text: 'Failed to update asset.' });
                    });
            } else {
                ApiCallPost(createUrl, token, payload)
                    .then(function (response) {
                        if (response && response.statusCode && response.statusCode !== 200) { return; }
                        Swal.fire({ icon: 'success', title: 'Saved', text: 'Asset created successfully.' })
                            .then(function () { GetAssets(); ToggleForm(); });
                    });
            }
        }

        function ClearAssetForm() {
            $('#hdnAssetId').val('');
            $('#txtAssetCode').val('');
            $('#ddlItem').val('').trigger('change');
            $('#ddlSupplier').val('').trigger('change');
            $('#txtSerialNo').val('');
            $('#txtPurchaseDate').val('');
            $('#txtPurchasePrice').val('');
            $('#txtDepreciation').val('');
            $('#txtWarrantyStart').val('');
            $('#txtWarrantyEnd').val('');
            $('#ddlStatus').val('Available');
            $('#txtRemarks').val('');
            $('#formTitle').text('Add Asset');
            $('#btnSaveAssetText').text('Save Asset');
        }

        function toDateInputValue(dateStr) {
            if (!dateStr) return '';
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return '';
            return d.toISOString().slice(0, 10);
        }

        function GetAssets() {
            ApiCall(listUrl, token)
                .then(function (response) {
                    assetRows = (response && response.data) ? response.data : [];
                    bindAssetTable(assetRows);
                })
                .catch(function (error) {
                    console.error('Error loading assets:', error);
                    bindAssetTable([]);
                });
        }

        function bindAssetTable(data) {
            if ($('.adv-table').data('footable')) {
                $('.adv-table').data('footable').destroy();
            }
            $('.adv-table').html('');
            $('#filter-form-container').empty();

            data.forEach(function (row, index) {
                row.slNo = index + 1;
                row.assetKey = row.assetId != null ? row.assetId : row.id;
                row.itemDisplay = row.itemName || getItemName(row.itemId);
                row.supplierDisplay = row.supplierId ? getSupplierName(row.supplierId) : '';
                row.purchaseDateDisplay = row.purchaseDate ? toDateInputValue(row.purchaseDate) : '';
                row.statusBadge = statusBadgeHtml(row.status);
                row.action = `
                    <div class="actions">
                        <a href="javascript:void(0)" data-id="${row.assetKey}" class="edit-btn" title="Edit"><i class="uil uil-edit"></i></a>
                        <a href="javascript:void(0)" data-id="${row.assetKey}" class="delete-btn" title="Delete"><i class="uil uil-trash-alt"></i></a>
                    </div>`;
            });

            var columns = [
                { name: 'slNo', title: 'SL', breakpoints: 'xs sm', type: 'number', className: 'userDatatable-content' },
                { name: 'assetCode', title: 'Asset Code', className: 'userDatatable-content' },
                { name: 'itemDisplay', title: 'Item', className: 'userDatatable-content' },
                { name: 'serialNo', title: 'Serial No', className: 'userDatatable-content' },
                { name: 'supplierDisplay', title: 'Supplier', className: 'userDatatable-content' },
                { name: 'purchaseDateDisplay', title: 'Purchase Date', className: 'userDatatable-content' },
                { name: 'purchasePrice', title: 'Price', className: 'userDatatable-content' },
                { name: 'statusBadge', title: 'Status', type: 'html', className: 'userDatatable-content' },
                { name: 'action', title: 'Action', sortable: false, filterable: false, type: 'html', className: 'userDatatable-content' }
            ];

            if (!data.length) {
                $('.adv-table').closest('.asset-card__body').find('.asset-empty').remove();
                $('.adv-table').after('<div class="asset-empty"><i class="fas fa-inbox"></i>No assets found. Click "Add New Asset" to create one.</div>');
                return;
            }
            $('.adv-table').closest('.asset-card__body').find('.asset-empty').remove();

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

            $('.adv-table').off('click', '.edit-btn').on('click', '.edit-btn', function () {
                var id = $(this).data('id');
                var asset = data.find(function (d) { return d.assetKey == id; });
                if (!asset) return;
                $('#hdnAssetId').val(id);
                $('#txtAssetCode').val(asset.assetCode);
                $('#ddlItem').val(asset.itemId).trigger('change');
                $('#ddlSupplier').val(asset.supplierId || '').trigger('change');
                $('#txtSerialNo').val(asset.serialNo);
                $('#txtPurchaseDate').val(toDateInputValue(asset.purchaseDate));
                $('#txtPurchasePrice').val(asset.purchasePrice);
                $('#txtDepreciation').val(asset.depreciationPercentPerMonth);
                $('#txtWarrantyStart').val(toDateInputValue(asset.warrantyStartDate));
                $('#txtWarrantyEnd').val(toDateInputValue(asset.warrantyEndDate));
                $('#ddlStatus').val(asset.status || 'Available');
                $('#txtRemarks').val(asset.remarks);
                $('#formTitle').text('Edit Asset');
                $('#btnSaveAssetText').text('Update Asset');
                ExpandForm();
            });

            $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                var id = $(this).data('id');
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'Do you really want to delete this asset?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!'
                }).then(function (result) {
                    if (result.isConfirmed) {
                        ApiDeleteById(deleteUrl, token, id)
                            .then(function () {
                                Swal.fire({ title: 'Deleted!', text: 'Asset deleted successfully.', icon: 'success' })
                                    .then(function () { GetAssets(); });
                            });
                    }
                });
            });
        }
    </script>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
