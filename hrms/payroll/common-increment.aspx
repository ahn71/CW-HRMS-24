<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="common-increment.aspx.cs" Inherits="SigmaERP.hrms.payroll.promotion_entry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/microsoft-signalr/7.0.0/signalr.min.js"></script>

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
        .loaderDaily {
            position: absolute;
            left: 50%;
            top: 30%;
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
                                     <div class="card">
                            <div id="togglePerShift" class="card-header px-20 py-15" style="cursor: pointer;">
                                <h6 class="d-flex justify-between align-items-center fw-500 w-100">
                                    <span class="d-flex align-items-center" style="font-size:16px; color:black";>
                                        <img src="../img/svg/sliders.svg" alt="sliders" class=" me-2" style="height: 16px !important; width: 16px !important">
                                        Filter By Permanent Shift
                                    </span>
                                    <i id="arrowIconPerShift" class="fas fa-chevron-down"></i> <!-- Arrow icon -->
                                </h6>
                            </div>
                            <div class="card-body">
                                <aside class="">
                                    <div class="card border-0 shadow-none multi-collapse mt-10 collapse show" id="multiCollapseExample3">
                                        <div class="product-brands" overflow-y: auto;">
                                           <ul id="PerShiftList">

                                              
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
                                                        <div class="row g-2 align-items-end">

                                                            <!-- Employee ID -->
                                                            <div class="col">
                                                                <label for="txtEmpCardNo" class="form-label mb-1 p-0">Employee ID</label>
                                                                <input type="text" id="txtEmpCardNo" class="form-control" placeholder="Employee ID...">
                                                                 <label id="txtEmpCardNoError" class="form-label mb-1 p-0"></label>
                                                            </div>

                                                            <!-- Effective Date -->
                                                            <div class="col">
                                                                <label for="txtEffectiveDate" class="form-label mb-1 p-0">Effective Date <span style="color:red">*</span></label>
                                                                <input type="date" id="txtEffectiveDate" class="form-control">
                                                                  <label id="txtEffectiveDateError" class="form-label mb-1 p-0"></label>
                                                            </div>

                                                            <!-- Employee Maturity -->
                                                            <div class="col">
                                                                <label for="ddlEmployeeMaturity" class="form-label mb-1 p-0">Employee Maturity<span style="color:red">*</span></label>
                                                                <select id="ddlEmployeeMaturity" class="form-control">
                                                                    <option value="all">All</option>
                                                                    <option value="1">1 Year</option>
                                                                    <option value="0">Less than 1 Year</option>
                                                                </select>
                                                                
                                                                  <label id="ddlEmployeeMaturityError" class="form-label mb-1 p-0"></label>
                                                            </div>

                                                            <!-- Increment On -->
                                                            <div class="col">
                                                                <label for="ddlIncrementOn" class="form-label mb-1 p-0">Increment On<span style="color:red">*</span></label>
                                                                <select id="ddlIncrementOn" class="form-control">
                                                                    <option value="">----Select----</option>
                                                                    <option value="Gross">Gross</option>
                                                                    <option value="Basic">Basic</option>
                                                                </select>
                                                                <label id="ddlIncrementOnError" class="form-label mb-1 p-0"></label>
                                                            </div>

                                                            <!-- Increment Pers + Buttons -->
                                                            <div class="col d-flex flex-column" style="margin:auto">
                                                                <label for="txtIncrementPers" class="form-label mb-1 p-0">
                                                                    Increment %<span style="color: red">*</span>
                                                                </label>

                                                                <div class="d-flex align-items-center gap-2">
                                                                    <input type="text" id="txtIncrementPers" class="form-control">

                                                                    <button type="button" title="Search" id="btnSearch" onclick="SearchEmployee()"
                                                                        class="btn btn-sm btn-primary d-flex align-items-center justify-content-center"
                                                                        style="height: 36px; width: 36px;">
                                                                        <i class="fas fa-search"></i>
                                                                    </button>

                                                                    <button type="button" onclick="SaveCommonIncrement()" title="Save" id="btnProcessing"
                                                                        class="btn btn-sm btn-success d-flex align-items-center justify-content-center"
                                                                        style="height: 36px; width: 36px;">
                                                                        <i class="uil uil-save" style="font-size: 20px"></i>
                                                                    </button>
                                                                </div>

                                                                <!-- ❗ Moved here for alignment consistency -->
                                                                <label for="txtIncrementPers" id="txtIncrementPersError" class="form-label mb-1 p-0"></label>
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
                                                    <strong>Note:</strong> First, select a date to search, then select the employee and submit for increment.
                                                </div>
                                                <div id="employeeContainer" style="overflow-x: auto; white-space: nowrap;">
                                                    <table class="table mb-0 packagesTable table-borderless adv-table"
                                                        data-sorting="true" data-filtering="false" data-paging="true" data-paging-size="10">
                                                    </table>
                                                </div>


                                            </div>
                                        </div>

                                    </div>

                                    <div id="progress-section" style="position: absolute; top: 15%; width: 70%; left: 15%; display: none; padding: 50px;">
                                        <div class="card" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; padding: 40px">
                                            <div class="card-body position-relative" style="padding-top: 15px !important;">
                                                <div class="userDatatable adv-table-table global-shadow border-light-0 w-100">
                                                    <div class="progress" style="height: 20px; margin: 10px; font-size: 12px;">
                                                        <div id="progress-bar" class="progress-bar bg-success" role="progressbar" style="width: 0%">
                                                            0%
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
        </div>



    </div>

                                                                        
    <script>
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var AttdMetchin = '<%= Session["__GetAttdMetchinName__"]%>';
        var IsAdministrator = '<%= Session["__GetISAdministetor__"]%>';
        var getEmployeeUrl = `${rootUrl}/api/Salary/Increment/employee`;
        var PostCommonIncrementURL = `${rootUrl}/api/Salary/common_increment/save`;

        var getPerShiftUrl = `${rootUrl}/api/Roster/permanent-shift?CompanyId=${CompanyID}`;

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
            $('#togglePerShift').on('click', function () {
                PermanentShiftToggle();
            });

            const today = new Date();
            const formattedDate = formatDate(today);



            $('#txtStartDate').val(formattedDate);
            $('#txtEndDate').val(formattedDate);


            GetEmpType();
            GetUnit();
          //  GetEmployee();
            GetDepartment();
            GetPermanentShift();
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
        function PermanentShiftToggle() {
            const unitList = $('#PerShiftList');
            const arrowIcon = $('#arrowIconPerShift');

            unitList.toggle(); // Corrected variable

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
            function GetPermanentShift() {
                ApiCall(getPerShiftUrl, token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            const permShifts = response.data;
                            console.log('Before table Data Bind', permShifts);

                            bindPermanentShifts(permShifts);

                            console.log('After Table Data Bind', permShifts);
                        } else {
                            console.error('Error occurred while fetching data:', response.message);
                        }
                    })
                    .catch(function (error) {
                        $('.loaderCosting').hide();
                        console.error('Error occurred while fetching data:', error);
                    });
            }

            function bindPermanentShifts(permShifts) {
                const $list = $('#PerShiftList');
                $list.empty(); // Clear existing list

                // Add "Select All" checkbox
                const selectAllItem = `
        <li>
            <div class="checkbox-theme-default custom-checkbox">
                <input type="checkbox" id="selectAllPerShift">
                <label for="selectAllPerShift">
                    <span class="checkbox-text" style="margin-left:20px">
                        Select All
                    </span>
                </label>
            </div>
        </li>
    `;
                $list.append(selectAllItem);

                // Add permShift checkboxes
                permShifts.forEach((shift, index) => {
                    const checkboxId = `permShift-check-${index}`;
                    const listItem = `
            <li>
                <div class="checkbox-theme-default custom-checkbox">
                    <input type="checkbox" class="PermShiftCheckbox" id="${checkboxId}" value="${shift.id}">
                    <label for="${checkboxId}">
                        <span class="checkbox-text" style="margin-left:20px">
                            ${shift.name}
                        </span>
                    </label>
                </div>
            </li>
        `;
                    $list.append(listItem);
                });
            }

            // Select All checkbox toggle
            $(document).on('change', '#selectAllPerShift', function () {
                const isChecked = $(this).is(':checked');
                $('.PermShiftCheckbox').prop('checked', isChecked);
            });

            // Sync "Select All" state with individual checkboxes
            $(document).on('change', '.PermShiftCheckbox', function () {
                const total = $('.PermShiftCheckbox').length;
                const checked = $('.PermShiftCheckbox:checked').length;
                $('#selectAllPerShift').prop('checked', total === checked);
            });

            // Optional: Get selected permShift IDs as query string
            function getSelectedShiftIdsQuery() {
                return $('.PermShiftCheckbox:checked')
                    .map(function () {
                        return $(this).val()
                    })
                    .get(); 
            }
        function getSelectedEmpTypeQuery() {
            return $('.empTypeCheckbox:checked')
                .map(function () {
                    return $(this).val();
                })
                .get();
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








        function GetEmployee() {
            // --- Clear previous error messages ---
            $('#txtEffectiveDateError').text('');
            $('#ddlEmployeeMaturityError').text('');
            $('#ddlIncrementOnError').text('');
            $('#txtIncrementPersError').text('');

            // --- Get field values ---
            const empCardNo = $('#txtEmpCardNo').val();
            const effectiveDate = $('#txtEffectiveDate').val();
            const empMaturityType = $('#ddlEmployeeMaturity').val();
            const incrementOn = $('#ddlIncrementOn').val();
            const incrementPer = $('#txtIncrementPers').val();

            let isValid = true;

            // --- Validation checks ---
            if (!effectiveDate) {
                $('#txtEffectiveDateError').text('Effective Date is required').css('color', 'red');
                isValid = false;
            }
            if (!empMaturityType) {
                $('#ddlEmployeeMaturityError').text('Employee Maturity is required').css('color', 'red');
                isValid = false;
            }
            if (!incrementOn) {
                $('#ddlIncrementOnError').text('Increment On is required').css('color', 'red');
                isValid = false;
            }
            if (!incrementPer) {
                $('#txtIncrementPersError').text('Increment % is required').css('color', 'red');
                isValid = false;
            } else if (isNaN(incrementPer) || incrementPer <= 0) {
                $('#txtIncrementPersError').text('Enter a valid percentage').css('color', 'red');
                isValid = false;
            }

            // --- Stop execution if validation fails ---
            if (!isValid) {
                return;
            }
              $('.loaderDaily').show();
            // --- Get other data ---
            const deptIds = getSelectedDepartmentQuery();
            const shiftIds = getSelectedShiftIdsQuery();
            const empTypeIds = getSelectedEmpTypeQuery();

            // --- Build the POST body ---
            const postData = {
                date: effectiveDate,
                empMaturityType: empMaturityType === "all" ? 2 : parseInt(empMaturityType),
                incrementOn: incrementOn,
                incrementPer: parseFloat(incrementPer),
                companyId: CompanyID,
                empCard: empCardNo || "",
                deptIds: deptIds.length > 0 ? deptIds : [""],
                shiftIds: shiftIds.length > 0 ? shiftIds : [""],
                empType: empTypeIds.length > 0 ? empTypeIds.map(Number) : [] 
            };

            console.log("POST BODY:", postData);

            // --- Call API ---
            const url = getEmployeeUrl;
            ApiCallPost(url, token, postData)
                .then(response => {
                    if (response.statusCode === 200) {
                        bindTableData(response.data);
                        $('.loaderDaily').hide();
                        $('#alertContainer').hide();
                    } else {
                        console.error("API Error:", response.message);
                        bindTableData([]);
                        $('.loaderDaily').hide();
                    }
                })
                .catch(error => {
                    console.error("Network Error:", error);
                    bindTableData([]);
                     $('.loaderDaily').hide();
                });
        }



        let allEmployeeData = [];
        // Change from Set to Map to store full data
        const selectedEmployees = new Map();

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
                const userImage = row.userPicture || defaultImage;
                row.userImage = `
            <div class="user-details-container d-flex align-items-center">
                <img src="${userImage}" alt="User Image" class="user-image" style="width: 25px; height: 25px; margin-right: 10px;">
                <div>
                    <a href="javascript:void(0)" class="user-name" data-id="${row.empId}">${row.empName}</a>
                    <div class="user-role">${row.departmentName}, ${row.designationName}</div>
                </div>
            </div>
        `.trim();

                row.select = `
            <input type="checkbox" class="EmployeerowCheckbox" data-id="${row.empId}" value="${row.empId}"
                ${selectedEmployees.has(row.empId) ? 'checked' : ''} />
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
                { name: "empType", title: "Emp Type", className: "userDatatable-content" },
                { name: "empJoiningDate", title: "Joining Date", className: "userDatatable-content" },

                { name: "empPresentSalary", title: "Salary", className: "userDatatable-content" },
                { name: "basicSalary", title: "Basic", className: "userDatatable-content" },
                { name: "houseRent", title: "House", className: "userDatatable-content" },
                { name: "newGrossSalary", title: "New Salary", className: "userDatatable-content" },
                { name: "newBasicSalary", title: "New Basic", className: "userDatatable-content" },
                { name: "newHouseRent", title: "New House", className: "userDatatable-content" }
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
                  $('.footable-loader').hide();
            }
        }

        // Select All
        // Select All
        $(document).on('change', '#selectAllEmployee', function () {
            const isChecked = $(this).is(':checked');
            allEmployeeData.forEach(emp => {
                if (isChecked) {
                    selectedEmployees.set(emp.empId, {
                        empId: emp.empId,
                        empType: emp.empTyp,
                        companyId: emp.companyId,
                        type: 'Increment',
                        empPresentSalary: emp.newGrossSalary,
                        basicSalary: emp.newBasicSalary,
                        medicalAllowance: emp.newMedicalAllownce,
                        foodAllowance: emp.newFoodAllownce,
                        conveyanceAllowance: emp.newConvenceAllownce,
                        houseRent: emp.newHouseRent,
                        updatedDate: emp.effectiveDate
                    });
                } else {
                    selectedEmployees.delete(emp.empId);
                }
            });
            bindTableData(allEmployeeData);
        });

        // Individual row selection
        $(document).on('change', '.EmployeerowCheckbox', function () {
            const empId = $(this).val();
            const empData = allEmployeeData.find(emp => emp.empId === empId);

            if ($(this).is(':checked')) {
                selectedEmployees.set(empId, {
                    empId: empData.empId,
                    empType: empData.empTyp,
                    companyId: empData.companyId,
                    type: 'Increment',
                    empPresentSalary: empData.newGrossSalary,
                    basicSalary: empData.newBasicSalary,
                    medicalAllowance: empData.newMedicalAllownce,
                    foodAllowance: empData.newFoodAllownce,
                    conveyanceAllowance: empData.newConvenceAllownce,
                    houseRent: empData.newHouseRent,
                    updatedDate: empData.effectiveDate
                });
            } else {
                selectedEmployees.delete(empId);
            }

            updateSelectAllCheckbox();
        });

        function updateSelectAllCheckbox() {
            const allIds = allEmployeeData.map(emp => emp.empId);
            const isAllSelected = allIds.every(id => selectedEmployees.has(id));
            $('#selectAllEmployee').prop('checked', isAllSelected);
        }

        // Get query string of selected employees (or full data)
        function getSelectedEmployeeQuery() {
            return Array.from(selectedEmployees.values()).map(emp => `empIds=${emp.empId}`).join('&');
        }

        // If you need the full data instead of query
        function getSelectedEmployeeData() {
            return Array.from(selectedEmployees.values());
        }

        let pollingInterval;
        async function SaveCommonIncrement() {
            const selectedEmployeeList = Array.from(selectedEmployees.values());

            if (!selectedEmployeeList.length) {
                Swal.fire({
                    icon: 'warning',
                    title: 'No Employee Selected',
                    text: 'Please select at least one employee before processing.'
                });
                return;
            }

            const progressSection = document.getElementById("progress-section");
            const progressBar = document.getElementById("progress-bar");

            progressSection.style.display = "block";
            progressBar.style.width = "0%";
            progressBar.innerText = "0%";

            // Map all employees
            const payload = selectedEmployeeList.map(emp => ({
                empId: emp.empId,
                empType: parseInt(emp.empType),
                companyId: emp.companyId,
                updatedDate: emp.updatedDate,
                empPresentSalary: parseFloat(emp.empPresentSalary) || 0,
                basicSalary: parseFloat(emp.basicSalary) || 0,
                medicalAllowance: parseFloat(emp.medicalAllowance) || 0,
                foodAllowance: parseFloat(emp.foodAllowance) || 0,
                conveyanceAllowance: parseFloat(emp.conveyanceAllowance) || 0,
                houseRent: parseFloat(emp.houseRent) || 0
            }));

            try {
                const response = await ApiCallPostForProgress(PostCommonIncrementURL, token, JSON.stringify(payload));

                if (response.statusCode === 200) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'All employee increments processed successfully.'
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: response.message || 'Error processing increments.'
                    });
                }
            } catch (error) {
                console.error("Error:", error);
                Swal.fire({
                    icon: 'error',
                    title: 'Network Error',
                    text: 'Unable to process increments at this time.'
                });
            } finally {
                progressSection.style.display = "none";
            }
        }


        // SignalR connection to ProgressHub
        const connection = new signalR.HubConnectionBuilder()
            .withUrl( rootUrl+"/hubs/incrementProgress") // Correct hub URL
            .withAutomaticReconnect()
            .build();


        // Listen for progress updates
        connection.on("ReceiveProgress", function (percent) {
            const progressBar = document.getElementById("progress-bar");
            if (progressBar) {
                progressBar.style.width = `${percent}%`;
                progressBar.innerText = `${percent.toFixed(0)}%`;
                console.log(percent);
            }
        });


        // Start connection
        async function startConnection() {
            try {
                await connection.start();
                console.log("SignalR connected.");
            } catch (err) {
                console.error(err);
                setTimeout(startConnection, 5000); // retry
            }
        }
        startConnection();


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
        function formatDateToDateOnly(dateValue) {
            if (!dateValue) return null;
            const date = new Date(dateValue);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
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
            // Collect all checked department checkboxes
            return $('.rowCheckbox:checked')
                .map(function () {
                    return $(this).val(); // e.g., "0001", "0002"
                })
                .get(); // returns ["0001", "0002"]
        }



 
    </script>


    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="../assets/theme_assets/js/apiHelper.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</asp:Content>
