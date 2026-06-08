<%@ Page Title="" Language="C#" MasterPageFile="~/payroll_nested.master" AutoEventWireup="true" CodeBehind="HolidayAllowence.aspx.cs" Inherits="SigmaERP.payroll.HolidayAllowence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="scr1"></asp:ScriptManager>
    <asp:TextBox runat="server"  ID="lblMessage"></asp:TextBox>

    <!DOCTYPE html>
    <html lang="bn">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Holiday Allowance | Payroll</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.19.0/dist/tabler-icons.min.css" />
        <style>
            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0
            }

            body {
                font-family: 'Segoe UI',Tahoma,Arial,sans-serif;
                background: #f0f2f5;
                color: #1a1a1a;
                min-height: 100vh
            }

            .topbar {
                background: #fff;
                border-bottom: 1px solid #e0e4ea;
                padding: 0 24px;
                height: 54px;
                display: flex;
                align-items: center;
                gap: 10px
            }

            .topbar-icon {
                width: 32px;
                height: 32px;
                background: #E1F5EE;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center
            }

                .topbar-icon i {
                    font-size: 18px;
                    color: #0F6E56
                }

            .topbar-title {
                font-size: 15px;
                font-weight: 600;
                color: #111
            }

            .topbar-crumb {
                font-size: 12px;
                color: #aaa;
                margin-left: 2px
            }

            .main {
                padding: 20px 24px
            }

            /* Form card */
            .form-card {
                background: #fff;
                border: 1px solid #e0e4ea;
                border-radius: 12px;
                padding: 18px 20px;
                margin-bottom: 16px
            }

            .form-row {
                display: grid;
                grid-template-columns: repeat(4,1fr) auto;
                gap: 12px;
                align-items: end
            }

            .field {
                display: flex;
                flex-direction: column;
                gap: 5px
            }

                .field label {
                    font-size: 11px;
                    font-weight: 600;
                    color: #888;
                    letter-spacing: .4px;
                    text-transform: uppercase
                }

                .field select,
                .field input[type=number] {
                    height: 38px;
                    border: 1px solid #d5d9e0;
                    border-radius: 8px;
                    background: #fafafa;
                    color: #1a1a1a;
                    font-size: 13px;
                    padding: 0 11px;
                    width: 100%;
                    outline: none;
                    transition: border-color .15s,box-shadow .15s;
                    appearance: none;
                    -webkit-appearance: none
                }

                .field select {
                    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23999' stroke-width='2.5'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
                    background-repeat: no-repeat;
                    background-position: right 10px center;
                    padding-right: 28px
                }

                    .field select:focus,
                    .field input[type=number]:focus {
                        border-color: #1D9E75;
                        box-shadow: 0 0 0 3px rgba(29,158,117,.12);
                        background: #fff
                    }

                    .field select:hover,
                    .field input[type=number]:hover {
                        border-color: #b0b8c4
                    }

            /* salary type inline */
            .sal-inline {
                display: flex;
                gap: 6px;
                height: 38px;
                align-items: center
            }

            .radio-pill {
                display: flex;
                align-items: center;
                gap: 5px;
                padding: 0 13px;
                height: 36px;
                border: 1px solid #d5d9e0;
                border-radius: 999px;
                cursor: pointer;
                font-size: 13px;
                color: #666;
                background: #fafafa;
                transition: all .15s;
                user-select: none;
                white-space: nowrap
            }

                .radio-pill input {
                    display: none
                }

                .radio-pill.active {
                    background: #E1F5EE;
                    border-color: #1D9E75;
                    color: #0F6E56;
                    font-weight: 600
                }

            /* buttons */
            .btn-group {
                display: flex;
                gap: 8px;
                justify-content: flex-end
            }

            .switch {
                position: relative;
                display: inline-block;
                width: 50px;
                height: 24px;
            }

                /* hide default checkbox */
                .switch input {
                    opacity: 0;
                    width: 0;
                    height: 0;
                }

            /* slider */
            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 34px;
            }

                .slider:before {
                    position: absolute;
                    content: "";
                    height: 18px;
                    width: 18px;
                    left: 3px;
                    bottom: 3px;
                    background-color: white;
                    transition: .4s;
                    border-radius: 50%;
                }

            /* checked state */
            .switch input:checked + .slider {
                background-color: #28a745;
            }

                .switch input:checked + .slider:before {
                    transform: translateX(26px);
                }

      

            .btn {
                height: 38px;
                padding: 0 16px;
                border-radius: 8px;
                font-size: 13px;
                font-weight: 500;
                cursor: pointer;
                border: 1px solid #d5d9e0;
                background: #fff;
                color: #333;
                transition: all .15s;
                display: inline-flex;
                align-items: center;
                gap: 5px;
                white-space: nowrap
            }

                .btn:hover {
                    background: #f5f6f8
                }

                .btn:active {
                    transform: scale(.98)
                }

            .btn-primary {
                background: #1D9E75;
                border-color: #1D9E75;
                color: #fff
            }

                .btn-primary:hover {
                    background: #0F6E56;
                    border-color: #0F6E56
                }

            .btn-ghost-danger {
                height: 28px;
                padding: 0 9px;
                font-size: 12px;
                color: #A32D2D;
                border: 1px solid #F09595;
                background: #fff;
                border-radius: 6px
            }

                .btn-ghost-danger:hover {
                    background: #FCEBEB
                }
                #btnsave {
    font-family: "tabler-icons", 'Segoe UI', sans-serif;
}

            /* table card */
            .table-card {
                background: #fff;
                border: 1px solid #e0e4ea;
                border-radius: 12px;
                overflow: hidden
            }

            .table-toolbar {
                padding: 11px 16px;
                background: #fafafa;
                border-bottom: 1px solid #f0f2f5;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 8px
            }

            .tbl-title {
                font-size: 13px;
                font-weight: 600;
                color: #222;
                display: flex;
                align-items: center;
                gap: 7px
            }

            .badge {
                display: inline-flex;
                align-items: center;
                padding: 2px 9px;
                border-radius: 999px;
                font-size: 11px;
                font-weight: 600;
                background: #E1F5EE;
                color: #085041
            }

            .tbl-wrap {
                overflow-x: auto
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 13px;
                min-width: 560px
            }

            thead th {
                padding: 9px 14px;
                text-align: left;
                font-size: 11px;
                font-weight: 600;
                color: #999;
                letter-spacing: .4px;
                text-transform: uppercase;
                background: #fafafa;
                border-bottom: 1px solid #e8eaed
            }

            tbody tr {
                border-bottom: 1px solid #f4f5f7;
                transition: background .1s
            }

                tbody tr:last-child {
                    border-bottom: none
                }

                tbody tr:hover {
                    background: #f9fafb
                }

            tbody td {
                padding: 10px 14px;
                vertical-align: middle;
                color: #222
            }

            .sal-badge {
                display: inline-flex;
                align-items: center;
                padding: 3px 9px;
                border-radius: 5px;
                font-size: 11px;
                font-weight: 600
            }

            .sal-basic {
                background: #E6F1FB;
                color: #0C447C
            }

            .sal-gross {
                background: #FAEEDA;
                color: #633806
            }

            .multi-val {
                font-weight: 600;
                color: #0F6E56
            }

            .sl {
                color: #ccc;
                font-size: 12px
            }

            .empty {
                padding: 44px 20px;
                text-align: center
            }

                .empty i {
                    font-size: 34px;
                    display: block;
                    margin-bottom: 10px;
                    color: #ddd
                }

                .empty p {
                    color: #bbb;
                    font-size: 13px
                }

            /* responsive */
            @media(max-width:900px) {
                .form-row {
                    grid-template-columns: 1fr 1fr;
                    gap: 10px
                }

                    .form-row > .btn-group {
                        grid-column: 1/-1;
                        justify-content: flex-end
                    }
            }

            @media(max-width:520px) {
                .main {
                    padding: 14px
                }

                .form-card {
                    padding: 14px
                }

                .form-row {
                    grid-template-columns: 1fr
                }

                    .form-row > .btn-group {
                        grid-column: 1/-1
                    }

                .btn-group {
                    flex-direction: row;
                    justify-content: flex-end
                }

                .topbar {
                    padding: 0 14px
                }
            }
        </style>

    </head>
    <body>
                <asp:UpdatePanel runat="server" ID="up2">
                        <ContentTemplate>
        <div class="topbar">
            <div class="topbar-icon"><i class="ti ti-beach" aria-hidden="true"></i></div>
            <div>
                <span class="topbar-title">Holiday Allowance</span>
                <span class="topbar-crumb">/ Payroll / Holiday Management</span>
            </div>
        </div>

        <div class="main">

            <!-- Form Row Card -->
            <div class="form-card">
                <div class="form-row">

                    <div class="field">
                        <label for="sel-company">Company</label>
                        <asp:DropDownList runat="server" ID="ddlCompanyList"></asp:DropDownList>
                    </div>

                    <div class="field">
                        <label for="sel-holiday">Holiday List</label>
                        <asp:DropDownList runat="server" ID="ddlholidaylist"></asp:DropDownList>
                    </div>

                    <div class="field">
                        <label>Salary Type</label>
                        <div class="sal-inline">
                            <label class="radio-pill active" id="pill-basic">
                                <asp:RadioButton ID="rdoBasic" runat="server"
                                    GroupName="saltype"
                                    Text="Basic"
                                    Checked="true" />
                            </label>
                            <label class="radio-pill" id="pill-gross">
                                <asp:RadioButton ID="rdoGross" runat="server"
                                    GroupName="saltype"
                                    Text="Gross" />
                            </label>
                        </div>
                    </div>

                    <div class="field">
                        <label for="inp-multi">Multiplier (কতগুণ)</label>
                        <asp:TextBox runat="server" type="number" ID="txtMultiplier" placeholder="e.g. 1, 1.5, 2" min="0.25" step="0.25"></asp:TextBox>
                    </div>

                    <!-- Buttons aligned right -->
                    <div class="btn-group">
                        <button class="btn" onclick="resetForm()">
                            <i class="ti ti-refresh" style="font-size: 14px" aria-hidden="true"></i>Reset
                        </button>
                        <asp:Button runat="server"
                            ID="btnsave"
                            CssClass="btn btn-primary"
                            OnClick="btnsave_Click"
                            Text="&#xe607; Add" />
                       

                    </div>

                </div>
            </div>

            <!-- Table Card -->
            <div class="table-card">
                <div class="table-toolbar">
                    <div class="tbl-title">
                        <i class="ti ti-table" style="font-size: 16px; color: #1D9E75" aria-hidden="true"></i>
                        Holiday Allowance List
                    </div>
                    
                </div>

                <div class="tbl-wrap">
            
                             <asp:GridView ID="gvHolidayAllowance" runat="server"
    AutoGenerateColumns="False" DataKeyNames="AllowanceID" OnRowCommand="gvHolidayAllowance_RowCommand"
    CssClass="table table-bordered table-striped"
    EmptyDataText="No data found"> 
    <Columns>

        <asp:TemplateField HeaderText="#">
            <ItemTemplate>
                <%# Container.DataItemIndex + 1 %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="CompanyId" HeaderText="Company" />

        <asp:BoundField DataField="Holiday" HeaderText="Holiday" />

        <asp:BoundField DataField="SalaryType" HeaderText="Salary Type" />

        <asp:BoundField DataField="Multiplier" HeaderText="Multiplier" />
<asp:TemplateField HeaderText="Active">
    <ItemTemplate>

        <label class="switch">

            <asp:CheckBox ID="chkIsActive"
                runat="server"
                AutoPostBack="true"
                OnCheckedChanged="chkIsActive_CheckedChanged"
                Checked='<%# Convert.ToBoolean(Eval("IsActive")) %>' />

            <span class="slider"></span>

        </label>
    </ItemTemplate>
</asp:TemplateField>

        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>

                <asp:LinkButton ID="lnkEdit"
                    runat="server"
                    CssClass="btn btn-primary btn-sm"
                    CommandName="EditRow"
                    CommandArgument='<%# Eval("AllowanceID") %>'>
            <i class="fa fa-edit"></i>
                </asp:LinkButton>

                <asp:LinkButton ID="lnkDelete"
                    runat="server"
                    CssClass="btn btn-danger btn-sm"
                    CommandName="DeleteRow"
                    CommandArgument='<%# Eval("AllowanceID") %>'
                    OnClientClick="return confirm('Are you sure to delete?');">
            <i class="fa fa-trash"></i>
                </asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>
                        </ContentTemplate>

                    </asp:UpdatePanel>
                    
               
                </div>
            </div>

        </div>

        <script>
            let rows = [];

            document.querySelectorAll('.radio-pill').forEach(p => {
                p.addEventListener('click', () => {
                    document.querySelectorAll('.radio-pill').forEach(x => x.classList.remove('active'));
                    p.classList.add('active');
                });
            });

            function addRow() {
                const company = document.getElementById('sel-company').value;
                const holiday = document.getElementById('sel-holiday').value;
                const multi = document.getElementById('inp-multi').value;
                const rdoBasic = document.getElementById('<%= rdoBasic.ClientID %>');
                const saltype  = rdoBasic.checked ? 'Basic' : 'Gross';
                if (!company || !holiday || !multi) { alert('সব ফিল্ড পূরণ করুন।'); return; }
                rows.push({ company, holiday, saltype, multi: parseFloat(multi) });
                render(); resetForm();
            }

            function deleteRow(i) { rows.splice(i, 1); render(); }

            function render() {
                const tbl = document.getElementById('main-table');
                const empty = document.getElementById('empty-msg');
                document.getElementById('row-count').textContent = rows.length + (rows.length === 1 ? ' entry' : ' entries');
                if (!rows.length) { tbl.style.display = 'none'; empty.style.display = 'block'; return; }
                empty.style.display = 'none'; tbl.style.display = 'table';
                document.getElementById('tbl-body').innerHTML = rows.map((r, i) => `
    <tr>
      <td class="sl">${i + 1}</td>
      <td>${r.company}</td>
      <td>${r.holiday}</td>
      <td><span class="sal-badge sal-${r.saltype.toLowerCase()}">${r.saltype}</span></td>
      <td class="multi-val">&times;&thinsp;${r.multi.toFixed(2)}</td>
      <td><button class="btn-ghost-danger" onclick="deleteRow(${i})" aria-label="Delete"><i class="ti ti-trash" style="font-size:13px" aria-hidden="true"></i></button></td>
    </tr>`).join('');
            }

            function resetForm() {
                document.getElementById('sel-company').value = '';
                document.getElementById('sel-holiday').value = '';
                document.getElementById('inp-multi').value = '';
                document.getElementById('<%= rdoBasic.ClientID %>').checked = true;
                document.getElementById('<%= rdoGross.ClientID %>').checked = false;
                document.getElementById('pill-basic').classList.add('active');
                document.getElementById('pill-gross').classList.remove('active');
                document.querySelectorAll('.radio-pill').forEach(p => p.classList.remove('active'));
                document.getElementById('pill-basic').classList.add('active');
              
            }

            function clearAll() { if (!rows.length) return; rows = []; render(); }
        </script>
    </body>
    </html>

</asp:Content>
