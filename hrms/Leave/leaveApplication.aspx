<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="leaveApplication.aspx.cs" Inherits="SigmaERP.hrms.Leave.leaveApplication" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>


        .calendar-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            cursor: pointer;
            width:20px;
            height:20px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <main class="main-content">
      <div class="Dashbord">
         <div class="crm mb-25">
            <div class="container-fulid">
               <div class="card card-Vertical card-default card-md mt-4 mb-4">

                  <div class="card-header d-flex align-items-center">
                     <div class="card-title d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center gap-3">
                           <h4>Leave Application</h4>
                        </div>

                     </div>

                     <div class="btn-wrapper">
                        <div class="dm-button-list d-flex flex-wrap align-items-end">
                        <button type="button" id="addnew" onclick="Cardbox();" class="btn btn-secondary btn-default btn-squared">Add New</button>                          
                        </div>
                     </div>
                  </div>
                   
                  <div style="display: none;" id="Cardbox" class="card-body pb-md-30">
                     <div class="Vertical-form">
                           <div class="row">
                               <div class="col-lg-12">
                                   <div class="row">
                                       <div class="col-lg-3 col-md-6 col-sm-12" ">
                                           <div class="form-group">
                                               <label id="lblHidenUserId" style="display: none"></label>
                                               <label for="ddlCompany" class="color-dark fs-14 fw-500 align-center mb-10">Company</label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                        <asp:DropDownList runat="server" ID="ddlCompany" ClientIDMode="Static" class="select-search form-control"></asp:DropDownList>

                                                   </div>
                                                   <span class="text-danger" id="ddlcompanyError"></span>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="ddlEmpName" class="color-dark fs-14 fw-500 align-center mb-10">Employee</label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                       <select name="ddlEmpName" id="ddlEmpName" class="select-search form-control">
                                                           <option value="0">---Select---</option>
                                                       </select>
                                                   </div>
                                                   <span class="text-danger" id="EmpNameError"></span>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="ddlLeaveName" class="color-dark fs-14 fw-500 align-center mb-10">Leave Name</label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                       <select name="ddlLeaveName" id="ddlLeaveName" class="select-search form-control">
                                                           <option value="0">---Select---</option>
                                                       </select>
                                                   </div>
                                                   <span class="text-danger" id="LeaveNameError"></span>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3  col-md-6 col-sm-12 col-sm-6">
                                           <div class="form-group position-relative">
                                               <label for="txtFromDate" class="color-dark fs-14 fw-500 align-center mb-10">
                                                  Leave Start Date
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" id="datepicker" placeholder="Start Date">
                                               <img class="svg calendar-icon" src="/hrms/img/svg/calendar.svg" alt="calendar">
                                           </div>
                                       </div>
                                       <div class="col-lg-3  col-md-6 col-sm-12 col-sm-6">
                                           <div class="form-group position-relative">
                                               <label for="txtFromDate" class="color-dark fs-14 fw-500 align-center mb-10">
                                                 Leave End Date
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-light radius-xs b-light px-15" id="datepicker2" placeholder="End Date">
                                               <img class="svg calendar-icon" src="/hrms/img/svg/calendar.svg" alt="calendar">
                                           </div>
                                       </div>


                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label for="ddlChargeHandOverTo" class="color-dark fs-14 fw-500 align-center mb-10">Charge hand Over To<span class="text-danger">*</span></label>
                                               <div class="support-form__input-id">
                                                   <div class="dm-select ">
                                                       <select name="ddlChargeHandOverTo" id="ddlChargeHandOverTo" class="select-search form-control">
                                                           <option value="0">---Select---</option>
                                                       </select>
                                                   </div>
                                                   <span class="text-danger" id="ChargeHandOverToError"></span>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">

                                               <label for="txtContact" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Phone Number
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtContact" placeholder="Phone Number">
                                               <span class="text-danger" id="ContactError"></span>
                                           </div>
                                       </div>
                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group">

                                               <label for="txtLeaveAddress" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Leave Address
                                               </label>
                                               <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtLeaveAddress" placeholder="Type First Name" pattern="[^\d]*" title="Numbers are not allowed">
                                           </div>
                                       </div>

                                       <div class="col-lg-3 col-md-6 col-sm-12">
                                           <div class="form-group form-element-textarea mb-20">
                                               <label for="txtPurposeOfLv" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Purpose Of Leave
                                                </label>
                                               <textarea class="form-control" id="txtPurposeOfLv" rows="3"></textarea>
                                           </div>
                                       </div>
                                       <div class="col-lg-6 col-md-6 col-sm-12">
                                           <div class="form-group form-element-textarea mb-20">
                                               <label for="txtLeaveAddress" class="color-dark fs-14 fw-500 align-center mb-10">Attach Document(if any)</label>
                                                  <div class="dm-tag-wrap">
                                                       <div class="dm-upload">
                                                           <div class="dm-upload__button">
                                                               <a href="javascript:void(0)" class="btn btn-lg btn-outline-lighten btn-upload" onclick="$('#upload-1').click()">
                                                                   <img class="svg" src="/hrms/img/svg/upload.svg" alt="upload">
                                                                   Click to Upload</a>
                                                               <input type="file" name="upload-1" class="upload-one" id="upload-1">
                                                           </div>
                                                           <div class="dm-upload__file">
                                                               <ul>
                                                               </ul>
                                                           </div>
                                                       </div>

                                                   </div>
                                           </div>
                                           
                                               
                                                
                                              
                                       
                                       </div>

                                       <div class="col-lg-3  col-md-6 col-sm-12">
                                           <div class="form-group">
                                               <label style="opacity: 0;" for="formGroupExampleInput"
                                                   class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Name <span
                                                       class="text-danger"></span>
                                               </label>
                                               <button type="button" id="btnSave" onclick="validateUser()"
                                                   class="btn btn-primary btn-default btn-squared px-30">Save</button>
                                           </div>
                                       </div>


                                   </div>

                               </div>

    

             
                     </div>
                  </div>
               </div>
            </div>
               <!-- Department List  -->
                        <div class="row">
               <div class="col-lg-12">
                  <div class="card ">
                     <div class="card-body">

                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                           <div class="table-responsive">
                              <div class="ad-table-table__header d-flex justify-content-between">
                                  <h4 style="margin-top: 13px;"></h4>
                              <div id="filter-form-container">
                              </div>
                              </div>

                               <div class="loader-size loaderModulesList " style="display: none">
                                   <div class="dm-spin-dots  dot-size dot-sizedot-sizedot-sizedot-size spin-sm">
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                       <span class="spin-dot badge-dot dot-primary"></span>
                                   </div>
                               </div>

                               <table class="table mb-0 table-borderless adv-table" data-sorting="true" data-filtering="true" data-filter-container="#filter-form-container" data-paging="true" data-paging-size="10">
                               </table>
                           </div>
                        </div>

                     </div>
                  </div>
               </div>
            </div>
            </div>
         </div>


   </main>

    <script>
        function BoxExpland() {
            var scrollTop = $(window).scrollTop();

            $("#Cardbox").show();
            $("#addnew").text("Close");
            $("#IsGuest").show();
            $(window).scrollTop(scrollTop);
        }

         function Cardbox() {
             var CardboxElement = $("#Cardbox");
             var addnewElement = $("#addnew");

             if (addnewElement.html() === "Add New") {
                 CardboxElement.show();
                  $("#IsGuest").show();
                 addnewElement.text("Close");
             } else {
                 ClearTextBox();
                 CardboxElement.hide();
                 addnewElement.html("Add New");
                   $("#IsGuest").hide();
             }
              var writeAction = '<%= Session["__WriteAction__"] %>';

                if (writeAction == "0") {
                    $("#btnSave").hide(); 
                } else {
                    $("#btnSave").show(); 
                }
         }

    </script>
 
</asp:Content>
