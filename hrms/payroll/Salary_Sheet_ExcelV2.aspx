<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Salary_Sheet_ExcelV2.aspx.cs" Inherits="SigmaERP.hrms.payroll.Salary_Sheet_ExcelV2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>cw-hrms</title>


    <style>
        .salary-grid {
            width: 100%;
            border-collapse: collapse;
            font-family: Calibri;
            font-size: 13px;
        }

            .salary-grid th {
                background: #0D6EFD;
                color: #fff;
                padding: 8px 6px;
                text-align: center;
                font-weight: 600;
                border: 1px solid #dcdcdc;
                white-space: nowrap;
            }

            .salary-grid td {
                padding: 6px;
                border: 1px solid #e5e5e5;
                text-align: center;
                white-space: nowrap;
            }

            .salary-grid tr:nth-child(even) {
                background: #f8f9fa;
            }

            .salary-grid tr:hover {
                background: #e8f4ff;
            }

        .btn {
            display: inline-block;
            padding: 8px 18px;
            background: #0d6efd;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            font-family: Calibri, Arial, sans-serif;
            cursor: pointer;
            transition: all .3s ease;
            box-shadow: 0 2px 6px rgba(13,110,253,.25);
            text-decoration: none;
            float:right;
        }

            .btn:hover {
                background: #0b5ed7;
                box-shadow: 0 6px 12px rgba(13,110,253,.35);
                transform: translateY(-2px);
            }

            .btn:active {
                transform: scale(0.97);
            }

            .btn:focus {
                outline: none;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3>Salary Sheet</h3>

            <div>
                <asp:Button runat="server" ID="btnExport" CssClass="btn" OnClick="btnExport_Click" Text="Download" />
                <div style="margin-bottom: 10px">
                    Show
   
                    <asp:DropDownList ID="ddlPageSize" runat="server"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">

                        <asp:ListItem Text="15" Value="15" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="25" Value="25"></asp:ListItem>
                        <asp:ListItem Text="50" Value="50"></asp:ListItem>
                        <asp:ListItem Text="100" Value="100"></asp:ListItem>

                    </asp:DropDownList>
                    records per page

                </div>

                <asp:GridView ID="gvSalaryReport" runat="server" CssClass="salary-grid" AutoGenerateColumns="False" AllowPaging="true" PageSize="15" PagerStyle-HorizontalAlign="Center" PagerStyle-CssClass="gridPager" OnPageIndexChanging="gvSalaryReport_PageIndexChanging">

                    <Columns>


                        <asp:TemplateField HeaderText="SL">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle Width="45px" />
                        </asp:TemplateField>

                        <asp:BoundField DataField="ID" HeaderText="ID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="Department" HeaderText="Department" />
                        <asp:BoundField DataField="Designation" HeaderText="Designation" />
                        <asp:BoundField DataField="Gross Salary" HeaderText="Gross Salary" DataFormatString="{0:N2}" HtmlEncode="false" />
                        <asp:BoundField DataField="Absent Count" HeaderText="Absent Count" />
                        <asp:BoundField DataField="OT Extra Duty Count" HeaderText="OT Extra Duty Count" />
                        <asp:BoundField DataField="NTR/ Duty Adjust" HeaderText="NTR/ Duty Adjust" />
                        <asp:BoundField DataField="Deduction (Min)" HeaderText="Deduction (Min)" />
                        <asp:BoundField DataField="OT Days" HeaderText="OT Days" />
                        <asp:BoundField DataField="Deduction/ Loan" HeaderText="Deduction/ Loan" DataFormatString="{0:N2}" HtmlEncode="false" />
                        <asp:BoundField DataField="KPI Achieved" HeaderText="KPI Achieved" />
                        <asp:BoundField DataField="Daily Income" HeaderText="Daily Income" DataFormatString="{0:N2}" HtmlEncode="false" />
                        <asp:BoundField DataField="Per Min Income" HeaderText="Per Min Income" DataFormatString="{0:N2}" HtmlEncode="false" />
                        <asp:BoundField DataField="Total OT Extra Duty Count Amount" HeaderText="OT Extra Duty Amount" DataFormatString="{0:N2}" HtmlEncode="false" />
                        <asp:BoundField DataField="Absent Deduction" HeaderText="Absent Deduction" DataFormatString="{0:N2}" HtmlEncode="false" />
                        <asp:BoundField DataField="Total Deduction Min Amount" HeaderText="Deduction Amount" DataFormatString="{0:N2}" HtmlEncode="false" />
                        <asp:BoundField DataField="Mobile Bill Deduction" HeaderText="Mobile Bill Deduction" DataFormatString="{0:N2}" HtmlEncode="false" />
                        <asp:BoundField DataField="Final Payable Amount" HeaderText="Final Payable Amount" DataFormatString="{0:N2}" HtmlEncode="false" />

                    </Columns>

                </asp:GridView>
            </div>

        </div>
    </form>
</body>
</html>
