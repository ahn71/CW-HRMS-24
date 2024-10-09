<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="leaveApplication.aspx.cs" Inherits="SigmaERP.hrms.Leave.leaveApplication" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>


        .calendar-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            cursor: pointer;
            width:20px;
            height:20px;
        }
        .PurposeOfLv{
            height:50px !important;
           
           
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
                           <h4>Leave Application</h4>
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
                               <div class="col-lg-12">
                                   <div class="row">
                                       <div class="col-lg-3 col-md-6 col-sm-12" ">
                                           <div class="form-group">
                                               <label id="lblHidenUserId" style="display: none"></label>
                                               <label for="ddlCompany" class="color-dark fs-14 fw-500 align-center mb-10">Company</label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                        <asp:DropDownList runat="server" ID="ddlCompany" ClientIDMode="Static" class="select-search form-control"></asp:DropDownList>

                                                   </div>
                                                   <span class="text-danger" id="ddlCompanyError"></span>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="ddlEmpName" class="color-dark fs-14 fw-500 align-center mb-10">Employee<span class="text-danger">*</span></label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                       <select name="ddlEmpName" id="ddlEmpName" class="select-search form-control">
                                                           <option value="0">---Select---</option>
                                                       </select>
                                                   </div>
                                                   <span class="text-danger" id="ddlEmpNameError"></span>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="ddlLeaveType" class="color-dark fs-14 fw-500 align-center mb-10">Leave Type<span class="text-danger">*</span></label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                       <select name="ddlLeaveType" id="ddlLeaveType" class="select-search form-control">
                                                           <option value="0">---Select---</option>
                                                       </select>
                                                   </div>
                                                   <span class="text-danger" id="ddlLeaveTypeError"></span>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3  col-md-6 col-sm-12 col-sm-6">
                                           <div class="form-group position-relative">
                                               <label for="datepicker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                  Leave Start Date<span class="text-danger">*</span>
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" id="datepicker" placeholder="Start Date">
                                               <img class="svg calendar-icon" src="/hrms/img/svg/calendar.svg" alt="calendar">
                                             <span class="text-danger" id="datepickerError"></span>

                                           </div>
                                       </div>
                                       <div class="col-lg-3  col-md-6 col-sm-12 col-sm-6">
                                           <div class="form-group position-relative">
                                               <label for="datepicker2" class="color-dark fs-14 fw-500 align-center mb-10">
                                                 Leave End Date<span class="text-danger">*</span>
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" id="datepicker2" placeholder="End Date">
                                               <img class="svg calendar-icon" src="/hrms/img/svg/calendar.svg" alt="calendar">
                                           <span class="text-danger" id="datepicker2Error"></span>

                                           </div>
                                       </div>


                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="ddlChargeHandOverTo" class="color-dark fs-14 fw-500 align-center mb-10">Charge hand Over To</label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                       <select name="ddlChargeHandOverTo" id="ddlChargeHandOverTo" class="select-search form-control">
                                                           <option value="0">---Select---</option>
                                                       </select>
                                                   </div>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">

                                               <label for="txtContact" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Phone Number
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtContact" placeholder="Phone Number">
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">

                                               <label for="txtLeaveAddress" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Leave Address
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtLeaveAddress" placeholder="Type First Name" pattern="[^\d]*" title="Numbers are not allowed">
                                           </div>
                                       </div>

                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group form-element-textarea mb-20">
                                               <label for="txtPurposeOfLv" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Purpose Of Leave
                                                </label>
                                               <textarea class="form-control PurposeOfLv" placeholder="Type Purpose Of Leave" id="txtPurposeOfLv" rows="1"></textarea>
                                           </div>
                                       </div>
                                       <div class="col-lg-6 col-md-6 col-sm-12">
                                           <div class="form-group form-element-textarea mb-20">
                                               <label for="txtdocemnt" class="color-dark fs-14 fw-500 align-center mb-10">Attach Document(if any)</label>
                                                  <div class="dm-tag-wrap">
                                                       <div class="dm-upload">
                                                           <div class="dm-upload__button">
                                                               <a href="javascript:void(0)" class="btn btn-lg btn-outline-lighten btn-upload" onclick="$('#upload-1').click()">
                                                                   <img class="svg" src="/hrms/img/svg/upload.svg" alt="upload">
                                                                   Click to Upload</a>
                                                               <input type="file" name="upload-1" class="upload-one" id="upload-1">
                                                           </div>
                                                           <div class="dm-upload__file">
                                                               <ul>
                                                               </ul>
                                                           </div>
                                                       </div>

                                                   </div>
                                           </div>
                                           
                                               
                                                
                                              
                                       
                                       </div>

                                       <div class="col-lg-3  col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label style="opacity: 0;" for="formGroupExampleInput"
                                                   class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Name <span
                                                       class="text-danger"></span>
                                               </label>
                                               <button type="button" id="btnSave" onclick="validateUser()"
                                                   class="btn btn-primary btn-default btn-squared px-30">Save</button>
                                           </div>
                                       </div>


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
                                  <h4 style="margin-top: 13px;"></h4>
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
         //var rootUrl = 'https://localhost:7220';
         var rootUrl = '<%= Session["__RootUrl__"]%>';
         var CompanyID = '<%= Session["__GetCompanyId__"]%>';

         var getLeavesApplicationUrl = rootUrl + '/api/Leave/lvApplications';
         var createLvUrl = rootUrl + '/api/Leave/create';
         var getEmployeeUrl = rootUrl + '/api/Employee/EmployeeName';
         var getLeaveTypeUrl = rootUrl + '/api/Leave/LeaveType';

        async function validateUser() {
            var isValid = true;
            let alphabeticPattern = /^[a-zA-Z]+( [a-zA-Z]+)*$/;
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            let selectedEmp = $('#ddlEmpName').val();
            if (selectedEmp == "0") {
                $('#ddlEmpNameError').html("Please select a Employee Name.");
                $("#ddlEmpName").focus();
                isValid = false;
            } else {
                $('#ddlEmpNameError').html("");
            }
            let selectedLeaveName = $('#ddlLeaveType').val();
            if (selectedLeaveName == "0") {
                $('#ddlLeaveTypeError').html("Please select a Leave Type.");
                $("#ddlLeaveType").focus();
                isValid = false;
            } else {
                $('#ddlLeaveTypeError').html("");
            }

            if ($('#datepicker').val().trim() === "") {
                $('#datepickerError').html("Start Date is required.");
                $("#datepicker").focus();
                isValid = false;
            } 
            else {
                $('#datepickerError').html("");
            }
            if ($('#datepicker2').val().trim() === "") {
                $('#datepicker2Error').html("End Date is required.");
                $("#datepicker").focus();
                isValid = false;
            }
            else {
                $('#datepickerError').html("");
            }


            // If validation passes, proceed with save or update
            if (isValid) {
                var addnewElement = $("#btnSave").text().trim();  // Get the button text

                // If adding new user
                if (addnewElement === "Save") {
                    try {
                        var result = await PostLeave(true);  // Wait for PostUsers to finish

                        if (result === true) {  // Check if PostUsers returned true
                            ClearTextBox();  // Clear the form fields
                        }
                    } catch (error) {
                        console.error("An error occurred:", error);  // Handle any errors
                    }
                }
                // If updating existing user
                //else {

                //    try {
                //        var result = await updateUsers(true);  // Wait for PostUsers to finish

                //        if (result === true) {  // Check if PostUsers returned true
                //            ClearTextBox();  // Clear the form fields
                //        }
                //    } catch (error) {
                //        console.error("An error occurred:", error);  // Handle any errors
                //    };



                //}
            }
        }

        function BoxExpland() {
            var scrollTop = $(window).scrollTop();

            $("#Cardbox").show();
            $("#addnew").text("Close");
            $("#IsGuest").show();
            $(window).scrollTop(scrollTop);
        }

        function Cardbox() {
             var CardboxElement = $("#Cardbox");
             var addnewElement = $("#addnew");

             if (addnewElement.html() === "Add New") {
                 CardboxElement.show();
                  $("#IsGuest").show();
                 addnewElement.text("Close");
             } else {
                 ClearTextBox();
                 CardboxElement.hide();
                 addnewElement.html("Add New");
                   $("#IsGuest").hide();
             }
          
        }

        $(document).ready(function () {
           console.log('hello test');
           
            GetLeaves();
            GetEmployee();
            GetLeaveType();

          
        });
        function GetEmployee() {
            ApiCall(getEmployeeUrl, token)
                .then(function (response) {
                    if (response.statusCode === 200) {  // Make sure 'statusCode' matches your API response structure
                        var responseData = response.data;  // Access the correct 'data' field
                        console.log(responseData);
                        EmployeePopulateDropdown(responseData);
                    } else {
                        console.error('Error occurred while fetching data:', response.message);
                    }
                    $('.loaderCosting').hide();  // Hide loader after the request finishes
                })
                .catch(function (error) {
                    $('.loaderCosting').hide();
                    console.error('Error occurred while fetching data:', error);
                });
        }




        function GetLeaveType() {
            ApiCallwithCompanyId(getLeaveTypeUrl, token, CompanyID)
                .then(function (response) {
                    if (response.statusCode === 200) {  // Make sure 'statusCode' matches your API response structure
                        var responseData = response.data;  // Access the correct 'data' field
                        console.log(responseData);
                        LeaveTypePopulateDropdown(responseData);
                    } else {
                        console.error('Error occurred while fetching data:', response.message);
                    }
                    $('.loaderCosting').hide();  // Hide loader after the request finishes
                })
                .catch(function (error) {
                    $('.loaderCosting').hide();
                    console.error('Error occurred while fetching data:', error);
                });
        }



        function LeaveTypePopulateDropdown(data) {
            const dropdown = document.getElementById('ddlLeaveType');
            dropdown.innerHTML = '<option value="0">---Select---</option>'; // Clear existing options

            data.forEach(item => {
                const option = document.createElement('option');
                option.value = item.leaveId;
                option.textContent = item.leaveName;
                dropdown.appendChild(option);
            });
        }

        function EmployeePopulateDropdown(data) {
            const empDropdown = document.getElementById('ddlEmpName');
            const chargeDropdown = document.getElementById('ddlChargeHandOverTo');

            // Clear existing options for both dropdowns
            empDropdown.innerHTML = '<option value="0">---Select---</option>';
            chargeDropdown.innerHTML = '<option value="0">---Select---</option>';

            // Populate both dropdowns with the same data
            data.forEach(item => {
                const empOption = document.createElement('option');
                empOption.value = item.empId;
                empOption.textContent = item.fullName;
                empDropdown.appendChild(empOption);

                const chargeOption = document.createElement('option');
                chargeOption.value = item.empId;
                chargeOption.textContent = item.fullName;
                chargeDropdown.appendChild(chargeOption);
            });
        }




        function GetLeaves() {
            ApiCall(getLeavesApplicationUrl, token)
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

             let serialNumber = 1; // Initialize serial number
             const defaultImage = 'user_img_default.jpg'; // Set the path to your default image here

             data.forEach(row => {
                 row.serial = serialNumber++; // Assign serial number to each row

                 var readAction = '<%= Session["__ReadAction__"] %>';
                 var updateAction = '<%= Session["__UpdateAction__"] %>';
                 var deleteAction = '<%= Session["__DeletAction__"] %>';

                 // Use default image if userImage is not found or invalid
                 const userImage = row.userImage ? row.userImage : defaultImage;

                 row.action = `
            <div class="actions">
                <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                    <li><a href="javascript:void(0)" class="view-btn view" data-id="${row.id}"><i class="uil uil-eye"></i></a></li>
                    <li><a href="javascript:void(0)" data-id="${row.id}" class="delete-btn remove"><i class="uil uil-trash-alt"></i></a></li> 
                </ul>
            </div>
        `;
                 row.approvalStatus = row.approvalStatus === null
                     ? '<span class="badge bg-onlyme">Pending</span>'
                     : row.approvalStatus === 0
                         ? '<span class="badge bg-warning">Processing</span>'
                         : row.approvalStatus === 1
                             ? '<span class="badge bg-success">Approve</span>'
                             : row.approvalStatus === 2
                                 ? '<span class="badge bg-info">Reject</span>'
                                 : '<span class="badge bg-secondary">NA</span>';
             });

             const columns = [
                 { "name": "serial", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" }, // Serial number column
                 { "name": "leaveTypeId", "title": "Leave Name", "className": "userDatatable-content" }, // Combined user image, name, and role column
                 { "name": "leaveStartDate", "title": "Start Date", "className": "userDatatable-content" },
                 { "name": "leaveEndDate", "title": "End Date", "className": "userDatatable-content" },
                 { "name": "totalLeaveDays", "title": "Total Day", "className": "userDatatable-content" },
                 { "name": "createdAt", "title": "Apply Date", "className": "userDatatable-content" },
                 { "name": "approvalStatus", "title": "Status", "className": "userDatatable-content" },
                 { "name": "action", "title": "Action", "sortable": false, "filterable": false, "className": "userDatatable-content" }, // Action column
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


             $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                 const id = $(this).data('id');
                 //Delete(id);
                 console.log('Delete button clicked for ID:', id);
             });

             $('.adv-table').off('click', '.view-btn').on('click', '.view-btn', function () {
                 const id = $(this).data('id');
                 //FetchDataForView(id);
                 console.log('View button clicked for ID:', id);
              });



              async function PostLeave(IsSave) {
                  var refaranceEmp = $('#ddlReferenceEmp').val();
                  var company = $('#ddlCompany').val();
                  var empId = $('#ddlEmpName').val();
                  var leaveTypeId = $('#ddlLeaveType').val().trim();
                  var startDate = $('#datepicker').val().trim();
                  var endDate = $('#datepicker2').val().trim();
                  var chargeHandoverTo = $('#ddlChargeHandOverTo').val();
                  var contact = $('#txtContact').val().trim();
                  var lvAddress = $('#txtLeaveAddress').val().trim();
                  var lvRemarks = $('#txtRemarks').val().trim();  // Assuming remarks
                  var isHalfDayLeave = $('#chkIsHalfDay').prop('checked'); // Assuming a checkbox for half-day leave

                  // Prepare the post data matching your API structure
                  var postData = {
                      applicationId: "", // Set to empty or a valid application ID
                      leaveTypeId: parseInt(leaveTypeId),
                      isHalfDayLeave: isHalfDayLeave,
                      applyDate: new Date().toISOString().split('T')[0], // Current date
                      leaveStartDate: startDate,
                      leaveEndDate: endDate,
                      totalLeaveDays: 0,
                      pregnantDate: "2024-10-09", 
                      expectedDeliveryDate: "2024-10-09", 
                      remarks: lvRemarks,
                      handedOverEmpId: chargeHandoverTo,
                      lvAddress: lvAddress,
                      lvContact: contact,
                      companyId: company,
                      empTypeId: 0, // Set employee type ID appropriately
                      sftId: 0, // Set shift ID if required
                      dptId: "string", // Set department ID appropriately
                      dsgId: "string", // Set designation ID appropriately
                      gId: 0, // Group ID if needed
                      empId: empId
                  };

                  try {
                      const response = await ApiCallPost(createLvUrl, token, postData);

                      if (response.statusCode === 200) {
                          Swal.fire({
                              icon: 'success',
                              title: 'Success',
                              text: 'Leave application saved successfully!'
                          }).then((result) => {
                              if (result.isConfirmed) {
                                  GetUsers();  // Update user list or perform necessary actions
                              }
                          });
                          return true; // Indicate success
                      } else if (response.statusCode === 400) {
                          Swal.fire({
                              icon: 'error',
                              title: 'Validation Error',
                              text: 'Please check your input and try again.'
                          });
                          return false; // Validation or other error
                      } else {
                          Swal.fire({
                              icon: 'error',
                              title: 'Error',
                              text: 'An error occurred. Please try again.'
                          });
                          return false; // General error handling
                      }
                  } catch (error) {
                      Swal.fire({
                          icon: 'error',
                          title: 'Error',
                          text: 'Failed to save the leave application. Please try again.'
                      });
                      return false; // Return false on error
                  }
              }


    

         }



    </script>

    <script src="../assets/theme_assets/js/apiHelper.js"></script>

</asp:Content>
