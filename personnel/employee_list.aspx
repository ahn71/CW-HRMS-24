<%@ Page Title="Employee Details" Language="C#" MasterPageFile="~/personnel_NestedMaster.master" AutoEventWireup="true" CodeBehind="employee_list.aspx.cs" Inherits="SigmaERP.personnel.employee_list1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script type="text/javascript">

           var oldgridcolor;
           function SetMouseOver(element) {
               oldgridcolor = element.style.backgroundColor;
               element.style.backgroundColor = '#ffeb95';
               element.style.cursor = 'pointer';
               // element.style.textDecoration = 'underline';
           }
           function SetMouseOut(element) {
               element.style.backgroundColor = oldgridcolor;
               // element.style.textDecoration = 'none';

           }

</script>
    <style>
        .h1, .h1, h2, .h2, h3, .h3 {
            margin-bottom: 2px;
            margin-top: 10px;
        }

        .emp_header_left {
            font-size: 16px;
            padding-left: 10px;
            text-align: left;
            font: bold;
        }

        .total_emp {
            color: yellow;
            display: inline;
        }

        .emp_header_right {
            float: right;
            margin-top: -37px;
            font: bold;
        }

        #ContentPlaceHolder1_MainContent_gvForApprovedList th, td {
            text-align: center;
        }

            #ContentPlaceHolder1_MainContent_gvForApprovedList th:nth-child(3), td:nth-child(3) {
                text-align: left;
                padding-left: 3px;
            }

        #ContentPlaceHolder1_MainContent_gvForApprovedList td:nth-child(1) {
            color: red;
            font: bold;
            font-family: 'Times New Roman';
        }

        .import-file-name {
            display: block;
            color: #fff;
            font-size: 12px;
            margin-top: 3px;
            max-width: 210px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .employee-import-modal .import-error-cell {
            background: #f8d7da !important;
            color: #a94442 !important;
            font-weight: bold;
        }

        .employee-import-modal {
            background: rgba(0,0,0,.45);
            bottom: 0;
            left: 0;
            outline: 0;
            overflow-x: hidden;
            overflow-y: auto;
            position: fixed;
            right: 0;
            top: 0;
            z-index: 1050;
        }

        .employee-import-modal .modal-dialog {
            margin: 24px auto;
            max-width: 1480px;
            width: 96%;
        }

        .employee-import-modal .modal-content {
            background: #fff;
            border: 1px solid #999;
            border-radius: 4px;
            box-shadow: 0 5px 15px rgba(0,0,0,.5);
            position: relative;
        }

        .employee-import-modal .modal-header,
        .employee-import-modal .modal-footer {
            background: #f7f7f7;
            border-color: #ddd;
            padding: 10px 14px;
        }

        .employee-import-modal .modal-body {
            padding: 12px 14px;
        }

        .employee-import-modal .modal-title {
            font-size: 20px;
            font-weight: 600;
            margin: 0;
        }

        .employee-import-modal .table-wrap {
            border: 1px solid #ddd;
            margin-top: 8px;
            max-height: 520px;
            overflow: auto;
        }

        .employee-import-modal table {
            border-collapse: collapse;
            margin: 0;
            min-width: 1500px;
            table-layout: auto;
            width: 100%;
        }

        .employee-import-modal th,
        .employee-import-modal td {
            border: 1px solid #ddd !important;
            padding: 6px 8px !important;
            text-align: center !important;
            vertical-align: middle !important;
            white-space: nowrap;
        }

        .employee-import-select {
            color: #333;
            font-weight: 400;
            height: 32px;
            max-width: 260px;
            min-width: 150px;
            padding: 3px 6px;
            width: 100%;
        }

        .employee-import-modal .cell-wide {
            min-width: 230px;
        }

        .employee-import-modal .cell-medium {
            min-width: 170px;
        }

        .employee-import-modal .btn-remove-row {
            background: #f36f45;
            border: 0;
            border-radius: 3px;
            color: #fff;
            display: inline-block;
            font-weight: bold;
            height: 28px;
            line-height: 28px;
            text-align: center;
            width: 28px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
                  <div class="col-md-12 ">
               <div class="ds_nagevation_bar">
                   <ul>
                       <li><a href="/default.aspx">Dashboard</a></li>
                       <li><a href="#">/</a></li>
                       <li> <a href="<%= Session["__topMenuForPersonnel__"] %>">Personnel</a></li>
                       <li><a href="#">/</a></li>
                       <li><a href="#" class="ds_negevation_inactive Ptactive">Employees Details</a></li>
                   </ul>
               </div>
          
             </div>
       </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate>
        <p class="message" id="lblMessage" clientidmode="Static" runat="server"></p>
    </ContentTemplate>
</asp:UpdatePanel>
    
<div style="padding:0;margin-top:25px;max-width:100%;">
    <div class="row Rrow">


                <div style="width: 100%; background:#750000 none repeat scroll 0 0 !important;"  class="list_main_content_box_header personal_color_header"  id="divElementContainer"  runat="server"> 
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <Triggers>
                     
                            <asp:AsyncPostBackTrigger ControlID="ddlCompanyList" />
                            <asp:AsyncPostBackTrigger ControlID="ddlShift" />
                            <asp:AsyncPostBackTrigger ControlID="ddlDepartmentList" />
                            <asp:AsyncPostBackTrigger ControlID="ddlChoseYear" />
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" />
                            <asp:AsyncPostBackTrigger ControlID="btnRefresh" />
                            <asp:AsyncPostBackTrigger ControlID="btnClear" />
                            <asp:PostBackTrigger ControlID="btnPreviewUpload" />
                        </Triggers>
                        <ContentTemplate>
                            <div style="overflow: hidden;margin-bottom: 5px; border-bottom: 1px solid #ddd;">
                                <h3 class="emp_header_left">
                                <p style="font-size: 20px;text-align: center;font-weight: 500; text-shadow: 5px 5px 5px #000;">Employee List Panel</p>
                                <h2 class="emp_header_right">                
                                    <span id="pTotalEmployee" runat="server" class="total_emp">Any Employee Not Founded</span>
                                    <asp:FileUpload ID="fuEmployeeExcel" runat="server" ClientIDMode="Static" Style="display:none" accept=".xlsx,.xls" onchange="showImportFileName(this)" />
                                    <asp:Button runat="server" ID="btnChooseUpload" CssClass="css_btn Ptbut" Text="Choose" Width="75px" Height="34px" OnClientClick="document.getElementById('fuEmployeeExcel').click(); return false;" />
                                    <asp:Button runat="server" ID="btnPreviewUpload" CssClass="css_btn Ptbut" Text="Upload" Width="75px" Height="34px" OnClick="btnPreviewUpload_Click" />
                                    <asp:Label ID="lblUploadFileName" runat="server" ClientIDMode="Static" CssClass="import-file-name"></asp:Label>
                                    <asp:Button runat="server" ID="btnClear" CssClass="css_btn Ptbut" Text="Clear" Width="75px" Height="34px" OnClick="btnClear_Click"   />                       
                                    <asp:Button  runat="server" ID="btnRefresh" CssClass="css_btn Ptbut" Text="Refresh" Width="75px" Height="34px" OnClick="btnRefresh_Click"     />
                                </h2>
                            </div>
                   <div>
                    
                    <table border="0" cellpadding="4" width="99%" cellspacing="0" style="margin:0 0 5px 6px; border-collapse: collapse;">
                        <tr>
                            <td>Unit</td>
                            <td>Depertment</td>
                            <td>Shift</td>
                            <td>Line / Grp</td>
                            <td>Card No/ Reg.</td>
                            <td>Year</td>
                            <td>From Date</td>
                            <td>To Date</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="ddlCompanyList" Visible="false" ClientIDMode="Static" CssClass="form-control inline_form_text_box_width" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCompanyList_SelectedIndexChanged">
                                </asp:DropDownList>

                                   <asp:DropDownList ID="ddlUnit"  ClientIDMode="Static" CssClass="form-control inline_form_text_box_width" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlUnit_SelectedIndexChanged">
                                </asp:DropDownList>

                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDepartmentList" CssClass="form-control inline_form_text_box_width" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartmentList_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlShift" CssClass="form-control inline_form_text_box_width"  AutoPostBack="True" OnSelectedIndexChanged="ddlShift_SelectedIndexChanged"    ></asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlGrouping" runat="server" AutoPostBack="True" CssClass="form-control inline_form_text_box_width" OnSelectedIndexChanged="ddlGrouping_SelectedIndexChanged">
                                </asp:DropDownList>                                   
                            </td>
                            <td>
                                <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control inline_form_text_box_width" ClientIDMode="Static" MaxLength="12" style="width:100px !important;" onkeypress="loadEmpInfo(event)"></asp:TextBox>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlChoseYear" CssClass="form-control inline_form_text_box_width" AutoPostBack="True" OnSelectedIndexChanged="ddlChoseYear_SelectedIndexChanged" style="width:100px !important;"></asp:DropDownList>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control inline_form_text_box_width" ClientIDMode="Static" MaxLength="12" style="width:100px !important;"></asp:TextBox>
                                <asp:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" Format="dd-MM-yyyy" TargetControlID="txtFromDate">
                                </asp:CalendarExtender>
                            </td>
                            <td>
                                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control inline_form_text_box_width" ClientIDMode="Static" MaxLength="12" style="width:100px !important;"></asp:TextBox>
                                <asp:CalendarExtender ID="txtToDate_CalendarExtender" runat="server"  Format="dd-MM-yyyy" TargetControlID="txtToDate">
                                </asp:CalendarExtender>
                            </td>
                            <td><asp:Button runat="server" ID="btnSearch" CssClass="css_btn Ptbut" Text="Search" Width="75px" Height="34px" OnClick="btnSearch_Click"   /> </td>
                        </tr>
                    </table>
                            
                  
                     </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div >
                   <div class="loding_img">
                       <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <span style=" font-family:'Times New Roman'; font-size:20px; color:green;font-weight:bold;float:left"><p>&nbsp;</p> </span> <br />
                                        <img cursor:pointer; float:left" src="/images/loader-2.gif"/>  
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                  </div>
                <asp:UpdatePanel runat="server" ID="up2">
                    <Triggers>                        
                       
                    </Triggers>
                    <ContentTemplate>
                     <div  style="width: 100%; background-color:#fff;margin: auto;">
                     <asp:GridView HeaderStyle-BackColor="#750000" ID="gvForApprovedList" runat="server" AutoGenerateColumns="false"  HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" HeaderStyle-Height="25px" HeaderStyle-Font-Size="14px" AllowPaging="true" PageSize="25" Width="100%" DataKeyNames="EmpId,CompanyId" OnRowCommand="gvForApprovedList_RowCommand"  OnPageIndexChanging="gvForApprovedList_PageIndexChanging" OnRowDataBound="gvForApprovedList_RowDataBound">
                         <PagerStyle CssClass="gridview" />
                          <Columns>  
                              <asp:TemplateField HeaderText="SL">
                                <ItemTemplate>
                                     <%# Container.DataItemIndex + 1 %>                                  
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>                         
                           <asp:BoundField DataField="EmpCardNo" HeaderText="Card No (Reg.)" ItemStyle-HorizontalAlign="Center" />
                                 <asp:BoundField DataField="EmpName" HeaderText="Name" />
                                 <asp:BoundField DataField="EmpJoiningDate" HeaderText="Join Date" ItemStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="UnitName" HeaderText="Unit" ItemStyle-HorizontalAlign="Center" />
                                 <asp:BoundField DataField="DptName" HeaderText="Department" ItemStyle-HorizontalAlign="Center" />
                                 <asp:BoundField DataField="DsgName" HeaderText="Designation" ItemStyle-HorizontalAlign="Center" />
                                 <asp:BoundField DataField="SftName" HeaderText="Shift" ItemStyle-HorizontalAlign="Center" />
                                 <asp:BoundField DataField="EmpType" HeaderText="Type" ItemStyle-HorizontalAlign="Center" />
                                 <asp:BoundField DataField="EmpDutyType" HeaderText="Duty Type" ItemStyle-HorizontalAlign="Center" />   
                              <asp:BoundField DataField="WeekendType" HeaderText="Weekend Type" ItemStyle-HorizontalAlign="Center" />
                              <asp:TemplateField HeaderText="Profile" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                  <ItemTemplate>
                                      <asp:LinkButton ID="lnkProfile" runat="server"
                                          CommandName="Profile"
                                          CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                          Font-Bold="true" ForeColor="Green">
                                          <i class="fa fa-user"></i> 
                                      </asp:LinkButton>

                                  </ItemTemplate>
                              </asp:TemplateField>
                                <asp:TemplateField HeaderText="Change"  HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                  <ItemTemplate >
                                      <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Width="55px" Height="30px" Font-Bold="true" ForeColor="green" Text="Edit" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' />
                                  </ItemTemplate>
                              </asp:TemplateField>
                               <asp:TemplateField HeaderText="Transfer" HeaderStyle-Width="30px">
                                  <ItemTemplate>
                                      <asp:Button ID="btnTransfer" runat="server" CommandName="Transfer" Font-Bold="true" ForeColor="Blue" Text="Transfer" Width="62px" Height="30px" OnClientClick="return confirm('Do you want to transfer this employe ?')" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' />
                                  </ItemTemplate>
                              </asp:TemplateField> 
                               <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                  <ItemTemplate>
                                      <asp:Button ID="btnView" runat="server" CommandName="Remove" Font-Bold="true" ForeColor="red" Text="Delete" Width="55px" Height="30px" OnClientClick="return confirm('Do you want to delete this record ?')" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' />
                                  </ItemTemplate>
                              </asp:TemplateField>                                                    
                          </Columns>
                     </asp:GridView>
                         <div id="divRecordMessage" runat="server" visible="false" style="color: red; font-weight: bold; text-align: center; padding-top: 75px; font-size: 32px; height: 118px">
                           
                         </div>
                </div>
                   </ContentTemplate>
                </asp:UpdatePanel>

                <div class="modal employee-import-modal" id="employeeImportModal" tabindex="-1" role="dialog" aria-labelledby="employeeImportModalLabel" style="display:none;">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" onclick="hideEmployeeImportModal()" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="employeeImportModalLabel">Employee Upload Preview</h4>
                            </div>
                            <div class="modal-body">
                                <asp:UpdatePanel ID="upEmployeeImportPreview" runat="server" UpdateMode="Conditional">
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="gvEmployeeImportPreview" />
                                        <asp:AsyncPostBackTrigger ControlID="btnSubmitEmployeeImport" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <asp:Label ID="lblImportSummary" runat="server" Font-Bold="true"></asp:Label>
                                        <div class="table-wrap">
                                            <asp:GridView ID="gvEmployeeImportPreview" runat="server" AutoGenerateColumns="false" Width="100%"
                                                CssClass="table table-bordered table-condensed" DataKeyNames="ImportRowId"
                                                OnRowCommand="gvEmployeeImportPreview_RowCommand" OnRowDataBound="gvEmployeeImportPreview_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkRemoveImportRow" runat="server" CommandName="RemoveImportRow"
                                                                CommandArgument='<%# Eval("ImportRowId") %>' CssClass="btn-remove-row" Text="x" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="ExcelRowNo" HeaderText="Row" />
                                                    <asp:TemplateField HeaderText="CompanyName">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlImportCompany" runat="server" CssClass="employee-import-select cell-wide"></asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="EmpType">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlImportEmpType" runat="server" CssClass="employee-import-select cell-medium"></asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="SalaryType" HeaderText="SalaryType" />
                                                    <asp:BoundField DataField="FullName" HeaderText="FullName" />
                                                    <asp:BoundField DataField="NameBangla" HeaderText="NameBangla" />
                                                    <asp:TemplateField HeaderText="Department">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlImportDepartment" runat="server" CssClass="employee-import-select cell-medium"></asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Designation">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlImportDesignation" runat="server" CssClass="employee-import-select cell-medium"></asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Group">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlImportGroup" runat="server" CssClass="employee-import-select cell-medium"></asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Shift">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlImportShift" runat="server" CssClass="employee-import-select cell-medium"></asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="EmpCardNo" HeaderText="EmpCardNo" />
                                                    <asp:BoundField DataField="RegID" HeaderText="Reg.ID" />
                                                     <asp:TemplateField HeaderText="EmpStatus">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlEmpstatus" runat="server" CssClass="employee-import-select cell-medium"></asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Type" HeaderText="Type" />
                                                    <asp:BoundField DataField="UnitName" HeaderText="UnitName" />
                                                    <asp:BoundField DataField="DutyType" HeaderText="DutyType" />
                                                    <asp:BoundField DataField="WeekendType" HeaderText="WeekendType" />
                                                    <asp:BoundField DataField="JoiningDate" HeaderText="JoiningDate" />
                                                    <asp:BoundField DataField="ErrorMessage" HeaderText="Problem" />
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnSubmitEmployeeImport" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="btnSubmitEmployeeImport_Click" />
                                <button type="button" class="btn btn-default" onclick="hideEmployeeImportModal()">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
        
        </div>
    </div>
    <style type=”text/css”>
    .hand { cursor: pointer; cursor: hand; } /* cross browser hand */
</style>
       <script type="text/javascript">
           $(document).ready(function () {              
               $(document).on("keypress", "body", function (e) {
                   if (e.keyCode == 13) e.preventDefault();
                   // alert('deafault prevented');

               });
           });
           function goToNewTabandWindow(url) {
               window.open(url);
               loadcardNo();
           }
           function loadEmpInfo(e) {              
               if (e.keyCode == 13) {                   
                   //jQuery.ajax({
                   //    url: 'employee_list.aspx/LoadEmpInfo',
                   //    type: "POST",
                   //    data: "",
                   //    contentType: "application/json; charset=utf-8",
                   //    dataType: "json",
                   //    beforeSend: function () {
                   //        //alert("Start!!! ");
                   //    },
                   //    success: function (data) {
                   //        alert("a");
                   //    },
                   //    failure: function (msg) { alert("Sorry!!! "); }
                   //});
                   
               }                               
           }
           function deleteRow(id) {
               var answer = confirm("Are you sure you want to Delete");
               if (answer == true) {
                   jx.load('/ajax.aspx?id=' + id + '&todo=DeleteEmployee', function (data) {
                       document.location = '/personnel/employee_list.aspx';
                       // $('#divEmployeeList').html(data);
                   });
                   return true;
               }
               else {
                   return false;
               }


           }
           function editEmployee(id) {
               goURL('/personnel/employee.aspx?EmpId=' + id + "&Edit=True");
           }
           function confirmDelete() {
               alert("confirmComplete");
               var answer = confirm("Are you sure you want to Delete");
               if (answer == true) {
                   $('#hdfdeleteconfirm').val('true');
                   //return true;
               }
               else {
                   $('#hdfdeleteconfirm').val('false');
                   // return false;
               }
           }
           function showImportFileName(input) {
               var label = document.getElementById('lblUploadFileName');
               if (label) label.innerHTML = input.files && input.files.length ? input.files[0].name : '';
           }
           function showEmployeeImportModal() {
               var modal = document.getElementById('employeeImportModal');
               if (!modal) return;
               modal.style.display = 'block';
               modal.className = modal.className.indexOf(' in') >= 0 ? modal.className : modal.className + ' in';
               document.body.className = document.body.className.indexOf('modal-open') >= 0 ? document.body.className : document.body.className + ' modal-open';
           }
           function hideEmployeeImportModal() {
               var modal = document.getElementById('employeeImportModal');
               if (!modal) return;
               modal.style.display = 'none';
               modal.className = modal.className.replace(' in', '');
               document.body.className = document.body.className.replace(' modal-open', '');
           }
           function clearEmployeeImportCellError(select) {
               if (!select || !select.parentNode) return;
               var cell = select.parentNode;
               while (cell && cell.tagName && cell.tagName.toLowerCase() !== 'td') {
                   cell = cell.parentNode;
               }
               if (cell && select.value) {
                   cell.className = cell.className.replace('import-error-cell', '');
               }
           }
       </script>
</asp:Content>
