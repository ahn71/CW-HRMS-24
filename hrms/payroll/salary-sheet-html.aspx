<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="salary-sheet-html.aspx.cs" Inherits="SigmaERP.hrms.payroll.salary_sheet_html" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Salary Sheet</title>

      <style>
    body {
      font-family: Arial, sans-serif;
      font-size: 12px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      table-layout: fixed;
	  border: 2px solid #000;
    }

    th, td {
      border: 2px solid #000;
      padding: 3px;
      text-align: center;
      word-wrap: break-word;
    }

    .text-left {
      text-align: left;
    }

    .print-btn {
      margin: 20px;
    }

    .title, .subtitle, .section-title {
      text-align: center;
      margin: 5px 0;
    }

    .title {
      font-weight: bold;
      font-size: 16px;
    }

    .subtitle {
      font-size: 13px;
    }

    .section-title {
      font-weight: bold;
    }


  .signature-footer {
    width: 100%;
    display:flex;
    justify-content:space-between;
    align-items:center;
  }



@media print {
    .page-break {
        page-break-before: always;
        break-before: page;
    }
    
    @page {
        size: A4;
        margin: 1cm;
    }
    
    table {
        page-break-inside: avoid;
    }
    
    .signature-footer {
        page-break-inside: avoid;
    }
}

.page-break {
    page-break-before: always;
    break-before: page;
}

.signature-footer {
    margin-top: 50px;
    width: 100%;
    border-collapse: collapse;
}

.title {
    text-align: center;
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
}

.subtitle {
    text-align: center;
    font-size: 14px;
    margin-bottom: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
    font-size: 10px;
}

th, td {
    border: 1px solid #000;
    padding: 2px;
    text-align: center;
}

  </style>
</head>
<body>
     <form id="form1" runat="server">
        <asp:PlaceHolder ID="phSalaryReport" runat="server"></asp:PlaceHolder>
    </form>
</body>
</html>
