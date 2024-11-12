<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="leaveApprove.aspx.cs" Inherits="SigmaERP.hrms.Leave.leaveApprove" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .exchange-icon {
            font-size: 1.5rem;
            color: rgba(0, 0, 0, 0.5); /* Transparent icon */
            display: inline-block;
            vertical-align: middle;
        }

        /*.line-height {
                line-height: 96px;
        }
        .action-btn{
            margin-top: -36px;
        }*/
        .total-day{
            text-align:center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
<%--    <div class="row mt-25 application">
   
    </div>--%>

        <div class="row">
               <div class="col-lg-12">
                  <div class="card ">
                     <div class="card-body">

                        <div class="userDatatable adv-table-table global-shadow border-light-0 w-100 ">
                           <div class="table-responsive">
                              <div class="ad-table-table__header d-flex justify-content-between">
                                  <h4 style="margin-top: 13px;">Leave Applications</h4>
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

    <script>
        var token = '<%= Session["__UserToken__"] %>';
        //var rootUrl = 'https://localhost:7220';
        var rootUrl = '<%= Session["__RootUrl__"]%>';
        var CompanyID = '<%= Session["__GetCompanyId__"]%>';
        var userId = '<%= Session["__GetUserId__"]%>';
        var loginempId = '<%= Session["__GetEmpId__"]%>';
        var dptId = '<%=  Session["__DptId__"]%>';
        var dsgId = '<%=  Session["__DsgId__"]%>';
        var gId = '<%=  Session["__Gid__"]%>';
        var sftId = '<%=  Session["__SftId__"]%>';
        var DataAccessLevel = '<%=Session["__UserDataAccessLevel__"]%>';

        var getLeavesApplicationUrl = rootUrl + '/api/Leave/lvApplicationForApprove';
        var getLeaveApproveUrl = rootUrl + '/api/Leave/approval';

        $(document).ready(function () {
            GetLeaves();  // Fetch leave data on document ready
        });

        function GetLeaves() {
            ApiCallAuthority(getLeavesApplicationUrl, token,CompanyID,userId)
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

            let serialNumber = 1;
            const defaultImage = '/hrms/user_img_default.jpg';

            data.forEach(row => {
                row.serial = serialNumber++;

                // Use default image if empPicture is not provided
                const imgUrl = '../../EmployeeImages/Images/';
                const empPicture = row.empPicture ? imgUrl + row.empPicture : defaultImage;

                // Combine employee image and name for the "User" column
                row.userImage = `
            <div class="user-details-container d-flex align-items-center">
                <img src="${empPicture}" alt="User Image" class="user-image" style="width: 40px; height: 40px; margin-right: 10px;">
                <div>
                    <a href="javascript:void(0)" class="user-name" data-id="${row.empId}">${row.empName}</a>
                    <div class="user-role">${row.dsgName || 'N/A'}</div>
                </div>
            </div>
        `;

                // Define buttons based on leave authorityAction
                let forwardButton = '';
                let approveButton = '';
                let declineButton = `
            <button type="button" class="btn btn-outline-danger btn-sm m-2 leave-action-btn" 
                data-id="${row.id}" 
                data-notification-id="0" 
                data-status="2">
                Decline <span><i class="uil-multiply"></i></span>
            </button>
        `;

                // Action buttons based on authorityAction value
                if (row.authorityAction === 1) {
                    forwardButton = `
                <button type="button" class="btn btn-info btn-sm m-2 leave-action-btn" 
                    data-id="${row.id}" 
                    data-notification-id="0" 
                    data-status="0">
                    Forward <span><i class="uil-share"></i></span>
                </button>
            `;
                } else if (row.authorityAction === 2) {
                    approveButton = `
                <button type="button" class="btn btn-success btn-sm m-2 leave-action-btn" 
                    data-id="${row.id}" 
                    data-notification-id="0" 
                    data-status="1">
                    Approve <span><i class="uil-check"></i></span>
                </button>
            `;
                } else {
                    forwardButton = `
                <button type="button" class="btn btn-info btn-sm m-2 leave-action-btn" 
                    data-id="${row.id}" 
                    data-notification-id="0" 
                    data-status="0">
                    Forward <span><i class="uil-share"></i></span>
                </button>
            `;
                    approveButton = `
                <button type="button" class="btn btn-success btn-sm m-2 leave-action-btn" 
                    data-id="${row.id}" 
                    data-notification-id="0" 
                    data-status="1">
                    Approve <span><i class="uil-check"></i></span>
                </button>
            `;
                }

                // Combine all buttons into one action column
                row.action = `
            <div class="actions">
                ${forwardButton}
                ${approveButton}
                ${declineButton}
            </div>
        `;
            });

            // Define columns for Footable
            const columns = [
                { "name": "serial", "title": "SL", "breakpoints": "xs sm", "type": "number", "className": "userDatatable-content" },
                { "name": "userImage", "title": "Employee", "className": "userDatatable-content" },
                { "name": "leaveName", "title": "Leave Type", "className": "userDatatable-content" },
                { "name": "leaveStartDate", "title": "Start Date", "className": "userDatatable-content" },
                { "name": "leaveEndDate", "title": "End Date", "className": "userDatatable-content" },
                { "name": "totalLeaveDays", "title": "Total Days", "className": "userDatatable-content" },
                { "name": "action", "title": "Action", "sortable": false, "filterable": false, "className": "userDatatable-content" }
            ];

            // Initialize Footable
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
                    $('.footable-loader').hide();
                });
            } catch (error) {
                console.error("Error initializing Footable:", error);
            }

            // Event listener for leave action buttons (Forward, Approve, Decline)
            $('.adv-table').off('click', '.leave-action-btn').on('click', '.leave-action-btn', function () {
                const leaveId = $(this).data('id');
                const notificationId = $(this).data('notification-id');
                const approvalStatus = $(this).data('status');

                LeaveApprove(leaveId, notificationId, approvalStatus);
            });
        }

        function LeaveApprove(LeaveId, notificationId, approval_status) {
            var updateData = {
                id: LeaveId,
                notificationId: notificationId,
                approval_status: approval_status
            };

            ApiCallUpdateWithoutId(getLeaveApproveUrl, token, updateData)
                .then(function (response) {
                    console.log('Data updated successfully:', response);
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'Leave Approved successfull!'
                    }).then(() => {
                         GetLeaves();
                    });
                })
                .catch(function (error) {
                    console.error('Error updating data:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to update data. Please try again.'
                    });
                });
        }


        function formatDate(dateString) {
            var date = new Date(dateString);
            return date.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            });
        }


    </script>

     <script src="../assets/theme_assets/js/apiHelper.js"></script>
</asp:Content>
