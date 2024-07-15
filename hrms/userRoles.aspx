<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="userRoles.aspx.cs" Inherits="SigmaERP.hrms.userRoles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="main-content">
        <div class="Dashbord">
            <div class="crm mb-25">
                <div class="container-fulid">
                    <div class="card card-Vertical card-default card-md mt-4 mb-4">

                        <div id="Cardbox" class="card-body pb-md-30">
                            <div class="Vertical-form">
                                <div class="row">

                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label for="txtRole" class="color-dark fs-14 fw-500 align-center mb-10">
                                                Role Name <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtRole" placeholder="Type Ordering">
                                            <span class="text-danger" id="errortxtRole"></span>
                                        </div>
                                    </div>

                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label for="txtOrdaring" class="color-dark fs-14 fw-500 align-center mb-10">
                                                Ordering <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtOrdaring" placeholder="Type Ordering">
                                            <span class="text-danger" id="orderingError"></span>
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
                                    <div class="col-lg-12">
                                        <p>Select permission</p>
                                        <div class="loader-size loaderPackages " style="display:none">
                                            <div class="dm-spin-dots  dot-size dot-sizedot-sizedot-sizedot-size spin-sm">
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                                <span class="spin-dot badge-dot dot-primary"></span>
                                            </div>
                                        </div>
                                        <div id="treeContainer"></div>
                                    </div>
                                    <div class="col-lg-12">
                                        <label style="opacity: 0;" for="formGroupExampleInput"
                                            class="color-dark fs-14 fw-500 align-center mb-10">
                                            Name <span
                                                class="text-danger"></span>
                                        </label>
                                        <button type="button" id="btnSave" onclick="ValidateAndPostModule()"
                                            class="btn btn-primary btn-default btn-squared px-30">Save</button>
                                    </div>
                                </div>



                            </div>
                        </div>
                    </div>
                </div>

                    <div class="row">
               <div class="col-lg-12">
                  <div class="card ">
                     <div class="card-body">

                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                           <div class="table-responsive">
                              <div class="ad-table-table__header d-flex justify-content-between">
                                  <h4 style="margin-top: 13px;">Setup Packages List</h4>
                              <div id="filter-form-container">

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


    </main>

    <script>
        var rootUrl = 'http://localhost:5081';
        var GetFeturesPackagesUrl = rootUrl + '/api/UserPackagesSetup/packagesSetup';
         var GetFeturesUrl = rootUrl + '/api/UserModules/Packages';
        var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        $(document).ready(function () {
           
            FetchFeatursData();
        });



         var responseData = null;


      var selectedPermissionIDs = [];
var selectedPermissionIDsUpdate = [];
var selectedPermissionIDs = [];
var selectedPermissionIDsUpdate = [];

function FetchFeatursData() {
    ApiCall(GetFeturesPackagesUrl, token)
        .then(function (response) {
            console.log('Data:', response);
            $('#loaderPackages').show();
            var data = response.data;
            console.log('data from packages setup', data);

            // Check if data.features is defined and is a valid JSON string
            if (data && data.features) {
                try {
                    selectedPermissionIDs = JSON.parse(data.features);
                } catch (e) {
                    console.error('Error parsing JSON:', e);
                    $('#loaderPackages').hide();
                    return;
                }
            } else {
                console.error('data.features is undefined or not a valid JSON string:', data.features);
                $('#loaderPackages').hide();
                return;
            }

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
                        console.log("id.toString()", id.toString());
                        data.instance.select_node(id.toString());
                    });
                }).on('changed.jstree', function (e, data) {
                    selectedPermissionIDsUpdate = [];

                    for (var i = 0, j = data.selected.length; i < j; i++) {
                        var node = data.instance.get_node(data.selected[i]);
                        if (node && node.children.length === 0) {
                            selectedPermissionIDsUpdate.push(parseInt(node.id, 10));
                        }
                        console.log('node:', node);
                    }
                    console.log('petch Child Node IDs:', selectedPermissionIDsUpdate);
                });
                $('#loaderPackages').hide();
            } else {
                console.error('selectedPermissionIDs is not an array:', selectedPermissionIDs);
                $('#loaderPackages').hide();
            }
        })
        .catch(function (error) {
            console.error('Error:', error);
            $('#loaderPackages').hide();
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

    </script>


   <script src="assets/theme_assets/js/apiHelper.js"></script>

</asp:Content>
