using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.payroll.salary
{
    public partial class HolidayAllowanceSheet : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];

                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__CShortName__"] = "MRC";
                classes.commonTask.LoadBranch(ddlCompany, ViewState["__CompanyId__"].ToString());
                classes.Payroll.loadMonthIdByCompany(ddlYearMonth, ViewState["__CompanyId__"].ToString());
                //classes.commonTask.LoadShift(ddlShift, ViewState["__CompanyId__"].ToString());
            }
        }

        private void GetPaymentData()
        {


            string sql = $@"SELECT EmpProximityNo as Sl,EmpId, EmpName,EmptypeId, PaymentMethod,EmpPicture, EmpAccountNo, Substring(EmpCardNo,10,6) as EmpCardNo , AbsentDay, BasicSalary, HouseRent, MedicalAllownce, AbsentDeduction,  OverTime as TotalOTHour, OTRate, round(OverTimeAmount,0) as TotalOTAmount, AttendanceBonus, DptName, CompanyName, SftId,SftName, EmpPresentSalary, Address,HolidayWorkingDays,HolidayTaka,HoliDayBillAmount, DptId, CompanyId, DsgName, TotalSalary, GrdName, GId, GName, PresentDay,WeekendHoliday,FestivalHoliday, PayableDays, Payable,NetPayable, OthersAllownce, ProvidentFund, ProfitTax, LateFine, TiffinDays, TiffinTaka,HoliDayBillAmount,HolidayWorkingDays,HolidayTaka, TiffinBillAmount,CasualLeave,SickLeave,AnnualLeave,OfficialLeave,DormitoryRent,TotalOverTime,TotalOtherOverTime,DaysInMonth,OthersPay,OthersDeduction,lwp as ShortLeave,AdvanceDeduction,LateDays,ConvenceAllownce,NightbilAmount,NightBillDays,convert(varchar(10), EmpJoiningDate,105) EmpJoiningDate,Stampdeduct,FoodAllownce,Activeday,EmpNetGross,EmpNameBn, DptNameBn, DsgNameBn, GrdNameBangla  FROM   v_MonthlySalarySheet  where  IsActive='1'  AND YearMonth='2026-05-01' AND FromDate='2026-05-01' AND ToDate='2026-05-31'  AND EmpTypeId = 1 AND CompanyId = '0001' and DptId in('0001') and sftId ='3705'  AND IsSeperationGeneration='0'  ORDER BY SftName, CONVERT(int,DptId),convert(int,Gid), CustomOrdering";
            DataTable dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(sql);
            Session["__SalarySheet__"] = dt;
            //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=HolidayAllowance-" + ddlYearMonth.SelectedItem.Text.Replace('-', '/') + "-True-" + ddlemolpyeType.SelectedValue + "');", true);

            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=HolidayAllowance-" + ddlYearMonth.SelectedItem.Text.Replace('-', '/') + "-True-" + ddlemolpyeType.SelectedValue + "-" + 0 + "-" + 0 + "');", true);


        }

        protected void btnPreView_Click(object sender, EventArgs e)
        {
            GetPaymentData();
        }
    }
}

