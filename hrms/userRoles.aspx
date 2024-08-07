﻿<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="userRoles.aspx.cs" Inherits="SigmaERP.hrms.userRoles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="main-content">
        <div class="Dashbord">
            <div class="crm mb-25">
                <div class="container-fulid">
                    <div class="card card-Vertical card-default card-md mt-4 mb-4">

                        <div id="Cardbox" class="card-body pb-md-30">
                            <div class="Vertical-form">
                                <div class="row">
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label id="lblHidenRolesId" style="display:none"></label>

                                            <label for="txtRole" class="color-dark fs-14 fw-500 align-center mb-10">
                                                Role Name <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtRole" placeholder="Type Ordering">
                                            <span class="text-danger" id="errortxtRole"></span>
                                        </div>
                                    </div>

                                    <div class="col-lg-2">
                                        <div class="form-group">
                                            <label for="txtOrdaring" class="color-dark fs-14 fw-500 align-center mb-10">
                                                Ordering <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtOrdaring" placeholder="Type Ordering">
                                            <span class="text-danger" id="orderingError"></span>
                                        </div>
                                    </div>
                                      <div class="col-lg-3 " style="display:flex; justify-content:space-between">
                                           <div class="LeftSite">
                                           <input style="opacity: 0" type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="">
                                           <div class="form-group d-flex">
                                               <label for="chkIsActive" class="color-dark fs-14 fw-500 align-center">
                                                   Status <span class="text-danger"></span>
                                               </label>
                                               <div class="radio-horizontal-list d-flex">
                                                   <div class="form-check form-switch form-switch-primary form-switch-sm mx-3">
                                                       <input type="checkbox" checked class="form-check-input" id="chkIsActive">
                                                       <label class="form-check-label" for="chkIsActive"></label>
                                                   </div>
                                               </div>
                                           </div>
                                           </div>
                                           <div class="rightSite">
                                               <label style="opacity: 0;" for="formGroupExampleInput"
                                                   class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Name <span
                                                       class="text-danger"></span>
                                               </label>
                                               <button type="button" id="btnSave" onclick="ValidateAndPostModule()"
                                                   class="btn btn-primary btn-default btn-squared px-30">Save</button>
                                           </div>

                                       </div>
                                    <div class="col-lg-4 " id="treeSection">
                                        <p>Select permission</p>
                                        <div class="loader-size loaderPackages " style="display:none">
                                            <div class="dm-spin-dots  dot-size dot-sizedot-sizedot-sizedot-size spin-sm">
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                            </div>
                                        </div>
                                        <div id="treeContainer"></div>
                                    </div>
                                </div>



                            </div>
                        </div>
                    </div>
                </div>

                    <div class="row">
               <div class="col-lg-12">
                  <div class="card ">
                     <div class="card-body">

                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                           <div class="table-responsive">
                              <div class="ad-table-table__header d-flex justify-content-between">
                                  <h4 style="margin-top: 13px;">Setup Packages List</h4>
                              <div id="filter-form-container">

                              </div>
                              </div>
                               <table class="table mb-0 packagesTable table-borderless adv-table" data-sorting="true" data-filtering="true" data-filter-container="#filter-form-container" data-paging="true" data-paging-size="10">
                               </table>
                           </div>
                        </div>

                     </div>
                  </div>
               </div>
            </div>
              
            </div>
        </div>


    </main>

    <script>
        //var rootUrl = 'http://localhost:5081';

        var rootUrl = 'https://localhost:7220';
        var getStpPkgFeaturesWithParentUrl = rootUrl + '/api/UserPackagesSetup/SetupedPackagesWithParent';
        var postRolesUrl = rootUrl + '/api/UserRoles/create';
         var getRolesUrl = rootUrl + '/api/UserRoles/userRoles';
         var getRolesByIdUrl = rootUrl + '/api/UserRoles/userRoles';
         var updateRolesUrl = rootUrl + '/api/UserRoles/update';
         var DeleteRoleUrl = rootUrl + '/api/UserRoles/delete';
         var getStpPkgFeaturesUrl = rootUrl + '/api/UserPackagesSetup/SetupPackage';
        var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        $(document).ready(function () {
           
            //GetModule();
            GetStpPkgFeatures();
            GetRoles();
        });



         function ValidateAndPostModule() {
            var isValid = true;
            if ($('#txtRole').val().trim() === "") {
                $('#errortxtRole').html("Packages Name is required.");
                $("#txtRole").focus();
                isValid = false;
            } else {
                $('#errortxtRole').html("");
            }
            if ($('#txtOrdaring').val().trim() === "" || isNaN($('#orderingError').val())) {
                $('#orderingError').html("Ordering is required and must be a number.");
                $("#txtOrdaring").focus();
                isValid = false;
            } else {
                $('#orderingError').html("");
            }
            if (isValid) {
                var addnewElement = $("#btnSave");
                if (addnewElement.html() === "Save") {
                    PostStpPkgFeatures();
                    //ClearTextBox();
                }
                else {
                    //updatePackages();
                    updateRoles();
                    //ClearTextBox();
                }
            }
        }


         function PostStpPkgFeatures() {
            var roleName = $('#txtRole').val();
            var ordering = parseInt($('#txtOrdaring').val());
            var isActive = $('#chkIsActive').is(':checked');
            var treeInstance = $('#treeContainer').jstree(true);

            var jsonString = JSON.stringify(selectedPermissionIDs);
            console.log(jsonString);

            var postData = {
                UserRole: roleName,
                Permissions: jsonString,
                Ordering: ordering,
                IsActive: isActive
 
            };

            ApiCallPost(postRolesUrl, token, postData)
                .then(function (response) {
                    console.log('Data saved successfully:', response);
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'Data saved successfully!'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            //GetModule();
                            GetRoles();
                            //GetPackages();
                        }
                    });
                })
                .catch(function (error) {
                    console.error('Error saving data:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to save data. Please try again.'
                    });
                });
        }

         function updateRoles() {
                var roleId = $('#lblHidenRolesId').val();
                var txtRole = $('#txtRole').val();
                var ordering = parseInt($('#txtOrdaring').val());
                var isActive = $('#chkIsActive').is(':checked');
                var treeInstance = $('#treeContainer').jstree(true);

                var jsonString = JSON.stringify(selectedPermissionIDsUpdate);
                console.log(jsonString);

                var updateData = {
                    UserRole: txtRole,
                    Permissions: jsonString,
                    Ordering: ordering,
                    IsActive: isActive
                };

            ApiCallUpdate(updateRolesUrl, token, updateData, roleId)
                .then(function (response) {
                    console.log('Data updated successfully:', response);
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'Data updated successfully!'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            GetRoles();
                            //GetPackages();
                        }
                    });
                })
                .catch(function (error) {
                    console.error('Error updating data:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to update data. Please try again.'
                    });
                });
        }
        function Delete(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "Do you really want to delete this Packages?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    ApiDeleteById(DeleteRoleUrl, token, id)
                        .then(function (response) {
                            Swal.fire({
                                title: 'Success!',
                                text: 'Packages deleted successfully.',
                                icon: 'success',
                                confirmButtonText: 'OK'
                            }).then(() => {
                                GetRoles();
                            });
                        })
                        .catch(function (error) {
                            Swal.fire({
                                title: 'Error!',
                                text: 'An error occurred while deleting the module.',
                                icon: 'error',
                                confirmButtonText: 'OK'
                            });
                        });
                }
            });
        }



        function GetRoles() {
            ApiCall(getRolesUrl, token)
                .then(function (response) {
                    if (response.statusCode === 200) {
                        var responseData = response.data;
                        console.log(responseData);
                        $('.footable-loader').show();
                        bindTableData(responseData);
                    } else {
                        console.error('Error occurred while fetching data:', response.message);
                    }
                })
                .catch(function (error) {
                    $('.loaderCosting').hide();
                    console.error('Error occurred while fetching data:', error);
                });
        }


        function bindTableData(data) {
            if ($('.adv-table').data('footable')) {
                $('.adv-table').data('footable').destroy();
            }
            $('.adv-table').html('');
            $('#filter-form-container').empty();

            data.forEach(row => {
                row.userRoleName = `
        <div class="permission-name-container">
            ${row.userRoleName}
            <div class="actions-container">
                <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                    <li><a href="javascript:void(0)" class="view-btn view" data-id="${row.userRoleId}"><i class="uil uil-eye"></i></a></li>
                    <li><a href="javascript:void(0)" data-id="${row.userRoleId}" class="edit-btn edit"><i class="uil uil-edit"></i></a></li>
                    <li><a href="javascript:void(0)" data-id="${row.userRoleId}" class="delete-btn remove"><i class="uil uil-trash-alt"></i></a></li>
                </ul>
            </div>
        </div>
        `;

                row.isActive = `
        <div class="form-check form-switch form-switch-primary form-switch-sm">
            <input type="checkbox" class="form-check-input" id="switch-${row.userRoleId}" ${row.isActive ? 'checked' : ''}>
            <label class="form-check-label" for="switch-${row.userRoleId}"></label>
        </div>
        `;

                row.permissions = `
        <div class="features-icon-container">
            <a href="javascript:void(0)" class="feature-btn" data-id="${row.userRoleId}"><i class="uil uil-star"></i></a>
        </div>
        `;
            });

            const columns = [
                { "name": "userRoleId", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
                { "name": "userRoleName", "title": "Role Name", "className": "userDatatable-content" },
                { "name": "permissions", "title": "Permissions", "className": "userDatatable-content" },
                { "name": "isActive", "title": "Is Active", "sortable": false, "filterable": false, "className": "userDatatable-content" },
                { "name": "ordering", "title": "Ordering", "type": "number", "className": "userDatatable-content" },
            ];

            try {
                $('.adv-table').footable({
                    "columns": columns,
                    "rows": data,
                    "filtering": {
                        "enabled": true,
                        "placeholder": "Search...",
                        "dropdownTitle": "Search in:",
                        "position": "left",
                        "containers": "#filter-form-container",
                        "space": true
                    }
                }).on('postinit.ft.table', function (e) {
                    $('.footable-loader').hide();
                });
            } catch (error) {
                console.error("Error initializing Footable:", error);
            }

            // Clear and re-attach event listeners
            $('.adv-table').off('click', '.edit-btn').on('click', '.edit-btn', function () {
                const userRoleId = $(this).data('id');
                FetchDataForEdit(userRoleId);
                console.log('Edit button clicked for ID:', userRoleId);
            });

            $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                const id = $(this).data('id');
                Delete(id);
                console.log('Delete button clicked for ID:', id);
            });

            $('.adv-table').off('click', '.view-btn').on('click', '.view-btn', function () {
                const id = $(this).data('id');
                // Handle the view action
                console.log('View button clicked for ID:', id);
            });

            $('.adv-table').off('click', '.feature-btn').on('click', '.feature-btn', function () {
                const id = $(this).data('id');
                console.log('Feature button clicked for ID:', id);
                //FetchDataForEdit(id);
            });
        }


      





    </script>

    <script src="assets/theme_assets/js/TreeViewHepler.js"></script>
   <script src="assets/theme_assets/js/apiHelper.js"></script>

</asp:Content>
