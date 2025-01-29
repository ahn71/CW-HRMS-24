<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="qualificationSetup.aspx.cs" Inherits="SigmaERP.hrms.settings.qualificationSetup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Bengali&display=swap" rel="stylesheet">

    <style>
        td{
            text-align:left;

        }

        @font-face {
            font-family: 'SutonnyMJ';
            src: url('https://cdn.example.com/fonts/SutonnyMJ.ttf') format('truetype');
        }

        .sutonny-font {
            font-family: 'SutonnyMJ', sans-serif;
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
                                    <h4>Add Qualification</h4>
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
                                                <label id="lblHidenId" style="display: none"></label>

                                                <label for="txtQName" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Qualification Name <span class="text-danger">*</span>
                                                </label>
                                                <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtQName" placeholder="Type Grade Name">
                                                <span class="text-danger" id="txtQNameError"></span>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="txtQBangla" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    বাংলায় <span class="text-danger"></span>
                                                </label>
                                               

                                                <asp:TextBox ID="txtQBangla" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-gray radius-xs b-light px-15" Font-Names="SutonnyMJ"></asp:TextBox>
                                            </div>
                                        </div>   
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
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
                                  <h4 style="margin-top: 13px;">Qualification </h4>
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
        var postUrl = rootUrl + '/api/Qualification/qualifications/create';
        var getByIdUrl = rootUrl + '/api/Qualification/qualifications';
        var getAllUrl = rootUrl + `/api/Qualification/qualifications?CompanyId=${CompanyID}`;
        var updateUrl = rootUrl + '/api/Qualification/qualifications/update';
        var DeleteUrl = rootUrl + '/api/Qualification/qualifications/delete';
        var GetDdlCompanyUrl = rootUrl + `/api/Company/GetDropdownCompanies?CompanyId=${CompanyID}`;

        var token = '<%= Session["__UserToken__"] %>';
        console.log('this is token you can use it :', token);
        //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        $(document).ready(function () {
           
        
            //GetCompanys();
            GetAllQualification();
            
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
            if ($('#txtQName').val().trim() === "") {
                $('#txtQNameError').html("Qualification Name is required.");
                $("#txtQName").focus();
                isValid = false;
            } else {
                $('#txtQNameError').html("");
            }

             if (isValid) {
                 var addnewElement = $("#btnSave").text().trim();
                 if (addnewElement === "Save") {
                     PostQualification();
                 }
                 else {
                     updateQualification(); 

                 }
             }
        }
        


         function PostQualification() {
            var CompanyId = CompanyID;
            var qname = $('#txtQName').val();
            var qnameBn = $('#txtQBangla').val();
             var postData = {
                companyId:CompanyId,
                qname: qname,
                qnameBn: qnameBn,

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
                            GetAllQualification();
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

         function updateQualification() {
                var Id = $('#lblHidenId').val();
                var Qname = $('#txtQName').val();
                var QnameBn = $('#txtQBangla').val();

             var updateData = {
                 companyId: CompanyID,
                qname: Qname,
                qnameBn: QnameBn,
                };

            ApiCallUpdate(updateUrl, token, updateData, Id)
                .then(function (response) {
                    console.log('Data updated successfully:', response);
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'Data updated successfully!'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            GetAllQualification();
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
                                GetAllQualification();
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





        function GetAllQualification() {
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
                        <a href="javascript:void(0)" data-id="${row.qid}" class="edit-btn edit">
                            <i class="uil uil-edit"></i>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:void(0)" data-id="${row.qid}" class="delete-btn remove">
                            <i class="uil uil-trash-alt"></i>
                        </a>
                    </li>
                </ul>
            </div>`;

                // Create the HTML for isActive column with a toggle switch
           
            });

            // Step 5: Define the columns for the table, including custom rendering logic for some columns
            const columns = [
                { "name": "serialNo", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
                { "name": "qname", "title": "Grade Name", "className": "userDatatable-content" },
                { "name": "qnameBn", "title": "বাংলায়", "className": "userDatatable-content sutonny-font" },
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
            ApiCallById(getByIdUrl, token, moduleID)
                .then(function (response) {
                    console.log('Data:', response);
                    var data = response.data;
                    $('#lblHidenId').val(data.qid);
                    $('#txtQName').val(data.qname);
                    $('#txtQBangla').val(data.qnameBn);
               
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