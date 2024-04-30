<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="SigmaERP.hrms.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">  
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <%--<div class="Dashbord">--%>
         <div class="crm mb-25">
            <div class="container-fluid">

               <div class="row mt-2">
                  <div class="col-lg-7">

                  </div>
                  <div class="col-lg-5">
                     <form action="" method="post">
                        <div class="dm-date-picker d-flex justify-content-end gap-1 w-100">
                           <div class="form-group mb-0 form-group-calender">
                              <div class="position-relative">
                                 <input type="text" class="form-control form-control-default" id="datepicker4" placeholder="January 20, 2018">
                                 <a href="#"><img class="svg" src="img/svg/calendar.svg" alt="calendar"></a>
                              </div>
                           </div>
                           <button style="line-height: 32px; display: block;" onclick="SearchData()" class="btn btn-info btn-default btn-squared "><i class="fas fa-search"></i>
                           </button>
                        </div>
                     </form>
                  </div>
               </div>

               <div class="row mt-2">
                  <div class="col-lg-8  d-block d-lg-flex">
                     <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-12 mb-25 d-block">
                           <div class="ap-po-details ap-po-details--luodcy  overview-card-shape radius-xl d-flex justify-content-between">
                              <div class=" ap-po-details-content d-flex flex-wrap justify-content-between w-100">
                                 <div class="ap-po-details__titlebar">
                                    <p class="fs-6 fw-bold">Total Employee</p>
                                    <h1 id="totalEmp"></h1>
                                    <div class="ap-po-details-time">
                                       <span class="color-success"><i class="las la-arrow-up"></i>
                                          <strong id="totalEmpRatio">10%</strong></span>
                                       <small></small>
                                    </div>
                                 </div>
                                 <div class="ap-po-details__icon-area color-info">
                                    <i class="uil uil-user"></i>
                                 </div>
                              </div>
                     
                           </div>
                           <!-- Card 1 End  -->
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 mb-25">
                           <!-- Card 2 -->
                           <div class="ap-po-details ap-po-details--luodcy  overview-card-shape radius-xl d-flex justify-content-between">
                              <div class=" ap-po-details-content d-flex flex-wrap justify-content-between w-100">
                                 <div class="ap-po-details__titlebar">
                                    <p class="fs-6 fw-bold">Today's Present</p>
                                    <h1 id="todayPresent"></h1>
                                    <div class="ap-po-details-time">
                                       <span class="color-success"><i class="las la-arrow-up"></i>
                                          <strong id="todayPresentRatio"></strong></span>
                                    </div>
                                 </div>
                                 <div class="ap-po-details__icon-area color-success">
                                    <i class="uil uil-user-check"></i>
                                 </div>
                              </div>
                           </div>
                           <!-- Card 2 End  -->
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 mb-25">
                           <!-- Card 2 -->
                           <div class="ap-po-details ap-po-details--luodcy  overview-card-shape radius-xl d-flex justify-content-between">
                              <div class=" ap-po-details-content d-flex flex-wrap justify-content-between w-100">
                                 <div class="ap-po-details__titlebar">
                                    <p class="fs-6 fw-bold">Today's Absent</p>
                                    <h1 id="todayAbsent"></h1>
                                    <div class="ap-po-details-time">
                                       <span class="color-danger"><i class="las la-arrow-up"></i>
                                          <strong id="todayAbsentRatio"></strong></span>
                                    </div>
                                 </div>
                                 <div class="ap-po-details__icon-area color-danger">
                                    <i class="uil uil-user-minus"></i>
                                 </div> 
                              </div>
                           </div>
                           <!-- Card 2 End  -->
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 mb-25">
                           <!-- Card 3 -->
                           <div class="ap-po-details ap-po-details--luodcy  overview-card-shape radius-xl d-flex justify-content-between">
                              <div class=" ap-po-details-content d-flex flex-wrap justify-content-between w-100">
                                 <div class="ap-po-details__titlebar">
                                    <p class="fs-6 fw-bold"> Today's Late
                                    </p>
                                    <h1 id="todayLate"></h1>
                                    <div class="ap-po-details-time">
                                       <span class="color-danger"><i class="las la-arrow-down"></i>
                                          <strong id="todayLateRatio"></strong></span>
                                    </div>
                                 </div>
                                 <div class="ap-po-details__icon-area color-warning">
                                    <i class="uil uil-stopwatch-slash"></i>
                                 </div>
                              </div>
                        
                           </div>
                           <!-- Card 3 End  -->
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 mb-25">
                           <!-- Card 4  -->
                           <div class="ap-po-details ap-po-details--luodcy  overview-card-shape radius-xl d-flex justify-content-between">
                              <div class=" ap-po-details-content d-flex flex-wrap justify-content-between w-100">
                                 <div class="ap-po-details__titlebar">
                                    <p class="fs-6 fw-bold">Today's Leave</p>
                                    <h1 id="todayLeave"></h1>
                                    <div class="ap-po-details-time">
                                       <span class="color-success"><i class="las la-arrow-up"></i>
                                          <strong id="todayLeaveRatio"></strong></span>
                                    </div>
                                 </div>
                                 <div class="ap-po-details__icon-area color-primary">
                                    <i class="uil uil-calendar-slash"></i>
                        
                                 </div>
                              </div>
                        
                           </div>
                           <!-- Card 4 End  -->
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 mb-25">
                           <!-- Card 4  -->
                           <div class="ap-po-details ap-po-details--luodcy  overview-card-shape radius-xl d-flex justify-content-between">
                              <div class=" ap-po-details-content d-flex flex-wrap justify-content-between w-100">
                                 <div class="ap-po-details__titlebar">
                                    <p class="fs-6 fw-bold">W/H Off Duty</p>
                                    <h1></h1>
                                    <div class="ap-po-details-time">
                                       <span class="color-success"><i class="las la-arrow-up"></i>
                                          <strong>2%</strong></span>
                                    </div>
                                 </div>
                                 <div class="ap-po-details__icon-area color-warning">
                                    <i class="uil uil-bag"></i>
                        
                                 </div>
                              </div>
                        
                           </div>
                           <!-- Card 4 End  -->
                        </div>
                     </div>
                  </div>
                  <div class="col-lg-4 mb-25 d-block">
                     <div class="card border-0 px-25 h-100">
                        <div class="card-header px-0 border-0">
                           <h6>Last 7 Days Attendance Ratio</h6>
                           
                       
                        </div>

                        <ul class="legend-static mb-30 mt-1 d-flex justify-content-center">
                           <li class="custom-label">
                              <span class="bg-primary"></span>Present
                           </li>
                           <li class="custom-label">
                              <span class="bg-secondary"></span>Absent
                           </li>
                        </ul>
                        <div class="card-body p-0 pb-sm-25">
                           <div class="tab-content">
                              <div class="tab-pane active show" id="salesgrowth" role="tabpanel"
                                 aria-labelledby="salesgrowth-tab">
                                 <div class="parentContainer">
                                    <div>
                                       <canvas id="salesGrowthToday"></canvas>
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

                     <div class="card border-0 px-25">
                        <div class="card-header px-0 border-0">
                           <h2 class="mt-3 mb-4">Daily Attendance Summary</h2>
                        </div>
                        <div class="card-body p-0">
                           <div class="tab-content">
                              <div class="tab-pane fade active show" id="t_selling-today" role="tabpanel"
                                 aria-labelledby="t_selling-today-tab">
                                 <div class="selling-table-wrap">
                                    <div class="table-responsive">
                                       <table class="table table-border " id="tblDailyAttSummary">
                                          <thead>
                                             <tr>
                                                <th>Department </th>
                                                <th>Total Employee</th>
                                                <th>Male</th>
                                                <th>Female</th>
                                                <th>Present</th>
                                                <th>Present %</th>
                                                <th>Absent</th>
                                                <th>Absent %</th>
                                                <th>Late</th>
                                                <th>Late %</th>
                                                <th>Leave</th>
                                                <th>leave %</th>
                                                <th>Off day</th>
                                                <th>Off day %</th>
                                             </tr>
                                          </thead>
                                          <tbody>
                                             <tr>
                                                <td>Oparetor
                                                </td>
                                                <td>500</td>
                                                <td>300</td>
                                                <td>200</td>
                                                <td>490</td>
                                                <td>99%</td>
                                                <td>10</td>
                                                <td>1%</td>
                                                <td>10</td>
                                                <td>1%</td>
                                                <td>0</td>
                                                <td>0%</td>
                                                <td>0</td>
                                                <td>0%</td>
                                             </tr>

                                             <tr>
                                                <td>Finacial
                                                </td>
                                                <td>300</td>
                                                <td>100</td>
                                                <td>120</td>
                                                <td>490</td>
                                                <td>99%</td>
                                                <td>10</td>
                                                <td>1%</td>
                                                <td>10</td>
                                                <td>1%</td>
                                                <td>0</td>
                                                <td>0%</td>
                                                <td>0</td>
                                                <td>0%</td>
                                             </tr>

                                             <tr>
                                                <td>Manager
                                                </td>
                                                <td>100</td>
                                                <td>300</td>
                                                <td>300</td>
                                                <td>190</td>
                                                <td>99%</td>
                                                <td>10</td>
                                                <td>1%</td>
                                                <td>10</td>
                                                <td>1%</td>
                                                <td>3</td>
                                                <td>0%</td>
                                                <td>1</td>
                                                <td>0%</td>
                                             </tr>
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

                 <div class="row">
                  <div class="col-lg-6 col-md-6 col-sm-12 mb-25 d-block">
                     <div class="card border-0 cashflowChart2">
                        <div class="card-header">
                           <h6>Monthly New Join & Release</h6>
                        </div>
                        <!-- <div class="card-header border-0 px-25 pt-25 pb-15">
                           <div class="chartLine-po-details__overview-content w-100">
                              <div class=" chartLine-po-details__content d-flex flex-wrap justify-content-between">
                                 <div class="chartLine-po-details__titlebar">
                                    <h1>Monthly New Join & Release</h1>
                                 </div>
                              </div>
                           </div>

                        </div> -->
                        <!-- ends: .card-header -->
                        <div style="height: 271px;" class="card-body pt-0 ">
                           <div class="cashflow-chart">
                              <ul class="legend-static mb-30 mt-1 d-flex justify-content-center">
                                 <li class="custom-label">
                                    <span class="bg-primary"></span>New Join
                                 </li>
                                 <li class="custom-label">
                                    <span class="bg-secondary"></span>Relase
                                 </li>
                              </ul>
                              <div class="parentContainer">


                                 <div>
                                    <canvas id="profitGrowthToday"></canvas>
                                 </div>


                              </div>
                           </div>
                        </div>
                        <!-- ends: .card-body -->
                     </div>

                  </div>

                  <div class="col-lg-6 d-block ">
                     <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12 mb-25 d-block ">
                           <div class="device-chart-box">
      
                              <div class="card border-0 MaleFemale">
                                 <div class="card-header">
                                    <h6>Male Female Ratio</h6>
                                 </div>
                                 <!-- ends: .card-header -->
                                 <div class="card-body pt-20 pb-30">
                                    <div class="tab-content">
                                       <div class="tab-pane fade active show" id="se_device-today" role="tabpanel"
                                          aria-labelledby="se_device-today-tab">
                                          <div class="device-pieChart-wrap position-relative">
      
                                             <div class="">
                                                <div class="salesDonutToday"></div>
                                             </div>
      
                                          </div>
                                          <div class="session-wrap session-wrap--top--4">
                                             <div class="session-single">
                                                <div class="chart-label">
                                                   <span class="label-dot dot-primary"></span>
                                                   Male
                                                </div>
                                             </div>
                                             <div class="session-single">
                                                <div class="chart-label">
                                                   <span class="label-dot dot-info"></span>
                                                   Female
                                                </div>
                                             </div>
      
                                          </div>
                                       </div>
      
                                    </div>
                                    <!-- ends: .session-wrap -->
                                 </div>
                                 <!-- ends: .card-body -->
                              </div>
      
                           </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 mb-25 d-block ">
                           <div class="device-chart-box">
      
                              <div class="card border-0 MaleFemale">
                                 <div class="card-header">
                                    <h6>Staff Worker Ratio</h6>
                                 </div>
                                 <!-- ends: .card-header -->
                                 <div class="card-body pt-20 pb-30">
                                    <div class="tab-content">
                                       <div class="tab-pane fade active show" id="se_device-today" role="tabpanel"
                                          aria-labelledby="se_device-today-tab">
                                          <div class="device-pieChart-wrap position-relative">
      
                                             <div class="">
                                                <div class="StapWorkerRatio"></div>
                                             </div>
      
                                          </div>
                                          <div class="session-wrap session-wrap--top--4">
                                             <div class="session-single">
                                                <div class="chart-label">
                                                   <span class="label-dot dot-primary"></span>
                                                   Staff
                                                </div>
                                             </div>
                                             <div class="session-single">
                                                <div class="chart-label">
                                                   <span class="label-dot dot-info"></span>
                                                   Worker
                                                </div>
                                             </div>
      
                                          </div>
                                       </div>
      
                                    </div>
                                    <!-- ends: .session-wrap -->
                                 </div>
                                 <!-- ends: .card-body -->
                              </div>
      
                           </div>
                        </div>
                     </div>
                     <!-------Stap Workar Ratio------>
                  </div>

                 </div> 


                  <!-----Start -->
                  <div class="col-lg-8 col-md-12 col-sm-12 mb-25">
                     <!-- Card 1  -->
                     <div class="ap-po-details ap-po-details--3 radius-xl d-flex">
                        <div class="row">
                           <div class="col-lg-4 overview-content overview-content3 bg-none mb-3">
                              <div class="d-flex">
                                 <div class="revenue-chart-box__Icon me-20 order-bg-opacity-primary color-primary">
                                    <i class="uil uil-user"></i>
                                 </div>
                                 <div class="d-flex align-items-start flex-wrap">
                                    <div class="me-25">
                                       <h2 id="RegularEmp">530</h2>
                                       <p class="mt-1 mb-0">Regular Emp
                                       </p>
                                    </div>
   
                                    <!-- <div class="ap-po-details bg-none">
                                       <span class="color-success"><i class="las la-arrow-up"></i>
                                          <strong>25.36%</strong></span>
                                    </div> -->
                                 </div>
                              </div>
                           </div>
                           <div class="col-lg-4 overview-content overview-content3 bg-none mb-3">
                              <div class="d-flex">
                                 <div class="revenue-chart-box__Icon me-20 order-bg-opacity-secondary color-secondary">
   
                                    <i class="uil uil-user-minus"></i>
                                 </div>
                                 <div class="d-flex align-items-start flex-wrap">
                                    <div class="me-25">
                                       <h2>10</h2>
                                       <p class="mt-1 mb-0">Released</p>
                                    </div>
   
                                    <!-- <div class="ap-po-details bg-none">
                                       <span class="color-success"><i class="las la-arrow-up"></i>
                                          <strong>25.36%</strong></span>
                                    </div> -->
                                 </div>
                              </div>
                           </div>

                           <div class="col-lg-4 overview-content overview-content3 bg-none mb-3">
                              <div class="d-flex">
                                 <div class="revenue-chart-box__Icon me-20 order-bg-opacity-success color-success">
   
                                    <i class="uil uil-users-alt"></i>
                                 </div>
                                 <div class="d-flex align-items-start flex-wrap">
                                    <div class="me-25">
                                       <h2 id="totalEmpReg">540</h2>
                                       <p class="mt-1 mb-0">Total</p>
                                    </div>
<!--    
                                    <div class="ap-po-details bg-none">
                                       <span class="color-success"><i class="las la-arrow-up"></i>
                                          <strong>25.36%</strong></span>
                                    </div> -->
                                 </div>
                              </div>
                           </div>

                           <div class="col-lg-4 overview-content overview-content3 bg-none mb-3">
                              <div class="d-flex">
                                 <div class="revenue-chart-box__Icon me-20 order-bg-opacity-warning color-warning">
   
                                    <i class="uil uil-user-md"></i>
                                 </div>
                                 <div class="d-flex align-items-start flex-wrap">
                                    <div class="me-25">
                                       <h2 id="male">250</h2>
                                       <p class="mt-1 mb-0">Male</p>
                                    </div>
   
                                    <!-- <div class="ap-po-details bg-none">
                                       <span class="color-danger"><i class="las la-arrow-down"></i>
                                          <strong>25.36%</strong></span>
                                    </div> -->
                                 </div>
                              </div>
                           </div>
                           
                        <div class="col-lg-4 overview-content overview-content3 bg-none mb-3">
                           <div class="d-flex">
                              <div class="revenue-chart-box__Icon me-20 order-bg-opacity-warning color-warning">

                                 <i class="uil uil-user-nurse"></i>
                              </div>
                              <div class="d-flex align-items-start flex-wrap">
                                 <div class="me-25">
                                    <h2 id="female">280</h2>
                                    <p class="mt-1 mb-0">Female</p>
                                 </div>

                                 <!-- <div class="ap-po-details bg-none">
                                    <span class="color-danger"><i class="las la-arrow-down"></i>
                                       <strong>25.36%</strong></span>
                                 </div> -->
                              </div>
                           </div>
                        </div>
                        <div class="col-lg-4 overview-content overview-content3 bg-none mb-3">
                           <div class="d-flex">
                              <div class="revenue-chart-box__Icon me-20 order-bg-opacity-warning color-warning">

                                 <i class="uil uil-clock-seven"></i>
                              </div>
                              <div class="d-flex align-items-start flex-wrap">
                                 <div class="me-25">
                                    <h2 id="overtime">497</h2>
                                    <p class="mt-1 mb-0">Over Time</p>
                                 </div>

                                 <!-- <div class="ap-po-details bg-none">
                                    <span class="color-danger"><i class="las la-arrow-down"></i>
                                       <strong>25.36%</strong></span>
                                 </div> -->
                              </div>
                           </div>
                        </div>
                        </div>
                     </div>
                     <!-- Card 1 End  -->
                     <!-- Salary Comparison chat Start -->

                     <div class="mt-25">
                           <div class="card">
                              <div class="card-header">
                                 <div class="chartLine-po-details__titlebar">

                                    <h1>Salary Comparison(Last 12th Month)</h1>
                                 </div>
                              </div>
                              <div class="card-body">
         
                                 <div class="">
                                    <div class="barChart"></div>
                                 </div>
         
                              </div>
                           </div>
                     </div>
                  <!-- Salary Comparison chat End -->

                  </div>
                  <div class="col-lg-4 col-md-12 col-sm-12 mb-25">
                     <div style="height:519px" class="card">
                        <div class="card-header">
                           <div class="chartLine-po-details__titlebar">
                              <h1>Floor Wise Employee</h1>
                           </div>
                          
                        </div>
                        <div class="card-body">
                           <style>
                              #barChartHorizontal {
                                 height: 33px;
                              }
                           </style>
                           <div class="">
                              <canvas id="barChartHorizontal"></canvas>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!---Salary Comparison Table Start ---->

   
                  <div class="col-12 mb-25">
                     <!-- Card 1  -->
                     <div class="ap-po-details ap-po-details--3 radius-xl d-flex py-25">
                        <div class="col-lg-3 overview-content overview-content3 b-none bg-none mb-lg-0 mb-20">
                           <div class="d-flex">
                              <div class="revenue-chart-box__Icon me-20 bg-primary color-white rounded-circle">
                                 <i class="uil uil-money-withdraw"></i>

                              </div>
                              <div class="d-flex align-items-start flex-wrap">
                                 <div class="me-10">
                                    <h1 id="TodaySalaryAmt"></h1>
                                       <p class="mt-1 mb-0">Today’s Salary</p>
                                 </div>

                                 <!-- <div class="ap-po-details bg-none">
                                    <span class="color-success fs-14  d-inline-block mt-2"><i
                                          class="las la-arrow-up"></i>
                                       <strong>25.36%</strong></span>
                                 </div> -->
                              </div>
                           </div>
                        </div>
                        <div class="col-lg-3 overview-content overview-content3 bg-none b-none mb-lg-0 mb-20">
                           <div class="d-flex">
                              <div class="revenue-chart-box__Icon me-20 bg-info color-white rounded-circle">
                                 <i class="uil uil-clock-eight"></i>
                              </div>
                              <div class="d-flex align-items-start flex-wrap">
                                 <div class="me-10">
                                    <h1 id="todayOtAmount"></h1>
                                    <p class="mt-1 mb-0">Today's OT Amount</p>
                                 </div>

                                 <!-- <div class="ap-po-details bg-none">
                                    <span class="color-success fs-14 d-inline-block mt-2"><i
                                          class="las la-arrow-up"></i>
                                       <strong>25.36%</strong></span>
                                 </div> -->
                              </div>
                           </div>
                        </div>
                        <div class="col-lg-3 overview-content overview-content3 bg-none b-none mb-lg-0 mb-20">
                           <div class="d-flex">
                              <div class="revenue-chart-box__Icon me-20 bg-success color-white rounded-circle">
                                 <i class="uil uil-money-withdraw"></i>
                              </div>
                              <div class="d-flex align-items-start flex-wrap">
                                 <div class="me-10">
                                    <h1 id="LastMonthCosting"></h1>
                                    <p class="mt-1 mb-0">Last Month Costing</p>
                                 </div>
                                 <!-- <div class="ap-po-details bg-none">
                                    <span class="color-success fs-14 d-inline-block mt-2"><i
                                          class="las la-arrow-up"></i>
                                       <strong>25.36%</strong></span>
                                 </div> -->
                              </div>
                           </div>
                        </div>
                        <div class="col-lg-3 overview-content overview-content3 bg-none b-none mb-lg-0 mb-20">
                           <div class="d-flex">
                              <div class="revenue-chart-box__Icon me-20 bg-warning color-white rounded-circle">
                                 <i class="uil uil-money-bill"></i>
                              </div>
                              <div class="d-flex align-items-start flex-wrap">
                                 <div class="me-10">
                                    <h1 id="lastMonthOtAmount"></h1>
                                    <p class="mt-1 mb-0">Last Month OT Amount
                                    </p>
                                 </div>

                                 <!-- <div class="ap-po-details bg-none">
                                    <span class="color-danger fs-14 d-inline-block mt-2"><i
                                          class="las la-arrow-down"></i>
                                       <strong>25.36%</strong></span>
                                 </div> -->
                              </div>
                           </div>
                        </div>

                     </div>
                     <!-- Card 1 End  -->
                  </div>

               <div class="col-lg-12">

                  <div class="card border-0">
                     <div class="card-header">
                        <h6>Total Overtime</h6>
                     </div>

                     <div class="card-body  mt-3">
                        <div class="tab-content">
                           <div class="tab-pane fade active show" id="st_matrics-today" role="tabpanel" aria-labelledby="st_matrics-today-tab">
                              <div class="row">
                                 <div class="col-lg-6 table-responsive">
                                    <table class=" table table-bordered">
                                       <thead>
                                          <tr class="text-center">
                                             
                                             <th scope="col" colspan="3">Total Overtime (Monthly)
                                             </th>
                                          </tr>
                                       </thead>
                                       <tbody>
                                          <tr>
                                             <td>
                                                <table class="table table-bordered table-hover">
                                                   <tr>
                                                      <td> OT Hour : <br> <strong>7H</strong> </td>
                                                   </tr>
                                                   <tr>
                                                      <td> OT Amount : <br> <strong>3200Tk</strong></td>
                                                   </tr>
                                                </table>
                                             </td>
                                             <td>
                                                <table class="table table-bordered table-hover">
                                                   <tr>
                                                      <td>Average : <br> <strong>45%</strong></td>
                                                   </tr>
                                                   <tr>
                                                      <td>Regular OT Hour : <br> <strong>7H</strong></td>
                                                   </tr>
                                                   <tr>
                                                      <td>OT Amount : <br><strong>3,200Tk</strong></td>
                                                   </tr>
                                                </table>
                                             </td>
                                             <td>
                                                <table class="table table-bordered table-hover">
                                                   <tr>
                                                      <td>Extra OT Hr : <br> <strong>7H</strong></td>
                                                   </tr>
                                                  
                                                   <tr>
                                                      <td>Extra OT Amount : <br> <strong>3,400TK</strong></td>
                                                   </tr>
                                                </table>
                                             </td>
                                          </tr>
                                       </tbody>
                                    </table>
                                 </div>
                                 <div class="col-lg-6 table-responsive">
                                    <table class=" table table-bordered ">
                                       <thead>
                                          <tr class="text-center">
                                             
                                             <th scope="col" colspan="3">Total Overtime (Daily)
                                             </th>
                                          </tr>
                                       </thead>
                                       <tbody>
                                          <tr>
                                             <td>
                                                <table class="table table-bordered table-hover">
                                                   <tr>
                                                      <td> OT Hour : <br> <strong>7H</strong> </td>
                                                   </tr>
                                                   <tr>
                                                      <td> OT Amount : <br> <strong>32,540TK</strong></td>
                                                   </tr>
                                                </table>
                                             </td>
                                             <td>
                                                <table class="table table-bordered table-hover">
                                                   <tr>
                                                      <td>Average : <br><strong>33%</strong></td>
                                                   </tr>
                                                   <tr>
                                                      <td>Regular OT Hour : <br> <strong>7H</strong></td>
                                                   </tr>
                                                   <tr>
                                                      <td>OT Amount : <br><strong>32,5400TK</strong></td>
                                                   </tr>
                                                </table>
                                             </td>
                                             <td>
                                                <table class="table table-bordered table-hover">
                                                   <tr>
                                                      <td>Extra OT Hr :<br> <strong>7H</strong> </td>
                                                   </tr>
                                                   
                                                   <tr>
                                                      <td>Extra OT Amount : <br><strong>3,200Tk</strong></td>
                                                   </tr>
                                                </table>
                                             </td>
                                          </tr>
                                       </tbody>
                                    </table>
                                 </div>
                                 
                                 
                              </div>
                        </div>
                     </div>
                  </div>
               </div>



                  <!-----Today’s Costing section Start---->

                  <!-----Today’s Costing section End---->





                  <!---Salary Comparison Table End------->

               </div>
               <!-- ends: .row -->

               <!-- Start: .row -->

               <div class="">
                  <div class="row">


                  </div>
               </div>


            </div>
         </div>
      </div>
<script>

    $(document).ready(function () {
        console.log("Hello");
        var DailyAttUrl = 'http://cw-hrms-api.codehosting.xyz/api/DailyAttendance/dailyAttendanceStatus';
        var DailyAttSumUrl = 'http://cw-hrms-api.codehosting.xyz/api/DailyAttendance/dailyAttendanceSummary';
        var CurrentEmpStatusUrl = 'http://cw-hrms-api.codehosting.xyz/api/DailyAttendance/currentEmployeeStaus';
        var GetTodaysCostingUrl = 'http://cw-hrms-api.codehosting.xyz/api/DailyAttendance/getTodaysCosting';
        var GetMonthlyCostingUrl = 'http://cw-hrms-api.codehosting.xyz/api/DailyAttendance/getlastMonthCosting';
        var GetLast7DaysPARatio = 'http://cw-hrms-api.codehosting.xyz/api/DailyAttendance/dailyAttendancehistory';

        var companyId = '0001'; 
        var date = '2024-02-01';

       var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTM5MzIxOTYsImV4cCI6MTc0NTQ2ODE5NiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.letXzwpes_YaMFumZsklIowaTR80FXr3m5h8mwCABCQ';

        ApiCall(DailyAttUrl, companyId, date, token).then(function (response) {
            $('#totalEmp').text(response.total);
            $('#totalEmpRatio').text(response.total);
            $('#todayPresent').text(response.present);
            $('#todayPresentRatio').text(response.pressentRatio);
            $('#todayAbsent').text(response.absent);
            $('#todayAbsentRatio').text(response.absentRatio);
            $('#todayLate').text(response.late);
            $('#todayLateRatio').text(response.lateRatio);
            $('#todayLeave').text(response.leave);
            $('#todayLeaveRatio').text(response.leavePers);
        }).catch(function (error) {
            console.error('Error occurred while fetching data:', error);
            });



       ApiCall(GetLast7DaysPARatio, companyId, date, token)
    .then(function (response) {
        var GetLast7DaysPARatioData = response;
        console.log(GetLast7DaysPARatioData); // Log the entire response
        var p = [];

        var a = []
        var w = [];
        var i = 0;
        // Loop through the last 7 days
        for (i ; i < GetLast7DaysPARatioData.length; i++) {

            p.push(GetLast7DaysPARatioData[i].present)
            a.push(GetLast7DaysPARatioData[i].absent)
            w.push(GetLast7DaysPARatioData[i].weekDay)
          
             console.log("present", GetLast7DaysPARatioData[i].present);     
             console.log("absent", GetLast7DaysPARatioData[i].absent); 
        }   
        console.log("present", p); 
         console.log("absent", a); 
        // Call the chartjsBarChart function with the obtained data
        chartjsBarChart(
            "salesGrowthToday",
            p, // Pass the 'data' array here
            a, // Assuming this is the data for another dataset (e.g., historical data)
            w,
            350,
            "Presnt",
            "Absent"
        );

        console.log('Hello PA');
    })
    .catch(function (error) {
        console.error('Error occurred while fetching data:', error);
    });



       



        //ApiCall(GetLast7DaysPARatio, companyId, date, token)
        //    .then(function (response) {
        //        var GetLast7DaysPARatioData = response;

        //        // Extract the sales growth data from the response
        //        var salesGrowthData = GetLast7DaysPARatioData.map(function (item) {
        //            return item.salesGrowth; // Assuming salesGrowth is the property containing the sales growth data
        //        });

        //        // Update the chart with the new data
        //        chartjsBarChart(
        //            "salesGrowthToday",
        //            salesGrowthData,
        //            [10, 30, 8, 11, 21, 32, 11], // Assuming this is the data for another dataset (e.g., historical data)
        //            [
        //                "Sat",
        //                "Sun",
        //                "Mon",
        //                "Tue",
        //                "Wed",
        //                "Thu",
        //                "Fri",
        //            ],
        //            350,
        //            "Presnt",
        //            "Absent"
        //        );
        //    })
        //    .catch(function (error) {
        //        console.error('Error occurred while fetching data:', error);
        //    });




        ApiCall(DailyAttSumUrl, companyId, date, token)
            .then(function (responsedata) {
                var tableBody = $('#tblDailyAttSummary tbody');
                tableBody.empty(); 
                var newRow = '';
                responsedata.forEach(item => {
                    newRow += `<tr>
                        <td>${item.department}</td>
                        <td>${item.totalEmployee}</td>
                        <td>${item.male}</td>
                        <td>${item.female}</td>
                        <td>${item.present}</td>
                        <td>${item.presentRatio}</td>
                        <td>${item.absent}</td>
                        <td>${item.absentRatio}</td>
                        <td>${item.leave}</td>
                        <td>${item.leaveRatio}</td>
                        <td>${item.late}</td>
                        <td>${item.lateRatio}</td>
                        <td>${item.offDay}</td>
                        <td>${item.offdayRatio}</td>
                    </tr>`;
                   
                });
                tableBody.append(newRow);
            })
            .catch(function (error) {
                console.error('Error occurred while fetching data:', error);
            });


        ApiCallSam(CurrentEmpStatusUrl, companyId, token).then(function (response) {
                $('#totalEmpReg').text(response.totalEmployee);
                $('#male').text(response.male);
                $('#female').text(response.female);
                $('#overtime').text(response.overTime);

        }).catch(function (error) {
         console.error('Error occurred while fetching data:', error);
            });



        ApiCallGetCosting(GetTodaysCostingUrl, date, token).then(function (response) {
            var responseData = response[0];
            $('#TodaySalaryAmt').text(responseData.dailySalaryAmnt +'Tk');
            $('#todayOtAmount').text(responseData.dailyOTPay +'Tk');
        }).catch(function (error) {
            console.error('Error occurred while fetching data:', error);
            });


        ApiCallGetCosting(GetMonthlyCostingUrl, date, token).then(function (response) {

            var GetDataFromArray = response[0];
            $('#LastMonthCosting').text(GetDataFromArray.monthlyPaySalaryamnt +'Tk');
            $('#lastMonthOtAmount').text(GetDataFromArray.monthlyOTPay +'Tk');
        }).catch(function (error) {
            console.error('Error occurred while fetching data:', error);
            });


        function ApiCall(url, companyId, date, token) {
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
                        date: date
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
    });


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

       function ApiCallGetCosting(url, date, token) {
        return new Promise(function (resolve, reject) {
            $.ajax({
                url: url,
                type: 'GET',
                dataType: 'json',
                headers: {
                    'Authorization': 'Bearer ' + token  // Corrected header field
                },
                data: {
                    date: date,
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
