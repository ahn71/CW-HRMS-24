<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="unitSetup.aspx.cs" Inherits="SigmaERP.hrms.settings.unitSetup" %>
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
                                    <h4>Add Units</h4>
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

                                                <label for="txtUnitName" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Unit Name <span class="text-danger">*</span>
                                                </label>
                                                <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtUnitName" placeholder="Type Grade Name">
                                                <span class="text-danger" id="txtUnitNameError"></span>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="txtUnitNameBn" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    বাংলায় <span class="text-danger"></span>
                                                </label>
                                               

                                                <asp:TextBox ID="txtUnitNameBn" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-gray radius-xs b-light px-15" Font-Names="SutonnyMJ"></asp:TextBox>
                                                                                                <span class="text-danger" id="txtUnitNameBnError"></span>

                                            </div>
                                        </div>

                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group mt-4">
                                                <label class="d-block">Status</label>
                                                <input type="checkbox" id="chkIsActive" checked>
                                                Active
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
                                  <h4 style="margin-top: 13px;">Unit List </h4>
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
        var LoginUserId = '<%= Session["__GetUserId__"]%>';
        var postUrl = rootUrl + '/api/Unit/create';
        var getByIdUrl = rootUrl + '/api/Unit/unit';
        var getAllUrl = rootUrl + `/api/Unit/units?CompanyId=${CompanyID}`;
        var updateUrl = rootUrl + '/api/Unit/update';
        var DeleteUrl = rootUrl + '/api/Unit/delete';
        var GetDdlCompanyUrl = rootUrl + `/api/Company/GetDropdownCompanies?CompanyId=${CompanyID}`;

        var token = '<%= Session["__UserToken__"] %>';
        console.log('this is token you can use it :', token);
        //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        $(document).ready(function () {
           
        
            //GetCompanys();
            GetAllUnits();
            
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

        // function ValidateAndPostModule() {
        //     var isValid = true;
        //    if ($('#txtQName').val().trim() === "") {
        //        $('#txtQNameError').html("Qualification Name is required.");
        //        $("#txtQName").focus();
        //        isValid = false;
        //    } else {
        //        $('#txtQNameError').html("");
        //    }

        //     if (isValid) {
        //         var addnewElement = $("#btnSave").text().trim();
        //         if (addnewElement === "Save") {
        //             PostQualification();
        //         }
        //         else {
        //             updateQualification(); 

        //         }
        //     }
        //}
         function ValidateAndPostModule() {
             var isValid = true;

             var unitName = $('#txtUnitName').val().trim();
             var unitNameBn = $('#txtUnitNameBn').val().trim();

             // Validate Unit Name
             if (unitName === "") {
                 $('#txtUnitNameError').html("Unit Name is required.");
                 $("#txtUnitName").focus();
                 isValid = false;
             } else {
                 $('#txtUnitNameError').html("");
             }
                  // Validate Unit Name
             if (unitNameBn === "") {
                 $('#txtUnitNameBnError').html("Unit Name is required.");
                 $("#txtUnitNameBn").focus();
                 isValid = false;
             } else {
                 $('#txtUnitNameBnError').html("");
             }
             // Add more validation here if needed for other fields (optional)

             if (isValid) {
                 var buttonText = $("#btnSave").text().trim();

                 if (buttonText === "Save") {
                     PostUnit();          // Call create function
                 } else {
                     updateUnit();        // Call update function
                 }
             }
         }

         function PostUnit () {
             var companyId = CompanyID; 
             var unitName = $('#txtUnitName').val().trim();
             var unitNameBn = $('#txtUnitNameBn').val().trim();
             var isActive = $('#chkIsActive').is(':checked');
             var userId = LoginUserId; 

          

             var postData = {
                 companyId: companyId,
                 unitName: unitName,
                 unitNameBn: unitNameBn,
                 isActive: isActive,
                 userId: userId
             };

             ApiCallPost(postUrl, token, postData)
                 .then(function (response) {
                     console.log('Unit saved:', response);
                     Swal.fire({
                         icon: 'success',
                         title: 'Success',
                         text: 'Unit saved successfully!'
                     }).then((result) => {
                         if (result.isConfirmed) {
                             GetAllUnits(); // Replace with your unit reload function
                             ClearForm();
                         }
                     });
                 })
                 .catch(function (error) {
                     console.error('Error saving unit:', error);

                     // Handle duplicate key error
                     if (error.responseJSON && error.responseJSON.error && error.responseJSON.error.includes("duplicate key")) {
                         Swal.fire({
                             icon: 'warning',
                             title: 'Duplicate Unit',
                             text: 'Unit with the same name already exists for this company.'
                         });
                     } else {
                         Swal.fire({
                             icon: 'warning',
                             title: 'Problem Found',
                             text: 'Failed to save unit. Please try again.'
                         });
                     }
                 });
         }




  

         function updateUnit() {
             var id = $('#lblHidenId').val();
             var unitName = $('#txtUnitName').val();
             var unitNameBn = $('#txtUnitNameBn').val();
             var isActive = $('#chkIsActive').is(':checked');

             var updateData = {
                 companyId: CompanyID,         // Assumes global CompanyID is available
                 unitName: unitName,
                 unitNameBn: unitNameBn,
                 isActive: isActive
             };

             ApiCallUpdate(updateUrl, token, updateData, id)
                 .then(function (response) {
                     console.log('Unit updated successfully:', response);
                     Swal.fire({
                         icon: 'success',
                         title: 'Success',
                         text: 'Unit updated successfully!'
                     }).then((result) => {
                         if (result.isConfirmed) {
                             GetAllUnits();         // Refresh the table
                             ClearForm();           // Optional: Clear/reset the form
                         }
                     });
                 })
                 .catch(function (error) {
                     console.error('Error updating unit:', error);

                     let message = 'Failed to update unit. Please try again.';
                     if (error.responseJSON && error.responseJSON.message) {
                         message = error.responseJSON.message;
                     }

                     Swal.fire({
                         icon: 'error',
                         title: 'Error',
                         text: message
                     });
                 });
         }

         function ClearForm() {
             $('#lblHidenId').val('');
             $('#txtUnitName').val('');
             $('#txtUnitNameBn').val('');
             $('#chkIsActive').prop('checked', true);
             $('#btnSave').html('Save');
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
                                GetAllUnits();
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


        function GetAllUnits() {
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

            if ($('.adv-table').data('footable')) {
                $('.adv-table').data('footable').destroy();
            }

            $('.adv-table').html('');
            $('#filter-form-container').empty();

            data.forEach((row, index) => {
                row.serialNo = index + 1;
                row.qid = row.unitId; // Use unitId for actions

                row.qname = row.unitName;         // Map to Grade Name column
                row.qnameBn = row.unitNameBn;     // Map to বাংলায় column

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
            });

            const columns = [
                { "name": "serialNo", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
                { "name": "qname", "title": "Unit Name", "className": "userDatatable-content" },
                { "name": "qnameBn", "title": "Unit Name (Bn)", "className": "userDatatable-content sutonny-font" },
                { "name": "action", "title": "Action", "sortable": false, "filterable": false, "className": "userDatatable-content" },
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
                }).on('postinit.ft.table', function () {
                    $('.footable-loader').hide();
                });
            } catch (error) {
                console.error("Error initializing Footable:", error);
            }

            $('.adv-table').off('click', '.edit-btn').on('click', '.edit-btn', function () {
                const unitId = $(this).data('id');
                console.log('Edit clicked for unitId:', unitId);
                FetchDataForEdit(unitId);
            });

            $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                const unitId = $(this).data('id');
                console.log('Delete clicked for unitId:', unitId);
                Delete(unitId);
            });
        }


 
        


       

        function BoxExpland() {
            var scrollTop = $(window).scrollTop();

            $("#Cardbox").show();
            $("#addnew").text("Close");
            $(window).scrollTop(scrollTop);
        }



        
         function FetchDataForEdit(unitId) {
             ApiCallById(getByIdUrl, token, unitId)
                 .then(function (response) {
                     console.log('Unit Data:', response);
                     var data = response.data;

                     // Fill form fields with data
                     $('#lblHidenId').val(data.unitId);                  // Hidden ID field
                     $('#txtUnitName').val(data.unitName);                  // Unit Name
                     $('#txtUnitNameBn').val(data.unitNameBn);             // Unit Name (Bn)
                     $('#chkIsActive').prop('checked', data.isActive);   // Checkbox

                     // Update save button text
                     $('#btnSave').html('Update');

                     // Expand form section or modal
                     BoxExpland();
                 })
                 .catch(function (error) {
                     console.error('Fetch Error:', error);
                     Swal.fire({
                         icon: 'error',
                         title: 'Failed to load data',
                         text: 'Something went wrong while fetching unit details.'
                     });
                 });
         }








     </script>

<%--    <script src="assets/theme_assets/js/TreeViewHepler.js"></script>--%>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="../assets/theme_assets/js/loadCompany.js"></script>
</asp:Content>
