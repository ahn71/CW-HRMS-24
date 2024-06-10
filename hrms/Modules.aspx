<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="modules.aspx.cs" Inherits="SigmaERP.hrms.Modules" %>
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
                        <div class="row">
               <div class="col-lg-12 mb-30">
                  <div class="card mt-30">
                     <div class="card-body">

                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                           <div class="table-responsive">
                              <div class="adv-table-table__header">
                                 <h4>Module List</h4>

                              </div>
                              <div id="filter-form-container"></div>
                              <table class="table mb-0 table-borderless adv-table" data-sorting="true" data-filter-container="#filter-form-container" data-paging-current="1" data-paging-position="right" data-paging-size="10">
                                 <thead>
                                    <tr class="userDatatable-header">
                                       <th>
                                          <span class="userDatatable-title">ID</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">Parent</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">Module Name</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">Module Url</span>
                                       </th>
                                       <th data-type="html" data-name='position'>
                                          <span class="userDatatable-title">Physical Location</span>
                                       </th>
                                       <th>
                                          <span class="userDatatable-title">Icon Class</span>
                                       </th>
                                        <th>
                                            <span class="userDatatable-title">Ordaring
                                            </span>
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

                                     <!---Data Bind From Api---->

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
<script>
    var rootUrl = 'https://localhost:7220';
      var GetModuleUrl = rootUrl + '/api/UserModules/modules';
    var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';



    function GetModule() {
        ApiCall(GetModuleUrl, token)
            .then(function (response) {
                if (response.statusCode === 200) {
                    var responseData = response.data;
                    console.log(responseData);
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
    var tableBody = $('.adv-table tbody');
    tableBody.empty(); // Clear any existing rows

        data.forEach(function (item) {
         var switchButton = `
            <div class="form-check form-switch form-switch-primary form-switch-sm">
                <input type="checkbox" class="form-check-input" id="switch-${item.moduleID}" ${item.isActive ? 'checked' : ''}>
                <label class="form-check-label" for="switch-${item.moduleID}"></label>
            </div>`;

        var row = `<tr>
            <td><div class="userDatatable-content">${item.moduleID}</div></td>
            <td><div class="userDatatable-content">${item.parentID}</div></td>
            <td><div class="userDatatable-content">${item.moduleName}</div></td>
            <td><div class="userDatatable-content">${item.url}</div></td>
            <td><div class="userDatatable-content">${item.physicalLocation}</div></td>
            <td><div class="userDatatable-content">${item.iconClass}</div></td>
            <td><div class="userDatatable-content">${item.ordering}</div></td>
            <td><div class="userDatatable-content">${switchButton}</div></td>

            <td>
                <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                    <li><a href="#" class="view"><i class="uil uil-eye"></i></a></li>
                    <li><a href="#" class="edit"><i class="uil uil-edit"></i></a></li>
                    <li><a href="#" class="remove"><i class="uil uil-trash-alt"></i></a></li>
                </ul>
            </td>
        </tr>`;

        tableBody.append(row);
    });
}




    function cardbox() {
        $("#cardbox").toggle();
        var currentText = $("#addnew").text();
        var newText = currentText === "Close" ? "Add New" : "Close";
        $("#addnew").text(newText);
    }




    $(document).ready(function () {
        GetModule();

    });


    function ApiCall(url, token) {
        return new Promise(function (resolve, reject) {
            $.ajax({
                url: url,
                type: 'GET',
                dataType: 'json',
                headers: {
                    'Authorization': 'Bearer ' + token  // Corrected header field
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
