<%@ Page Title="" Language="C#" MasterPageFile="~/payroll_nested.master" AutoEventWireup="true" CodeBehind="IncrementEntitleReport.aspx.cs" Inherits="SigmaERP.payroll.salary.IncrementEntitleReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        #ContentPlaceHolder1_ContentPlaceHolder1_gvEmplye th{
            background-color:#198754 !important;
            color:white;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManger1" runat="Server" EnablePageMethods="false"></asp:ScriptManager>
    <div class="row justify-content-center mt-2">
        <div class="col-lg-6">
            <div class="row">
                 <div class="col-md-4">
            <div class="card">
                 <asp:DropDownList runat="server" ID="ddlEmpCard" CssClass="form-control">
                <asp:ListItem>Select One</asp:ListItem>
                <asp:ListItem>hhhhhhdfjhs</asp:ListItem>
                <asp:ListItem>rtyuihghajk</asp:ListItem>
                <asp:ListItem>Sncadshar</asp:ListItem>
              </asp:DropDownList>
            </div>
           
        </div>
       
         <div class="col-md-4">
               <div class="card">
                     <asp:DropDownList CssClass="form-control" runat="server" ID="ddlDepartment"></asp:DropDownList>
                </div>
          </div>
        
          <div class="col-md-4">
               <div class="card">
                    <asp:TextBox ID="txtDate" runat="server" type="Date"></asp:TextBox>
                </div>
          </div>
      </div>
          <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />        
          <asp:Button runat="server" ID="btnExport" CssClass="btn btn-success" Text="Export" OnClick="btnExport_Click" />        
   </div>
 </div>
      <asp:GridView ID="gvEmplye" runat="server"  CssClass="table mt-3" AutoGenerateColumns="false">
          <Columns>
        <asp:TemplateField HeaderText="SL">
            <ItemTemplate>
                <%# Container.DataItemIndex + 1 %>
            </ItemTemplate>
        </asp:TemplateField>
            <asp:BoundField DataField="empCardNo" HeaderText="EmpCard No" SortExpression="ID" />
            <asp:BoundField DataField="empName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="departmentName" HeaderText="Department Name" SortExpression="DepartmentName" />
            <asp:BoundField DataField="designationName" HeaderText="Designation Name" SortExpression="DesignationName" />
            <asp:BoundField DataField="empJoiningDate" HeaderText="Joining Date" SortExpression="JoiningDate" />
            <asp:BoundField DataField="lastIncrementMonth" HeaderText="LastIncrement Date" SortExpression="LastIncrementDate" />
            <asp:BoundField DataField="preIncrementAmount" HeaderText="LastIcrement Amount" SortExpression="LastIcrementAmount" />
            <asp:BoundField DataField="empPresentSalary" HeaderText="Current Salary" SortExpression="CurrentSalary" />
    </Columns>
      </asp:GridView>
</asp:Content>
