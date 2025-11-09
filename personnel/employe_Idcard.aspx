<%@ Page Title="" Language="C#" MasterPageFile="~/personnel_NestedMaster.master" AutoEventWireup="true" CodeBehind="employe_Idcard.aspx.cs" Inherits="SigmaERP.personnel.employe_Idcard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        <style>
        @media print {
    * {
        margin: 0 !important;
        padding: 0 !important;
        -webkit-print-color-adjust: exact !important; /* For WebKit browsers */
        print-color-adjust: exact !important; /* Standard property */
    }

    @page {
        margin: 20px; /* Removes the default margin */
    }

    .print-btn{
        display:none;
    }

    body {
        margin: 0;
        padding: 0;
    }

       .header_top{
            display:none;
        }
       .footer{
           display:none;
       }
        .id-card {
            width: 154px;
            height: 254px !important;
            background-color: white  !important;
            border-radius: 10px  !important;
            overflow: hidden  !important;
            border:1px solid #ddd !important;
            /*box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);*/
        }
        .header {
            background-color: white  !important;
            padding: 10px 0  !important;
            text-align: center  !important;
        }
        .logo {
            max-width: 90px  !important;
            margin: 0 auto  !important;
        }
        .photo-container {
            display: flex  !important;
            justify-content: center  !important;
            margin: 15px 0  !important;
        }
          .photo {
            width: 55px  !important;
            height: 68px  !important;
            border: 1px solid blue  !important;
            object-fit: cover  !important;
            margin-top: -8px  !important;
        }
        .details {
            padding: 0px  !important;
            text-align: center  !important;
        }
        .name {
            color: #0066b3  !important;
            font-size: 10px  !important;
            margin-bottom: 5px  !important;
            font-weight: bold  !important;
        }
        .designation {
            color: #333  !important;
            font-size: 10px  !important;
            margin-bottom: 8px  !important;
        }
        .info {
            text-align: left  !important;
            margin-bottom: 3px  !important;
            padding-left: 20px  !important;
        }
        .info-item {
            margin-bottom: 0px  !important;
            font-size: 9px  !important;
        }
        .ft{
            /*background-color:#0066b3  !important;*/
            /*color:white  !important;*/
            text-align:center  !important;
            font-size:8px  !important;
            /*margin-top: 17px !important;*/    
        }
    .company-name {
    font-size: 8px  !important;
    font-weight: bold  !important;
    text-align: center  !important;
    margin-top: 13px  !important;
    margin-bottom: 13px  !important;
}
                .address {
            text-align: center  !important;
            padding: 0 10px  !important;
            margin-bottom: 10px  !important;
            font-size:12px  !important;
             
        }
        .address-title {
            font-weight: bold  !important;
            margin-bottom: 5px  !important;
        }
        .signature-section {
            text-align: center  !important;
            margin-top: 10px  !important;
            margin-bottom: 20px  !important;
        }
        .signature-line {
            width: 120px  !important;
            height: 20px  !important;
            border-bottom: 1px solid #000  !important;
            margin: 0 auto  !important;
        }
        .signature-text {
            width: 100%  !important;
            text-align: center  !important;
            font-size: 8px  !important;
        }
        .qr-code {
            text-align: center  !important;
        }
        .card-property {
            color: #0066b3  !important;
            text-align: center  !important;
            font-style: italic  !important;
            font-size: 8px  !important;
            margin-top: 10px  !important;
            font-weight: bold  !important;
        }
        .backside_card{
            height: 254px  !important;
            margin-top:10px  !important;
             width: 154px  !important;
            background-color: white  !important;
            border-radius: 10px  !important;
            overflow: hidden  !important;
                 border:1px solid #ddd !important;
            /*box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);*/
        }
        p {
    font-size: 8px  !important;
    margin: 0 !important;
}
}


        /*main*/
     
        .id-card {
            width: 154px;
            height: 254px !important;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .header {
            background-color: white;
            padding: 10px 0;
            text-align: center;
        }
        .logo {
            max-width: 90px;
            margin: 0 auto;
        }
        .photo-container {
            display: flex;
            justify-content: center;
            margin: 15px 0;
        }
          .photo {
            width: 55px;
            height: 68px;
            border: 1px solid blue;
            object-fit: cover;
            margin-top: -8px;
        }
        .details {
            padding: 0px;
            text-align: center;
        }
        .name {
            color: #0066b3;
            font-size: 10px;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .designation {
            color: #333;
            font-size: 10px;
            margin-bottom: 8px;
        }
        .info {
            text-align: left;
            margin-bottom: 3px;
            padding-left: 20px;
        }
        .info-item {
            margin-bottom: 0px;
            font-size: 9px;
        }
        .ft{
            /*background-color:#0066b3  !important;*/
            /*color:white  !important;*/
            text-align:center  !important;
            font-size:8px;
            /*margin-top: 17px !important;*/    
        }
    .company-name {
    font-size: 8px;
    font-weight: bold;
    text-align: center;
    margin-top: 13px;
    margin-bottom: 13px;
}
                .address {
            text-align: center;
            padding: 0 10px;
            margin-bottom: 10px;
            font-size:12px;
             
        }
        .address-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .signature-section {
            text-align: center;
            margin-top: 10px;
            margin-bottom: 20px;
        }
        .signature-line {
            width: 120px;
            height: 20px;
            border-bottom: 1px solid #000;
            margin: 0 auto;
        }
        .signature-text {
            width: 100%;
            text-align: center;
            font-size: 8px;
        }
        .qr-code {
            text-align: center;
        }
        .card-property {
            color: #0066b3;
            text-align: center;
            font-style: italic;
            font-size: 8px;
            margin-top: 10px;
            font-weight: bold;
        }
        .backside_card{
            height: 254px;
            margin-top:10px;
             width: 154px;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        p {
    font-size: 8px;
    margin: 0 !important;
}
    </style>
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
