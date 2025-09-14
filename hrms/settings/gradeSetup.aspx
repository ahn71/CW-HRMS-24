<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="gradeSetup.aspx.cs" Inherits="SigmaERP.hrms.settings.gradeSetup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        td{
            text-align:left;
        }
    </style>
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
                                    <h4>Add Grade</h4>
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
                                   
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                                    <div class="form-group">
                                                        <label for="ddlCompany" class="color-dark fs-14 fw-500 align-center mb-10">
                                                            Company<span
                                                                class="text-danger">*</span></label>
                                                        <div class="support-form__input-id">
                                                            <div class="dm-select ">
                                                                <asp:DropDownList runat="server" ID="ddlCompany" ClientIDMode="Static" class="select-search form-control"></asp:DropDownList>

                                                            </div>
                                                            <span class="text-danger" id="ddlCompanyError"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label id="lblHidenGradeId" style="display: none"></label>

                                                <label for="txtRole" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Grade Name <span class="text-danger">*</span>
                                                </label>
                                                <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtGradeName" placeholder="Type Grade Name">
                                                <span class="text-danger" id="txtGradeNameError"></span>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="txtGradeBangla" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    বাংলায় <span class="text-danger">*</span>
                                                </label>
                                               

                                                <asp:TextBox ID="txtGradeBangla" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-gray radius-xs b-light px-15" Font-Names="SutonnyMJ"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 col-md-6 col-sm-12 " style="display: flex; justify-content: space-between">
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
                                                    class="btn btn-primary btn-default btn-squared px-30">
                                                    Save</button>
                                            </div>

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
                                  <h4 style="margin-top: 13px;">Grades</h4>
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

        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var postUrl = rootUrl + '/api/Grade/create';
        var getGradeByIdUrl = rootUrl + '/api/Grade/grades';
        var getAllUrl = rootUrl + `/api/Grade/grades?CompanyId=${CompanyID}`;
        var updateGradeUrl = rootUrl + '/api/Grade/update';
        var DeleteUrl = rootUrl + '/api/Grade/delete';
        var GetDdlCompanyUrl = rootUrl + `/api/Company/GetDropdownCompanies?CompanyId=${CompanyID}`;

        var token = '<%= Session["__UserToken__"] %>';
        console.log('this is token you can use it :', token);
        //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        $(document).ready(function () {
           
        
            GetCompanys();
            GetAllGrades();
            
        });

        //function getCompanypackage(compayId) {
        //    var companyId = compayId;
        //     GetStpPkgFeatures(companyId);
        //}

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


        function ClearTextBox() {
            $('#txtRole').val("");
            $('#txtOrdaring').val("");
            $('#chkIsActive').prop('checked', true);
            $('#btnSave').text("Save");
        }

         function ValidateAndPostModule() {
             var isValid = true;
             if ($('#ddlCompany').val() == "0") {
                 $('#ddlCompanyError').html("Please select a company.");
                 $('#ddlCompany').focus(); // Set focus on the dropdown
                 isValid = false;
             } else {
                 $('#ddlCompanyError').html(""); // Clear the error message
             }
            if ($('#txtGradeName').val().trim() === "") {
                $('#txtGradeNameError').html("Grade Name is required.");
                $("#txtGradeName").focus();
                isValid = false;
            } else {
                $('#txtGradeNameError').html("");
            }

             if (isValid) {
                 var addnewElement = $("#btnSave").text().trim();
                 if (addnewElement === "Save") {
                     PostGrade();
                 }
                 else {
                     updateGrade(); 

                 }
             }
        }
        


         function PostGrade() {
            var CompanyId = $('#ddlCompany').val();
            var GradeName = $('#txtGradeName').val();
            var GradeNameBangla = $('#txtGradeBangla').val();
            var isActive = $('#chkIsActive').is(':checked');
             var postData = {
                companyId:CompanyId,
                grdName: GradeName,
                grdNameBangla: GradeNameBangla,
                grdStatus: isActive
 
            };

            ApiCallPost(postUrl, token, postData)
                .then(function (response) {
                    console.log('Data saved successfully:', response);
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'Data saved successfully!'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            //GetModule();
                            GetAllGrades();
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

         function updateGrade() {
                var GradeId = $('#lblHidenGradeId').val();
                var CompanyId = $('#ddlCompany').val();
                var GradeName = $('#txtGradeName').val();
                var GradeNameBangla = $('#txtGradeBangla').val();
                var isActive = $('#chkIsActive').is(':checked');
             
         

                var updateData = {
                companyId:CompanyId,
                grdName: GradeName,
                grdNameBangla: GradeNameBangla,
                grdStatus: isActive
                };

            ApiCallUpdate(updateGradeUrl, token, updateData, GradeId)
                .then(function (response) {
                    console.log('Data updated successfully:', response);
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'Data updated successfully!'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            GetAllGrades();
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
                text: "Do you really want to delete this Grade?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    ApiDeleteById(DeleteUrl, token, id)
                        .then(function (response) {
                            Swal.fire({
                                title: 'Success!',
                                text: 'Grade deleted successfully.',
                                icon: 'success',
                                confirmButtonText: 'OK'
                            }).then(() => {
                                GetAllGrades();
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





        function GetAllGrades() {
            ApiCall(getAllUrl, token)
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

            // Step 1: Destroy any existing Footable instance to avoid conflicts when reinitializing
            if ($('.adv-table').data('footable')) {
                $('.adv-table').data('footable').destroy();
            }

            // Step 2: Clear the HTML content of the table and filter container
            $('.adv-table').html('');
            $('#filter-form-container').empty();

            // Step 3: Loop through the data array and modify the rows for display
            data.forEach((row, index) => {
                // Assign a serial number based on the loop index
                row.serialNo = index + 1;

                // Create the HTML for userRoleName column including actions (View, Edit, Delete)
                row.action = `
            <div class="actions">
                <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                    <li>
                        <a href="javascript:void(0)" data-id="${row.gradeId}" class="edit-btn edit">
                            <i class="uil uil-edit"></i>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:void(0)" data-id="${row.gradeId}" class="delete-btn remove">
                            <i class="uil uil-trash-alt"></i>
                        </a>
                    </li>
                </ul>
            </div>`;

                // Create the HTML for isActive column with a toggle switch
                row.isActive = `
            <div class="form-check form-switch form-switch-primary form-switch-sm">
                <input 
                    type="checkbox" 
                    class="form-check-input" 
                    id="switch-${row.userRoleId}" 
                    ${row.grdStatus ? 'checked' : ''}>
                <label 
                    class="form-check-label" 
                    for="switch-${row.gradeId}">
                </label>
            </div>`;
            });

            // Step 5: Define the columns for the table, including custom rendering logic for some columns
            const columns = [
                { "name": "serialNo", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
                { "name": "grdName", "title": "Grade Name", "className": "userDatatable-content" },
                { "name": "grdNameBangla", "title": "বাংলায়", "className": "userDatatable-content" },
                { "name": "isActive", "title": "Status", "sortable": false, "filterable": false, "className": "userDatatable-content" },
                { "name": "action", "title": "Action", "sortable": false, "filterable": false, "className": "userDatatable-content" },
            ];

            // Step 6: Initialize Footable with the columns and data, enable filtering
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
                }).on('postinit.ft.table', function () {
                    // Hide loader after table initialization
                    $('.footable-loader').hide();
                });
            } catch (error) {
                console.error("Error initializing Footable:", error);
            }

            // Step 7: Attach event listeners for actions (Edit, Delete, View, Feature)

            // Clear and re-attach the edit button click event
            $('.adv-table').off('click', '.edit-btn').on('click', '.edit-btn', function () {
                const userRoleId = $(this).data('id');
                console.log('Edit button clicked for userRoleId:', userRoleId);
                 FetchDataForEdit(userRoleId); // Custom function to handle edit logic
            });

            // Clear and re-attach the delete button click event
            $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                const userRoleId = $(this).data('id');
                console.log('Delete button clicked for userRoleId:', userRoleId);
                Delete(userRoleId); 
            });

            // Clear and re-attach the feature button click event
            $('.adv-table').off('click', '.feature-btn').on('click', '.feature-btn', function () {
                const userRoleId = $(this).data('id');
                console.log('Feature button clicked for userRoleId:', userRoleId);
                // Add logic for feature handling
            });
        }

 
        


       

        function BoxExpland() {
            var scrollTop = $(window).scrollTop();

            $("#Cardbox").show();
            $("#addnew").text("Close");
            $(window).scrollTop(scrollTop);
        }



        
        function FetchDataForEdit(moduleID) {
            ApiCallById(getGradeByIdUrl, token, moduleID)
                .then(function (response) {
                    console.log('Data:', response);
                    var data = response.data;
                    $('#lblHidenGradeId').val(data.gradeId);
                    $('#ddlCompany').val(data.companyId).change();
                    $('#txtGradeName').val(data.grdName);
                    $('#txtGradeBangla').val(data.grdNameBangla);
                    $('#chkIsActive').prop('checked', data.grdStatus);
                    $('#btnSave').html('Update');
                    BoxExpland();
                      
                 
                })
                .catch(function (error) {
                    console.error('Error:', error);
                });
        }







    </script>

<%--    <script src="assets/theme_assets/js/TreeViewHepler.js"></script>--%>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="../assets/theme_assets/js/loadCompany.js"></script>
</asp:Content>
