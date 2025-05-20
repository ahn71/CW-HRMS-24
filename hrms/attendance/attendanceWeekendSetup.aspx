<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="attendanceWeekendSetup.aspx.cs" Inherits="SigmaERP.hrms.attendance.attendanceWeekendSetup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
         .packagesTable{
            padding :0 !important;
        }
        td{
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                                    <!-- Arrow icon -->
                                </h6>
                            </div>
                            <div class="card-body">
                                <aside class="">
                                    <div class="card border-0 shadow-none multi-collapse mt-10 collapse show" id="multiCollapseExample2">
                                        <div class="product-brands"  overflow-y: auto;">
                                            <ul id="departmentList">
                                                <!-- Checkboxes will be injected here -->
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
                                <div class="card ">
                                    <div class="card-body position-relative" style="padding-top: 15px !important;">

                                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                                            <div class="table-responsive">
                                                <div class="ad-table-table__header d-flex justify-content-between mb-15">
                                                    <%--Table Search Area--%>
                                                    <div class="container-fluid" style="padding-left:0px !important; padding-right:0px !important">
                                                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3 align-items-end">

                                                            <!-- Search Input -->

                                                            <div class="col-lg-2">
                                                                <label for="txtSearch" class="form-label mb-1 p-0">Search by</label>
                                                                <div class="input-group">
                                                                    <select name="ddlSearchType" id="ddlSearchBye" class="form-control me-2">
                                                                        <option value="Day">Day Wise </option>
                                                                        <option value="Dates">Date Wise</option>
                                                                    </select>
                                                                </div>
                                                            </div>


                                                            <div class="col-lg-2">
                                                                <label for="txtSearch" class="form-label mb-1 p-0">Employee ID</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-text bg-white border-end-0">
                                                                        <i class="uil uil-search"></i>
                                                                    </span>
                                                                    <input type="text" id="txtEmpCardNo" class="form-control border-start-0" placeholder="Employee ID..." aria-describedby="searchIcon">
                                                                </div>
                                                            </div>

                                                            <!-- Start Date -->
                                                                <div class="col-lg-2 day-wise-field" >
                                                                    <label for="txtStartDate" class="form-label mb-1 p-0">Start Date</label>
                                                                    <input type="date" id="txtStartDate" class="form-control">
                                                                </div>

                                                                <div class="col-lg-2 day-wise-field" >
                                                                    <label for="txtEndDate" class="form-label mb-1 p-0">End Date</label>
                                                                    <input type="date" id="txtEndDate" class="form-control">
                                                                </div>

                                                                <div class="col-lg-2 day-wise-field">
                                                                    <label for="ddlWeekend" class="form-label mb-1 p-0">Weekend</label>
                                                                    <select name="ddlWeekend" id="ddlWeekend" class="form-control me-2"> 
                                                                        <option value="0">---Select---</option>
                                                                        <option value="Saturday">Saturday</option>
                                                                        <option value="Sunday">Sunday</option>
                                                                        <option value="Monday">Monday</option>
                                                                        <option value="Tuesday">Tuesday</option>
                                                                        <option value="Wednesday">Wednesday</option>
                                                                        <option value="Thursday">Thursday</option>
                                                                        <option value="Friday">Friday</option>
                                                                        
                                                                    </select>
                                                                </div>

                                                            <div class="col-lg-2 date-wise-field" style="display: none">
                                                                <label for="txtWeekendDate" class="form-label mb-1 p-0">Date</label>
                                                                <input type="date" id="txtWeekendDate" class="form-control">
                                                            </div>





                                                            <!-- End Date + Search Button -->
                                                            <div class="col-lg-2 d-flex gap-2">
                                                                    <button type="button" title="Search" id="btnSearch" onclick="SearchEmployee()"
                                                                        class="btn btn-sm btn-primary d-flex align-items-center justify-content-center"
                                                                        style="height: 36px; width: 36px;">
                                                                        <i class="fas fa-search"></i>
                                                                    </button>

                                                                 <button type="button" onclick="onClickSaveWeekend()" title="Processing" id="btnProcessing"
                                                                        class="btn btn-sm btn-success d-flex align-items-center justify-content-center"
                                                                        style="height: 36px; width: 36px;">
                                                                        <i class="uil uil-save" style="font-size: 20px"></i>
                                                                    </button>
                                                                
                                                            </div>



                                                       
    

                                                        </div>
                                                    </div>
                                                    <%--Close--%>
                                                </div>

                                                <div id="employeeContainer">
                                                      <table class="table mb-0 packagesTable table-borderless adv-table"
                                                    data-sorting="true" data-filtering="false" data-paging="true" data-paging-size="10">
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
        var getEmployeeDayWiseUrl = `${rootUrl}/api/WeekendSetup/getDaywiseEmployeeForWeekend`;
        var getEmployeeDateWiseUrl = `${rootUrl}/api/WeekendSetup/getDatewiseEmployeeForWeekend`;
        var PostDateWiseWeekendSetupURL = `${rootUrl}/api/WeekendSetup/save/datewiseWeekendsetup`;
        var PostDayWiseWeekendSetupURL = `${rootUrl}/api/WeekendSetup/save/daywiseWeekendsetup`;
        var DeleteDateWiseUrl = `${rootUrl}/api/WeekendSetup/delete/datewiseweekennd1`;

        var getDepartmentUrl = `${rootUrl}/api/Department/basicInfo/${CompanyID}`;
        var getUnitUrl = `${rootUrl}/api/Unit/basicInfo?CompanyId=${CompanyID}`;
      


        var token = '<%= Session["__UserToken__"] %>';
     

            $(document).ready(function () {

                $('#ddlSearchBye').on('change', function () {
                    var selected = $(this).val();

                    if (selected === 'Day') {
                        $('.day-wise-field').show();
                        $('.date-wise-field').hide();
                    } else if (selected === 'Dates') {
                        $('.day-wise-field').hide();
                        $('.date-wise-field').show();
                    } else {
                        // If "---Select---"
                        $('.day-wise-field').hide();
                        $('.date-wise-field').hide();
                    }
                });



                $('#toggleFilter').on('click', function () {
                    unitToggle();
                });

             $('#toggleDepartment').on('click', function () {
                            DepartmentToggle();
              });

            const today = new Date();
            const formattedDate = formatDate(today);

            $('#txtStartDate').val(formattedDate);
                $('#txtEndDate').val(formattedDate);

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
            var searchType = $('#ddlSearchBye').val();

            if (searchType === 'Day') {
                GetEmployeeDayWise();
            } else {
                GetEmployee_DateWise();
            }
        }




        function showAttendanceHideEmployee() {
            $('#attendanceContainer').hide();
        }


        function GetEmployee_DateWise() {
            const HolyDayDate = $('#txtWeekendDate').val();
            const EmpCardNo = $('#txtEmpCardNo').val();
            const deptQuery = getSelectedDepartmentQuery();
            const unitQuery = getSelectedUnitQuery();

            const url = `${getEmployeeDateWiseUrl}/${CompanyID}/${HolyDayDate}?cardNum=${EmpCardNo}&${deptQuery}&${unitQuery}`;

            ApiCall(url, token)
                .then(response => {
                    if (response.statusCode === 200) {
                        bindTableData(response.data);
                    } else {
                        console.error('API Error:', response.message);
                    }
                })
                .catch(error => {
                    console.error('Network Error:', error);
                });
        }

        function GetEmployeeDayWise() {
            const startDate = $('#txtStartDate').val();
            const endDate = $('#txtEndDate').val();
            const weekendDate = $('#ddlWeekend').val();
            const EmpCardNo = $('#txtEmpCardNo').val();
            const deptQuery = getSelectedDepartmentQuery();
            const unitQuery = getSelectedUnitQuery();

            const url = `${getEmployeeDayWiseUrl}/${CompanyID}/${startDate}/${endDate}?weekendDay=${weekendDate}&cardNum=${EmpCardNo}&${deptQuery}&${unitQuery}`;

            ApiCall(url, token)
                .then(response => {
                    if (response.statusCode === 200) {
                        bindTableData(response.data);
                    } else {
                        console.error('API Error:', response.message);
                    }
                })
                .catch(error => {
                    console.error('Network Error:', error);
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

                row.action = `
            <div class="actions">
                <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                    <li>
                        <a href="javascript:void(0)" data-id="${row.empId}" class="delete-btn remove">
                            <i class="uil uil-trash-alt"></i>
                        </a>
                    </li>
                </ul>
            </div>`;
                row.userImage = `
            <div class="user-details-container d-flex align-items-center">
                <img src="${userImage}" alt="User Image" class="user-image" style="width: 40px; height: 40px; margin-right: 10px;">
                <div>
                    <a href="javascript:void(0)" class="user-name" data-id="${row.empId}">${row.empName}</a>
                    <div class="user-role">${row.desingation}</div>
                    <div class="user-role">${row.department}</div>
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
                { name: "empcard", title: "Employee ID", className: "userDatatable-content" },
                { name: "lastWeekend", title: "Last Weekend", className: "userDatatable-content" },
                { name: "currentWeekend", title: "Current Weekend", className: "userDatatable-content" },
                { name: "newWeekend", title: "New Weekend", className: "userDatatable-content" },
                { name: "action", title: "action", className: "userDatatable-content" }
            ];

            try {
                $table.footable({
                    columns: columns,
                    rows: data,
                    filtering: { enabled: false },
                    paging: { enabled: true, size: 10 },
                    sorting: true
                }).on('postinit.ft.table', function () {
                    $('.footable-loader').hide();
                    updateSelectAllCheckbox();
                    });


            } catch (error) {
                console.error("Error initializing table:", error);
            }

                $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                const userRoleId = $(this).data('id');
                Delete(userRoleId); // Custom function to handle delete logic
                console.log('Delete button clicked for userRoleId:', userRoleId);
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
                            $('.footable-loader').show();
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
                        $('.footable-loader').show();
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

            function onClickSaveWeekend() {
                var searchType = $('#ddlSearchBye').val();

                if (searchType === 'Day') {
                    Day_WiseEmpWeekendSetup();
                } else {
                    DateWiseEmpWeekendSetup();
                }
            }

            function Day_WiseEmpWeekendSetup() {
                const starDate = $('#txtStartDate').val();
                const endDate = $('#txtEndDate').val();
                const weekendDate = $('#ddlWeekend').val();

                const employeeQuery = getSelectedEmployeeQuery();
                const urlParams = new URLSearchParams(employeeQuery);
                const empIds = urlParams.getAll('empIds');

                if (empIds.length === 0) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'No Employee Selected',
                        text: 'Please select at least one employee before processing attendance.',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                const formData = new FormData();
                formData.append('companyId', CompanyID);
                formData.append('fromDate', starDate);
                formData.append('toDate', endDate);
                formData.append('weekendDay', weekendDate);

                empIds.forEach((id, index) => {
                    formData.append(`empIds[${index}]`, id);
                });

                ApiCallPostForm(PostDayWiseWeekendSetupURL, token, formData)
                    .then(data => {
                        if (data.status === 200) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Date Wise Weekend Setup Success',
                                text: 'Thanks!',
                                confirmButtonText: 'OK'
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'API Error',
                                text: data.message || 'Unexpected response from server.',
                                confirmButtonText: 'OK'
                            });
                            console.error('API Error:', data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Request failed:', error);
                    });
            }


            function DateWiseEmpWeekendSetup() {
                const WeekendDate = $('#txtWeekendDate').val();
                const employeeQuery = getSelectedEmployeeQuery();
                const urlParams = new URLSearchParams(employeeQuery);
                const empIds = urlParams.getAll('empIds');

                if (empIds.length === 0) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'No Employee Selected',
                        text: 'Please select at least one employee before processing attendance.',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                const formData = new FormData();
                formData.append('companyId', CompanyID);
                formData.append('weekendDay', WeekendDate);

                empIds.forEach((id, index) => {
                    formData.append(`empIds[${index}]`, id);
                });

                ApiCallPostForm(PostDateWiseWeekendSetupURL, token, formData)
                    .then(data => {
                        if (data.status === 200) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Date Wise Weekend Setup Success',
                                text: 'Thanks!',
                                confirmButtonText: 'OK'
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'API Error',
                                text: data.message || 'Unexpected response from server.',
                                confirmButtonText: 'OK'
                            });
                            console.error('API Error:', data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Request failed:', error);
                    });
            }


            
            function onClickDeleteWeekend() {
                var searchType = $('#ddlSearchBye').val();

                if (searchType === 'Day') {
                    Day_WiseWeekendDelete();
                } else {
                    DateWiseWeekendDelete();
                }
            }


            function Delete(id) {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "Do you really want to delete this Packages?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        ApiDeleteById(DeleteDateWiseUrl, token, id)
                            .then(function (response) {
                                Swal.fire({
                                    title: 'Success!',
                                    text: 'Packages deleted successfully.',
                                    icon: 'success',
                                    confirmButtonText: 'OK'
                                }).then(() => {
                                    GetRoles();
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


        </script>

    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="../assets/theme_assets/js/apiHelper.js"></script>
   
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
