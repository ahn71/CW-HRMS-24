<%@ Page Title="Report Builder" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="reportGenerate.aspx.cs" Inherits="SigmaERP.hrms.settings.reportGenerate" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Noto+Sans+Bengali:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <script src="https://cdn.tiny.cloud/1/mkrkcjme2z7l59z0yf6whc3g972lqryj00iqcalldfkzpz0r/tinymce/8/tinymce.min.js" referrerpolicy="origin" crossorigin="anonymous"></script>
    <style>
        :root {
            --rb-navy: #102a43;
            --rb-blue: #1463d9;
            --rb-sky: #eef5ff;
            --rb-line: #dce6f3;
            --rb-ink: #172b4d;
            --rb-muted: #6b7b93
        }

        .report-builder {
            font-family: Inter,'Noto Sans Bengali',sans-serif;
            color: var(--rb-ink);
            max-width: 1600px;
            margin: 20px auto 34px;
            padding: 0 18px
        }

        .rb-top {
            background: linear-gradient(120deg,#0d2544,#1769e5);
            border-radius: 18px;
            padding: 22px 26px;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 13px 30px #12335a2e
        }

        .rb-eyebrow {
            font-size: 11px;
            letter-spacing: 1.6px;
            text-transform: uppercase;
            opacity: .7;
            font-weight: 700
        }

        .rb-top h2 {
            font-size: 25px;
            margin: 5px 0 0;
            font-weight: 800
        }

        .rb-top p {
            margin: 4px 0 0;
            opacity: .76;
            font-size: 13px
        }

        .rb-status {
            background: #ffffff1c;
            border: 1px solid #ffffff35;
            border-radius: 10px;
            padding: 9px 12px;
            font-size: 12px
        }

            .rb-status i {
                display: inline-block;
                width: 7px;
                height: 7px;
                border-radius: 50%;
                background: #63e6be;
                margin-right: 6px
            }

        .rb-filter-card {
            background: #fff;
            border: 1px solid var(--rb-line);
            border-radius: 16px;
            margin: 18px 0;
            padding: 18px 20px;
            box-shadow: 0 4px 16px #1c4f8510
        }

        .rb-card-title {
            font-weight: 800;
            font-size: 14px
        }

        .rb-card-note {
            color: var(--rb-muted);
            font-size: 12px;
            margin-top: 3px
        }

        .rb-filters {
            display: grid;
            grid-template-columns: 1.25fr repeat(4,1fr);
            gap: 12px;
            margin-top: 15px
        }

        .rb-field label {
            font-size: 11px;
            color: var(--rb-muted);
            display: block;
            font-weight: 700;
            margin: 0 0 6px
        }

        .rb-field select, .rb-field input {
            border: 1px solid var(--rb-line);
            border-radius: 8px;
            width: 100%;
            height: 38px;
            padding: 0 10px;
            background: #fbfdff;
            outline: none;
            color: var(--rb-ink)
        }

            .rb-field select:focus, .rb-field input:focus {
                border-color: #4b91ef;
                box-shadow: 0 0 0 3px #dbeafe
            }

        .rb-workspace {
            display: grid;
            grid-template-columns: 270px minmax(0,1fr);
            gap: 18px;
            align-items: start
        }

        .rb-sidebar {
            background: #fff;
            border: 1px solid var(--rb-line);
            border-radius: 16px;
            position: sticky;
            top: 12px;
            overflow: hidden
        }

        .rb-side-head {
            padding: 17px 17px 12px;
            border-bottom: 1px solid #edf2f7
        }

            .rb-side-head strong {
                font-size: 14px;
                display: block
            }

            .rb-side-head span {
                font-size: 11px;
                color: var(--rb-muted)
            }

        .rb-search {
            position: relative;
            margin: 12px 15px
        }

            .rb-search:before {
                content: '⌕';
                position: absolute;
                left: 11px;
                top: 7px;
                color: #7890ac;
                font-size: 18px
            }

            .rb-search input {
                box-sizing: border-box;
                width: 100%;
                padding: 9px 11px 9px 31px;
                border: 1px solid var(--rb-line);
                border-radius: 8px;
                outline: none;
                font-size: 12px
            }

        .rb-token-list {
            max-height: calc(100vh - 330px);
            min-height: 350px;
            overflow-y: auto;
            padding: 2px 11px 13px
        }

        .rb-token {
            display: flex;
            align-items: center;
            gap: 9px;
            padding: 10px 7px;
            border-bottom: 1px solid #f0f4f8;
            cursor: grab;
            user-select: none;
            transition: .16s
        }

            .rb-token:hover {
                background: #f1f7ff;
                border-radius: 7px;
                padding-left: 10px
            }

            .rb-token:active {
                cursor: grabbing
            }

        .rb-token-icon {
            width: 27px;
            height: 27px;
            display: grid;
            place-items: center;
            border-radius: 7px;
            background: #e7f0ff;
            color: #1463d9;
            font-size: 13px;
            font-weight: 800
        }

        .rb-token-name {
            font-size: 12px;
            font-weight: 700;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap
        }

        .rb-token-key {
            font-size: 10px;
            color: #8091a7;
            margin-top: 2px
        }

        .rb-editor-card {
            background: #fff;
            border: 1px solid var(--rb-line);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 6px 18px #1d4e8911
        }

        .rb-editor-head {
            padding: 17px 20px;
            border-bottom: 1px solid #edf2f7;
            display: flex;
            align-items: center;
            gap: 13px
        }

            .rb-editor-head label {
                font-size: 11px;
                color: var(--rb-muted);
                font-weight: 700;
                white-space: nowrap
            }

        .rb-template-name {
            width: 300px;
            border: 1px solid var(--rb-line);
            border-radius: 8px;
            padding: 9px 11px;
            outline: none;
            font-weight: 600
        }

        .rb-insert-tools {
            margin-left: auto;
            display: flex;
            gap: 7px
        }

        .rb-lite-btn {
            border: 1px solid var(--rb-line);
            background: #fff;
            border-radius: 7px;
            padding: 8px 10px;
            color: #39526f;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer
        }

            .rb-lite-btn:hover {
                background: var(--rb-sky);
                color: var(--rb-blue)
            }

        .rb-canvas-wrap {
            padding: 20px;
            background: #f5f8fc
        }

        .rb-drop-hint {
            padding: 9px 13px;
            background: #eaf3ff;
            border: 1px dashed #86b8f7;
            border-radius: 8px;
            font-size: 12px;
            color: #2763ad;
            margin-bottom: 12px
        }

            .rb-drop-hint b {
                font-weight: 800
            }

        .rb-actions {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 16px 20px;
            border-top: 1px solid #edf2f7;
            background: #fff
        }

            .rb-actions .rb-action-note {
                font-size: 11px;
                color: var(--rb-muted);
                margin-right: auto
            }

        .rb-button {
            border: 0;
            border-radius: 8px;
            padding: 10px 15px;
            font-weight: 700;
            font-size: 12px;
            cursor: pointer
        }

        .rb-preview {
            background: #eef4fb;
            color: #31516f
        }

        .rb-save {
            background: #1664d9;
            color: #fff;
            box-shadow: 0 5px 12px #1664d94a
        }

        .rb-download {
            background: #102a43;
            color: #fff
        }

        .rb-message {
            padding: 0 2px
        }

        .rb-preview-modal { margin: 18px 0; border: 1px solid var(--rb-line); border-radius: 16px; overflow: hidden; background: #f1f5f9 }
        .rb-preview-modal-head { display:flex; align-items:center; gap:12px; padding:14px 18px; background:#fff; border-bottom:1px solid var(--rb-line) }
        .rb-preview-modal-head strong { font-size:14px }
        .rb-preview-modal-head span { color:var(--rb-muted); font-size:12px; margin-right:auto }
        .rb-preview-close { color:#39526f; text-decoration:none; font-weight:700; font-size:12px }
        .rb-preview-pages { max-height:75vh; overflow:auto; padding:24px; }
        .rb-a4-page { width:210mm; min-height:297mm; box-sizing:border-box; margin:0 auto 22px; padding:20mm; background:#fff; box-shadow:0 4px 18px #102a4330; color:#172b4d; page-break-after:always; overflow:hidden }
        .rb-a4-page:last-child { page-break-after:auto }
        @media print { body * { visibility:hidden } .rb-preview-modal, .rb-preview-modal * { visibility:visible } .rb-preview-modal { position:absolute; inset:0; border:0 } .rb-preview-modal-head { display:none } .rb-preview-pages { max-height:none; overflow:visible; padding:0 } .rb-a4-page { box-shadow:none; margin:0; width:210mm; min-height:297mm; page-break-after:always } }

        .rb-empty {
            padding: 18px 8px;
            text-align: center;
            color: #93a2b5;
            font-size: 12px
        }

        @media(max-width:900px) {
            .rb-workspace {
                grid-template-columns: 1fr
            }

            .rb-sidebar {
                position: static
            }

            .rb-token-list {
                max-height: 240px;
                min-height: 0
            }

            .rb-filters {
                grid-template-columns: 1fr 1fr
            }

            .rb-editor-head {
                flex-wrap: wrap
            }

            .rb-insert-tools {
                margin-left: 0
            }

            .rb-template-name {
                width: 100%
            }
        }

        @media(max-width:580px) {
            .rb-top {
                align-items: flex-start
            }

            .rb-status {
                display: none
            }

            .rb-filters {
                grid-template-columns: 1fr
            }

            .rb-actions {
                flex-wrap: wrap
            }

                .rb-actions .rb-action-note {
                    width: 100%
                }
        }

        .rb-search:before {
            display: none
        }

        .rb-search input {
            padding-left: 11px
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="scr1" />
    <main class="report-builder">
        <section class="rb-filter-card">
            <div class="rb-filters">
                <div class="rb-field">
                    <label>Report Type</label><asp:DropDownList ID="ddlLetterType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLetterType_SelectedIndexChanged">
                        <asp:ListItem Text="Promotion Letter" Value="Promotion" />
                        <asp:ListItem Text="Appointment Letter" Value="Appointment" />
                        <asp:ListItem Text="Dismissal Letter" Value="Dismissal" />
                        <asp:ListItem Text="Lady Worker Night Duty Bill" Value="NightDutyBill" />
                        <asp:ListItem Text="Custom Report" Value="Custom" />
                    </asp:DropDownList></div>
                <div class="rb-field">
                    <label>Department</label><asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" /></div>
                <div class="rb-field">
                    <label>Designation</label><asp:DropDownList ID="ddlDesignation" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDesignation_SelectedIndexChanged" /></div>
                <div class="rb-field">
                    <label>Unit</label><asp:DropDownList ID="ddlUnit" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlUnit_SelectedIndexChanged" /></div>
                <div class="rb-field">
                    <label>Specific Employee</label><asp:DropDownList ID="ddlEmployee" runat="server" /></div>
            </div>
        </section>
        <div class="rb-workspace">
            <aside class="rb-sidebar">
                <div class="rb-side-head"><strong>Data Fields</strong><span>Drag a field into the editor or click to insert it.</span></div>
                <div class="rb-search">
                    <input id="fieldSearch" type="search" placeholder="Search fields..." autocomplete="off" /></div>
                <div class="rb-token-list" id="tokenList" data-fields='<%= AvailableFieldsJson %>'></div>
            </aside>
            <section class="rb-editor-card">
                <div class="rb-editor-head">
                    <div>
                        <asp:TextBox ID="txtTemplateName" runat="server" CssClass="rb-template-name" placeholder="Template Name" /></div>
                    <div class="rb-insert-tools">
                        <button type="button" class="rb-lite-btn" id="addTitle">Add Title</button>
                        <button type="button" class="rb-lite-btn" id="addLogo">Add Logo</button><input type="file" id="logoFile" accept="image/*" hidden /></div>
                </div>
                <div class="rb-canvas-wrap">
                    <asp:TextBox ID="txtTemplateBody" runat="server" TextMode="MultiLine" Rows="18" Width="100%" ValidateRequestMode="Disabled" /></div>
                <div class="rb-actions"><span class="rb-action-note">Save your changes before downloading the PDF.</span>
                    <asp:Button ID="btnPreview" runat="server" Text="Preview" OnClick="btnPreview_Click" CssClass="rb-button rb-preview" OnClientClick="return syncEditor();" /><asp:Button ID="btnSaveTemplate" runat="server" Text="Submit / Save" OnClick="btnSaveTemplate_Click" CssClass="rb-button rb-save" OnClientClick="return syncEditor();" /><asp:Button ID="btnGeneratePdf" runat="server" Text="Download PDF" OnClick="btnGeneratePdf_Click" CssClass="rb-button rb-download" OnClientClick="return syncEditor();" /></div>
            </section>
        </div>
        <asp:Panel ID="pnlPreview" runat="server" CssClass="rb-preview-modal" Visible="false">
            <div class="rb-preview-modal-head"><strong>Print Preview</strong><span><asp:Literal ID="litPreviewSummary" runat="server" /></span><a class="rb-preview-close" href="reportGenerate.aspx">Close preview</a><button type="button" class="rb-lite-btn" onclick="window.print()">Print</button></div>
            <div class="rb-preview-pages"><asp:Literal ID="litPreviewPages" runat="server" /></div>
        </asp:Panel>
        <div class="rb-message">
            <asp:Literal ID="litMessage" runat="server" /></div>
    </main>
    <script>
        (function () {
            var editor, list = document.getElementById('tokenList'), search = document.getElementById('fieldSearch');
            var fields = JSON.parse(list.getAttribute('data-fields') || '[]');
            function label(v) { return v.replace(/_/g, ' ').replace(/\b\w/g, function (c) { return c.toUpperCase(); }); }
            function addToken(field) { var el = document.createElement('div'); el.className = 'rb-token'; el.draggable = true; el.dataset.token = field; el.innerHTML = '<span class="rb-token-icon">{ }</span><span><div class="rb-token-name">' + label(field) + '</div><div class="rb-token-key">{{' + field + '}}</div></span>'; el.addEventListener('dragstart', function (e) { e.dataTransfer.setData('text/plain', field); e.dataTransfer.effectAllowed = 'copy'; }); el.addEventListener('click', function () { insertToken(field); }); list.appendChild(el); }
            fields.forEach(addToken); if (!fields.length) list.innerHTML = '<div class="rb-empty">No fields found.</div>';
            search.addEventListener('input', function () { var q = this.value.toLowerCase();[].forEach.call(list.querySelectorAll('.rb-token'), function (x) { x.style.display = x.textContent.toLowerCase().indexOf(q) > -1 ? 'flex' : 'none'; }); });
            function insertToken(field) { if (!editor) return; editor.focus(); editor.insertContent('<span style="background:#e8f1ff;color:#155ec4;border-radius:4px;padding:2px 5px;font-weight:600;white-space:nowrap">{{' + field + '}}</span>&nbsp;'); editor.save(); }
            function init() { tinymce.init({ selector:'#<%= txtTemplateBody.ClientID %>', height: 530, menubar: false, plugins: 'lists link image table code searchreplace visualblocks wordcount', toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist | link image table | removeformat code', content_style: "body{font-family:Inter,'Noto Sans Bengali',sans-serif;font-size:14px;line-height:1.8;padding:26px;min-height:420px;color:#172b4d} img{max-width:180px;height:auto}", setup: function (ed) { editor = ed; ed.on('init', function () { var body = ed.getBody(); body.addEventListener('dragover', function (e) { e.preventDefault(); }); body.addEventListener('drop', function (e) { e.preventDefault(); var f = e.dataTransfer.getData('text/plain'); if (f) insertToken(f); }); }); ed.on('change input undo redo', function () { ed.save(); }); } }); }
            window.syncEditor = function () { if (editor) editor.save(); return true; }; init();
            document.getElementById('addTitle').onclick = function () { if (editor) { editor.focus(); editor.insertContent('<h1 style="text-align:center;color:#102a43">REPORT TITLE</h1><hr />'); editor.save(); } };
            document.getElementById('addLogo').onclick = function () { document.getElementById('logoFile').click(); }; document.getElementById('logoFile').onchange = function () { var file = this.files[0]; if (!file || !editor) return; var r = new FileReader(); r.onload = function (e) { editor.focus(); editor.insertContent('<p style="text-align:center"><img src="' + e.target.result + '" alt="Company logo" /></p>'); editor.save(); }; r.readAsDataURL(file); };
        })();
    </script>
</asp:Content>
