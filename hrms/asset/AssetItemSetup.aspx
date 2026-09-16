<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="AssetItemSetup.aspx.cs" Inherits="SigmaERP.hrms.asset.AssetItemSetup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #assetItemForm { display: none; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="asset-page mt-1">
        <div class="container-fluid">

            <div class="asset-hero">
                <div class="asset-hero__row">
                    <div class="asset-hero__left">
                        <div class="asset-hero__icon"><i class="fas fa-boxes"></i></div>
                        <div>
                            <h4 class="asset-hero__title">Asset Item Setup</h4>
                            <p class="asset-hero__subtitle">Manage the catalog of asset items &mdash; category, brand, model &amp; unit</p>
                        </div>
                    </div>
                    <button type="button" id="btnToggleForm" class="btn-asset-toggle" onclick="ToggleForm();">
                        <i class="fas fa-plus"></i> <span id="btnToggleFormText">Add New Item</span>
                    </button>
                </div>
            </div>

            <div class="asset-card" id="assetItemForm">
                <div class="asset-card__header">
                    <h6><i class="fas fa-box-open"></i> <span id="formTitle">Add Asset Item</span></h6>
                </div>
                <div class="asset-card__body">
                    <input type="hidden" id="hdnItemId" value="" />
                    <div class="row g-3">
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Item Name <span class="required-star">*</span></label>
                            <input type="text" id="txtItemName" class="form-control" placeholder="e.g. Dell Latitude Laptop" />
                            <span class="text-danger" id="txtItemNameError"></span>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Category</label>
                            <input type="text" id="txtCategory" class="form-control" placeholder="e.g. Electronics" list="dlCategory" />
                            <datalist id="dlCategory">
                                <option value="Electronics"></option>
                                <option value="Furniture"></option>
                                <option value="Vehicle"></option>
                                <option value="Tools"></option>
                                <option value="Office Equipment"></option>
                            </datalist>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Brand</label>
                            <input type="text" id="txtBrand" class="form-control" placeholder="e.g. Dell" />
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Model</label>
                            <input type="text" id="txtModel" class="form-control" placeholder="e.g. Latitude 5420" />
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Unit</label>
                            <input type="text" id="txtUnit" class="form-control" placeholder="e.g. Pcs" />
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <label class="form-label">Status</label>
                            <div class="pt-2">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" role="switch" id="chkIsActive" checked>
                                    <label class="form-check-label" for="chkIsActive">Active</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Description</label>
                            <textarea id="txtDescription" class="form-control" rows="3" placeholder="Optional notes about this item..."></textarea>
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-25">
                        <button type="button" id="btnSaveItem" class="btn-asset-primary" onclick="ValidateAndSaveItem();">
                            <i class="fas fa-save"></i> <span id="btnSaveItemText">Save Item</span>
                        </button>
                        <button type="button" class="btn-asset-outline" onclick="ClearItemForm();">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                    </div>
                </div>
            </div>

            <div class="asset-card">
                <div class="asset-card__header">
                    <h6><i class="fas fa-list-ul"></i> Asset Item List</h6>
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

        var createUrl = `${rootUrl}/api/AssetItem/create`;
        var updateUrl = `${rootUrl}/api/AssetItem/update`;
        var deleteUrl = `${rootUrl}/api/AssetItem/delete`;
        var listUrl = `${rootUrl}/api/AssetItem/list?companyId=${CompanyID}`;

        $(document).ready(function () {
            GetAssetItems();
        });

        function ToggleForm() {
            const $form = $('#assetItemForm');
            if ($form.is(':visible')) {
                $form.slideUp(150);
                $('#btnToggleFormText').text('Add New Item');
                $('#btnToggleForm i').removeClass('fa-times').addClass('fa-plus');
                ClearItemForm();
            } else {
                $form.slideDown(150);
                $('#btnToggleFormText').text('Close');
                $('#btnToggleForm i').removeClass('fa-plus').addClass('fa-times');
            }
        }

        function ExpandForm() {
            $('#assetItemForm').slideDown(150);
            $('#btnToggleFormText').text('Close');
            $('#btnToggleForm i').removeClass('fa-plus').addClass('fa-times');
            $('html, body').animate({ scrollTop: $('#assetItemForm').offset().top - 100 }, 300);
        }

        function ValidateAndSaveItem() {
            var itemName = $('#txtItemName').val().trim();
            if (itemName === '') {
                $('#txtItemNameError').html('Item Name is required.');
                $('#txtItemName').focus();
                return;
            }
            $('#txtItemNameError').html('');

            var payload = {
                companyId: CompanyID,
                itemName: itemName,
                category: $('#txtCategory').val().trim(),
                brand: $('#txtBrand').val().trim(),
                model: $('#txtModel').val().trim(),
                unit: $('#txtUnit').val().trim(),
                description: $('#txtDescription').val().trim(),
                isActive: $('#chkIsActive').is(':checked')
            };

            var id = $('#hdnItemId').val();

            if (id) {
                ApiCallUpdate(updateUrl, token, payload, id)
                    .then(function () {
                        Swal.fire({ icon: 'success', title: 'Updated', text: 'Asset item updated successfully.' })
                            .then(function () { GetAssetItems(); ToggleForm(); });
                    })
                    .catch(function () {
                        Swal.fire({ icon: 'error', title: 'Error', text: 'Failed to update asset item.' });
                    });
            } else {
                ApiCallPost(createUrl, token, payload)
                    .then(function (response) {
                        if (response && response.statusCode && response.statusCode !== 200) { return; }
                        Swal.fire({ icon: 'success', title: 'Saved', text: 'Asset item created successfully.' })
                            .then(function () { GetAssetItems(); ToggleForm(); });
                    });
            }
        }

        function ClearItemForm() {
            $('#hdnItemId').val('');
            $('#txtItemName').val('');
            $('#txtCategory').val('');
            $('#txtBrand').val('');
            $('#txtModel').val('');
            $('#txtUnit').val('');
            $('#txtDescription').val('');
            $('#chkIsActive').prop('checked', true);
            $('#formTitle').text('Add Asset Item');
            $('#btnSaveItemText').text('Save Item');
        }

        function GetAssetItems() {
            ApiCall(listUrl, token)
                .then(function (response) {
                    var data = (response && response.data) ? response.data : [];
                    bindItemTable(data);
                })
                .catch(function (error) {
                    console.error('Error loading asset items:', error);
                    bindItemTable([]);
                });
        }

        function bindItemTable(data) {
            if ($('.adv-table').data('footable')) {
                $('.adv-table').data('footable').destroy();
            }
            $('.adv-table').html('');
            $('#filter-form-container').empty();

            data.forEach(function (row, index) {
                row.serialNo = index + 1;
                row.itemKey = row.itemId != null ? row.itemId : row.id;
                row.statusBadge = row.isActive
                    ? '<span class="asset-badge asset-badge-active">Active</span>'
                    : '<span class="asset-badge asset-badge-inactive">Inactive</span>';
                row.action = `
                    <div class="actions">
                        <a href="javascript:void(0)" data-id="${row.itemKey}" class="edit-btn" title="Edit"><i class="uil uil-edit"></i></a>
                        <a href="javascript:void(0)" data-id="${row.itemKey}" class="delete-btn" title="Delete"><i class="uil uil-trash-alt"></i></a>
                    </div>`;
            });

            var columns = [
                { name: 'serialNo', title: 'SL', breakpoints: 'xs sm', type: 'number', className: 'userDatatable-content' },
                { name: 'itemName', title: 'Item Name', className: 'userDatatable-content' },
                { name: 'category', title: 'Category', className: 'userDatatable-content' },
                { name: 'brand', title: 'Brand', className: 'userDatatable-content' },
                { name: 'model', title: 'Model', className: 'userDatatable-content' },
                { name: 'unit', title: 'Unit', className: 'userDatatable-content' },
                { name: 'statusBadge', title: 'Status', type: 'html', className: 'userDatatable-content' },
                { name: 'action', title: 'Action', sortable: false, filterable: false, type: 'html', className: 'userDatatable-content' }
            ];

            if (!data.length) {
                $('.adv-table').closest('.asset-card__body').find('.asset-empty').remove();
                $('.adv-table').after('<div class="asset-empty"><i class="fas fa-inbox"></i>No asset items found. Click "Add New Item" to create one.</div>');
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
                var item = data.find(function (d) { return d.itemKey == id; });
                if (!item) return;
                $('#hdnItemId').val(id);
                $('#txtItemName').val(item.itemName);
                $('#txtCategory').val(item.category);
                $('#txtBrand').val(item.brand);
                $('#txtModel').val(item.model);
                $('#txtUnit').val(item.unit);
                $('#txtDescription').val(item.description);
                $('#chkIsActive').prop('checked', !!item.isActive);
                $('#formTitle').text('Edit Asset Item');
                $('#btnSaveItemText').text('Update Item');
                ExpandForm();
            });

            $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                var id = $(this).data('id');
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'Do you really want to delete this asset item?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!'
                }).then(function (result) {
                    if (result.isConfirmed) {
                        ApiDeleteById(deleteUrl, token, id)
                            .then(function () {
                                Swal.fire({ title: 'Deleted!', text: 'Asset item deleted successfully.', icon: 'success' })
                                    .then(function () { GetAssetItems(); });
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
