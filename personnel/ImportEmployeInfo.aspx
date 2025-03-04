<%@ Page Title="" Language="C#" MasterPageFile="~/personnel_NestedMaster.master" AutoEventWireup="true" CodeBehind="ImportEmployeInfo.aspx.cs" Inherits="SigmaERP.personnel.ImportEmployeInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .healder{
            width:100%;
           height:30px;
           background-color:#9E1313;
        }
        th {
    background: #750000;
    color: white;
}
        table#ContentPlaceHolder1_MainContent_gvemployeList {
    margin-top: 15px;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager runat="server" ID="scr1"></asp:ScriptManager>
    <asp:UpdatePanel ID="uplMessage" runat="server">
        <ContentTemplate>
            <p class="message" id="lblMessage" clientidmode="Static" runat="server"></p>
        </ContentTemplate>
    </asp:UpdatePanel>
      <div class="row Rrow">
        <div class="ds_nagevation_bar">
            <ul>
                <li><a href="/default.aspx">Dashboard</a></li>
                <li> <a href="#">/</a></li>
                 <li> <a href="<%= Session["__topMenuForPersonnel__"] %>">Personnel</a></li>
                <li> <a href="#">/</a></li>
                <li> <a href="#" class="ds_negevation_inactive Ptactive">Employes Excel Import</a></li>
            </ul>               
        </div>
       </div>
    <div class="healder">

    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlBranch" />
            <asp:PostBackTrigger ControlID="btnImport" />
            <asp:PostBackTrigger ControlID="btnExport" />

        </Triggers>
        <ContentTemplate>
            <asp:HiddenField ID="hdfCardnoDigits" Value="0" runat="server" ClientIDMode="Static" />
            <asp:HiddenField ID="hdfCardnoDigitsSet" Value="0" runat="server" ClientIDMode="Static" />

            <div class="container">
                       <div class="row">
                           <div class="col-lg-2"></div>
                <div class="col-lg-4">
                    <label>Company:</label>
                    <asp:DropDownList ID="ddlBranch" ClientIDMode="Static" CssClass="form-control select_width" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="col-lg-2">
                    <label style="margin-top:5px;">Excel File:</label>
          
                    <asp:FileUpload ID="fuEmployeesData" runat="server" CssClass="fileUpload" />
                </div>
                <div class="col-lg-2">
                    <label style="opacity:0">Button</label><br />
             
                    <asp:Button style="margin-right:20px;" ID="btnImport" CssClass="css_btn Ptbut" ClientIDMode="Static" runat="server" Text="Import" OnClick="btnImport_Click" />

                    <%--OnClientClick="return InputValidationImport();"  --%>
                </div>

            </div>
            </div>
         <asp:GridView runat="server" ID="gvemployeList" CssClass="table">

         </asp:GridView>
            <asp:Button runat="server" ID="btnExport"  Text="EXPORT" CssClass="btn btn-primary"  OnClick="btnExport_Click"/>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
