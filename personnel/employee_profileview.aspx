<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="employee_profileview.aspx.cs" Inherits="SigmaERP.personnel.employee_profileview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style type="text/css">
/* Print Code */
/* Basic styling for A4 page print */
        @media print {
            /* Set the page size to A4 */
            @page {
                size: A4;
                /* margin: 1cm; Adjust margins as needed */
                margin: 20px;
                padding: 20px;
            }

            #btnDownload {
                display: none;
            }

            /* General styling for body */

            /* Header and Footer */
            .header, .footer {
                text-align: center;
                font-weight: bold;
                margin-bottom: 1cm;
            }

            /* Content area */
            .content {
                margin: 0;
                padding: 0;
            }

            /* Avoid breaking content in between elements */
            .section {
                page-break-inside: avoid;
            }

            /* Hide elements that are not needed in print */
            .no-print {
                display: none;
            }

            /* Optional: Add custom styles for tables */
            table {
                width: 100%;
                border-collapse: collapse;
            }

            /* Ensure text fits within the page */
            p, h1, h2, h3, h4, h5, h6 {
                margin: 0;
            }

            .profile-header {
                color: #1a0b0b;
                text-align: start;
            }

                .profile-header img {
                    border-radius: 50%;
                    width: 150px;
                    height: 150px;
                }

            .profile-details h5 {
                color: #034ea1;
                margin-top: 10px;
            }

            .profile-details p {
                color: #000000;
                font-size: 16px;
            }

            .card {
                margin-top: 20px;
            }

            .bg-custom {
                background: #003873 !important;
            }

            .table-blue th {
                background: #003873 !important;
                color: #fff;
            }
        }


        .profile-header {
           
            color: #1a0b0b;
            text-align: start; 
        }
        .profile-header img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
        }
        .profile-details h5 {
            color: #034ea1;
            margin-top: 10px;
        }
        .profile-details p {
            color: #6c757d;
            font-size: 16px;
        }
        .card {
            margin-top: 20px;
        }
        .bg-custom{
            background: #003873;
        }
        .table-blue{
            background: #003873;
            color: #fff;
        }
        .employee-section:not(:first-child) {
            page-break-before: always;
        }
        

    </style>
</head>
<body>
    <form id="form1" runat="server">
       
         <div class="container" runat="server" id="divProfileView">

         </div>
         
      
    </form>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
