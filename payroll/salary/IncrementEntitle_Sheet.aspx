<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IncrementEntitle_Sheet.aspx.cs" Inherits="SigmaERP.payroll.salary.IncrementEntitle_Sheet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap JavaScript Bundle (includes Popper.js) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
           th {
            background: #4c9b4c !important;
            color: white !important;
        }
        tbody, td, tfoot, th, thead, tr {
            border-width: 1px !important;
        }
        td{
            text-align:center !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="m-3">
        <div>
            <div class="d-flex justify-content-between mb-2">
               <h3 runat="server" id="header" class=""></h3>
             <asp:Button runat="server" ID="btnExport" Text="Export" CssClass="btn btn-success" OnClick="btnExport_Click"/>
            </div>
        

            <asp:GridView runat="server" ID="gventitleList" AutoGenerateColumns="false" CssClass="table">
                 <Columns>
              <asp:TemplateField HeaderText="SL">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
             <asp:BoundField DataField="EmpCardNo" HeaderText="Emp. Card" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="EmpName" HeaderText="Name" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="DsgName" HeaderText="Designation" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />

                <asp:BoundField DataField="DptName" HeaderText="Department" />
         
                <asp:BoundField DataField="EmpJoiningDate" HeaderText="Joining Date" DataFormatString="{0:dd-MM-yyyy}" />
                <asp:BoundField DataField="PreBasicSalary" HeaderText="Pre. Basic" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="PreHouseRent" HeaderText="Pre. House Rent" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="PreEmpSalary" HeaderText="Pre. Gross" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                     <asp:BoundField DataField="IncrementType" HeaderText="Increment Type" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>
                <asp:BoundField DataField="IncrementMonth" HeaderText="Increment Month" DataFormatString="{0:MMMM-yyyy}" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />

              <asp:BoundField DataField="CommonIncrementMonth" HeaderText="Increment Month (Common)" DataFormatString="{0:MMMM-yyyy}" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                           
                <asp:BoundField DataField="IncrementAmount" HeaderText="Increment Amount" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                <asp:BoundField DataField="BasicSalary" HeaderText="New Basic" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
               <asp:BoundField DataField="HouseRent" HeaderText="N_HouseRent" Visible="true" 
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="EmpPresentSalary" HeaderText="New Gross" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                 

                 <asp:BoundField DataField="n_EffecctiveMonth" HeaderText="Effective Month" DataFormatString="{0:MMMM-yyyy}" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                           
            
       

            
        </Columns>
            </asp:GridView>

            <asp:GridView runat="server" ClientIDMode="Static" ID="gvPromotionSheet" AutoGenerateColumns="true">                  
            </asp:GridView>
        </div>
    </form>
</body>
</html>
