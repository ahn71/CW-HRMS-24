<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="leaveYearlySummaryReport.aspx.cs" Inherits="SigmaERP.hrms.Leave.leaveYearlySummaryReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <style>
        #ContentPlaceHolder1_MainContent_trForCompanyList {
            height:50px;
        }
        #ContentPlaceHolder1_MainContent_tblGenerateType td:nth-child(2), td:nth-child(4) {
            width:40%;
        }
        .alginment {
            margin-top: 15px;
            margin-left: auto;
         }
        body{
            color:black !important;
        }
        .lstdata option{
            padding: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>   
     <asp:UpdatePanel ID="uplMessage" runat="server">
        <ContentTemplate>
            <p class="message" id="lblMessage" clientidmode="Static" runat="server"></p>
        </ContentTemplate>
    </asp:UpdatePanel>
    <main class="main-content">
        <div class="Dashbord">
            <div class="crm mb-25">
                <div class="container-fulid">
                    <div class="card card-Vertical card-default card-md mt-4 mb-4">
                        <div class="card-header d-flex align-items-center">
                            <div class="card-title d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <h4>Leave Summery Report</h4>
                                </div>

                            </div>
                        </div>
                        <div class="main_box_body_leave Lbody">
                            <div class="main_box_content_leave">
                                <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlCompanyName" />
                                        <asp:AsyncPostBackTrigger ControlID="chkForAllCompany" />
                                        <asp:AsyncPostBackTrigger ControlID="lnkNew" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <div class="bonus_generation" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; width: 80%; margin: 0px auto; padding:20px">
                                            <h1 runat="server" visible="false" id="WarningMessage" style="color: red; text-align: center"></h1>
                                            <table runat="server" visible="true" id="tblGenerateType" class="division_table_leave1" style="margin: 0px auto">
                                                <tr id="trForCompanyList" runat="server">
                                                    <td>Company</td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlCompanyName" runat="server" ClientIDMode="Static" CssClass="form-control select_width" Width="96%" AutoPostBack="True" OnSelectedIndexChanged="ddlCompanyName_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>Employee Type</td>
                                                    <td>
                                                        <asp:CheckBox ID="chkForAllCompany" Visible="false" runat="server" Text="For All Companies" AutoPostBack="True" />
                                                        <asp:RadioButtonList runat="server" ID="rblEmpType" AutoPostBack="true" RepeatDirection="Horizontal">
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>

                                                <tr>
                                                    <td>Year     &nbsp;</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlYear" ClientIDMode="Static" CssClass="form-control select_width" Width="96%"></asp:DropDownList>
                                                    </td>
                                                    <td>&nbsp;   Card No.  &nbsp;</td>
                                                    <td>
                                                        <asp:TextBox ID="txtCardNo" runat="server" PlaceHolder="For Individual" ClientIDMode="Static" CssClass="form-control text_box_width_import" Width="96%"></asp:TextBox>

                                                    </td>
                                                    <td>
                                                        <asp:LinkButton runat="server" Text="New" ID="lnkNew" ClientIDMode="Static" OnClientClick="return ClearCardNo();"></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <center>
                          <asp:CheckBox runat="server" ID="ckbIndividualDetails"  Text="Individual Details"/>
                     </center>
                                             <div id="workerlist" runat="server" class="id_card" style="background-color: white; width: 99%;">
                                            <div class="id_card_left EilistL">
                                                <asp:ListBox ID="lstAll" runat="server" CssClass="lstdata EilistCec p-2" SelectionMode="Multiple"></asp:ListBox>
                                            </div>
                                            <div class="id_card_center EilistC">
                                                <table style="margin-top: 0px;" class="employee_table">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnAddItem" Class="arrow_button" runat="server" Text=">" OnClick="btnAddItem_Click" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnAddAllItem" Class="arrow_button" runat="server" Text=">>" OnClick="btnAddAllItem_Click" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnRemoveItem" Class="arrow_button" runat="server" Text="<" OnClick="btnRemoveItem_Click" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnRemoveAllItem" Class="arrow_button" runat="server" Text="<<" OnClick="btnRemoveAllItem_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="id_card_right EilistR">
                                                <asp:ListBox ID="lstSelected" SelectionMode="Multiple" CssClass="lstdata EilistCec" ClientIDMode="Static" runat="server"></asp:ListBox>
                                            </div>
                                        </div>
                                            <asp:Button ID="btnPreview" runat="server" CssClass="btn btn-primary btn-default btn-squared px-30 alginment" Text="Preview" OnClientClick="return InputValidationBasket();" OnClick="btnPreview_Click" />
                                        </div>
                                       
                                        <div class="payroll_generation_button">
                                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                <ProgressTemplate>

                                                    <span style="font-family: 'Times New Roman'; font-size: 20px; color: green; font-weight: bold; width: 139px; float: left">
                                                        <asp:Label runat="server" ID="lblProcess" Text="wait processing"></asp:Label>
                                                        <img style="width: 26px; height: 24px; cursor: pointer; margin-right: -56px" src="/images/wait.gif" />
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>

                                            
                                           
                                        </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
     <script type="text/javascript">
        function InputValidationBasket() {
            try {
                //if ($('#').val().trim().length == 0) {
                //    showMessage('Please select To Date!', 'warning');
                //    $('#txtToDate').focus(); return false;
                //}
                //if ($('#txtFromDate').val().trim().length == 0) {
                //    showMessage('Please select From Date!', 'warning');
                //    $('#txtFromDate').focus(); return false;
                //}
                //if ($('#txtToDate').val().trim().length == 0) {
                //    showMessage('Please select To Date!', 'warning');
                //    $('#txtToDate').focus(); return false;
                //}
                //if (validatecombo('ddlShiftName', '0', 'Please Select Shift Name!') == false) return false;
                if ($('#txtCardNo').val().trim().length == 0)
                {
                    if (validatecombo('ddlShiftName', '0', 'Please Select Shift Name!') == false) return false;
                }
                return true;
            }
            catch (exception) {
                showMessage(exception, error)
            }
        }
        function CloseWindowt() {
            window.close();
        }
        function ClearCardNo()
        {
            $("#txtCardNo").val("");
            $("#txtCardNo").focus();          
            
        }
            function goToNewTabandWindow(url) {
                window.open(url);

            }

            function getSalaryMonth() {

                var val = document.getElementById('ddlMonthID').value;
                document.getElementById('txtMonthId').value = val;

            }

            function CloseWindowt() {
                window.close();
            }

            function goToNewTabandWindow(url) {
                window.open(url);
            
            }
    </script>

</asp:Content>
