﻿<%@ Page Title="Processing Daily Attendance" Language="C#" MasterPageFile="~/attendance_nested.master" AutoEventWireup="true" CodeBehind="AttendanceProcessing.aspx.cs" Inherits="SigmaERP.attendance.AttendanceProcessing" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">



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


        document.addEventListener('DOMContentLoaded', function () {
            // Initialize Flatpickr only if it hasn't been initialized
            if (!document.querySelector(".DatePicker")._flatpickr) {
                flatpickr(".DatePicker", {
                    dateFormat: "d-m-Y",
                    allowInput: true,
                });
            }

            // Trigger calendar on icon click
            document.querySelectorAll(".DatePicker").forEach(function (element) {
                const icon = element.nextElementSibling; // Assuming the icon is next to the input
                if (icon) {
                    icon.addEventListener("click", function () {
                        element._flatpickr.open(); // Open Flatpickr programmatically
                    });
                }
            });
        });

    </script>


    <style type="text/css">
        .alignment {
            text-align: center
        }

        .AlgRgh {
            text-align: right;
            font-family: Verdana, Arial, Helvetica, sans-serif;
        }

        label{
            padding:0 !important;
        }
        .fileUpload {
            background-color: yellow;
            /*float: left;*/
            height: 36px;
            margin-top: 0;
            width: 188px;
        }

        .selectionBox {
            margin: 15px auto;
            font-size: 13px;
            width: 100%;
        }

            .selectionBox td:nth-child(2), td:nth-child(4), td:nth-child(6) {
                width: 25%;
            }

        .tbl1 {
            margin: 0px auto;
            font-size: 13px;
            /*width:80%;*/
        }

            .tbl1 tr {
                height: 50px;
            }

        .ajax__calendar_days table tr {
            height: auto !important;
        }

            .ajax__calendar_days table tr td:nth-child(2), td:nth-child(4), td:nth-child(6) {
                width: auto;
            }

        .table tr th:first-child, tr th:nth-child(2) {
            align-content: center;
        }

        .caption {
            font-size: 14px;
            font-weight: bold;
            padding-bottom: 5px;
            padding-right: 5px;
            padding-left: 5px;
        }

        .input-container {
            position: relative;
            display: block;
      
        }

        .input-container input {
            padding-left: 35px;
            font-size: 16px;
            height: 40px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .input-container .fa-calendar {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="ds_nagevation_bar">
                <ul>
                    <li><a href="/default.aspx">Dashboard</a></li>
                    <li>/</li>
                    <li><a href="<%=  Session["__topMenu__"] %>">Attendance</a></li>
                    <li>/</li>
                    <li><a href="#" class="ds_negevation_inactive Mactive">Processing Daily Attendance</a></li>
                </ul>
            </div>
        </div>
    </div>


    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>



    <div class="">
        <div class="">
            <h4>Daily Attendance Processing</h4>
        </div>
        <%--<div class="main_box_body">
            <div class="main_box_content">--%>
        <div class="main_box_body Mbody">
            <div class="employee_box_content">
                <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" runat="server">
                    <Triggers>
                        <%-- <asp:AsyncPostBackTrigger ControlID="btnImport" />--%>
                        <asp:AsyncPostBackTrigger ControlID="gvAttendance" />
                        <asp:AsyncPostBackTrigger ControlID="ddlCompanyList" />
                        <asp:AsyncPostBackTrigger ControlID="ddlDepartmentList" />
                        <asp:AsyncPostBackTrigger ControlID="rblDateType" />
                        <asp:AsyncPostBackTrigger ControlID="rblImportType" />
                        <asp:AsyncPostBackTrigger ControlID="txtFullAttDate" />
                    </Triggers>
                    <ContentTemplate>

                        <div class="row">
                            <div class="col-lg-6" style="display: flex; justify-content: flex-start">
                                <label class="form-label ">Process Type:</label>
                                <div class="" style="display: flex; justify-content: flex-start">
                                    <asp:RadioButtonList ForeColor="Red" OnSelectedIndexChanged="rblImportType_SelectedIndexChanged" AutoPostBack="true" Style="font-size: 13px" Font-Bold="true" ID="rblImportType" runat="server" ClientIDMode="Static" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Value="FullImport">Full Process</asp:ListItem>
                                        <asp:ListItem Value="PartialImport">Partial Process</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RadioButtonList ForeColor="blue" Style="font-size: 13px" Visible="false" Font-Bold="true" ID="rblDateType" runat="server" ClientIDMode="Static" RepeatDirection="Horizontal" AutoPostBack="true">
                                        <asp:ListItem Selected="True" Value="SingleDate">Single Date</asp:ListItem>
                                        <%--<asp:ListItem Value="MultipleDate">Multiple Date</asp:ListItem>--%>
                                    </asp:RadioButtonList>
                                </div>

                            </div>
                            <div class="col-lg-6 " style="display: flex; justify-content: flex-start">
                                
                                    <label class="form-label" for="rblEmpType">Employee Type:</label>
                                    <div>
                                        <asp:RadioButtonList runat="server" ID="rblEmpType" RepeatDirection="Horizontal"></asp:RadioButtonList>
                                    </div>
                               

                            </div>


                            <div class="col-lg-6">
                                <label>Company <span class="requerd1">*</span></label>
                                <div>
                                    <asp:DropDownList ID="ddlCompanyList" runat="server" OnSelectedIndexChanged="ddlCompanyList_SelectedIndexChanged" ClientIDMode="Static" AutoPostBack="true" CssClass="form-control select_width">
                                    </asp:DropDownList>
                                </div>


                            </div>

                            <div class="col-lg-6">
                                <label>Department <span class="requerd1">*</span></label>
                                <div>
                                    <asp:DropDownList ID="ddlDepartmentList" runat="server" ClientIDMode="Static" AutoPostBack="true" CssClass="form-control select_width">
                                    </asp:DropDownList>
                                </div>

                            </div>

                            <div class="col-lg-6" runat="server" id="fullSection" visible="true">

                        <label style="margin-top:5px">Date</label>
                        <div class="input-container" >
                            <i class="fas fa-calendar"></i>
                        <asp:TextBox 
                            ID="txtFullAttDate" 
                            runat="server" 
                            ClientIDMode="Static" 
                            CssClass="form-control flatpickr-input DatePicker" 
                            autocomplete="off"
                            placeholder="dd-mm-yyyy">
                        </asp:TextBox>
                     
                     
                        </div>




                                <%--                                <label>Full Section</label>
                                <div>
                                    <asp:TextBox ID="txtFullAttDate" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width" autocomplete="off" PlaceHolder="Click For Calendar" Style="margin-left: 10px"></asp:TextBox>
                                    <asp:CalendarExtender ID="CExtApplicationDate" runat="server" Enabled="True" Format="dd-MM-yyyy" PopupButtonID="imgAttendanceDate" TargetControlID="txtFullAttDate">
                                    </asp:CalendarExtender>--%>

                                    <span id="spnFullToDate" runat="server" visible="false">To Date </span>
                                    <asp:TextBox ID="txtFullToDate" Visible="false" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width" autocomplete="off" PlaceHolder="Click For Calendar" Width="174px" Style="margin-left: 26px"></asp:TextBox>
                                    </p>
                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="dd-MM-yyyy" PopupButtonID="imgAttendanceDate" TargetControlID="txtFullToDate">
                                </asp:CalendarExtender>
                                </div>
                            </div>

                            <div class="row" runat="server" id="partialSection" visible="false">
                                <div>
                                    <div class="col-lg-6 " style="margin-top:5px">
                                        <label>Card No</label>
                                            <asp:TextBox ID="txtCardNo" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width_import" autocomplete="off" PLaceHolder="Type Card No"></asp:TextBox>
                                    </div>
                                
                                    <div class="col-lg-6" style="margin-top:5px">
                                        <label>Date</label>

                                        <div class="input-container">
                                            <i class="fas fa-calendar"></i>
                                            <asp:TextBox
                                                ID="txtPartialAttDate"
                                                runat="server"
                                                ClientIDMode="Static"
                                                CssClass="form-control flatpickr-input DatePicker"
                                                autocomplete="off"
                                                placeholder="dd-mm-yyyy">
                                         </asp:TextBox>


                                        </div>


                                    </div>


                                    <div style="display: none">
                                        <asp:CalendarExtender ID="txtPartialAttDate_CalendarExtender" runat="server" Format="dd-MM-yyyy" TargetControlID="txtPartialAttDate">
                                        </asp:CalendarExtender>

                                        <asp:TextBox ID="txtPartialToDate" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width_import" autocomplete="off" PLaceHolder="Click For Calendar"></asp:TextBox>
                                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd-MM-yyyy" TargetControlID="txtPartialToDate">
                                        </asp:CalendarExtender>
                                    </div>


                                </div>
                            </div>

                        <div class="col-lg-6">

                              <asp:Button ID="btnImport" runat="server" Style="float: left;" CssClass="Mbutton
                                  
                                  " Text="Process" OnClick="btnImport_Click" />
                        </div>



                        <p>

                        <p>
                        </p>

                        <div>
                            <center>
                                    <table>


                                            <tr runat="server" id="trImportFrom">
                                            <td class="caption">Import From </td>
                                            <td class="caption">:</td>
                                            <td>
                                      <asp:RadioButtonList  ForeColor="blue" Style="font-size:13px" Font-Bold="true" ID="rblImportFrom" runat="server" ClientIDMode="Static" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rblImportFrom_SelectedIndexChanged" >
                                        <asp:ListItem Selected="True" Value="sql">Sql DB</asp:ListItem>
                                        <asp:ListItem Value="access">Access DB</asp:ListItem>
                                    </asp:RadioButtonList> 
                                            </td>
                                         
                                        </tr>
                                    </table>
                                      
                                    
                                    
                                                            
                                </center>

                        </div>
                        <br />
                        <div class="import_data_header" style="display:none">
                            <div style="width: 80%; margin: 0px auto">
                                <table class="selectionBox">
                                    <tr>
                                        <td id="tdSelectFile" runat="server" visible="true">Select File<span class="requerd1">*</span>
                                        </td>
                                        <td id="tdFileUpload" runat="server" visible="true">
                                            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="fileUpload" />
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </div>

                           <div class="dataTables_wrapper">
                    <asp:GridView ID="gvAttendance" runat="server" AllowPaging="True" Style="font-size: 13px" AutoGenerateColumns="False" DataKeyNames="EmpCardNo" CellPadding="4" ForeColor="#333333" Height="13px" PageSize="1500" Width="100%" OnPageIndexChanging="gvAttendance_PageIndexChanging" OnRowDataBound="gvAttendance_RowDataBound">
                        <PagerStyle CssClass="gridview" Height="20px" />
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>

                            <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hideSubId" runat="server"
                                        Value='<%# DataBinder.Eval(Container.DataItem, "EmpCardNo")%>' />
                                    <%# Container.DataItemIndex+1%>
                                </ItemTemplate>

                                <ItemStyle HorizontalAlign="Center" ForeColor="green" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderText="Card No">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmpCode" runat="server" Text='<%# Eval("EmpCardNo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("EmpName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Department">
                                <ItemTemplate>
                                    <asp:Label ID="lblDptName" runat="server" Text='<%# Eval("DptName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--   <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Designation">
                                <ItemTemplate>
                                    <asp:Label ID="lblDsgName" runat="server" Text='<%# Eval("DsgName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Emp Type">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmpType" runat="server" Text='<%# Eval("EmpType") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Duty Type">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmpDutyType" runat="server" Text='<%# Eval("EmpDutyType") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Weekend Type">
                                <ItemTemplate>
                                    <asp:Label ID="lblWeekendType" runat="server" Text='<%# Eval("WeekendType") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="MC">
                                <ItemTemplate>
                                    <asp:Label ID="lblProcessType" runat="server" Text='<%# Eval("AttManual") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblATTDate" runat="server" Text='<%# Eval("AttDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Shift Info">
                                <ItemTemplate>
                                    <asp:Label ID="lblSftInfo" runat="server" Text='<%# Eval("SftInfo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="In Time" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblIntime" ForeColor="Green" Font-Bold="true" runat="server" Text='<%# Eval("Intime") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Out Time" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label Font-Bold="true" ID="lblOuttime" ForeColor="Red" runat="server" Text='<%# Eval("Outtime") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblATTStatus" runat="server" Text='<%# Eval("ATTStatus") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#27235C" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                    <ul runat="server" id="ulAttMissingLog" visible="false">
                        <li><a target="_blank" href="attendance_missing_log.aspx">attendance missing log</a></li>
                    </ul>
                </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <div class="import_data_footer">

                    <div class="import_data_footer_right" style="height: 30px;">
                        <asp:Label ID="lblErrorMessage" runat="server" ClientIDMode="Static" ForeColor="Red" Text=""></asp:Label>
                    </div>

                </div>


             



            </div>
        </div>
    </div>


    <%--<div class="import_middle">
                            <p>
                                <asp:RadioButton ID="RadioButton1" runat="server"></asp:RadioButton>
                                Full Import
                            </p>
                            <p>
                                <asp:Button ID="Button2" runat="server" Text="Button"/>
                                <asp:RadioButton ID="RadioButton2" runat="server"></asp:RadioButton>
                                Partial Import.
                            </p>
                        </div>--%>
    <%--<div class="import_bottom">
                            
                            <asp:ListBox ID="ListBox1" Width="546" Height="120" runat="server"></asp:ListBox>
                        </div>--%>
    <%--                 </div>
                    
                </div>
            </div>--%>





    <script type="text/javascript">
        function InputValidationBasket() {
            try {

                if ($('#FileUpload1').val().trim().length == 0) {
                    alert('Please select access database file !');
                    $('#FileUpload1').focus();
                    return true;
                }

                if ($('#rblImportType input:checked').val().trim() == "FullImport") {
                    if ($('#txtFullAttDate').val().trim().length == 0) {
                        showMessage('Please select date for full attendance import', 'error');
                        $('#txtFullAttDate').focus(); return false;
                    }
                }
                else {
                    if ($('#txtCardNo').val().trim().length < 4) {
                        showMessage('Please type valid card no', 'error');
                        $('#txtCardNo').focus(); return false;
                    }

                    if ($('#txtPartialAttDate').val().trim().length == 0) {
                        showMessage('Please select date for partial attendance import', 'error');
                        $('#txtPartialAttDate').focus(); return false;
                    }
                }


            }
            catch (exception) {
                showMessage(exception, error)
            }
        }

        function ClearInputBox() {
            try {
                $('#txtCardNo').val('');
                $('#txtFullAttDate').val('');
                $('#txtPartialAttDate').val('');

                $('#ddlDivisionName').val('0');
                $('#ddlShiftName').val('0');

            }
            catch (exception) {
                showMessage(exception, error)
            }
        }

        function alertMessage() {

            setTimeout(function () {
                $('#lblErrorMessage').fadeOut("slow", function () {
                    $('#lblErrorMessage').remove();
                    $('#lblErrorMessage').val('');
                });

            }, 3000);
        }

    </script>

  
   
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
</asp:Content>
