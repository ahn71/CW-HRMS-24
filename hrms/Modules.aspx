<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="Modules.aspx.cs" Inherits="SigmaERP.hrms.Modules" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                           <h4>Add Modules</h4>
                        </div>
                     </div>

                     <div class="btn-wrapper">
                        <div class="dm-button-list d-flex flex-wrap align-items-end">

                           <button type="button" id="addnew" onclick="cardbox();" class="btn btn-secondary btn-default btn-squared">Add New
                           </button>
                        </div>
                     </div>
                  </div>

                  <div style="display: none;" id="cardbox" class="card-body pb-md-30">
                     <div class="Vertical-form">
  
                           <div class="row">
                              <div class="col-lg-3">
                                 <div class="form-group">
                                     <label for="formGroupExampleInput" class="color-dark fs-14 fw-500 align-center mb-10">Parent</label>
                                     <div class="support-form__input-id">
                                         <div class="dm-select ">
                                             <select name="ddlParent" class="select-search form-control ">
                                                 <option value="01">All</option>
                                                 <option value="02">Option 2</option>
                                                 <option value="03">Option 3</option>
                                                 <option value="04">Option 4</option>
                                                 <option value="05">Option 5</option>
                                             </select>
                                         </div>
                                     </div>
                                 </div>
                              </div>
                              <div class="col-lg-3">
                                 <div class="form-group">
                                    <label for="formGroupExampleInput"
                                       class="color-dark fs-14 fw-500 align-center mb-10">Module Name <span
                                          class="text-danger">*</span></label>
                                    <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15"
                                       id="txtModuleName" placeholder="Type Module Name ">
                                 </div>
                              </div>
                              <div class="col-lg-3">
                                 <div class="form-group">
                                    <label for="formGroupExampleInput"
                                       class="color-dark fs-14 fw-500 align-center mb-10">Module Url <span
                                          class="text-danger">*</span></label>
                                    <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15"
                                       id="txtModuleUrl" placeholder="Type Module Url">
                                 </div>
                              </div>
                              <div class="col-lg-3">
                                 <div class="form-group">
                                    <label for="formGroupExampleInput"
                                       class="color-dark fs-14 fw-500 align-center mb-10">Physical Location <span
                                          class="text-danger">*</span></label>
                                    <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15"
                                       id="txtPhysicalLocation" placeholder="Type PhysicalLocation">
                                 </div>
                              </div>
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="formGroupExampleInput"
                                           class="color-dark fs-14 fw-500 align-center mb-10">
                                            Icon Class <span
                                               class="text-danger">*</span></label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15"
                                           id="txtIconClass" placeholder="Type Icon Class">
                                   </div>
                               </div>   
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="formGroupExampleInput"
                                           class="color-dark fs-14 fw-500 align-center mb-10">
                                            Ordaring <span
                                               class="text-danger">*</span></label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15"
                                           id="txtOrdaring" placeholder="Type Ordaring">
                                   </div>
                               </div>
                               <div class="col-lg-3">
                                   <div class="form-group">        
                                       <div class="radio-horizontal-list d-flex mt-40">


                                           <div class="radio-theme-default custom-radio ">
                                               <input class="radio " checked  type="radio" name="radio-optional" value="0" id="radio-hl1">
                                               <label for="radio-hl1">
                                                   <span class="radio-text">Active</span>
                                               </label>
                                           </div>
                                           <div class="radio-theme-default custom-radio ">
                                               <input class="radio" type="radio" name="radio-optional" value="1" id="radio-hl2">
                                               <label for="radio-hl2">
                                                   <span class="radio-text">Deactive</span>
                                               </label>
                                           </div>

                                       </div>
                                   </div>
                               </div>
                               <div class="col-lg-3">
                                 <label style="opacity: 0;" for="formGroupExampleInput"
                                    class="color-dark fs-14 fw-500 align-center mb-10">Name <span
                                       class="text-danger"></span></label>
                                 <button type="button"
                                    class="btn btn-primary btn-default btn-squared px-30">Save</button>
                              </div>
                           </div>
             
                     </div>
                  </div>
               </div>
            </div>
               <!-- Department List  -->
               <div class="card card-Vertical card-default card-md mt-4 mb-4">
                  <div class="support-ticket-system support-ticket-system--search">

                     <div class="breadcrumb-main m-0 breadcrumb-main--table justify-content-sm-between ">
                        <div class=" d-flex flex-wrap justify-content-center breadcrumb-main__wrapper">
                           <div
                              class="d-flex align-items-center ticket__title justify-content-center me-md-25 mb-md-0 mb-20">
                              <h4 class="text-capitalize fw-500 breadcrumb-title">Module List</h4>
                           </div>
                        </div>
                        <div class="action-btn">
                           <a href="#" class="btn btn-primary">
                              Export
                              <i class="las la-angle-down"></i>
                           </a>
                        </div>
                     </div>

                     <div
                        class="support-form datatable-support-form d-flex justify-content-xxl-between justify-content-start align-items-center flex-wrap">
                        <div class="support-form__input">
                           <div class="d-flex flex-wrap">
                              <div class="support-form__input-id">
                                 <label>Id:</label>

                                 <div class="dm-select ">

                                    <select name="select-search" class="select-search form-control ">
                                       <option value="01">All</option>
                                       <option value="02">Option 2</option>
                                       <option value="03">Option 3</option>
                                       <option value="04">Option 4</option>
                                       <option value="05">Option 5</option>
                                    </select>

                                 </div>

                              </div>
                              <div class="support-form__input-status">
                                 <label>status:</label>

                                 <div class="dm-select ">

                                    <select name="select-search" class="select-search form-control ">
                                       <option value="01">All</option>
                                       <option value="02">Option 2</option>
                                       <option value="03">Option 3</option>
                                       <option value="04">Option 4</option>
                                       <option value="05">Option 5</option>
                                    </select>

                                 </div>

                              </div>
                              <button class="support-form__input-button">search</button>
                           </div>
                        </div>

                     </div>
                     <div class="userDatatable userDatatable--ticket userDatatable--ticket--2 mt-1">
                        <div class="table-responsive">
                           <table class="table mb-0 table-borderless">
                              <thead>
                                 <tr class="userDatatable-header">
                                    <th>
                                       <span class="userDatatable-title">ID</span>
                                    </th>
                                    <th>
                                       <span class="userDatatable-title">User</span>
                                    </th>
                                    <th>
                                       <span class="userDatatable-title">Country</span>
                                    </th>
                                    <th>
                                       <span class="userDatatable-title">Company</span>
                                    </th>
                                    <th>
                                       <span class="userDatatable-title">Position</span>
                                    </th>
                                    <th>
                                       <span class="userDatatable-title">Join Date</span>
                                    </th>
                                    <th>
                                       <span class="userDatatable-title">Status</span>
                                    </th>
                                    <th class="actions">
                                       <span class="userDatatable-title">Actions</span>
                                    </th>
                                 </tr>
                              </thead>
                              <tbody>

                                 <tr>
                                    <td>#01</td>
                                    <td>
                                       <div class="d-flex">
                                          <div class="userDatatable-inline-title">
                                             <a href="#" class="text-dark fw-500">
                                                <h6>Kellie Marquot</h6>
                                             </a>
                                          </div>
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content--subject">
                                          United Street
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content--subject">
                                          Business Development
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content--priority">
                                          Web Developer
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content--priority">
                                          January 20, 2020
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content d-inline-block">
                                          <span
                                             class="bg-opacity-success  color-success userDatatable-content-status active">active</span>
                                       </div>
                                    </td>
                                    <td>
                                       <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                          <li>
                                             <a href="#" class="view">
                                                <i class="uil uil-setting"></i>
                                             </a>
                                          </li>
                                          <li>
                                             <a href="#" class="edit">
                                                <i class="uil uil-edit"></i>
                                             </a>
                                          </li>
                                          <li>
                                             <a href="#" class="remove">
                                                <i class="uil uil-trash-alt"></i>
                                             </a>
                                          </li>
                                       </ul>
                                    </td>
                                 </tr>


                                 <tr>
                                    <td>#02</td>
                                    <td>
                                       <div class="d-flex">
                                          <div class="userDatatable-inline-title">
                                             <a href="#" class="text-dark fw-500">
                                                <h6>Robert Clinton</h6>
                                             </a>
                                          </div>
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content--subject">
                                          Japan
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content--subject">
                                          Vehicle Master
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content--priority">
                                          Senior Manager
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content--priority">
                                          January 20, 2020
                                       </div>
                                    </td>
                                    <td>
                                       <div class="userDatatable-content d-inline-block">
                                          <span
                                             class="bg-opacity-warning  color-warning userDatatable-content-status active">deactivated</span>
                                       </div>
                                    </td>
                                    <td>
                                       <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                          <li>
                                             <a href="#" class="view">
                                                <i class="uil uil-setting"></i>
                                             </a>
                                          </li>
                                          <li>
                                             <a href="#" class="edit">
                                                <i class="uil uil-edit"></i>
                                             </a>
                                          </li>
                                          <li>
                                             <a href="#" class="remove">
                                                <i class="uil uil-trash-alt"></i>
                                             </a>
                                          </li>
                                       </ul>
                                    </td>
                                 </tr>

                              </tbody>
                           </table>
                        </div>
                        <div class="d-flex justify-content-end pt-30">

                           <nav class="dm-page ">
                              <ul class="dm-pagination d-flex">
                                 <li class="dm-pagination__item">
                                    <a href="#" class="dm-pagination__link pagination-control"><span
                                          class="la la-angle-left"></span></a>
                                    <a href="#" class="dm-pagination__link"><span class="page-number">1</span></a>
                                    <a href="#" class="dm-pagination__link active"><span
                                          class="page-number">2</span></a>
                                    <a href="#" class="dm-pagination__link"><span class="page-number">3</span></a>
                                    <a href="#" class="dm-pagination__link pagination-control"><span
                                          class="page-number">...</span></a>
                                    <a href="#" class="dm-pagination__link"><span class="page-number">12</span></a>
                                    <a href="#" class="dm-pagination__link pagination-control"><span
                                          class="la la-angle-right"></span></a>
                                    <a href="#" class="dm-pagination__option">
                                    </a>
                                 </li>
                                 <li class="dm-pagination__item">
                                    <div class="paging-option">
                                       <select name="page-number" class="page-selection">
                                          <option value="20">20/page</option>
                                          <option value="40">40/page</option>
                                          <option value="60">60/page</option>
                                       </select>
                                    </div>
                                 </li>
                              </ul>
                           </nav>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
        </div>


   </main>   
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        function cardbox() {
            $("#cardbox").toggle();
            var currentText = $("#addnew").text();
            var newText = currentText === "Close" ? "Add New" : "Close";
            $("#addnew").text(newText);
        }

    </script>
</asp:Content>
