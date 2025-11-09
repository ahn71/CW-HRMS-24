<%@ Page Title="" Language="C#" MasterPageFile="~/personnel_NestedMaster.master" AutoEventWireup="true" CodeBehind="employe_Idcard.aspx.cs" Inherits="SigmaERP.personnel.employe_Idcard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <asp:ScriptManager runat="server" ID="src1"></asp:ScriptManager>
    <button onclick="window.print()" class="btn btn-primary print-btn">Print</button>
        <asp:Literal ID="ltlEmployeeCards" runat="server"></asp:Literal>
     <%--<div class="id-card">
        <div class="header">
            <img src="/api/placeholder/120/50" alt="Company Logo" class="logo">
        </div>
        <div class="photo-container">
            <img src="/api/placeholder/150/180" alt="Employee Photo" class="photo">
        </div>
        <div class="details">
            <div class="name">Md. Yamin</div>
            <div class="designation">Sales Officer</div>
        </div>
        <div class="info">
            <div class="info-item"><strong>Blood Group:</strong> B+</div>
            <div class="info-item"><strong>Emp. ID No.:</strong> 15-07-84</div>
        </div>
       
         <div class="ft">
               <span>Web: <a href="http://www.rdmilk.com">www.rdmilk.com</a></span>
         </div>
          
      
    </div>
      <div class="backside_card">
            <div class="back-header"></div>
            <div class="company-name">Rangpur Dairy & Food Products Limited</div>
            <div class="address">
                <div class="address-title">Address:</div>
                <div>23, Adarsha Chayaneer, Ring Road,</div>
                <div>Adabor, Dhaka-1207</div>
                <div>Hotline : +88 01987 090829</div>
                <div>E-mail : corporate@rdmilk.com.bd</div>
            </div>
            <div class="signature-section">
                <div class="signature-line">
                    <img src="/api/placeholder/100/30" alt="Signature" style="position: absolute; top: -20px; left: 25px;">
                    <div class="signature-text">Authorized Signature</div>
                </div>
            </div>
            <div class="qr-code">
                <img src="/api/placeholder/100/100" alt="QR Code">
            </div>
            <div class="card-property">
                This card is the property of RDFPL
            </div>
        </div>--%>
</asp:Content>
