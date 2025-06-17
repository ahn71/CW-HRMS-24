<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="roster-entry.aspx.cs" Inherits="SigmaERP.hrms.attendance.roster.roster_entry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
            .packagesTable {
                padding: 0 !important;
            }

            td {
                text-align: left;
            }

            .w-100 {
                width: 100%;
            }

            .justify-between {
                justify-content: space-between;
            }

            .me-2 {
                margin-right: 0.5rem;
            }

            i {
                margin-right: 0 !important;
            }
             label{
                 margin-left: 0 !important;
             }
             .row > *{
                 margin-top: 0 !important;
             }
         .loaderDaily {
             position: absolute;
             left: 50%;
             top: 8%;

         }
         .user-role{
             font-size:10px !important;
         }
        </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <div class="mt-1">
        <div class="products_page product_page--grid mb-30">
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-lg-3 col-sm-12 mb-lg-0 mb-30">
                        <div class="card">
                            <div id="toggleFilter" class="card-header px-20 py-15" style="cursor: pointer;">
                                <h6 class="d-flex justify-between align-items-center fw-500 w-100">
                                    <span class="d-flex align-items-center" style="font-size:16px; color:black";>
                                        <img src="../img/svg/sliders.svg" alt="sliders" class=" me-2" style="height: 16px !important; width: 16px !important">
                                        Filter bye Unit
                                    </span>
                                    <i id="arrowIcon" class="fas fa-chevron-down"></i> <!-- Arrow icon -->
                                </h6>
                            </div>
                            <div class="card-body">
                                <aside class="">
                                    <div class="card border-0 shadow-none multi-collapse mt-10 collapse show" id="multiCollapseExample1">
                                        <div class="product-brands" overflow-y: auto;">
                                            <ul id="UnitList">
                                              
                                            </ul>
                                        </div>
                                    </div>
                                </aside>
                            </div>
                        </div>
                        <div class="card mt-1">
                            <div id="toggleDepartment" class="card-header px-20 py-15" style="cursor: pointer;">
                                <h6 class="d-flex justify-between align-items-center fw-500 w-100">
                                    <span class="d-flex align-items-center"  style="font-size:16px; color:black";>
                                        <img src="../img/svg/sliders.svg" alt="sliders" class=" me-2"  style="height: 16px !important; width: 16px !important">
                                        Filter bye Department
                                    </span>
                                    <i id="arrowIcondpt" class="fas fa-chevron-down"></i>
                                </h6>
                            </div>
                            <div class="card-body">
                                <aside class="">
                                    <div class="card border-0 shadow-none multi-collapse mt-10 collapse show" id="multiCollapseExample2">
                                        <div class="product-brands"  overflow-y: auto;">
                                            <ul id="departmentList">
                                            </ul>
                                        </div>
                                    </div>
                                </aside>
                            </div>
                        </div>
                    </div>
                    <div class=" col-lg-9 mt-xl-0 mt-lg-30">

                        <div class="row product-page-list justify-content-center">
                            <div class="col-12 mb-25 px-10">
                                <div class="card">
                                    <div class="card-body position-relative mt-3" style="padding-top: 15px !important;">

                                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                                            <div class="loaderparent">
                                                <div class="ad-table-table__header d-flex justify-content-between mb-15">
                                                    <div class="container-fluid" style="padding-left:0px !important; padding-right:0px !important">
                                                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3 align-items-end">

                                                            <div class="col-lg-4 d-flex">
                                                                <div class="col-lg-5">
                                                                    <label for="txtSearch" class="form-label mb-1 p-0">Permanent Shift</label>
                                                                    <div class="input-group">
                                                                        <select name="ddlShift" id="ddlShift" class="form-control me-2">
                                                                        </select>
                                                                    </div>
                                                                </div>


                                                                <div class="col-lg-5">
                                                                    <label for="txtSearch" class="form-label mb-1 p-0">Employee ID</label>
                                                                    <div class="input-group">
                                                                        
                                                                          <%--  <i class="uil uil-search"></i>--%>
                                                                        
                                                                        <input type="text" id="txtEmpCardNo" class="form-control border-start-0" placeholder="Employee ID..." aria-describedby="searchIcon">
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-2" style="margin-left:5px">
                                                                    <label for="txtSearch" class="form-label mb-1 p-0" style="opacity:0"> ID</label>
                                                                    <div class="input-group">
                                                                           <button type="button" title="Search" id="btnSearch" onclick="SearchEmployee()"
                                                                        class="btn btn-primary text-center"
                                                                        style="padding: 7px;">
                                                                        <i class="fas fa-search" style="font-size: 18px"></i>
                                                                    </button>
                                                                    </div>
                                                                </div>
                                                                
                                                            </div>
                                                            <div style="display:none" id="DataSubmitContainer" class="col-lg-8">
                                                            <div  class=" d-flex">
                                                                <div class="col-lg-3">
                                                                    <label for="txtStartDate" class="form-label mb-1 p-0">Start Date</label>
                                                                    <input type="date" id="txtStartDate" class="form-control" aria-describedby="passwordHelpInline">
                                                                </div>
                                                                <div class="col-lg-3">
                                                                    <label for="txtEndDate" class="form-label mb-1 p-0">End Date</label>
                                                                    <input type="date" id="txtEndDate" class="form-control" aria-describedby="passwordHelpInline">
                                                                </div>
                                                                <div class="col-lg-4" style="margin-left:5px">
                                                                    <label for="txtSearch" class="form-label mb-1 p-0">New Shift</label>
                                                                    <div class="input-group">
                                                                        <select name="ddlNewShift" id="ddlNewShift" class="form-control me-2">
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-2" style="margin-left:5px">
                                                                    <label for="txtSearch" class="form-label mb-1 p-0" style="opacity: 0">New Shift</label>
                                                                    <div class="input-group">
                                                                        <button type="button" onclick="RosterSubmit()" title="Processing" id="btnProcessing"
                                                                            class="btn btn-sm btn-success d-flex align-items-center justify-content-center"
                                                                            style="height: 36px;">
                                                                            <%--<i class="uil uil-save" style="font-size: 20px"></i>--%>Submit
                                                                        </button>
                                                                    </div>
                                                                </div>


                                                            </div>

                                                          </div>
    

                                                        </div>
                                                    </div>
                                                    <%--Close--%>
                                                </div>




                                                <div class="loader-size loaderDaily" style="display:none">
                                                    <div class="dm-spin-dots  dot-size dot-sizedot-sizedot-sizedot-size spin-sm">
                                                        <span class="spin-dot badge-dot dot-primary"></span>
                                                        <span class="spin-dot badge-dot dot-primary"></span>
                                                        <span class="spin-dot badge-dot dot-primary"></span>
                                                        <span class="spin-dot badge-dot dot-primary"></span>
                                                    </div>
                                                </div>

                                                <div id="alertContainer" class="alert alert-info text-center mt-3" role="alert" style="height: 200px">
                                                    <strong>Note:</strong> Please filter employees first before setting up the Roster.
                                                </div>
                                                <div id="employeeContainer">
                                                      <table class="table mb-0 packagesTable table-borderless adv-table"
                                                    data-sorting="true" data-filtering="false" data-paging="true" data-paging-size="25">
                                                </table>
                                                </div>

                                

            


                                            </div>
                                        </div>
             
                                    </div>

     
                             
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
         </div>

        <script>
            var rootUrl = '<%= Session["__RootUrl__"]%>';
            var CompanyID = '<%= Session["__GetCompanyId__"]%>';
            var IsAdministrator = '<%= Session["__GetISAdministetor__"]%>';
            var getEmployeeeUrl = `${rootUrl}/api/Employee/employees`;

            var getDepartmentUrl = `${rootUrl}/api/Department/basicInfo/${CompanyID}`;
            var getUnitUrl = `${rootUrl}/api/Unit/basicInfo?CompanyId=${CompanyID}`;
            var getShiftsUrl = `${rootUrl}/api/Shift/basicInfo?CompanyId=${CompanyID}`;
            var PostRosterURL = `${rootUrl}/api/Roster/roster/create`;



            var token = '<%= Session["__UserToken__"] %>';


            $(document).ready(function () {

               // GetEmployees();

               // $('#DataSubmitContainer').hide();
                $('#toggleFilter').on('click', function () {
                    unitToggle();
                });

                $('#toggleDepartment').on('click', function () {
                    DepartmentToggle();
                });

                GetShifts();
                GetNewShifts();
                GetUnit();
                GetDepartment();
             

            });


            function unitToggle() {
                const unitList = $('#UnitList');
                const arrowIcon = $('#arrowIcon');

                unitList.toggle();

                if (unitList.is(':visible')) {
                    arrowIcon.removeClass('fa-chevron-up').addClass('fa-chevron-down');
                } else {
                    arrowIcon.removeClass('fa-chevron-down').addClass('fa-chevron-up');
                }
            }


            function DepartmentToggle() {
                const unitList = $('#departmentList');
                const arrowIcon = $('#arrowIcondpt');

                unitList.toggle(); // Corrected variable

                if (unitList.is(':visible')) {
                    arrowIcon.removeClass('fa-chevron-up').addClass('fa-chevron-down');
                } else {
                    arrowIcon.removeClass('fa-chevron-down').addClass('fa-chevron-up');
                }
            }


            function formatDate(date) {
                const day = String(date.getDate()).padStart(2, '0');
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const year = date.getFullYear();
                return `${year}-${month}-${day}`;
            }
            function SearchEmployee() {


                GetEmployees();

            }

            function GetEmployees() {
                const EmpCardNo = $('#txtEmpCardNo').val();
                const Shift = $('#ddlShift').val();
                const deptQuery = getSelectedDepartmentQuery(); // returns something like: "DptIds=1&"
                const unitQuery = getSelectedUnitQuery(); // not used below — include if needed

                let empCardNo = '';
                if (EmpCardNo && EmpCardNo.length > 0) {
                    empCardNo = `&EmpCardNo=${EmpCardNo}`;
                }

                let shiftId = '';
                if (Shift !== null && Shift !== 'null') {
                    shiftId = `&SftId=${Shift}`;
                }
               $('.loaderDaily').show();
               $('.loaderparent').css('opacity', '0.5');
                const url = `${getEmployeeeUrl}?CompanyId=${CompanyID}&${deptQuery}${empCardNo}${shiftId}&DeautyType=Roster`;

                ApiCall(url, token)
                    .then(response => {
                        if (response.statusCode === 200) {
                            const message = `Weekend employee data loaded for the period:`;
                            $('#alertContainer').hide();
                            $('#DataSubmitContainer').show();
                            $('.loaderDaily').hide();
                            $('.loaderparent').css('opacity', '1');
                            bindTableData(response.data);
                       
                        } else {
                            console.error('API Error:', response.message);
                            bindTableData([]);
                            $('.loaderDaily').hide();
                            $('.loaderparent').css('opacity', '1');
                        }
                    })
                    .catch(error => {
                        console.error('Network Error:', error);
                        bindTableData([]);
                        $('.loaderDaily').hide();
                        $('.loaderparent').css('opacity', '1');
                    });
            }


            let allEmployeeData = [];
            const selectedEmployeeIds = new Set();

            function bindTableData(data) {
                const $table = $('.adv-table');
                const defaultImage = '/hrms/user_img_default.jpg';

                allEmployeeData = data;
                if ($table.data('footable')) {
                    $table.data('footable').destroy();
                }

                $table.html('');
                data.forEach((row, index) => {
                    row.serial = index + 1;
                    row.userImage = null;
                    const userImage = row.empImage || defaultImage;

            //        row.action = `
            //<div class="actions">
            //    <ul class="">
            //        <li>
            //            <a href="javascript:void(0)"
            //             data-emp-id="${row.empId}" 
            //             data-emp-type="${row.empType}" 
            //             class="btn btn-primary btn-sm text-white delete-btn remove">
            //                <i class="uil uil-money-insert"></i>Set Salary
            //            </a>
            //        </li>
            //    </ul>
            //</div>`;
                    row.userImage = `
            <div class="user-details-container d-flex align-items-center">
                <img src="${userImage}" alt="User Image" class="user-image" style="width: 25px; height: 25px; margin-right: 10px;">
                <div>
                    <a href="javascript:void(0)" class="user-name" data-id="${row.empId}">${row.empName}</a>
                    <div class="user-role">${row.dptName},${row.dsgName}</div>
                    <div class="user-role"></div>
                </div>
            </div>
        `.trim();

                    row.select = `
            <input type="checkbox" class="EmployeerowCheckbox" data-id="${row.empId}" value="${row.empId}"
                ${selectedEmployeeIds.has(row.empId) ? 'checked' : ''} />
        `;
                });

                const columns = [
                    {
                        name: "select",
                        title: `<input type="checkbox" id="selectAllEmployee" />`,
                        className: "text-center",
                        sortable: false,
                        type: "html"
                    },
                    { name: "serial", title: "SL", breakpoints: "xs sm", type: "number", className: "userDatatable-content" },
                    { name: "userImage", title: "Name", className: "userDatatable-content", type: "html" },
                    { name: "empCardNo", title: "Emp. ID", className: "userDatatable-content" },
                    { name: "empType", title: "Emp Type", className: "userDatatable-content" },
                    { name: "shift", title: "P. Shift", className: "userDatatable-content" },
                    { name: "joiningDate", title: "Joining Date", className: "userDatatable-content" },
                    //{ name: "deautyType", title: "D. Type", className: "userDatatable-content" },
                    //{ name: "newWeekend", title: "New Weekend", className: "userDatatable-content" },
                    //{ name: "action", title: "Action", className: "userDatatable-content" }
                ];

                try {
                    $table.footable({
                        columns: columns,
                        rows: data,
                        filtering: { enabled: false },
                        paging: { enabled: true, size: 25 },
                        sorting: true
                    }).on('postinit.ft.table', function () {
                        $('.footable-loader').hide();
                        updateSelectAllCheckbox();
                    });


                } catch (error) {
                    console.error("Error initializing table:", error);

                }

                let selectedEmpId = null;
                let selectedEmpType = null;

                $(document).off('click', '.delete-btn').on('click', '.delete-btn', function () {
                    selectedEmpId = $(this).data('emp-id');
                    selectedEmpType = $(this).data('emp-type');

                    $('#empIdField').val(selectedEmpId);

                    // Optional: You can store the empType in a hidden field too
                    $('#empTypeField').val(selectedEmpType); 

                    console.log(selectedEmpType)
                    console.log(selectedEmpId)

                    $('#salaryModal').modal('show');
                });

           



            }


            $(document).on('change', '#selectAllEmployee', function () {
                const isChecked = $(this).is(':checked');
                allEmployeeData.forEach(emp => {
                    if (isChecked) {
                        selectedEmployeeIds.add(emp.empId);
                       
                    } else {
                        selectedEmployeeIds.delete(emp.empId);
                         
                    }
                });
                bindTableData(allEmployeeData);
            });

            $(document).on('change', '.EmployeerowCheckbox', function () {
                const empId = $(this).val();
                if ($(this).is(':checked')) {
                    selectedEmployeeIds.add(empId);
                   
                } else {
                    selectedEmployeeIds.delete(empId);
                }

                updateSelectAllCheckbox();
            });

            function updateSelectAllCheckbox() {
                const allIds = allEmployeeData.map(emp => emp.empId);
                const isAllSelected = allIds.every(id => selectedEmployeeIds.has(id));
                $('#selectAllEmployee').prop('checked', isAllSelected);
               

            }

            function getSelectedEmployeeQuery() {
                return Array.from(selectedEmployeeIds).map(id => `empIds=${id}`).join('&');
            }


            function GetUnit() {
                ApiCall(getUnitUrl, token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            var responseData = response.data;
                            console.log('Before table Data Bind', responseData);

                            bindUnits(responseData);

                            console.log('after Table Data Bind ', responseData);
                        } else {
                            console.error('Error occurred while fetching data:', response.message);
                        }
                    })
                    .catch(function (error) {
                        $('.loaderCosting').hide();
                        console.error('Error occurred while fetching data:', error);
                    });
            }

            function bindUnits(units) {
                const $list = $('#UnitList');
                $list.empty(); // Clear existing list

                // Add "Select All" checkbox
                const selectAllItem = `
        <li>
            <div class="checkbox-theme-default custom-checkbox">
                <input type="checkbox" id="selectAllUnits">
                <label for="selectAllUnits">
                    <span class="checkbox-text" style="margin-left:20px">
                        Select All
                    </span>
                </label>
            </div>
        </li>
    `;
                $list.append(selectAllItem);

                // Add unit checkboxes
                units.forEach((unit, index) => {
                    const checkboxId = `unit-check-${index}`;
                    const listItem = `
            <li>
                <div class="checkbox-theme-default custom-checkbox">
                    <input type="checkbox" class="unitCheckbox" id="${checkboxId}" value="${unit.id}">
                    <label for="${checkboxId}">
                        <span class="checkbox-text" style="margin-left:20px">
                            ${unit.name}
                        </span>
                    </label>
                </div>
            </li>
        `;
                    $list.append(listItem);
                });
            }

            // Event listener for "Select All" functionality
            $(document).on('change', '#selectAllUnits', function () {
                const isChecked = $(this).is(':checked');
                $('.unitCheckbox').prop('checked', isChecked);
            });

            // Sync "Select All" when individual checkboxes are clicked
            $(document).on('change', '.unitCheckbox', function () {
                const total = $('.unitCheckbox').length;
                const checked = $('.unitCheckbox:checked').length;
                $('#selectAllUnits').prop('checked', total === checked);
            });

            // Optional: function to get selected unit IDs as query string
            function getSelectedUnitQuery() {
                return $('.unitCheckbox:checked')
                    .map(function () {
                        return 'UnitIds=' + $(this).val();
                    })
                    .get()
                    .join('&');
            }



            function GetDepartment() {
                ApiCall(getDepartmentUrl, token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            var responseData = response.data;
                            console.log('Before table Data Bind', responseData);

                            bindDepartments(responseData);

                            console.log('after Table Data Bind ', responseData);
                        } else {
                            console.error('Error occurred while fetching data:', response.message);
                        }
                    })
                    .catch(function (error) {
                        $('.loaderCosting').hide();
                        console.error('Error occurred while fetching data:', error);
                    });
            }



            function bindDepartments(departments) {
                const $list = $('#departmentList');
                $list.empty();
                const selectAllItem = `
                <li>
                    <div class="checkbox-theme-default custom-checkbox">
                        <input type="checkbox" id="selectAllRows">
                        <label for="selectAllRows">
                            <span class="checkbox-text" style="margin-left:20px">
                               Select All 
                            </span>
                        </label>
                    </div>
                </li>
            `;
                $list.append(selectAllItem);
                departments.forEach((dept, index) => {
                    const checkboxId = `dept-check-${index}`;
                    const listItem = `
                    <li>
                        <div class="checkbox-theme-default custom-checkbox">
                            <input type="checkbox" class="rowCheckbox" id="${checkboxId}" value="${dept.dptId}">
                            <label for="${checkboxId}">
                                <span class="checkbox-text" style="margin-left:20px">
                                    ${dept.dptName}
                                </span>
                            </label>
                        </div>
                    </li>
                `;
                    $list.append(listItem);
                });
            }
            $(document).on('change', '#selectAllRows', function () {
                const isChecked = $(this).is(':checked');
                $('.rowCheckbox').prop('checked', isChecked);
            });

            $(document).on('change', '.rowCheckbox', function () {
                const total = $('.rowCheckbox').length;
                const checked = $('.rowCheckbox:checked').length;
                $('#selectAllRows').prop('checked', total === checked);
            });


            function getSelectedDepartmentQuery() {
                return $('.rowCheckbox:checked')
                    .map(function () {
                        return 'DptIds=' + $(this).val();
                    })
                    .get()
                    .join('&');
            }



            function GetShifts() {
                ApiCall(getShiftsUrl, token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            var responseData = response.data;
                             PopulateDropdown(responseData);
                        } else {
                            console.error('Error occurred while fetching data:', response.message);
                        }
                    })
                    .catch(function (error) {
                        $('.loaderCosting').hide();
                        console.error('Error occurred while fetching data:', error);
                    });
            }


            function PopulateDropdown(data) {
                const dropdown = document.getElementById('ddlShift');
                dropdown.innerHTML = '<option value="null">---Select---</option>';

                data.forEach(item => {
                    const option = document.createElement('option');
                    option.value = item.id; 
                    option.textContent = item.name; 
                    dropdown.appendChild(option);
                });

            }

            function GetNewShifts() {
                ApiCall(getShiftsUrl, token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            var responseData = response.data;
                            PopulateNewDropdown(responseData);
                        } else {
                            console.error('Error occurred while fetching data:', response.message);
                        }
                    })
                    .catch(function (error) {
                        $('.loaderCosting').hide();
                        console.error('Error occurred while fetching data:', error);
                    });
            }


            function PopulateNewDropdown(data) {
                const dropdown = document.getElementById('ddlNewShift');
                dropdown.innerHTML = '<option value="null">---Select---</option>';

                data.forEach(item => {
                    const option = document.createElement('option');
                    option.value = item.id;
                    option.textContent = item.name;
                    dropdown.appendChild(option);
                });

            }

           function RosterSubmit() {
            const startDate = $('#txtStartDate').val();
            const endDate = $('#txtEndDate').val();
            const Shift  = $('#ddlNewShift').val();
            const employeeQuery = getSelectedEmployeeQuery();

           const urlParams = new URLSearchParams(employeeQuery);
           const empIds = urlParams.getAll('empIds');


           const formData = new FormData();
           formData.append('fromDate', startDate);
           formData.append('toDate', endDate);
           formData.append('shiftId', Shift);
           formData.append('companyId', CompanyID);
           empIds.forEach((id, index) => {
               formData.append(`empIds[${index}]`, id);
           });
               if (!startDate) {
                   Swal.fire({
                       icon: 'warning',
                       title: 'Start Date Required',
                       text: 'Please select a Start Date.',
                       confirmButtonText: 'OK'
                   });
                   return;
               }

               if (!endDate) {
                   Swal.fire({
                       icon: 'warning',
                       title: 'End Date Required',
                       text: 'Please select an End Date.',
                       confirmButtonText: 'OK'
                   });
                   return;
               }

               if (Shift=='null') {
                   Swal.fire({
                       icon: 'warning',
                       title: 'Shift Required',
                       text: 'Please select New Shift.',
                       confirmButtonText: 'OK'
                   });
                   return;
               }

               if (empIds.length === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'No Employee Selected',
                    text: 'Please select Employee.',
                    confirmButtonText: 'OK'
                });
                return;
               }
               $('.loaderDaily').show();
               $('.loaderparent').css('opacity', '0.5');
            ApiCallPostForm(
                PostRosterURL,
                token,
                formData
            )
                .then(response => {
                    if (response.statusCode === 200) {
                        console.log('Roster Create Success');
                        $('.loaderDaily').hide();
                        $('.loaderparent').css('opacity', '1');
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: `The roster has been successfully created from ${startDate} to ${endDate}.`,
                            confirmButtonText: 'OK'
                        });

                    } else {
                        console.error('API Error:', response.message);
                        $('.footable-loader').hide();
                        $('.loaderDaily').hide();
                        $('.loaderparent').css('opacity', '1');
                        //$('#progress-section').hide();
                    }
                })
                .catch(error => {
                    console.error('Network Error:', error);
                    $('.footable-loader').hide();
                    $('.loaderparent').css('opacity', '1');
                    //$('#progress-section').hide();
                });
        }


        </script>
<%--    <script src="../../assets/theme_assets/js/loadCompany.js"></script>
    <script src="../../assets/theme_assets/js/apiHelper.js"></script>--%>

    
    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="../assets/theme_assets/js/apiHelper.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</asp:Content>
