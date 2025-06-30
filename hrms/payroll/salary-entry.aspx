<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="salary-entry.aspx.cs" Inherits="SigmaERP.hrms.payroll.salary_entry" %>
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
            
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
            <div class="mt-1">
        <div class="products_page product_page--grid mb-30">
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-lg-3 col-sm-12 mb-lg-0 mb-30">
                        <div class="card">
                            <div id="toggleFilter5" class="card-header px-20 py-15" style="cursor: pointer;">
                                <h6 class="d-flex justify-between align-items-center fw-500 w-100">
                                    <span class="d-flex align-items-center" style="font-size:16px; color:black";>
                                        <img src="../img/svg/sliders.svg" alt="sliders" class=" me-2" style="height: 16px !important; width: 16px !important">
                                        Filter by Emp. Type
                                    </span>
                                    <i id="arrowIcon1" class="fas fa-chevron-down"></i> <!-- Arrow icon -->
                                </h6>
                            </div>
                            <div class="card-body">
                                <aside class="">
                                    <div class="card border-0 shadow-none multi-collapse mt-10 collapse show"  id="multiCollapseExample91"><!-- test Git  -->
                                        <div class="product-brands" overflow-y: auto;">

                                        
                                         
                                                <div class="input-group">
                                                    <select name="ddlSearchType" id="ddlSearchType" class="form-control me-2">
                                                        <option value="">All </option>
                                                        <option value="Staff">Staff </option>
                                                        <option value="Worker">Worker</option>
                                                    </select>
                                                </div>
                                          
                                        </div>
                                    </div>
                                </aside>
                            </div>
                        </div>
                                                <div class="card">
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
                                                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3 align-items-end">

                                                            <!-- Search Input -->



                                                            <div class="col-lg-4">
                                                                
                                                                <div class="input-group mt-2">
                                                                    <span class="input-group-text bg-white border-end-0">
                                                                        <i class="uil uil-search"></i>
                                                                    </span>
                                                                    <input type="text" id="txtEmpCardNo" class="form-control border-start-0" placeholder="Type Employee ID" aria-describedby="searchIcon">
                                                                     <button type="button" title="Search" id="btnSearch" onclick="SearchEmployee()"
                                                                        class="btn btn-primary text-center"
                                                                        style="padding: 7px;">
                                                                        <i class="fas fa-search"  style="font-size: 18px"></i>
                                                                    </button>
                                                                </div>
                                                            </div>

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
            var PostSalarySaveURL = `${rootUrl}/api/Salary/salary-save`;



            var token = '<%= Session["__UserToken__"] %>';


            $(document).ready(function () {

                GetEmployees();
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
                GetSalaryStracture();

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


                GetEmployees();

            }

            function showAttendanceHideEmployee() {
                $('#attendanceContainer').hide();
            }


            function GetEmployees() {
                  const EmpCardNo = $('#txtEmpCardNo').val();
                const EmpType = $('#ddlSearchType').val();

                const deptQuery = getSelectedDepartmentQuery();
                const unitQuery = getSelectedUnitQuery();

                let empCardNo = '';
                let emptype = '';

                if (EmpCardNo && EmpCardNo.length > 0) {
                    empCardNo = `&EmpCardNo=${EmpCardNo}`;
                }

                if (EmpType && EmpType.length > 0) {
                    emptype = `&EmpType=${EmpType}`;
                }
                const url = `${getEmployeeeUrl}?CompanyId=${CompanyID}&${deptQuery}${empCardNo}${emptype}`;

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
                });

                const columns = [
                    { name: "serial", title: "SL", breakpoints: "xs sm", type: "number", className: "userDatatable-content" },
                    { name: "userImage", title: "Name", className: "userDatatable-content", type: "html" },
                    { name: "empCardNo", title: "Employee ID", className: "userDatatable-content" },
                    { name: "empType", title: "Emp Type", className: "userDatatable-content" },
                    { name: "empPresentSalary", title: "Salary", className: "userDatatable-content" },
                    { name: "joiningDate", title: "Joining Date", className: "userDatatable-content" },
                    { name: "action", title: "Action", className: "userDatatable-content" }
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
                            scope[key] = formula.value;
                        }
                    }

         
                    for (const [key, formula] of Object.entries(formulas)) {
                        if (formula.calculationType === 'percentage') {
                            scope[key] = math.evaluate(formula.value, scope);
                        }
                    }
                    for (const [key, formula] of Object.entries(formulas)) {
                        if (formula.calculationType === 'formula') {
                            scope[key] = math.evaluate(formula.value, scope);
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
                const empType = selectedEmpType === 'Worker' ? 1 : 2;
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
