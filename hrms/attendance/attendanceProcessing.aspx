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
                  <div class="columns-1 col-lg-12 col-sm-12 mb-lg-0 mb-30">
                     <div class="widget">
                        <div class="widget-header-title px-20 py-15">
                           <h6 class="d-flex align-content-center fw-500">
                              <img src="../img/svg/sliders.svg" alt="sliders" class="svg"> Filter Department
                           </h6>
                        </div>
                        <div class="category_sidebar">
                           <aside class="product-sidebar-widget mb-30">
                               <div class="card border-0 shadow-none multi-collapse mt-10 collapse show" id="multiCollapseExample1">
                                   <div class="product-brands">
                                       <ul id="departmentList">
                                           <!-- Checkboxes will be injected here -->
                                       </ul>
                                   </div>
                               </div>
                           </aside>
                        </div>
                     </div>
                  </div>
                  <div class="columns-2 col-lg-12 mt-xl-0 mt-lg-30">

                      <div class="row product-page-list justify-content-center mt-20">
                          <div class="col-12 mb-25 px-10">
                              <div class="card ">
                                  <div class="card-body">

                                      <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                                          <div class="table-responsive">
                                              <div class="ad-table-table__header d-flex justify-content-between">
                                                  
                                                  <div id="filter-form-container"></div>
                                                      <div class="d-flex justify-content-between  align-items-center">
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
        var getEmployeeUrl = `${rootUrl}/api/Employee/employees?CompanyId=${CompanyID}`;
        var getDepartmentUrl = `${rootUrl}/api/Department/basicInfo/${CompanyID}`;
      


        var token = '<%= Session["__UserToken__"] %>';
        console.log('this is token you can use it :', token);
        //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        $(document).ready(function () {
           
            //GetModule();
            GetEmployee();
            GetDepartment();

            
        });
                function GetDepartment() {
            ApiCall(getDepartmentUrl, token)
                .then(function (response) {
                    if (response.statusCode === 200) {
                        var responseData = response.data;
                        console.log('Before table Data Bind', responseData);
                        $('.footable-loader').show();
                        bindDepartmnet(responseData);

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
        function bindDepartmnet(departments) {
            var $list = $('#departmentList');
            $list.empty(); // Clear existing items if needed

            departments.forEach(function (dept, index) {
                var checkboxId = 'dept-check-' + index;

                var listItem = `
            <li>
                <div class="checkbox-theme-default custom-checkbox">
                    <input class="checkbox" type="checkbox" id="${checkboxId}" value="${dept.dptId}">
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


        function GetEmployee() {
            ApiCall(getEmployeeUrl, token)
                .then(function (response) {
                    if (response.statusCode === 200) {
                        var responseData = response.data;
                        console.log('Before table Data Bind', responseData);
                        $('.footable-loader').show();
                        bindTableData(responseData);

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
                 row.select = `<input type="checkbox" class="rowCheckbox" data-id="${row.empId}" />`;

             });

             const columns = [
                     { "name": "select", "title": `<input type="checkbox" id="selectAllRows" />`, "className": "text-center", "sortable": false, "type": "html"
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


        $(document).on('change', '#selectAllRows', function () {
            const checked = $(this).is(':checked');
            $('.rowCheckbox').prop('checked', checked);
        });
    </script>


    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="../assets/theme_assets/js/apiHelper.js"></script>
   
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
</asp:Content>
