<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="userPermissions.aspx.cs" Inherits="SigmaERP.hrms.userPermissions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">  <main class="main-content">
      <div class="Dashbord">
         <div class="crm mb-25">
            <div class="container-fulid">
               <div class="card card-Vertical card-default card-md mt-4 mb-4">

                  <div class="card-header d-flex align-items-center">
                     <div class="card-title d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center gap-3">
                           <h4>Add User Permissions</h4>
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
                                       <label for="formGroupExampleInput" class="color-dark fs-14 fw-500 align-center mb-10">Modules <span
                                          class="text-danger">*</span></label>
                                       <div class="support-form__input-id">
                                           <div class="dm-select ">
                                               <select name="ddlModules" class="select-search form-control ">
                                                   <option value="02">Salary</option>
                                                   <option value="03">Attendance</option>
                                                   <option value="04">Employee</option>
                                                   <option value="05">Provident Found</option>
                                               </select>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                              <div class="col-lg-3">
                                 <div class="form-group">
                                    <label for="formGroupExampleInput"
                                       class="color-dark fs-14 fw-500 align-center mb-10">Permission Name <span
                                          class="text-danger">*</span></label>
                                    <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15"
                                       id="txtPermissionName" placeholder="Type Permission Name ">
                                 </div>
                              </div>
                              <div class="col-lg-3">
                                 <div class="form-group">
                                    <label for="formGroupExampleInput"
                                       class="color-dark fs-14 fw-500 align-center mb-10">Permission Url<span
                                          class="text-danger">*</span></label>
                                    <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15"
                                       id="txtPermissionsUrl" placeholder="Type permission Url">
                                 </div>
                              </div>
                              <div class="col-lg-3">
                                 <div class="form-group">
                                    <label for="formGroupExampleInput"
                                       class="color-dark fs-14 fw-500 align-center mb-10">Physical Location <span
                                          class="text-danger">*</span></label>
                                    <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15"
                                       id="txtPerPhysicalLocation" placeholder="Type PhysicalLocation">
                                 </div>
                              </div>
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="formGroupExampleInput"
                                           class="color-dark fs-14 fw-500 align-center mb-10">
                                            Ordaring <span
                                               class="text-danger">*</span></label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15"
                                           id="txtPerOrdaring" placeholder="Type Ordaring">
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
                        <div class="row">
               <div class="col-lg-12 mb-30">
                  <div class="card mt-30">
                     <div class="card-body">

                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 adv-table">
                           <div class="table-responsive">
                              <div class="adv-table-table__header">
                                 <h4>Permission List</h4>
                                 <div class="adv-table-table__button">
                                    <div class="dropdown">
                                       <a class="btn btn-primary dropdown-toggle dm-select" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                          Export
                                       </a>

                                       <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                          <a class="dropdown-item" href="#">copy</a>
                                          <a class="dropdown-item" href="#">csv</a>
                                          <a class="dropdown-item" href="#">print</a>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <div id="filter-form-container"></div>
                              <table class="table mb-0 table-borderless adv-table" data-sorting="true" data-filter-container="#filter-form-container" data-paging-current="1" data-paging-position="right" data-paging-size="10">
                                 <thead>
                                    <tr class="userDatatable-header">
                                       <th>
                                          <span class="userDatatable-title">id</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">user</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">emaill</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">company</span>
                                       </th>
                                       <th data-type="html" data-name='position'>
                                          <span class="userDatatable-title">position</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">join date</span>
                                       </th>
                                       <th data-type="html" data-name='status'>
                                          <span class="userDatatable-title">status</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title float-end">action</span>
                                       </th>
                                    </tr>
                                 </thead>
                                 <tbody>

                                    <tr>
                                       <td>
                                          <div class="userDatatable-content">01</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Kellie Marquot </h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             john-keller@gmail.com
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Web Developer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 20, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">02</div>
                                       </td>
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
                                          <div class="userDatatable-content">
                                             Japan
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Vehicle Master
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Senior Manager
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 25, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-warning  color-warning rounded-pill userDatatable-content-status active">deactivate</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">03</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Chris Joe</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             South Korea
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Smart Collection
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             UX/UI Designer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             June 20, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-danger  color-danger rounded-pill userDatatable-content-status active">blocked</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">04</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Jack Kalis</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             South Africa
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Content writer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             July 30, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">05</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Black Smith</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             United Kingdom
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Print Media
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Graphic Designer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             August 20, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">06</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Aftab Ahmed</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Bangladesh
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Online Super Shop
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Marketer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 15, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">07</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Daniel White</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Australia
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Project Manager
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 20, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">08</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Chris john</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Japan
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Boss IT Farm
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Web Developer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             February 20, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">09</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>David Manal</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Russia
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             UI Designer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             March 20, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">10</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Kapil Deb</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             India
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Manager
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             March 31, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">11</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Kellie Marquot </h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             john-keller@gmail.com
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Web Developer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 20, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">12</div>
                                       </td>
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
                                          <div class="userDatatable-content">
                                             Japan
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Vehicle Master
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Senior Manager
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 25, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-warning  color-warning rounded-pill userDatatable-content-status active">deactivate</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">13</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Chris Joe</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             South Korea
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Smart Collection
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             UX/UI Designer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             June 20, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-danger  color-danger rounded-pill userDatatable-content-status active">blocked</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">14</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Jack Kalis</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             South Africa
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Content writer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             July 30, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">15</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Black Smith</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             United Kingdom
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Print Media
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Graphic Designer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             August 20, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">16</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Aftab Ahmed</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Bangladesh
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Online Super Shop
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Marketer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 15, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">17</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Daniel White</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Australia
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Project Manager
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 20, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">18</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Chris john</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Japan
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Boss IT Farm
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Web Developer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             February 20, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">19</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>David Manal</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Russia
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             UI Designer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             March 20, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">20</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Kapil Deb</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             India
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Manager
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             March 31, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">21</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Kellie Marquot </h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             john-keller@gmail.com
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Web Developer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 20, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">12</div>
                                       </td>
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
                                          <div class="userDatatable-content">
                                             Japan
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Vehicle Master
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Senior Manager
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 25, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-warning  color-warning rounded-pill userDatatable-content-status active">deactivate</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">23</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Chris Joe</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             South Korea
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Smart Collection
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             UX/UI Designer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             June 20, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-danger  color-danger rounded-pill userDatatable-content-status active">blocked</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">24</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Jack Kalis</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             South Africa
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Content writer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             July 30, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">25</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Black Smith</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             United Kingdom
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Print Media
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Graphic Designer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             August 20, 2020
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">26</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Aftab Ahmed</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Bangladesh
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Online Super Shop
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Marketer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 15, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">27</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Daniel White</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Australia
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Project Manager
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             January 20, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">28</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Chris john</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Japan
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Boss IT Farm
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Web Developer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             February 20, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">29</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>David Manal</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Russia
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             UI Designer
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             March 20, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
                                       <td>
                                          <div class="userDatatable-content">30</div>
                                       </td>
                                       <td>
                                          <div class="d-flex">
                                             <div class="userDatatable-inline-title">
                                                <a href="#" class="text-dark fw-500">
                                                   <h6>Kapil Deb</h6>
                                                </a>
                                             </div>
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             India
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Business Development
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             Manager
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content">
                                             March 31, 2021
                                          </div>
                                       </td>
                                       <td>
                                          <div class="userDatatable-content d-inline-block">
                                             <span class="bg-opacity-success  color-success rounded-pill userDatatable-content-status active">active</span>
                                          </div>
                                       </td>
                                       <td>
                                          <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                                             <li>
                                                <a href="#" class="view">
                                                   <i class="uil uil-eye"></i>
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
