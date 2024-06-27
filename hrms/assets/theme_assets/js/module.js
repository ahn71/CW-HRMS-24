var rootUrl = 'http://localhost:5081';
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
    if ($('#txtIconClass').val().trim() === "") {
        $('#iconClassError').html("Icon Class is required.");
        $("#txtIconClass").focus();
        isValid = false;
    } else {
        $('#iconClassError').html("");
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

    data.forEach(row => {
        row.actions = `
            <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                <li><a href="javascript:void(0)" class="view-btn view"><i class="uil uil-eye"></i></a></li>
                <li><a href="javascript:void(0)" data-id="${row.moduleID}" class="edit-btn edit"><i class="uil uil-edit"></i></a></li>  
                <li><a href="javascript:void(0)" data-id="${row.moduleID}" class="delete-btn remove"><i class="uil uil-trash-alt"></i></a></li>
            </ul>
        `;

        row.isActive = `
            <div class="form-check form-switch form-switch-primary form-switch-sm">
                <input type="checkbox" class="form-check-input" id="switch-${row.moduleID}" ${row.isActive ? 'checked' : ''}>
                <label class="form-check-label" for="switch-${row.moduleID}"></label>
            </div>
        `;
    });

    const columns = [
        { "name": "moduleID", "title": "ID", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
        { "name": "moduleName", "title": "Module Name", "className": "userDatatable-content" },
        { "name": "parentID", "title": "Parent ID", "type": "number", "className": "userDatatable-content" },
        { "name": "url", "title": "URL", "className": "userDatatable-content" },
        { "name": "physicalLocation", "title": "Physical Location", "className": "userDatatable-content" },
        { "name": "isActive", "title": "Is Active", "sortable": false, "filterable": false, "className": "userDatatable-content" },
        { "name": "ordering", "title": "Ordering", "type": "number", "className": "userDatatable-content" },
        { "name": "iconClass", "title": "Icon Class", "className": "userDatatable-content" },
        { "name": "actions", "title": "Actions", "sortable": false, "filterable": false, "className": "userDatatable-content" }
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
//    <input type="checkbox" class="form-check-input" id="switch-${item.moduleID}" ${item.isActive ? 'checked' : ''}>
//        <label class="form-check-label" for="switch-${item.moduleID}"></label>
//        </div>`;

//var row = `<tr>
//    <td><div class="userDatatable-content">${item.moduleID}</div></td>
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
//            <li><a href="#" onclick="FetchDataForEdit('${item.moduleID}');" class="edit"><i class="uil uil-edit"></i></a></li>
//            <li><a href="javascript:void(0)" onclick="DeleteModule('${item.moduleID}');" class="remove"><i class="uil uil-trash-alt"></i></a></li>
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


function BoxExpland() {
    var scrollTop = $(window).scrollTop();

    $("#Cardbox").show();
    $("#addnew").text("Close");
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
            $('#btnSave').html('Update');

            BoxExpland()
        })
        .catch(function (error) {
            console.error('Error:', error);
        });

}

$(document).ready(function () {

    GetModule();
});