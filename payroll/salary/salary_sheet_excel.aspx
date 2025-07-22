<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="salary_sheet_excel.aspx.cs" Inherits="SigmaERP.payroll.salary.salary_sheet_excel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
    <div class="container">
        <form id="form1" runat="server">
    <style>
        .flex-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 15px;
        }

        .flex-container label {
            min-width: 150px;
            font-weight: bold;
        }

        .flex-item {
            display: flex;
            align-items: center;
            width: 48%;
        }

        .flex-item input {
            flex: 1;
            padding: 5px;
            font-size: 14px;
        }
    </style>

            <div class="flex-container">
                <div runat="server" id="bankContainer">
                <div class="row">
               

         
                    <div class="col-lg-3 mb-3">
                        <label for="txtLetterRef" class="form-label">Letter Ref:</label>
                        <asp:TextBox ID="txtLetterRef" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-lg-3 mb-3">
                        <label for="txtDate" class="form-label">Date:</label>
                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div class="col-lg-3 mb-3">
                        <label for="txtBankName" class="form-label">Bank Name:</label>
                        <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-lg-3 mb-3">
                        <label for="txtBranch" class="form-label">Branch:</label>
                        <asp:TextBox ID="txtBranch" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-lg-3 mb-3">
                        <label for="txtMonth" class="form-label">Month Name:</label>
                        <asp:TextBox ID="txtMonth" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-lg-3 mb-3">
                        <label for="txtAccountNo" class="form-label">Debit Account No:</label>
                        <asp:TextBox ID="txtAccountNo" runat="server" CssClass="form-control" />
                    </div>
                     </div>
                </div>
                <div id="bkashContainer" runat="server" visible="false" style=" margin: 10px;">
                        <h4>
                            <asp:Label ID="lblCompanyName" runat="server" Text=""></asp:Label></h4>
                        
                            <asp:Label ID="lblBkashWallet" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="col-lg-3 mb-3">
                        <asp:Button runat="server" Style="margin-top: 30px;" ID="btnExport" CssClass="btn btn-success" Text="Export" OnClick="btnExport_Click" />
                    </div>
            </div>

       


    <asp:GridView runat="server" ID="gvSalarySheetExcel" HeaderStyle-BackColor="#750000"
        HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" HeaderStyle-Height="25px"
        HeaderStyle-Font-Size="14px" Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="SL">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</form>

    </div>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
