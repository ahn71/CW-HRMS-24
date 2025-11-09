<%@ Page Title="" Language="C#" MasterPageFile="~/personnel_NestedMaster.master" AutoEventWireup="true" CodeBehind="employe_Idcard.aspx.cs" Inherits="SigmaERP.personnel.employe_Idcard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
id-card-wrapper {
    font-family: SutonnyMJ, sans-serif;
    font-weight: bold;
    font-size: 28px;
}
/* Print-specific styles */
@media print {
     * {
        
        -webkit-print-color-adjust: exact !important; /* For WebKit browsers */
        print-color-adjust: exact !important; /* Standard property */
    }

      .no-print {
        display: none !important; /* hide everything except ID card */
    }
        .print-btn{
        display:none;
    }
    @page {
       margin: 20px;/* Remove headers/footers */
    }

    .no-print {
        display: none !important; /* Hide buttons/menus in print */
    }

    .id-card-wrapper {
        page-break-inside: avoid; /* Prevent card breaking */
    }
}

/* ID card wrapper */
.id-card-wrapper {
    display: flex;
    gap: 20px;
    margin-bottom: 25px;
    font-weight: bold;
    font-size: 28px;
     font-family: SutonnyMJ, sans-serif;
    font-weight: bold;
    font-size: 28px;
}

/* ID card common styles */
.id-card {
    width: 320px;
    height: 480px;
    border: 1px solid #000;
    padding: 12px;
    box-sizing: border-box;
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
    margin-top: 35px;
    font-size: 15px;
}

.footasr div {
    text-align: center;
}

.footasr div div {
    border-top: 1px solid #000;
    width: 110px;
    margin: auto;
    color: #4e587e;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <asp:ScriptManager runat="server" ID="src1"></asp:ScriptManager>
    <button onclick="window.print()" class="btn btn-primary print-btn">Print</button>
        <asp:Literal ID="ltlEmployeeCards" runat="server"></asp:Literal>


    <div>
<div class='id-card-wrapper'>

    <!-- FRONT SIDE -->
    <div class="id-card">
        <div class="card-header">
            <img src='../EmployeeImages/CompanyLogo/logo.jpeg' style='width:60px; height:60px; object-fit:contain;' />
            <img src='https://localhost:7220/0001/EmployeeImage/' 
                 style='width:85px; height:105px; object-fit:cover; border:1px solid #000;' />
        </div>

        <h2 style='text-align:center; margin:0; font-size:20px; font-weight:bold; color:#82b8e0'>H.we.Avi w¯úwbs wgjm wjt</h2>
        <h3 style='text-align:center; margin:5px 0 12px 0; font-size:26px; font-weight:bold; text-decoration:underline; color:#215868'>cwiPqcÎ</h3>

        <table style='width:100%; font-size:14px; border-collapse:collapse;'>
            <tr><td style='padding:3px 6px; width:40%; color:#305991;font-size:20px'>AvBwW KvW© bs</td><td style='padding:3px 6px; color:#4e587e;font-size:18px'>: 300186</td></tr>
            <tr><td style='padding:3px 6px; color:#4e587e;font-size:18px'>k«wg‡Ki bvg</td><td style='padding:3px 6px; color:#4e587e;font-size:18px'>: bvivqb P›`ª</td></tr>
            <tr><td style='padding:3px 6px; color:#4e587e;font-size:18px'>c`we</td><td style='padding:3px 6px; color:#4e587e;font-size:18px'>: DaŸ©Zb gnve¨e¯’vcK</td></tr>
            <tr><td style='padding:3px 6px; color:#4e587e;font-size:18px'>wefvM/kvLv</td><td style='padding:3px 6px; color:#4e587e;font-size:18px'>: gvbwbwðZKib</td></tr>
            <tr><td style='padding:3px 8px; color:#4e587e;font-size:18px'>‡hvM`v‡bi ZvwiL</td><td style='padding:3px 6px; color:#4e587e;font-size:18px'>: 01-01-2023</td></tr>
            <tr><td style='padding:3px 6px; color:#4e587e;font-size:18px'>Bm¨yi ZvwiL</td><td style='padding:3px 6px; color:#4e587e;font-size:18px'>: 09-11-2025</td></tr>
        </table>

        <div class="footasr">
            <div><div>k«wg‡Ki ¯^v¶i</div></div>
            <div><div>KZ©…c‡¶i ¯^v¶i</div></div>
        </div>
    </div>

    <!-- BACK SIDE -->
    <div class="id-card id-card-back">
        <h3 style='text-align:center; font-size:18px; margin-bottom:3px; font-family:Cursive; color:#1f4267'>If Found Please</h3>
        <h3 style='text-align:center; font-size:18px; margin-bottom:12px; font-family:Cursive; color:#1f4267'>Return This Card To-</h3>

        <p style='text-align:center; font-size:16px; line-height:22px; margin-bottom:15px; color:#82b8e0'>
            কারখানার ঠিকানা <br/>
            গোধার, মির্জাপুর, টাঙ্গাইল।
        </p>

        <p style='font-size:14px; margin-bottom:12px;'>অফিস মোবাইল নং : ০১৮৬০-৩১২৩১৮</p>
        
        <h4 style='font-size:16px; margin-bottom:8px; text-decoration:underline; font-weight:bold'>শ্রমিকের স্থায়ী ঠিকানা</h4>

        <table style='width:100%; font-size:14px; border-collapse:collapse; font-family:SutonnyMJ;'>
            <tr><td style='padding:2px 6px; width:40%;'>গ্রাম</td><td style='padding:2px 6px;'>: </td></tr>
            <tr><td style='padding:2px 6px;'>ডাকঘর</td><td style='padding:2px 6px;'>: </td></tr>
            <tr><td style='padding:2px 6px;'>থানা</td><td style='padding:2px 6px;'>: </td></tr>
            <tr><td style='padding:2px 6px;'>জেলা</td><td style='padding:2px 6px;'>: </td></tr>
        </table>

        <p style='font-size:14px; margin-top:14px;'>জরুরী ফোন নম্বর : </p>
        <p style='font-size:14px;'>জাতি পরিচয় পত্র নং : </p>
        <p style='font-size:14px;'>রক্তের গ্রুপ : </p>
    </div>

</div>
</div>

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
