using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.payroll.salary
{
    public partial class salary_sheet : System.Web.UI.Page
    {
        //Permission=337
        protected void Page_Load(object sender, EventArgs e)
        {
           
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            lblMessage.InnerText = "";
            if (!IsPostBack)
            {
                int[] pagePermission = { 337, 474 };
                int[] userPagePermition = AccessControl.hasPermission(pagePermission);
                if (!userPagePermition.Any())
                    Response.Redirect(Routing.defualtUrl);

                classes.commonTask._loadEmpTye(rblEmployeeType);
              
                rblEmployeeType.SelectedValue = "1";


                ViewState["__salaryGenerateFor__"] = "compliance";
                string url = Request.Url.ToString();
                string[] parts = url.Split('/');
                string value = parts[5];
                if (value == "regular")
                {
                    ViewState["__salaryGenerateFor__"] = value;
                    heading.InnerText = "Salary Sheet Report(Regular)";
                }
                setPrivilege(userPagePermition);

                if (!classes.commonTask.HasBranch())
                    ddlCompanyName.Enabled = false;
                ddlCompanyName.SelectedValue = ViewState["__CompanyId__"].ToString();
                ViewState["__IsGerments__"] = classes.commonTask.IsGarments();
                //if (!bool.Parse(ViewState["__IsGerments__"].ToString()))
                //    trHideForIndividual.Visible = false;

            }
        }
        DataTable dtSetPrivilege;
        private void setPrivilege(int[] permissions)
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];

                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__CShortName__"] = "MRC";
                classes.commonTask.LoadBranch(ddlCompanyName, ViewState["__CompanyId__"].ToString());
                classes.commonTask.LoadShift(ddlShift, ViewState["__CompanyId__"].ToString());
                if (permissions.Contains(474))
                {
                    chkbanksheet.Visible = true;
                }
                //------------load privilege setting inof from db------
                //string[] AccessPermission = new string[0];
                //AccessPermission = checkUserPrivilege.checkUserPrivilegeForReport(ViewState["__CompanyId__"].ToString(), getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "salary_sheet_Report.aspx", ddlCompanyName, WarningMessage, tblGenerateType, btnPreview);
                //ViewState["__ReadAction__"] = AccessPermission[0];
                commonTask.LoadDepartmentByCompanyInListBox(ViewState["__CompanyId__"].ToString(), lstAll);
                if (ViewState["__salaryGenerateFor__"].ToString() == "regular")
                    classes.Payroll.loadMonthIdByCompany(ddlSelectMonth, ViewState["__CompanyId__"].ToString());
                else
                    classes.Payroll.loadMonthIdByCompanyForComplaince(ddlSelectMonth, ViewState["__CompanyId__"].ToString());

                commonTask.loadBankNameCompanyWise(ViewState["__CompanyId__"].ToString(), ddlBankSheet);
                classes.commonTask.loadUnit(ddlUnit, ViewState["__CompanyId__"].ToString());
                //-----------------------------------------------------


            }
            catch { }
        }
       

        protected void rblGenerateType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {


                if (!rblGenerateType.SelectedItem.Text.Equals("All"))
                {
                    txtEmpCardNo.Enabled = true;
                    pnl1.Enabled = false;
                    rblEmployeeType.Visible = false;
                    trHideForIndividualLabel.Visible = false;
                    pnl1.Visible = false;
                    txtEmpCardNo.Focus();

                }
                else
                {
                    txtEmpCardNo.Enabled = false;
                    pnl1.Enabled = true;
                    rblEmployeeType.Visible = true;
                    trHideForIndividualLabel.Visible = true;
                    pnl1.Visible = true;
                    rblEmployeeType.SelectedValue = "1";
                    rblPaymentType.SelectedValue = "Cash";
                }
                //if (!bool.Parse(ViewState["__IsGerments__"].ToString()))
                //    trHideForIndividual.Visible = false;
            }
            catch { }
        }

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            if (ddlSelectMonth.SelectedValue == "0")
            { lblMessage.InnerText = "warning->Please select any Month!"; ddlSelectMonth.Focus(); return; }
            if (rblGenerateType.SelectedItem.Text.Equals("All") && lstSelected.Items.Count < 1) { lblMessage.InnerText = "warning->Please select any Department"; lstSelected.Focus(); return; }
            if (!rblGenerateType.SelectedItem.Text.Equals("All") && txtEmpCardNo.Text.Trim().Length < 4) { lblMessage.InnerText = "warning->Please type valid Card No!(Minimum last 4 digit.)"; txtEmpCardNo.Focus(); return; }
        
               generateSalarySheet();
        }
        private void generateSalarySheet()
        {
            try
            {
                string tableName = "v_MonthlySalarySheet";
                if (ViewState["__salaryGenerateFor__"].ToString() == "compliance")
                    tableName = "v_MonthlySalarySheet_Compliance";


                string bMnth = "";
                string CompanyList = "";
                string DepartmentList = "";

                string[] monthInfo = ddlSelectMonth.SelectedValue.Split('/');
                string yearMonth = "";
                if (monthInfo.Length > 1)
                {
                    yearMonth = " AND YearMonth='" + monthInfo[0] + "' AND FromDate='" + monthInfo[1] + "' AND ToDate='" + monthInfo[2] + "'";
                    bMnth = " GenerateDate >= '" + monthInfo[1] + "' AND GenerateDate<= '" + monthInfo[2] + "'";
                }

                else
                {
                    yearMonth = " AND YearMonth='" + monthInfo[0] + "'";
                }
               

                if (!Page.IsValid)  
                {
                    lblMessage.InnerText = "erroe->Please Select From Date And To Date"; return;
                }
   
                string Condition = "";

                if (rblGenerateType.SelectedValue == "1")
                {
                    // Only search by EmpCardNo and CompanyId (ignore all other filters)
                    string empCardNo = txtEmpCardNo.Text.Trim();
                    string companyId = ddlCompanyName.SelectedValue.Equals("0000")
                                        ? ViewState["__CompanyId__"].ToString()
                                        : ddlCompanyName.SelectedValue.ToString();

                    Condition = " AND (EmpCardNo LIKE '%" + empCardNo + "' OR EmpProximityNo='"+empCardNo+"' )  AND CompanyId = '" + companyId + "'";
                }
                else
                {
                    DepartmentList = classes.commonTask.getDepartmentList(lstSelected);
                    string companyId = ddlCompanyName.SelectedValue.Equals("0000")
                    ? ViewState["__CompanyId__"].ToString()
                    : ddlCompanyName.SelectedValue.ToString();
                    if (rblEmployeeType.SelectedValue != "0")
                    {
                        Condition += " AND EmpTypeId = " + rblEmployeeType.SelectedValue;
                    }

                    if (bool.Parse(ViewState["__IsGerments__"].ToString()))
                    {
                        Condition += " AND SalaryCount = '" + rblPaymentType.SelectedValue + "'";
                    }

                    Condition += " AND CompanyId = '" + companyId + "' and DptId " + DepartmentList + " ";

                }
                 if(rblSheet.SelectedValue == "1")
                    {
                        Condition += "and IsSeperationGeneration='1'";
                    }
                 if(ddlShift.SelectedValue !=null && ddlShift.SelectedValue != "0")
                {
                    Condition += "and sftId ='" + ddlShift.SelectedValue + "'";
                }

                if(ddlUnit.SelectedValue!="0")
                    Condition += "and unitId ='" + ddlShift.SelectedValue + "'";
                string getSQLCMD;
                DataTable dt = new DataTable();
                if (chkIsBankfordQatar.Checked)
                {
                    if (ddlBankSheet.SelectedIndex >= 0)
                    {
                        banksheetGenarate(yearMonth, DepartmentList,rblSheet.SelectedValue, bMnth);
                        return;

                    }
                }
                
              
                if (chkBankForwardingLetter.Checked)
                {
                    getSQLCMD = "SELECT  EmpProximityNo as Sl,EmpId, EmpName, Substring(EmpCardNo,10,6) as EmpCardNo, DptName, DptId, CompanyId, TotalSalary, MobileNo,Format(YearMonth,'MMMM-yyyy') as YearMonth ,CompanyName ,EmpAccountNo  FROM   "+ tableName + " where " +
                           " IsActive='1' " + yearMonth + " " + Condition + "  AND SalaryCount='Bank' and IsSeperationGeneration='0' " +
                           " ORDER BY CONVERT(int,DptId), CustomOrdering ";
                    Session["__ReportTitle__"] = "";
                    sqlDB.fillDataTable(getSQLCMD, dt);
                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.InnerText = "warning->Data not found."; return;
                    }
                    Session["__SalarySheetBankFordLetter__"] = dt;
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=SalarySheetBankFordLetter');", true);
                }
                else if (chkExcel.Checked)
                {
                    getSQLCMD = @"select SUBSTRING(EmpCardNo,8,6) as [Card No],EmpName as [Name],DptName as [Department],DsgName as [Designation],PresentDay as [Present] ,AbsentDay as [Absent],(CasualLeave + SickLeave + AnnualLeave) as [Leave],(WeekendHoliday+FestivalHoliday
) as [W&H],EmpPresentSalary as [Gross Salary],AbsentDeduction as [Absent Deduction],AdvanceDeduction as [Advance],ProfitTax as [Tax],OthersDeduction as [Others Deduction],(AbsentDeduction + AdvanceDeduction + OthersDeduction + ProfitTax) as [Total Deduction],TotalSalary as [Net Payable] from  " + tableName + " where IsActive='1' " + yearMonth + " " + Condition + "  and IsSeperationGeneration='0' " +
                           " ORDER BY CONVERT(int,DptId), CustomOrdering ";
                    sqlDB.fillDataTable(getSQLCMD, dt);
                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.InnerText = "warning->Data not found."; return;
                    }
                    Session["__salarySheetExcel__"] = dt;
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/payroll/salary/salary_sheet_excel.aspx?for=SalarySheet&&company=" + ddlCompanyName.SelectedItem.Text + "&&month=" + ddlSelectMonth.SelectedItem.Text.Trim() + "');", true);
                }

                else if (chkBKashForwardingLetterXL.Checked)
                {
                    getSQLCMD = @"select  SUBSTRING(EmpCardNo,8,6) as [Card No],EmpName as [Name],EmpAccountNo as[Account No],TotalSalary as [Net Payable] from  " + tableName + " where SalaryCount='Bkash' AND IsActive='1' " + yearMonth + " " + Condition + " " +
                          " ORDER BY CONVERT(int,DptId), CustomOrdering ";
                    sqlDB.fillDataTable(getSQLCMD, dt);
                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.InnerText = "warning->Data not found."; return;
                    }
                    Session["__salarySheetExcel__"] = dt;
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me",
            "goToNewTabandWindow('/payroll/salary/salary_sheet_excel.aspx?for=SalaryBankForwardingSheet&&company="
            + ddlCompanyName.SelectedItem.Text
            + "&&month=" + ddlSelectMonth.SelectedItem.Text.Trim()
            + "&&PaymentType=Bkash');", true);
                }

                else if (chkBankForwardingLetterXL.Checked)
                {
                  
                    getSQLCMD = @"select SUBSTRING(EmpCardNo,8,6) as [Card No],EmpName as [Name],EmpAccountNo as[Account No],TotalSalary as [Net Payable] from  " + tableName + " where SalaryCount='Bank' AND IsActive='1' " + yearMonth + " " + Condition + " " +
                           " ORDER BY CONVERT(int,DptId), CustomOrdering ";
                    sqlDB.fillDataTable(getSQLCMD, dt);
                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.InnerText = "warning->Data not found."; return;
                    }
                    Session["__salarySheetExcel__"] = dt;
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me",
                  "goToNewTabandWindow('/payroll/salary/salary_sheet_excel.aspx?for=SalaryBankForwardingSheet&&company="
                  + ddlCompanyName.SelectedItem.Text
                  + "&&month=" + ddlSelectMonth.SelectedItem.Text.Trim()
                  + "&&PaymentType=Bank');", true);
                }
                else if (rblReportType.SelectedValue == "sheet" || rblReportType.SelectedValue == "slip" || rblReportType.SelectedValue == "holidayallowance")
                {
                    string holidayAllowance = "";
                    if (rblReportType.SelectedValue == "holidayallowance")
                        holidayAllowance = "and HoliDayBillAmount !='0'";

                    if (rblGenerateType.SelectedItem.Text.Equals("All"))
                    {
                        if (rblSheet.SelectedValue == "0")
                        {
                            getSQLCMD = "SELECT EmpProximityNo as Sl,EmpId, EmpName,EmptypeId, PaymentMethod,EmpPicture, EmpAccountNo, Substring(EmpCardNo,10,6) as EmpCardNo , AbsentDay, BasicSalary, HouseRent, MedicalAllownce, AbsentDeduction, " +
                                " OverTime as TotalOTHour, OTRate, round(OverTimeAmount,0) as TotalOTAmount, AttendanceBonus, DptName, CompanyName, SftId,SftName, EmpPresentSalary, Address,HolidayWorkingDays,HolidayTaka,HoliDayBillAmount," +
                                " DptId, CompanyId, DsgName, TotalSalary, GrdName, GId, GName, PresentDay,WeekendHoliday,FestivalHoliday, PayableDays, Payable,NetPayable, OthersAllownce, ProvidentFund, ProfitTax, LateFine, TiffinDays, TiffinTaka, TiffinBillAmount,CasualLeave,SickLeave,AnnualLeave,OfficialLeave,DormitoryRent,TotalOverTime,TotalOtherOverTime,DaysInMonth,OthersPay,OthersDeduction,lwp as ShortLeave,AdvanceDeduction,LateDays,ConvenceAllownce,NightbilAmount,NightBillDays,convert(varchar(10), EmpJoiningDate,105) EmpJoiningDate,Stampdeduct,FoodAllownce,Activeday,EmpNetGross,EmpNameBn, DptNameBn,Additional,DsgNameBn, GrdNameBangla " +
                                " FROM   " + tableName + " " +
                                " where " +
                                " IsActive='1' " + yearMonth + " " + Condition + "  AND IsSeperationGeneration='0' " + holidayAllowance + " " +
                                " ORDER BY SftName, CONVERT(int,DptId),convert(int,Gid), CustomOrdering";
                            Session["__ReportTitle__"] = "";
                        }
                        else
                        {
                            getSQLCMD = "SELECT EmpProximityNo as Sl,EmpId, EmpName,EmptypeId,EmpPicture, Substring(EmpCardNo,10,6) as EmpCardNo , AbsentDay, BasicSalary,PaymentMethod, HouseRent, MedicalAllownce, AbsentDeduction, " +
                                 " OverTime as TotalOTHour, OTRate, round(OverTimeAmount,0) as TotalOTAmount, AttendanceBonus, DptName, CompanyName, SftId,SftName, EmpPresentSalary, Address,HolidayWorkingDays,HolidayTaka,HoliDayBillAmount," +
                                 " DptId, CompanyId, DsgName, TotalSalary, GrdName, GId, GName, PresentDay,WeekendHoliday,HoliDayBillAmount,HolidayWorkingDays,HolidayTaka, FestivalHoliday, PayableDays, Payable, NetPayable, OthersAllownce, ProvidentFund, ProfitTax, LateFine, TiffinDays, TiffinTaka, TiffinBillAmount,CasualLeave,SickLeave,AnnualLeave,OfficialLeave,DormitoryRent,TotalOverTime,TotalOtherOverTime,DaysInMonth,OthersPay,OthersDeduction,lwp as ShortLeave,AdvanceDeduction,LateDays,ConvenceAllownce,NightbilAmount,NightBillDays,convert(varchar(10), EmpJoiningDate,105) EmpJoiningDate,Stampdeduct,FoodAllownce,Activeday,EmpNetGross,SeparationTypeName,EmpNameBn, DptNameBn, DsgNameBn, GrdNameBangla " +
                                 " FROM   " + tableName + " " +
                                 " where " +
                                 " IsActive='1' " + yearMonth + " " + Condition + "  "+ holidayAllowance + "" +
                                 " ORDER BY CONVERT(int,DptId),convert(int,Gid), CustomOrdering";
                            Session["__ReportTitle__"] = "[Separation]";
                        }


                        sqlDB.fillDataTable(getSQLCMD, dt);
                        if (dt.Rows.Count == 0)
                        {
                            lblMessage.InnerText = "warning->Data not found."; return;
                        }


                    }
                    else
                    {
                        if (rblSheet.SelectedValue == "0")
                        {
                            getSQLCMD = "SELECT EmpProximityNo as Sl,EmpId, EmpName,EmptypeId,EmpAccountNo,EmpPicture,PaymentMethod,Substring(EmpCardNo,10,6) as EmpCardNo, AbsentDay, BasicSalary,SalaryCount, HouseRent, MedicalAllownce, AbsentDeduction, " +
                               " OverTime as TotalOTHour, OTRate, round(OverTimeAmount,0) as TotalOTAmount, AttendanceBonus, DptName, CompanyName, SftId,SftName, EmpPresentSalary, Address,HolidayWorkingDays,HolidayTaka,HoliDayBillAmount," +
                               " DptId, CompanyId, DsgName, TotalSalary, GrdName, GId, GName, PresentDay,WeekendHoliday,FestivalHoliday,HoliDayBillAmount,HolidayWorkingDays,HolidayTaka, PayableDays, Payable,round(NetPayable,0) as NetPayable, OthersAllownce, ProvidentFund, ProfitTax, LateFine, TiffinDays, TiffinTaka, HoliDayBillAmount,HolidayWorkingDays,HolidayTaka, TiffinBillAmount,CasualLeave,SickLeave,AnnualLeave,OfficialLeave,SalaryCount,DormitoryRent,TotalOverTime,TotalOtherOverTime,DaysInMonth,OthersPay,OthersDeduction,lwp as ShortLeave,AdvanceDeduction,LateDays,ConvenceAllownce,NightbilAmount,NightBillDays,convert(varchar(10), EmpJoiningDate,105) EmpJoiningDate,Stampdeduct,FoodAllownce,Activeday,EmpNetGross,EmpNameBn, DptNameBn, DsgNameBn, GrdNameBangla " +
                               " FROM   " + tableName + " " +
                               " where " +
                               " IsActive='1' " + yearMonth + " AND (EmpCardNo Like '%" + txtEmpCardNo.Text.Trim() + "' OR EmpProximityNo='"+txtEmpCardNo.Text.Trim()+ "') AND IsSeperationGeneration='0' " + holidayAllowance + "" +
                               " ORDER BY SftName, CONVERT(int,DptId),convert(int,Gid), CustomOrdering";
                            Session["__ReportTitle__"] = "";
                        }
                        else
                        {
                            getSQLCMD = "SELECT EmpProximityNo as Sl,EmpId, EmpName,EmptypeId, Substring(EmpCardNo,10,6) as EmpCardNo, AbsentDay,PaymentMethod,EmpPicture, BasicSalary, HouseRent, MedicalAllownce, AbsentDeduction, " +
                                " OverTime as TotalOTHour, OTRate, round(OverTimeAmount,0) as TotalOTAmount, AttendanceBonus, DptName, CompanyName, SftId,SftName, EmpPresentSalary, Address,HolidayWorkingDays,HolidayTaka,HoliDayBillAmount," +
                                " DptId, CompanyId, DsgName, TotalSalary, GrdName, GId, GName,HoliDayBillAmount,HolidayWorkingDays,HolidayTaka,  PresentDay,WeekendHoliday,FestivalHoliday, PayableDays, Payable,round(NetPayable,0) as NetPayable, OthersAllownce, ProvidentFund, ProfitTax, LateFine, TiffinDays, TiffinTaka, TiffinBillAmount,CasualLeave,SickLeave,AnnualLeave,OfficialLeave,SalaryCount,DormitoryRent,TotalOverTime,TotalOtherOverTime,DaysInMonth,OthersPay,OthersDeduction,lwp as ShortLeave,AdvanceDeduction,LateDays,ConvenceAllownce,NightbilAmount,NightBillDays,convert(varchar(10), EmpJoiningDate,105) EmpJoiningDate,Stampdeduct,FoodAllownce,Activeday,EmpNetGross,SeparationTypeName,EmpNameBn, DptNameBn, DsgNameBn, GrdNameBangla " +
                                " FROM   " + tableName + " " +
                                " where " +
                                " IsActive='1' " + yearMonth + " AND EmpCardNo Like '%" + txtEmpCardNo.Text.Trim() + "' AND IsSeperationGeneration='1' " + holidayAllowance + " " + 
                                " ORDER BY SftName, CONVERT(int,DptId),convert(int,Gid), CustomOrdering";
                            Session["__ReportTitle__"] = "[Separation]";
                        }

                        sqlDB.fillDataTable(getSQLCMD, dt);
                        if (dt.Rows.Count == 0)
                        {
                            lblMessage.InnerText = "warning-> Data no found."; return;
                        }
                        rblEmployeeType.SelectedValue = dt.Rows[0]["EmptypeId"].ToString();
                        //rblPaymentType.SelectedValue = dt.Rows[0]["SalaryCount"].ToString();


                    }

                    if (rblReportType.SelectedValue == "slip")
                    {
                        Session["__Language__"] = "Bangla";
                        Session["__PaySlip__"] = dt;
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=PaySlipNew-" + ddlSelectMonth.SelectedItem.Text + "');", true);  //Open New Tab for Sever side code
                    }

                    else if (rblReportType.SelectedValue == "holidayallowance")
                    {

                        Session["__SalarySheet__"] = dt;
                        //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=HolidayAllowance-" + ddlYearMonth.SelectedItem.Text.Replace('-', '/') + "-True-" + ddlemolpyeType.SelectedValue + "');", true);

                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=HolidayAllowance-" + ddlSelectMonth.SelectedItem.Text.Replace('-', '/') + "-True-" + rblEmployeeType.SelectedValue + "-" + rblPaymentType.SelectedValue + "-" + rblSheet.SelectedValue + "');", true);
                    }


                    else if (rblReportType.SelectedValue == "finalSettlement")
                    {

                    }
                    else
                    {
                        Session["__Language__"] = "English";
                        Session["__SalarySheet__"] = dt;

                        ScriptManager.RegisterStartupScript(this, GetType(),"OpenSalarySheet","window.open('/hrms/payroll/Salary_Sheet_ExcelV2.aspx', '_blank');", true);
                        /* ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=SalarySheetNew-" + ddlSelectMonth.SelectedItem.Text.Replace('-', '/') + "-True-" + rblEmployeeType.SelectedValue + "-" + rblPaymentType.SelectedValue + "-" + rblSheet.SelectedValue + "');", true);*/  //Open New Tab for Sever side code

                    }

                }

                else if (rblReportType.SelectedValue == "finalSettlement")
                {
                    if (rblGenerateType.SelectedItem.Text.Equals("All"))
                    {
                        getSQLCMD = @"SELECT pep.EmpId,pfs.EarnLeave,pfs.EarnLeaveAmount,pfs.MonthlyPayroll,pfs.NoticeDeduction_Amount,pfs.NoticeDeduction_Days,pfs.OtRate,pfs.RetirementBenefits_Amount,pfs.RetirementBenefits_Days,FORMAT(RetirementEffectiveDate, 'MMMM yyyy') AS RetirementEffectiveDate,pfs.ServiceBenefits_Amount,pfs.ServiceBenefits_Days,pfs.Total,pfs.TotalOtAmount,pfs.TotalOtHours,pfs.TotalOtAmount,pfs.TotalOtHours,pfs.TotalWorkingDays, RIGHT(pei.EmpCardNo, 6) + '(' + pei.EmpProximityNo + ')' AS EmpCardNo,  pei.EmpNameBn, pei.EmpName, cmp.CompanyLogo,  CONVERT(VARCHAR(10), pes.EffectiveDate, 105) AS EmpResignDate,cmp.CompanyNameBangla, cmp.CompanyName, cmp.Address, cmp.AddressBangla, CONVERT(VARCHAR(10), pep.DateOfBirth, 105) AS DateOfBirth, CONVERT(VARCHAR(10), pei.EmpJoiningDate, 105) AS EmpJoiningDate, dsg.DsgNameBn, dsg.DsgName, dpt.DptNameBn, dpt.DptName, grp.GNameBn, grp.GName, pep.Sex, pep.Age, pei.CompanyId, pei.EmpStatus, pecs.DptId, pecs.CustomOrdering, pecs.BasicSalary, pecs.HouseRent, pecs.MedicalAllownce, pecs.FoodAllownce, pecs.ConvenceAllownce, pecs.OthersAllownce, pecs.EmpPresentSalary, pecs.PreBasicSalary, pecs.PreHouseRent, pecs.PreMedicalAllownce, pecs.PreFoodAllownce, pecs.PreConvenceAllownce, pecs.PreOthersAllownce, pecs.PreEmpSalary,pfs.StampDeduction,pfs.AttendanceBonus FROM dbo.Personnel_EmployeeInfo AS pei LEFT JOIN dbo.Personnel_EmpPersonnal AS pep ON pei.EmpId = pep.EmpId INNER JOIN dbo.Personnel_EmpCurrentStatus AS pecs ON pei.EmpId = pecs.EmpId AND pecs.IsActive = 1 INNER JOIN HRD_CompanyInfo AS cmp ON pei.CompanyId = cmp.CompanyId  LEFT OUTER JOIN dbo.HRD_Department AS dpt ON pecs.DptId = dpt.DptId LEFT OUTER JOIN dbo.HRD_Designation AS dsg ON pecs.DsgId = dsg.DsgId LEFT OUTER JOIN dbo.HRD_Group AS grp ON pecs.GId = grp.GId LEFT OUTER JOIN dbo.HRDGrade AS Grd ON pecs.GrdId = Grd.GradeID   left join Payroll_FinalSettlemnet as pfs on pecs.EmpId = pfs.EmpId left join Personnel_EmpSeparation as pes on pfs.EmpId=pes.EmpId and pfs.RegistrationId=pes.EmpSeparationId 
                  WHERE convert(varchar(7), pfs.RetirementEffectiveDate)='" + ddlSelectMonth.SelectedValue.Substring(0, 7) + @"' 
and pfs.EmpTypeId='" + rblEmployeeType.SelectedValue + "' and pecs.DptId " + DepartmentList + " and pecs.IsActive=1 order by dsg.Ordering,pecs.CustomOrdering";
                    }
                    else
                        getSQLCMD = @"SELECT pep.EmpId,pfs.EarnLeave,pfs.EarnLeaveAmount,pfs.MonthlyPayroll,pfs.NoticeDeduction_Amount,pfs.NoticeDeduction_Days,pfs.OtRate,pfs.RetirementBenefits_Amount,pfs.RetirementBenefits_Days,FORMAT(RetirementEffectiveDate, 'MMMM yyyy') AS RetirementEffectiveDate,pfs.ServiceBenefits_Amount,pfs.ServiceBenefits_Days,pfs.Total,pfs.TotalOtAmount,pfs.TotalOtHours,pfs.TotalOtAmount,pfs.TotalOtHours,pfs.TotalWorkingDays, RIGHT(pei.EmpCardNo, 6) + '(' + pei.EmpProximityNo + ')' AS EmpCardNo,  pei.EmpNameBn, pei.EmpName, cmp.CompanyLogo,  CONVERT(VARCHAR(10), pes.EffectiveDate, 105) AS EmpResignDate,cmp.CompanyNameBangla, cmp.CompanyName, cmp.Address, cmp.AddressBangla, CONVERT(VARCHAR(10), pep.DateOfBirth, 105) AS DateOfBirth, CONVERT(VARCHAR(10), pei.EmpJoiningDate, 105) AS EmpJoiningDate, dsg.DsgNameBn, dsg.DsgName, dpt.DptNameBn, dpt.DptName, grp.GNameBn, grp.GName, pep.Sex, pep.Age, pei.CompanyId, pei.EmpStatus, pecs.DptId, pecs.CustomOrdering, pecs.BasicSalary, pecs.HouseRent, pecs.MedicalAllownce, pecs.FoodAllownce, pecs.ConvenceAllownce, pecs.OthersAllownce, pecs.EmpPresentSalary, pecs.PreBasicSalary, pecs.PreHouseRent, pecs.PreMedicalAllownce, pecs.PreFoodAllownce, pecs.PreConvenceAllownce, pecs.PreOthersAllownce, pecs.PreEmpSalary,pfs.StampDeduction,pfs.AttendanceBonus FROM dbo.Personnel_EmployeeInfo AS pei LEFT JOIN dbo.Personnel_EmpPersonnal AS pep ON pei.EmpId = pep.EmpId INNER JOIN dbo.Personnel_EmpCurrentStatus AS pecs ON pei.EmpId = pecs.EmpId AND pecs.IsActive = 1 INNER JOIN HRD_CompanyInfo AS cmp ON pei.CompanyId = cmp.CompanyId  LEFT OUTER JOIN dbo.HRD_Department AS dpt ON pecs.DptId = dpt.DptId LEFT OUTER JOIN dbo.HRD_Designation AS dsg ON pecs.DsgId = dsg.DsgId LEFT OUTER JOIN dbo.HRD_Group AS grp ON pecs.GId = grp.GId LEFT OUTER JOIN dbo.HRDGrade AS Grd ON pecs.GrdId = Grd.GradeID   left join Payroll_FinalSettlemnet as pfs on pecs.EmpId = pfs.EmpId left join Personnel_EmpSeparation as pes on pfs.EmpId=pes.EmpId and pfs.RegistrationId=pes.EmpSeparationId 
                  WHERE convert(varchar(7), pfs.RetirementEffectiveDate)='" + ddlSelectMonth.SelectedValue.Substring(0, 7) + @"' 
and (pecs.EmpCardNo LIKE '%" + txtEmpCardNo.Text.Trim() + "' OR pei.EmpProximityNo ='" + txtEmpCardNo.Text.Trim() + "') and pecs.IsActive=1";

                    sqlDB.fillDataTable(getSQLCMD, dt = new DataTable());
                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.InnerText = "warning-> Data no found."; return;
                    }
                    if (rblLanguage.SelectedValue == "BN")
                    {
                        dt.Columns["CompanyId"].MaxLength = -1; // -1 means no limit
                        foreach (DataRow _row in dt.Rows)
                        {
                            try
                            {
                                string inWordBn = " " + classes.Payroll.NumberToBanglaWords(Math.Abs(long.Parse(_row["Total"].ToString()))) + " UvKv gvÎ";
                                _row["CompanyId"] = inWordBn;
                            }
                            catch (Exception ex) { }
                        }

                    }
                    Session["__final_settlement__"] = dt;
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=FinalSettlementV1-" + ddlCompanyName.SelectedValue + "-" + rblLanguage.SelectedValue + "');", true);
                }


                else // summary
                {
                    if (rblSheet.SelectedValue == "0")
                    {
                        getSQLCMD = "SELECT count(Empid) as ActiveDay,sum(round(ProfitTax,0)) as ProfitTax, sum(round(AbsentDeduction,0)) as AbsentDeduction,sum(round(ProvidentFund,0)) as ProvidentFund , sum(EmpNetGross) as EmpNetGross, sum(round(Payable,0)) as Payable, sum(round(NetPayable,0)) as NetPayable,sum(round( OverTimeAmount,0)) as TotalOTAmount , sum(AttendanceBonus) as AttendanceBonus,sum(AdvanceDeduction) as AdvanceDeduction,sum(Stampdeduct) as Stampdeduct,  CompanyId, CompanyName, Address, DptName,CONVERT(int,DptId), case when FromDate is null then FORMAT(YearMonth,'MMMM-yyyy') else FORMAT(YearMonth,'MMMM-yyyy')+' ['+ convert(varchar(10), FromDate,105)+' to '+convert(varchar(10), ToDate,105) +']' end as YearMonth" +
                            " From " + tableName + " where " +
                            " IsActive='1' " + yearMonth + " " + Condition + "  AND IsSeperationGeneration='0' " +
                            " group by CompanyId, CompanyName, Address, DptName,CONVERT(int,DptId),case when FromDate is null then FORMAT(YearMonth,'MMMM-yyyy') else FORMAT(YearMonth,'MMMM-yyyy')+' ['+ convert(varchar(10), FromDate,105)+' to '+convert(varchar(10), ToDate,105) +']' end" +
                            " ORDER BY CONVERT(int,DptId)";
                        Session["__SummaryReportTitle__"] = "";
                    }
                    else
                    {
                        getSQLCMD = "SELECT count(Empid) as ActiveDay,sum(round(ProfitTax,0)) as ProfitTax, sum(round(AbsentDeduction,0)) as AbsentDeduction,sum(round(ProvidentFund,0)) as ProvidentFund , sum(EmpNetGross) as EmpNetGross, sum(round(Payable,0)) as Payable, sum(round(NetPayable,0)) as NetPayable,sum(round( OverTimeAmount,0)) as TotalOTAmount , sum(AttendanceBonus) as AttendanceBonus,sum(AdvanceDeduction) as AdvanceDeduction,sum(Stampdeduct) as Stampdeduct,  CompanyId, CompanyName, Address, DptName,CONVERT(int,DptId), case when FromDate is null then FORMAT(YearMonth,'MMMM-yyyy') else FORMAT(YearMonth,'MMMM-yyyy')+' ['+ convert(varchar(10), FromDate,105)+' to '+convert(varchar(10), ToDate,105) +']' end as YearMonth" +
                             " From " + tableName + " where " +
                             " IsActive='1' " + yearMonth + " " + Condition + " AND IsSeperationGeneration='1' " +
                             " group by CompanyId, CompanyName, Address, DptName,CONVERT(int,DptId),case when FromDate is null then FORMAT(YearMonth,'MMMM-yyyy') else FORMAT(YearMonth,'MMMM-yyyy')+' ['+ convert(varchar(10), FromDate,105)+' to '+convert(varchar(10), ToDate,105) +']' end" +
                             " ORDER BY CONVERT(int,DptId)";
                        Session["__SummaryReportTitle__"] = "[Separation]";
                    }
                    sqlDB.fillDataTable(getSQLCMD, dt = new DataTable());
                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.InnerText = "warning->Data not found."; return;
                    }
                    if (rblEmployeeType.SelectedValue == "1")
                        Session["__SummaryReportTitle__"] = "Worker Wages of " + dt.Rows[0]["YearMonth"].ToString() + " " + Session["__SummaryReportTitle__"].ToString();
                    else
                        Session["__SummaryReportTitle__"] = "Executive Salary of " + dt.Rows[0]["YearMonth"].ToString() + " " + Session["__SummaryReportTitle__"].ToString();
                    Session["__SummaryOfSalary__"] = dt;
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=SummaryOfSalaryNew-" + rblReportType.SelectedValue + "-" + rblEmployeeType.SelectedValue + "');", true);  //Open New Tab for Sever side code

                }
            }
            catch ( Exception ex)
            {
                 string test = ex.Message;

            }
        }
        protected void ddlCompanyName_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

                string CompanyId = (ddlCompanyName.SelectedValue.ToString().Equals("0000")) ? ViewState["__CompanyId__"].ToString() : ddlCompanyName.SelectedValue.ToString();
                classes.commonTask.LoadDepartmentByCompanyInListBox(CompanyId, lstAll);
                //classes.commonTask.LoadShift(ddlShiftName, CompanyId);
                //addAllTextInShift();
                classes.Payroll.loadMonthIdByCompany(ddlSelectMonth, CompanyId);
            }
            catch { }
        }

      
        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveItem(lstAll, lstSelected);

        }

        protected void btnAddAllItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveAll(lstAll, lstSelected);
        }

        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveItem(lstSelected, lstAll);
        }

        protected void btnRemoveAllItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveAll(lstSelected, lstAll);
        }       
       
        private void banksheetGenarate(string yearmonth,string departmentList,string salarySheet,string bnmnth)
        {
           Session["__bankShortname__"] = "";
            Session["__bankAcount__"] = "";
            DataTable dt = new DataTable();
            string paymentType = "";
            string empptype = "";
            if (rblEmployeeType.SelectedValue != "0")
            {
                empptype = "and ei.EmpTypeId = '" + rblEmployeeType.SelectedValue+"'";
            }

            string empStatus = "ecs.EmpStatus in ('1','8')";
            if (salarySheet == "1")
            {
                empStatus = "ecs.EmpStatus not in ('1','8') ";
            }
            string condition = "";
            if (ddlBankSheet.SelectedIndex>0)
            {
                string[] bankIdandShortname = ddlBankSheet.SelectedValue.Split('_');


                string bankId = bankIdandShortname[0];
                Session["__bankShortname__"] = bankIdandShortname[1];
                Session["__bankAcount__"] = commonTask.getBankAcount(bankId);
                condition = "and ecs.BankId="+ bankId + "";
            }
          
            string getSQLCMD = @"
with bns as (select EmpId,BonusAmount from Payroll_YearlyBonusSheet where CompanyId='0001' AND "+ bnmnth + @")
select ep.NationIDCardNo, ecs.BankId, Isnull(ep.EmpVisaNo,'') as EmpVisaNo,ei.EmpName,bi.BankShortName,ecs.PayerBankId,pbi.BankShortName as PayerBankShotname,ecs.EmpAccountNo,'M' as SalaryFrequency,pms.PayableDays,pms.EmpPresentSalary,pms.BasicSalary,pms.TotalSalary,Isnull(ExtraOtHour,0) as ExtraOtHour,Isnull(ExtraOtAmount,0)+(pms.otherspay)+Isnull(bns.BonusAmount,0)+isnull(pms.MedicalAllownce,0)+isnull(pms.FoodAllownce,0) +isnull(pms.ConvenceAllownce,0) +isnull(pms.TechnicalAllowance,0) +isnull(pms.HouseRent,0) +isnull(pms.OthersAllownce,0)+isnull(pms.LateFine,0) as ExtraOtAmount,case when ecs.BankId=54 then 'Salary' else 'Normal Payment' end  as PaymentType,''  as Notes,Isnull(ecs.IsVacation,0) as IsVacation,
  case when Isnull(ecs.IsVacation,0)= 1 then pms.EmpPresentSalary else  (pms.AdvanceDeduction + pms.AbsentDeduction+pms.othersdeduction) end as Deduction,(pms.BasicSalary+Isnull(ExtraOtAmount,0)+(pms.otherspay)+Isnull(bns.BonusAmount,0)+isnull(pms.MedicalAllownce,0)+isnull(pms.FoodAllownce,0) +isnull(pms.ConvenceAllownce,0) +isnull(pms.TechnicalAllowance,0) +isnull(pms.HouseRent,0) +isnull(pms.OthersAllownce,0))+isnull(pms.LateFine,0)-(pms.AdvanceDeduction + pms.AbsentDeduction+pms.othersdeduction) as OrginalAmount,EmpNetGross,

pms.EmpPresentSalary+Isnull(ExtraOtAmount,0)+(pms.otherspay)+Isnull(bns.BonusAmount,0)-case when Isnull(ecs.IsVacation,0)= 1 then pms.EmpPresentSalary else  (pms.AdvanceDeduction + pms.AbsentDeduction+pms.othersdeduction) end as NetAmount,
  case when Isnull(ecs.IsVacation,0)= 1 then 0 else pms.TotalSalary end as TotalSalary,
  case when Isnull(ecs.IsVacation,0)= 1 then 'Vacation' else '' end as Note" +
                " from Payroll_MonthlySalarySheet pms inner join Personnel_EmployeeInfo ei on ei.EmpId = pms.EmpId  inner join Personnel_EmpCurrentStatus ecs on ei.EmpId = ecs.EmpId left join Personnel_EmpPersonnal ep on ei.EmpId = ep.EmpId left join Hrd_BankInfo bi on ecs.BankId = bi.BankId  left join Hrd_BankInfo pbi on ecs.PayerBankId=pbi.BankId left join bns on pms.Empid=bns.empid  where ecs.companyId in (" + ddlCompanyName.SelectedValue+") and ecs.Isactive = 1  "+ empptype + " "+ condition + " "+yearmonth+" and pms.DptId "+departmentList+" and "+ empStatus + "";
            sqlDB.fillDataTable(getSQLCMD, dt);
            if (dt.Rows.Count == 0)
            {
                lblMessage.InnerText = "warning->Data not found."; return;
            }
             Session["__SalarySheetBankFord__"] = dt;
          ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/payroll/salary/QatarBankfordReport.aspx?for=SalarySheet&&company=" + ddlCompanyName.SelectedValue + "&&month=" + ddlSelectMonth.SelectedItem.Text.Trim() + "');", true);

        }

        protected void chkIsBankfordQatar_CheckedChanged(object sender, EventArgs e)
        {
            if (chkIsBankfordQatar.Checked)
            {
                bankshhet.Visible = true;
                chkExcel.Visible = false;
                chkBankForwardingLetterXL.Visible = false;
                //rblAlll.Visible = true;
            }
            else
            {
                bankshhet.Visible = false;
                chkExcel.Visible = true;
                chkBankForwardingLetterXL.Visible =true;
                //rblAlll.Visible = false;
            }
        }

        //protected void rblAlll_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (rblAlll.Checked)
        //        rblEmployeeType.Visible = false;
        //    else
        //        rblEmployeeType.Visible = true;

        //}

        protected void rblEmployeeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            //rblAlll.Checked = false;
        }
    }
}