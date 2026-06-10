<%@ Page Title="" Language="C#" MasterPageFile="~/payroll_nested.master" AutoEventWireup="true" CodeBehind="HolidayAllowanceSheet.aspx.cs" Inherits="SigmaERP.payroll.salary.HolidayAllowanceSheet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="scr1"></asp:ScriptManager>

 <asp:DropDownList runat="server" ID="ddlCompany"></asp:DropDownList>

    <asp:DropDownList runat="server" ID="ddlYearMonth"></asp:DropDownList>

    <asp:DropDownList runat="server" ID="ddlEmployeeList"></asp:DropDownList>

    <asp:DropDownList runat="server" ID="ddlDepartmentList"></asp:DropDownList>
    <asp:DropDownList runat="server" ID="ddlemolpyeType">
        <asp:ListItem Value="1">
            Worker
        </asp:ListItem>
                <asp:ListItem Value="2">
            Staff
        </asp:ListItem>
    </asp:DropDownList>

      <asp:Button  runat="server" ID="btnPreView" Text="Preview"  OnClick="btnPreView_Click"/>


     <script type="text/javascript">
        $(document).keyup(function (e) {
            if (e.keyCode == 80) {
                goToNewTabandWindow('/payroll/salary_sheet_Report.aspx');
            }
        });
        function InputValidationBasket() {
            try {

                if ($('#txtEmpCardNo').val().trim().length < 4) {
                    showMessage('Please select To Date', 'error');
                    $('#txtToDate').focus(); return true;
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
