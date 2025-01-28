<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="shiftSetup.aspx.cs" Inherits="SigmaERP.hrms.settings.shiftSetup" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        td{
            text-align:left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate><p class="message"  id="lblMessage" clientidmode="Static" runat="server"></p></ContentTemplate>
</asp:UpdatePanel>
        <main class="main-content">
        <div class="Dashbord">
            <div class="crm mb-25">
                <div class="container-fulid">
                    <div class="card card-Vertical card-default card-md mt-4 mb-4">
                        <div class="card-header d-flex align-items-center">
                            <div class="card-title d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <h4>Add Shift</h4>
                                </div>
                            </div>

                            <div class="btn-wrapper">
                                <div class="dm-button-list d-flex flex-wrap align-items-end">
                                    <button type="button" id="addnew" onclick="Cardbox();" class="btn btn-secondary btn-default btn-squared">Add New</button>
                                </div>
                            </div>
                        </div>
                        <div <%--style="display: none;"--%> id="Cardbox" class="card-body pb-md-30">
                            <div class="Vertical-form">
                                    
                                    <div class="row">

                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label id="lblHiddenShiftId" style="display: none"></label>

                                                <label for="txtShiftName" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Shift Name <span class="text-danger">*</span>
                                                </label>
                                                <input type="text" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtShiftName" placeholder="Type Shift Name">
                                                <span class="text-danger" id="txtGradeNameError"></span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="txtShiftBangla" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    বাংলায় 
                                                </label>


                                                <asp:TextBox ID="txtShiftBangla" ClientIDMode="Static" runat="server" CssClass="form-control ih-medium ip-gray radius-xs b-light px-15" Font-Names="SutonnyMJ" placeholder="বাংলায়"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="ddlDepartment" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Department</label>
                                                <div class="support-form__input-id">
                                                    <div class="dm-select ">
                                                        <asp:DropDownList runat="server" ID="ddlDepartment" ClientIDMode="Static" class="select-search form-control"></asp:DropDownList>

                                                    </div>
                                                    <span class="text-danger" id="ddlDepartmentError"></span>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="time-picker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    IN Time<span class="text-danger">*</span>
                                                </label>

                                                        <div class="input-container icon-right position-relative">
                                                            <input type="time" class="form-control form-control-lg" id="txtInTime" >
                                                      <span class="text-danger" id="INTimeError"></span>

                                                        </div>
                                                    
                                                
                                            </div>
                                        </div>      
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="time-picker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Starting IN<span class="text-danger">*</span>
                                                </label>
                                                        <div class="input-container icon-right position-relative">
                                                            <input type="time" id="txtStartingIn" class="form-control form-control-lg" placeholder="Select time">
                                                         <span class="text-danger" id="StartingINError"></span>

                                                        </div>
                                                    
                                                
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="time-picker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                   Ending IN<span class="text-danger">*</span>
                                                </label>
                                                        <div class="input-container icon-right position-relative">
                                                            <input type="time" class="form-control form-control-lg" id="txtEndingIn" placeholder="Select time">
                                                            <span class="text-danger" id="EndingINError"></span>
                                                        </div>
                                                    
                                                
                                            </div>
                                        </div>

                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="time-picker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                     OUT Time<span class="text-danger">*</span>
                                                </label>
                                                <div class="input-container icon-right position-relative">

                                                    <input type="time" class="form-control form-control-lg" id="txtOutTime" placeholder="Select time">
                                                    <span class="text-danger" id="OUTTimerror"></span>
                                                </div>
                                            </div>
                                        </div>                                
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="time-picker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Starting OUT<span class="text-danger">*</span>
                                                </label>
                                                <div class="input-container icon-right position-relative">
                                                    <input type="time" class="form-control form-control-lg" id="txtStartingOut" placeholder="Select time">
                                                    <span class="text-danger" id="StartingOUTError"></span>
                                                </div>
                                            </div>
                                        </div>         
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label for="time-picker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Ending OUT<span class="text-danger">*</span>
                                                </label>
                                                <div class="input-container icon-right position-relative">
                                                    <input type="time"class="form-control form-control-lg" id="txtEndingOut" placeholder="Select time">
                                                    <span class="text-danger" id="EndingOUTError"></span>
                                                </div>


                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">

                                                <label for="time-picker" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Acceptable late (MM)<span class="text-danger">*</span>
                                                </label>
                                                <div class="input-container icon-right position-relative">
                                                    <span class="input-icon icon-right">
                                                        <%--                            <img class="svg" src="img/svg/clock.svg" alt="clock">--%>
                                                        <span class="uil uil-clock-eight"></span>

                                                    </span>
                                                    <input type="number" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtAccepLateTime" placeholder="MM">
                                                     <span class="text-danger" id="AccepLateTimeError"></span>

                                                </div>

                                            </div>
                                        </div>
                                          <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group">
                                                
                                                    <label for="txtAccepEarlyOut" class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Acceptable Early Out (MM)<span class="text-danger">*</span>
                                                </label>
                                                        <div class="input-container icon-right position-relative">
                                                            <span class="input-icon icon-right">
                                    <%--                            <img class="svg" src="img/svg/clock.svg" alt="clock">--%>
                                                                <span class="uil uil-clock-eight"></span>

                                                            </span>
                                                              <input type="number" class="form-control ih-medium ip-gray radius-xs b-light px-15" id="txtAccepEarlyOut" placeholder="MM">
                                                               <span class="text-danger" id="AccepEarlyOutError"></span>

                                                        </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="form-group form-element-textarea mb-20">
                                                <label for="txtPurposeOfLv" class="color-dark fs-14 fw-500 align-center mb-10">
                                                  Notes
                                                </label>
                                                <textarea class="form-control PurposeOfLv" placeholder="Type Notes" id="txtNotes" rows="1" style="height:48px"></textarea>
                                            </div>
                                        </div>

                                        <div class="col-lg-8 col-md-6 col-sm-12 " style="display: flex; justify-content: space-between">
                                            <div class="LeftSite" style="display:flex">
                                                <div class="form-group d-flex align-items-center">
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
                                                     <div class="form-group d-flex align-items-center">
                                                    <label for="chkIsActive" class="color-dark fs-14 fw-500 align-center">
                                                        Over Time <span class="text-danger"></span>
                                                    </label>
                                                    <div class="radio-horizontal-list d-flex">
                                                        <div class="form-check form-switch form-switch-primary form-switch-sm mx-3">
                                                            <input type="checkbox" checked class="form-check-input" id="chkIsOverTime">
                                                            <label class="form-check-label" for="chkIsActive"></label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group d-flex align-items-center">
                                                    <label for="chkIsActive" class="color-dark fs-14 fw-500 align-center">
                                                       Is Night <span class="text-danger"></span>
                                                    </label>
                                                    <div class="radio-horizontal-list d-flex">
                                                        <div class="form-check form-switch form-switch-primary form-switch-sm mx-3">
                                                            <input type="checkbox" class="form-check-input" id="chkIsNight">
                                                            <label class="form-check-label" for="chkIsActive"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="rightSite">
                                                <label style="opacity: 0;" for="formGroupExampleInput"
                                                    class="color-dark fs-14 fw-500 align-center mb-10">
                                                    Name <span
                                                        class="text-danger"></span>
                                                </label>
                                                 <button type="button" id="btnSave" onclick="ValidateAndPost()"
                                                   class="btn btn-primary btn-default btn-squared px-30">Save</button>
                                            </div>

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
                                  <h4 style="margin-top: 13px;">Grades</h4>
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
        //var rootUrl = 'http://localhost:5081';

        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var postUrl = rootUrl + '/api/Shift/Shift/create';
        var getShiftByIdUrl = rootUrl + '/api/Shift/Shift';
        var getAllUrl = rootUrl + `/api/Shift/Shift?CompanyId=${CompanyID}`;
        var updateShiftUrl = rootUrl + '/api/Shift/Shift/update';
        var DeleteUrl = rootUrl + '/api/Shift/Shift/delete';
        var GetDepartmentNameURL = rootUrl + `/api/Department/basicInfo/${CompanyID}`;

        var token = '<%= Session["__UserToken__"] %>';
        console.log('this is token you can use it :', token);
        //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJpYXQiOjE3MTQ2MjQ5MjYsImV4cCI6MTc0NjE2MDkyNiwiYXVkIjoiIiwic3ViIjoiSldUU2VydmljZUFjY2Vzc1Rva2VuIn0.tVlIuOLas2VxEnBohuaIXXQR2Lju_2h8yVjCDizQh9o';

        $(document).ready(function () {
           
        
            //GetCompanys();
            GetDepartment(CompanyID);
            GetAllShift();
            
        });

        //function getCompanypackage(compayId) {
        //    var companyId = compayId;
        //     GetStpPkgFeatures(companyId);
        //}

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

            async function ValidateAndPost() {
                var isValid = true;

                // Validate Shift Name
                if ($('#txtShiftName').val().trim() === "") {
                    $('#txtGradeNameError').html("Please enter the Shift Name.");
                    $('#txtShiftName').focus();
                    isValid = false;
                } else {
                    $('#txtGradeNameError').html("");
                }


                // Validate IN Time
                if ($('#txtInTime').val() === "") {
                    $('#INTimeError').html("Please enter IN Time.");
                    $('#txtInTime').focus();
                    isValid = false;
                } else {
                    $('#INTimeError').html("");
                }

                // Validate Starting IN
                if ($('#txtStartingIn').val() === "") {
                    $('#StartingINError').html("Please enter Starting IN.");
                    $('#txtStartingIn').focus();
                    isValid = false;
                } else {
                    $('#StartingINError').html("");
                }

                // Validate Ending IN
                if ($('#txtEndingIn').val() === "") {
                    $('#EndingINError').html("Please enter Ending IN.");
                    $('#txtEndingIn').focus();
                    isValid = false;
                } else {
                    $('#EndingINError').html("");
                }

                // Validate OUT Time
                if ($('#txtOutTime').val() === "") {
                    $('#OUTTimerror').html("Please enter OUT Time.");
                    $('#txtOutTime').focus();
                    isValid = false;
                } else {
                    $('#OUTTimerror').html("");
                }

                // Validate Starting OUT
                if ($('#txtStartingOut').val() === "") {
                    $('#StartingOUTError').html("Please enter Starting OUT.");
                    $('#txtStartingOut').focus();
                    isValid = false;
                } else {
                    $('#StartingOUTError').html("");
                }

                // Validate Ending OUT
                if ($('#txtEndingOut').val() === "") {
                    $('#EndingOUTError').html("Please enter Ending OUT.");
                    $('#txtEndingOut').focus();
                    isValid = false;
                } else {
                    $('#EndingOUTError').html("");
                }

                // Validate Acceptable Late Time
                if ($('#txtAccepLateTime').val() === "") {
                    $('#AccepLateTimeError').html("Please enter acceptable late time.");
                    $('#txtAccepLateTime').focus();
                    isValid = false;
                } else {
                    $('#AccepLateTimeError').html("");
                }

                // Validate Acceptable Early OUT
                if ($('#txtAccepEarlyOut').val() === "") {
                    $('#AccepEarlyOutError').html("Please enter acceptable early OUT.");
                    $('#txtAccepEarlyOut').focus();
                    isValid = false;
                } else {
                    $('#AccepEarlyOutError').html("");
                }

                // If all fields are valid, save the module
                if (isValid) {
                var addnewElement = $("#btnSave").text().trim();  // Get the button text

                 // If adding new user
                    if (addnewElement === "Save") {
                        try {
                            var result = await PostShift(true);  // Wait for PostUsers to finish

                            if (result === true) {  // Check if PostUsers returned true
                                //ClearTextBox();  // Clear the form fields
                            }
                        } catch (error) {
                            console.error("An error occurred:", error);  // Handle any errors
                        }
                    }
                                    // If updating existing user
                 else {

                     try {
                         var result = await  UpdateShift(true);  // Wait for PostUsers to finish

                         if (result === true) {  // Check if PostUsers returned true
                             //ClearTextBox();  // Clear the form fields
                         }
                     } catch (error) {
                         console.error("An error occurred:", error);  // Handle any errors
                     } ; 
                 }
                }
            }


        function ClearTextBox() {
            $('#txtRole').val("");
            $('#txtOrdaring').val("");
            $('#chkIsActive').prop('checked', true);
            $('#btnSave').text("Save");
        }

            function GetDepartment(companyId) {
                ApiCall(GetDepartmentNameURL , token)
                    .then(function (response) {
                        if (response.statusCode === 200) {
                            var responseData = response.data;
                            PopulateDropdown(responseData)
                        } else {
                            console.error('Error occurred while fetching data:', response.message);
                            const dropdown = document.getElementById('ddlDepartment');
                            dropdown.innerHTML = '<option value="0">---Select---</option>';
                        }
                    })
                    .catch(function (error) {
                        $('.loaderCosting').hide();
                        console.error('Error occurred while fetching data:', error);
                        const dropdown = document.getElementById('ddlDepartment');
                        dropdown.innerHTML = '<option value="0">---Select---</option>'; 
                        console.error('Error occurred while fetching data:', error);

                    });
            }
            function PopulateDropdown(data) {
                const dropdown = document.getElementById('ddlDepartment');
                dropdown.innerHTML = '<option value="0">ALL</option>'; 

                data.forEach(item => {
                    const option = document.createElement('option');
                    option.value = item.dptId;
                    option.textContent = item.dptName;
                    dropdown.appendChild(option);
                });
            }




            function PostShift(IsSave) {
                var CompanyId = CompanyID;
                var ShiftName = $('#txtShiftName').val();
                var ShiftNameBangla = $('#txtShiftBangla').val();
                var Department = $('#ddlDepartment').val();
                var Notes = $('#txtNotes').val();

                // Get time values and ensure they are in the correct format (HH:mm:ss)
                var InTime = $('#txtInTime').val() + ':00';
                var StartingIN = $('#txtStartingIn').val() + ':00';
                var EndingIN = $('#txtEndingIn').val() + ':00';
                var OutTime = $('#txtOutTime').val() + ':00';
                var StartingOUT = $('#txtStartingOut').val() + ':00';
                var EndingOUT = $('#txtEndingOut').val() + ':00';

                var AccepLateTime = parseInt($('#txtAccepLateTime').val()) || 0;
                var AccepEarlyOut = parseInt($('#txtAccepEarlyOut').val()) || 0;

                var isActive = $('#chkIsActive').is(':checked');
                var isNight = $('#chkIsNight').is(':checked');
                var isOverTime = $('#chkIsOverTime').is(':checked');

                // Prepare the data object
                var postData = {
                    sftName: ShiftName,
                    sftStartTime: InTime,
                    startingIN: StartingIN,
                    endingIN: EndingIN,
                    sftEndTime: OutTime,
                    startingOUT: StartingOUT,
                    endingOUT: EndingOUT,
                    sftAcceptableLate: AccepLateTime,
                    sftAcceptableEarlyOut: AccepEarlyOut,
                    sftOverTime: isOverTime,
                    isActive: isActive,
                    notes: Notes,
                    companyId: CompanyId,
                    dptId: Department,
                    sftNameBangla: ShiftNameBangla,
                    isNight: isNight
                };

                // Call the API
                ApiCallPost(postUrl, token, postData)
                    .then(function (response) {
                        console.log('Data saved successfully:', response);
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: 'Data saved successfully!'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                GetAllShift();
                                return true;
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

                        return false;
                    });
            }

            function UpdateShift(IsUpdate) {
                // Retrieve necessary values from the UI
                var ShiftId = $('#lblHiddenShiftId').val(); // Hidden field holding the Shift ID
                var CompanyId = CompanyID;
                var ShiftName = $('#txtShiftName').val();
                var ShiftNameBangla = $('#txtShiftBangla').val();
                var Department = $('#ddlDepartment').val();
                var Notes = $('#txtNotes').val();

                // Get time values and ensure they are in the correct format (HH:mm:ss)
                var InTime = $('#txtInTime').val() + ':00';
                var StartingIN = $('#txtStartingIn').val() + ':00';
                var EndingIN = $('#txtEndingIn').val() + ':00';
                var OutTime = $('#txtOutTime').val() + ':00';
                var StartingOUT = $('#txtStartingOut').val() + ':00';
                var EndingOUT = $('#txtEndingOut').val() + ':00';

                // Parse numeric values
                var AccepLateTime = parseInt($('#txtAccepLateTime').val()) || 0;
                var AccepEarlyOut = parseInt($('#txtAccepEarlyOut').val()) || 0;

                // Get boolean values from checkboxes
                var isActive = $('#chkIsActive').is(':checked');
                var isNight = $('#chkIsNight').is(':checked');
                var isOverTime = $('#chkIsOverTime').is(':checked');

                // Prepare the data object for the update operation
                var updateData = {
                    sftName: ShiftName,
                    sftStartTime: InTime,
                    startingIN: StartingIN,
                    endingIN: EndingIN,
                    sftEndTime: OutTime,
                    startingOUT: StartingOUT,
                    endingOUT: EndingOUT,
                    sftAcceptableLate: AccepLateTime,
                    sftAcceptableEarlyOut: AccepEarlyOut,
                    sftOverTime: isOverTime,
                    isActive: isActive,
                    notes: Notes,
                    companyId: CompanyId,
                    dptId: Department,
                    sftNameBangla: ShiftNameBangla,
                    isNight: isNight
                };

                // Call the API for updating the shift data
                ApiCallUpdate(updateShiftUrl, token, updateData, ShiftId)
                    .then(function (response) {
                        console.log('Data updated successfully:', response);
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: 'Shift data updated successfully!'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                GetAllShift(); // Refresh the shift list after update
                                return true;
                            }
                        });
                    })
                    .catch(function (error) {
                        console.error('Error updating shift data:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Failed to update shift data. Please try again.'
                        });
                        return false;
                    });
            }

        function Delete(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "Do you really want to delete this Grade?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    ApiDeleteById(DeleteUrl, token, id)
                        .then(function (response) {
                            Swal.fire({
                                title: 'Success!',
                                text: 'Grade deleted successfully.',
                                icon: 'success',
                                confirmButtonText: 'OK'
                            }).then(() => {
                                GetAllShift();
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
            });
        }





        function GetAllShift() {
            ApiCall(getAllUrl, token)
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

            // Step 1: Destroy any existing Footable instance to avoid conflicts when reinitializing
            if ($('.adv-table').data('footable')) {
                $('.adv-table').data('footable').destroy();
            }

            // Step 2: Clear the HTML content of the table and filter container
            $('.adv-table').html('');
            $('#filter-form-container').empty();

            // Step 3: Loop through the data array and modify the rows for display
            data.forEach((row, index) => {
                // Assign a serial number based on the loop index
                row.serialNo = index + 1;

                // Create the HTML for userRoleName column including actions (View, Edit, Delete)
                row.action = `
            <div class="actions">
                <ul class="orderDatatable_actions mb-0 d-flex flex-wrap">
                    <li>
                        <a href="javascript:void(0)" data-id="${row.sftId}" class="delete-btn view">
                            <i class="uil uil-eye"></i>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:void(0)" data-id="${row.sftId}" class="edit-btn edit">
                            <i class="uil uil-edit"></i>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:void(0)" data-id="${row.sftId}" class="delete-btn remove">
                            <i class="uil uil-trash-alt"></i>
                        </a>
                    </li>
                </ul>
            </div>`;

                // Create the HTML for isActive column with a toggle switch
                row.isActive = `
            <div class="form-check form-switch form-switch-primary form-switch-sm">
                <input 
                    type="checkbox" 
                    class="form-check-input" 
                    id="switch-${row.sftId}" 
                    ${row.isActive ? 'checked' : ''}>
                <label 
                    class="form-check-label" 
                    for="switch-${row.sftId}">
                </label>
            </div>`;
            });

            // Step 5: Define the columns for the table, including custom rendering logic for some columns
            const columns = [
                { "name": "serialNo", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
                { "name": "sftName", "title": "Shift Name", "className": "userDatatable-content" },
                { "name": "sftStartTime", "title": "IN Time", "className": "userDatatable-content" },
                { "name": "startingIN", "title": "Starting IN", "className": "userDatatable-content" },
                { "name": "endingIN", "title": "Ending IN", "className": "userDatatable-content" },
                { "name": "sftEndTime", "title": "OUT Time", "className": "userDatatable-content" },
                { "name": "startingOUT", "title": "Starting OUT", "className": "userDatatable-content" },
                { "name": "endingOUT", "title": "Ending OUT", "className": "userDatatable-content" },
                { "name": "isActive", "title": "Status", "sortable": false, "filterable": false, "className": "userDatatable-content" },
                { "name": "action", "title": "Action", "sortable": false, "filterable": false, "className": "userDatatable-content" },
            ];

            // Step 6: Initialize Footable with the columns and data, enable filtering
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
                }).on('postinit.ft.table', function () {
                    // Hide loader after table initialization
                    $('.footable-loader').hide();
                });
            } catch (error) {
                console.error("Error initializing Footable:", error);
            }

            // Step 7: Attach event listeners for actions (Edit, Delete, View, Feature)

            // Clear and re-attach the edit button click event
            $('.adv-table').off('click', '.edit-btn').on('click', '.edit-btn', function () {
                const userRoleId = $(this).data('id');
                console.log('Edit button clicked for userRoleId:', userRoleId);
                 FetchDataForEdit(userRoleId); // Custom function to handle edit logic
            });

            // Clear and re-attach the delete button click event
            $('.adv-table').off('click', '.delete-btn').on('click', '.delete-btn', function () {
                const userRoleId = $(this).data('id');
                console.log('Delete button clicked for userRoleId:', userRoleId);
                Delete(userRoleId); 
            });

            // Clear and re-attach the feature button click event
            $('.adv-table').off('click', '.feature-btn').on('click', '.feature-btn', function () {
                const userRoleId = $(this).data('id');
                console.log('Feature button clicked for userRoleId:', userRoleId);
                // Add logic for feature handling
            });
        }

 
        


       

        function BoxExpland() {
            var scrollTop = $(window).scrollTop();

            $("#Cardbox").show();
            $("#addnew").text("Close");
            $(window).scrollTop(scrollTop);
        }

            function FetchDataForEdit(shiftID) {
                // Call the API with the Shift ID
                ApiCallById(getShiftByIdUrl, token, shiftID)
                    .then(function (response) {
                        console.log('Data fetched for edit:', response);

                        // Extract data from the response
                        var data = response.data;

                        // Populate the fields with fetched data
                        $('#lblHiddenShiftId').val(data.sftId); // Hidden field for Shift ID
                        $('#ddlCompany').val(data.companyId).change(); // Set company dropdown value
                        $('#txtShiftName').val(data.sftName); // Set shift name
                        $('#txtShiftBangla').val(data.sftNameBangla); // Set shift name in Bangla
                        $('#ddlDepartment').val(data.dptId).change(); // Set department dropdown
                        $('#txtNotes').val(data.notes); 

                        // Populate time fields
                        $('#txtInTime').val(data.sftStartTime.substring(0, 5)); // Time without seconds
                        $('#txtStartingIn').val(data.startingIN.substring(0, 5));
                        $('#txtEndingIn').val(data.endingIN.substring(0, 5));
                        $('#txtOutTime').val(data.sftEndTime.substring(0, 5));
                        $('#txtStartingOut').val(data.startingOUT.substring(0, 5));
                        $('#txtEndingOut').val(data.endingOUT.substring(0, 5));

                        // Populate numeric fields
                        $('#txtAccepLateTime').val(data.sftAcceptableLate || 0); // Acceptable late time
                        $('#txtAccepEarlyOut').val(data.sftAcceptableEarlyOut || 0); // Acceptable early out time

                        // Set checkboxes
                        $('#chkIsActive').prop('checked', data.isActive); // Is active checkbox
                        $('#chkIsNight').prop('checked', data.isNight); // Is night checkbox
                        $('#chkIsOverTime').prop('checked', data.sftOverTime); // Is overtime checkbox

                        // Update the save button to reflect edit mode
                        $('#btnSave').html('Update');

                        // Expand the form box if it is collapsed
                        BoxExpland();
                    })
                    .catch(function (error) {
                        console.error('Error fetching data for edit:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Failed to fetch data for edit. Please try again.'
                        });
                    });
            }

        

        



        </script>


<%--    <script type="text/javascript">
     $('#btnNew').click(function () {
              clear();
          });
          function validateInputs() {
              if (validateText('txtShiftName', 1, 60, 'Enter ShiftName') == false) return false;
              if (validateText('txtEffectiveDate', 1, 60, 'Enter Effective Date') == false) return false;
              if (validateText('txtShiftName', 1, 60, 'Enter ShiftName') == false) return false;
              return true;
          }

          function clear() {
              if ($('#upSave').val() == '0') {

                  $('#btnSave').removeClass('css_btn');
                  $('#btnSave').attr('disabled', 'disabled');
              }
              else {
                  $('#btnSave').addClass('css_btn');
                  $('#btnSave').removeAttr('disabled');
              }

              $('#txtShiftName').val('');
              $('#txtEffectiveDate').val('');
              $('#txtStartTime').val('');
              $('#txtEndTime').val('');
              $('#txtAcceptableLate').val('');
              $('#txtDelayTimeOut').val('');
              $('#btnSave').val('Save');
              $('#hdnbtnStage').val("");
              $('#hdnUpdate').val("");
              $('#txtShiftName').focus();
              $('#btnDelete').removeClass('css_btn');
              $('#btnDelete').attr('disabled', 'disabled');
          }

    </script>--%>
        <script src="/hrms/assets/theme_assets/js/loadCompany.js"></script>
   <script src="/hrms/assets/theme_assets/js/apiHelper.js"></script>
</asp:Content>
