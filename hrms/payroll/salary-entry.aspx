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
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <div class="mt-1">
        <div class="products_page product_page--grid mb-30">
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-lg-3 col-sm-12 mb-lg-0 mb-30">
                        <div class="card">
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

                                                            <div class="col-lg-2">
                                                                <label for="txtSearch" class="form-label mb-1 p-0">Search by</label>
                                                                <div class="input-group">
                                                                    <select name="ddlSearchType" id="ddlSearchBy" class="form-control me-2">
                                                                        <option value="2">Staff </option>
                                                                        <option value="1">Worker</option>
                                                                    </select>
                                                                </div>
                                                            </div>


                                                            <div class="col-lg-2">
                                                                <label for="txtSearch" class="form-label mb-1 p-0">Employee ID</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-text bg-white border-end-0">
                                                                        <i class="uil uil-search"></i>
                                                                    </span>
                                                                    <input type="text" id="txtEmpCardNo" class="form-control border-start-0" placeholder="Employee ID..." aria-describedby="searchIcon">
                                                                </div>
                                                            </div>

                                                            <!-- Start Date -->
                                                              <%--  <div class="col-lg-2 day-wise-field" >
                                                                    <label for="txtStartDate" class="form-label mb-1 p-0">Start Date</label>
                                                                    <input type="date" id="txtStartDate" class="form-control">
                                                                </div>

                                                                <div class="col-lg-2 day-wise-field" >
                                                                    <label for="txtEndDate" class="form-label mb-1 p-0">End Date</label>
                                                                    <input type="date" id="txtEndDate" class="form-control">
                                                                </div>--%>

                                                      





                                                            <!-- End Date + Search Button -->
                                                            <div class="col-lg-2 d-flex gap-2">
                                                                    <button type="button" title="Search" id="btnSearch" onclick="SearchEmployee()"
                                                                        class="btn btn-primary text-center"
                                                                        style="padding: 7px;">
                                                                        <i class="fas fa-search"  style="font-size: 18px"></i>
                                                                    </button>
                                                           <%--      <button type="button" title="Search" id="btnProcessing" onclick="onClickSaveWeekend()"
                                                                        class="btn btn-success text-center"
                                                                        style="padding: 7px;">
                                                                        <i class="fas fa-save"  style="font-size: 18px"></i>
                                                                    </button>
                                                                 <button type="button" title="Search" id="btnDelete" onclick="Delete()"
                                                                        class="btn btn-danger text-center"
                                                                        style="padding: 7px;">
                                                                        <i class="fas fa-trash"  style="font-size: 18px"></i>
                                                                    </button>--%>
                                                               
                                                                
                                                                
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

                                                <!-- Employee Salary Entry Modal -->
                                            <%--    <div class="modal fade" id="salaryModal" tabindex="-1" aria-labelledby="salaryModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="salaryModalLabel">Set Employee Salary</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="salaryForm">
                                                                    <input type="hidden" id="empIdField" name="empId">
                                                                    <div class="form-group row mb-3">
                                                                        <div class="col-sm-3 d-flex align-items-center">
                                                                            <label for="ddlDataAccessLevel" class="col-form-label color-dark fs-14 fw-500 mb-0">Payment Method</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="input-group">
                                                                         <span class="input-group-text bg-white text-gray">
                                                                                    <i class="las la-credit-card"></i>
                                                                                </span>
                                                                                <select name="ddlPaymentMethod" id="ddlDataAccessLevel" class="form-select">
                                                                                    <option value="0">---Select---</option>
                                                                                    <option value="3">Bank</option>
                                                                                    <option value="2">Check</option>
                                                                                    <option value="1">Cash</option>
                                                                                    <option value="4">Dutch Bangla</option>
                                                                                </select>
                                                                            </div>
                                                                            <span class="text-danger" id="errorDataAccessLevel"></span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtBasicSalary" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">Basic</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                                <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtBasicSalary">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                     <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtMedical" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">Medical</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                              <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtMedical">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                     <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtConveyance" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">Conveyance</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                               <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtConveyance">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                     <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtTechnical" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">Technical</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                               <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtTechnical">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                     <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtHouse" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">House</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                               <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtHouse">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                                                                                                                                                <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtOthers" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">Others</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                               <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtOthers">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                     <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtGross" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">Gross</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                               <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtGross">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                     <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtAttBonuse" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">Atten. Bonus</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                            <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtAttBonuse">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                     <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtDormetory" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">Dormitory Rent</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                               <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtDormetory">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                     <div class="form-group row mb-25">
                                                                        <div class="col-sm-3 d-flex aling-items-center">
                                                                            <label for="txtTds" class=" col-form-label color-dark fs-14 fw-500 align-center mb-10">TDS</label>
                                                                        </div>
                                                                        <div class="col-sm-9">
                                                                            <div class="with-icon">
                                                                              <span class="las la-money-bill lar color-gray"></span>
                                                                                <input type="number" class="form-control  ih-medium ip-gray radius-xs b-light" id="txtTds">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                   
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                <button type="submit" class="btn btn-primary" id="saveSalaryBtn">Save Salary</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>--%>

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
                                                                                         <div class="col-lg-4 mb-10">
                                                                                        <label for="ddlOvertTime" class="color-dark fs-14 fw-500 align-center">Over Time </label>
                                                                                        <div class="input-group with-icon">

                                                                                            <select name="ddlOvertTime" id="ddlOvertTime" class="form-control ih-medium ip-gray radius-xs b-light">
                                                                                                <option value="0">---Select---</option>
                                                                                                <option value="3">Yes</option>
                                                                                                <option value="2">No</option>
                                                                                                <option value="1">Single Rate</option>
                                                                                           
                                                                                            </select>
                                                                                        </div>
                                                                                        <span class="text-danger" id="ddlOvertTimeError"></span>
                                                                                    </div>
                                                                                    <div class="col-lg-4">
                                                                            <label for="ddlPaymentMethod" class="color-dark fs-14 fw-500 align-center">Payment Method</label>
                                                                            <div class="input-group with-icon">
                                                                                
                                                                                <select name="ddlPaymentMethod" id="ddlPaymentMethod" class="form-control ih-medium ip-gray radius-xs b-light">
                                                                                    <option value="0">---Select---</option>
                                                                                    <option value="1">Cash</option>
                                                                                    <option value="3">Bank</option>
                                                                                    <option value="2">Check</option>
                                                                                </select>
                                                                            </div>
                                                                            <span class="text-danger" id="errorDataAccessLevel"></span>
                                                                                      </div>

                                                                               
                                                                                     <div class="col-lg-4 mb-10">
                                                                                        <label for="ddlSalaryBank" class="color-dark fs-14 fw-500 align-center">Salary Bank</label>
                                                                                        <div class="input-group with-icon">

                                                                                            <select name="ddlSalaryBankName" id="ddlSalaryBank" class="form-control ih-medium ip-gray radius-xs b-light">

                                                                                               <%-- <option value="0">---Select---</option>
                                                                                                <option value="3">IFIC Bank</option>
                                                                                                <option value="2">Inslami Bank</option>
                                                                                                <option value="1">Jamuna bank</option>--%>
                                                                                           
                                                                                            </select>
                                                                                        </div>
                                                                                        <span class="text-danger" id="ddlSalaryBankError"></span>
                                                                                    </div>


                                                                                    <div class="col-lg-4">
                                                                                        <div class="form-group">
                                                                                            <label for="txtAccountNo" class=" color-dark fs-14 fw-500 align-center">Account No</label>
                                                                                            <div class="with-icon">
                                                                                                <span class="las la-money-bill"></span>
                                                                                                <input type="text" class="form-control ih-medium ip-gray radius-xs b-light" id="AccountNo">
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                        <div class="col-lg-4 mb-10">
                                                                                        <label for="ddlGrade" class="color-dark fs-14 fw-500 mb-1">Grade</label>
                                                                                        <div class="input-group with-icon">

                                                                                            <select name="ddlGrade" id="ddlGrade" class="form-control ih-medium ip-gray radius-xs b-light">
                                                                                               <%-- <option value="0">---Select---</option>
                                                                                                <option value="3">1st</option>
                                                                                                <option value="2">2nd</option>
                                                                                                <option value="1">3rd</option>--%>
                                                                                           
                                                                                            </select>
                                                                                        </div>
                                                                                        <span class="text-danger" id="ddlGradeError"></span>
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

                                                                        <div class="col-lg-4">
                                                                            <div class="form-group">
                                                                                <label for="txtBasicSalary" class=" color-dark fs-14 fw-500 align-center">Basic Salary</label>
                                                                                <div class="with-icon">
                                                                                    <span class="las la-money-bill"></span>
                                                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtBasicSalary">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4">
                                                                            <div class="form-group">
                                                                                <label for="txtMedical" class=" color-dark fs-14 fw-500 align-center">Medical</label>
                                                                                <div class="with-icon">
                                                                                    <span class="las la-money-bill"></span>
                                                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtMedical">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4">
                                                                            <div class="form-group">
                                                                                <label for="txtConveyance" class=" color-dark fs-14 fw-500 align-center">Conveyance</label>
                                                                                <div class="with-icon">
                                                                                    <span class="las la-money-bill"></span>
                                                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtConveyance">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4">
                                                                            <div class="form-group">
                                                                                <label for="txtTechnical" class=" color-dark fs-14 fw-500 align-center">Technical</label>
                                                                                <div class="with-icon">
                                                                                    <span class="las la-money-bill"></span>
                                                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtTechnical">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4">
                                                                            <div class="form-group">
                                                                                <label for="txtHouse" class=" color-dark fs-14 fw-500 align-center">House Rent</label>
                                                                                <div class="with-icon">
                                                                                    <span class="las la-money-bill"></span>
                                                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtHouse">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4">
                                                                            <div class="form-group">
                                                                                <label for="txtOthers" class=" color-dark fs-14 fw-500 align-center">Others</label>
                                                                                <div class="with-icon">
                                                                                    <span class="las la-money-bill"></span>
                                                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtOthers">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                   
                                                                        <div class="col-lg-4">
                                                                            <div class="form-group">
                                                                                <label for="txtAttBonuse" class=" color-dark fs-14 fw-500 align-center">Attendance Bonus</label>
                                                                                <div class="with-icon">
                                                                                    <span class="las la-money-bill"></span>
                                                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtAttBonuse">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4">
                                                                            <div class="form-group">
                                                                                <label for="txtDormetory" class=" color-dark fs-14 fw-500 align-center">Dormitory Rent</label>
                                                                                <div class="with-icon">
                                                                                    <span class="las la-money-bill"></span>
                                                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtDormetory">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4">
                                                                            <div class="form-group">
                                                                                <label for="txtTds" class=" color-dark fs-14 fw-500 align-center">TDS</label>
                                                                                <div class="with-icon">
                                                                                    <span class="las la-money-bill"></span>
                                                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light" id="txtTds">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                                </div>



                                                                            </div>

                                                                        <div class="col-lg-4">
                                                                            <div class="card shadow-sm rounded p-3">
                                                                                <div class="text-center">
                                                                                    <!-- Profile Image -->
                                                                                    <img src="/hrms/user_img_default.jpg" alt="Employee Photo"
                                                                                        class="rounded-circle mb-3" width="100" height="100" />

                                                                                    <!-- Employee Info -->
                                                                                    <h5 class="mb-1 fw-bold">John Doe</h5>
                                                                                    <p class="mb-1 text-muted">Senior Accountant</p>
                                                                                    <p class="mb-1 text-muted">Finance Department</p>

                                                                                    <!-- Details -->
                                                                                    <ul class="list-group list-group-flush mt-3 text-start">
                                                                                        <li class="list-group-item py-1"><strong>Card No:</strong> 123456</li>
                                                                                        <li class="list-group-item py-1"><strong>Type:</strong> Staff</li>
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                        </div>



                                                                   

                                                                      


                                                                    </div>
                                                                </form>
                                                            </div>

                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                <button type="submit" class="btn btn-primary" id="saveSalaryBtn">Submit</button>
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
            var getEmployeeDayWiseUrl = `${rootUrl}/api/Employee/employees`;
            var getEmployeeDateWiseUrl = `${rootUrl}/api/WeekendSetup/getDatewiseEmployeeForWeekend`;
            var PostDateWiseWeekendSetupURL = `${rootUrl}/api/WeekendSetup/save/datewiseWeekendsetup`;

            var GetBankInfoURL = `${rootUrl}/api/BankInfo/basicInfo/${CompanyID}`;
            var GeGradeInfoURL = `${rootUrl}/api/Grade/grades?CompanyId=${CompanyID}`;


            var getDepartmentUrl = `${rootUrl}/api/Department/basicInfo/${CompanyID}`;
            var getUnitUrl = `${rootUrl}/api/Unit/basicInfo?CompanyId=${CompanyID}`;



            var token = '<%= Session["__UserToken__"] %>';


            $(document).ready(function () {

                GetEmployeeDayWise();



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

                //model Bank Info
                //GetBankInfo();

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


                GetEmployeeDayWise();

            }




            function showAttendanceHideEmployee() {
                $('#attendanceContainer').hide();
            }


            function GetEmployee_DateWise() {
                const HolyDayDate = $('#txtWeekendDate').val();

                if (HolyDayDate == null || HolyDayDate == '') {
                    Swal.fire({
                        title: 'Warning!',
                        text: 'Please Select Date',
                        icon: 'warning',
                        confirmButtonText: 'OK'
                    })
                }

                sessionStorage.setItem('__WeekendDate__', HolyDayDate);


                const EmpCardNo = $('#txtEmpCardNo').val();
                const deptQuery = getSelectedDepartmentQuery();
                const unitQuery = getSelectedUnitQuery();

                const url = `${getEmployeeDateWiseUrl}/${CompanyID}/${HolyDayDate}?cardNum=${EmpCardNo}&${deptQuery}&${unitQuery}`;

                ApiCall(url, token)
                    .then(response => {
                        if (response.statusCode === 200) {
                            $('#alertContainer').hide();
                            $('#dateWiseAlert').show();
                            const message = `Weekend employee data loaded for the date: ${HolyDayDate}.`;

                            $('#dateWiseAlert').html(`<strong>${message}</strong>`).removeClass('d-none');

                            bindTableData(response.data);
                        } else {
                            console.error('API Error:', response.message);
                        }
                    })
                    .catch(error => {
                        console.error('Network Error:', error);
                    });
            }

            function GetEmployeeDayWise() {
                const EmpCardNo = $('#txtEmpCardNo').val();
                const deptQuery = getSelectedDepartmentQuery();
                const unitQuery = getSelectedUnitQuery();
                const empCardNo = '';
                if (EmpCardNo.length > 0) {
                    empCardNo = `&EmpCardNo=${EmpCardNo}`;
                }



                const url = `${getEmployeeDayWiseUrl}?CompanyId=${CompanyID}${deptQuery}${empCardNo}`;

                ApiCall(url, token)
                    .then(response => {
                        if (response.statusCode === 200) {
                            //$('#alertContainer').hide();

                            //$('#dateWiseAlert').show();
                            //$('#dateWiseAlert').html = '';
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
                        <a href="javascript:void(0)" data-id="${row.empId}" class="btn btn-primary btn-sm text-white delete-btn remove">
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
                    { name: "empType", title: "Emp Type", className: "userDatatable-content" },
                    { name: "joiningDate", title: "Joining Date", className: "userDatatable-content" },
                    //{ name: "newWeekend", title: "New Weekend", className: "userDatatable-content" },
                    { name: "action", title: "action", className: "userDatatable-content" }
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

                //          $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                //  const EmpId = $(this).data('id');
                ////  Delete(userRoleId); // Custom function to handle delete logic
                //              console.log('Delete button clicked for userRoleId:', EmpId);

                $(document).off('click', '.delete-btn').on('click', '.delete-btn', function () {
                    const empId = $(this).data('id');
                    $('#empIdField').val(empId);
                    $('#salaryModal').modal('show');
                });

                // Move this outside the click handler
                $('#salaryModal').on('shown.bs.modal', function () {
                    GetBankInfo(); // Safe to call here — dropdown will exist in the DOM
                    GetGradeInfo();
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

            function onClickSaveWeekend() {
                var searchType = $('#ddlSearchBye').val();

                if (searchType === 'Day') {
                    Day_WiseEmpWeekendSetup();
                } else {
                    DateWiseEmpWeekendSetup();
                }
            }

            function Day_WiseEmpWeekendSetup() {
                const starDate = sessionStorage.getItem('__startDate__');
                const endDate = sessionStorage.getItem('__endDate__');
                const weekendDate = sessionStorage.getItem('__weekendDate__');

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

                const formData = new FormData();
                formData.append('companyId', CompanyID);
                formData.append('fromDate', starDate);
                formData.append('toDate', endDate);
                formData.append('weekendDay', weekendDate);

                empIds.forEach((id, index) => {
                    formData.append(`empIds[${index}]`, id);
                });

                ApiCallPostForm(PostDayWiseWeekendSetupURL, token, formData)
                    .then(data => {
                        if (data.status === 200) {
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


            function DateWiseEmpWeekendSetup() {
                //const WeekendDate = $('#txtWeekendDate').val();
                const WeekendDate = sessionStorage.getItem('__WeekendDate__');


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

                const formData = new FormData();
                formData.append('companyId', CompanyID);
                formData.append('weekendDay', WeekendDate);

                empIds.forEach((id, index) => {
                    formData.append(`empIds[${index}]`, id);
                });

                ApiCallPostForm(PostDateWiseWeekendSetupURL, token, formData)
                    .then(data => {
                        if (data.status === 200) {
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



            function onClickDeleteWeekend() {
                var searchType = $('#ddlSearchBye').val();

                if (searchType === 'Day') {
                    Day_WiseWeekendDelete();
                } else {
                    DateWiseWeekendDelete();
                }
            }



            function Delete() {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "Do you really want to delete this Weekend?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        var searchType = $('#ddlSearchBye').val();
                        if (searchType === 'Day') {
                            Delete_DayWiseWeekend();
                        } else {
                            DeleteDateWiseWeekend();
                        }



                    }
                });
            }


            function DeleteDateWiseWeekend() {
                const WeekendDate = sessionStorage.getItem('__WeekendDate__');
                const employeeQuery = getSelectedEmployeeQuery(); // Already returns query string like "empIds=0001&empIds=0002"

                if (!employeeQuery) {
                    Swal.fire({
                        title: 'Warning!',
                        text: 'Please select at least one employee.',
                        icon: 'warning',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                const url = `${DeleteDateWiseUrl}/${CompanyID}/${WeekendDate}?${employeeQuery}`;

                ApiDeleteByUrl(url, token)
                    .then(function (response) {
                        Swal.fire({
                            title: 'Success!',
                            text: 'Weekend deleted successfully.',
                            icon: 'success',
                            confirmButtonText: 'OK'
                        }).then(() => {
                            GetEmployee_DateWise();
                        });
                    })
                    .catch(function (error) {
                        Swal.fire({
                            title: 'Error!',
                            text: 'An error occurred while deleting the weekend data.',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    });
            }

            function Delete_DayWiseWeekend(id) {

                const startDate = sessionStorage.getItem('__startDate__');
                const endDate = sessionStorage.getItem('__endDate__');
                const weekendDate = sessionStorage.getItem('__weekendDate__');
                const employeeQuery = getSelectedEmployeeQuery(); // Already returns query string like "empIds=0001&empIds=0002"

                if (!employeeQuery) {
                    Swal.fire({
                        title: 'Warning!',
                        text: 'Please select at least one employee.',
                        icon: 'warning',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                url = `${Delete_DayWiseUrl}/${startDate}/${endDate}?companyId=${CompanyID}&${employeeQuery}`
                ApiDeleteByUrl(url, token)
                    .then(function (response) {
                        Swal.fire({
                            title: 'Success!',
                            text: 'Weekend deleted successfully.',
                            icon: 'success',
                            confirmButtonText: 'OK'
                        }).then(() => {
                            GetEmployeeDayWise();
                        });
                    })
                    .catch(function (error) {
                        Swal.fire({
                            title: 'Error!',
                            text: 'An error occurred while deleting the module.',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    });

            }


            //Model Start 

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


        </script>

    <script src="../assets/theme_assets/js/loadCompany.js"></script>
    <script src="../assets/theme_assets/js/apiHelper.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
