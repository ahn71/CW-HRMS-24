<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="reportGenerate.aspx.cs" Inherits="SigmaERP.hrms.settings.reportGenerate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>HRMS Letter Builder</title>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Bengali:wght@400;600;700&display=swap" rel="stylesheet" />
    <!-- Place the first <script> tag in your HTML's <head> -->
<script src="https://cdn.tiny.cloud/1/mkrkcjme2z7l59z0yf6whc3g972lqryj00iqcalldfkzpz0r/tinymce/8/tinymce.min.js" referrerpolicy="origin" crossorigin="anonymous"></script>

<!-- Place the following <script> and <textarea> tags your HTML's <body> -->
<script>
  tinymce.init({
    selector: 'textarea',
    plugins: [
      // Core editing features
      'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount',
      // Premium features
      'checklist', 'mediaembed', 'casechange', 'formatpainter', 'pageembed', 'a11ychecker', 'tinymcespellchecker', 'permanentpen', 'powerpaste', 'advtable', 'advcode', 'advtemplate', 'tinymceai', 'uploadcare', 'mentions', 'tinycomments', 'tableofcontents', 'footnotes', 'mergetags', 'autocorrect', 'typography', 'inlinecss', 'markdown','importword', 'exportword', 'exportpdf'
    ],
    toolbar: 'undo redo | tinymceai-chat tinymceai-quickactions tinymceai-review | blocks fontfamily fontsize | bold italic underline strikethrough | link media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck typography uploadcare | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
    tinycomments_mode: 'embedded',
    tinycomments_author: 'Author name',
    mergetags_list: [
      { value: 'First.Name', title: 'First Name' },
      { value: 'Email', title: 'Email' },
    ],
    tinymceai_token_provider: async () => {
      await fetch(`https://demo.api.tiny.cloud/1/mkrkcjme2z7l59z0yf6whc3g972lqryj00iqcalldfkzpz0r/auth/random`, { method: "POST", credentials: "include" });
      return { token: await fetch(`https://demo.api.tiny.cloud/1/mkrkcjme2z7l59z0yf6whc3g972lqryj00iqcalldfkzpz0r/jwt/tinymceai`, { credentials: "include" }).then(r => r.text()) };
    },
    uploadcare_public_key: '5e81612bf28b8bbba8be',
  });
</script>
    <style>
        body { font-family: 'Noto Sans Bengali', sans-serif; }
        .section { margin-bottom: 16px; }
        label { display:block; font-weight:600; margin-bottom:4px; }
        .filters { display:flex; gap:14px; flex-wrap:wrap; }
        .filters .field { min-width:180px; }
    </style>
    <script>
        window.onload = function () {
            tinymce.init({
                selector: '#<%= txtTemplateBody.ClientID %>',
                height: 380,
                content_style: "body{font-family:'Noto Sans Bengali',sans-serif; font-size:15px; line-height:1.9;}",
                setup: function (editor) {
                    editor.on('change', function () { editor.save(); });
                }
            });
        };
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="scr1"></asp:ScriptManager>
  
        <h2>HRMS ডাইনামিক লেটার বিল্ডার</h2>

        <div class="section">
            <label>পত্রের ধরন</label>
            <asp:DropDownList ID="ddlLetterType" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="ddlLetterType_SelectedIndexChanged">
                <asp:ListItem Text="Promotion Letter" Value="Promotion" />
                <asp:ListItem Text="Appointment Letter" Value="Appointment" />
                <asp:ListItem Text="Dismissal Letter" Value="Dismissal" />
                <asp:ListItem Text="Lady Worker Night Duty Bill" Value="NightDutyBill" />
                <asp:ListItem Text="Custom" Value="Custom" />
            </asp:DropDownList>
        </div>

        <div class="section">
            <label>কাদের জন্য তৈরি হবে? — যেকোনো ফিল্টার খালি রাখলে সেটা "সব" ধরা হবে</label>
            <div class="filters">
                <div class="field">
                    <label style="font-weight:400;">বিভাগ (Department)</label>
                    <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" />
                </div>
                <div class="field">
                    <label style="font-weight:400;">পদবী (Designation)</label>
                    <asp:DropDownList ID="ddlDesignation" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlDesignation_SelectedIndexChanged" />
                </div>
                <div class="field">
                    <label style="font-weight:400;">ইউনিট (Unit)</label>
                    <asp:DropDownList ID="ddlUnit" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlUnit_SelectedIndexChanged" />
                </div>
                <div class="field">
                    <label style="font-weight:400;">নির্দিষ্ট কর্মী (Single Employee)</label>
                    <asp:DropDownList ID="ddlEmployee" runat="server" />
                </div>
            </div>
            <p style="font-size:12px;color:#666;">
                শুধু কর্মী বাছলে → single employee &nbsp;|&nbsp;
                শুধু বিভাগ বাছলে (কর্মী খালি) → পুরো department &nbsp;|&nbsp;
                সব খালি → company-এর সব কর্মী
            </p>
        </div>

        <div class="section">
            <label>উপলব্ধ ফিল্ড (এই {{token}} গুলো টেমপ্লেটে ব্যবহার করুন)</label>
            <asp:Label ID="lblAvailableTokens" runat="server" Font-Size="12" ForeColor="#6C1F26" />
        </div>

        <div class="section">
            <label>টেমপ্লেট নাম</label>
            <asp:TextBox ID="txtTemplateName" runat="server" Width="350px" />
        </div>

        <div class="section">
            <label>পত্রের টেমপ্লেট (TinyMCE — যেকোনোভাবে সাজান)</label>
            <asp:TextBox ID="txtTemplateBody" runat="server" TextMode="MultiLine" Rows="15" Width="100%" />
        </div>

        <div class="section">
            <asp:Button ID="btnSaveTemplate" runat="server" Text="টেমপ্লেট সংরক্ষণ করুন" OnClick="btnSaveTemplate_Click" />
            <asp:Button ID="btnGeneratePdf" runat="server" Text="PDF তৈরি করুন" OnClick="btnGeneratePdf_Click" CssClass="primary" />
        </div>

        <asp:Literal ID="litMessage" runat="server" />


</asp:Content>
