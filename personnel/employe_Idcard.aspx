<%@ Page Title="" Language="C#" MasterPageFile="~/personnel_NestedMaster.master" AutoEventWireup="true" CodeBehind="employe_Idcard.aspx.cs" Inherits="SigmaERP.personnel.employe_Idcard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
           
          
           
             
        }
        .wrapperx{
            font-family: SutonnyMJ, sans-serif;
              font-weight: bold;
            font-size: 28px;
            background-color: #f5f5f5;
            padding: 20px;
        }
        
        /* ID card wrapper */
        .id-card-wrapper {
            /* display: flex; */
            gap: 20px;
            margin-bottom: 25px;
            font-weight: bold;
            font-size: 28px;
            /* justify-content: center; */
         
        }

        /* ID card common styles */
        .id-card {
            width: 2in;
            height: 3.10in;
            border: 1px solid #000;
            padding: 0px;
            box-sizing: border-box;
            background-color: white;
            margin-bottom: 10px;
        }

        .id-card-back {
            padding: 15px;
            font-size: 18px;
        }

        /* Header images */
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }

        /* Footer signature */
        .footasr {
            display: flex;
            justify-content: space-around;
            margin-top: 0px;
            font-size: 13px;
        }

        .footasr div {
            text-align: center;
        }

        .footasr div div {
            border-top: 1px solid #000;
            width: 86px;
            margin: auto;
            color: #4e587e;
        }
        
        /* Table styles */
        .id-card-table {
            width: 100%;
            font-size: 14px;
            border-collapse: collapse;
        }
        
.id-card-table td {
    padding: 1px 2px;
    color: #4e587e;
    font-size: 13px !important;
}
        
        .id-card-table td:first-child {
            width: 45%;
            color: #305991;
            font-size: 18px;
        }
        .id-card-back .id-card-table tr td{
            font-size: 13px !important;
            color: #000 !important;
        }
               .grid-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr); 
            gap: 10px;
            width: 100%;
             box-sizing: border-box;
             height: 100vh;
           
        }
        /* Print-specific styles */
        @media print {
            * {
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
                color-adjust: exact !important;
            }
            
            body {
                background-color: white;
                padding: 1px !important;
                margin: 1px !important;
            }
            
            .no-print {
                display: none !important;
            }
            
            .print-btn {
                display: none;
            }
            .header_top_area{
                display:none;
            }
            
            @page {
                margin: 10px;
                size: auto;
            }
            
            .id-card-wrapper {
                page-break-inside: avoid;
                break-inside: avoid;
                margin: 0;
                gap: 10px;
            }
            
            .id-card {
                box-shadow: none;
                border: 1px solid #000;
            }
        }
        
        /* Print button styling */
        .print-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #305991;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            z-index: 1000;
        }
        
        .print-btn:hover {
            background-color: #1f4267;
        }
          .wrapper {
        max-width: 100%;
        
        
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
