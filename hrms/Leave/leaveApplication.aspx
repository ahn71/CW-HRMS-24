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
                                                       <select name="ddlLeaveType" id="ddlLeaveType" class="select-search form-control" onchange="IsMetarityLv()">
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
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" id="datepicker" placeholder="Start Date" onchange="calculateTotalDays()">
                                               <img class="svg calendar-icon" src="/hrms/img/svg/calendar.svg" alt="calendar">
                                             <span class="text-danger" id="datepickerError"></span>

                                           </div>
                                       </div>
                                       <div class="col-lg-3  col-md-6 col-sm-12 col-sm-6">
                                           <div class="form-group position-relative">
                                               <label for="datepicker2" class="color-dark fs-14 fw-500 align-center mb-10">
                                                 Leave End Date<span class="text-danger">*</span>
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" id="datepicker2" placeholder="End Date" onchange="calculateTotalDays()">
                                               <img class="svg calendar-icon" src="/hrms/img/svg/calendar.svg" alt="calendar">
                                           <span class="text-danger" id="datepicker2Error"></span>

                                           </div>
                                       </div>
                                       <div class="col-lg-3  col-md-6 col-sm-12 col-sm-6">
                                           <div class="form-group position-relative">
                                               <label for="totalDay" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Total Day
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" id="totalDay" placeholder="Total Day" disabled>
                                           

                                           </div>
                                       </div>
                                       
                                        <div id="pregnantDate" style="display:none" class="col-lg-3  col-md-6 col-sm-12 col-sm-6">
                                           <div class="form-group position-relative">
                                               <label for="datepicker3" class="color-dark fs-14 fw-500 align-center mb-10">
                                                  Pregnant Date<span class="text-danger">*</span>
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" id="datepicker3" placeholder="Pregnant Date">
                                               <img class="svg calendar-icon" src="/hrms/img/svg/calendar.svg" alt="calendar">
                                               <span class="text-danger" id="datepicker3Error"></span>

                                           </div>
                                       </div>
                                       <div id="expectedDeliverypanel" style="display:none" class="col-lg-3  col-md-6 col-sm-12 col-sm-6">
                                           <div class="form-group position-relative">
                                               <label for="datepicker4" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Expected Delivery Date <span class="text-danger">*</span>
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" id="datepicker4" placeholder="Expected Delivery Date" ">
                                               <img class="svg calendar-icon" src="/hrms/img/svg/calendar.svg" alt="calendar">
                                               <span class="text-danger" id="datepicker4Error"></span>

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
                                       <div class="col-lg-3 col-md-6 col-sm-12">
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


          <!-- Bootstrap Modal for Leave Application -->
          <div class="modal fade" id="leaveApplicationModal" tabindex="-1" aria-labelledby="leaveApplicationModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-lg">
                  <div class="modal-content" id="modalContent">
                      <div class="modal-header">
                          <h5 class="modal-title" id="leaveApplicationModalLabel">Leave Application Details</h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body">
                          <div id="leaveApplicationContent">
                              <!-- Leave Application details will be dynamically inserted here -->
                          </div>
                      </div>
                      <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                          <button type="button" class="btn btn-primary" onclick="printPDF()">Print PDF</button>
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
         var userId = '<%= Session["__GetUserId__"]%>';
         var dptId = '<%=  Session["__DptId__"]%>';
         var dsgId = '<%=  Session["__DsgId__"]%>';
         var gId = '<%=  Session["__Gid__"]%>';
         var sftId = '<%=  Session["__SftId__"]%>';
         var getLeavesApplicationUrl = rootUrl + '/api/Leave/lvApplications';
         var getLeaveByIdUrl = rootUrl + '/api/Leave/lvApplication';
        //var createLvUrl = rootUrl + '/api/Leave/create/${userId}';
        var createLvUrl =rootUrl+`/api/Leave/create/${userId}`;  // Pass userId in the URL

         var getEmployeeUrl = rootUrl + '/api/Employee/EmployeeName';
         var getLeaveTypeUrl = rootUrl + '/api/Leave/LeaveType';

        async function validateUser() {
            var isValid = true;

            // Patterns for validation (Alphabetic and Email patterns for future use)
            let alphabeticPattern = /^[a-zA-Z]+( [a-zA-Z]+)*$/;
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            // Validate Employee Name (Dropdown)
            let selectedEmp = $('#ddlEmpName').val();
            if (selectedEmp == "0") {
                $('#ddlEmpNameError').html("Please select an Employee Name.");
                $("#ddlEmpName").focus();
                isValid = false;
            } else {
                $('#ddlEmpNameError').html("");
            }

            // Validate Leave Type (Dropdown)
            let selectedLeaveName = $('#ddlLeaveType').val();
            if (selectedLeaveName == "0") {
                $('#ddlLeaveTypeError').html("Please select a Leave Type.");
                $("#ddlLeaveType").focus();
                isValid = false;
            } else {
                $('#ddlLeaveTypeError').html("");
            }

            // Validate Start Date
            if ($('#datepicker').val() === "") {
                $('#datepickerError').html("Start Date is required.");
                $("#datepicker").focus();
                isValid = false;
            } else {
                $('#datepickerError').html("");
            }

            // Validate End Date
            if ($('#datepicker2').val() === "") {
                $('#datepicker2Error').html("End Date is required.");
                $("#datepicker2").focus();
                isValid = false;
            } else {
                $('#datepicker2Error').html("");
            }

            // If validation passes, proceed with save or update
            if (isValid) {
                var addnewElement = $("#btnSave").text().trim();  // Get the button text (Save or Update)

                // If adding new user (Save operation)
                if (addnewElement === "Save") {
                    try {
                        var result = await PostLeave(true);  // Await the PostLeave function since it's async
                        if (result === true) {
                            // Optionally clear the form after saving
                            // ClearTextBox(); // Uncomment if you want to clear fields after save
                        }
                    } catch (error) {
                        console.error("An error occurred:", error);  // Handle any errors
                    }
                }

                // If updating existing user (Update operation)
                // Uncomment and modify this block if needed for update functionality
                /*
                else {
                    try {
                        var result = await updateUsers(true);  // Call the update function
                        if (result === true) {
                            ClearTextBox();  // Clear form fields if update was successful
                        }
                    } catch (error) {
                        console.error("An error occurred:", error);
                    }
                }
                */
            }
        }


        //function BoxExpland() {
        //    var scrollTop = $(window).scrollTop();

        //    $("#Cardbox").show();
        //    $("#addnew").text("Close");
        //    $("#IsGuest").show();
        //    $(window).scrollTop(scrollTop);
        //}

         function Cardbox() {
             var CardboxElement = $("#Cardbox");
             var addnewElement = $("#addnew");

             if (addnewElement.html() === "Add New") {
                 CardboxElement.show();
                 addnewElement.text("Close");
             } else {
                 /*ClearTextBox()*/;
                 CardboxElement.hide();
                 addnewElement.html("Add New");
                
             }
         }


        $(document).ready(function () {
           console.log('hello test');
            var initialDate = new Date();
            var options = { day: 'numeric', month: 'long', year: 'numeric' };
            var formattedDate = initialDate.toLocaleDateString('en-US', options);
            document.querySelector('.hasDatepicker').value = formattedDate;
            console.log('Date Check:', formattedDate);

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

        function IsMetarityLv() {
            // Ensure ddlLeaveType is defined and accessible
            const ddlLeaveType = document.getElementById('ddlLeaveType'); // Replace with the correct ID if necessary

            // Check if ddlLeaveType exists
            if (ddlLeaveType) {
                if (ddlLeaveType.value === '3032') {
                    $('#expectedDeliverypanel').show();
                    $('#pregnantDate').show();
                } else {
                    $('#expectedDeliverypanel').hide();
                    $('#pregnantDate').hide();
                }
            }
        }

        function calculateTotalDays() {
            // Get the values of the start and end date inputs
            const startDateValue = document.getElementById('datepicker').value;
            const endDateValue = document.getElementById('datepicker2').value;

            // Convert the date strings to Date objects
            const startDate = new Date(startDateValue);
            const endDate = new Date(endDateValue);

            // Check if both dates are valid
            if (startDate && endDate && startDate <= endDate) {
                // Calculate the total days
                const timeDiff = endDate - startDate; // Difference in milliseconds
                const totalDays = Math.ceil(timeDiff / (1000 * 3600 * 24)) + 1; // Convert to days and include the start date

                // Display the total days in the input box
                document.getElementById('totalDay').value = totalDays;
            } else {
                // Reset the total days input if dates are invalid
                document.getElementById('totalDay').value = '';
            }
        }


        function GetLeaves() {
            ApiCallwithCompanyId(getLeavesApplicationUrl, token,CompanyID)
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
             const defaultImage = '../user_img_default.jpg'; // Set the path to your default image here

             data.forEach(row => {
                 row.serial = serialNumber++; 
                 const empPicture = row.empPicture ? row.empPicture : defaultImage;
                 row.empPicture = `
                    <div class="user-details-container d-flex align-items-center">
                        <img src="${empPicture}" alt="User Image" class="user-image" style="width: 40px; height: 40px; margin-right: 10px;">
                        <div>
                            <a href="javascript:void(0)" class="user-name" data-id="${row.Id}">${row.empName}</a>
                            <div class="user-role">${row.dsgName}</div>
                        </div>
                    </div>
                `;
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
                    { "name": "empPicture", "title": "User", "className": "userDatatable-content" }, 
                 { "name": "leaveName", "title": "Leave Type", "className": "userDatatable-content" }, // Combined user image, name, and role column
                 { "name": "leaveStartDate", "title": "Start Date", "className": "userDatatable-content" },
                 { "name": "leaveEndDate", "title": "End Date", "className": "userDatatable-content" },
                 { "name": "totalLeaveDays", "title": "Total Day", "className": "userDatatable-content" },
                 { "name": "applyDate", "title": "Apply Date", "className": "userDatatable-content" },
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
                 FetchDataForView(id);
                 console.log('View button clicked for ID:', id);
              });

         }

        async function PostLeave(IsSave) {
            // Get selected values from the dropdowns
            var referenceEmp = $('#ddlReferenceEmp').val();
            var company = $('#ddlCompany').val();
            var empId = $('#ddlEmpName').val();
            var leaveTypeId = parseInt($('#ddlLeaveType').val().trim()) || 0; // Ensure valid integer

            // Get the input dates
            var startDate = $('#datepicker').val();  // Example: "1 October 2024"
            var endDate = $('#datepicker2').val();   // Example: "12 October 2024"

            // Convert to Date objects and check for validity
            var startDateObj = new Date(startDate);
            var endDateObj = new Date(endDate);
            if (isNaN(startDateObj.getTime()) || isNaN(endDateObj.getTime())) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Date',
                    text: 'Please enter valid start and end dates.'
                });
                return false;
            }

            var formattedStartDate = startDateObj.toISOString().split('T')[0];
            var formattedEndDate = endDateObj.toISOString().split('T')[0];

            // Get pregnancy and delivery dates
            var pregnantDate = $('#datepicker3').val();  // Example: "1 October 2024"
            var deliveryDate = $('#datepicker4').val();   // Example: "12 October 2024"

            // Convert to Date objects
            var pregnantDateObj = new Date(pregnantDate);
            var deliveryDateObj = new Date(deliveryDate);

            // Check for empty input values or invalid dates
            var formattedDeliveryDate = '';
            var formattedPregnantDate = '';

            if (pregnantDate.trim() === '') {
                // If both dates are empty or invalid
                formattedDeliveryDate = '';
                formattedPregnantDate = '';
            } else if (isNaN(pregnantDateObj.getTime()) || isNaN(deliveryDateObj.getTime())) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Date',
                    text: 'Please enter valid pregnancy and delivery dates.'
                });
                return false;
            } else {
                // Format dates to "YYYY-MM-DD"
                formattedDeliveryDate = deliveryDateObj.toISOString().split('T')[0];
                formattedPregnantDate = pregnantDateObj.toISOString().split('T')[0];
            }

            // Get other input values
            var chargeHandoverTo = $('#ddlChargeHandOverTo').val();
            var contact = $('#txtContact').val().trim();
            var lvAddress = $('#txtLeaveAddress').val().trim();
            var lvRemarks = $('#txtPurposeOfLv').val().trim();

            // Prepare the post data matching your API structure
            var postData = {
                leaveTypeId: leaveTypeId,
                leaveStartDate: formattedStartDate,
                leaveEndDate: formattedEndDate,
                pregnantDate: formattedPregnantDate,
                expectedDeliveryDate: formattedDeliveryDate,
                remarks: lvRemarks,
                handedOverEmpId: chargeHandoverTo,
                lvAddress: lvAddress,
                lvContact: contact,
                companyId: company,
                empTypeId: 0,
                // Assuming sftId, dptId, dsgId, gId are defined elsewhere
                sftId: sftId,
                dptId: dptId,
                dsgId: dsgId,
                gId: gId,
                empId: empId
            };

            try {
                // Await the API call
                let response = await ApiCallPost(createLvUrl, token, postData);

                // Handle response based on the status code
                if (response && response.statusCode === 200) {
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
                } else if (response && response.statusCode === 400) {
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
                console.error("API Error:", error); // Log the error
                return false; // Return false on error
            }
        }


        function printPDF() {
            var element = document.getElementById('leaveApplicationContent');

            // Generate PDF using html2pdf
            html2pdf()
                .from(element)
                .set({
                    margin: 1,
                    filename: 'leave-application.pdf',
                    html2canvas: {
                        scale: 2, // Increase scale for better quality
                        letterRendering: true // Enable letter rendering
                    },
                    jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
                })
                .save();
        }




        function FetchDataForView(Id) {
            ApiCallByCompId(getLeaveByIdUrl, token, Id, CompanyID)
                .then(function (responseData) {
                    var data = responseData.data[0]; // Get the first element in the data array

                    // Construct the HTML content for leave application form view
                    var leaveApplicationContent = `
            <div class="row">
              <div class="col-md-6">
                <p><strong>Employee Name:</strong> ${data.empName}</p>
                <p><strong>Designation:</strong> ${data.dsgName}</p>
                <p><strong>Leave Type:</strong> ${data.leaveName}</p>
                <p><strong>Leave Start Date:</strong> ${data.leaveStartDate}</p>
                <p><strong>Leave End Date:</strong> ${data.leaveEndDate}</p>
                <p><strong>Total Leave Days:</strong> ${data.totalLeaveDays}</p>
              </div>
              <div class="col-md-6">
                <p><strong>Remarks:</strong> ${data.remarks}</p>
                <p><strong>Handed Over Employee ID:</strong> ${data.handedOverEmpId}</p>
                <p><strong>Leave Address:</strong> ${data.lvAddress}</p>
                <p><strong>Leave Contact:</strong> ${data.lvContact}</p>
                <p><strong>Approval Status:</strong> ${data.approvalStatus ?? 'Pending'}</p>
                <p><strong>Company ID:</strong> ${data.companyId}</p>
              </div>
            </div>
            `;


                    document.getElementById('leaveApplicationContent').innerHTML = leaveApplicationContent;

                    var myModal = new bootstrap.Modal(document.getElementById('leaveApplicationModal'));
                    myModal.show();
                })
                .catch(function (error) {
                    console.error('Error:', error);
                });
        }
        





    </script>
  

    <script src="../assets/theme_assets/js/apiHelper.js"></script>

</asp:Content>
