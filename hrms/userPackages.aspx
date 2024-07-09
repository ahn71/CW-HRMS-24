<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="userPackages.aspx.cs" Inherits="SigmaERP.hrms.userPackages" %>
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
                           <h4>Add Packages</h4>
                        </div>
                     </div>
                  </div>

                  <div id="Cardbox" class="card-body pb-md-30">
                     <div class="Vertical-form">
                           <div class="row">
 
                               <div class="col-lg-3">
                                   <div class="form-group">
                                       <label for="txtModuleName" class="color-dark fs-14 fw-500 align-center mb-10">
                                           Packages Name <span class="text-danger">*</span>
                                       </label>
                                       <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtPackagesName" placeholder="Type Module Name">
                                       <span class="text-danger" id="moduleNameError"></span>
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
                                   <p>Test TreeView</p>
                                <div id="treeContainer"></div>
                               </div>
                               <div class="col-lg-12">
                                 <label style="opacity: 0;" for="formGroupExampleInput"
                                    class="color-dark fs-14 fw-500 align-center mb-10">Name <span
                                       class="text-danger"></span></label>
                                 <button type="button" id="btnSave" 
                                    class="btn btn-primary btn-default btn-squared px-30">Save</button>
                              </div>
                           </div>
             
                     </div>
                  </div>
               </div>
            </div>
<%--               <!-- Department List  -->
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

                               <table class="table mb-0 table-borderless adv-table" data-sorting="true" data-filtering="true" data-filter-container="#filter-form-container" data-paging="true" data-paging-size="10">
                               </table>
                           </div>
                        </div>

                     </div>
                  </div>
               </div>
            </div>--%>
            </div>
         </div>


   </main>

    <script>
        
        // Document ready function to start the process
        $(document).ready(function () {
            console.log('Document is ready, initializing GetModule');
            // GetModule(); // Call GetModule to fetch data and initialize tree view

            GetModule();
          
        });

        var rootUrl = 'http://localhost:5081';
        var GetByIdModuleUrl = rootUrl + '/api/UserModules/Packages';
        var GetPackagesUrl = rootUrl + '/api/UserModules/Packages';
        var PostModuleUrl = rootUrl + '/api/UserModules/modules/create';
        var updateModuleUrl = rootUrl + '/api/UserModules/modules/update';
        var DeleteModuleUrl = rootUrl + '/api/UserModules/modules/delete';

        var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

            function GetModule() {
        console.log('Calling GetModule');
        ApiCall(GetPackagesUrl, token)
            .then(function(response) {
                if (response.statusCode === 200) {
                    var responseData = response.data;
                    var treeData = transformToJSTreeFormat(responseData);
                    $('#treeContainer').jstree({
                        'core': {
                            'data': treeData,
                            'themes': {
                                'dots': true // Optional: Show dots
                            },
                            'multiple': true, // Enable multiple selection
                            'animation': true, // Optional: Enable animation
                            'check_callback': true, // Optional: Enable check callback
                        },
                        'checkbox': {
                            'keep_selected_style': false, // Optional: Remove style when unchecked
                            'tie_selection': true // Optional: Tie selection to checkbox
                        },
                        'plugins': ['checkbox', 'wholerow'] // Enable checkbox and wholerow plugins
                    }).on('changed.jstree', function(e, data) {
                        var selectedNodes = data.instance.get_selected(true);
                        console.log(selectedNodes); // Log selected nodes
                    });
                } else {
                    console.error('Error occurred while fetching data:', response.message);
                }
            })
            .catch(function(error) {
                console.error('Error occurred while fetching data:', error.message || error);
            });
    }

    function transformToJSTreeFormat(data) {
        return data.map(function(item) {
            let hasSelectedChild = item.children && item.children.some(child => child.state && child.state.selected);

            return {
                "text": item.name,
                "state": {
                    "opened": true,
                    "selected": hasSelectedChild // Select parent if any child is selected
                },
                "children": item.children && item.children.length > 0 ? transformToJSTreeFormat(item.children) : [], // Recursively transform children if present
                "li_attr": {
                    "id": item.id // Optional: Assign an ID to each node
                }
            };
        });
    }



         


    </script>



    <script src="assets/theme_assets/js/apiHelper.js"></script>
</asp:Content>
