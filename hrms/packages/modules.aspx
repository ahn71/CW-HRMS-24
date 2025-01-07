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
                           <h4>Add Module</h4>
                        </div>
                     </div>

                     <div class="btn-wrapper">
                        <div class="dm-button-list d-flex flex-wrap align-items-end">
                        <button type="button" id="addnew" onclick="Cardbox();" class="btn btn-secondary btn-default btn-squared">Add New</button>                          
                        </div>
                     </div>
                  </div>

                  <div style="display: none;" id="Cardbox" class="card-body pb-md-30">
                     <div class="Vertical-form">
                           <div class="row">
                              <div class="col-lg-3">
                                 <div class="form-group">
                                     <label id="lblHidenModuleId" style="display:none"></label>
                                     <label for="formGroupExampleInput" class="color-dark fs-14 fw-500 align-center mb-10">Parent</label>
                                     <div class="support-form__input-id">
                                         <div class="dm-select ">
                                             <select name="ddlParent" id="ddlParent" class="select-search form-control">
                                                 <option value="0">---Select---</option>
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
                                 <button type="button" id="btnSave" onclick="validateAndPostModule()"
                                    class="btn btn-primary btn-default btn-squared px-30">Save</button>
                              </div>
                           </div>
             
                     </div>
                  </div>
               </div>
            </div>
               <!-- Department List  -->
                        <div class="row">
               <div class="col-lg-12">
                  <div class="card ">
                     <div class="card-body">

                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                           <div class="table-responsive">
                              <div class="ad-table-table__header d-flex justify-content-between">
                                  <h4 style="margin-top: 13px;">Modules</h4>
                              <div id="filter-form-container">
                              </div>
                              </div>

                               <div class="loader-size loaderModulesList " style="display: none">
                                   <div class="dm-spin-dots  dot-size dot-sizedot-sizedot-sizedot-size spin-sm">
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                   </div>
                               </div>

                               <table class="table mb-0 table-borderless adv-table" data-sorting="true" data-filtering="true" data-filter-container="#filter-form-container" data-paging="true" data-paging-size="10">
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

        var token = '<%= Session["__UserToken__"] %>';
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        function BoxExpland() {
            var scrollTop = $(window).scrollTop();

            $("#Cardbox").show();
            $("#addnew").text("Close");
            $(window).scrollTop(scrollTop);
        }

            function Cardbox() {
    var CardboxElement = $("#Cardbox");
    var addnewElement = $("#addnew");

    if (addnewElement.html() === "Add New") {
        CardboxElement.show();
        addnewElement.text("Close");
    } else {
        ClearTextBox(); 
        CardboxElement.hide();
        addnewElement.html("Add New");

    }
        }



        
//var rootUrl = 'http://localhost:5081';
//var rootUrl = 'https://localhost:7220';



var GetByIdModuleUrl = rootUrl + '/api/UserModules/modules';
var GetModuleUrl = rootUrl + '/api/UserModules/modules';
var PostModuleUrl = rootUrl + '/api/UserModules/modules/create';
var updateModuleUrl = rootUrl + '/api/UserModules/modules/update';
var DeleteModuleUrl = rootUrl + '/api/UserModules/modules/delete';

//var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';
function GetModule() {
    ApiCall(GetModuleUrl, token )
        .then(function (response) {
            if (response.statusCode === 200) {
                var responseData = response.data;
                $('.footable-loader').show();
                populateDropdown(responseData)
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
    var isValid = true;
    if ($('#txtModuleName').val().trim() === "") {
        $('#moduleNameError').html("Module Name is required.");
        $("#txtModuleName").focus();
        isValid = false;
    } else {
        $('#moduleNameError').html("");
    }
    if ($('#txtModuleUrl').val().trim() === "") {
        $('#moduleUrlError').html("Module Url is required.");
        $("#txtModuleUrl").focus();
        isValid = false;
    } else {
        $('#moduleUrlError').html("");
    }
    if ($('#txtPhysicalLocation').val().trim() === "") {
        $('#physicalLocationError').html("Physical Location is required.");
        $("#txtPhysicalLocation").focus();
        isValid = false;
    } else {
        $('#physicalLocationError').html("");
    }

    if ($('#txtOrdaring').val().trim() === "" || isNaN($('#txtOrdaring').val())) {
        $('#orderingError').html("Ordering is required and must be a number.");
        $("#txtOrdaring").focus();
        isValid = false;
    } else {
        $('#orderingError').html("");
    }
    if (isValid) {
        var addnewElement = $("#btnSave");
        if (addnewElement.html() === "Save") {
            PostModule();
            ClearTextBox();
        }
        else {
            updateModule();
            ClearTextBox();
        }
    }
}

function populateDropdown(data) {
    const dropdown = document.getElementById('ddlParent');
    dropdown.innerHTML = '<option value="0">---Select---</option>'; // Clear existing options

    data.forEach(item => {
        const option = document.createElement('option');
        option.value = item.moduleId;
        option.textContent = item.moduleName;
        dropdown.appendChild(option);
    });
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
        .then(function (response) {
            console.log('Data saved successfully:', response);
            // Handle success response with SweetAlert2
            Swal.fire({
                icon: 'success',
                title: 'Success',
                text: 'Data saved successfully!'
            }).then((result) => {
                // Reload the page if the user clicks "OK"
                if (result.isConfirmed) {
                    GetModule();
                }
            });
        })
        .catch(function (error) {
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
    var moduleID = $('#lblHidenModuleId').val();
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
    ApiCallUpdate(updateModuleUrl, token, updateData, moduleID)
        .then(function (response) {
            console.log('Data updated successfully:', response);
            Swal.fire({
                icon: 'success',
                title: 'Success',
                text: 'Data updated successfully!'
            }).then(() => {
                GetModule();
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
    if ($('.adv-table').data('footable')) {
        $('.adv-table').data('footable').destroy();
    }
    $('.adv-table').html('');
    $('#filter-form-container').empty();

    data.forEach((row, index) => {
        // Adding the serial number by using the index (starting from 1)
        row.serialNo = index + 1;

        row.moduleName = `
            <div class="permission-name-container">
                ${row.moduleName}
                <div class="actions-container">
                    <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                        <li><a href="javascript:void(0)" class="view-btn view" data-id="${row.moduleId}"><i class="uil uil-eye"></i></a></li>
                        <li><a href="javascript:void(0)" data-id="${row.moduleId}" class="edit-btn edit"><i class="uil uil-edit"></i></a></li>
                        <li><a href="javascript:void(0)" data-id="${row.moduleId}" class="delete-btn remove"><i class="uil uil-trash-alt"></i></a></li>
                    </ul>
                </div>
            </div>
        `;

        row.isActive = `
            <div class="form-check form-switch form-switch-primary form-switch-sm">
                <input type="checkbox" class="form-check-input" id="switch-${row.moduleId}" ${row.isActive ? 'checked' : ''}>
                <label class="form-check-label" for="switch-${row.moduleId}"></label>
            </div>
        `;
    });

    const columns = [
        { "name": "serialNo", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" }, // New serial number column
        { "name": "moduleId", "title": "ID", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
        { "name": "moduleName", "title": "Module Name", "className": "userDatatable-content" },
        { "name": "parentName", "title": "Parent Name", "className": "userDatatable-content" },
        { "name": "url", "title": "URL", "className": "userDatatable-content" },
        { "name": "physicalLocation", "title": "Physical Location", "className": "userDatatable-content" },
        { "name": "isActive", "title": "Is Active", "sortable": false, "filterable": false, "className": "userDatatable-content" },
        { "name": "ordering", "title": "Ordering", "type": "number", "className": "userDatatable-content" },
        { "name": "iconClass", "title": "Icon Class", "className": "userDatatable-content" }
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
        const id = $(this).data('id');
        FetchDataForEdit(id);
        console.log('Edit button clicked for ID:', id);
    });

    $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
        const id = $(this).data('id');
        DeleteModule(id);
        console.log('Delete button clicked for ID:', id);
    });

    $('.adv-table').off('click', '.view-btn').on('click', '.view-btn', function () {
        const id = $(this).data('id');
        // Handle the view action
        console.log('View button clicked for ID:', id);
    });
}










//    function bindTableData(data) {
//        console.log("this data from bind Table test");
//        var tableBody = $('.adv-table tbody');
//        tableBody.empty(); // Clear any existing rows

//     //$('.table').footable({
//     // //"columns": $.get('columns.json'),
//     // "rows": data
//     //});

//    data.forEach(function (item) {
//     var switchButton = `
//        <div class="form-check form-switch form-switch-primary form-switch-sm">
//    <input type="checkbox" class="form-check-input" id="switch-${item.moduleId}" ${item.isActive ? 'checked' : ''}>
//        <label class="form-check-label" for="switch-${item.moduleId}"></label>
//        </div>`;

//var row = `<tr>
//    <td><div class="userDatatable-content">${item.moduleId}</div></td>
//    <td><div class="userDatatable-content">${item.parentID}</div></td>
//    <td><div class="userDatatable-content">${item.moduleName}</div></td>
//    <td><div class="userDatatable-content">${item.url}</div></td>
//    <td><div class="userDatatable-content">${item.physicalLocation}</div></td>
//    <td><div class="userDatatable-content">${item.iconClass}</div></td>
//    <td><div class="userDatatable-content">${item.ordering}</div></td>
//    <td><div class="userDatatable-content">${switchButton}</div></td>

//    <td>
//        <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
//            <li><a href="javascript:void(0)" class="view"><i class="uil uil-eye"></i></a></li>
//            <li><a href="#" onclick="FetchDataForEdit('${item.moduleId}');" class="edit"><i class="uil uil-edit"></i></a></li>
//            <li><a href="javascript:void(0)" onclick="DeleteModule('${item.moduleId}');" class="remove"><i class="uil uil-trash-alt"></i></a></li>
//        </ul>
//    </td>
//</tr>`;

//        tableBody.append(row);
//        tableBody.trigger('footable_initialize');
//});
//    };

function ClearTextBox() {
    $('#txtModuleName').val("");
    $('#ddlParent').val("");
    $('#txtModuleUrl').val("");
    $('#txtPhysicalLocation').val("");
    $('#txtIconClass').val("");
    $('#txtOrdaring').val("");
    $('#chkIsActive').prop('checked', false);
    $('#btnSave').text("Save");
}




//function BoxExpland() {
//    var scrollTop = $(window).scrollTop();

//    $("#Cardbox").show();
//    $("#addnew").text("Close");
//    $(window).scrollTop(scrollTop);
//}

function DeleteModule(moduleId) {
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
            ApiDeleteById(DeleteModuleUrl, token, moduleId)
                .then(function (response) {
                    Swal.fire({
                        title: 'Success!',
                        text: 'Module deleted successfully.',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then(() => {
                        GetModule();
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

function FetchDataForEdit(moduleId) {
    ApiCallById(GetByIdModuleUrl, token, moduleId)
        .then(function (responseData) {
            var data = responseData.data;
            console.log(data.moduleId);
            $('#lblHidenModuleId').val(data.moduleID);
            $('select[name="ddlParent"]').val(data.parentID).change();   
            $('#txtModuleName').val(data.moduleName);
            $('#txtModuleUrl').val(data.url);
            $('#txtPhysicalLocation').val(data.physicalLocation);
            $('#txtIconClass').val(data.iconClass);
            $('#txtOrdaring').val(data.ordering);
            $('#chkIsActive').prop('checked', data.isActive);
            $('#btnSave').html('Update');

            BoxExpland()
            //Cardbox()
        })
        .catch(function (error) {
            console.error('Error:', error);
        });

}

$(document).ready(function () {
    $(".loaderModulesList").show();

    GetModule();
    $(".loaderModulesList").hide();
});

    </script>


   <%-- <script src="assets/theme_assets/js/module.js"></script>--%>
    <script src="../assets/theme_assets/js/apiHelper.js"></script>
</asp:Content>
