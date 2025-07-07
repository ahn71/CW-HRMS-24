<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="id_card.aspx.cs" Inherits="SigmaERP.hrms.personnel.id_card" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ID Card</title>
    <%--<link rel="stylesheet" href="style.css">--%>

    <style>
        body {
            font-family: 'Kalpurush', sans-serif;
            background: #f5f5f5;
            padding: 20px;
           
        }

        
            .id-card {
                display: flex;
                width: 500px;
                margin: auto;
                background: #fff;
                 height: 381px;
            }



        .left-section{
            width: 50%;
            padding: 10px 15px;
            box-sizing: border-box;
            border:1px solid #333;
        }
        .right-section {
             width: 50%;
            padding: 10px 15px;
            box-sizing: border-box;
            border:1px solid #333;
        }

        .left-section {
            border-right: 1px solid #000;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            width: 60px;
            height: auto;
        }

       .photo {
            width: 67px;
            height: 73px;
            border: 1px solid #000;
            object-fit: cover;
        }

        h2, h3 {
            text-align: center;
            margin: 5px 0;
        }

        .info p, .right-section p {
            font-size: 14px;
            margin: 4px 0;
        }

        .sign {
            display:flex;
            justify-content:space-between;
            margin-top: 24px;
            text-align: center;
        }

        .factory-address {
            color: blue;
            font-size: 16px;
            margin-top: -12px;
            text-align:center;
        }
        .idenity{
            text-align:center;
            border-bottom:1px solid #333;
            margin-top: -17px;
        }


    </style>
</head>
<body>
<div class="id-card">
    <div class="left-section">
        <div class="header">
            <img src="logo.png" alt="Logo" class="logo">
            <img src="person.jpg" alt="Person" class="photo">
        </div>
        <h4 style="text-align:center; margin-top:0px; color:#4c9bd4;">এবি.আর স্পিনিং মিলস্ লিঃ</h4>
        <h2 class="idenity" style="color:#215869;">পরিচয়পত্র</h2>
        <div class="info">
            <p style="color:#4c567a;" ><strong>আইডি নং: 300003 </strong></p>
            <p><strong>শ্রমিকের নাম: মোঃ শাহানুর হোসেন</strong> </p>
            <p><strong>পদবী: ২য় ইন্সপিরেশন  </strong></p>
            <p><strong>বিভাগ/শাখা: রিং  </strong></p>
            <p><strong>যোগদানের তারিখ: ০৩-১০-২০২৩ ইং  </strong></p>
            <p><strong>ইস্যুর তারিখ:০৩-১০-২০২৪ ইং </strong> </p>
        </div> 
        <div class="sign">
            <p>শ্রমিকের স্বাক্ষর</p>
            <p>কর্তৃপক্ষের স্বাক্ষর</p>
        </div>
    </div>

    <div class="right-section">
        <h4 style="margin-top:0px; font-family:Cursive;">If Found Please Return</h4>
        <h4 style="margin-top:-24px;  font-family:Cursive; text-align:center;">This Card To</h4>
        <h5 class="factory-address" style="color:#4c9bd4;">কারখানার ঠিকানা</h5>
        <h5 style="margin-top:-29px;text-align: center; color:#4c9bd4;">গোজাই, মির্জাপুর, টাঙ্গাইল ।</h5>
        <p style="margin-top:-15px;"><strong>মোবাইল নং:</strong> ০১৮৬০-০৩২৩১৮</p>

        <p style="margin-top:2px;"><strong>শ্রমিকের স্থায়ী ঠিকানা</strong></p>
        <p><strong>গ্রাম:</strong> রাজশাহী</p>
        <p><strong>ডাকঘর:</strong> চাঁপাইনবাবগঞ্জ</p>
        <p><strong>উপজেলা:</strong> শিবগঞ্জ</p>
        <p><strong>থানা:</strong> শিবগঞ্জ সদর</p>
        <p><strong>জেলা:</strong> নামো বিনোদপুর</p>
        <p><strong>জরুরী ফোন নম্বর:</strong>০১৭৮৭৬৫২৪৩৭</p>
        <p><strong>জা:পরিঃ পত্র নং</strong> মুসলিম</p>
        <p><strong>রক্তের গ্রুপ:</strong> B+</p>
    </div>
</div>
</body>
</html>

