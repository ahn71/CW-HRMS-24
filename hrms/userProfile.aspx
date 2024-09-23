<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="userProfile.aspx.cs" Inherits="SigmaERP.hrms.userProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="profileEdit">
          <div class="contents">
         <div class="profile-setting ">
            <div class="container-fluid">
               <div class="row">
                  <div class="col-lg-12">
                  </div>
                  <div class="col-xxl-3 col-lg-4 col-sm-5">
                     <!-- Profile Acoount -->
                     <div class="card mb-25">
                        <div class="card-body text-center p-0">

                           <div class="account-profile border-bottom pt-25 px-25 pb-0 flex-column d-flex align-items-center ">
<%--                              <div class="ap-img mb-20 pro_img_wrapper">
                                 <input id="userProfileImage" type="file" name="fileUpload" class="d-none">
                                 <label for="file-upload">
                                    <!-- Profile picture image-->
                                    <img class="ap-img__main rounded-circle wh-120" id="UserProfileImage" src="img/author/myProfile.jpg" alt="profile">
                                    <span class="cross" id="remove_pro_pic">
                                       <img src="img/svg/camera.svg" alt="camera" class="svg">
                                    </span>
                                 </label>
                              </div>--%>
                               <div class="ap-img mb-20 pro_img_wrapper">
                                   <input id="userProfileImage" type="file" name="fileUpload" class="d-none" accept="image/*" onchange="previewAndUploadImage(this)">
                                   <label for="userProfileImage">
                                       <!-- Profile picture image -->
                                       <img class="ap-img__main rounded-circle wh-120" id="UserProfileImage" src="user_img_default.jpg" alt="profile">
                                       <span class="cross" id="remove_pro_pic">
                                           <img src="img/svg/camera.svg" alt="camera" class="svg">
                                       </span>
                                   </label>
                               </div>



                               <div class="ap-nameAddress pb-3">
                                 <h5 id="txtUserName" class="ap-nameAddress__title">Default Text</h5>
                                 <p id="designation" class="ap-nameAddress__subTitle fs-14 m-0">UI/UX Designer</p>
                              </div>

<%--                               <div class="ap-button button-group d-flex justify-content-center flex-wrap">
                                   <button class="btn btn-primary btn-default btn-squared text-capitalize  px-25" type="button" onclick="ShowEdit()">
                                        Update
                                   </button>
                               </div>--%>
                           </div>
                           <div class="ps-tab p-20 pb-25">
                              <div class="nav flex-column text-start" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                 <a class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" href="#v-pills-home" role="tab" aria-selected="true">
                                    <img src="img/svg/user.svg" alt="user" class="svg"> Profile</a>
                                 <a class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" href="#v-pills-messages" role="tab" aria-selected="false">
                                    <img src="img/svg/key.svg" alt="key" class="svg">change password</a>
 
                              </div>
                           </div>

                        </div>
                     </div>
                     <!-- Profile Acoount End -->
                  </div>
                  <div class="col-xxl-9 col-lg-8 col-sm-7">
                     <div class="mb-50">
                        <div class="tab-content" id="v-pills-tabContent">
                           <div class="tab-pane fade  show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                              <!-- Edit Profile -->
                              <div class="edit-profile mt-25">
                                 <div class="card">
                                    <div class="card-header px-sm-25 px-3">
                                       <div class="edit-profile__title">
                                          <h6>Profile</h6>
                                          <span class="fs-13 color-light fw-400">Your personal
                                             information</span>
                                       </div>
                                    </div>
                                    <div class="card-body">
                                       <div class="row justify-content-center">
                                          <div class="col-xxl-6">
                                              <div class="edit-profile__body mx-xl-20">
                                                  <div class="form-group mb-20">
                                                      <label for="names" id="userRole">User Role: Admin</label>
                                                  </div>

                                                   <div class="form-group mb-20">
                                                      <label for="names" id="userDepartment">Department: Manager</label>
                                                  </div>
                                                  <div class="form-group mb-20">
                                                      <span> <img class="svg" src="img/svg/mail.svg" alt="mail"></span>
                                                      <label id="userEmail" for="names"></label>
                                                  </div>
                                              </div>



                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <!-- Edit Profile End -->
                           </div>
         
                           <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
                              <!-- Edit Profile -->
                              <div class="edit-profile mt-25">
                                 <div class="card">
                                    <div class="card-header  px-sm-25 px-3">
                                       <div class="edit-profile__title">
                                          <h6>change password</h6>
                                          <span class="fs-13 color-light fw-400">Change or reset your account
                                             password</span>
                                       </div>
                                    </div>
                                    <div class="card-body">
                                       <div class="row justify-content-center">
                                          <div class="col-xxl-6">
                                             <div class="edit-profile__body mx-xl-20">
                                                 <label id="txtUserPasswordhiden" style="display: none">
                                                 </label>

                                                   <div class="form-group mb-20">
                                                      <label for="name">old passowrd</label>
                                                      <input type="text" id="txtOldPasswoed" class="form-control"/>
                                                   </div>
                                                   <div class="form-group mb-1">
                                                      <label for="password-field">new password</label>
                                                      <div class="position-relative">
                                                         <input id="txtNewPass" type="password" class="form-control" name="password" placeholder="Password"/>
                                                         <span class="uil uil-eye-slash text-lighten fs-15 field-icon toggle-password2"></span>
                                                      </div>
                                                      <small id="passwordHelpdvInline" class="text-light fs-13">Minimum
                                                         6
                                                         characters

                                                      </small>
                                                          <span class="text-danger" id="newPasswordError"></span>
                                                   </div>


                                                      <div class="form-group mb-1">
                                                      <label for="password-field">confirm password</label>
                                                      <div class="position-relative">
                                                         <input id="txtConfirmPass" type="password" class="form-control" name="password" placeholder="Password">
                                                         <span class="uil uil-eye-slash text-lighten fs-15 field-icon toggle-password2"></span>
                                                      </div>
                                                      <small id="passwordHelpvInline" class="text-light fs-13">Minimum
                                                         6
                                                         characters
                                                      </small>

                                                          <span class="text-danger" id="confirmPasswordError"></span>
                                                      <div class="button-group d-flex flex-wrap pt-45 mb-35">
                                                         <button class="btn btn-primary btn-default btn-squared me-15 text-capitalize" type="button"  onclick="FetchDataForView()">Save Change
                                                         </button>
                                                         <button class="btn btn-light btn-default btn-squared fw-400 text-capitalize">cancel
                                                         </button>
                                                      </div>
                                                   </div>
                                                   </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <!-- Edit Profile End -->
                           </div>


                     </div>
                  </div>
               </div>
            </div>
         </div>


      </div>
    </section>

   

    <script>
            var token = '<%= Session["__UserToken__"] %>';
            var rootUrl = '<%= Session["__RootUrl__"]%>';
            var userId = '<%= Session["__GetUserId__"]%>';
            var getUsersUrl = rootUrl + '/api/User/users';
            var updateUserUrl = rootUrl + '/api/User/users/password/update';
            var updateUserImageUrl = rootUrl + '/api/User/users/ImageUpdate'; 
            var getUserByIDUrl = rootUrl + '/api/User/users';
            var userName = '<%= Session["__UserNameText__"] %>';
            var userEmail = '<%= Session["__UserEmailText__"] %>';
            var userDesignation = '<%= Session["__UserDsgText__"] %>';
            var userDepartment = '<%= Session["__UserDptNameText__"] %>';
            var userRoles = '<%= Session["__UserRolesText__"] %>';

            $(document).ready(function () {
                console.log('UserName:', userName);
                console.log('UserEmail:', userEmail);

                $('#txtUserName').text(userName);
                $('#userEmail').text(userEmail);
                $('#designation').text(userDesignation);
                $('#userDepartment').text('Department: ' + userDepartment);

                $('#userRole').text('Role :' + userRoles);

                GetUserData(userId);
               
             
        });

        function FetchDataForView() {
            var isValid = true;
            if ($('#txtNewPass').val().trim() === "") {
                $('#newPasswordError').html("Password is required.");
                $("#txtUserPassword").focus();
                isValid = false;
            } else if ($('#txtNewPass').val().trim().length < 6) {
                $('#newPasswordError').html("Password must be at least 6 characters.");
                $("#txtNewPass").focus();
                isValid = false;
            } else {
                $('#newPasswordError').html("");
            }

            if ($('#txtConfirmPass').val().trim() === "") {
                $('#confirmPasswordError').html("Password is required.");
                $("#txtConfirmPass").focus();
                isValid = false;
            } else if ($('#txtConfirmPass').val().trim().length < 6) {
                $('#confirmPasswordError').html("Password must be at least 6 characters.");
                $("#txtConfirmPass").focus();
                isValid = false;
            } else {
                $('#confirmPasswordError').html("");
            }

            if (isValid == true) {
   
                updateUsers(userId)
            }
        }

        function previewAndUploadImage(input) {
            const file = input.files[0]; // Get the selected file

            if (file) {
                // Preview the selected image
                const reader = new FileReader();
                reader.onload = function (e) {
                    $('#UserProfileImage').attr('src', e.target.result); // Set the preview image source
                };
                reader.readAsDataURL(file); // Read the image file as a Data URL

                // Prepare form data for the API call
                const formData = new FormData();
                formData.append('file', file); // Append the selected file to the form data

                // Make an API call to upload and update the image
                ApiCallImageUpdate(updateUserImageUrl, token, formData, userId)
                    .then(function (response) {
                        const successMessage = response.message || 'Data updated successfully';
                        const statusCode = response.statusCode;

                        // Handle the response based on the status code
                        if (statusCode === 400) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: successMessage
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    GetUserData(userId); // Reload user data if error occurred
                                }
                            });
                        } else {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: successMessage
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    //GetUserData(userId);
                                }
                            });
                        }
                    })
                    .catch(function (error) {
                        console.error('Error updating data:', error);

                        let errorMessage = 'Failed to update the data. Please try again.';

                        if (error.response && error.response.data && error.response.data.message) {
                            errorMessage = error.response.data.message;
                        }

                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: errorMessage
                        });
                    });
            }
        }



        function GetUserData(userId) {
            ApiCallById(getUserByIDUrl, token, userId)
                .then(function (responseData) {
                    var data = responseData.data;

                    // Assuming data.userImage contains the relative URL to the user's image (e.g., '/userImage/123.jpg')
                    if (data.userImage) {
                        $('#UserProfileImage').attr('src', data.userImage); // Set the src of the image to display it
                    } else {
                        // If there's no user image, you can set a default or empty image
                        $('#UserProfileImage').attr('src', 'user_img_default.jpg');
                    }
                })
                .catch(function (error) {
                    console.error('Error:', error);
                });
        }


        function updateUsers(userId) {
            // var userId = $('#lblHidenUserId').val(); // Uncomment this line if you need to get userId from a hidden field
            var oldPassword = $('#txtOldPasswoed').val().trim();
            var newPassword = $('#txtNewPass').val().trim();
            var confirmPassword = $('#txtConfirmPass').val().trim();

            // Validate if newPassword matches confirmPassword
            if (newPassword !== confirmPassword) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'The new password and confirm password do not match.'
                });
                return;
            }

            var updateData = {
                NewUserPassword: newPassword,  // New password
                OldUserPassword: oldPassword   // Old password
            };

            // Call the API to update the user data
            ApiCallUpdate(updateUserUrl, token, updateData, userId)
                .then(function (response) {
                    console.log('Data updated successfully:', response.message);

                    // Check if the API returned a custom message and display it
                    let successMessage = response.message || 'Data updated successfully';
                    let statusCode = response.statusCode;

                    console.log(statusCode)

                    if (statusCode == 400) {

                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: successMessage  // Display the API's error message or default one
                        });
                    }
                    else {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: successMessage  // Show the message from the API
                        }).then((result) => {
                            if (result.isConfirmed) {
                                // Optional: Perform further actions here, e.g. refresh data or reset form
                                // GetRoles();
                                // GetPackages();
                                // GetUsers();
                            }
                        });
                    }



                })
                .catch(function (error) {
                    console.error('Error updating data:', error);

                    // Default error message
                    let errorMessage = 'Failed to update the data. Please try again.';

                    // Check if the error response contains a specific message from the API
                    if (error.response && error.response.data && error.response.data.message) {
                        errorMessage = error.response.data.message;  // Use the message from the API response
                    }

                    // Display error message using SweetAlert
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorMessage  // Display the API's error message or default one
                    });
                });

        }


    </script>
     <script src="assets/theme_assets/js/apiHelper.js"></script>

</asp:Content>
