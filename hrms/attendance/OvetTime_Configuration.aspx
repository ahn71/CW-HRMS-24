<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="OvetTime_Configuration.aspx.cs" Inherits="SigmaERP.hrms.payroll.OvetTime_Configuration" %>
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


            .swal2-container {
                z-index: 99999 !important;
            }
            .uil-money-insert{
                margin-right:5px;
            }

            label{
                margin-bottom:3px;
            }
            .form-control {
                height: 40px !important;
            }

            .ot-filter-toolbar {
                display: flex;
                justify-content: space-between;
                align-items: end;
                gap: 12px;
                flex-wrap: wrap;
                width: 100%;
            }

            .ot-search-group {
                display: grid;
                grid-template-columns: minmax(170px, 1fr) minmax(145px, 170px) minmax(150px, 180px) 44px;
                gap: 8px;
                width: min(100%, 740px);
            }

            .ot-input-icon {
                position: relative;
            }

            .ot-input-icon i {
                position: absolute;
                left: 12px;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
                z-index: 2;
            }

            .ot-input-icon .form-control {
                padding-left: 36px;
            }

            .ot-icon-btn {
                width: 44px;
                height: 40px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 0 !important;
            }

            .overtime-limit-input {
                min-width: 130px;
                max-width: 170px;
            }

            .overtime-date-input {
                min-width: 145px;
                max-width: 180px;
            }

            @media (max-width: 575.98px) {
                .ot-search-group {
                    grid-template-columns: 1fr;
                    width: 100%;
                }

                .ot-icon-btn {
                    width: 100%;
                }
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
                    <div class=" col-lg-9 mt-xl-0 mt-lg-30">

                        <div class="row product-page-list justify-content-center">
                            <div class="col-12 mb-25 px-10">
                                <div class="card ">
                                    <div class="card-body position-relative" style="padding-top: 15px !important;">

                                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                                            <div class="">
                                                <div class="ad-table-table__header d-flex justify-content-between mb-15">
                                                    <%--Table Search Area--%>
                                                    <div class="container-fluid" style="padding-left:0px !important; padding-right:0px !important">
                                                        <div class="ot-filter-toolbar">
                                                            <div class="ot-search-group">
                                                                <div class="ot-input-icon">
                                                                    <i class="uil uil-user"></i>
                                                                    <input type="text" id="txtEmpCardNo" class="form-control" placeholder="Employee Card" aria-label="Employee Card">
                                                                </div>
                                                                <div class="ot-input-icon">
                                                                    <i class="uil uil-clock"></i>
                                                                    <input type="text" id="overTimeLimit" class="form-control" placeholder="HH:mm" maxlength="5" inputmode="numeric" pattern="^([01]?[0-9]|2[0-3]):[0-5][0-9]$" aria-label="Overtime Limit">
                                                                </div>
                                                                <div class="ot-input-icon">
                                                                    <i class="uil uil-calendar-alt"></i>
                                                                    <input type="date" id="overTimeDate" class="form-control" aria-label="Overtime Date">
                                                                </div>
                                                                <button type="button" title="Search" id="btnSearch" onclick="SearchEmployee()"
                                                                    class="btn btn-primary ot-icon-btn">
                                                                    <i class="fas fa-search" style="font-size: 16px"></i>
                                                                </button>
                                                            </div>
                                                            <button type="button" id="btnSubmitOverTime" onclick="SaveOverTimeConfiguration()" class="btn btn-primary d-inline-flex align-items-center">
                                                                <i class="uil uil-check-circle me-2"></i>Submit
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <%--Close--%>
                                                </div>

                                               <%-- <div id="alertContainer" class="alert alert-info text-center mt-3" role="alert" style="height:200px">
                                                    <strong>Note:</strong> Please filter employees first before setting up the weekend schedule.
                                                </div>--%>

                                                <%--<div id="dateWiseAlert" class="alert alert-success text-center mt-3" role="alert">--%>
                                                    <%--<strong id="dateWiseAlertText">Note:</strong> Please filter employees first before setting up the weekend schedule.--%>
                                                <%--</div>--%>
                                                
                                                <%--<div id="dayWiseAlertText" class="alert alert-success text-center mt-3" role="alert">
                                                    <strong>01-01-2025 Weekend Employee </strong> 
                                                </div>--%>






                                                <div id="employeeContainer">
                                                      <table class="table mb-0 packagesTable table-borderless adv-table"
                                                    data-sorting="true" data-filtering="false" data-paging="true" data-paging-size="10">
                                                </table>
                                                </div>

                                

                                                <div class="modal fade" id="salaryModal" tabindex="-1" aria-labelledby="salaryModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-xl">
                                                        <!-- Large Modal -->
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="salaryModalLabel">Set Employee Salary</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>

                                                            <div class="modal-body pb-0 pt-10">
                                                                <form id="salaryForm">
                                                                    <input type="hidden" id="empIdField" name="empId">

                                                                    <div class="row">
                                                                       
                                                                
                                                                            <div class="col-lg-8 mb-10">
                                                                                <div class="row">
                                                                                   
                                                                                    <div class="col-lg-4">
                                                                            <label for="ddlPaymentMethod" class="color-dark fs-14 fw-500 align-center">Payment Method</label>
                                                                            <div class="input-group">
                                                                                
                                                                                <select name="ddlPaymentMethod" id="ddlPaymentMethod" class="form-control ih-medium ip-gray radius-xs b-light">
                                                                                    <option value="">---Select---</option>
                                                                                    <option value="0">Cash</option>
                                                                                    <option value="1">Bank</option>
                                                                                    <option value="2">Bkash</option>
                                                                                    <option value="3">Check</option>
                                                                                </select>
                                                                            </div>
                                                                            <span class="text-danger" id="errorDataAccessLevel"></span>
                                                                                      </div>

                                                                               
                                                                                     <div class="col-lg-4 mb-10">
                                                                                        <label for="ddlSalaryBank" class="color-dark fs-14 fw-500 align-center">Salary Bank</label>
                                                                                        <div class="input-group ">
                                                                                          
                                                                                            <select name="ddlSalaryBankName" id="ddlSalaryBank" class="form-control ih-medium ip-gray radius-xs b-light">

                                                                                           
                                                                                            </select>
                                                                                        </div>
                                                                                        <span class="text-danger" id="ddlSalaryBankError"></span>
                                                                                    </div>

                                                                                     <div class="col-lg-4">
                                                                                        <div class="form-group">
                                                                                            <label for="txtAccountNo" class=" color-dark fs-14 fw-500 align-center">Account No</label>
                                                                                            <div class="with-icon">
                                                                                                <span class="las la-money-bill"></span>
                                                                                                <input type="text" class="form-control ih-medium ip-gray radius-xs b-light" id="txtAccountNo">
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                     <div class="col-lg-4 mb-10">
                                                                                        <label for="ddlGrade" class="color-dark fs-14 fw-500 mb-1">Grade</label>
                                                                                        <div class="input-group">

                                                                                            <select name="ddlGrade" id="ddlGrade" class="form-control ih-medium ip-gray radius-xs b-light">
                                                                                               <%-- <option value="0">---Select---</option>
                                                                                                <option value="3">1st</option>
                                                                                                <option value="2">2nd</option>
                                                                                                <option value="1">3rd</option>--%>
                                                                                           
                                                                                            </select>
                                                                                        </div>
                                                                                        <span class="text-danger" id="ddlGradeError"></span>
                                                                                    </div>
                                                                                     <div class="col-lg-4 mb-10">
                                                                                        <label for="ddlOvertTime" class="color-dark fs-14 fw-500 align-center">Over Time </label>
                                                                                        <div class="input-group">

                                                                                            <select name="ddlOvertTime" id="ddlOvertTime" class="form-control ih-medium ip-gray radius-xs b-light">
                                                                                                
                                                                                                <option value="1" selected >Yes</option>
                                                                                                <option value="0">No</option>
                                                                                                <option value="">Single Rate</option>
                                                                                           
                                                                                            </select>
                                                                                        </div>
                                                                                        <span class="text-danger" id="ddlOvertTimeError"></span>
                                                                                    </div>
                                                                                     <div class="col-lg-4">
                                                                                        <div class="form-group">
                                                                                            <label for="txtGross" class=" color-dark fs-14 fw-500 align-center">Gross</label>
                                                                                            <div class="with-icon">
                                                                                                <span class="las la-money-bill"></span>
                                                                                                <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtGross">
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    
                                                                            
                                                                                </div>
                                                                                 <div class="row" id="salaryFieldsContainer"></div>



                                                                            </div>

                                                                        <div class="col-lg-4">
                                                                          <div class="card shadow-sm rounded p-3">
                                                                            <div class="text-center">
                                                                              <!-- Profile Image -->
                                                                              <img id="empImage" src="/hrms/user_img_default.jpg" alt="Employee Photo"
                                                                                   class="rounded-circle mb-3" width="100" height="100" />

                                                                              <!-- Employee Info -->
                                                                              <h5 id="empName" class="mb-1 fw-bold"></h5>
                                                                              <p id="empDesignation" class="mb-1 text-muted"></p>
                                                                              <p id="empDepartment" class="mb-1 text-muted"></p>

                                                                              <!-- Details -->
                                                                              <ul class="list-group list-group-flush mt-3 text-start">
                                                                                <li class="list-group-item py-1"><strong>Employee Id:</strong> <span id="empCardNo"></span></li>
                                                                                <li class="list-group-item py-1"><strong>Type:</strong> <span id="empType"></span></li>
                                                                              </ul>
                                                                            </div>
                                                                          </div>
                                                                        </div>

                                                                    </div>

                                                            


                                                                </form>
                                                            </div>

                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                <button type="button" class="btn btn-primary" id="saveSalaryBtn" onclick="SaveSalary();">Submit</button>
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
         </div>

        <script>
            var rootUrl = '<%= Session["__RootUrl__"]%>';
            var CompanyID = '<%= Session["__GetCompanyId__"]%>';
            var IsAdministrator = '<%= Session["__GetISAdministetor__"]%>';
            var getEmployeeeUrl = `${rootUrl}/api/Employee/employees`;
          

            var GetBankInfoURL = `${rootUrl}/api/BankInfo/basicInfo/${CompanyID}`;
            var GeGradeInfoURL = `${rootUrl}/api/Grade/grades?CompanyId=${CompanyID}`;
            var GetSalaryStractureURL = `${rootUrl}/api/Salary/salary-structure/${CompanyID}`;
            var GetEmployeeInfoByeIdURL = `${rootUrl}/api/Salary/SalaryInfo/${CompanyID}`;


            var getDepartmentUrl = `${rootUrl}/api/Department/basicInfo/${CompanyID}`;
            var getUnitUrl = `${rootUrl}/api/Unit/basicInfo?CompanyId=${CompanyID}`;
            var getEmpTypeUrl = `${rootUrl}/api/EmployeeType/basicInfo`;
            var PostSalarySaveURL = `${rootUrl}/api/Salary/salary-save`;
            var PostOverTimeConfigurationSaveURL = `${rootUrl}/api/OverTimeConfiguration/save`;



            var token = '<%= Session["__UserToken__"] %>';


            $(document).ready(function () {

                GetEmployees();
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
                $('#overTimeDate').val(formattedDate);
          
                GetUnit();
                GetDepartment();
                GetSalaryStracture();
                GetEmpType();

                $('#overTimeLimit').on('input', function () {
                    applyOverTimeLimitToEmployees($(this).val());
                });

                $('#overTimeLimit').on('change blur', function () {
                    const timeValue = normalizeTimeValue($(this).val());
                    $(this).val(timeValue);
                    applyOverTimeLimitToEmployees(timeValue);
                });

                $('#overTimeDate').on('change input', function () {
                    applyOverTimeDateToEmployees($(this).val());
                });

                $('#txtEmpCardNo').on('keypress', function (event) {
                    if (event.which === 13) {
                        event.preventDefault();
                        SearchEmployee();
                    }
                });
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


            function formatDate(date) {
                const day = String(date.getDate()).padStart(2, '0');
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const year = date.getFullYear();
                return `${year}-${month}-${day}`;
            }
            function SearchEmployee() {
                const timeValue = normalizeTimeValue($('#overTimeLimit').val());
                $('#overTimeLimit').val(timeValue);
                GetEmployees();

            }

            function showAttendanceHideEmployee() {
                $('#attendanceContainer').hide();
            }


            function GetEmployees() {
                const EmpCardNo = $('#txtEmpCardNo').val();

                const deptQuery = getSelectedDepartmentQuery();
                const unitQuery = getSelectedUnitQuery();
                const empTypeQuery = getSelectedEmpTypeQuery();
                const queryParts = [`CompanyId=${CompanyID}`];

                if (deptQuery) queryParts.push(deptQuery);
                if (unitQuery) queryParts.push(unitQuery);
                if (EmpCardNo && EmpCardNo.trim().length > 0) queryParts.push(`EmpCardNo=${encodeURIComponent(EmpCardNo.trim())}`);
                if (empTypeQuery) queryParts.push(empTypeQuery);

                const url = `${getEmployeeeUrl}?${queryParts.join('&')}`;

                ApiCall(url, token)
                    .then(response => {
                        if (response.statusCode === 200) {
                            const message = `Weekend employee data loaded for the period:`;
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
            let selectedEmpId = null;
            let selectedEmpType = null;

            function normalizeTimeValue(value) {
                if (!value) return '';

                let timeText = String(value).trim();

                if (/^\d{1,4}$/.test(timeText)) {
                    if (timeText.length <= 2) {
                        timeText = `${timeText}:00`;
                    } else if (timeText.length === 3) {
                        timeText = `${timeText.slice(0, 1)}:${timeText.slice(1)}`;
                    } else {
                        timeText = `${timeText.slice(0, 2)}:${timeText.slice(2)}`;
                    }
                }

                const match = timeText.match(/^(\d{1,2}):(\d{1,2})(?::\d{1,2})?$/);
                if (!match) return '';

                const hours = parseInt(match[1], 10);
                const minutes = parseInt(match[2], 10);

                if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) return '';

                return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}`;
            }

            function normalizeDateValue(value) {
                if (!value) return '';

                const dateText = String(value).trim();
                const isoMatch = dateText.match(/^(\d{4})-(\d{2})-(\d{2})/);
                if (!isoMatch) return '';

                const year = parseInt(isoMatch[1], 10);
                const month = parseInt(isoMatch[2], 10);
                const day = parseInt(isoMatch[3], 10);
                const date = new Date(year, month - 1, day);

                if (date.getFullYear() !== year || date.getMonth() !== month - 1 || date.getDate() !== day) return '';

                return `${isoMatch[1]}-${isoMatch[2]}-${isoMatch[3]}`;
            }

            function buildOverTimeLimitInput(empId, value) {
                const timeValue = normalizeTimeValue(value);
                return `<input type="text" value="${timeValue}" data-emp-id="${empId}" class="form-control overtime-limit-input" placeholder="HH:mm" maxlength="5" inputmode="numeric" pattern="^([01]?[0-9]|2[0-3]):[0-5][0-9]$">`;
            }

            function buildOverTimeDateInput(empId, value) {
                const dateValue = normalizeDateValue(value);
                return `<input type="date" value="${dateValue}" data-emp-id="${empId}" class="form-control overtime-date-input">`;
            }

            function applyOverTimeLimitToEmployees(value) {
                const timeValue = normalizeTimeValue(value);

                if (!timeValue) return;

                allEmployeeData.forEach(row => {
                    row.overTimeLimitValue = timeValue;
                    row.overTimeLimit = buildOverTimeLimitInput(row.empId, timeValue);
                });

                $('.overtime-limit-input').val(timeValue);
            }

            function applyOverTimeDateToEmployees(value) {
                const dateValue = normalizeDateValue(value);

                if (!dateValue) return;

                allEmployeeData.forEach(row => {
                    row.overTimeDateValue = dateValue;
                    row.overTimeDate = buildOverTimeDateInput(row.empId, dateValue);
                });

                $('.overtime-date-input').val(dateValue);
            }

            function bindOverTimeLimitChange() {
                $(document).off('change input blur', '.overtime-limit-input').on('change input blur', '.overtime-limit-input', function (event) {
                    const empId = $(this).data('emp-id');
                    const timeValue = normalizeTimeValue($(this).val());
                    const employee = allEmployeeData.find(row => String(row.empId) === String(empId));

                    if (employee) {
                        employee.overTimeLimitValue = timeValue;
                        employee.overTimeLimit = buildOverTimeLimitInput(employee.empId, timeValue);
                    }

                    if (event.type === 'change' || event.type === 'blur') {
                        $(this).val(timeValue);
                    }
                });
            }

            function bindOverTimeDateChange() {
                $(document).off('change input', '.overtime-date-input').on('change input', '.overtime-date-input', function () {
                    const empId = $(this).data('emp-id');
                    const dateValue = normalizeDateValue($(this).val());
                    const employee = allEmployeeData.find(row => String(row.empId) === String(empId));

                    if (employee) {
                        employee.overTimeDateValue = dateValue;
                        employee.overTimeDate = buildOverTimeDateInput(employee.empId, dateValue);
                    }
                });
            }

            function SaveOverTimeConfiguration() {
                if (!allEmployeeData.length) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'No Employee Found',
                        text: 'Please search or filter employees first.',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                const payload = allEmployeeData
                    .map(row => ({
                        companyId: CompanyID,
                        overTimeLimit: normalizeTimeValue(row.overTimeLimitValue),
                        empId: String(row.empId),
                        overTimeDate: normalizeDateValue(row.overTimeDateValue)
                    }))
                    .filter(row => row.empId && row.overTimeLimit && row.overTimeDate);

                if (!payload.length) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Overtime Data Required',
                        text: 'Please set overtime limit and date for at least one employee.',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                $('#btnSubmitOverTime').prop('disabled', true);

                $.ajax({
                    url: PostOverTimeConfigurationSaveURL,
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    headers: {
                        'Authorization': 'Bearer ' + token
                    },
                    data: JSON.stringify(payload),
                    success: function (response) {
                        if (response.statusCode === 200 || response.statusCode === 201 || response.success === true) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Overtime Configuration Saved',
                                text: 'Employee overtime limits saved successfully.',
                                confirmButtonText: 'OK'
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'API Error',
                                text: response.message || response.Message || 'Unexpected response from server.',
                                confirmButtonText: 'OK'
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        const response = xhr.responseJSON || {};
                        console.error('Overtime configuration save failed:', status, error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Request Failed',
                            text: response.message || response.Message || 'Something went wrong while saving overtime configuration.',
                            confirmButtonText: 'OK'
                        });
                    },
                    complete: function () {
                        $('#btnSubmitOverTime').prop('disabled', false);
                    }
                });
            }

            function bindTableData(data) {
                const $table = $('.adv-table');
                const defaultImage = '/hrms/user_img_default.jpg';

                allEmployeeData = data;
                if ($table.data('footable')) {
                    $table.data('footable').destroy();
                }
                const overtimeLimit = normalizeTimeValue($("#overTimeLimit").val());
                const overtimeDate = normalizeDateValue($("#overTimeDate").val());
                $table.html('');
                data.forEach((row, index) => {
                    row.serial = index + 1;
                    row.userImage = null;
                    const userImage = row.empImage || defaultImage;

                    row.action = `
            <div class="actions">
                <ul class="">
                    <li>
                        <a href="javascript:void(0)"
                         data-emp-id="${row.empId}" 
                         data-emp-type="${row.empType}" 
                         class="btn btn-primary btn-sm text-white delete-btn remove">
                            <i class="uil uil-money-insert"></i>Set Salary
                        </a>
                    </li>
                </ul>
            </div>`;
                    row.userImage = `
            <div class="user-details-container d-flex align-items-center">
                <img src="${userImage}" alt="User Image" class="user-image" style="width: 40px; height: 40px; margin-right: 10px;">
                <div>
                    <a href="javascript:void(0)" class="user-name" data-id="${row.empId}">${row.empName}</a>
                    <div class="user-role">${row.dsgName}</div>
                    <div class="user-role">${row.dptName}</div>
                </div>
            </div>
        `.trim();
                    row.overTimeLimitValue = overtimeLimit || normalizeTimeValue(row.overTimeLimit) || '';
                    row.overTimeLimit = buildOverTimeLimitInput(row.empId, row.overTimeLimitValue);
                    row.overTimeDateValue = overtimeDate || normalizeDateValue(row.overTimeDate) || '';
                    row.overTimeDate = buildOverTimeDateInput(row.empId, row.overTimeDateValue);
                });

                const columns = [
                    { name: "serial", title: "SL", breakpoints: "xs sm", type: "number", className: "userDatatable-content" },
                    { name: "userImage", title: "Name", className: "userDatatable-content", type: "html" },
                    { name: "empCardNo", title: "Employee ID", className: "userDatatable-content" },
                    { name: "empType", title: "Emp Type", className: "userDatatable-content" },
                    { name: "joiningDate", title: "Joining Date", className: "userDatatable-content" },
                    { name: "overTimeLimit", title: "OverTime Limit", type: "html", className: "userDatatable-content" },
                    { name: "overTimeDate", title: "OverTime Date", type: "html", className: "userDatatable-content" }
                    
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
                    });


                } catch (error) {
                    console.error("Error initializing table:", error);

                }

                bindOverTimeLimitChange();
                bindOverTimeDateChange();

              

                $(document).off('click', '.delete-btn').on('click', '.delete-btn', function () {
                    selectedEmpId = $(this).data('emp-id');
                    selectedEmpType = $(this).data('emp-type');

                    $('#empIdField').val(selectedEmpId);

                    $('#empTypeField').val(selectedEmpType); 

                    console.log(selectedEmpType)
                    console.log(selectedEmpId)

                    $('#salaryModal').modal('show');
                });

                $('#salaryModal').on('shown.bs.modal', function () {
                    GetBankInfo();
                    GetGradeInfo();
                  

                    const roleKey = selectedEmpType ?.toLowerCase(); // "worker", "staff", etc.
                    renderDynamicSalaryFields(roleKey);


                      GetEmployeeInfoByeId(selectedEmpId);
                });
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

            var salaryStructureCache = {};

            function GetSalaryStracture() {
                ApiCall(GetSalaryStractureURL, token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            var data = response.data;

                            for (var role in data) {
                                for (var key in data[role]) {
                                    var cleanKey = key.trim(); 
                                    var cacheKey = role + " " + cleanKey;
                                    salaryStructureCache[cacheKey] = data[role][key];
                                }
                            }

                            console.log("Salary structure cached:", salaryStructureCache);
                        }
                    })
                    .catch(function (error) {
                        console.error("Error loading employee info:", error);
                    });
            }



            function GetEmployeeInfoByeId(EmpId) {
                ApiCall(`${GetEmployeeInfoByeIdURL}/${EmpId}`, token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            var data = response.data;

                            // --- Dropdowns ---
                           $('#ddlOvertTime').val(data.isSingleRateOT ? '' : (data.isOverTime ? '1' : '0'));
                            $('#ddlPaymentMethod').val(data.paymentMethod ?? '0');
                            $('#ddlSalaryBank').val(data.bankId ?? '0');
                            $('#ddlGrade').val(data.grdId ?? '');

                            // --- Textboxes ---
                            $('#txtAccountNo').val(data.empAccountNo ?? '');
                            $('#txtGross').val((data.empPresentSalary ?? 0).toFixed(2));
                            $('#txtBasic').val((data.basicSalary ?? 0).toFixed(2));
                            $('#txtMedical').val((data.medicalAllownce ?? 0).toFixed(2));
                            $('#txtFood').val((data.foodAllownce ?? 0).toFixed(2));
                            $('#txtConveyance').val((data.convenceAllownce ?? 0).toFixed(2));
                            $('#txtTechnical').val((data.technicalAllownce ?? 0).toFixed(2));
                            $('#txtHouse_rent').val((data.houseRent ?? 0).toFixed(2));
                            $('#txtOthers').val((data.othersAllownce ?? 0).toFixed(2));
                            $('#txtAttBonuse').val((data.attendanceBonus ?? 0).toFixed(2));
                            $('#txtDormetory').val((data.dormitoryRent ?? 0).toFixed(2));
                            $('#txtTds').val((data.incomeTax ?? 0).toFixed(2));


                            $('#empName').text(data.empName ?? 'N/A');
                            $('#empDesignation').text(data.dsgName ?? 'N/A');
                            $('#empDepartment').text(data.dptName ?? 'N/A');
                            $('#empCardNo').text(data.empCardNo ? data.empCardNo.slice(-6) : 'N/A');
                            $('#empType').text(data.empType ?? 'N/A');

                            // Profile Image Handling
                            let imagePath = data.empPicture && data.empPicture.trim() !== ''
                                ? data.empPicture
                                : '/hrms/user_img_default.jpg';
                            $('#empImage').attr('src', imagePath);

                        }
                    })
                    .catch(function (error) {
                        console.error("Error loading employee info:", error);
                    });
            }


            function GetBankInfo() {
                ApiCall(GetBankInfoURL, token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            var responseData = response.data;
                            EmployeePopulateDropdown(responseData);
                        } else {
                            console.error('Error occurred while fetching data:', response.message);
                            const dropdown = document.getElementById('ddlSalaryBank');
                            dropdown.innerHTML = '<option value="0">---Select---</option>';
                        }
                    })
                    .catch(function (error) {
                        $('.loaderCosting').hide();
                        console.error('Error occurred while fetching data:', error);
                        const dropdown = document.getElementById('ddlSalaryBank');
                        dropdown.innerHTML = '<option value="0">---Select---</option>';
                    });
            }

            function EmployeePopulateDropdown(data) {
                const dropdown = document.getElementById('ddlSalaryBank');
                if (!dropdown) {
                    console.warn('ddlSalaryBank not found in DOM when trying to bind data.');
                    return;
                }

                dropdown.innerHTML = '<option value="0">---Select---</option>';

                data.forEach(item => {
                    const option = document.createElement('option');
                    option.value = item.id;
                    option.textContent = item.name;
                    dropdown.appendChild(option);
                });
            }


            function GetGradeInfo() {
                ApiCall(GeGradeInfoURL, token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            var responseData = response.data;
                            GradePopulateDropdown(responseData);
                        } else {
                            console.error('Error occurred while fetching data:', response.message);
                            const dropdown = document.getElementById('ddlGrade');
                            dropdown.innerHTML = '<option value="0">---Select---</option>';
                        }
                    })
                    .catch(function (error) {
                        $('.loaderCosting').hide();
                        console.error('Error occurred while fetching data:', error);
                        const dropdown = document.getElementById('ddlGrade');
                        dropdown.innerHTML = '<option value="0">---Select---</option>';
                    });
            }

            function GradePopulateDropdown(data) {
                const dropdown = document.getElementById('ddlGrade');
                if (!dropdown) {
                    console.warn('ddlGrade not found in DOM when trying to bind data.');
                    return;
                }

                dropdown.innerHTML = '<option value="0">---Select---</option>';

                data.forEach(item => {
                    const option = document.createElement('option');
                    option.value = item.gradeId;
                    option.textContent = item.grdName;
                    dropdown.appendChild(option);
                });
            }

            function renderDynamicSalaryFields(roleKey) {
                const container = $('#salaryFieldsContainer');
                container.empty();

                let structure = salaryStructureCache[roleKey];

                if (!structure) {
                    structure = groupSalaryStructure(roleKey); // fallback
                }

                if (!structure || Object.keys(structure).length === 0) {
                    container.append(`<p class="text-danger">No salary structure found for "${roleKey}"</p>`);
                    return;
                }

                Object.entries(structure).forEach(([fieldKey, fieldData]) => {
                    const label = fieldData.label || fieldKey;
                    const value = fieldData.value || '';
                    const msg = fieldData.msg || '';
                    const calculationType = fieldData.calculationType || '';
                    const id = `txt${capitalize(fieldKey)}`;
                    const msgId = `${id}Msg`;
                    let msgHtml = '';
                    if (calculationType === 'formula') {
                        msgHtml = ` <small class="text-info fs-12" title="${msg}" style="font-size:10px; cursor: help; margin-left:5px;" >Formula </small> `;
                    } else {
                        msgHtml = `<small id="${msgId}" style="margin-left:5px;font-size:10px" class="text-primary fs-12">${msg}</small> `;
                    }

                            const fieldHtml = `
                <div class="col-lg-4" id="Section${capitalize(fieldKey)}">
                    <div class="form-group">
                        <label for="${id}" class="color-dark fs-14 fw-500 align-center">${label}
                            ${msgHtml}
                        </label>
                        <div class="with-icon">
                            <span class="las la-money-bill"></span>
                            <input type="number" 
                                class="form-control ih-medium ip-gray radius-xs b-light" 
                                id="${id}" 
                                name="${fieldKey}" 
                                data-calculation-type="${calculationType}"
                                data-formula="${calculationType === 'formula' ? value : ''}"
                                value="${calculationType === 'fixed' ? value : ''}" 
                                disabled>
                        </div>
                    </div>
                </div>
            `;
                    container.append(fieldHtml);
                });

            }

            function groupSalaryStructure(roleKey) {
                const grouped = {};
                Object.entries(salaryStructureCache).forEach(([fullKey, value]) => {
                    if (fullKey.startsWith(roleKey + " ")) {
                        const shortKey = fullKey.replace(roleKey + " ", "");
                        grouped[shortKey] = value;
                    }
                });
                return grouped;
            }


            function capitalize(str) {
                return str.charAt(0).toUpperCase() + str.slice(1);
            }
            $('#salaryFieldsContainer').on('input', '#txtGross', function () {
                const grossValue = parseFloat($(this).val()) || 0;
                const inputs = {};

                $('#salaryFieldsContainer input').each(function () {
                    const name = $(this).attr('name');
                    const val = parseFloat($(this).val()) || 0;
                    inputs[name] = val;
                });
                inputs.gross = grossValue;

                $('#salaryFieldsContainer input').each(function () {
                    const type = $(this).data('calculation-type');
                    const formula = $(this).data('formula');
                    if (type === 'formula' && formula) {
                        try {
                            const result = math.evaluate(formula, inputs);
                            $(this).val(result.toFixed(2));
                        } catch (err) {
                            console.warn(`Error evaluating formula for ${$(this).attr('name')}:`, err);
                        }
                    }
                });
            });


            function getDynamicFormulas() {
                const roleKey = selectedEmpType?.toLowerCase();
                const formulas = {};

                if (!roleKey) return formulas;

                for (const key in salaryStructureCache) {
                    if (key.startsWith(roleKey)) {
                        const fieldName = key.replace(`${roleKey} `, '');
                        const item = salaryStructureCache[key];
                        formulas[fieldName] = item;
                    }
                }

                return formulas;
            }
            
            document.getElementById('txtGross').addEventListener('input', function () {
                const grossValue = parseFloat(this.value);
                if (!isNaN(grossValue)) {
                    calculateSalary(grossValue);
                } else {
                    document.getElementById('txtBasic').value = '';
                    document.getElementById('txtHouse_rent').value = '';
                    if (document.getElementById('txtPf')) {
                        document.getElementById('txtPf').value = '';
                    }
                }
            });
            function calculateSalary(grossValue) {
                const formulas = getDynamicFormulas();
                const scope = {
                    gross: grossValue
                };

                try {
                    for (const [key, formula] of Object.entries(formulas)) {
                        if (formula.calculationType === 'fixed') {
                            scope[key] = Math.round(formula.value);
                        }
                    }

         
                    for (const [key, formula] of Object.entries(formulas)) {
                        if (formula.calculationType === 'percentage') {
                           scope[key] = Math.round(math.evaluate(formula.value, scope));
                        }
                    }
                    for (const [key, formula] of Object.entries(formulas)) {
                        if (formula.calculationType === 'formula') {
                            scope[key] = Math.round(math.evaluate(formula.value, scope));
                        }
                    }

                    for (const key in formulas) {
                        if (key === 'house_rent')
                        {
                            console.log(key);
                        }
                        const htmlId = 'txt' + key.charAt(0).toUpperCase() + key.slice(1);

                        const element = document.getElementById(htmlId);
                        const value =  Math.round(scope[key]);

                        if (element) {
                            if (typeof value === 'number') {
                                element.value = value > 0 ? value.toFixed(2) : '';
                            } else {
                                element.value = value ?? '';
                            }
                        }
                    }

                } catch (err) {
                    console.error('Formula calculation error:', err);

                    // Reset all relevant fields on error
                    for (const key in formulas) {
                        const htmlId = 'txt' + key.replace(/(^\w|_\w)/g, match => match.replace('_', '').toUpperCase());
                        const element = document.getElementById(htmlId);
                        if (element) element.value = '';
                    }
                }
            }



            function SaveSalary() {
                let empType = '';

                if (selectedEmpType === 'Worker') {
                    empType = '1';
                } else if (selectedEmpType === 'Staff') {
                    empType = '2';
                } else {
                    empType = '3';
                }
                const salaryData = {
                    empId: selectedEmpId,
                    empType: empType,
                    paymentMethod: parseInt($('#ddlPaymentMethod').val()),
                    bankId: parseInt($('#ddlSalaryBank').val()),
                    empAccountNo: $('#txtAccountNo').val().trim(),
                    empPresentSalary: parseFloat($('#txtGross').val()),
                    basicSalary: parseFloat($('#txtBasic').val()) || 0,
                    overTime: $('#ddlOvertTime').val() === "1" ? true : $('#ddlOvertTime').val() === "0" ? false : null,
                    grdId: $('#ddlGrade').val(),
                    companyId: CompanyID
                };

                const txtMedical = document.getElementById('txtMedical');
                if (txtMedical) {
                    salaryData.medicalAllowance = parseFloat(txtMedical.value) || 0;
                }
                const txtConveyance = document.getElementById('txtConveyance');
                if (txtConveyance) {
                    salaryData.conveyanceAllowance = parseFloat(txtConveyance.value) || 0;
                }

                const txtHouseRent = document.getElementById('txtHouse_rent');
                if (txtHouseRent) {
                    salaryData.houseRent = parseFloat(txtHouseRent.value) || 0;
                }
                const txtFood = document.getElementById('txtFood');
                if (txtFood) {
                    salaryData.foodAllowance = parseFloat(txtFood.value) || 0;
                }

                ApiCallPost(PostSalarySaveURL, token, salaryData)
                    .then(response => {
                        if (response.statusCode === 200) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Salary Saved Successfully',
                                text: 'Thank you!',
                                confirmButtonText: 'OK'
                            });
                            const newSalary = parseInt($('#txtGross').val()) || 0;
                            const empId = selectedEmpId; 

                            const index = allEmployeeData.findIndex(emp => emp.empId == empId);
                            if (index !== -1) {
                                allEmployeeData[index].empPresentSalary = newSalary;
                            }
                            const row = $(`.adv-table tbody tr`).filter(function () {
                                return $(this).find('a.user-name').data('id') == empId;
                            });

                            if (row.length) {
                                row.find('td').eq(4).text(newSalary);
                            }
                                $('#salaryModal').modal('hide');
                            
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'API Error',
                                text: response.message || 'Unexpected response from server.',
                                confirmButtonText: 'OK'
                            });
                            console.error('API Error:', response.message);
                        }
                    })
                    .catch(error => {
                        console.error('Request failed:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Request Failed',
                            text: 'Something went wrong while saving salary.',
                            confirmButtonText: 'OK'
                        });
                    });
            }





        </script>

    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjs/11.11.2/math.min.js"></script>
</asp:Content>
