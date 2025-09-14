<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="attendanceProcessing.aspx.cs" Inherits="SigmaERP.hrms.attendance.attendanceProcessing" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <style>
        .packagesTable {
            padding: 0 !important;
        }

        td {
            text-align: left;
        }

        i {
            margin-right: 0 !important;
        }
        .clickable-roster:hover {
            color: darkorange; /* Change this to your department color */
            text-decoration: underline;
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

        label {
            margin-left: 0 !important;
        }

        /*.row > * {
            margin-top: 0 !important;
        }*/


        .swal2-container {
            z-index: 99999 !important;
        }

        .uil-money-insert {
            margin-right: 5px;
        }

        label {
            margin-bottom: 3px;
        }

        .form-control {
            height: 40px !important;
        }
        .table-responsive{
            overflow-x: hidden;
        }

    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-1">
        <div class="products_page product_page--grid mb-30">
            <div class="container-fluid">
                <div class="row justify-content-center">

                        <div class="col-lg-3 col-sm-12 mb-lg-0 mb-30">
                        <div class="card" id="EmpTypeSection">
                            <div id="toggleEmpType" class="card-header px-20 py-15" style="cursor: pointer;">
                                <h6 class="d-flex justify-between align-items-center fw-500 w-100">
                                    <span class="d-flex align-items-center" style="font-size: 16px; color: black;">
                                        <img src="../img/svg/sliders.svg" alt="sliders" class="me-2" style="height: 16px; width: 16px;">
                                        Filter by EmpType
                                    </span>
                                    <i id="arrowIconEmpType" class="fas fa-chevron-down"></i>
                                </h6>
                            </div>
                            <div class="card-body">
                                <aside>
                                    <div class="card border-0 shadow-none mt-10 collapse show" id="multiCollapseExample4">
                                        <div class="product-brands">
                                            <ul id="empTypeList" class="list-unstyled mb-0"></ul>
                                        </div>
                                    </div>
                                </aside>
                            </div>
                        </div>

                        <div class="card" id="unitSection">
                            <div id="toggleFilter" class="card-header px-20 py-15" style="cursor: pointer;">
                                <h6 class="d-flex justify-between align-items-center fw-500 w-100">
                                    <span class="d-flex align-items-center" style="font-size:16px; color:black";>
                                        <img src="../img/svg/sliders.svg" alt="sliders" class=" me-2" style="height: 16px !important; width: 16px !important">
                                        Filter by Unit
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
                                        Filter by Department
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

                                          

<%--                    <div class="col-lg-3 col-sm-12 mb-lg-0 mb-30">
                        <div class="widget">
                            <div class="widget-header-title px-20 py-15">
                                <h6 class="d-flex align-content-center fw-500">
                                    <img src="../img/svg/sliders.svg" alt="sliders" class="svg">
                                    Filter Department
                                </h6>
                            </div>
                            <div class="category_sidebar">
                                <aside class="product-sidebar-widget mb-30">
                                    <div class="card border-0 shadow-none multi-collapse mt-10 collapse show" id="multiCollapseExample1">
                                        <div class="product-brands" style="height: 100vh; overflow-y: auto;">
                                            <ul id="departmentList">
                                                <!-- Checkboxes will be injected here -->
                                            </ul>
                                        </div>
                                    </div>
                                </aside>
                            </div>
                        </div>
                    </div>--%>
                    <div class=" col-lg-9 mt-xl-0 mt-lg-30">

                        <div class="row product-page-list justify-content-center">
                            <div class="col-12 mb-25 px-10">
                                <div class="card ">
                                    <div class="card-body position-relative" style="padding-top: 15px !important;">

                                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                                            <div class="table-responsive">
                                                <div class="ad-table-table__header d-flex justify-content-between mb-15">
                                                    <%--Table Search Area--%>
                                                    <div class="container-fluid" style="padding-left: 0px !important; padding-right: 0px !important">
                                                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3 align-items-end">

                                                            <!-- Search Input -->
                                                            <div class="col">
                                                                <label for="txtSearch" class="form-label mb-1 p-0">Employee ID</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-text bg-white border-end-0">
                                                                        <i class="uil uil-search"></i>
                                                                    </span>
                                                                    <input type="text" id="txtEmpCardNo" class="form-control border-start-0" placeholder="Employee ID..." aria-describedby="searchIcon">
                                                                </div>
                                                            </div>

                                                            <!-- Start Date -->
                                                            <div class="col">
                                                                <label for="txtStartDate" class="form-label mb-1 p-0">Start Date</label>
                                                                <input type="date" id="txtStartDate" class="form-control" aria-describedby="passwordHelpInline">
                                                            </div>

                                                            <!-- End Date + Search Button -->
                                                            <div class="col">
                                                                <label for="txtEndDate" class="form-label mb-1 p-0">End Date</label>
                                                                <div class="d-flex align-items-center">
                                                                    <input type="date" id="txtEndDate" class="form-control me-2" aria-describedby="passwordHelpInline">
                                                                    <button type="button" title="Search" id="btnSearch" onclick="SearchEmployee()"
                                                                        class="btn btn-sm btn-primary d-flex align-items-center justify-content-center"
                                                                        style="height: 36px; width: 36px;">
                                                                        <i class="fas fa-search"></i>
                                                                    </button>
                                                                </div>
                                                            </div>



                                                            <!-- File Input and Process Button -->
                                                            <div class="col">
                                                                <div id="AttdMetchinFileSection">
                                                                    <label for="AttFile" class="form-label mb-1 p-0">Attendance File</label>
                                                                    <div class="d-flex align-items-center">
                                                                        <input type="file" id="AttFile" class="form-control me-2" style="width: 100%;" aria-describedby="passwordHelpInline">
                                                                    </div>
                                                                </div>

                                                                <button type="button" onclick="AttendanceProcess()" title="Processing" id="btnProcessing"
                                                                    class="btn btn-sm btn-success d-flex align-items-center justify-content-center"
                                                                    style="height: 36px; width: 36px;">
                                                                    <i class="uil uil-calculator" style="font-size: 20px"></i>
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

                                    <div id="progress-section" style="position: absolute; top: 15%; width: 70%; left: 15%; display: none; padding: 50px;">
                                        <div class="card " style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; padding: 40px">
                                            <div class="card-body position-relative" style="padding-top: 15px !important;">

                                                <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                                                    <div class="progress" style="height: 20px; margin: 10px; font-size: 12px;">
                                                        <div id="progress-bar" class="progress-bar bg-success" role="progressbar" style="width: 0%">
                                                            0%
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="attendanceContainer" class="card p-4" style="position: absolute; top: 0%; width: 100%; height: 100%; display: none; z-index: 9990;">
                                        <!-- Close Button -->
                                        <div class="d-flex align-items-center pb-4 card-header justify-content-between">

                                            <h2>Attendance Result</h2>
                                            <div class="d-flex">
                                                <h2 id="totalMessingRoster" class="text-danger clickable-roster" style="margin-right:30px; cursor:pointer;" title="Click to view details">
    <!-- Total Missing Data will be shown here --></h2>

                                                <button type="button" class="alert alert-danger fs-5"
                                                title="Close" onclick="showAttendanceHideEmployee()">
                                                <i class="fas fa-times"></i>
                                            </button>
                                            </div>
                                       
                                        </div>


                                        <div id="filter-form-container"></div>

                                        <table id="attdTable" class="table mb-0 table-borderless attd-table" data-sorting="true" data-filtering="true" data-filter-container="#filter-form-container" data-paging="true" data-paging-size="10">
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


    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var AttdMetchin = '<%= Session["__GetAttdMetchinName__"]%>';
        var IsAdministrator = '<%= Session["__GetISAdministetor__"]%>';
        var getEmployeeUrl = `${rootUrl}/api/Employee/active-employees-date-range?CompanyId=${CompanyID}`;
        var PostAttendanceProcessURL = `${rootUrl}/api/Attendance/attedance/process`;

        var getDepartmentUrl = `${rootUrl}/api/Department/basicInfo/${CompanyID}`;
        var getUnitUrl = `${rootUrl}/api/Unit/basicInfo?CompanyId=${CompanyID}`;
        var getEmpTypeUrl = `${rootUrl}/api/EmployeeType/basicInfo`;



        var token = '<%= Session["__UserToken__"] %>';


        $(document).ready(function () {

            $('#toggleFilter').on('click', function () {
                unitToggle();
            });

            $('#toggleDepartment').on('click', function () {
                DepartmentToggle();
            });

            $('#toggleEmpType').on('click', function () {
                EmpTypetToggle();
            });


            const today = new Date();
            const formattedDate = formatDate(today);



            $('#txtStartDate').val(formattedDate);
            $('#txtEndDate').val(formattedDate);


            GetEmpType();
            GetUnit();
            GetEmployee();
            GetDepartment();

            if (AttdMetchin === "zk(access)") {
                $("#AttdMetchinFileSection").show();
            } else {
                $("#AttdMetchinFileSection").hide();
            }

        });
        function formatDate(date) {
            const day = String(date.getDate()).padStart(2, '0');
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const year = date.getFullYear();
            return `${year}-${month}-${day}`;
        }
        function SearchEmployee() {
            GetEmployee();
        }


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

            function EmpTypetToggle() {
                const unitList = $('#empTypeList');
                const arrowIcon = $('#arrowIconEmpType');

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

                unitList.toggle(); 

                if (unitList.is(':visible')) {
                    arrowIcon.removeClass('fa-chevron-up').addClass('fa-chevron-down');
                } else {
                    arrowIcon.removeClass('fa-chevron-down').addClass('fa-chevron-up');
                }
            }

        function GetEmpType() {
            ApiCall(getEmpTypeUrl, token)
                .then(function (response) {
                    if (response.statusCode === 200) {
                        var responseData = response.data;
                        console.log('Before table Data Bind', responseData);

                        bindEmpType(responseData);

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
        // Function to bind EmpType list
        function bindEmpType(empTypeList) {
            const $list = $('#empTypeList');
            $list.empty();

            // Add "Select All" option
            const selectAllHTML = `
        <li>
            <div class="checkbox-theme-default custom-checkbox">
                <input type="checkbox" id="selectAllEmpTypes">
                <label for="selectAllEmpTypes">
                    <span class="checkbox-text" style="margin-left: 20px;">Select All</span>
                </label>
            </div>
        </li>
    `;
            $list.append(selectAllHTML);

            // Append each EmpType checkbox
            empTypeList.forEach((empType, index) => {
                const checkboxId = `empType-check-${index}`;
                const itemHTML = `
            <li>
                <div class="checkbox-theme-default custom-checkbox">
                    <input type="checkbox" class="empTypeCheckbox" id="${checkboxId}" value="${empType.id}">
                    <label for="${checkboxId}">
                        <span class="checkbox-text" style="margin-left: 20px;">${empType.name}</span>
                    </label>
                </div>
            </li>
        `;
                $list.append(itemHTML);
            });
        }

        // "Select All" checkbox behavior
        $(document).on('change', '#selectAllEmpTypes', function () {
            const isChecked = $(this).is(':checked');
            $('.empTypeCheckbox').prop('checked', isChecked);
        });

        // Sync "Select All" checkbox based on individual checks
        $(document).on('change', '.empTypeCheckbox', function () {
            const total = $('.empTypeCheckbox').length;
            const checked = $('.empTypeCheckbox:checked').length;
            $('#selectAllEmpTypes').prop('checked', total === checked);
        });

        // Get selected EmpType query string
        function getSelectedEmpTypeQuery() {
            return $('.empTypeCheckbox:checked')
                .map(function () {
                    return 'EmpTypeIds=' + $(this).val();
                })
                .get()
                .join('&');
        }


        function GetUnit() {
            ApiCall(getUnitUrl, token)
                .then(function (response) {
                    if (response.statusCode === 200) {
                        var responseData = response.data;
                        console.log('Before table Data Bind', responseData);

                        bindUnits(responseData);
                        if (responseData.length > 1) {
                            $('#unitSection').show();
                        } else {
                            $('#unitSection').hide();
                        }
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
            $list.empty();


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

        $(document).on('change', '#selectAllUnits', function () {
            const isChecked = $(this).is(':checked');
            $('.unitCheckbox').prop('checked', isChecked);
        });

        $(document).on('change', '.unitCheckbox', function () {
            const total = $('.unitCheckbox').length;
            const checked = $('.unitCheckbox:checked').length;
            $('#selectAllUnits').prop('checked', total === checked);
        });


        function getSelectedUnitQuery() {
            return $('.unitCheckbox:checked')
                .map(function () {
                    return 'UnitIds=' + $(this).val();
                })
                .get()
                .join('&');
        }

        function showAttendanceHideEmployee() {
            $('#attendanceContainer').hide();
        }







        let pollingInterval;
        function AttendanceProcess() {
            const startDate = $('#txtStartDate').val();
            const endDate = $('#txtEndDate').val();
            const employeeQuery = JSON.stringify(Array.from(selectedEmployeeIds));

            if (!selectedEmployeeIds || selectedEmployeeIds.size === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'No Employee Selected',
                    text: 'Please select at least one employee before processing attendance.',
                    confirmButtonText: 'OK'
                });
                return;
            }

            $('#progress-section').show();
            $('#progress-bar').css('width', '0%').text('0%');

            pollingInterval = setInterval(fetchProgress, 500);

            ApiCallPostAttendProcess(
                PostAttendanceProcessURL,
                token,
                'AttFile',
                CompanyID,
                startDate,
                endDate,
                employeeQuery
            )
                .then(response => {
                    if (response.statusCode === 200) {
                        console.log('Attendance processing started...');
                        bindAttdTableData(response.data);
                        $('#progress-section').hide();
                        $('#attendanceContainer').show();
                       console.log('Missing Data', response.missingData);
                        sessionStorage.setItem('__MessingRosterData__', JSON.stringify(response.missingData));
                        const totalMessing = response.missingData?.length || 0;
                        console.log('Total Missing Data:', totalMessing);
                        $('#totalMessingRoster').text('Messing Roster ' + '('+ totalMessing+ ')');

                        if (totalMessing === 0) {
                            $('#totalMessingRoster').hide();
                        } else {
                            $('#totalMessingRoster').show();
                        }
                        selectedEmployeeIds.clear();
                        $('#selectAllEmployee').prop('checked', false);
                        $('.EmployeerowCheckbox').prop('checked', false);
                    } else {
                        console.error('API Error:', response.message);
                        $('.footable-loader').hide();
                        $('#progress-section').hide();
                       
                    }
                })
                .catch(error => {
                    console.error('Network Error:', error);
                    $('.footable-loader').hide();
                    $('#progress-section').hide();
                
                });
        }

        function ApiCallPostAttendProcess(apiUrl, token, fileInputId, companyId, fromDate, toDate, empIds) {
            return new Promise(function (resolve, reject) {
                const fileInput = document.getElementById(fileInputId);
                //if (!fileInput || fileInput.files.length === 0) {
                //    Swal.fire({ icon: 'warning', title: 'File Missing', text: 'Please select a file to upload.' });
                //    reject('No file selected');
                //    return;
                //}

                const formData = new FormData();
                formData.append('file', fileInput.files[0]);
                formData.append('companyId', companyId);
                formData.append('fromDate', fromDate);
                formData.append('toDate', toDate);
                formData.append('empIds', empIds);

                $.ajax({
                    url: apiUrl,
                    type: 'POST',
                    headers: {
                        'Authorization': 'Bearer ' + token
                    },
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        resolve(data);
                    },
                    error: function (xhr, status, error) {
                         console.log("Error Message for attendance proccess: ",xhrr)
                         console.log("Error Message for attendance proccess",error)
                        Swal.fire({
                           
                            icon: 'warning',
                            title: 'Almost There!',
                            text: 'Some issues occurred while processing attendance. Please retry or contact support if needed.',
                            confirmButtonText: 'OK'
                        });


                        reject(error);
                    }
                });
            });
        }


        function fetchProgress() {
            $.get(`${rootUrl}/api/AttendanceProgress/getprogress`, function (data) {
                $('#progress-bar').css('width', data.percent + '%').text(data.percent + '%');
                if (data.isCompleted) {
                    clearInterval(pollingInterval);
                    $('.footable-loader').hide();

                }
            });
        }

        function bindAttdTableData(data) {
            const $table = $('#attdTable');

            if ($table.data('footable')) {
                $table.data('footable').destroy();
            }

            $('#filter-form-container').empty();

            let serialNumber = 1;
            const defaultImage = '/hrms/user_img_default.jpg';

            data.forEach(row => {
                row.serial = serialNumber++;
                const userImage = row.userImage || defaultImage;

                row.empPicture = `
                    <div class="user-details-container d-flex align-items-center">
                        <img src="${userImage}" alt="User Image" class="user-image" style="width: 40px; height: 40px; margin-right: 10px;">
                        <div>
                            <a href="javascript:void(0)" class="user-name" data-id="${row.empId}">${row.empName}</a>
                            <div class="user-role">${row.designation}</div>
                        </div>
                    </div>
                `;
            });

            const columns = [
                { name: "serial", title: "SL", breakpoints: "xs sm", type: "number", className: "userDatatable-content" },
                { name: "empPicture", title: "Name", className: "userDatatable-content" },
                { name: "empCardNo", title: "Emp. ID", className: "userDatatable-content" },
                { name: "departmnet", title: "Department", className: "userDatatable-content" },
                { name: "attDate", title: "Date", className: "userDatatable-content" },
                { name: "attStatus", title: "Status", className: "userDatatable-content" },
                { name: "inPunch", title: "In Time", className: "userDatatable-content" },
                { name: "outPunch", title: "Out Time", className: "userDatatable-content" },
            ];

            try {
                $table.footable({
                    columns: columns,
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
                console.error("Error initializing Attendance Table:", error);
            }
        }






        function GetEmployee() {
            const startDate = $('#txtStartDate').val();
            const EmpCardNo = $('#txtEmpCardNo').val();
            const deptQuery = getSelectedDepartmentQuery();
            const empTypeQuery = getSelectedEmpTypeQuery();
            const unit = getSelectedUnitQuery();

            const url = `${getEmployeeUrl}&${deptQuery}&startDate=${startDate}&endDate=${startDate}&EmpCardNo=${EmpCardNo}&${empTypeQuery}&${unit}`;

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
                     bindTableData([]);
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
                const userImage = row.userImage || defaultImage;
                row.userImage = `
            <div class="user-details-container d-flex align-items-center">
                <img src="${userImage}" alt="User Image" class="user-image" style="width: 40px; height: 40px; margin-right: 10px;">
                <div>
                    <a href="javascript:void(0)" class="user-name" data-id="${row.empId}">${row.empName}</a>
                    <div class="user-role">${row.dsgName}</div>
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
                { name: "empCardNo", title: "Employee ID", className: "userDatatable-content" },
                { name: "dptName", title: "Department", className: "userDatatable-content" },
                { name: "joiningDate", title: "Joining Date", className: "userDatatable-content" }
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


        function DateWiseEmpWeekendSetup() {
            const startDate = $('#txtStartDate').val();
            const endDate = $('#txtEndDate').val(); // Optional use
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

            const apiUrl = PostAttendanceProcessURL;
            const tokenValue = token;
            const companyId = CompanyID;
            const weekendDate = startDate;

            const postData = {
                empIds: empIds,
                companyId: companyId,
                weekendDay: weekendDate
            };

            ApiCallPost(apiUrl, tokenValue, postData)
                .then(data => {
                    if (data.statusCode === 200) {
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
        $(document).on('click', '#totalMessingRoster', function () {
            const rawData = sessionStorage.getItem('__MessingRosterData__');
            const missingDetails = rawData ? JSON.parse(rawData) : [];

            if (!missingDetails.length) {
                alert('No missing roster entries found.');
                return;
            }

            const companyName = 'ABR SPINNING MILLS LIMITED';
            const companyAddress = 'House# 10, (Lift-7) Road-90, Gulshan-2, Dhaka-1212';
            const reportTitle = 'Missing Roster Report';
            const generatedDate = 'Generated on: ' + new Date().toLocaleString();

            // 🔁 Step 1: Define field mappings (key: original key, value: new label)
            const headerMap = {
                empCardNo: 'Employee ID',
                empName: 'Employee Name',
                dptName: 'Department',
                dsgName: 'Designation',
                perShift: 'Permanent Shift',
                attDate: 'Attendance Date',
                reason: 'Reason'
            };

            // ✅ Step 2: Create array of header labels
            const headers = Object.values(headerMap);

            // ✅ Step 3: Convert data to rows based on the header map
            const dataRows = missingDetails.map(item =>
                Object.keys(headerMap).map(key => item[key] ?? '')
            );

            // ✅ Step 4: Build full worksheet data with company info and headers
            const worksheetData = [
                [companyName],
                [companyAddress],
                [reportTitle],
                [generatedDate],
                [],
                headers,
                ...dataRows
            ];

            const worksheet = XLSX.utils.aoa_to_sheet(worksheetData);

            // ✅ Step 5: Merge and style top header rows
            const mergeAcross = headers.length - 1;
            worksheet['!merges'] = [
                { s: { r: 0, c: 0 }, e: { r: 0, c: mergeAcross } },
                { s: { r: 1, c: 0 }, e: { r: 1, c: mergeAcross } },
                { s: { r: 2, c: 0 }, e: { r: 2, c: mergeAcross } },
                { s: { r: 3, c: 0 }, e: { r: 3, c: mergeAcross } },
            ];

            // 🔧 Optional: Style the title rows (center align, bold, font size)
            ['A1', 'A2', 'A3', 'A4'].forEach(cell => {
                if (worksheet[cell]) {
                    worksheet[cell].s = {
                        alignment: { horizontal: 'center', vertical: 'center' },
                        font: { bold: true, sz: 16 }
                    };
                }
            });

            worksheet['!cols'] = headers.map(() => ({ wch: 22 }));

            const workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, 'MissingRoster');

            XLSX.writeFile(workbook, 'MissingRoster_Report.xlsx');
        });
    </script>


    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="../assets/theme_assets/js/apiHelper.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</asp:Content>
