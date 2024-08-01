<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="SigmaERP.hrms.user" %>
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
                           <h4>Add User</h4>
                        </div>

                     </div>
                      <div class="col-lg-3">
                          <div class="form-group d-flex">
                              <label for="chkIsGetUser" class="color-dark fs-14 fw-500 align-center">
                                  Guest User <span class="text-danger"></span>
                              </label>
                              <div class="radio-horizontal-list d-flex">
                                  <div class="form-check form-switch form-switch-primary form-switch-sm mx-3">
                                      <input type="checkbox" class="form-check-input" onchange="toggleReferenceEmp()" id="chkIsGetUser">
                                      <label class="form-check-label" for="chkIsGetUser"></label>
                                  </div>
                              </div>
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
                               <div class="col-lg-3" id="ddlReference">
                                   <div class="form-group">
                                       <label id="lblHidenUserId" style="display: none"></label>
                                       <label for="ddlReferenceEmp" class="color-dark fs-14 fw-500 align-center mb-10">Employee</label>
                                       <div class="support-form__input-id">
                                           <div class="dm-select ">
                                               <select name="ddlReferenceEmp" id="ddlReferenceEmp" class="select-search form-control">
                                                   <option value="0">---Select---</option>
                                               </select>
                                           </div>
                                             <span class="text-danger" id="repEmpError"></span>
                                       </div>
                                   </div>
                               </div>
                               
                                 <div id="FirstName" style="display:none" class="col-lg-3">
                                   <div class="form-group">

                                       <label for="txtFirstName" class="color-dark fs-14 fw-500 align-center mb-10">
                                           First Name
                                       </label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtFirstName" placeholder="Type First Name" pattern="[^\d]*" title="Numbers are not allowed" >
                                       <span class="text-danger" id="firstNameError"></span>
                                   </div>
                               </div>
                               <div id="LastName" style="display:none" class="col-lg-3">
                                   <div class="form-group">
                                       <label for="txtLastName" class="color-dark fs-14 fw-500 align-center mb-10">
                                           Last Name
                                       </label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtLastName" placeholder="Type Last name">
                                       <span class="text-danger" id="lastNameError"></span>
                                   </div>
                               </div>
                            
                  
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="txtUserName" class="color-dark fs-14 fw-500 align-center mb-10">
                                           User Name <span class="text-danger">*</span>
                                       </label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtUserName" placeholder="Type User Name">
                                       <span class="text-danger" id="userNameError"></span>
                                   </div>
                               </div>
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="txtUserPassword" class="color-dark fs-14 fw-500 align-center mb-10">
                                           Password <span class="text-danger">*</span>
                                       </label>
                                       <input type="password" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtUserPassword" placeholder="Type User Password">
                                       <span class="text-danger" id="userPasswordError"></span>
                                   </div>
                               </div>
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="txtUserEmail" class="color-dark fs-14 fw-500 align-center mb-10">
                                           User Email <span class="text-danger">*</span>
                                       </label>
                                       <input type="email" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtUserEmail" placeholder="Type User Email">
                                       <span class="text-danger" id="userEmailError"></span>
                                   </div>
                               </div>
                              <div class="col-lg-3">
                                 <div class="form-group">
                                     <label for="ddlUserRole" class="color-dark fs-14 fw-500 align-center mb-10">User Role<span class="text-danger">*</span></label>
                                     <div class="support-form__input-id">
                                         <div class="dm-select ">
                                             <select name="ddlUserRole" id="ddlUserRole" class="select-search form-control">
                                                 <option value="0">---Select---</option>
                                             </select>
                                         </div>
                                           <span class="text-danger" id="roleError"></span>
                                     </div>
                                 </div>
                              </div>
                              

                               <div class="col-lg-3">
                                   <input style="opacity: 0" type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="">
                                   <div class="form-group d-flex">
                                       <label for="chkIsActive" class="color-dark fs-14 fw-500 align-center">
                                           Status <span class="text-danger"></span>
                                       </label>
                                       <div class="radio-horizontal-list d-flex">
                                           <div class="form-check form-switch form-switch-primary form-switch-sm mx-3">
                                               <input type="checkbox" checked class="form-check-input" id="chkIsActive">
                                               <label class="form-check-label" for="chkIsActive"></label>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                               <div class="col-lg-3">
                                   <p>Select Aditional Permissions</p>
                                   <div class="loader-size loaderPackages " style="display: none">
                                       <div class="dm-spin-dots  dot-size dot-sizedot-sizedot-sizedot-size spin-sm">
                                           <span class="spin-dot badge-dot dot-primary"></span>
                                           <span class="spin-dot badge-dot dot-primary"></span>
                                           <span class="spin-dot badge-dot dot-primary"></span>
                                           <span class="spin-dot badge-dot dot-primary"></span>
                                       </div>
                                   </div>
                                   <div id="treeContainer"></div>
                               </div>

                               <div class="col-lg-3">
                                 <label style="opacity: 0;" for="formGroupExampleInput"
                                    class="color-dark fs-14 fw-500 align-center mb-10">Name <span
                                       class="text-danger"></span></label>
                                 <button type="button" id="btnSave" onclick="validateAndPostModule()"
                                    class="btn btn-primary btn-default btn-squared px-30">Save</button>
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
                                  <h4 style="margin-top: 13px;">Module List</h4>
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
         var rootUrl = 'https://localhost:7220';
         var getUsersUrl = rootUrl + '/api/User/users';
         var getRolesUrl = rootUrl + '/api/UserRoles/userRoles';
         var getEmployeeUrl = rootUrl + '/api/Employee/EmployeeName';
         var GetFeturesUrl = rootUrl + '/api/UserModules/Packages';
         var getRolesByIdUrl = rootUrl + '/api/UserRoles/userRoles';
         var createUserUrl = rootUrl + '/api/User/users/create';
         var getStpPkgFeaturesWithParentUrl = rootUrl + '/api/UserPackagesSetup/SetupedPackagesWithParent';

         var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

         $(document).ready(function () {
             IsGuestUser();
             GetRoles();
             GetEmployee();
             GetUsers();
             GetStpPkgFeatures();
             GetRolesFeatures();
             //$('#chkIsGetUser').change(function () {
             //    toggleReferenceEmp();
             //});


         });
         function toggleReferenceEmp() {
             if ($('#chkIsGetUser').is(':checked')) {
                 $('#ddlReference').hide("");
                 $('#repEmpError').html("");
                 $('#userEmailError').html("");
                 $('#userPasswordError').html("");
                 $('#userNameError').html("");
                  $('#roleError').html("");
             } else {
                 $('#ddlReference').show();
                 $('#userEmailError').html("");
                 $('#roleError').html("");
                 $('#userPasswordError').html("");
                 $('#userNameError').html("");
                
             }
         }
         
         function validateAndPostModule() {
             var isValid = true;
             let alphabeticPattern = /^[a-zA-Z]+$/;
             let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
             if ($('#chkIsGetUser').is(':checked')) {
                 $('#ddlReference').hide();
                 $('#repEmpError').html("");
             } else {
                 $('#ddlReference').show();
                 let selectedReferenceEmp = $('#ddlReferenceEmp').val();
                 if (selectedReferenceEmp == "0") {
                     $('#repEmpError').html("Please select a valid reference employee.");
                     $("#ddlReferenceEmp").focus();
                 } else {
                     $('#repEmpError').html("");
                 }
             }
             let firstName = $('#txtFirstName').val().trim();
             if (firstName !== "" && !alphabeticPattern.test(firstName)) {
                 $('#firstNameError').html("Only alphabetic characters are allowed.");
                 $("#txtFirstName").focus();
                 isValid = false;
             } else {
                 $('#firstNameError').html("");
             }
             let LastName = $('#txtLastName').val().trim();
             if (LastName !== "" && !alphabeticPattern.test(LastName)) {
                 $('#lastNameError').html("Only alphabetic characters are allowed.");
                 $("#txtLastName").focus();
                 isValid = false;
             } else {
                 $('#lastNameError').html("");
             }
             if ($('#txtUserName').val().trim() === "") {
                 $('#userNameError').html("User Name is required.");
                 $("#txtUserName").focus();
                 isValid = false;
             } else {
                 $('#userNameError').html("");
             }
             if ($('#txtUserPassword').val().trim() === "") {
                 $('#userPasswordError').html("Password is required.");
                 $("#userPasswordError").focus();
                 isValid = false;
             } else {
                 $('#userNameError').html("");
             }

             let userEmail = $('#txtUserEmail').val().trim();
             if (userEmail === "") {
                 $('#userEmailError').html("Email is required.");
                 $("#txtUserEmail").focus();
                 isValid = false;
             } else if (!emailPattern.test(userEmail)) {
                 $('#userEmailError').html("Please enter a valid email address.");
                 $("#txtUserEmail").focus();
                 isValid = false;
             } else {
                 $('#userEmailError').html("");
             }
             let selectedRole = $('#ddlUserRole').val();
             if (selectedRole == "0") {
                 $('#roleError').html("Please select role.");
                 $("#ddlUserRole").focus();
                 isValid = false;
             } else {
                 $('#roleError').html("");
             }
             if (isValid) {
                 var addnewElement = $("#btnSave");
                 if (addnewElement.html() === "Save") {
                     PostStpPkgFeatures();
                     //ClearTextBox();
                 }
                 else {
                     updateModule();
                     ClearTextBox();
                 }
             }
         }




         function IsGuestUser () {
                $('#chkIsGetUser').change(function() {
                if ($(this).is(':checked')) {
                    $('#FirstName, #LastName').show();
                } else {
                    $('#FirstName, #LastName').hide();
                }
            });
         }

         function GetRolesFeatures() {
             $('#ddlUserRole').change(function () {
                 var selectedValue = $(this).val();
                 console.log("Selected value: " + selectedValue);
                 FetchDataRolesWise(selectedValue);

             });
         }

         function GetRoles() {
             ApiCall(getRolesUrl, token)
                 .then(function (response) {
                     if (response.statusCode === 200) {
                         var responseData = response.data;
                         RolesPopulateDropdown(responseData)
                     } else {
                         console.error('Error occurred while fetching data:', response.message);
                     }
                 })
                 .catch(function (error) {
                     $('.loaderCosting').hide();
                     console.error('Error occurred while fetching data:', error);
                 });
         }
         function RolesPopulateDropdown(data) {
             const dropdown = document.getElementById('ddlUserRole');
             dropdown.innerHTML = '<option value="0">---Select---</option>'; // Clear existing options

             data.forEach(item => {
                 const option = document.createElement('option');
                 option.value = item.userRoleId;
                 option.textContent = item.userRoleName;
                 dropdown.appendChild(option);
             });
         }
         function GetEmployee() {
             ApiCall(getEmployeeUrl, token)
                 .then(function (response) {
                     if (response.statusCode === 200) {
                         var responseData = response.data;
                         EmployeePopulateDropdown(responseData)
                     } else {
                         console.error('Error occurred while fetching data:', response.message);
                     }
                 })
                 .catch(function (error) {
                     $('.loaderCosting').hide();
                     console.error('Error occurred while fetching data:', error);
                 });
         }
         function EmployeePopulateDropdown(data) {
             const dropdown = document.getElementById('ddlReferenceEmp');
             dropdown.innerHTML = '<option value="0">---Select---</option>'; // Clear existing options

             data.forEach(item => {
                 const option = document.createElement('option');
                 option.value = item.empId;
                 option.textContent = item.fullName;
                 dropdown.appendChild(option);
             });
         }


         function GetUsers() {
             ApiCall(getUsersUrl, token)
                 .then(function (response) {
                     if (response.statusCode === 200) {
                         var responseData = response.data;
                         console.log(responseData);
                         $('.footable-loader').show();
                         bindTableData(responseData);
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

             data.forEach(row => {
                 row.userName = `
        <div class="permission-name-container">
            ${row.userName}
            <div class="actions-container">
                <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                    <li><a href="javascript:void(0)" class="view-btn view" data-id="${row.userId}"><i class="uil uil-eye"></i></a></li>
                    <li><a href="javascript:void(0)" data-id="${row.userId}" class="edit-btn edit"><i class="uil uil-edit"></i></a></li>
                    <li><a href="javascript:void(0)" data-id="${row.userId}" class="delete-btn remove"><i class="uil uil-trash-alt"></i></a></li>
                </ul>
            </div>
        </div>
        `;

                 row.isActive = `
        <div class="form-check form-switch form-switch-primary form-switch-sm">
            <input type="checkbox" class="form-check-input" id="switch-${row.userId}" ${row.isActive ? 'checked' : ''}>
            <label class="form-check-label" for="switch-${row.userId}"></label>
        </div>
        `;

                 row.permissions = `
        <div class="features-icon-container">
            <a href="javascript:void(0)" class="feature-btn" data-id="${row.userId}"><i class="uil uil-star"></i></a>
        </div>
        `;
             });

             const columns = [
                 { "name": "userId", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
                 { "name": "firstName", "title": "First Name", "className": "userDatatable-content" },
                 { "name": "lastName", "title": "Last Name", "className": "userDatatable-content" },
                 { "name": "userName", "title": "User Name", "className": "userDatatable-content" },
                 { "name": "userPassword", "title": "Password", "className": "userDatatable-content" },
                 { "name": "email", "title": "Email", "className": "userDatatable-content" },
                 { "name": "isGuestUser", "title": "Is Guest User", "sortable": false, "filterable": false, "className": "userDatatable-content" },
                 { "name": "referenceID", "title": "Refer By", "className": "userDatatable-content" },
                 { "name": "additionalPermissions", "title": "Additional Permissions", "className": "userDatatable-content" },
                 { "name": "removedPermissions", "title": "Remove Permission", "className": "userDatatable-content" },
                 { "name": "isActive", "title": "Is Active", "sortable": false, "filterable": false, "className": "userDatatable-content" },
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

             // Clear and re-attach event listeners
             $('.adv-table').off('click', '.edit-btn').on('click', '.edit-btn', function () {
                 const userId = $(this).data('id');
                 FetchDataForEdit(userId);
                 console.log('Edit button clicked for ID:', userId);
             });

             $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                 const id = $(this).data('id');
                 Delete(id);
                 console.log('Delete button clicked for ID:', id);
             });

             $('.adv-table').off('click', '.view-btn').on('click', '.view-btn', function () {
                 const id = $(this).data('id');
                 // Handle the view action
                 console.log('View button clicked for ID:', id);
             });

             $('.adv-table').off('click', '.feature-btn').on('click', '.feature-btn', function () {
                 const id = $(this).data('id');
                 console.log('Feature button clicked for ID:', id);
                 //FetchDataForEdit(id);
             });
         }
         var selectedPermissionIDs = [];
         var responseData = null;
         function GetStpPkgFeatures() {
             console.log('Calling GetModule');
             $('.loaderPackages').show();
             ApiCall(getStpPkgFeaturesWithParentUrl, token)
                 .then(function (response) {
                     if (response.statusCode === 200) {
                         responseData = response.data;
                         var treeData = transformToJSTreeFormat(responseData);
                         console.log("TreeData :", treeData)
                         $('#treeContainer').jstree({
                             'core': {
                                 'data': treeData,
                                 'themes': {
                                     'dots': true
                                 },
                                 'multiple': true,
                                 'animation': true,
                                 'check_callback': true
                             },
                             'checkbox': {
                                 'keep_selected_style': false,
                                 'tie_selection': true
                             },
                             'plugins': ['checkbox', 'wholerow']
                         }).on('changed.jstree', function (e, data) {
                             selectedPermissionIDs = [];
                             for (i = 0, j = data.selected.length; i < j; i++) {

                                 var node = data.instance.get_node(data.selected[i]);
                                 if (node && node.children.length === 0) {
                                     selectedPermissionIDs.push(parseInt(node.id, 10));
                                 }
                                 console.log('node:', node);
                             }
                             console.log('Child Node IDs:', selectedPermissionIDs);

                         });
                         $('.loaderPackages').hide();
                     } else {
                         console.error('Error occurred while fetching data:', response.message);
                     }
                 })
                 .catch(function (error) {
                     console.error('Error occurred while fetching data:', error.message || error);
                 });
         }

         function transformToJSTreeFormat(data) {
             return data.map(function (item) {
                 let hasSelectedChild = item.children && item.children.some(child => child.state && child.state.selected);

                 return {
                     "id": item.isPermission ? item.permissionId : item.moduleID,
                     "text": item.name,
                     "state": {
                         "opened": true,
                         "selected": hasSelectedChild
                     },
                     "children": item.children && item.children.length > 0 ? transformToJSTreeFormat(item.children) : [],
                     "li_attr": {
                         "id": item.isPermission ? item.permissionId : item.moduleID
                     },
                     "original": {
                         "isPermission": item.isPermission
                     }
                 };
             });
         }

         var selectedPermissionIDsUpdate = []
         var selectedPermissionIDs = []

         function FetchDataRolesWise(moduleID) {
             ApiCallById(getRolesByIdUrl, token, moduleID)
                 .then(function (response) {
                     console.log('Data:', response);
                     var data = response.data;
                     $('#lblHidenRolesId').val(data.userRoleId);
                     //BoxExpland();

                     selectedPermissionIDs = JSON.parse(data.permissions);
                     console.log('additionalPermissions:',additionalPermissions);
                     console.log('removedPermissions:', removedPermissions);

                     if (removedPermissions.length > 0 || additionalPermissions.length > 0) {
                         selectedPermissionIDs = selectedPermissionIDs.filter(id => !removedPermissions.includes(id));

                         additionalPermissions.forEach(id => {
                             if (!selectedPermissionIDs.includes(id)) {
                                 selectedPermissionIDs.push(id);
                             }
                         });

                         console.log('After update - selectedPermissionIDs:', selectedPermissionIDs);
                     } else {
                         console.log('only roles data :.',selectedPermissionIDs);
                     }




                     console.log('Roles data:',selectedPermissionIDs);
                     if (Array.isArray(selectedPermissionIDs)) {
                         var treeData = transformToJSTreeFormats(responseData);
                         $('#treeContainer').jstree("destroy").empty();
                         $('#treeContainer').jstree({
                             'core': {
                                 'data': treeData,
                                 'themes': {
                                     'dots': true
                                 },
                                 'multiple': true,
                                 'animation': true,
                                 'check_callback': true
                             },
                             'checkbox': {
                                 'keep_selected_style': false,
                                 'tie_selection': true
                             },
                             'plugins': ['checkbox', 'wholerow']
                         }).on('ready.jstree', function (e, data) {
                             selectedPermissionIDs.forEach(function (id) {
                                 console.log("id.toString()", id.toString())
                                 data.instance.select_node(id.toString());
                             });
                         }).on('changed.jstree', function (e, data) {
                             selectedPermissionIDsUpdate = [];

                             for (i = 0, j = data.selected.length; i < j; i++) {

                                 var node = data.instance.get_node(data.selected[i]);
                                 if (node && node.children.length === 0) {
                                     selectedPermissionIDsUpdate.push(parseInt(node.id, 10));
                                 }
                                 //console.log('node:', node);
                             }
                             console.log('roles Data and Additional Data :', selectedPermissionIDsUpdate)
                         });
                     } else {
                         console.error('responseData.features is not an array:', responseData.features);
                     }
                 })
                 .catch(function (error) {
                     console.error('Error:', error);
                 });
         }
         function transformToJSTreeFormats(data) {
             return data.map(function (item) {

                 return {
                     "id": item.isPermission ? item.permissionId : item.moduleID,
                     "text": item.name,
                     "state": {
                         "opened": true
                     },
                     "children": item.children && item.children.length > 0 ? transformToJSTreeFormat(item.children) : [],
                     "li_attr": {
                         "id": item.isPermission ? item.permissionId : item.moduleID
                     },
                     "original": {
                         "isPermission": item.isPermission
                     }
                 };
             });
         }

         function findDifferences(array1, array2) {
             return array1.filter(item => !array2.includes(item));
         }
         function PostStpPkgFeatures() {
             var refaranceEmp = $('#ddlReferenceEmp').val();
             var firstName = $('#txtFirstName').val();
             var lastName = $('#txtLastName').val();
             var userName = $('#txtUserName').val();
             var userPassword = $('#txtUserPassword').val();
             var userEmail = $('#txtUserEmail').val();
             var userRole = parseInt($('#ddlUserRole').val());
             var isActive = $('#chkIsActive').is(':checked');
             var isGuest = $('#chkIsGetUser').is(':checked');
             var treeInstance = $('#treeContainer').jstree(true);

             var jsonRolesData = JSON.stringify(selectedPermissionIDs);
             var jsonUpdateData = JSON.stringify(selectedPermissionIDsUpdate);

             var rolesDataArray = JSON.parse(jsonRolesData);
             var updateDataArray = JSON.parse(jsonUpdateData);
             var removedItems = findDifferences(rolesDataArray, updateDataArray);
             var addedItems = findDifferences(updateDataArray, rolesDataArray);



             if (removedItems.length > 0 || addedItems.length > 0) {
                 rolesDataArray = rolesDataArray.filter(item => !removedItems.includes(item));
             }

             var additionalPermissions = addedItems.length > 0 ? JSON.stringify(addedItems) : "";
             var removedPermissions = removedItems.length > 0 ? JSON.stringify(removedItems) : "";

             var postData = {
                 FirstName: firstName,
                 LastName: lastName,
                 UserName: userName,
                 UserPassword: userPassword,
                 Email: userEmail,
                 UserRoleID: userRole,
                 IsGuestUser: isGuest,
                 ReferenceID: refaranceEmp,
                 AdditionalPermissions: additionalPermissions,
                 RemovedPermissions: removedPermissions,
                 IsActive: isActive,
             };

             ApiCallPost(createUserUrl, token, postData)
                 .then(function (response) {
                     console.log('Data saved successfully:', response);
                     Swal.fire({
                         icon: 'success',
                         title: 'Success',
                         text: 'Data saved successfully!'
                     }).then((result) => {
                         if (result.isConfirmed) {
                             //GetModule();
                             //GetRoles();
                             //GetPackages();
                         }
                     });
                 })
                 .catch(function (error) {
                     console.error('Error saving data:', error);
                     Swal.fire({
                         icon: 'error',
                         title: 'Error',
                         text: 'Failed to save data. Please try again.'
                     });
                 });
         }

         var additionalPermissions;
         var removedPermissions;

         function FetchDataForEdit(moduleId) {
             ApiCallById(getUsersUrl, token, moduleId)
                 .then(function (responseData) {
                     var data = responseData.data;
                     console.log(data.moduleId);
                     $('#lblHidenUserId').val(data.userId);
                     $('select[name="ddlReferenceEmp"]').val(data.referenceID).change();
                     $('#txtFirstName').val(data.firstName);
                     $('#txtLastName').val(data.lastName);
                     $('#txtUserName').val(data.userName);
                     $('#txtUserPassword').val(data.userPassword);
                     $('#txtUserEmail').val(data.email);
                     $('select[name="ddlUserRole"]').val(data.userRoleID).change();
                     $('#chkIsActive').prop('checked', data.isGuestUser);
                     $('#chkIsGetUser').prop('checked', data.isActive);
                     var GuestUser = data.isGuestUser;

                     

                     additionalPermissions = JSON.parse(data.additionalPermissions);
                     removedPermissions = JSON.parse(data.removedPermissions);
                     console.log(additionalPermissions);
                     console.log(removedPermissions);



                     if (GuestUser == true) {
                         $('#chkIsGetUser').prop('checked', true);
                         $('#FirstName, #LastName').show();
                         $('#ddlReference').hide();
                     } else {
                         $('#chkIsGetUser').prop('checked', false);
                         $('#FirstName, #LastName').hide();
                         $('#ddlReference').show();
                     }


                     console.log(GuestUser);
                     
                     $('#btnSave').html('Update');

                     BoxExpland()
                     //Cardbox()
                 })
                 .catch(function (error) {
                     console.error('Error:', error);
                 });

         }





        function BoxExpland() {
            var scrollTop = $(window).scrollTop();

            $("#Cardbox").show();
            $("#addnew").text("Close");
            $(window).scrollTop(scrollTop);
        }

         function Cardbox() {
             var CardboxElement = $("#Cardbox");
             var addnewElement = $("#addnew");

             if (addnewElement.html() === "Add New") {
                 CardboxElement.show();
                 addnewElement.text("Close");
             } else {
                 ClearTextBox();
                 CardboxElement.hide();
                 addnewElement.html("Add New");

             }
         }


     </script>
<%--    <script src="assets/theme_assets/js/TreeViewHepler.js"></script>--%>
    <script src="assets/theme_assets/js/apiHelper.js"></script>

</asp:Content>
