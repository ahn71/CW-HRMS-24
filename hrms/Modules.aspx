<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="modules.aspx.cs" Inherits="SigmaERP.hrms.Modules" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">   


  <main class="main-content">
      <div class="Dashbord">
         <div class="crm mb-25">
            <div class="container-fulid">
               <div class="card card-Vertical card-default card-md mt-4 mb-4">

                  <div class="card-header d-flex align-items-center">
                     <div class="card-title d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center gap-3">
                           <h4>Add Modules</h4>
                        </div>
                     </div>

                     <div class="btn-wrapper">
                        <div class="dm-button-list d-flex flex-wrap align-items-end">

                           <button type="button" id="addnew" onclick="cardbox();" class="btn btn-secondary btn-default btn-squared">Add New
                           </button>
                        </div>
                     </div>
                  </div>

                  <div style="display: none;" id="cardbox" class="card-body pb-md-30">
                     <div class="Vertical-form">
  
                           <div class="row">
                              <div class="col-lg-3">
                                 <div class="form-group">
                                     <label id="lblHidenModuleId" style="display:none"></label>
                                     <label for="formGroupExampleInput" class="color-dark fs-14 fw-500 align-center mb-10">Parent</label>
                                     <div class="support-form__input-id">
                                         <div class="dm-select ">
                                             <select id="ddlParent" class="select-search form-control ">
                                                 <option value="1">All</option>
                                                 <option value="2">Option 2</option>
                                                 <option value="3">Option 3</option>
                                                 <option value="04">Option 4</option>
                                                 <option value="05">Option 5</option>
                                             </select>
                                         </div>
                                     </div>
                                 </div>
                              </div>
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="txtModuleName" class="color-dark fs-14 fw-500 align-center mb-10">
                                           Module Name <span class="text-danger">*</span>
                                       </label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtModuleName" placeholder="Type Module Name">
                                       <span class="text-danger" id="moduleNameError"></span>
                                   </div>
                               </div>
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="txtModuleUrl" class="color-dark fs-14 fw-500 align-center mb-10">
                                           Module Url <span class="text-danger">*</span>
                                       </label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtModuleUrl" placeholder="Type Module Url">
                                       <span class="text-danger" id="moduleUrlError"></span>
                                   </div>
                               </div>
                              <div class="col-lg-3">
                                  <div class="form-group">
                                      <label for="txtPhysicalLocation" class="color-dark fs-14 fw-500 align-center mb-10">
                                          Physical Location <span class="text-danger">*</span>
                                      </label>
                                      <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtPhysicalLocation" placeholder="Type Physical Location">
                                      <span class="text-danger" id="physicalLocationError"></span>
                                  </div>
                              </div>
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="txtIconClass" class="color-dark fs-14 fw-500 align-center mb-10">
                                           Icon Class <span class="text-danger">*</span>
                                       </label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtIconClass" placeholder="Type Icon Class">
                                       <span class="text-danger" id="iconClassError"></span>
                                   </div>
                               </div>
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="txtOrdaring" class="color-dark fs-14 fw-500 align-center mb-10">
                                           Ordering <span class="text-danger">*</span>
                                       </label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtOrdaring" placeholder="Type Ordering">
                                       <span class="text-danger" id="orderingError"></span>
                                   </div>
                               </div>
                               <div class="col-lg-3">
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
                               <div class="col-lg-3">
                                 <label style="opacity: 0;" for="formGroupExampleInput"
                                    class="color-dark fs-14 fw-500 align-center mb-10">Name <span
                                       class="text-danger"></span></label>
                                 <button type="button" id="saveButton" onclick="validateAndPostModule()"
                                    class="btn btn-primary btn-default btn-squared px-30">Save</button>
                              </div>
                           </div>
             
                     </div>
                  </div>
               </div>
            </div>
               <!-- Department List  -->
                        <div class="row">
               <div class="col-lg-12 mb-30">
                  <div class="card mt-30">
                     <div class="card-body">

                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                           <div class="table-responsive">
                              <div class="adv-table-table__header">
                                 <h4>Module List</h4>

                              </div>
                              <div id="filter-form-container"></div>
                              <table class="table mb-0 table-borderless adv-table" data-sorting="true" data-filter-container="#filter-form-container" data-paging-current="1" data-paging-position="right" data-paging-size="10">
                                 <thead>
                                    <tr class="userDatatable-header">
                                       <th>
                                          <span class="userDatatable-title">ID</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">Parent</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">Module Name</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">Module Url</span>
                                       </th>
                                       <th data-type="html" data-name='position'>
                                          <span class="userDatatable-title">Physical Location</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">Icon Class</span>
                                       </th>
                                        <th>
                                            <span class="userDatatable-title">Ordaring
                                            </span>
                                        </th>
                                       <th data-type="html" data-name='status'>
                                          <span class="userDatatable-title">status</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title float-end">action</span>
                                       </th>
                                    </tr>
                                 </thead>
                                 <tbody>

                                     <!---Data Bind From Api---->

                                 </tbody>
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

      var rootUrl = 'https://localhost:7220';
      var GetByIdModuleUrl = rootUrl + '/api/UserModules/modules';
      var GetModuleUrl = rootUrl + '/api/UserModules/modules';
      var PostModuleUrl = rootUrl + '/api/UserModules/modules/create';
      var updateModuleUrl = rootUrl + '/api/UserModules/modules/update';
      var DeleteModuleUrl = rootUrl + '/api/UserModules/modules/delete';

    var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';



    function GetModule() {
        ApiCall(GetModuleUrl, token)
            .then(function (response) {
                if (response.statusCode === 200) {
                    var responseData = response.data;
                    console.log(responseData);
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


    function validateAndPostModule() {
        // Clear previous error messages

        // Validate form data
        var isValid = true;
          if ($('#txtModuleName').val().trim() === "") {
        $('#moduleNameError').html("Module Name is required.");
    $("#txtModuleName").focus();
        isValid = false;
    } else {
        $('#moduleNameError').html("");
    }

    // Validate Module Url
    if ($('#txtModuleUrl').val().trim() === "") {
        $('#moduleUrlError').html("Module Url is required.");
    $("#txtModuleUrl").focus();
        isValid = false;
    } else {
        $('#moduleUrlError').html("");
    }

    // Validate Physical Location
    if ($('#txtPhysicalLocation').val().trim() === "") {
        $('#physicalLocationError').html("Physical Location is required.");
    $("#txtPhysicalLocation").focus();
        isValid = false;
    } else {
        $('#physicalLocationError').html("");
    }

    // Validate Icon Class
    if ($('#txtIconClass').val().trim() === "") {
        $('#iconClassError').html("Icon Class is required.");
    $("#txtIconClass").focus();
        isValid = false;
    } else {
        $('#iconClassError').html("");
    }

    // Validate Ordering
    if ($('#txtOrdaring').val().trim() === "" || isNaN($('#txtOrdaring').val())) {
        $('#orderingError').html("Ordering is required and must be a number.");
    $("#txtOrdaring").focus();
        isValid = false;
    } else {
        $('#orderingError').html("");
    }

        if (isValid) {

            if ($('#saveButton').html === 'Save') {
        PostModule();
    }
            else {
        updateModule();
    }


        }
    }



   function PostModule() {
    // Capture form data
    var moduleName = $('#txtModuleName').val();
    var parentID = parseInt($('#ddlParent').val());
    var url = $('#txtModuleUrl').val();
    var physicalLocation = $('#txtPhysicalLocation').val();
    var iconClass = $('#txtIconClass').val();
    var ordering = parseInt($('#txtOrdaring').val());
    var isActive = $('#chkIsActive').is(':checked'); // Changed to boolean

    // Create postData object
    var postData = {
        moduleName: moduleName,
        parentID: parentID,
        url: url,
        physicalLocation: physicalLocation,
        isActive: isActive,
        ordering: ordering,
        iconClass: iconClass
    };

    // Call the API using ApiCallPost function
    ApiCallPost(PostModuleUrl, token, postData)
        .then(function(response) {
        console.log('Data saved successfully:', response);
    // Handle success response with SweetAlert2
    Swal.fire({
        icon: 'success',
                title: 'Success',
                text: 'Data saved successfully!'
            }).then((result) => {
                // Reload the page if the user clicks "OK"
                if (result.isConfirmed) {
        location.reload();
    }
            });
        })
        .catch(function(error) {
        console.error('Error saving data:', error);
    // Handle error response with SweetAlert2
    Swal.fire({
        icon: 'error',
                title: 'Error',
                text: 'Failed to save data. Please try again.'
            });
        });
}

    function updateModule() {
        // Capture form data
        var moduleId = $('#lblHidenModuleId').val();
        var moduleName = $('#txtModuleName').val();
        var parentID = parseInt($('#ddlParent').val());
        var url = $('#txtModuleUrl').val();
        var physicalLocation = $('#txtPhysicalLocation').val();
        var iconClass = $('#txtIconClass').val();
        var ordering = parseInt($('#txtOrdaring').val());
        var isActive = $('#chkIsActive').is(':checked');

        // Create updateData object
        var updateData = {
        moduleName: moduleName,
            parentID: parentID,
            url: url,
            physicalLocation: physicalLocation,
            isActive: isActive,
            ordering: ordering,
            iconClass: iconClass
        };
         //var updateUrl = `${GetByIdModuleUrl}/${moduleId}`;
        ApiCallUpdate(updateModuleUrl, token, updateData, moduleId)
            .then(function (response) {
        console.log('Data updated successfully:', response);
    Swal.fire({
        icon: 'success',
                    title: 'Success',
                    text: 'Data updated successfully!'
                }).then(() => {
        location.reload();
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


    function bindTableData(data) {
    var tableBody = $('.adv-table tbody');
    tableBody.empty(); // Clear any existing rows

        data.forEach(function (item) {
         var switchButton = `
            <div class="form-check form-switch form-switch-primary form-switch-sm">
        <input type="checkbox" class="form-check-input" id="switch-${item.moduleID}" ${item.isActive ? 'checked' : ''}>
            <label class="form-check-label" for="switch-${item.moduleID}"></label>
            </div>`;

        var row = `<tr>
            <td><div class="userDatatable-content">${item.moduleID}</div></td>
            <td><div class="userDatatable-content">${item.parentID}</div></td>
            <td><div class="userDatatable-content">${item.moduleName}</div></td>
            <td><div class="userDatatable-content">${item.url}</div></td>
            <td><div class="userDatatable-content">${item.physicalLocation}</div></td>
            <td><div class="userDatatable-content">${item.iconClass}</div></td>
            <td><div class="userDatatable-content">${item.ordering}</div></td>
            <td><div class="userDatatable-content">${switchButton}</div></td>

            <td>
                <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                    <li><a href="javascript:void(0)" class="view"><i class="uil uil-eye"></i></a></li>
                    <li><a href="#" onclick="FetchDataForEdit('${item.moduleID}');" class="edit"><i class="uil uil-edit"></i></a></li>


                    <li><a href="javascript:void(0)" onclick="DeleteModule('${item.moduleID}');" class="remove"><i class="uil uil-trash-alt"></i></a></li>
                </ul>
            </td>
        </tr>`;

        tableBody.append(row);
    });
}




    function cardbox() {
            $("#cardbox").toggle();
        var currentText = $("#addnew").text();
        var newText = currentText === "Close" ? "Add New" : "Close";
        $("#addnew").text(newText);
    }

    function BoxExpland() {
        var scrollTop = $(window).scrollTop();
        $("#cardbox").show();
        $(window).scrollTop(scrollTop);
    }

  function DeleteModule(moduleID) {
            // Show confirmation dialog
            Swal.fire({
                title: 'Are you sure?',
                text: "Do you really want to delete this module?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Proceed with deletion
                    ApiDeleteById(DeleteModuleUrl, token, moduleID)
                        .then(function (response) {
                            Swal.fire({
                                title: 'Success!',
                                text: 'Module deleted successfully.',
                                icon: 'success',
                                confirmButtonText: 'OK'
                            }).then(() => {
                                location.reload();
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

            function FetchDataForEdit(moduleID) {
            ApiCallById(GetByIdModuleUrl, token, moduleID)
                .then(function (responseData) {
                    // Log the retrieved data
                    console.log('Data:', responseData);
                    var data = responseData.data;
                    $('#lblHidenModuleId').val(data.moduleID);
                    $('#ddlParent').val(data.parentID);
                    $('#txtModuleName').val(data.moduleName);
                    $('#txtModuleUrl').val(data.url);
                    $('#txtPhysicalLocation').val(data.physicalLocation);
                    $('#txtIconClass').val(data.iconClass);
                    $('#txtOrdaring').val(data.ordering);
                    $('#chkIsActive').prop('checked', data.isActive);
                    $('#saveButton').html('Update');

                    BoxExpland()
                })
                .catch(function (error) {
                    console.error('Error:', error);
                });

        }

        $(document).ready(function () {
            GetModule();
        });

    </script>
    <script src="assets/theme_assets/js/module.js"></script>
    <script src="assets/theme_assets/js/apiHelper.js"></script>
</asp:Content>
