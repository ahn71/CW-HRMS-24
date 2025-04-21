 <%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="specialCase.aspx.cs" Inherits="SigmaERP.hrms.Special_Case.specialCase" EnableEventValidation="false" %>
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
        .removeFile{
            background-color:none;
            border:none;
            color:red;
            padding:3px;
        }
        .leve_loader_wrap {
            position: absolute;
            z-index: 3;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
             display: flex;
    align-items: center;
    justify-content: center;
             width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.1);
            border-radius:4px;
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
                           <h4>SpecialCase Application</h4>
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
                                   <div class="leve_loader_wrap loaderLeaveSave" style="display:none">
                                   <div id="lvSaveLoader" class="loader-size py-5 text-center ">
                                       <div class="dm-spin-dots  dot-size dot-sizedot-sizedot-sizedot-size spin-sm">
                                           <span class="spin-dot badge-dot dot-primary"></span>
                                           <span class="spin-dot badge-dot dot-primary"></span>
                                           <span class="spin-dot badge-dot dot-primary"></span>
                                           <span class="spin-dot badge-dot dot-primary"></span>
                                       </div>
                                   </div>

                                   </div>
                                   <div class="row">
                                       <div class="col-lg-3 col-md-6 col-sm-12" id="ddlCompanySection" style="display:none">
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
                                       <div class="col-lg-3 col-md-6 col-sm-12" id="ddlEmpNameSection" style="display:none">
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
                                       <div class="col-lg-3  col-md-6 col-sm-12 col-sm-6">
                                           <div class="form-group position-relative">
                                               <label for="datepicker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Date<span class="text-danger">*</span>
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" autocomplete="off" id="datepicker" placeholder="Apply Date">
                                               <img class="svg calendar-icon" src="/hrms/img/svg/calendar.svg" alt="calendar">
                                               <span class="text-danger" id="applydateError"></span>

                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="ddlCaseType" class="color-dark fs-14 fw-500 align-center mb-10">Case Type<span class="text-danger">*</span></label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                       <select name="ddlCaseType" id="ddlCaseType" class="select-search form-control" onchange="IsMetarityLv()">
                                                           <option value="0">---Select---</option>
                                                           <option value="1">Punch missing</option>
                                                           <option value="2">Out Site Metting</option>
                                                           <option value="3">Home Office</option>
                                                       </select>
                                                   </div>
                                                   <span class="text-danger" id="ddlCaseTypeError"></span>
                                               </div>
                                           </div>
                                       </div>
              
                                         <div class="col-lg-3 col-md-6 col-sm-12">
                                            <div class="form-group position-relative">
                                                <label for="intimepicker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    In Time <span class="text-danger">*</span>
                                                </label>
                                                <input type="time" class="form-control ih-medium ip-light radius-xs b-light px-15" 
                                                       id="inTimepicker" onchange="handleTimeChange()">
                                                <span class="text-danger" id="intimeError"></span>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-6 col-sm-12">
                                            <div class="form-group position-relative">
                                                <label for="OutTimepicker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Out Time <span class="text-danger">*</span>
                                                </label>
                                                <input type="time" class="form-control ih-medium ip-light radius-xs b-light px-15" 
                                                       id="OutTimepicker" onchange="handleTimeChange()">
                                                <span class="text-danger" id="OutTimepickerError"></span>
                                            </div>
                                        </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group form-element-textarea mb-20">
                                               <label for="txtPurposeOfOutDuty" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Purpose
                                                </label>
                                               <textarea class="form-control PurposeOfLv" placeholder="Type Purpose Of Leave" id="txtPurposeOfOutDuty" rows="1"></textarea>
                                           </div>
                                       </div>
                                       <div class="col-lg-3  col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label style="opacity: 0;" for="formGroupExampleInput"
                                                   class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Name <span
                                                       class="text-danger"></span>
                                               </label>
                                               <button type="button" style="cursor: pointer;" id="btnSave" onclick="validateUser()"
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
                          <button type="button" class="btn btn-primary" onclick="printPDF()">Print</button>
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
         var loginempId = '<%= Session["__GetEmpId__"]%>';
         var dptId = '<%= Session["__DptId__"] %>' || null;
         var dsgId = '<%= Session["__DsgId__"] %>' || null;
         var gId = '<%= Session["__Gid__"] %>' || null;
         var sftId = '<%= Session["__SftId__"] %>' || null;
         
        
        
         var getCompanyUrl = rootUrl + `/api/Company/GetDropdownCompanies?IsAdministrator=false&CompanyId=${CompanyID}`;
         var getLeaveByIdUrl = rootUrl + `/api/Leave/lvApplication/${userId}?CompanyId=${CompanyID}`;
         var getSpcDeleteUrl = rootUrl + '/api/SpecialCase/delete';
         var getSpCApplicationUrl = rootUrl + `/api/SpecialCase/SpecialCases?CompnayId=${CompanyID}&EmpId=${loginempId}`;
         var DataAccessLevel = '<%=Session["__UserDataAccessLevel__"]%>';

        //var createLvUrl = rootUrl + '/api/Leave/create/${userId}';
        var PostCaseUrl =rootUrl+`/api/SpecialCase/create`;  // Pass userId in the URL

        var empUrl = '/api/Employee/EmployeeName';
        var getEmployeeUrl = `${rootUrl}${empUrl}?CompanyId=${CompanyID}`;


        var getLeaveTypeUrl = rootUrl + '/api/Leave/LeaveType';

         function handleTimeChange() {
             let intime = document.getElementById("inTimepicker").value;
             let OutTime = document.getElementById("OutTimepicker").value;
                console.log("Selected Time:", intime);
         }

        async function validateUser() {
            var isValid = true;

            let alphabeticPattern = /^[a-zA-Z]+( [a-zA-Z]+)*$/;
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (DataAccessLevel != 1) {
                let selectedEmp = $('#ddlCompany').val();
                if (selectedEmp == "0") {
                    $('#ddlCompanyError').html("Please select Comapny.");
                    $("#ddlCompany").focus();
                    isValid = false;
                } else {
                    $('#ddlCompanyError').html("");
                }
            }
            if (DataAccessLevel != 1) {
                let selectedEmp = $('#ddlEmpName').val();
                if (selectedEmp == "0") {
                    $('#ddlEmpNameError').html("Please select an Employee Name.");
                    $("#ddlEmpName").focus();
                    isValid = false;
                } else {
                    $('#ddlEmpNameError').html("");
                }
            }
            if (DataAccessLevel != 1) {
                let selectedEmp = $('#ddlCaseType').val();
                if (selectedEmp == "0") {
                    $('#ddlCaseTypeError').html("Please select Case Type.");
                    $("#ddlCaseType").focus();
                    isValid = false;
                } else {
                    $('#ddlCaseTypeError').html("");
                }
            }
            let inTime = $('#inTimepicker').val();
            let outTime = $('#OutTimepicker').val();

            // Validate In Time
            if (!inTime) {
                $('#intimeError').html("Please select In Time.");
                $('#inTimepicker').focus();
                isValid = false;
            } else {
                $('#intimeError').html("");
            }

            // Validate Out Time
            if (!outTime) {
                $('#OutTimepickerError').html("Please select Out Time.");
                if (isValid) { // focus only if In Time was valid
                    $('#OutTimepicker').focus();
                }
                isValid = false;
            } else {
                $('#OutTimepickerError').html("");
            }

            // Validate Start Date
            if ($('#datepicker').val() === "") {
                $('#lvstartdateError').html("Apply Date is required.");
                $("#datepicker").focus();
                isValid = false;
            } else {
                $('#lvstartdateError').html("");
            }

            if (isValid) {
                var addnewElement = $("#btnSave").text().trim();  
                if (addnewElement === "Save") {
                    try {
                        var result = await PostCase(true);  
                        if (result === true) {
                            ClearTextBox();
                        }
                    } catch (error) {
                        console.error("An error occurred:", error);
                    }
                }

            }
        }
        function ClearTextBox() {
            $('select[name="ddlLeaveType"]').val('0').change();
            $('select[name="ddlEmpName"]').val('0').change();
            $('select[name="ddlChargeHandOverTo"]').val('0').change();
            $('#datepicker5').val("");
            $('#datepicker').val("");
            $('#datepicker2').val("");
            $('#totalDay').val("");
            $('#datepicker3').val("");
            $('#datepicker4').val("");
            $('#txtLeaveAddress').val("");
            $('#txtPurposeOfLv').val("");
            $('#txtContact').val("");
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

           
            GetEmployee();
            GetCompany();
            GetSpacialCase();
            if (DataAccessLevel == 1) {
                $('#divapplyDate').hide();
                $('#ddlCompanySection').hide();
                $('#ddlEmpNameSection').hide();
            } else {
                $('#divapplyDate').show();
                $('#ddlCompanySection').show();
                $('#ddlEmpNameSection').show();

            }



          
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




        function GetCompany() {
            ApiCall(getCompanyUrl, token)
                .then(function (response) {
                    if (response.statusCode === 200) {  // Make sure 'statusCode' matches your API response structure
                        var responseData = response.data;  // Access the correct 'data' field
                        console.log(responseData);
                        CompanyPopulateDropdown(responseData);
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



        function CompanyPopulateDropdown(data) {
            const dropdown = document.getElementById('ddlCompany');
            dropdown.innerHTML = '<option value="0">---Select---</option>'; // Clear existing options

            data.forEach(item => {
                const option = document.createElement('option');
                option.value = item.companyId;
                option.textContent = item.companyName;
                dropdown.appendChild(option);
            });
        }

        function EmployeePopulateDropdown(data) {
            const empDropdown = document.getElementById('ddlEmpName');

            // Clear existing options for both dropdowns
            empDropdown.innerHTML = '<option value="0">---Select---</option>';

            // Populate both dropdowns with the same data
            data.forEach(item => {
                const empOption = document.createElement('option');
                empOption.value = item.empId;
                empOption.textContent = item.fullName;
                empDropdown.appendChild(empOption);
            });
        }





        function GetSpacialCase() {
            ApiCall(getSpCApplicationUrl, token)
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

             let serialNumber = 1; 
             const defaultImage = '../user_img_default.jpg'; 

             data.forEach(row => {
                 row.serial = serialNumber++; 
                 const imgUrl = '../../EmployeeImages/Images/';
                 const empPicture = row.empPicture ? imgUrl + row.empPicture : defaultImage;

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
                 row.status = row.status === null
                     ? '<span class="badge-leave bg-onlyme">Pending</span>'
                     : row.status === 0
                         ? '<span class="badge-leave bg-warning">Processing</span>'
                         : row.status === 1
                             ? '<span class="badge-leave bg-success">Approve</span>'
                             : row.status === 2
                                 ? '<span class="badge-leave bg-rejected">Reject</span>'
                                 : '<span class="badge-leave bg-secondary">NA</span>';
             });

             const columns = [
                 { "name": "serial", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" }, 
                    { "name": "empPicture", "title": "User", "className": "userDatatable-content" }, 
                 { "name": "typeName", "title": "Case Type", "className": "userDatatable-content" },
                 { "name": "inTime", "title": "In-Time", "className": "userDatatable-content" },
                 { "name": "outTime", "title": "Out-Time", "className": "userDatatable-content" },
                 { "name": "appiedDate", "title": "Apply Date", "className": "userDatatable-content" },
                 { "name": "status", "title": "Status", "className": "userDatatable-content" },
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
                 }).on('postinit.ft.table', function (e) {
                     $('.footable-loader').hide();
                 });
             } catch (error) {
                 console.error("Error initializing Footable:", error);
             }


             $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                 const id = $(this).data('id');
                 Delete(id);
                 console.log('Delete button clicked for ID:', id);
             });

             $('.adv-table').off('click', '.view-btn').on('click', '.view-btn', function () {
                 const id = $(this).data('id');
                 FetchDataForView(id);
                 console.log('View button clicked for ID:', id);
              });

            }

            async function PostCase(IsSave) {
                let empId = null;
                let companyId = null;

                if (DataAccessLevel === 1) {
                    empId = loginempId;
                    companyId = CompanyID;
                } else {
                    empId = $('#ddlEmpName').val();
                    companyId = $('#ddlCompany').val();
                }

                let caseType = parseInt($('#ddlCaseType').val()) || 0;
                let purpose = $('#txtPurposeOfOutDuty').val().trim();
                let date = $('#datepicker').val();
                let inTime = $('#inTimepicker').val();
                let outTime = $('#OutTimepicker').val();

                // Apply date formatting
                let formattedDate = null;
                if (date && date.trim() !== '') {
                    let dateObj = new Date(date);
                    formattedDate = dateObj.toISOString().split('T')[0];
                }

                let now = new Date();
                let appliedDate = now.toISOString(); // Full ISO for audit trail

                let postData = {
                    empId: empId,
                    date: formattedDate,
                    type: caseType,
                    remark: purpose,
                    status: 0,
                    processing: 0,
                    appliedBy: userId,
                    appliedDate: appliedDate,
                    inTime: inTime,
                    outTime: outTime,
                    compnayId: companyId
                };

                try {
                    const loaderLeaveSave = $(".loaderLeaveSave");
                    loaderLeaveSave.show();

                    let response = await ApiCallPost(PostCaseUrl, token, postData);
                    if (response && response.statusCode === 200) {   
                    loaderLeaveSave.hide();
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: 'Case submitted successfully!'
                        }).then(result => {
                            if (result.isConfirmed) {
                                // Optional: reload or reset form
                                // ResetForm();
                                GetSpacialCase();
                            }
                        });
                        return true;
                    } else if (response && response.statusCode === 400) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Validation Error',
                            text: 'Please check your input and try again.'
                        });
                        return false;
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An error occurred. Please try again.'
                        });
                        return false;
                    }
                } catch (error) {
                    loaderLeaveSave.hide();
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to submit the case. Please try again.'
                    });
                    console.error("Case Entry API Error:", error);
                    return false;
                }
            }



        function Delete(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "Do you really want to delete this Leave?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    ApiDeleteById(getSpcDeleteUrl, token, id)
                        .then(function (response) {
                            // Check if the status code is 200
                            if (response.statusCode === 200) {
                                Swal.fire({
                                    title: 'Success!',
                                    text:'Case deleted successfully.',
                                    icon: 'success',
                                    confirmButtonText: 'OK'
                                }).then(() => {
                                   GetSpacialCase();
                                });
                            }
                            else if (response.statusCode === 401) {
                                Swal.fire({
                                    title: 'Error!',
                                    text: 'The Case is already being processed, so it cannot be deleted.',
                                    icon: 'error',
                                    confirmButtonText: 'OK'
                                }).then(() => {
                                    GetLeaves();
                                });
                            }
                            else if (response.statusCode === 402) {
                                Swal.fire({
                                    title: 'Error!',
                                    text: 'The Case is already being Approved, so it cannot be deleted.',
                                    icon: 'error',
                                    confirmButtonText: 'OK'
                                }).then(() => {
                                    GetLeaves();
                                });
                            }
                            else if (response.statusCode === 403) {
                                Swal.fire({
                                    title: 'Error!',
                                    text: 'The Case is already being Rejected, so it cannot be deleted.',
                                    icon: 'error',
                                    confirmButtonText: 'OK'
                                }).then(() => {
                                    GetSpacialCase();
                                });
                            }
                        })
                        .catch(function (error) {
                            // Handle different status codes
                            if (error.response && error.response.statusCode === 400) {
                                Swal.fire({
                                    title: 'Error!',
                                    text: error.response.data.message || 'Bad request while deleting the package.',
                                    icon: 'error',
                                    confirmButtonText: 'OK'
                                });
                            } else {
                                Swal.fire({
                                    title: 'Error!',
                                    text: 'An unexpected error occurred while deleting the package.',
                                    icon: 'error',
                                    confirmButtonText: 'OK'
                                });
                            }
                        });
                }
            });
        }




        function FetchDataForView(Id) {
            ApiCall(getLeaveByIdUrl, token)
                .then(function (responseData) {
                    var data = responseData.data[0]; 
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
                <p><strong>Handed Over Employee ID:</strong> ${data.handedOverEmpName}</p>
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
