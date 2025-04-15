<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="dashbordUser.aspx.cs" Inherits="SigmaERP.hrms.dashbordUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <style>
        .ui-datepicker {
            position: fixed !important;
            top: 108px !important;
        }
        #tblDailyAttSummary thead th {
             position: sticky;
             top: 0;
             background: #f8f9fa;
             z-index: 10;
         }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <%--<div class="Dashbord">--%>
    <div class="crm mb-25">
        <div class="container-fluid">

      
                <div class="date-parent">
                            <div class="row position-relative">
            
                    <div class="dm-date-picker d-flex justify-content-end gap-1 w-100">
                        <div class="form-group mb-0 form-group-calender position-relative">
                            <div class="positon-fixed top-0">
                                <input type="text" onload="getDate()" class="form-control top-0 date-wrapper form-control-default " id="datepicker4" placeholder="select date">
                         
                             
                            </div>

                            <%--<span><i class="fab fa-facebook"></i></span>--%>
                                  <img class="svg cicon" src="img/svg/calendar.svg" alt="calendar">
                        </div>
                        <button style="line-height: 32px; display: block;" type="button" onclick="SearchData()" class="btn btn-info btn-default btn-squared ">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
            </div>
            </div>
                            
            



            <div class="row mt-2">

                  <div class="col-xxl-6">
                     <div class="row">
                        <div class="col-xxl-6 col-sm-6 mb-25">
                           <!-- Card 1  -->
                           <div class="ap-po-details ap-po-details--2 p-25 radius-xl d-flex justify-content-between">

                              <div class="overview-content w-100">
                                 <div class=" ap-po-details-content d-flex flex-wrap justify-content-between">
                                    <div class="ap-po-details__titlebar">
                                       <h1>100+</h1>
                                       <p>Total Products</p>
                                    </div>
                                    <div class="ap-po-details__icon-area">
                                       <div class="svg-icon order-bg-opacity-primary color-primary">

                                          <i class="uil uil-briefcase-alt"></i>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="ap-po-details-time">
                                    <span class="color-success"><i class="las la-arrow-up"></i>
                                       <strong>25.36%</strong></span>
                                    <small>Since last month</small>
                                 </div>
                              </div>

                           </div>
                           <!-- Card 1 End  -->
                        </div>
                        <div class="col-xxl-6 col-sm-6 mb-25">
                           <!-- Card 2 -->
                           <div class="ap-po-details ap-po-details--2 p-25 radius-xl d-flex justify-content-between">





                              <div class="overview-content w-100">
                                 <div class=" ap-po-details-content d-flex flex-wrap justify-content-between">
                                    <div class="ap-po-details__titlebar">
                                       <h1>30,825</h1>
                                       <p>Total Orders</p>
                                    </div>
                                    <div class="ap-po-details__icon-area">
                                       <div class="svg-icon order-bg-opacity-info color-info">

                                          <i class="uil uil-shopping-cart-alt"></i>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="ap-po-details-time">
                                    <span class="color-success"><i class="las la-arrow-up"></i>
                                       <strong>25.36%</strong></span>
                                    <small>Since last month</small>
                                 </div>
                              </div>

                           </div>
                           <!-- Card 2 End  -->
                        </div>
                        <div class="col-xxl-6 col-sm-6 mb-25">
                           <!-- Card 3 -->
                           <div class="ap-po-details ap-po-details--2 p-25 radius-xl d-flex justify-content-between">





                              <div class="overview-content w-100">
                                 <div class=" ap-po-details-content d-flex flex-wrap justify-content-between">
                                    <div class="ap-po-details__titlebar">
                                       <h1>$30,825</h1>
                                       <p>Total Sales</p>
                                    </div>
                                    <div class="ap-po-details__icon-area">
                                       <div class="svg-icon order-bg-opacity-secondary color-secondary">

                                          <i class="uil uil-usd-circle"></i>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="ap-po-details-time">
                                    <span class="color-danger"><i class="las la-arrow-down"></i>
                                       <strong>25.36%</strong></span>
                                    <small>Since last month</small>
                                 </div>
                              </div>

                           </div>
                           <!-- Card 3 End  -->
                        </div>
                        <div class="col-xxl-6 col-sm-6 mb-25">
                           <!-- Card 4  -->
                           <div class="ap-po-details ap-po-details--2 p-25 radius-xl d-flex justify-content-between">





                              <div class="overview-content w-100">
                                 <div class=" ap-po-details-content d-flex flex-wrap justify-content-between">
                                    <div class="ap-po-details__titlebar">
                                       <h1>30,825</h1>
                                       <p>New Customers</p>
                                    </div>
                                    <div class="ap-po-details__icon-area">
                                       <div class="svg-icon order-bg-opacity-warning color-warning">

                                          <i class="uil uil-users-alt"></i>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="ap-po-details-time">
                                    <span class="color-success"><i class="las la-arrow-up"></i>
                                       <strong>25.36%</strong></span>
                                    <small>Since last month</small>
                                 </div>
                              </div>

                           </div>
                           <!-- Card 4 End  -->
                        </div>
                     </div>
                  </div>
                  <div class="col-xxl-6 col-lg-6 mb-25">

                     <div class="card border-0 px-25">
                        <div class="card-header px-0 border-0">
                           <h6>Attendance Summary</h6>
                 
                        </div>
                         <div class="card-body p-0" style="height: 325px">
                             <div class="tab-content">
                                 <div class="tab-pane fade active show" role="tabpanel" aria-labelledby="t_selling-today-tab">
                                     <div class="selling-table-wrap">
                                         <div class="table-responsive" style="max-height: 320px; overflow-y: auto;">
                                             <div class="dm-spin-dots dot-size table-loader loaderDailySum dot-sizedot-sizedot-sizedot-size spin-sm">
                                                 <span class="spin-dot badge-dot dot-primary"></span>
                                                 <span class="spin-dot badge-dot dot-primary"></span>
                                                 <span class="spin-dot badge-dot dot-primary"></span>
                                                 <span class="spin-dot badge-dot dot-primary"></span>
                                             </div>
                                             <table id="tblDailyAttSummary" class="table table-bordered table-sm text-sm align-middle">
                                                 <thead class="table-light">
                                                     <tr>
                                                         <th scope="col">SL</th>
                                                         <th scope="col">Date</th>
                                                         <th scope="col">Shift</th>
                                                         <th scope="col">In Time</th>
                                                         <th scope="col">Out Time</th>
                                                         <th scope="col">Stay Time</th>
                                                         <th scope="col">Status</th>
                                                         <th scope="col">Late By</th>
                                                         <th scope="col">OT Total (H)</th>
                                                     </tr>
                                                 </thead>
                                                 <tbody>
                                                     <!-- Table data rows go here -->
                                                 </tbody>
                                             </table>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>

                  </div>
                <!---Today Costing Over time start---->
                <!---Attendance Summary start---->
                <div class="col-lg-12 col-md-12 col-sm-12 mb-25">

                    <div class="card border-0 px-25 position-relative">
                        <div class="card-header px-0 border-0">
                            <h2 class="mt-3 mb-4">Leave Balance</h2>
                        </div>
                        <div class=" p-0">
                            <div class="tab-content">
                                <div class="tab-pane fade active show" id="t_selling-today" role="tabpanel"
                                    aria-labelledby="t_selling-today-tab">
                                    <div class="selling-table-wrap">
                                        <div class="table-responsive table-height">
                                            <div class="dm-spin-dots dot-size table-loader loaderDailySum dot-sizedot-sizedot-sizedot-size spin-sm">
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                            </div>
                                            <table class="table table-bordered table-sm text-sm align-middle" id="tblLeaveSummary">
                                                <thead>
                                                    <!-- First Row: Main Headers -->
                                                    <tr>
                                                        <th rowspan="2">SL</th>
                                                        <th rowspan="2">ID</th>
                                                        <th rowspan="2">Name</th>
                                                        <th rowspan="2">Joining Date</th>
                                                        <th rowspan="2">Designation</th>
                                                        <th rowspan="2">Department</th>
                                                        <th colspan="5" class="text-center">Availed</th>
                                                        <th colspan="5" class="text-center">Balance</th>
                                                    </tr>
                                                    <!-- Second Row: Sub-Headers -->
                                                    <tr>
                                                        <th>CL</th>
                                                        <th>SL</th>
                                                        <th>EL</th>
                                                        <th>ML</th>
                                                        <th>LWP</th>
                                                        <th>CL</th>
                                                        <th>SL</th>
                                                        <th>EL<br>
                                                            <span style="font-weight: normal">(Pre. + Cur.)</span>
                                                        </th>
                                                        <th>Remaining</th>
                                                        <th>ML<br>
                                                            <span style="font-weight: normal">-112</span>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Example Row -->
                                                    <tr>
                                                        <td>1</td>
                                                        <td>0005 (3005)</td>
                                                        <td>Md. Muzahid-UI Islam</td>
                                                        <td>01-06-2014</td>
                                                        <td>AGM</td>
                                                        <td>Commercial</td>
                                                        <td>1</td>
                                                        <td>33</td>
                                                        <td>0</td>
                                                        <td>0</td>
                                                        <td>0</td>
                                                        <td>10</td>
                                                        <td>-19</td>
                                                        <td>2 + 1 = 3</td>
                                                        <td>3</td>
                                                        <td>112</td>
                                                    </tr>
                                                    <!-- Add more rows as needed -->
                                                </tbody>
                                            </table>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!---Attendance Summary End---->





                <!---Today Costing Over time End ---->

          

            </div>   
            </div>

                <!-----Start -->

               
                <!---Salary Comparison Table Start ---->


        </div>


    <script>

        //var rootUrl = 'http://cw-hrms-api.codehosting.xyz';
          var rootUrl = '<%= Session["__RootUrl__"]%>';
        //var rootUrl = 'http://localhost:8081';

        var DailyAttUrl = rootUrl + '/api/DailyAttendance/dailyAttendanceStatus';
        var DailyAttSumUrl = rootUrl + '/api/Attendance/attendance/userAttendanceSummary/0001/00000007/2023-11-01';
        var CurrentEmpStatusUrl = rootUrl + '/api/DailyAttendance/currentEmployeeStatus';
        var GetTodaysCostingUrl = rootUrl + '/api/DailyAttendance/getTodaysCosting';
        var GetLeaveSummaryReportURL = rootUrl + '/api/Leave/LeaveReport?companyId=0001&empId=00000007&year=2024';


        var companyId = '<%= Session["__GetCompanyId__"] %>';
        var token = '<%= Session["__UserToken__"] %>';
        //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        function SearchData() {
            var formattedDate = $(".hasDatepicker").val();
            var promises = [];

            // Push promises for each function call
            promises.push(new Promise(function (resolve, reject) {
                GetDailyAttendanceStatus(formattedDate);
                resolve();
            }));
     
        }

        $(document).ready(function () {
            var initialDate = new Date();
            var options = { day: 'numeric', month: 'long', year: 'numeric' };
            var formattedDate = initialDate.toLocaleDateString('en-US', options);
            document.querySelector('.hasDatepicker').value = formattedDate;

            var date = formattedDate;
            // Define an array to hold promises
            var promises = [];

            promises.push(new Promise(function (resolve, reject) {
                GetDailyAttSummary(date);
                resolve();
            }));


            GetLeaveSummary()

       
        });


        function GetDailyAttendanceStatus(date) {
            // Show loader
            $('#totalEmp').text('');
            $('#totalEmpRatio').text('');
            $('#todayPresent').text('');
            $('#todayPresentRatio').text('');
            $('#todayAbsent').text('');
            $('#todayAbsentRatio').text('');
            $('#todayLate').text('');
            $('#todayLateRatio').text('');
            $('#todayLeave').text('');
            $('#todayLeaveRatio').text('');
            $('#WHOffDuty').text('');

            $('.loaderDaily').show();
            date = date;
            ApiCall(DailyAttUrl, companyId, date, token)
                .then(function (response) {
                    // Hide loader
                    $('.loaderDaily').hide();

                    // Update UI with data
                    $('#totalEmp').text(response.total);
                    $('#totalEmpRatio').text(response.totalPerc +'%');
                    $('#todayPresent').text(response.present);
                    $('#todayPresentRatio').text(response.pressentRatio +'%');
                    $('#todayAbsent').text(response.absent);
                    $('#todayAbsentRatio').text(response.absentRatio +'%');
                    $('#todayLate').text(response.late);
                    $('#todayLateRatio').text(response.lateRatio +'%');
                    $('#todayLeave').text(response.leave);
                    $('#todayLeaveRatio').text(response.leavePers +'%');
                    $('#WHOffDuty').text(response.offDayDuty);
                    $('#WHOffDeutyPers').text(response.offDayDutyPerc +'%');
                })
                .catch(function (error) {
                    // Hide loader
                    $('#loaderDaily').hide();
                    console.error('Error occurred while fetching data:', error);
                });
        }




        function GetDailyAttSummary(date) {
            $('.loaderDailySum').show();
            var tableBody = $('#tblDailyAttSummary tbody');
            $('.loaderDailySum').show().promise().done(function () {
                tableBody.empty();
            });

            ApiCall(DailyAttSumUrl, token)
                .then(function (response) {
                    $('.loaderDailySum').hide();
                    if (response.statusCode === 200 && response.data && response.data.length > 0) {
                        var newRow = '';
                        var i = 1;
                        response.data.forEach(item => {
                            newRow += `<tr>
                        <td>${i++}</td>
                        <td>${item.attDate}</td>
                        <td>${item.sftName}</td>
                        <td>${item.inTime}</td>
                        <td>${item.outTime}</td>
                        <td>${item.stayTime}</td>
                        <td>${item.attstatus}</td>
                        <td>${item.lateTime}</td>
                        <td>${item.overTime}</td>
                    </tr>`;
                        });
                        tableBody.append(newRow);
                    } else {
                        tableBody.append('<tr><td colspan="9" class="text-center text-danger">No records found</td></tr>');
                    }
                })
                .catch(function (error) {
                    $('.loaderDailySum').hide();
                    console.error('Error occurred while fetching data:', error);
                    tableBody.append('<tr><td colspan="9" class="text-center text-danger">Error loading data</td></tr>');
                });
        }


        function GetLeaveSummary() {
            const tableBody = $('#tblLeaveSummary tbody');
            tableBody.empty();
            $('.loaderLeaveSummary').show();

            ApiCall(GetLeaveSummaryReportURL, token)
                .then(function (response) {
                    $('.loaderLeaveSummary').hide();
                    if (response.statusCode === 200 && response.data && response.data.length > 0) {
                        let i = 1;
                        let newRow = '';
                        response.data.forEach(item => {
                            const totalEL = (item.bel || 0) + (item.pel || 0);
                            const remainingEL = totalEL - (item.ael || 0);

                            newRow += `<tr>
                        <td>${i++}</td>
                        <td>${item.empCardNo}</td>
                        <td>${item.empName}</td>
                        <td>${item.empJoiningDate}</td>
                        <td>${item.dsgName}</td>
                        <td>${item.dptName}</td>
                        <td>${item.cl}</td>
                        <td>${item.sl}</td>
                        <td>${item.al}</td>
                        <td>${item.ml}</td>
                        <td>${item.lwp}</td>
                        <td>${item.acl}</td>
                        <td>${item.asl}</td>
                        <td>${totalEL}</td>
                        <td>${remainingEL}</td>
                        <td>${item.aml}</td>
                    </tr>`;
                        });
                        tableBody.append(newRow);
                    } else {
                        tableBody.append('<tr><td colspan="16" class="text-center text-danger">No records found</td></tr>');
                    }
                })
                .catch(function (error) {
                    $('.loaderLeaveSummary').hide();
                    console.error('Error:', error);
                    tableBody.append('<tr><td colspan="16" class="text-center text-danger">Error loading data</td></tr>');
                });
        }



        //api calling function

        function ApiCall(url, token) {
            return new Promise(function (resolve, reject) {
                $.ajax({
                    url: url,
                    type: 'GET',
                    headers: {
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    success: function (data) {
                        resolve(data);
                    },
                    error: function (xhr, status, error) {
                        //console.log(status);
                        //var message = xhr.responseJSON.message
                        //console.log('Error occurred while fetching data:', message);
                        var message = xhr.responseJSON.message;
                        console.error('Error occurred while fetching data:', message);
                        reject({ message: message, status: status, error: error });
                    }
                });
            });
        }

        function ApiCallSam(url, companyId, token) {
            return new Promise(function (resolve, reject) {
                $.ajax({
                    url: url,
                    type: 'GET',
                    dataType: 'json',
                    headers: {
                        'Authorization': 'Bearer ' + token  // Corrected header field
                    },
                    data: {
                        companyId: companyId,
                    },
                    success: function (data) {
                        resolve(data);

                    },
                    error: function (xhr, status, error) {
                        console.error('Error occurred while fetching data:', status, error);
                        reject(error);
                    }
                });
            });
        }

    </script>

</asp:Content>
