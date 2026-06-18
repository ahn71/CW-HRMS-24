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
         .roster-import-panel {
             align-items: flex-end;
             display: flex;
             gap: 8px;
             justify-content: flex-end;
         }
         .roster-import-file {
             max-width: 230px;
         }
         .roster-modal-table th {
             background: #f8fafc;
             color: #334155;
             font-size: 12px;
             font-weight: 600;
             text-transform: uppercase;
             white-space: nowrap;
         }
         .roster-modal-table td {
             color: #111827;
             font-size: 13px;
             vertical-align: middle;
         }
         .roster-modal-table .form-control {
             min-width: 145px;
         }
         .roster-import-summary {
             color: #64748b;
             font-size: 12px;
         }
         .roster-selected-file {
             color: #475569;
             font-size: 12px;
             margin-top: 4px;
             max-width: 100%;
             overflow: hidden;
             text-overflow: ellipsis;
             white-space: nowrap;
         }
         @media (max-width: 991px) {
             .roster-import-panel {
                 align-items: stretch;
                 flex-direction: column;
             }
             .roster-import-file {
                 max-width: 100%;
             }
         }
        </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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
                                                            <div class="col-lg-4 ml-auto">
                                                                <label for="rosterExcelFile" class="form-label mb-1 p-0">Excel Import</label>
                                                                <div class="roster-import-panel">
                                                                    <input type="file" id="rosterExcelFile" class="form-control roster-import-file" accept=".xlsx,.xls,.csv">
                                                                    <button type="button" id="btnRosterImport" class="btn btn-primary btn-sm" onclick="ImportRosterExcel()">
                                                                        Import
                                                                    </button>
                                                                    <button type="button" id="btnRosterDemo" class="btn btn-outline-primary btn-sm" onclick="DownloadRosterDemo()">
                                                                        Demo
                                                                    </button>
                                                                </div>
                                                                <div id="rosterSelectedFileName" class="roster-selected-file">No file selected</div>
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

        <div class="modal fade" id="rosterImportModal" tabindex="-1" role="dialog" aria-labelledby="rosterImportModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div>
                            <h5 class="modal-title" id="rosterImportModalLabel">Imported Roster Preview</h5>
                            <div id="rosterImportSummary" class="roster-import-summary"></div>
                        </div>
                        <button type="button" class="close" aria-label="Close" onclick="CloseRosterImportModal()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover roster-modal-table mb-0">
                                <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Employee ID</th>
                                        <th>Name</th>
                                        <th>Department</th>
                                        <th>Designation</th>
                                        <th>Shift</th>
                                        <th>Roster Date</th>
                                    </tr>
                                </thead>
                                <tbody id="rosterImportTableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light btn-sm" onclick="CloseRosterImportModal()">Close</button>
                        <button type="button" id="btnSubmitImportedRoster" class="btn btn-success btn-sm" onclick="SubmitImportedRoster()">Submit</button>
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
            var getEmpTypeUrl = `${rootUrl}/api/EmployeeType/basicInfo`;
            var getEmployeesByCardNumbersUrl = `${rootUrl}/api/Employee/by-card-numbers?companyId=${CompanyID}`;


            var token = '<%= Session["__UserToken__"] %>';
            var rosterShiftList = [];
            var importedRosterRows = [];

            $(document).on('change', '#rosterExcelFile', function () {
                const fileName = this.files && this.files.length > 0 ? this.files[0].name : 'No file selected';
                $('#rosterSelectedFileName').text(fileName);
            });


            $(document).ready(function () {

               // GetEmployees();

               // $('#DataSubmitContainer').hide();
                $('#toggleFilter').on('click', function () {
                    unitToggle();
                });

                $('#toggleDepartment').on('click', function () {
                    DepartmentToggle();
                });
                $('#toggleEmpType').on('click', function () {
                    EmpTypetToggle();
                });
                GetShifts();
                GetNewShifts();
                GetUnit();
                GetDepartment();
                GetEmpType();

            });

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

                const deptQuery = getSelectedDepartmentQuery(); // string: DptIds=0002&DptIds=0003
                const empTypeQuery = getSelectedEmpTypeQuery(); // string: EmpTypeIds=2&EmpTypeIds=1
                const unit = getSelectedUnitQuery(); // string: key=value

                const params = new URLSearchParams();
                params.append('CompanyId', CompanyID);

                if (EmpCardNo) {
                    params.append('EmpCardNo', EmpCardNo);
                }

                if (Shift && Shift !== 'null') {
                    params.append('SftId', Shift);
                }

                params.append('DeautyType', 'Roster');

                // Show loader
                $('.loaderDaily').show();
                $('.loaderparent').css('opacity', '0.5');

                // Build base URL with core params
                let url = `${getEmployeeeUrl}?${params.toString()}`;

                // Append additional query strings if available
                if (deptQuery) {
                    url += `&${deptQuery}`;
                }
            
                if (empTypeQuery) {
                    url += `&${empTypeQuery}`;
                }
                if (unit) {           
                    url += `&${unit}`;
                }

                var DataAccessLevel = '<%=Session["__UserDataAccessLevel__"]%>';

                var dptIds = '<%=Session["__DptAccessPermission__"]%>';
                var UserdptId = '<%=Session["__DptId__"]%>';
                var departmentIds = dptIds ? JSON.parse(dptIds) : [];
                var dptParam = encodeURIComponent(JSON.stringify(departmentIds));
                if (deptQuery == '' || deptQuery == null) {
                    if (DataAccessLevel == 2) {
                       url += `&DptIds=${encodeURIComponent(UserdptId)}`;
                    }
                    else if (DataAccessLevel == 4) {
                        var dptQueryString = departmentIds
                            .map(function (id) {
                                return 'DptIds=' + encodeURIComponent(id);
                            })
                            .join('&');

                        url += '&' + dptQueryString;
                    }
                }
                // API call
                ApiCall(url, token)
                    .then(response => {
                        $('.loaderDaily').hide();
                        $('.loaderparent').css('opacity', '1');

                        if (response.statusCode === 200) {
                            $('#alertContainer').hide();
                            $('#DataSubmitContainer').show();
                            bindTableData(response.data);
                        } else {
                            console.error('API Error:', response.message);
                            bindTableData([]);
                        }
                    })
                    .catch(error => {
                        console.error('Network Error:', error);
                        bindTableData([]);
                        $('.loaderDaily').hide();
                        $('.loaderparent').css('opacity', '1');
                    });
            }




            //function GetEmployees() {
            //    const EmpCardNo = $('#txtEmpCardNo').val();
            //    const Shift = $('#ddlShift').val();
            //    const deptQuery = getSelectedDepartmentQuery(); 
            //    const empTypeQuery = getSelectedEmpTypeQuery();
            //    const unit = getSelectedUnitQuery();
            //    let empCardNo = '';
            //    if (EmpCardNo && EmpCardNo.length > 0) {
            //        empCardNo = `&EmpCardNo=${EmpCardNo}`;
            //    }

            //    let shiftId = '';
            //    if (Shift !== null && Shift !== 'null') {
            //        shiftId = `&SftId=${Shift}`;
            //    }

            //    let dutyType = '&DeautyType=Roster';

            //   $('.loaderDaily').show();
            //   $('.loaderparent').css('opacity', '0.5');
            //    const url = `${getEmployeeeUrl}?CompanyId=${CompanyID}&${deptQuery}${empCardNo}${shiftId} ${dutyType}&${empTypeQuery}&${unit}`;

            //    ApiCall(url, token)
            //        .then(response => {
            //            if (response.statusCode === 200) {
            //                const message = `Weekend employee data loaded for the period:`;
            //                $('#alertContainer').hide();
            //                $('#DataSubmitContainer').show();
            //                $('.loaderDaily').hide();
            //                $('.loaderparent').css('opacity', '1');
            //                bindTableData(response.data);
                       
            //            } else {
            //                console.error('API Error:', response.message);
            //                bindTableData([]);
            //                $('.loaderDaily').hide();
            //                $('.loaderparent').css('opacity', '1');
            //            }
            //        })
            //        .catch(error => {
            //            console.error('Network Error:', error);
            //            bindTableData([]);
            //            $('.loaderDaily').hide();
            //            $('.loaderparent').css('opacity', '1');
            //        });
            //}


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
                rosterShiftList = data || [];
                const dropdown = document.getElementById('ddlNewShift');
                dropdown.innerHTML = '<option value="null">---Select---</option>';

                data.forEach(item => {
                    const option = document.createElement('option');
                    option.value = item.id;
                    option.textContent = item.name;
                    dropdown.appendChild(option);
                });

            }

            function DownloadRosterDemo() {
                const demoData = [
                    { EmployeeId: '993050', Name: 'Demo Employee 1', Shift: '1', RosterDate: formatDate(new Date()) },
                    { EmployeeId: '993795', Name: 'Demo Employee 2', Shift: '1', RosterDate: formatDate(new Date()) },
                    { EmployeeId: '993918', Name: 'Demo Employee 3', Shift: '1', RosterDate: formatDate(new Date()) }
                ];

                if (typeof XLSX === 'undefined') {
                    const csv = 'EmployeeId,Name,Shift,RosterDate\r\n' +
                        demoData.map(row => `${row.EmployeeId},${row.Name},${row.Shift},${row.RosterDate}`).join('\r\n');
                    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
                    downloadBlob(blob, 'Roster_Import_Demo.csv');
                    return;
                }

                const worksheet = XLSX.utils.json_to_sheet(demoData);
                const workbook = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(workbook, worksheet, 'Roster Import');
                XLSX.writeFile(workbook, 'Roster_Import_Demo.xlsx');
            }

            function downloadBlob(blob, fileName) {
                const link = document.createElement('a');
                link.href = URL.createObjectURL(blob);
                link.download = fileName;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                URL.revokeObjectURL(link.href);
            }

            function ImportRosterExcel() {
                const fileInput = document.getElementById('rosterExcelFile');
                const file = fileInput.files && fileInput.files[0];

                if (!file) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'File Required',
                        text: 'Please select an Excel file first.',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                if (typeof XLSX === 'undefined') {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Excel Library Missing',
                        text: 'XLSX library is not loaded. Please reload the page and try again.',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                const reader = new FileReader();
                reader.onload = function (event) {
                    try {
                        const workbook = XLSX.read(new Uint8Array(event.target.result), {
                            type: 'array',
                            cellDates: true
                        });
                        const firstSheet = workbook.Sheets[workbook.SheetNames[0]];
                        const rows = XLSX.utils.sheet_to_json(firstSheet, { defval: '' });
                        const parsedRows = normalizeRosterImportRows(rows);

                        if (parsedRows.length === 0) {
                            Swal.fire({
                                icon: 'warning',
                                title: 'No Valid Data',
                                text: 'Excel file must contain EmployeeId, Name, Shift and RosterDate columns.',
                                confirmButtonText: 'OK'
                            });
                            return;
                        }

                        LoadImportedEmployees(parsedRows);
                    } catch (error) {
                        console.error('Excel read error:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Invalid File',
                            text: 'Could not read the selected file.',
                            confirmButtonText: 'OK'
                        });
                    }
                };
                reader.readAsArrayBuffer(file);
            }

            function normalizeRosterImportRows(rows) {
                return rows.map(function (row) {
                    const rosterDateValue = getCellValue(row, 'RosterDate') || getCellValue(row, 'RosterDate(yyy-MM-dd)');
                    return {
                        employeeId: getCellValue(row, 'EmployeeId'),
                        excelName: getCellValue(row, 'Name'),
                        shift: getCellValue(row, 'Shift'),
                        rosterDate: normalizeExcelDate(rosterDateValue)
                    };
                }).filter(function (row) {
                    return row.employeeId && row.shift && row.rosterDate;
                });
            }

            function getCellValue(row, columnName) {
                const key = Object.keys(row).find(function (item) {
                    return item.replace(/\s/g, '').toLowerCase() === columnName.toLowerCase();
                });
                if (!key) {
                    return '';
                }

                const value = row[key];
                if (Object.prototype.toString.call(value) === '[object Date]') {
                    return value;
                }

                return String(value).trim();
            }

            function normalizeExcelDate(value) {
                if (!value) {
                    return '';
                }

                if (Object.prototype.toString.call(value) === '[object Date]' && !isNaN(value)) {
                    return formatDate(value);
                }

                if (!isNaN(value) && Number(value) > 25569) {
                    const parsedDate = new Date((Number(value) - 25569) * 86400 * 1000);
                    return formatDate(parsedDate);
                }

                const text = String(value).trim();
                const parts = text.split(/[\/\-\.]/);
                if (parts.length === 3) {
                    const isYearFirst = parts[0].length === 4;
                    const yearPart = isYearFirst ? parts[0] : parts[2];
                    const monthPart = isYearFirst ? parts[1] : parts[1];
                    const dayPart = isYearFirst ? parts[2] : parts[0];
                    const day = dayPart.padStart(2, '0');
                    const month = monthPart.padStart(2, '0');
                    const year = yearPart.length === 2 ? `20${yearPart}` : yearPart;
                    return `${year}-${month}-${day}`;
                }

                const directDate = new Date(text);
                if (!isNaN(directDate)) {
                    return formatDate(directDate);
                }

                return '';
            }

            function LoadImportedEmployees(parsedRows) {
                const cardNumbers = [...new Set(parsedRows.map(function (row) {
                    return row.employeeId;
                }))];

                $('.loaderDaily').show();
                $('.loaderparent').css('opacity', '0.5');

                $.ajax({
                    url: getEmployeesByCardNumbersUrl,
                    type: 'POST',
                    contentType: 'application/json',
                    dataType: 'json',
                    headers: {
                        'Authorization': 'Bearer ' + token
                    },
                    data: JSON.stringify({ cardNumbers: cardNumbers }),
                    
                    success: function (response) {
                        const employees = normalizeApiData(response);
                        console.log("Imported employees",employees)
                        importedRosterRows = buildImportedRosterRows(parsedRows, employees);
                        console.log("Imported data",importedRosterRows)
                        BindRosterImportTable(importedRosterRows);
                        $('#rosterImportSummary').text(`${importedRosterRows.length} row(s) ready. You can edit Shift and Roster Date before submit.`);
                        OpenRosterImportModal();
                    },
                    error: function (xhr) {
                        const message = (xhr.responseJSON && (xhr.responseJSON.message || xhr.responseJSON.Message)) || xhr.responseText || 'Employee data could not be loaded.';
                        Swal.fire({
                            icon: 'warning',
                            title: 'Import Failed',
                            text: message,
                            confirmButtonText: 'OK'
                        });
                    },
                    complete: function () {
                        $('.loaderDaily').hide();
                        $('.loaderparent').css('opacity', '1');
                    }
                });
            }

            function normalizeApiData(response) {
                if (Array.isArray(response)) {
                    return response;
                }
                if (response && Array.isArray(response.data)) {
                    return response.data;
                }
                if (response && response.data && Array.isArray(response.data.items)) {
                    return response.data.items;
                }
                return [];
            }

            function buildImportedRosterRows(parsedRows, employees) {
                return parsedRows.map(function (row, index) {
                    const employee = employees.find(function (item) {
                        return getEmployeeCardNumber(item) === row.employeeId;
                    }) || {};

                    return {
                        serial: index + 1,
                        empId: employee.empId || employee.id || employee.employeeId || '',
                        empCardNo: getEmployeeCardNumber(employee) || row.employeeId,
                        empName: employee.empName || employee.name || row.excelName,
                        dptName: employee.dptName || employee.departmentName || '',
                        dsgName: employee.dsgName || employee.designationName || '',
                        shiftId: resolveShiftId(row.shift),
                        shiftText: row.shift,
                        rosterDate: row.rosterDate
                    };
                }).filter(function (row) {
                    return row.empId;
                });
            }

            function getEmployeeCardNumber(employee) {
                return String(
                    employee.empCard ||
                    employee.empCardNo ||
                    employee.cardNo ||
                    employee.cardNumber ||
                    employee.employeeCard ||
                    employee.employeeId ||
                    ''
                ).trim();
            }

            function resolveShiftId(value) {
                const shiftText = String(value || '').trim();
                if (!shiftText) {
                    return '';
                }

                const matchedShift = rosterShiftList.find(function (shift) {
                    return String(shift.id) === shiftText || String(shift.name).trim().toLowerCase() === shiftText.toLowerCase();
                });

                return matchedShift ? matchedShift.id : shiftText;
            }

            function BindRosterImportTable(rows) {
                const $tbody = $('#rosterImportTableBody');
                $tbody.empty();

                rows.forEach(function (row, index) {
                    $tbody.append(`
                        <tr data-index="${index}">
                            <td>${index + 1}</td>
                            <td>${escapeHtml(row.empCardNo)}</td>
                            <td>${escapeHtml(row.empName)}</td>
                            <td>${escapeHtml(row.dptName)}</td>
                            <td>${escapeHtml(row.dsgName)}</td>
                            <td>
                                <select class="form-control import-shift" data-index="${index}">
                                    ${getShiftOptions(row.shiftId, row.shiftText)}
                                </select>
                            </td>
                            <td>
                                <input type="date" class="form-control import-roster-date" data-index="${index}" value="${row.rosterDate}">
                            </td>
                        </tr>
                    `);
                });

                if (rows.length === 0) {
                    $tbody.append('<tr><td colspan="7" class="text-center text-muted">No matching employee found from imported EmployeeId values.</td></tr>');
                }
            }

            function getShiftOptions(selectedId, selectedText) {
                const options = ['<option value="">---Select---</option>'];
                let hasSelectedOption = false;

                rosterShiftList.forEach(function (shift) {
                    const isSelected = String(shift.id) === String(selectedId) ||
                        String(shift.name).trim().toLowerCase() === String(selectedText || selectedId).trim().toLowerCase();
                    const selected = isSelected ? 'selected' : '';
                    if (isSelected) {
                        hasSelectedOption = true;
                    }
                    options.push(`<option value="${shift.id}" ${selected}>${escapeHtml(shift.name)}</option>`);
                });

                if (!hasSelectedOption && selectedText) {
                    options.push(`<option value="${escapeHtml(selectedId)}" selected>${escapeHtml(selectedText)}</option>`);
                }

                return options.join('');
            }

            function escapeHtml(value) {
                return String(value || '')
                    .replace(/&/g, '&amp;')
                    .replace(/</g, '&lt;')
                    .replace(/>/g, '&gt;')
                    .replace(/"/g, '&quot;')
                    .replace(/'/g, '&#039;');
            }

            $(document).on('change', '.import-shift', function () {
                const index = Number($(this).data('index'));
                importedRosterRows[index].shiftId = $(this).val();
            });

            $(document).on('change', '.import-roster-date', function () {
                const index = Number($(this).data('index'));
                importedRosterRows[index].rosterDate = $(this).val();
            });

            function OpenRosterImportModal() {
                $('#rosterImportModal').modal('show');
            }

            function CloseRosterImportModal() {
                $('#rosterImportModal').modal('hide');
            }

            function SubmitImportedRoster() {
                const validRows = importedRosterRows.filter(function (row) {
                    return row.empId && row.shiftId && row.rosterDate;
                });

                if (validRows.length === 0 || validRows.length !== importedRosterRows.length) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Incomplete Data',
                        text: 'Every imported row must have Employee, Shift and Roster Date.',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                const rosterGroups = {};
                validRows.forEach(function (row) {
                    const key = `${row.shiftId}_${row.rosterDate}`;
                    if (!rosterGroups[key]) {
                        rosterGroups[key] = {
                            fromDate: row.rosterDate,
                            toDate: row.rosterDate,
                            shiftId: row.shiftId,
                            empIds: []
                        };
                    }
                    rosterGroups[key].empIds.push(row.empId);
                });

                $('#btnSubmitImportedRoster').prop('disabled', true).text('Submitting...');
                $('.loaderDaily').show();
                $('.loaderparent').css('opacity', '0.5');

                const requests = Object.keys(rosterGroups).map(function (key) {
                    const group = rosterGroups[key];
                    const formData = new FormData();
                    formData.append('fromDate', group.fromDate);
                    formData.append('toDate', group.toDate);
                    formData.append('shiftId', group.shiftId);
                    formData.append('companyId', CompanyID);
                    formData.append('empIds', JSON.stringify(group.empIds));
                    return ApiCallPostForm(PostRosterURL, token, formData);
                });

                Promise.all(requests)
                    .then(function () {
                        CloseRosterImportModal();
                        $('#rosterExcelFile').val('');
                        $('#rosterSelectedFileName').text('No file selected');
                        importedRosterRows = [];
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: 'Imported roster has been submitted successfully.',
                            confirmButtonText: 'OK'
                        });
                    })
                    .catch(function (error) {
                        console.error('Imported roster submit error:', error);
                    })
                    .finally(function () {
                        $('#btnSubmitImportedRoster').prop('disabled', false).text('Submit');
                        $('.loaderDaily').hide();
                        $('.loaderparent').css('opacity', '1');
                    });
            }

           function RosterSubmit() {
            const startDate = $('#txtStartDate').val();
            const endDate = $('#txtEndDate').val();
            const Shift  = $('#ddlNewShift').val();
           // const employeeQuery = getSelectedEmployeeQuery();

           //const urlParams = new URLSearchParams(employeeQuery);
           //const empIds = urlParams.getAll('empIds');

           const employeeQuery = JSON.stringify(Array.from(selectedEmployeeIds));
           

           const formData = new FormData();
           formData.append('fromDate', startDate);
           formData.append('toDate', endDate);
           formData.append('shiftId', Shift);
           formData.append('companyId', CompanyID);
           formData.append('empIds', employeeQuery);
           
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

               if (!selectedEmployeeIds || selectedEmployeeIds.size === 0) {
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
                        selectedEmployeeIds.clear();
                        $('#selectAllEmployee').prop('checked', false);
                        $('.EmployeerowCheckbox').prop('checked', false);
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
