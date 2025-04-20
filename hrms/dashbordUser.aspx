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
        th {
             text-align:center;
        }
        td {
            text-align:center;
        }
        .card-body{
            padding:0px !important;
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
                                       <h3 id="presentDays"></h3>
                                       <p> </p>
                                    </div>
                                    <div class="ap-po-details__icon-area">
                                       <div class="svg-icon order-bg-opacity-success color-success">

                                          <i class="uil uil-user-check"></i>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="ap-po-details-time" style="margin-top: 20px;">
                                    <span class="color-success"><i class="las la-arrow-up"></i>
                                      </span>
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
                                       <h3 id="absentDays"></h3>
                                       <p> </p>
                                    </div>
                                     <div class="ap-po-details__icon-area">
                                         <div class="svg-icon order-bg-opacity-danger color-danger">
                                             <i class="uil uil-user-minus"></i>
                                         </div>
                                    </div>
                                 </div>
                                 <div class="ap-po-details-time" style="margin-top: 20px;">
                                 <span class="color-danger"><i class="las la-arrow-down"></i>
                                       </span>
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
                                       <h3 id="lateDays"></h3>
                                       <p> </p>
                                    </div>
                                    <div class="ap-po-details__icon-area">
                                       <div class="svg-icon order-bg-opacity-warning color-warning">
                                          <i class="uil uil-stopwatch-slash"></i>

                                       </div>
                                    </div>
                                 </div>
                                 <div class="ap-po-details-time" style="margin-top: 20px;">
                                    <span class="color-danger"><i class="las la-arrow-down"></i>
                                       </span>
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
                                       <h3 id="leaveDays"></h3>
                                       <p> </p>
                                    </div>
                                    <div class="ap-po-details__icon-area">
                                       <div class="svg-icon order-bg-opacity-primary color-primary">
                                           <i class="uil uil-calendar-slash"></i>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="ap-po-details-time" style="margin-top: 20px;">
                                    <span class="color-success"><i class="las la-arrow-up"></i>
                                       </span>
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
        var companyId = '<%= Session["__GetCompanyId__"] %>';
        //var companyId = 0001;
        var LogInEmpId = '<%= Session["__GetEmpId__"] %>';
        //var LogInEmpId = 000000007;
        var token = '<%= Session["__UserToken__"] %>';
        var DailyAttStatusUrl = rootUrl + `/api/Attendance/attendance/userAttendaceStaus/${companyId}/${LogInEmpId}`;
        var DailyAttSumUrl = rootUrl + `/api/Attendance/attendance/userAttendanceSummary/${companyId}/${LogInEmpId}`;
        var GetLeaveSummaryReportURL = rootUrl + `/api/Leave/LeaveReport?companyId=${companyId}&empId=${LogInEmpId}&year=`;



        //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        function formatDateToDDMMYYYY(date) {
            var d = new Date(date);
            var day = String(d.getDate()).padStart(2, '0');
            var month = String(d.getMonth() + 1).padStart(2, '0');
            var year = d.getFullYear();
            return `${day}-${month}-${year}`;
        }

        function SearchData() {
            // Get the selected date from the input field
            var rawDate = document.querySelector('.hasDatepicker').value;

            // Parse the date string to a Date object
            var parsedDate = new Date(rawDate);

            // Format the date (if needed)
            var options = { day: 'numeric', month: 'long', year: 'numeric' };
            var formattedDate = parsedDate.toLocaleDateString('en-US', options);
            document.querySelector('.hasDatepicker').value = formattedDate;

            // Extract the year
            var year = parsedDate.getFullYear();

            // Use formatted date for summary
            var date = formattedDate;
            var promises = [];
            GetMonthlyAttendanceSummary(date);
            promises.push(new Promise(function (resolve, reject) {
                GetDailyAttSummary(date);
                resolve();
            }));

            GetLeaveSummary(year);
        }


        $(document).ready(function () {
            var initialDate = new Date();
            var options = { day: 'numeric', month: 'long', year: 'numeric' };
            var formattedDate = initialDate.toLocaleDateString('en-US', options);
            document.querySelector('.hasDatepicker').value = formattedDate;

            var date = formattedDate;
            var year = initialDate.getFullYear(); // Use initialDate instead of 'today'

            GetMonthlyAttendanceSummary(date);
            GetDailyAttSummary(date);
            GetLeaveSummary(year);

            // Optional: Trigger SearchData when datepicker changes
            $(".hasDatepicker").on("change", function () {
                SearchData();
            });
        });


        function GetMonthlyAttendanceSummary(date) {
            $('.loaderMonthly').show(); // Show loader if needed

            ApiCall(`${DailyAttStatusUrl}/${date}`, token)
                .then(function (response) {
                    $('.loaderMonthly').hide(); // Hide loader

                    if (response.statusCode === 200 && response.data.length > 0) {
                        const summary = response.data[0];

                        // Bind to card titles
                        $('#presentDays').text(`Present ${summary.presentDays} Days`);
                        $('#absentDays').text(`Absent ${summary.absentDays} Days`);
                        $('#lateDays').text(`Late ${summary.lateDays} Days`);
                        $('#leaveDays').text(`Leave ${summary.leaveDays} Days`);

                        // Optionally bind percentages or other metrics here too
                        // $('#presentRatio').text("25.36%") etc...
                    } else {
                        console.warn('No data returned from API');
                    }
                })
                .catch(function (error) {
                    $('.loaderMonthly').hide(); // Hide loader on error
                    console.error('Error fetching monthly summary:', error);
                });
        }


        function GetDailyAttSummary(date) {
            $('.loaderDailySum').show();
            var tableBody = $('#tblDailyAttSummary tbody');
            $('.loaderDailySum').show().promise().done(function () {
                tableBody.empty();
            }); 

            ApiCall(`${DailyAttSumUrl}/${date}`, token)
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


        function GetLeaveSummary(year) {
            const tableBody = $('#tblLeaveSummary tbody');
            tableBody.empty();
            $('.loaderLeaveSummary').show();

            ApiCall(`${GetLeaveSummaryReportURL}${year}`, token)
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
