<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="attendanceProcessing.aspx.cs" Inherits="SigmaERP.hrms.attendance.attendanceProcessing" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <style>
        .packagesTable{
            padding :0 !important;
        }
        td{
           text-align: left;
        }

    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="mt-25">
         <div class="products_page product_page--grid mb-30">
            <div class="container-fluid">
               <div class="row justify-content-center">
                  <div class="col-lg-3 col-sm-12 mb-lg-0 mb-30">
                     <div class="widget">
                        <div class="widget-header-title px-20 py-15">
                           <h6 class="d-flex align-content-center fw-500">
                              <img src="../img/svg/sliders.svg" alt="sliders" class="svg"> Filter Department
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
                  </div>
                  <div class=" col-lg-9 mt-xl-0 mt-lg-30">

                      <div class="row product-page-list justify-content-center mt-20">
                          <div class="col-12 mb-25 px-10">
                              <div class="card ">
                                  <div class="card-body">

                                      <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                                          <div class="table-responsive">
                                              <div class="ad-table-table__header d-flex justify-content-between mb-15">

                                                  <div id="filter-form-container" class="d-none"></div>


                                                  <div class="d-flex justify-content-between  align-items-center">
                                                      <div class="col-auto">
                                                          <div class="input-group">
                                                              <span class="input-group-text bg-white border-end-0">
                                                                  <i class="uil uil-search"></i>
                                                                  <!-- You can use another icon font if needed -->
                                                              </span>
                                                              <input type="text" id="txtSearch" class="form-control border-start-0" placeholder="Employee ID..." aria-describedby="searchIcon">
                                                          </div>


                                                      </div>
                                                      <div class="col-auto">
                                                          <label for="inputPassword6" class="col-form-label">Start Date</label>
                                                      </div>
                                                      <div class="col-auto">
                                                          <input type="date" id="txtStartDate" class="form-control" aria-describedby="passwordHelpInline">
                                                      </div>
                                                      <div class="col-auto">
                                                          <label for="inputPassword6" class="col-form-label">End Date</label>
                                                      </div>
                                                      <div class="col-auto">
                                                          <input type="date" id="txtEndDate" class="form-control" aria-describedby="passwordHelpInline">
                                                      </div>
                                                    <div class="col-auto">
                                                        <button type="button" title="Search" id="btnSearch" onclick="SearchEmployee()"
                                                            class="btn btn-sm btn-primary d-flex align-items-center justify-center p-2"
                                                            style="height: 36px !important; width: 36px !important; margin-left: 10px;">
                                                            <i class="fas fa-search"></i>
                                                        </button>
                                                    </div>    

                                                  </div>
                                                  <div class="col-auto d-flex">
                                                  
                                                          <input type="file" title="Attendance File" style="width:200px" id="AttFile" class="form-control" aria-describedby="passwordHelpInline">
                                                          <button type="button" onclick="AttendanceProcess()" title="Processing"  id="btnProcessing"
                                                          class="btn btn-sm btn-success d-flex align-items-center justify-content-center p-2"
                                                          style="height: 36px !important; width: 36px !important; margin-left: 10px;">
                                                          <i class="uil uil-calculator"></i>
                                                      </button>

                                                  </div>
                                                 
                                              </div>
                                              <table class="table mb-0 packagesTable table-borderless adv-table" data-sorting="true" data-filtering="true" data-filter-container="#filter-form-container" data-paging="true" data-paging-size="10">
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
           <!-- End: .job -->

       </div>






    <script>
                var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var IsAdministrator = '<%= Session["__GetISAdministetor__"]%>';
        //var IsAdministrator = false;
        //var getEmployeeUrl = `${rootUrl}/api/Employee/employees?CompanyId=${CompanyID}`;
        var getEmployeeUrl = `${rootUrl}/api/Employee/active-employees-date-range?CompanyId=${CompanyID}`;
        var PostAttendanceProcess = `${rootUrl}/api/Attendance/attedance/process?companyId=${CompanyID}`;

        var getDepartmentUrl = `${rootUrl}/api/Department/basicInfo/${CompanyID}`;
      


        var token = '<%= Session["__UserToken__"] %>';
        console.log('this is token you can use it :', token);
        //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        $(document).ready(function () {
           
            const today = new Date();
            const formattedDate = formatDate(today);

            $('#txtStartDate').val(formattedDate);
            $('#txtEndDate').val(formattedDate);

            GetEmployee();
            GetDepartment();


        });
        function formatDate(date) {
            const day = String(date.getDate()).padStart(2, '0');
            const month = String(date.getMonth() + 1).padStart(2, '0'); // Months are zero-based
            const year = date.getFullYear();
            return `${year}-${month}-${day}`; // This is HTML5 <input type="date"> compatible
        }
        function SearchEmployee() {
            GetEmployee();
        }




        function AttendanceProcess() {
            const startDate = $('#txtStartDate').val();
            const endDate = $('#txtEndDate').val();
            const employeeQuery = getSelectedEmployeeQuery();
            const attDate = $('#AttFile').val();
            const url = `${PostAttendanceProcess}&fromDate=${startDate}&toDate=${endDate}&${employeeQuery}`;

            ApiCallPost(url, token,attDate)
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


        function AttendanceProcess() {
            const startDate = $('#txtStartDate').val();
            const endDate = $('#txtEndDate').val();
            const employeeQuery = getSelectedEmployeeQuery();
            const url = `${PostAttendanceProcess}&fromDate=${startDate}&toDate=${endDate}&${employeeQuery}`;

            ApiCallPostAttendProcess(url, token, 'AttFile')
                .then(response => {
                    if (response.statusCode === 200) {
                       // bindTableData(response.data);
                    } else {
                        console.error('API Error:', response.message);
                    }
                })
                .catch(error => {
                    console.error('Network Error:', error);
                });
        }

        function ApiCallPostAttendProcess(url, token, fileInputId) {
            return new Promise(function (resolve, reject) {
                const fileInput = document.getElementById(fileInputId);
                if (!fileInput || fileInput.files.length === 0) {
                    Swal.fire({ icon: 'warning', title: 'File Missing', text: 'Please select a file to upload.' });
                    reject('No file selected');
                    return;
                }

                const formData = new FormData();
                formData.append('file', fileInput.files[0]);

                $.ajax({
                    url: url,
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
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: xhr.responseText
                        });
                        reject(error);
                    }
                });
            });
        }


        function getSelectedEmployeeQuery() {
            return $('.EmployeerowCheckbox:checked')
                .map(function () {
                    return 'empIds=' + $(this).val();
                })
                .get()
                .join('&');
        }
        $(document).on('change', '#selectAllEmployee', function () {
            const isChecked = $(this).is(':checked');
            $('.EmployeerowCheckbox').prop('checked', isChecked);
        });

        // Sync "Select All" checkbox when departments are manually toggled
        $(document).on('change', '.EmployeerowCheckbox', function () {
            const total = $('.EmployeerowCheckbox').length;
            const checked = $('.EmployeerowCheckbox:checked').length;
            $('#selectAllEmployee').prop('checked', total === checked);
        });
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

            // Add "Select All" checkbox at the top
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

            // Add each department checkbox
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



        //function GetEmployee() {
        //    var StartDate = $('#txtStartDate').val(); // ✅ Get actual value
        //    ApiCall(getEmployeeUrl + &DptIds=0034&DptIds=0035 + StartDate, token)
        //        .then(function (response) {
        //            if (response.statusCode === 200) {
        //                var responseData = response.data;
        //                console.log('Before table Data Bind', responseData);
        //                $('.footable-loader').show();
        //                bindTableData(responseData);
        //                console.log('after Table Data Bind ', responseData);
        //            } else {
        //                console.error('Error occurred while fetching data:', response.message);
        //            }
        //        })
        //        .catch(function (error) {
        //            $('.loaderCosting').hide();
        //            console.error('Error occurred while fetching data:', error);
        //        });
        //}

        function GetEmployee() {
            const startDate = $('#txtStartDate').val();
            const deptQuery = getSelectedDepartmentQuery();
            const url = `${getEmployeeUrl}&${deptQuery}&startDate=${startDate}`;

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


         function bindTableData(data) {
             if ($('.adv-table').data('footable')) {
                 $('.adv-table').data('footable').destroy();
             }
             $('.adv-table').html('');
             $('#filter-form-container').empty();

             let serialNumber = 1; 
             const defaultImage = '/hrms/user_img_default.jpg'; 
             data.forEach(row => {
                 row.serial = serialNumber++; 
                 const userImage = row.userImage ? row.userImage : defaultImage;
                 row.userImage = `
                    <div class="user-details-container d-flex align-items-center">
                        <img src="${userImage}" alt="User Image" class="user-image" style="width: 40px; height: 40px; margin-right: 10px;">
                        <div>
                            <a href="javascript:void(0)" class="user-name" data-id="${row.empId}">${row.empName}</a>
                            <div class="user-role">${row.dsgName}</div>
                        </div>
                    </div>
                `;
                 row.select = `<input type="checkbox" class="EmployeerowCheckbox" data-id="${row.empId}" value="${row.empId}" />`;

             });

             const columns = [
                 { "name": "select", "title": `<input type="checkbox" id="selectAllEmployee" />`, "className": "text-center", "sortable": false, "type": "html"
                 },
                 { "name": "serial", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
                 { "name": "userImage", "title": "Name", "className": "userDatatable-content" },
                 { "name": "empCardNo", "title": "Employee ID", "className": "userDatatable-content" },
                 { "name": "dptName", "title": "Department", "className": "userDatatable-content" },
                 { "name": "joiningDate", "title": "Joining Date", "className": "userDatatable-content" },
         
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
         }

        // Handle "Select All" click
        $(document).on('change', '#selectAllRows', function () {
            const isChecked = $(this).is(':checked');
            $('.rowCheckbox').prop('checked', isChecked);
        });

        // Sync "Select All" checkbox when departments are manually toggled
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


    </script>


    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="../assets/theme_assets/js/apiHelper.js"></script>
   
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
</asp:Content>
