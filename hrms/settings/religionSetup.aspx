<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="religionSetup.aspx.cs" Inherits="SigmaERP.hrms.settings.religionSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
         <script src="../scripts/jquery-1.8.2.js"></script>
        <script type="text/javascript">

            var oldgridcolor;
            function SetMouseOver(element) {
                oldgridcolor = element.style.backgroundColor;
                element.style.backgroundColor = '#ffeb95';
                element.style.cursor = 'pointer';
                // element.style.textDecoration = 'underline';
            }
            function SetMouseOut(element) {
                element.style.backgroundColor = oldgridcolor;
                // element.style.textDecoration = 'none';

            }

     </script>
    <style>
        /* ============================================================
           Religion Panel - visual restyle only.
           NOTE: No server-side control IDs, events, CommandNames,
           OnClick/OnClientClick handlers, or postback logic were
           touched. Pure CSS + responsive layout upgrade.
           ============================================================ */

        * {
            box-sizing: border-box;
        }

        .RBox {
            width: 100%;
            margin: 0 0 24px 0;
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 6px 24px rgba(15, 34, 58, 0.10);
            border: 1px solid #e3e8f0;
            font-family: 'Segoe UI', Tahoma, Arial, sans-serif;
        }

        .RBoxheader {
            background: linear-gradient(120deg, #003f82 0%, #0072d6 55%, #1e93ff 100%);
            padding: 20px 28px;
            border-bottom: 3px solid #ffb100;
        }

        .RBoxheader h2 {
            color: #ffffff;
            font-size: 21px;
            font-weight: 700;
            margin: 0;
            letter-spacing: 0.4px;
        }

        .RBoxheader h2::before {
            content: "🕊";
            margin-right: 10px;
            font-size: 18px;
        }

        .Rbody {
            padding: 28px 32px 26px 32px;
            background: #fafbfd;
        }

        .main_box_content {
            width: 100%;
        }

        /* ---------- Message area ---------- */
        .message {
            font-size: 14px;
            padding: 10px 14px;
            border-radius: 8px;
        }

        .message:not(:empty) {
            background: #eaf6ec;
            border: 1px solid #bfe4c6;
            color: #1f7a34;
            margin-bottom: 14px;
        }

        /* ---------- Input form ---------- */
        .input_division_info {
            background: #ffffff;
            border: 1px solid #e3e8f0;
            border-radius: 10px;
            padding: 24px 28px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(15, 34, 58, 0.04);
        }

        .division_table {
            width: 100%;
            max-width: 640px;
            border-collapse: separate;
            border-spacing: 0 16px;
        }

        .division_table td {
            font-size: 14.5px;
            color: #2c3e50;
            vertical-align: middle;
            padding-right: 10px;
        }

        .division_table td:first-child {
            font-weight: 600;
            white-space: nowrap;
            width: 150px;
        }

        .division_table td:nth-child(2) {
            width: 14px;
            text-align: center;
            color: #9aa7b8;
        }

        .requerd1 {
            color: #e53935;
            font-weight: 700;
            margin-left: 2px;
        }

        .form-control.text_box_width {
            width: 100%;
            max-width: 360px;
            box-sizing: border-box;
            padding: 10px 14px;
            border: 1.5px solid #d3dae4;
            border-radius: 7px;
            font-size: 14.5px;
            background: #fbfcfe;
            transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
        }

        .form-control.text_box_width:hover {
            border-color: #b9c4d3;
        }

        .form-control.text_box_width:focus {
            outline: none;
            border-color: #0072d6;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(0, 114, 214, 0.12);
        }

        .fontF {
            font-family: 'SolaimanLipi', 'Nikosh', 'Segoe UI', Tahoma, Arial, sans-serif;
        }

        /* ---------- Buttons ---------- */
        .Rbutton_area {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin: 4px 0 30px 0;
        }

        .Rbutton {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 26px;
            min-width: 96px;
            font-size: 14px;
            font-weight: 600;
            border: none;
            border-radius: 7px;
            background: #0057AE;
            color: #ffffff !important;
            text-decoration: none;
            cursor: pointer;
            box-shadow: 0 2px 6px rgba(0, 87, 174, 0.25);
            transition: background 0.2s ease, transform 0.12s ease, box-shadow 0.2s ease;
        }

        .Rbutton:hover {
            background: #003f82;
            transform: translateY(-2px);
            box-shadow: 0 5px 12px rgba(0, 63, 130, 0.3);
        }

        .Rbutton:active {
            transform: translateY(0);
        }

        a.Rbutton {
            background: #64748b;
            box-shadow: 0 2px 6px rgba(100, 116, 139, 0.25);
        }

        a.Rbutton:hover {
            background: #475569;
            box-shadow: 0 5px 12px rgba(71, 85, 105, 0.3);
        }

        input.Rbutton[disabled] {
            background: #c3ccd8 !important;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        /* ---------- GridView / table ---------- */
        .show_division_info {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border: 1px solid #e3e8f0;
            border-radius: 10px;
            background: #ffffff;
            box-shadow: 0 1px 3px rgba(15, 34, 58, 0.04);
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList {
            width: 100% !important;
            table-layout: fixed;
            border-collapse: collapse;
            font-size: 14.5px;
            min-width: 560px;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList th,
        #ContentPlaceHolder1_MainContent_gvQualificationList td {
            border-right: 1px solid #eef1f6;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList th:last-child,
        #ContentPlaceHolder1_MainContent_gvQualificationList td:last-child {
            border-right: none;
        }

        /* Column proportions: Religion | বাংলায় | Edit | Delete */
        #ContentPlaceHolder1_MainContent_gvQualificationList th:nth-child(1),
        #ContentPlaceHolder1_MainContent_gvQualificationList td:nth-child(1) {
            width: 32%;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList th:nth-child(2),
        #ContentPlaceHolder1_MainContent_gvQualificationList td:nth-child(2) {
            width: 32%;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList th:nth-child(3),
        #ContentPlaceHolder1_MainContent_gvQualificationList td:nth-child(3) {
            width: 18%;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList th:nth-child(4),
        #ContentPlaceHolder1_MainContent_gvQualificationList td:nth-child(4) {
            width: 18%;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList th {
            background: #0f2b4c;
            color: #ffffff;
            font-weight: 600;
            padding: 13px 14px;
            height: auto;
            text-transform: uppercase;
            font-size: 12.5px;
            letter-spacing: 0.5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList td {
            padding: 12px 14px;
            border-bottom: 1px solid #eef1f6;
            color: #33475b;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList tr:nth-child(even) td {
            background-color: #f6f9fc;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList tr:hover td {
            background-color: #fff3cf !important;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList tr:last-child td {
            border-bottom: none;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList th:nth-child(3),
        #ContentPlaceHolder1_MainContent_gvQualificationList th:nth-child(4),
        #ContentPlaceHolder1_MainContent_gvQualificationList td:nth-child(3),
        #ContentPlaceHolder1_MainContent_gvQualificationList td:nth-child(4) {
            text-align: center;
        }

        #ContentPlaceHolder1_MainContent_gvQualificationList th:nth-child(1),
        td:nth-child(1),
        th:nth-child(2),
        td:nth-child(2) {
            padding-left: 16px;
        }

        .btnForAlterInGV,
        .btnForDeleteInGV {
            padding: 7px 16px;
            font-size: 12.5px;
            font-weight: 600;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            color: #fff;
            letter-spacing: 0.2px;
            transition: opacity 0.2s ease, transform 0.12s ease;
        }

        .btnForAlterInGV {
            background: #17a2b8;
        }

        .btnForAlterInGV:hover {
            opacity: 0.88;
            transform: translateY(-1px);
        }

        .btnForDeleteInGV {
            background: #e5533d;
        }

        .btnForDeleteInGV:hover {
            opacity: 0.88;
            transform: translateY(-1px);
        }

        .gridview.Sgridview {
            text-align: center;
            background: #f6f9fc;
            padding: 10px 0;
        }

        .gridview.Sgridview td,
        .gridview.Sgridview tr {
            border: none !important;
        }

        .gridview.Sgridview a,
        .gridview.Sgridview span {
            display: inline-block;
            padding: 5px 11px;
            margin: 2px;
            border-radius: 5px;
            color: #0f2b4c;
            font-size: 13px;
        }

        .gridview.Sgridview a:hover {
            background: #dbe7f5;
        }

        /* ============================================================
           Responsive breakpoints
           ============================================================ */
        @media (max-width: 768px) {
            .RBox {
                margin: 0 0 16px 0;
                border-radius: 10px;
            }

            .RBoxheader {
                padding: 16px 18px;
            }

            .Rbody {
                padding: 18px 16px;
            }

            .input_division_info {
                padding: 18px 16px;
            }

            .division_table,
            .division_table tbody,
            .division_table tr,
            .division_table td {
                display: block;
                width: 100%;
            }

            .division_table {
                border-spacing: 0;
                max-width: 100%;
            }

            .division_table tr {
                margin-bottom: 14px;
            }

            .division_table td:first-child {
                width: 100%;
                margin-bottom: 6px;
                font-size: 13.5px;
                color: #536477;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .division_table td:nth-child(2) {
                display: none;
            }

            .form-control.text_box_width {
                max-width: 100%;
            }

            .Rbutton_area {
                justify-content: stretch;
            }

            .Rbutton {
                flex: 1 1 auto;
                text-align: center;
            }
        }

        @media (max-width: 480px) {
            .RBoxheader h2 {
                font-size: 17px;
            }

            .Rbutton {
                padding: 11px 14px;
                font-size: 13px;
                min-width: 0;
            }

            .btnForAlterInGV,
            .btnForDeleteInGV {
                padding: 6px 10px;
                font-size: 12px;
            }

            #ContentPlaceHolder1_MainContent_gvQualificationList {
                min-width: 460px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate><p class="message"  id="lblMessage" clientidmode="Static" runat="server"></p></ContentTemplate>
</asp:UpdatePanel>
    <asp:HiddenField ID="hdnUpdate" runat="server" ClientIDMode="Static" />
    
     <asp:HiddenField ID="upSave" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="upupdate" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="updelete" runat="server" ClientIDMode="Static" />
    <div class="main_box RBox">
    <%--<div class="main_box">--%>
    	<div class="main_box_header RBoxheader">
            <h2>Religion Panel</h2>
        </div>
    	<div class="main_box_body Rbody">
        	<div class="main_box_content">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSave" />
                               <asp:AsyncPostBackTrigger ControlID="gvQualificationList" />
                            </Triggers>
                            <ContentTemplate>
                <div class="input_division_info">
                    <table class="division_table">
                        <tr>
                            <td>
                                Religion <span class="requerd1">*</span>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtReligion" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width" MaxLength="20"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                বাংলায় 
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtReligionBn" runat="server" ClientIDMode="Static" CssClass="form-control text_box_width fontF" MaxLength="30"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="button_area Rbutton_area">
                    <a href="#" onclick="window.history.back()" class="Rbutton">Back</a>
                    <asp:Button ID="btnNew" ClientIDMode="Static" CssClass="Rbutton"  runat="server" Text="New"  OnClick="btnNew_Click1"/>
                    <asp:Button ID="btnSave" ClientIDMode="Static" CssClass="Rbutton"  runat="server" Text="Save" OnClientClick="return validateInputs();" OnClick="btnSave_Click"  />
                    <asp:Button ID="btnClose" ClientIDMode="Static" CssClass="Rbutton" PostBackUrl="~/hrd_default.aspx"  runat="server" Text="Close" />
                </div>
             </ContentTemplate>
                        </asp:UpdatePanel>

				 <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" />
                         
                        <asp:AsyncPostBackTrigger ControlID="gvQualificationList" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:HiddenField ID="hdnbtnStage" runat="server" ClientIDMode="Static" />
                <div class="show_division_info">
                    <asp:GridView ID="gvQualificationList" runat="server" DataKeyNames="RId" AllowPaging="True" PageSize="15"  AutoGenerateColumns="False" Width="100%" HeaderStyle-BackColor="Black" HeaderStyle-ForeColor="White" OnRowCommand="gvQualificationList_RowCommand" OnRowDataBound="gvQualificationList_RowDataBound" OnRowDeleting="gvQualificationList_RowDeleting"  >
                             <RowStyle HorizontalAlign="Center" />
                              <PagerStyle CssClass="gridview Sgridview" Height="40px" />
                             <Columns>
                                 <asp:BoundField DataField="RName" HeaderText="Religion" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                 <asp:BoundField DataField="RNameBn" HeaderText="বাংলায়" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="fontF" />



                                 <asp:TemplateField HeaderText="Edit" ItemStyle-Width="100px">
                                     <ItemTemplate>
                                         <asp:Button ID="btnAlter" runat="server" ControlStyle-CssClass="btnForAlterInGV" Text="Edit" CommandName="Alter" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' />
                                     </ItemTemplate>
                                 </asp:TemplateField>
                                 <%--<asp:ButtonField CommandName="Alter"   ControlStyle-CssClass="btnForAlterInGV"  HeaderText="Alter" ButtonType="Button" Text="Alter" ItemStyle-Width="80px"/>--%>

                                 <asp:TemplateField HeaderText="Delete" ItemStyle-Width="100px">
                                     <ItemTemplate>
                                         <asp:Button ID="btnDelete" runat="server" ControlStyle-CssClass="btnForDeleteInGV" Text="Delete" CommandName="Delete" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' OnClientClick="return confirm('Are you sure to delete ?')" />
                                     </ItemTemplate>
                                 </asp:TemplateField>

                             </Columns>
                             <HeaderStyle BackColor="#0057AE" Height="28px" />
                         </asp:GridView>
                </div>
                        </ContentTemplate>
                </asp:UpdatePanel>

				
            </div>
        </div>
    <%--</div>--%>
    </div>
     <script type="text/javascript">

         //$('#dlDivision').change(function () {



         $('#btnNew').click(function () {
             clear();
         });
         function validateInputs() {
             if (validateText('txtReligion', 1, 60, 'Enter Religion') == false) return false;
             return true;
         }

         function editQualification(id) {
             var divsn = $('#r_' + id + ' td:first').html();

             $('#txtReligion').val(divsn);
             if ($('#updelete').val() == '1') {
                 $('#btnDelete').addClass('css_btn');
                 $('#btnDelete').removeAttr('disabled');
             }
             if ($('#upupdate').val() == '1') {
                 $('#btnSave').val('Update');
                 $('#btnSave').addClass('css_btn');
                 $('#btnSave').removeAttr('disabled');
             }
             else {
                 $('#btnSave').val('Update');
                 $('#btnSave').removeClass('css_btn');
                 $('#btnSave').attr('disabled', 'disabled');
             }
             $('#hdnbtnStage').val(1);
             $('#hdnUpdate').val(id);
         }

         //function deleteSuccess() {
         //    showMessage('Deleted successfully', 'success');
         //    $('#btnSave').val('Save');
         //    $('#hdnbtnStage').val("");
         //    $('#hdnUpdate').val("");
         //    clear();
         //}
         //function UpdateSuccess() {
         //    showMessage('Updated successfully', 'success');
         //    $('#btnSave').val('Save');
         //    $('#hdnbtnStage').val("");
         //    $('#hdnUpdate').val("");
         //    clear();
         //}
         //function SaveSuccess() {
         //    showMessage('Save successfully', 'success');
         //    $('#btnSave').val('Save');
         //    $('#hdnbtnStage').val("");
         //    $('#hdnUpdate').val("");
         //    clear();
         //}


         function clear() {
             if ($('#upSave').val() == '0') {

                 $('#btnSave').removeClass('css_btn');
                 $('#btnSave').attr('disabled', 'disabled');
             }
             else {
                 $('#btnSave').addClass('css_btn');
                 $('#btnSave').removeAttr('disabled');
             }

             $('#txtReligion').val('');
             $('#btnSave').val('Save');
             $('#hdnbtnStage').val("");
             $('#hdnUpdate').val("");
             $('#btnDelete').removeClass('css_btn');
             $('#btnDelete').attr('disabled', 'disabled');
         }

    </script>
</asp:Content>
