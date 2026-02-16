<%@ Page Title="" Language="C#" MasterPageFile="~/leave_nested.master" AutoEventWireup="true" CodeBehind="LieuLeaveReport.aspx.cs" Inherits="SigmaERP.hrms.Leave.LieuLeaveReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager runat="server" ID="scr1"></asp:ScriptManager>
       <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
    <style>
        .report-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 25px;
            margin: 20px 0;
        }
        
        .page-header {
            border-bottom: 3px solid #007bff;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        
        .page-header h2 {
            color: #2c3e50;
            font-size: 24px;
            font-weight: 600;
            margin: 0;
        }
        
        .filter-section {
            background: #f8f9fa;
            border-radius: 6px;
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -10px;
        }
        
        .form-group {
            flex: 0 0 25%;
            padding: 0 10px;
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            font-weight: 500;
            color: #495057;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .form-group label .required {
            color: #dc3545;
        }
        
        .form-control, .select2-container {
            width: 100% !important;
        }
        
        .form-control {
            height: 38px;
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.15s ease-in-out;
        }
        
        .form-control:focus {
            border-color: #007bff;
            outline: 0;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        
        .select2-container--default .select2-selection--single {
            height: 38px !important;
            border: 1px solid #ced4da !important;
            border-radius: 4px !important;
        }
        
        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 36px !important;
            padding-left: 12px !important;
            color: #495057 !important;
        }
        
        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 36px !important;
        }
        
        .btn-group {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 10px;
        }
        
        .btn {
            padding: 10px 24px;
            font-size: 14px;
            font-weight: 500;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-search {
            background: #007bff;
            color: white;
        }
        
        .btn-search:hover {
            background: #0056b3;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0,123,255,0.3);
        }
        
        .btn-export {
            background: #28a745;
            color: white;
        }
        
        .btn-export:hover {
            background: #218838;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(40,167,69,0.3);
        }
        
        .btn i {
            font-size: 16px;
        }
        
        .grid-container {
            margin-top: 20px;
            overflow-x: auto;
        }
        
        .gridview {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        
        .gridview th {
            background: #343a40;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: 500;
            font-size: 13px;
            border: 1px solid #dee2e6;
        }
        
        .gridview td {
            padding: 10px 12px;
            border: 1px solid #dee2e6;
            font-size: 13px;
            color: #495057;
        }
        
        .gridview tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        .gridview tr:hover {
            background-color: #e9ecef;
        }
        
        @media (max-width: 1200px) {
            .form-group {
                flex: 0 0 33.333%;
            }
        }
        
        @media (max-width: 768px) {
            .form-group {
                flex: 0 0 50%;
            }
        }
        
        @media (max-width: 576px) {
            .form-group {
                flex: 0 0 100%;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
        
        .loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
        
        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #007bff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>


      <div class="report-container">
        <div class="page-header">
            <h2><i class="fas fa-file-alt"></i> Lieu Leave Report</h2>
        </div>
        
        <asp:UpdatePanel ID="UpdatePanelFilters" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="filter-section">
                    <div class="form-row">
                        <!-- Company Dropdown -->
                        <div class="form-group">
                            <label>Company <span class="required">*</span></label>
                            <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" 
                                AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                        
                        <!-- Employee Dropdown -->
                        <div class="form-group">
                            <label>Employee</label>
                            <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control select2">
                                <asp:ListItem Value="0" Text="All Employees"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <!-- Department Dropdown -->
                        <div class="form-group">
                            <label>Department</label>
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control select2" 
                                AutoPostBack="true">
                                <asp:ListItem Value="0" Text="All Departments"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <!-- Designation Dropdown -->
                        <div class="form-group">
                            <label>Designation</label>
                            <asp:DropDownList ID="ddlDesignation" runat="server" CssClass="form-control select2">
                                <asp:ListItem Value="0" Text="All Designations"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <!-- From Date -->
                        <div class="form-group">
                            <label>From Date</label>
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" 
                                TextMode="Date"></asp:TextBox>
                        </div>
                        
                        <!-- To Date -->
                        <div class="form-group">
                            <label>To Date</label>
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" 
                                TextMode="Date"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="btn-group">
                        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-search" 
                            Text="Search" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnExport" runat="server" CssClass="btn btn-export" 
                            Text="Export to Excel" OnClick="btnExport_Click" />
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlCompany" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="ddlDepartment" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
        
        <asp:UpdatePanel ID="UpdatePanelGrid" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="grid-container">
                    <asp:GridView ID="gvLieuLeaveReport" runat="server" 
                        CssClass="gridview" 
                        AutoGenerateColumns="false"
                        EmptyDataText="No records found"
                      
                       >
                        <Columns>
                            <asp:BoundField DataField="EmployeeCode" HeaderText="Employee Code" />
                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:BoundField DataField="Designation" HeaderText="Designation" />
                            <asp:BoundField DataField="OTDate" HeaderText="OT Date" DataFormatString="{0:dd-MMM-yyyy}" />
                            <asp:BoundField DataField="OTHours" HeaderText="OT Hours" />
                            <asp:BoundField DataField="LieuLeaveEarned" HeaderText="Lieu Leave Earned" />
                            <asp:BoundField DataField="LieuLeaveUsed" HeaderText="Lieu Leave Used" />
                            <asp:BoundField DataField="LieuLeaveBalance" HeaderText="Balance" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Columns>
                        <PagerStyle CssClass="pagination" HorizontalAlign="Center" />
                    </asp:GridView>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
    </div>
    
    <!-- Select2 JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function() {
            // Initialize Select2 for all dropdowns except Company
            initializeSelect2();
            
            // Set default dates
            setDefaultDates();
            
            // Update Progress Handler
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            
            prm.add_beginRequest(function() {
                $('#loadingOverlay').css('display', 'flex');
            });
            
            prm.add_endRequest(function() {
                $('#loadingOverlay').hide();
                // Reinitialize Select2 after UpdatePanel refresh
                initializeSelect2();
            });
        });
        
        function initializeSelect2() {
            // Apply Select2 to dropdowns with select2 class
            $('.select2').select2({
                placeholder: 'Select an option',
                allowClear: true,
                width: '100%'
            });
        }
        
        function setDefaultDates() {
            var today = new Date();
            var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
            
            // Format dates as YYYY-MM-DD
            var fromDate = firstDay.toISOString().split('T')[0];
            var toDate = today.toISOString().split('T')[0];
            
            // Set values if empty
            if (!$('#<%= txtFromDate.ClientID %>').val()) {
                $('#<%= txtFromDate.ClientID %>').val(fromDate);
            }
            if (!$('#<%= txtToDate.ClientID %>').val()) {
                $('#<%= txtToDate.ClientID %>').val(toDate);
            }
        }
    </script>

</asp:Content>
