<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="KPIConfiguration.aspx.cs" Inherits="SigmaERP.hrms.payroll.KPIConfiguration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- SheetJS: client-side Excel reader -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <style>
        .kpi-upload-row {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

            .kpi-upload-row input[type="file"] {
                font-size: 12px;
            }

        .kpi-top-row {
            display: flex;
            gap: 12px;
            align-items: stretch;
            margin-bottom: 15px;
        }

        .kpi-excel-panel {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 12px 14px;
            background: #fafafa;
            width: 230px;
            flex-shrink: 0;
        }

            .kpi-excel-panel label {
                font-size: 12px;
                font-weight: 600;
                color: #555;
            }

        .btn-sm-compact {
            padding: 4px 12px;
            font-size: 12px;
        }

        /* KPI List section */
        .kpi-list-section {
            margin-top: 25px;
        }

        .kpi-list-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .kpi-search-box {
            padding: 6px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 13px;
            width: 260px;
            max-width: 100%;
        }

        .kpi-action-icon {
            cursor: pointer;
            font-size: 15px;
            margin: 0 4px;
            display: inline-block;
        }

        .kpi-action-edit {
            color: #2980b9;
        }

        .kpi-action-delete {
            color: #c0392b;
        }

        .kpi-action-icon:hover {
            opacity: 0.7;
        }

        .kpi-editing-banner {
            background: #fff8e1;
            border: 1px solid #ffe082;
            color: #8a6d00;
            padding: 6px 10px;
            border-radius: 4px;
            font-size: 12px;
            margin-bottom: 8px;
            display: none;
        }

        .kpi-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

            .kpi-table th, .kpi-table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
                font-size: 13px;
            }

            .kpi-table th {
                background-color: #f2f2f2;
            }

        .kpi-error {
            color: #c0392b;
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        .kpi-info {
            color: #2e7d32;
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        .kpi-loading {
            color: #555;
            font-style: italic;
            display: none;
            margin-top: 10px;
        }

        /* Popup modal (shared: error/success + excel preview) */
        .kpi-modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.45);
            z-index: 9999;
            align-items: center;
            justify-content: center;
        }

            .kpi-modal-overlay.show {
                display: flex;
            }

        .kpi-modal-box {
            background: #fff;
            border-radius: 8px;
            max-width: 420px;
            width: 90%;
            padding: 24px;
            box-shadow: 0 10px 35px rgba(0,0,0,0.25);
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
            width: 48px;
            height: 48px;
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
            color: #333;
            margin-bottom: 8px;
        }

        .kpi-modal-message {
            font-size: 14px;
            color: #555;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .kpi-modal-btn {
            background: #c0392b;
            color: #fff;
            border: none;
            padding: 8px 24px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }

            .kpi-modal-btn:hover {
                background: #a93226;
            }

        .border {
            border-bottom: 1px solid gray;
            width: 100%
        }

        /* Excel preview modal (bigger box) */
        .kpi-preview-box {
            background: #fff;
            border-radius: 8px;
            max-width: 950px;
            width: 95%;
            max-height: 85vh;
            padding: 20px 24px;
            box-shadow: 0 10px 35px rgba(0,0,0,0.25);
            text-align: left;
            animation: kpi-modal-in 0.18s ease-out;
            display: flex;
            flex-direction: column;
        }

        .kpi-preview-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .kpi-preview-close {
            background: none;
            border: none;
            font-size: 22px;
            cursor: pointer;
            color: #888;
            line-height: 1;
        }

            .kpi-preview-close:hover {
                color: #333;
            }

        .kpi-preview-body {
            overflow-y: auto;
        }

        /* Single entry panel */
        .kpi-single-entry-panel {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 12px 14px;
            background: #fafafa;
            flex: 1;
        }

        .kpi-single-row {
            display: flex;
            gap: 8px;
            margin-bottom: 8px;
        }

            .kpi-single-row > div {
                display: flex;
                flex-direction: column;
                min-width: 160px;
            }

                .kpi-single-row > div label {
                    font-size: 12px;
                    font-weight: 600;
                    color: #555;
                    margin-bottom: 4px;
                }

                .kpi-single-row > div input {
                    padding: 6px 8px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    font-size: 13px;
                }

                .kpi-single-row > div input[readonly] {
                    background: #eee;
                }

        .kpi-find-btn-wrap {
            justify-content: flex-end;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h3 class="text-center mt-4">KPI Bonus - Configuration</h3>
    <p class="border"></p>

    <div class="kpi-top-row">
        <!-- ============ Single Entry Panel ============ -->
        <div class="kpi-single-entry-panel">
            <h5>Single Entry</h5>

            <div id="editingBanner" class="kpi-editing-banner">
                আপনি একটি বিদ্যমান রেকর্ড Edit করছেন। <a href="javascript:void(0)" id="btnCancelEdit">বাতিল করুন</a>
            </div>

            <div class="kpi-single-row">
                <div>
                    <label>Employee</label>
                    <select id="ddlEmployee">
                        <option value="">-- Select Employee --</option>
                    </select>
                </div>
                <div>
                    <label>Salary Month</label>
                    <input type="date" id="singleSalaryMonth" />
                </div>
                <div>
                    <label>KPI Score</label>
                    <input type="number" id="singleKpiScore" step="any" />
                </div>
                <div>
                    <label>KPI Bonus Amount</label>
                    <input type="number" id="singleKpiBonus" step="any" />
                </div>
                <div style="flex: 1;">
                    <label>Remarks</label>
                    <input type="text" id="singleRemarks" />
                </div>
            </div>

            <div style="text-align: right;">
                <button type="button" id="btnSingleSubmit" class="btn btn-success btn-sm-compact">SUBMIT</button>
            </div>
        </div>

        <!-- ============ Excel Import (right side, compact) ============ -->
        <div class="kpi-excel-panel">
            <label>KPI Excel File</label>
            <div class="kpi-upload-row">
                <input type="file" id="fuKPIExcel" accept=".xlsx,.xls" />
                <button type="button" id="btnLoad" class="btn btn-primary btn-sm-compact">Load &amp; Process</button>
            </div>
        </div>
    </div>

    <span id="lblLoading" class="kpi-loading">Processing... please wait</span>

    <!-- ============ KPI List Section ============ -->
    <div class="kpi-list-section">
        <div class="kpi-list-header">
            <h5 style="margin: 0;">KPI List</h5>
            <input type="text" id="kpiSearchBox" class="kpi-search-box" placeholder="Search anything in the table..." />
        </div>
        <div id="kpiListTableWrapper"></div>
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
                <div id="resultTableWrapper"></div>
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
                document.querySelector(".kpi-modal-icon").textContent = "!";
                document.querySelector(".kpi-modal-icon").style.background = "#fdecea";
                document.querySelector(".kpi-modal-icon").style.color = "#c0392b";
                document.querySelector(".kpi-modal-title").textContent = "দুঃখিত!";
                modalMessage.textContent = message;
                modalOverlay.classList.add("show");
            }

            function showSuccessPopup(message) {
                document.querySelector(".kpi-modal-icon").textContent = "✓";
                document.querySelector(".kpi-modal-icon").style.background = "#e8f5e9";
                document.querySelector(".kpi-modal-icon").style.color = "#2e7d32";
                document.querySelector(".kpi-modal-title").textContent = "সফল হয়েছে!";
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

            loadEmployeeDropdown();

            function resetSingleForm() {
                ddlEmployee.value = "";
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

                        ddlEmployee.value = d.empId;
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
                            // empCard -> card number, empName -> Name, dptName -> Department, dsgName -> Designation
                            var cardNo = emp.empCard;
                            if (cardNo) {
                                map[String(cardNo).trim()] = {
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
