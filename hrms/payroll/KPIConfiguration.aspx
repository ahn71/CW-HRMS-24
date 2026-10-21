<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="KPIConfiguration.aspx.cs" Inherits="SigmaERP.hrms.payroll.KPIConfiguration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- SheetJS: client-side Excel reader -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <style>
        .kpi-page {
            --kpi-primary: #3f51b5;
            --kpi-primary-soft: #eef0fb;
            --kpi-border: #e3e6ef;
            --kpi-text: #2d3142;
            --kpi-muted: #6b7280;
            --kpi-bg: #f6f7fb;
            --kpi-radius: 10px;
            color: var(--kpi-text);
            padding: 10px 4px 30px;
        }

        /* Page header */
        .kpi-page-header {
            display: flex;
            align-items: center;
            gap: 14px;
            margin: 10px 0 20px;
            padding-bottom: 14px;
            border-bottom: 1px solid var(--kpi-border);
        }

        .kpi-page-header-icon {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            background: var(--kpi-primary-soft);
            color: var(--kpi-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            flex-shrink: 0;
        }

        .kpi-page-header h3 {
            margin: 0;
            font-size: 22px;
            font-weight: 700;
        }

        .kpi-page-header p {
            margin: 2px 0 0;
            font-size: 13px;
            color: var(--kpi-muted);
        }

        /* Cards */
        .kpi-card {
            background: #fff;
            border: 1px solid var(--kpi-border);
            border-radius: var(--kpi-radius);
            box-shadow: 0 1px 3px rgba(16, 24, 40, 0.06);
            padding: 18px 20px;
        }

        .kpi-card-title {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 15px;
            font-weight: 600;
            margin: 0 0 14px;
            color: var(--kpi-text);
        }

            .kpi-card-title .kpi-dot {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                background: var(--kpi-primary);
            }

        .kpi-top-row {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 290px;
            gap: 18px;
            align-items: stretch;
            margin-bottom: 20px;
        }

        /* Single entry panel */
        .kpi-single-entry-panel {
            display: flex;
            flex-direction: column;
        }

        .kpi-single-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(170px, 1fr));
            gap: 14px;
            margin-bottom: 16px;
        }

            .kpi-single-row > div {
                display: flex;
                flex-direction: column;
                min-width: 0;
            }

            .kpi-single-row .kpi-field-wide {
                grid-column: 1 / -1;
            }

        .kpi-field-label,
        .kpi-excel-panel > label {
            font-size: 12px;
            font-weight: 600;
            color: var(--kpi-muted);
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .kpi-single-row input,
        .kpi-single-row select {
            width: 100%;
            height: 38px;
            padding: 6px 10px;
            border: 1px solid #d5d9e2;
            border-radius: 6px;
            font-size: 13px;
            background: #fff;
            color: var(--kpi-text);
            transition: border-color 0.15s, box-shadow 0.15s;
        }

            .kpi-single-row input:focus,
            .kpi-single-row select:focus {
                outline: none;
                border-color: var(--kpi-primary);
                box-shadow: 0 0 0 3px rgba(63, 81, 181, 0.15);
            }

            .kpi-single-row input[readonly] {
                background: #f1f3f7;
            }

        .kpi-actions {
            margin-top: auto;
            display: flex;
            justify-content: flex-end;
        }

        /* Employee dropdown (select2) */
        .kpi-single-row .select2-container .select2-selection--single {
            height: 38px;
            border: 1px solid #d5d9e2;
            border-radius: 6px;
        }

            .kpi-single-row .select2-container .select2-selection--single .select2-selection__rendered {
                line-height: 36px;
                padding-left: 10px;
                font-size: 13px;
            }

            .kpi-single-row .select2-container .select2-selection--single .select2-selection__arrow {
                height: 36px;
            }

        .kpi-single-row .select2-container--focus .select2-selection--single,
        .kpi-single-row .select2-container--open .select2-selection--single {
            border-color: var(--kpi-primary);
            box-shadow: 0 0 0 3px rgba(63, 81, 181, 0.15);
        }

        /* Excel panel */
        .kpi-excel-panel {
            display: flex;
            flex-direction: column;
        }

        .kpi-upload-row {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .kpi-file-drop {
            border: 2px dashed #c9cfe0;
            border-radius: 8px;
            background: var(--kpi-bg);
            padding: 14px 10px;
            text-align: center;
            transition: border-color 0.15s, background 0.15s;
        }

            .kpi-file-drop:hover {
                border-color: var(--kpi-primary);
                background: var(--kpi-primary-soft);
            }

            .kpi-file-drop input[type="file"] {
                width: 100%;
                font-size: 12px;
            }

        .kpi-file-hint {
            display: block;
            font-size: 11px;
            color: var(--kpi-muted);
            margin-top: 6px;
        }

        .kpi-upload-row .btn {
            width: 100%;
        }

        .btn-sm-compact {
            padding: 7px 16px;
            font-size: 13px;
            font-weight: 600;
            border-radius: 6px;
        }

        .btn-kpi-outline {
            background: #fff;
            color: var(--kpi-primary);
            border: 1px solid var(--kpi-primary);
        }

            .btn-kpi-outline:hover {
                background: var(--kpi-primary-soft);
                color: var(--kpi-primary);
            }

        /* KPI List section */
        .kpi-list-section {
            margin-top: 4px;
        }

        .kpi-list-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 6px;
            flex-wrap: wrap;
            gap: 10px;
        }

            .kpi-list-header .kpi-card-title {
                margin: 0;
            }

        .kpi-search-box {
            height: 36px;
            padding: 6px 12px 6px 32px;
            border: 1px solid #d5d9e2;
            border-radius: 18px;
            font-size: 13px;
            width: 280px;
            max-width: 100%;
            background: #fff url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' viewBox='0 0 24 24' fill='none' stroke='%236b7280' stroke-width='2' stroke-linecap='round'%3E%3Ccircle cx='11' cy='11' r='7'/%3E%3Cline x1='21' y1='21' x2='16.5' y2='16.5'/%3E%3C/svg%3E") no-repeat 11px center;
        }

            .kpi-search-box:focus {
                outline: none;
                border-color: var(--kpi-primary);
                box-shadow: 0 0 0 3px rgba(63, 81, 181, 0.15);
            }

        .kpi-table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .kpi-action-icon {
            cursor: pointer;
            font-size: 14px;
            margin: 0 2px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            border-radius: 6px;
            transition: background 0.15s;
        }

        .kpi-action-edit {
            color: #2563eb;
            background: #eff4ff;
        }

        .kpi-action-delete {
            color: #c0392b;
            background: #fdecea;
        }

        .kpi-action-icon:hover {
            filter: brightness(0.93);
        }

        .kpi-editing-banner {
            background: #fff8e1;
            border: 1px solid #ffe082;
            color: #8a6d00;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
            margin-bottom: 12px;
            display: none;
        }

        .kpi-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 12px;
            border: 1px solid var(--kpi-border);
            border-radius: 8px;
            min-width: 640px;
        }

            .kpi-table th, .kpi-table td {
                border-bottom: 1px solid var(--kpi-border);
                padding: 10px 12px;
                text-align: left;
                font-size: 13px;
                white-space: nowrap;
            }

            .kpi-table th {
                background-color: #f3f5fa;
                color: #4b5563;
                font-weight: 600;
                font-size: 12px;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .kpi-table tbody tr:nth-child(even) td {
                background: #fafbfd;
            }

            .kpi-table tbody tr:hover td {
                background: var(--kpi-primary-soft);
            }

            .kpi-table tbody tr:last-child td {
                border-bottom: none;
            }

        .kpi-error {
            color: #c0392b;
            font-weight: 600;
            display: block;
            margin-top: 10px;
        }

        .kpi-info {
            color: #2e7d32;
            font-weight: 600;
            display: block;
            margin-top: 10px;
        }

        .kpi-loading {
            color: var(--kpi-muted);
            font-style: italic;
            display: none;
            margin: 0 0 10px;
        }

        /* Popup modal (shared: error/success + excel preview) */
        .kpi-modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(15, 23, 42, 0.5);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            padding: 12px;
        }

            .kpi-modal-overlay.show {
                display: flex;
            }

        .kpi-modal-box {
            background: #fff;
            border-radius: 12px;
            max-width: 420px;
            width: 100%;
            padding: 26px 24px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.25);
            text-align: center;
            animation: kpi-modal-in 0.18s ease-out;
        }

        @keyframes kpi-modal-in {
            from {
                transform: translateY(-15px);
                opacity: 0;
            }

            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .kpi-modal-icon {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            background: #fdecea;
            color: #c0392b;
            font-size: 26px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 14px;
        }

        .kpi-modal-title {
            font-size: 17px;
            font-weight: 600;
            color: var(--kpi-text, #333);
            margin-bottom: 8px;
        }

        .kpi-modal-message {
            font-size: 14px;
            color: #555;
            margin-bottom: 20px;
            line-height: 1.6;
            word-break: break-word;
        }

        .kpi-modal-btn {
            background: #3f51b5;
            color: #fff;
            border: none;
            padding: 9px 28px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

            .kpi-modal-btn:hover {
                background: #303f9f;
            }

        /* Excel preview modal (bigger box) */
        .kpi-preview-box {
            background: #fff;
            border-radius: 12px;
            max-width: 980px;
            width: 100%;
            max-height: 88vh;
            padding: 20px 24px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.25);
            text-align: left;
            animation: kpi-modal-in 0.18s ease-out;
            display: flex;
            flex-direction: column;
        }

        .kpi-preview-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 12px;
            margin-bottom: 12px;
            border-bottom: 1px solid #e3e6ef;
        }

        .kpi-preview-close {
            background: #f3f5fa;
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            font-size: 20px;
            cursor: pointer;
            color: #6b7280;
            line-height: 1;
        }

            .kpi-preview-close:hover {
                background: #e5e7eb;
                color: #333;
            }

        .kpi-preview-body {
            overflow: auto;
        }

            .kpi-preview-body .kpi-table th {
                position: sticky;
                top: 0;
                z-index: 1;
            }

        /* Responsive */
        @media (max-width: 991px) {
            .kpi-top-row {
                grid-template-columns: 1fr;
            }

            .kpi-upload-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
            }

                .kpi-upload-row .kpi-file-drop {
                    grid-column: 1 / -1;
                }
        }

        @media (max-width: 575px) {
            .kpi-page {
                padding: 6px 0 20px;
            }

            .kpi-page-header h3 {
                font-size: 18px;
            }

            .kpi-card {
                padding: 14px;
            }

            .kpi-single-row {
                grid-template-columns: 1fr;
            }

            .kpi-upload-row {
                grid-template-columns: 1fr;
            }

            .kpi-actions .btn {
                width: 100%;
            }

            .kpi-list-header {
                flex-direction: column;
                align-items: stretch;
            }

            .kpi-search-box {
                width: 100%;
            }

            .kpi-preview-box {
                padding: 14px;
                max-height: 92vh;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <div class="kpi-page">
    <div class="kpi-page-header">
        <div class="kpi-page-header-icon">&#128202;</div>
        <div>
            <h3>KPI Bonus - Configuration</h3>
            <p>Employee-দের KPI score ও bonus single entry অথবা Excel upload করে সেট করুন</p>
        </div>
    </div>

    <div class="kpi-top-row">
        <!-- ============ Single Entry Panel ============ -->
        <div class="kpi-card kpi-single-entry-panel">
            <h5 class="kpi-card-title"><span class="kpi-dot"></span>Single Entry</h5>

            <div id="editingBanner" class="kpi-editing-banner">
                আপনি একটি বিদ্যমান রেকর্ড Edit করছেন। <a href="javascript:void(0)" id="btnCancelEdit">বাতিল করুন</a>
            </div>

            <div class="kpi-single-row">
                <div>
                    <label class="kpi-field-label">Employee</label>
                    <select id="ddlEmployee">
                        <option value="">-- Select Employee --</option>
                    </select>
                </div>
                <div>
                    <label class="kpi-field-label">Salary Month</label>
                    <input type="date" id="singleSalaryMonth" />
                </div>
                <div>
                    <label class="kpi-field-label">KPI Score</label>
                    <input type="number" id="singleKpiScore" step="any" placeholder="0" />
                </div>
                <div>
                    <label class="kpi-field-label">KPI Bonus Amount</label>
                    <input type="number" id="singleKpiBonus" step="any" placeholder="0.00" />
                </div>
                <div class="kpi-field-wide">
                    <label class="kpi-field-label">Remarks</label>
                    <input type="text" id="singleRemarks" placeholder="Optional" />
                </div>
            </div>

            <div class="kpi-actions">
                <button type="button" id="btnSingleSubmit" class="btn btn-success btn-sm-compact">SUBMIT</button>
            </div>
        </div>

        <!-- ============ Excel Import (right side, compact) ============ -->
        <div class="kpi-card kpi-excel-panel">
            <h5 class="kpi-card-title"><span class="kpi-dot"></span>Excel Import</h5>
            <label>KPI Excel File</label>
            <div class="kpi-upload-row">
                <div class="kpi-file-drop">
                    <input type="file" id="fuKPIExcel" accept=".xlsx,.xls" />
                    <span class="kpi-file-hint">.xlsx / .xls file সিলেক্ট করুন</span>
                </div>
                <button type="button" id="btnLoad" class="btn btn-primary btn-sm-compact">Load &amp; Process</button>
                <button type="button" id="btnDemoExcel" class="btn btn-kpi-outline btn-sm-compact">&#11015; Download Demo Excel</button>
            </div>
        </div>
    </div>

    <span id="lblLoading" class="kpi-loading">Processing... please wait</span>

    <!-- ============ KPI List Section ============ -->
    <div class="kpi-card kpi-list-section">
        <div class="kpi-list-header">
            <h5 class="kpi-card-title"><span class="kpi-dot"></span>KPI List</h5>
            <input type="text" id="kpiSearchBox" class="kpi-search-box" placeholder="Search anything in the table..." />
        </div>
        <div id="kpiListTableWrapper" class="kpi-table-wrap"></div>
    </div>
  </div>

    <!-- ============ Excel Preview Modal ============ -->
    <div id="excelPreviewOverlay" class="kpi-modal-overlay">
        <div class="kpi-preview-box">
            <div class="kpi-preview-header">
                <div class="kpi-modal-title" style="margin-bottom:0;">Excel Preview</div>
                <button type="button" id="btnClosePreview" class="kpi-preview-close">&times;</button>
            </div>

            <div id="submitBtnWrapper" style="text-align:right; margin-bottom:10px; display:none;">
                <button type="button" id="btnSubmit" class="btn btn-success btn-sm-compact">SUBMIT</button>
            </div>

            <span id="lblMessage" class="kpi-error"></span>

            <div class="kpi-preview-body">
                <div id="resultTableWrapper" class="kpi-table-wrap"></div>
            </div>
        </div>
    </div>

    <!-- ============ Error / Success Popup Modal ============ -->
    <div id="kpiModalOverlay" class="kpi-modal-overlay">
        <div class="kpi-modal-box">
            <div class="kpi-modal-icon">!</div>
            <div class="kpi-modal-title">দুঃখিত!</div>
            <div class="kpi-modal-message" id="kpiModalMessage"></div>
            <button type="button" class="kpi-modal-btn" id="kpiModalCloseBtn">ঠিক আছে</button>
        </div>
    </div>

    <script>
        (function () {
            // ---------------- Values coming from server-side Session ----------------
            var TOKEN = '<%= Session["__UserToken__"] %>';
            var ROOT_URL = '<%= Session["__RootUrl__"] %>';
            var COMPANY_ID = "0001";
            var API_URL = ROOT_URL + "/api/Employee/by-card-numbers?companyId=" + COMPANY_ID;
            var SUBMIT_URL = ROOT_URL + "/api/KPI/create?companyId=" + COMPANY_ID;       // Single Entry (create)
            var EXCEL_SUBMIT_URL = ROOT_URL + "/api/KPI/import?companyId=" + COMPANY_ID; // Excel bulk import
            var KPI_LIST_URL = ROOT_URL + "/api/KPI/kpis?companyId=" + COMPANY_ID;
            var KPI_BY_ID_URL = ROOT_URL + "/api/KPI/kpis/"; // + id
            var KPI_UPDATE_URL = ROOT_URL + "/api/KPI/update?id="; // + id
            // NOTE: Delete endpoint wasn't specified - adjust if your actual route differs.
            var KPI_DELETE_URL = ROOT_URL + "/api/KPI/delete/"; // + id
            // -----------------------------------------------------------------------------

            var REQUIRED_COLUMNS = ["EmpId", "SalaryMonth", "KPIScore", "KPIBonusAmount", "Remarks"];

            var btnLoad = document.getElementById("btnLoad");
            var fileInput = document.getElementById("fuKPIExcel");
            var lblMessage = document.getElementById("lblMessage");
            var lblLoading = document.getElementById("lblLoading");
            var resultWrapper = document.getElementById("resultTableWrapper");
            var modalOverlay = document.getElementById("kpiModalOverlay");
            var modalMessage = document.getElementById("kpiModalMessage");
            var modalCloseBtn = document.getElementById("kpiModalCloseBtn");
            var submitBtnWrapper = document.getElementById("submitBtnWrapper");
            var btnSubmit = document.getElementById("btnSubmit");
            var excelPreviewOverlay = document.getElementById("excelPreviewOverlay");
            var btnClosePreview = document.getElementById("btnClosePreview");

            var currentFoundRows = [];
            var currentEmployeeMap = {};

            // ---------------- Error / Success popup ----------------
            function showErrorPopup(message) {
                modalOverlay.querySelector(".kpi-modal-icon").textContent = "!";
                modalOverlay.querySelector(".kpi-modal-icon").style.background = "#fdecea";
                modalOverlay.querySelector(".kpi-modal-icon").style.color = "#c0392b";
                modalOverlay.querySelector(".kpi-modal-title").textContent = "দুঃখিত!";
                modalMessage.textContent = message;
                modalOverlay.classList.add("show");
            }

            function showSuccessPopup(message) {
                modalOverlay.querySelector(".kpi-modal-icon").textContent = "✓";
                modalOverlay.querySelector(".kpi-modal-icon").style.background = "#e8f5e9";
                modalOverlay.querySelector(".kpi-modal-icon").style.color = "#2e7d32";
                modalOverlay.querySelector(".kpi-modal-title").textContent = "সফল হয়েছে!";
                modalMessage.textContent = message;
                modalOverlay.classList.add("show");
            }

            function hideErrorPopup() {
                modalOverlay.classList.remove("show");
            }

            modalCloseBtn.addEventListener("click", hideErrorPopup);
            modalOverlay.addEventListener("click", function (e) {
                if (e.target === modalOverlay) hideErrorPopup();
            });

            // ---------------- Excel preview modal open/close ----------------
            function showExcelPreviewModal() {
                excelPreviewOverlay.classList.add("show");
            }

            function hideExcelPreviewModal() {
                excelPreviewOverlay.classList.remove("show");
            }

            btnClosePreview.addEventListener("click", hideExcelPreviewModal);
            excelPreviewOverlay.addEventListener("click", function (e) {
                if (e.target === excelPreviewOverlay) hideExcelPreviewModal();
            });

            // =====================================================================
            // EXCEL IMPORT FLOW
            // =====================================================================
            btnLoad.addEventListener("click", function () {
                lblMessage.textContent = "";
                lblMessage.className = "kpi-error";
                resultWrapper.innerHTML = "";
                submitBtnWrapper.style.display = "none";
                currentFoundRows = [];
                currentEmployeeMap = {};

                var file = fileInput.files[0];
                if (!file) {
                    showErrorPopup("অনুগ্রহ করে একটি Excel file সিলেক্ট করুন।");
                    return;
                }

                setLoading(true);

                readExcelFile(file)
                    .then(function (kpiRows) {
                        if (!kpiRows.length) {
                            throw new Error("Excel file এ কোনো ডেটা পাওয়া যায়নি।");
                        }

                        var empIds = uniqueValues(kpiRows.map(function (r) { return String(r.EmpId).trim(); }));

                        return fetchEmployeesByCardNumbers(empIds).then(function (employeeMap) {
                            var foundRows = kpiRows.filter(function (r) { return !!employeeMap[r.EmpId]; });
                            var missingIds = empIds.filter(function (id) { return !employeeMap[id]; });
                            var missingRows = kpiRows.filter(function (r) { return missingIds.indexOf(r.EmpId) !== -1; });

                            currentFoundRows = foundRows;
                            currentEmployeeMap = employeeMap;

                            renderTable(foundRows, employeeMap);
                            submitBtnWrapper.style.display = foundRows.length ? "block" : "none";

                            if (missingIds.length) {
                                showMissingMessage(missingIds.length, missingRows);
                            }

                            showExcelPreviewModal();
                        });
                    })
                    .catch(function (err) {
                        console.error(err);
                        showErrorPopup(err.message || "একটি অপ্রত্যাশিত সমস্যা হয়েছে।");
                    })
                    .finally(function () {
                        setLoading(false);
                    });
            });

            // SUBMIT (inside excel preview modal) - sends an array of rows to the EXCEL import endpoint
            btnSubmit.addEventListener("click", function () {
                if (!currentFoundRows.length) {
                    showErrorPopup("Submit করার মতো কোনো ডেটা নেই।");
                    return;
                }

                var payload = currentFoundRows.map(function (row) {
                    var emp = currentEmployeeMap[row.EmpId];
                    return {
                        empId: emp.empId,
                        salaryMonth: toSalaryMonthDateString(row.SalaryMonth),
                        kpiScore: parseFloat(row.KPIScore) || 0,
                        kpiBonusAmount: parseFloat(row.KPIBonusAmount) || 0,
                        remarks: row.Remarks || ""
                    };
                });

                submitToApi(payload, btnSubmit, function () {
                    hideExcelPreviewModal();
                    loadKpiList();
                }, EXCEL_SUBMIT_URL, "POST");
            });

            // =====================================================================
            // SINGLE ENTRY FLOW (dropdown-based)
            // =====================================================================
            var EMPLOYEE_LIST_URL = ROOT_URL + "/api/Employee/employees?CompanyId=" + COMPANY_ID;
            var ddlEmployee = document.getElementById("ddlEmployee");
            var singleSalaryMonth = document.getElementById("singleSalaryMonth");
            var singleKpiScore = document.getElementById("singleKpiScore");
            var singleKpiBonus = document.getElementById("singleKpiBonus");
            var singleRemarks = document.getElementById("singleRemarks");
            var btnSingleSubmit = document.getElementById("btnSingleSubmit");
            var editingBanner = document.getElementById("editingBanner");
            var btnCancelEdit = document.getElementById("btnCancelEdit");

            var editingId = null; // null = create mode, otherwise the id being edited

            function loadEmployeeDropdown() {
                fetch(EMPLOYEE_LIST_URL, {
                    method: "GET",
                    headers: {
                        "Authorization": "Bearer " + TOKEN
                    }
                })
                    .catch(function () {
                        throw new Error("Employee list লোড করা যায়নি। API সার্ভারের সাথে সংযোগ করা যায়নি।");
                    })
                    .then(function (response) {
                        if (!response.ok) {
                            throw new Error("Employee list লোড করা যায়নি (status " + response.status + ")।");
                        }
                        return response.json();
                    })
                    .then(function (json) {
                        var list = Array.isArray(json) ? json : (json.data || json.result || []);

                        list.forEach(function (emp) {
                            var opt = document.createElement("option");
                            opt.value = emp.empId;
                            opt.textContent = emp.fullName;
                            ddlEmployee.appendChild(opt);
                        });
                    })
                    .catch(function (err) {
                        console.error(err);
                        showErrorPopup(err.message || "Employee list লোড করতে সমস্যা হয়েছে।");
                    });
            }

            // Searchable employee dropdown (select2 loads at the end of the master page)
            $(document).ready(function () {
                $(ddlEmployee).select2({ placeholder: "-- Select Employee --", allowClear: true, width: "100%" });
            });

            loadEmployeeDropdown();

            function resetSingleForm() {
                $(ddlEmployee).val("").trigger("change");
                singleSalaryMonth.value = "";
                singleKpiScore.value = "";
                singleKpiBonus.value = "";
                singleRemarks.value = "";
                editingId = null;
                editingBanner.style.display = "none";
                btnSingleSubmit.textContent = "SUBMIT";
            }

            btnCancelEdit.addEventListener("click", resetSingleForm);

            // SUBMIT (single entry) - sends a single JSON object; behaves as Create or Update
            btnSingleSubmit.addEventListener("click", function () {
                var empId = ddlEmployee.value;

                if (!empId) {
                    showErrorPopup("অনুগ্রহ করে একজন Employee সিলেক্ট করুন।");
                    return;
                }
                if (!singleSalaryMonth.value) {
                    showErrorPopup("অনুগ্রহ করে Salary Month সিলেক্ট করুন।");
                    return;
                }

                var payload = {
                    empId: empId,
                    salaryMonth: singleSalaryMonth.value, // <input type="date"> already gives yyyy-MM-dd
                    kpiScore: parseFloat(singleKpiScore.value) || 0,
                    kpiBonusAmount: parseFloat(singleKpiBonus.value) || 0,
                    remarks: singleRemarks.value || ""
                };

                if (editingId) {
                    // ---- UPDATE mode ----
                    submitToApi(payload, btnSingleSubmit, function () {
                        resetSingleForm();
                        loadKpiList();
                    }, KPI_UPDATE_URL + editingId, "PUT");
                } else {
                    // ---- CREATE mode ----
                    submitToApi(payload, btnSingleSubmit, function () {
                        resetSingleForm();
                        loadKpiList();
                    }, SUBMIT_URL, "POST");
                }
            });

            // =====================================================================
            // KPI LIST (view / search / edit / delete)
            // =====================================================================
            var kpiSearchBox = document.getElementById("kpiSearchBox");
            var kpiListTableWrapper = document.getElementById("kpiListTableWrapper");
            var kpiListData = [];

            function loadKpiList() {
                kpiListTableWrapper.innerHTML = "<p class='kpi-loading' style='display:block;'>List লোড হচ্ছে...</p>";

                fetch(KPI_LIST_URL, {
                    method: "GET",
                    headers: {
                        "Authorization": "Bearer " + TOKEN
                    }
                })
                    .catch(function () {
                        throw new Error("KPI List লোড করা যায়নি। API সার্ভারের সাথে সংযোগ করা যায়নি।");
                    })
                    .then(function (response) {
                        if (!response.ok) {
                            throw new Error("KPI List লোড করা যায়নি (status " + response.status + ")।");
                        }
                        return response.json();
                    })
                    .then(function (json) {
                        kpiListData = json.data || [];
                        renderKpiListTable(kpiListData);
                    })
                    .catch(function (err) {
                        console.error(err);
                        kpiListTableWrapper.innerHTML = "";
                        showErrorPopup(err.message || "KPI List লোড করতে সমস্যা হয়েছে।");
                    });
            }

            function renderKpiListTable(rows) {
                if (!rows.length) {
                    kpiListTableWrapper.innerHTML = "<p class='kpi-info' style='display:block;'>কোনো ডেটা পাওয়া যায়নি।</p>";
                    return;
                }

                var html = "<table class='kpi-table'><thead><tr>" +
                    "<th>Card No</th><th>Name</th><th>Department</th><th>Designation</th>" +
                    "<th>Shift</th><th>Unit</th><th>Salary Month</th><th>KPI Score</th><th>KPI Bonus</th><th>Action</th>" +
                    "</tr></thead><tbody>";

                rows.forEach(function (row) {
                    html += "<tr>" +
                        "<td>" + escapeHtml(row.empCardNo) + "</td>" +
                        "<td>" + escapeHtml(row.empName) + "</td>" +
                        "<td>" + escapeHtml(row.departmentName) + "</td>" +
                        "<td>" + escapeHtml(row.designationName) + "</td>" +
                        "<td>" + escapeHtml(row.shiftName) + "</td>" +
                        "<td>" + escapeHtml(row.unitName) + "</td>" +
                        "<td>" + escapeHtml(formatSalaryMonth(row.salaryMonth)) + "</td>" +
                        "<td>" + escapeHtml(row.kpiScore) + "</td>" +
                        "<td>" + escapeHtml(row.kpiBonusAmount) + "</td>" +
                        "<td>" +
                        "<span class='kpi-action-icon kpi-action-edit' title='Edit' data-id='" + escapeHtml(row.id) + "'>&#9998;</span>" +
                        "<span class='kpi-action-icon kpi-action-delete' title='Delete' data-id='" + escapeHtml(row.id) + "'>&#128465;</span>" +
                        "</td>" +
                        "</tr>";
                });

                html += "</tbody></table>";
                kpiListTableWrapper.innerHTML = html;

                kpiListTableWrapper.querySelectorAll(".kpi-action-edit").forEach(function (el) {
                    el.addEventListener("click", function () {
                        editKpiRecord(el.getAttribute("data-id"));
                    });
                });

                kpiListTableWrapper.querySelectorAll(".kpi-action-delete").forEach(function (el) {
                    el.addEventListener("click", function () {
                        deleteKpiRecord(el.getAttribute("data-id"));
                    });
                });
            }

            // "Search Any" - filters rows where ANY visible column contains the search text
            kpiSearchBox.addEventListener("input", function () {
                var term = kpiSearchBox.value.trim().toLowerCase();

                if (!term) {
                    renderKpiListTable(kpiListData);
                    return;
                }

                var filtered = kpiListData.filter(function (row) {
                    return Object.keys(row).some(function (key) {
                        var val = row[key];
                        return val !== null && val !== undefined && String(val).toLowerCase().indexOf(term) !== -1;
                    });
                });

                renderKpiListTable(filtered);
            });

            function editKpiRecord(id) {
                fetch(KPI_BY_ID_URL + id, {
                    method: "GET",
                    headers: {
                        "Authorization": "Bearer " + TOKEN
                    }
                })
                    .catch(function () {
                        throw new Error("রেকর্ড লোড করা যায়নি। API সার্ভারের সাথে সংযোগ করা যায়নি।");
                    })
                    .then(function (response) {
                        if (!response.ok) {
                            throw new Error("রেকর্ড লোড করা যায়নি (status " + response.status + ")।");
                        }
                        return response.json();
                    })
                    .then(function (json) {
                        var d = json.data;
                        if (!d) {
                            throw new Error("রেকর্ড পাওয়া যায়নি।");
                        }

                        $(ddlEmployee).val(d.empId).trigger("change");
                        singleSalaryMonth.value = toSalaryMonthDateString(d.salaryMonth);
                        singleKpiScore.value = d.kpiScore;
                        singleKpiBonus.value = d.kpiBonusAmount;
                        singleRemarks.value = d.remarks || "";

                        editingId = d.id;
                        editingBanner.style.display = "block";
                        btnSingleSubmit.textContent = "Update";

                        document.querySelector(".kpi-single-entry-panel").scrollIntoView({ behavior: "smooth", block: "start" });
                    })
                    .catch(function (err) {
                        console.error(err);
                        showErrorPopup(err.message || "রেকর্ড লোড করতে সমস্যা হয়েছে।");
                    });
            }

            function deleteKpiRecord(id) {
                if (!confirm("আপনি কি নিশ্চিত এই KPI রেকর্ডটি Delete করতে চান?")) {
                    return;
                }

                fetch(KPI_DELETE_URL + id, {
                    method: "DELETE",
                    headers: {
                        "Authorization": "Bearer " + TOKEN
                    }
                })
                    .catch(function () {
                        throw new Error("Delete করা যায়নি। API সার্ভারের সাথে সংযোগ করা যায়নি।");
                    })
                    .then(function (response) {
                        if (!response.ok) {
                            throw new Error("Delete ব্যর্থ হয়েছে (status " + response.status + ")।");
                        }
                        showSuccessPopup("রেকর্ডটি সফলভাবে Delete হয়েছে।");
                        loadKpiList();
                    })
                    .catch(function (err) {
                        console.error(err);
                        showErrorPopup(err.message || "Delete করতে সমস্যা হয়েছে।");
                    });
            }

            loadKpiList();

            // =====================================================================
            // SHARED: submit any payload (single object OR array) to a KPI API endpoint
            // =====================================================================
            function submitToApi(payload, triggerBtn, onSuccess, url, method) {
                url = url || SUBMIT_URL;
                method = method || "POST";

                var originalText = triggerBtn.textContent;
                triggerBtn.disabled = true;
                triggerBtn.textContent = "Saving...";

                fetch(url, {
                    method: method,
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "Bearer " + TOKEN
                    },
                    body: JSON.stringify(payload)
                })
                    .catch(function () {
                        throw new Error("API সার্ভারের সাথে সংযোগ করা যায়নি। সার্ভার চালু আছে কিনা এবং CORS সেটিংস ঠিক আছে কিনা চেক করুন।");
                    })
                    .then(function (response) {
                        if (!response.ok) {
                            return response.text().then(function (bodyText) {
                                var detail = "";
                                try {
                                    var errJson = JSON.parse(bodyText);
                                    // Try common ASP.NET error shapes: { message }, { title }, { errors: {...} }
                                    if (errJson.errors) {
                                        detail = Object.keys(errJson.errors)
                                            .map(function (k) { return k + ": " + errJson.errors[k].join(", "); })
                                            .join(" | ");
                                    } else {
                                        detail = errJson.message || errJson.title || bodyText;
                                    }
                                } catch (e) {
                                    detail = bodyText;
                                }
                                throw new Error("Submit ব্যর্থ হয়েছে (status " + response.status + ")। " + (detail || "বিস্তারিত পাওয়া যায়নি।"));
                            });
                        }
                        return response;
                    })
                    .then(function (response) {
                        var successMsg = (method === "PUT" || url.indexOf("/update") !== -1)
                            ? "KPI ডেটা সফলভাবে Update হয়েছে।"
                            : "KPI ডেটা সফলভাবে সাবমিট হয়েছে।";
                        showSuccessPopup(successMsg);
                        if (typeof onSuccess === "function") onSuccess();
                    })
                    .catch(function (err) {
                        console.error(err);
                        showErrorPopup(err.message || "একটি অপ্রত্যাশিত সমস্যা হয়েছে।");
                    })
                    .finally(function () {
                        triggerBtn.disabled = false;
                        triggerBtn.textContent = originalText;
                    });
            }

            // Converts a date/text SalaryMonth value into a "yyyy-MM-dd" string (DateOnly-compatible).
            function toSalaryMonthDateString(value) {
                var d = null;

                if (value instanceof Date) {
                    d = value;
                } else if (value !== null && value !== undefined && String(value).trim() !== "") {
                    var parsed = new Date(value);
                    if (!isNaN(parsed.getTime())) {
                        d = parsed;
                    }
                }

                if (!d) {
                    return value == null ? "" : String(value).trim();
                }

                var yyyy = d.getFullYear();
                var mm = String(d.getMonth() + 1).padStart(2, "0");
                var dd = String(d.getDate()).padStart(2, "0");
                return yyyy + "-" + mm + "-" + dd;
            }

            function setLoading(isLoading) {
                lblLoading.style.display = isLoading ? "inline" : "none";
                btnLoad.disabled = isLoading;
            }

            function uniqueValues(arr) {
                return arr.filter(function (v, i) { return arr.indexOf(v) === i; });
            }

            // ---------- Read Excel file entirely in the browser ----------
            function readExcelFile(file) {
                return new Promise(function (resolve, reject) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        try {
                            var data = new Uint8Array(e.target.result);
                            var workbook = XLSX.read(data, { type: "array", cellDates: true });
                            var firstSheetName = workbook.SheetNames[0];
                            var sheet = workbook.Sheets[firstSheetName];

                            var rows = XLSX.utils.sheet_to_json(sheet, { defval: "" });

                            if (rows.length === 0) {
                                resolve([]);
                                return;
                            }

                            var headers = Object.keys(rows[0]);
                            var missing = REQUIRED_COLUMNS.filter(function (col) { return headers.indexOf(col) === -1; });
                            if (missing.length) {
                                reject(new Error("Excel file এ এই কলাম(গুলো) পাওয়া যায়নি: " + missing.join(", ")));
                                return;
                            }

                            var kpiRows = rows
                                .filter(function (r) { return String(r.EmpId).trim() !== ""; })
                                .map(function (r) {
                                    return {
                                        EmpId: String(r.EmpId).trim(),
                                        SalaryMonth: r.SalaryMonth,
                                        KPIScore: String(r.KPIScore).trim(),
                                        KPIBonusAmount: String(r.KPIBonusAmount).trim(),
                                        Remarks: String(r.Remarks).trim()
                                    };
                                });

                            resolve(kpiRows);
                        } catch (err) {
                            reject(err);
                        }
                    };

                    reader.onerror = function () {
                        reject(new Error("Excel file পড়া যায়নি।"));
                    };

                    reader.readAsArrayBuffer(file);
                });
            }

            // ---------- Call the Employee API with EmpIds/card numbers (used by both flows) ----------
            function fetchEmployeesByCardNumbers(cardNumbers) {
                return fetch(API_URL, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "Bearer " + TOKEN
                    },
                    body: JSON.stringify({ cardNumbers: cardNumbers })
                })
                    .catch(function () {
                        throw new Error("API সার্ভারের সাথে সংযোগ করা যায়নি। সার্ভার চালু আছে কিনা এবং CORS সেটিংস ঠিক আছে কিনা চেক করুন।");
                    })
                    .then(function (response) {
                        if (!response.ok) {
                            throw new Error("API কল ব্যর্থ হয়েছে (status " + response.status + ")। অনুগ্রহ করে পুনরায় চেষ্টা করুন।");
                        }
                        return response.json();
                    })
                    .then(function (json) {
                        var list = Array.isArray(json) ? json : (json.data || json.result || []);

                        var map = {};
                        list.forEach(function (emp) {
                            // empProximityNo -> match key, empName -> Name, dptName -> Department, dsgName -> Designation
                            var proximityNo = emp.empProximityNo;
                            if (proximityNo) {
                                map[String(proximityNo).trim()] = {
                                    empId: emp.empId || "",
                                    name: emp.empName || "N/A",
                                    department: emp.dptName || "N/A",
                                    designation: emp.dsgName || "N/A"
                                };
                            }
                        });
                        return map;
                    });
            }

            // ---------- Missing employees message + Excel download ----------
            function showMissingMessage(count, missingRows) {
                lblMessage.innerHTML = "";
                lblMessage.className = "kpi-info";

                var textSpan = document.createElement("span");
                textSpan.textContent = count + " জন employee এর তথ্য API থেকে পাওয়া যায়নি। ";
                lblMessage.appendChild(textSpan);

                var downloadBtn = document.createElement("button");
                downloadBtn.type = "button";
                downloadBtn.textContent = "Missing Roster";
                downloadBtn.className = "btn btn-warning";
                downloadBtn.style.marginLeft = "8px";
                downloadBtn.addEventListener("click", function () {
                    downloadMissingExcel(missingRows);
                });
                lblMessage.appendChild(downloadBtn);
            }

            function downloadMissingExcel(missingRows) {
                var exportData = missingRows.map(function (row) {
                    return {
                        EmpId: row.EmpId,
                        SalaryMonth: formatSalaryMonth(row.SalaryMonth),
                        KPIScore: row.KPIScore,
                        KPIBonusAmount: row.KPIBonusAmount,
                        Remarks: row.Remarks
                    };
                });

                var worksheet = XLSX.utils.json_to_sheet(exportData);
                var wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, worksheet, "Missing Employees");
                XLSX.writeFile(wb, "Missing_Employees.xlsx");
            }

            // ---------- Demo Excel template download ----------
            function downloadDemoExcel() {
                var demoData = [
                    { EmpId: "1001", SalaryMonth: "2026-10-01", KPIScore: "85", KPIBonusAmount: "2000", Remarks: "Good performance" },
                    { EmpId: "1002", SalaryMonth: "2026-10-01", KPIScore: "70", KPIBonusAmount: "1000", Remarks: "" }
                ];

                var worksheet = XLSX.utils.json_to_sheet(demoData, { header: REQUIRED_COLUMNS });
                worksheet["!cols"] = [{ wch: 12 }, { wch: 14 }, { wch: 10 }, { wch: 16 }, { wch: 25 }];
                var wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, worksheet, "KPI");
                XLSX.writeFile(wb, "KPI_Demo.xlsx");
            }

            document.getElementById("btnDemoExcel").addEventListener("click", downloadDemoExcel);

            // ---------- Render preview table (inside modal) ----------
            function renderTable(kpiRows, employeeMap) {
                if (!kpiRows.length) {
                    resultWrapper.innerHTML = "";
                    return;
                }

                var html = "<table class='kpi-table'><thead><tr>" +
                    "<th>EmpId</th><th>Name</th><th>Department</th><th>Designation</th>" +
                    "<th>Salary Month</th><th>KPI Score</th><th>KPI Bonus Amount</th><th>Remarks</th>" +
                    "</tr></thead><tbody>";
                kpiRows.forEach(function (row) {
                    var emp = employeeMap[row.EmpId];
                    html += "<tr data-emp-id='" + escapeHtml(emp.empId) + "'>" +
                        "<td>" + escapeHtml(row.EmpId) + "</td>" +
                        "<td>" + escapeHtml(emp.name) + "</td>" +
                        "<td>" + escapeHtml(emp.department) + "</td>" +
                        "<td>" + escapeHtml(emp.designation) + "</td>" +
                        "<td>" + escapeHtml(formatSalaryMonth(row.SalaryMonth)) + "</td>" +
                        "<td>" + escapeHtml(row.KPIScore) + "</td>" +
                        "<td>" + escapeHtml(row.KPIBonusAmount) + "</td>" +
                        "<td>" + escapeHtml(row.Remarks) + "</td>" +
                        "</tr>";
                });

                html += "</tbody></table>";
                resultWrapper.innerHTML = html;
            }

            function formatSalaryMonth(value) {
                var d = null;

                if (value instanceof Date) {
                    d = value;
                } else if (value !== null && value !== undefined && String(value).trim() !== "") {
                    var parsed = new Date(value);
                    if (!isNaN(parsed.getTime())) {
                        d = parsed;
                    }
                }

                if (!d) {
                    return value == null ? "" : String(value).trim();
                }

                var dd = String(d.getDate()).padStart(2, "0");
                var mm = String(d.getMonth() + 1).padStart(2, "0");
                var yyyy = d.getFullYear();
                return dd + "-" + mm + "-" + yyyy;
            }

            function escapeHtml(str) {
                var div = document.createElement("div");
                div.textContent = str == null ? "" : String(str);
                return div.innerHTML;
            }
        })();
    </script>

</asp:Content>
