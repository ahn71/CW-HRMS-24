<%@ Page Title="Bank entry form" Language="C#" MasterPageFile="~/hrd_nested.master" AutoEventWireup="true" Debug="true" CodeBehind="bank_entry_panel.aspx.cs" Inherits="SigmaERP.hrd.bank_entry_panel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
<div class="row">
    <div class="col-md-3">
        <label runat="server" id="lblcompany">Company Name</label>
         <asp:DropDownList runat="server" ID="ddlCompany" CssClass="form-control"></asp:DropDownList>
    </div>
   
    <div class="col-md-3">
        <label runat="server" id="lblbnkname">Bank name</label>
        <asp:TextBox runat="server" ID="txtbankName" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="col-md-3">
        <label runat="server" id="lblbankshortname">Bank short name</label>
        <asp:TextBox runat="server" ID="txtbankshortname" CssClass="form-control"></asp:TextBox>
    </div>
    <div class="col-md-3">
        <label runat="server" id="lblAccountname">Bank Account</label>
        <asp:TextBox runat="server" ID="txtBankacount" CssClass="form-control"></asp:TextBox>
    </div>

   <div class="col-md-3" style="margin-top:10px;">
            <label runat="server" id="lblcheckpayer" style="opacity:0"></label>
            <asp:CheckBox runat="server" ID="chkIspayer" Text="IsPayer" OnCheckedChanged="chkIspayer_CheckedChanged"/>
             <label runat="server" id="lblbutton" style="opacity:0"></label>
           <asp:Button runat="server" ID="btnSave" OnClick="btnSave_Click" CssClass="btn btn-success" Text="Save"/>
      </div>

</div>
  
 <asp:Gridview runat="server" ID="gvbanklist">
     <column>

     </column>
</asp:Gridview>
</asp:Content>
