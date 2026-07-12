<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="KPIConfiguration.aspx.cs" Inherits="SigmaERP.hrms.payroll.KPIConfiguration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- SheetJS: client-side Excel reader -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <style>
        .kpi-upload-row {
            margin-bottom: 15px;
            display: flex;
            align-items: flex-end;
            gap: 15px;
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

        /* Popup modal for errors */
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h3 class="text-center mt-4">KPI Bonus - Configuration</h3>
    <p class="border"></p>

    <div class="kpi-upload-row">
        <div>
            <label>KPI Excel File</label><br />
            <input type="file" id="fuKPIExcel" accept=".xlsx,.xls" />
        </div>
        <div>
            <button type="button" id="btnLoad" class="btn btn-primary">Load &amp; Process</button>
        </div>
    </div>

    <span id="lblLoading" class="kpi-loading">Processing... please wait</span>
    <span id="lblMessage" class="kpi-error"></span>

    <div id="resultTableWrapper"></div>

    <!-- Error Popup Modal -->
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

            function showErrorPopup(message) {
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

            btnLoad.addEventListener("click", function () {
                lblMessage.textContent = "";
                lblMessage.className = "kpi-error";
                resultWrapper.innerHTML = "";

                var file = fileInput.files[0];
                if (!file) {
                    lblMessage.textContent = "অনুগ্রহ করে একটি Excel file সিলেক্ট করুন।";
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

                            renderTable(foundRows, employeeMap);

                            if (missingIds.length) {
                                showMissingMessage(missingIds.length, missingRows);
                            }
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

            function setLoading(isLoading) {
                lblLoading.style.display = isLoading ? "inline" : "none";
                btnLoad.disabled = isLoading;
            }

            function uniqueValues(arr) {
                return arr.filter(function (v, i) { return arr.indexOf(v) === i; });
            }

            // ---------- Step 1: Read Excel file entirely in the browser ----------
            function readExcelFile(file) {
                return new Promise(function (resolve, reject) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        try {
                            var data = new Uint8Array(e.target.result);
                            var workbook = XLSX.read(data, { type: "array", cellDates: true });
                            var firstSheetName = workbook.SheetNames[0];
                            var sheet = workbook.Sheets[firstSheetName];

                            // Convert to array of objects using header row as keys
                            var rows = XLSX.utils.sheet_to_json(sheet, { defval: "" });

                            if (rows.length === 0) {
                                resolve([]);
                                return;
                            }

                            // Validate required columns exist
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

            // ---------- Step 2: Call the Employee API with the EmpIds as card numbers ----------
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
                        // Network-level failure (server down, CORS blocked, no internet, etc.)
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
                            // Mapped to your actual API response fields:
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

            // ---------- Step 3: Merge Excel data + API data and render a plain HTML table ----------
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
                    // Not a recognizable date - show the original value as-is
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
