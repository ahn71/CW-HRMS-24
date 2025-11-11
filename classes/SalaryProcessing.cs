using Newtonsoft.Json.Linq;
using SigmaERP.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SigmaERP.classes
{
    public class SalaryProcessing
    {
        string query = "";
        DataTable dt;
        SalaryRecord salaryRecord;
        public string GetEmpIdString(DataTable dtEmployees)
        {
            if (dtEmployees == null || dtEmployees.Rows.Count == 0)
                return string.Empty;

            // Collect EmpId values
            List<string> empList = new List<string>();

            foreach (DataRow row in dtEmployees.Rows)
            {
                string empId = row["EmpId"].ToString();
                if (!string.IsNullOrEmpty(empId))
                {
                    empList.Add("'" + empId + "'");
                }
            }

            // Join with comma
            return string.Join(",", empList);
        }

        public string  salaryProcessing(string IsSeperationGeneration, string UserId, string CompanyId,string EmpId,string SelectedDate,bool hasPF, bool hasSpesialGross, string PersentOfGross,bool hasAdvanceDeduction,bool hasStampDeduction,bool hasLateDeduction,string ExceptedEmpCardNo,string generateFor)
        {
            //Note: ProcessNo is 1 for Separation Employees and 0 for Regular Employees
            try
            {
                string errorData = "";
                string EmpIdS = "";
            string[] getDays = SelectedDate.Split('-');
            DateTime FromDate=DateTime.Parse( getDays[2] + "-" + getDays[1] + "-01");
            DateTime ToDate = DateTime.Parse(getDays[2] + "-" + getDays[1] + "-" + getDays[0]);

               
               var payRollPolicy=getPayrollPolicy(CompanyId, generateFor);
                  // getting selected employees 
                  DataTable dtEmployees = new DataTable();
                if (IsSeperationGeneration == "0")// regular employee 
                {
                    // check half month salary and set From Date            
                    FromDate = setFromDate(CompanyId, FromDate, ToDate);
                    dtEmployees = getEmployees(CompanyId, EmpId, ToDate.ToString("yyyy-MM-dd"));
                }
                else
                {
                    dtEmployees = getSeparationEmployees(CompanyId, EmpId, ToDate.ToString("yyyy-MM"));
                    EmpIdS = GetEmpIdString(dtEmployees);
                }

                if (dtEmployees != null && dtEmployees.Rows.Count > 0)
                {
                    
                    /// deleteing existing salary 
                    if (IsSeperationGeneration == "1")
                    {
                        if (generateFor == "regular")
                            salarySheetClearForSeparation(ToDate, CompanyId, EmpIdS);
                        else
                            salarySheetClearForSeparation_complaince(ToDate, CompanyId, EmpId);

                    }

                    else
                    {
                        if (generateFor == "regular")
                            salarySheetClear(ToDate, CompanyId, EmpId);
                        else
                            salarySheetClear_Complaince(ToDate, CompanyId, EmpId);
                    }
                        

                // getting month info 
                dt = new DataTable();
                dt = getMonthInfo(CompanyId,ToDate.ToString("MM-yyyy"));
                int TotalDays= int.Parse(dt.Rows[0]["TotalDays"].ToString());              
                int Activeday = int.Parse(dt.Rows[0]["TotalWorkingDays"].ToString());


                   var allAdvanceDeductions = getAllAdvanceDeduction(FromDate, EmpId);

                    var allPunishmentDeductions = getAllPunishment(EmpId, FromDate);
                    //get stamp Amount

                    //int count = 0;
                    //int countPost = 0;
                    //int countSuccess= 0;
                    foreach (DataRow employee in dtEmployees.Rows)
                {
                        string paymentMethod = employee["PaymentMethod"].ToString() == null ? "0" : employee["PaymentMethod"].ToString();
                        double stampDeduct = (hasStampDeduction) ? getStampDeduction(payRollPolicy["StampDeduction"].ToString(), paymentMethod) : 0;
                        // excepted employee ignore here 
                        if (ExceptedEmpCardNo!= "")
                        {
                            string EmpCardNo = employee["EmpCardNo"].ToString().Substring(employee["EmpCardNo"].ToString().Length - 6);

                            if (ExceptedEmpCardNo.Contains(EmpCardNo))
                                continue;
                        }

                        //count++;
                    DateTime _FromDateForAll = FromDate;
                    DateTime _ToDateForAll = ToDate;
                    DateTime _FromDate = FromDate;
                    DateTime _ToDate = ToDate;
                    string _EmpSeparationId = "0";
                    if (IsSeperationGeneration == "1")// separation employee 
                    {
                        _EmpSeparationId =employee["EmpSeparationId"].ToString();
                        _ToDate = DateTime.Parse(employee["EffectiveDate"].ToString());
                    }
                        

                   // check new joining employees 
                    DateTime empJoiningDate = DateTime.Parse(employee["EmpJoiningDate"].ToString());
                    if (_FromDate < empJoiningDate)
                        _FromDate = empJoiningDate;
                    //initial 
                    try {
                          salaryRecord = new SalaryRecord
                            {
                                UserId = int.Parse(UserId),
                                EmpId = employee["EmpId"].ToString(),
                                EmpCardNo = employee["EmpCardNo"].ToString(),
                                EmpTypeId = int.Parse(employee["EmpTypeId"].ToString()),
                                EmpStatus = int.Parse(employee["EmpStatus"].ToString()),
                                CompanyId = employee["CompanyId"].ToString(),
                                DptId = employee["DptId"].ToString(),
                                DsgId = employee["DsgId"].ToString(),
                                GrdName = employee["GrdName"].ToString(),
                                SftId = employee["SftId"].ToString(),
                                EmpPresentSalary = double.Parse(employee["EmpPresentSalary"].ToString()),
                                EmpNetGross = 0,
                                BasicSalary = double.Parse(employee["BasicSalary"].ToString()),
                                HouseRent = double.Parse(employee["HouseRent"].ToString()),
                                MedicalAllownce = double.Parse(employee["MedicalAllownce"].ToString()),
                                ConvenceAllownce = double.Parse(employee["ConvenceAllownce"].ToString()),
                                FoodAllownce = double.Parse(employee["FoodAllownce"].ToString()),
                                TechnicalAllowance = double.Parse(employee["TechnicalAllownce"].ToString()),
                                OthersAllownce = double.Parse(employee["OthersAllownce"].ToString()),
                                AttendanceBonus=double.Parse(employee["AttendanceBonus"].ToString()),
                                DaysInMonth = TotalDays,
                                Activeday = Activeday,
                                WeekendHoliday = 0,
                                FestivalHoliday = 0,
                                AbsentDay = 0,
                                PresentDay = 0,
                                LateDays = 0,
                                PayableDays = 0,
                                CasualLeave = 0,
                                SickLeave = 0,
                                AnnualLeave = 0,
                                OthersLeave = 0,
                                LWP = 0,
                                AdvanceDeduction = 0,
                                AbsentDeduction = 0,
                                LateFine = 0,
                                ProvidentFund = 0,
                                ProfitTax = 0,
                                Payable = 0,
                                TiffinDays = 0,
                                TiffinTaka = 0,
                                TiffinBillAmount = 0,
                                HolidayWorkingDays = 0,
                                HolidayTaka = 0,
                                HoliDayBillAmount = 0,
                                NightbilAmount = 0,
                                NightBillDays = 0,
                                OTRate = 0,
                                OverTime = "00:00:00",
                                OverTimeAmount = 0,
                                TotalOverTime = "00:00:00",
                                TotalOTAmount = 0,
                                Stampdeduct = stampDeduct,
                                NetPayable = 0,
                                TotalSalary = 0,
                                YearMonth = DateTime.Parse(FromDate.ToString("yyyy-MM") + "-01"),
                                FromDate = _FromDate,
                                ToDate = _ToDate,
                                FromDateForAll = _FromDateForAll,
                                ToDateForAll = _ToDateForAll,
                                IsSeperationGeneration= IsSeperationGeneration,
                                EmpSeparationId= _EmpSeparationId

                            };
                    }
                    catch (Exception ex)
                        {
                            continue;
                        }
                    //getting Attendance Status (Leave,Absent,Present,Late) 
                    if(generateFor == "regular")
                            salaryRecord = getAttendanceStatus(salaryRecord);
                    else
                            salaryRecord = getAttendanceStatus_Complaince(salaryRecord);



                        // check git
                        //check Attendance bonus
                        salaryRecord = checkAttendanceBonus(salaryRecord, employee["EmpDutyType"].ToString(), payRollPolicy["AttendanceBonus"].ToString());
                    //Night Bill 
                    salaryRecord.NightbilAmount = CalculatedNightBill(employee["EmpTypeId"].ToString(), payRollPolicy["NightAllowance"].ToString(), Convert.ToInt32(salaryRecord.NightBillDays));

                        //get Others Pay
                        salaryRecord.OthersPay = getOthersPay(salaryRecord.EmpId);

                    //get Others Deduction
                    //salaryRecord.OthersPay = getOthersDeduction(salaryRecord.EmpId, salaryRecord.ToDate.ToString("MM-yyyy"));
                    
                    //get PF Deduction 
                    if (hasPF)
                        salaryRecord.ProvidentFund = getPF(employee,ToDate);
                        //get Advance Deduction

                        //get Advance Deduction
                    if (hasAdvanceDeduction)
                    {
                        //salaryRecord.AdvanceDeduction = getAdvanceDeduction(salaryRecord.EmpId, salaryRecord.FromDate);
                        if (allAdvanceDeductions.TryGetValue(salaryRecord.EmpId, out DataRow advanceDeduction))
                        {
                            salaryRecord.AdvanceDeduction = double.Parse(advanceDeduction["Amount"].ToString());
                        }
                    }
                        //get Tax Deduction
                    salaryRecord.ProfitTax =Round(double.Parse(employee["TaxAmount"].ToString()));
                    // get Late Deduction
                   
                    if (hasLateDeduction && payRollPolicy.TryGetValue("LateDeduction", out var lateDeduction))
                    {
                        salaryRecord.LateFine = getLateFine(lateDeduction.ToString());
                    }

                        //get Punishment Deduction
                        //salaryRecord.OthersDeduction = getPunishmentDeduction(salaryRecord.EmpId, salaryRecord.FromDate);

                        if (allPunishmentDeductions.TryGetValue(salaryRecord.EmpId, out DataRow punishmentDeduction))
                    {
                        salaryRecord.OthersDeduction = double.Parse(punishmentDeduction["PAmount"].ToString());
                    }

                        //OverTime 
                    if (employee["EmpTypeId"].ToString() == "1")// for worker 
                    {
                        salaryRecord = getOverTime(salaryRecord, employee);
                    }
                        //Payable days calculations 
                        if (generateFor == "regular")
                            salaryRecord = getPayableDaysCalculation(salaryRecord, hasSpesialGross, PersentOfGross);
                        else
                            salaryRecord = getPayableDaysCalculation_Complaince(salaryRecord, hasSpesialGross, PersentOfGross);




                        //Payable amount calculation

                        //if(generateFor == "regular")
                            salaryRecord = getNetPayableCalculation(salaryRecord, hasAdvanceDeduction, payRollPolicy["AbsentDeduction"].ToString());
                        







                        if (employee["DsgId"].ToString()== "0005" && generateFor== "compliance")

                        {
                            salaryRecord.NightbilAmount = 0;
                            salaryRecord.NightBillDays = 0;
                            
                        }
                        else
                        {
                            salaryRecord.NightbilAmount = CalculatedNightBill(employee["EmpTypeId"].ToString(), payRollPolicy["NightAllowance"].ToString(), Convert.ToInt32(salaryRecord.NightBillDays));
                        }
                        if (generateFor == "compliance")
                        {
                            if (saveSalaryComplaince(salaryRecord))
                            {

                            }
                            else
                            {
                                errorData += "," + salaryRecord.EmpId;
                            }
                        }
                            
                        else
                        {
                            if (saveSalary(salaryRecord))
                            {
                                //  countSuccess++;

                                if (salaryRecord.ProvidentFund > 0)
                                    savePFRecord(salaryRecord.EmpId, salaryRecord.ToDate.ToString("yyyy-MM") + "-01", salaryRecord.ProvidentFund);
                                if (salaryRecord.ProfitTax > 0)
                                    updateTaxRecord(salaryRecord.EmpId, salaryRecord.ToDate.ToString("yyyy-MM") + "-01");
                                if (salaryRecord.AdvanceDeduction > 0)
                                    updateLoanStatus(salaryRecord.EmpId, salaryRecord.ToDate.ToString("yyyy-MM") + "-01");
                            }
                            else
                            {
                                errorData += "," + salaryRecord.EmpId;
                            }
                        }
                  
                

                       // countPost++;
                }

                    //int check = count;
                    // check = countPost;
                    // check = countSuccess;

            }


                return errorData;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        public string FinalSattlementProcessing(string IsSeperationGeneration, string UserId, string CompanyId, string EmpId, string SelectedDate, bool hasPF, bool hasSpesialGross, string PersentOfGross, bool hasAdvanceDeduction, bool hasStampDeductionAll, bool hasStampDeductionOnlyCash, string ExceptedEmpCardNo, int noticeDay,string generateFor)
        {
            //Note: ProcessNo is 1 for Separation Employees and 0 for Regular Employees
            try
            {
                string errorData = "";
                string[] getDays = SelectedDate.Split('-');
                DateTime FromDate = DateTime.Parse(getDays[2] + "-" + getDays[1] + "-01");
                DateTime ToDate = DateTime.Parse(getDays[2] + "-" + getDays[1] + "-" + getDays[0]);

                var payRollPolicy = getPayrollPolicy(CompanyId, generateFor);
                // getting selected employees  for separation
                DataTable dtEmployees = getSeparationEmployees(CompanyId, EmpId, ToDate.ToString("yyyy-MM"));

                if (dtEmployees != null && dtEmployees.Rows.Count > 0)
                {

                    /// deleteing existing FinalSattlementsalary 
                    ClearFinalSattlementSheet(ToDate, CompanyId, EmpId);
                    //get stamp Amount
                    //double stampDeduct = getStampDeduction();
                    
                    foreach (DataRow employee in dtEmployees.Rows)
                    {

                        string paymentMethod = employee["PaymentMethod"].ToString() == null ? "0" : employee["PaymentMethod"].ToString();

                        double _stampDeduct = (hasStampDeductionAll) ? getStampDeduction(payRollPolicy["StampDeduction"].ToString(), paymentMethod) : 0;

                        //// set stamp deduction 
                        // SalaryCount 'False' means 'Cash Salary'.
                       
                        //if (hasStampDeductionAll)
                        //    _stampDeduct = stampDeduct;

                        // excepted employee ignore here 
                        if (ExceptedEmpCardNo != "")
                        {
                            string EmpCardNo = employee["EmpCardNo"].ToString().Substring(employee["EmpCardNo"].ToString().Length - 6);

                            if (ExceptedEmpCardNo.Contains(EmpCardNo))
                                continue;
                        }
                        // Deduction days for Notice pay
                        noticeDay = int.Parse(employee["DeductionDaysNoticePay"].ToString());

                        InsertPayrollFinalSettlement(employee["EmpId"].ToString(), employee["EmpTypeId"].ToString(), employee["EmpName"].ToString(), Convert.ToInt32(employee["DsgId"]), Convert.ToInt32(employee["DptId"]), employee["EmpCardNo"].ToString(), employee["EmpSeparationId"].ToString(), Convert.ToDateTime(employee["EmpJoiningDate"]), Convert.ToDateTime(employee["EffectiveDate"]), Convert.ToInt32(employee["SalaryCount"]), Convert.ToSingle(employee["BasicSalary"]), Convert.ToSingle(employee["HouseRent"]), Convert.ToSingle(employee["MedicalAllownce"]), Convert.ToSingle(employee["FoodAllownce"]), Convert.ToSingle(employee["ConvenceAllownce"]), Convert.ToSingle(employee["EmpPresentSalary"]), employee["CompanyId"].ToString(), SelectedDate, _stampDeduct, noticeDay);
                    }

                }
                return errorData;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        private DateTime setFromDate(string CompanyId,DateTime FromDate, DateTime ToDate)
        {
            dt = new DataTable();
            dt =CRUD.ExecuteReturnDataTable( "select Distinct convert(varchar(10), ToDate,120) as ToDate from Payroll_MonthlySalarySheet where IsSeperationGeneration=0  and CompanyId='" + CompanyId + "' and YearMonth='" + ToDate.ToString("yyyy-MM") + "-01' and ToDate<'" + ToDate.ToString("yyyy-MM-dd") + "'");           
            if (dt != null && dt.Rows.Count > 0)
            {
                return DateTime.Parse(dt.Rows[0]["ToDate"].ToString()).AddDays(1);
            }
            return FromDate;
        }
        private DataTable getEmployees(string CompanyId,string EmpId, string SelectDate)
        {

            EmpId = (EmpId == "0" )?"": " and cs.EmpId='" + EmpId + "'";
            string query= "Select cs.CompanyId,cs.DptId,cs.DsgId,grd.GrdName,cs.EmpId,cs.EmpCardNo,ei.EmpName,et.EmpType, cs.EmpTypeId,cs.EmpStatus,cs.ActiveSalary,cs.IsActive,cs.CompanyId,cs.SftId,cs.OverTime,cs.EmpDutyType, cs.PfMember, CONVERT(VARCHAR(10), cs.PfDate, 120) AS PfDate, ISNULL(cs.PFAmount, 0) AS PFAmount, ISNULL(cs.IncomeTax, 0) AS TaxAmount, cs.BasicSalary,ISNULL(cs.MedicalAllownce,0) as MedicalAllownce,ISNULL(cs.FoodAllownce,0) as FoodAllownce,ISNULL(cs.ConvenceAllownce,0) as ConvenceAllownce, ISNULL(cs.HouseRent,0) as HouseRent,ISNULL(cs.TechnicalAllownce,0) as TechnicalAllownce,ISNULL(cs.OthersAllownce,0) as OthersAllownce ,ISNULL(cs.EmpPresentSalary,0) as EmpPresentSalary,ISNULL(cs.AttendanceBonus,0) as AttendanceBonus ,ISNULL(cs.LunchCount,0),ISNULL(cs.LunchAllownce,0),CONVERT(VARCHAR(10), ei.EmpJoiningDate, 120) AS EmpJoiningDate,cs.PaymentMethod from dbo.Personnel_EmployeeInfo ei on  sp.EmpId=ei.EmpId inner join dbo.Personnel_EmpCurrentStatus cs on ei.EmpId = cs.EmpId and cs.isActive=1 INNER JOIN dbo.HRD_EmployeeType et ON cs.EmpTypeId = et.EmpTypeId  LEFT JOIN dbo.HRDGrade grd ON cs.GrdId = grd.GradeID  Where  cs.EmpStatus in ('1','8') AND cs.ActiveSalary='true' AND cs.CompanyId='" + CompanyId + "' and ei.EmpJoiningDate<='" + SelectDate + "' " + EmpId;

             return CRUD.ExecuteReturnDataTable("Select cs.CompanyId,cs.DptId,cs.DsgId,grd.GrdName,cs.EmpId,cs.EmpCardNo,ei.EmpName,et.EmpType, cs.EmpTypeId,cs.EmpStatus,cs.ActiveSalary,cs.IsActive,cs.CompanyId,cs.SftId,cs.OverTime,cs.EmpDutyType, cs.PfMember, CONVERT(VARCHAR(10), cs.PfDate, 120) AS PfDate, ISNULL(cs.PFAmount, 0) AS PFAmount, ISNULL(cs.IncomeTax, 0) AS TaxAmount, cs.BasicSalary,ISNULL(cs.MedicalAllownce,0) as MedicalAllownce,ISNULL(cs.FoodAllownce,0) as FoodAllownce,ISNULL(cs.ConvenceAllownce,0) as ConvenceAllownce, ISNULL(cs.HouseRent,0) as HouseRent,ISNULL(cs.TechnicalAllownce,0) as TechnicalAllownce,ISNULL(cs.OthersAllownce,0) as OthersAllownce ,ISNULL(cs.EmpPresentSalary,0) as EmpPresentSalary,ISNULL(cs.AttendanceBonus,0) as AttendanceBonus ,ISNULL(cs.LunchCount,0),ISNULL(cs.LunchAllownce,0),CONVERT(VARCHAR(10), ei.EmpJoiningDate, 120) AS EmpJoiningDate,cs.PaymentMethod from dbo.Personnel_EmployeeInfo ei inner join dbo.Personnel_EmpCurrentStatus cs on ei.EmpId = cs.EmpId and cs.isActive=1 INNER JOIN dbo.HRD_EmployeeType et ON cs.EmpTypeId = et.EmpTypeId  LEFT JOIN dbo.HRDGrade grd ON cs.GrdId = grd.GradeID  Where  cs.EmpStatus in ('1','8') AND cs.ActiveSalary='true' AND cs.CompanyId='" + CompanyId + "' and ei.EmpJoiningDate<='" + SelectDate + "' "+EmpId);
        }
        private DataTable getSeparationEmployees(string CompanyId,string EmpId, string YearMonth)
        {

            EmpId = (EmpId == "0" )?"": " and s.EmpId='" + EmpId + "'";

            string query = "select s.EmpSeparationId,cs.CompanyId,  CONVERT(varchar(7), s.EffectiveDate, 126) as YearMonth ,CONVERT(varchar(7), s.EffectiveDate, 126) as YearMonth,cs.DptId,cs.DsgId,grd.GrdName,cs.EmpId,cs.EmpCardNo,ei.EmpName,et.EmpType, cs.EmpTypeId,cs.EmpStatus,cs.ActiveSalary,cs.IsActive,cs.CompanyId,cs.SftId,cs.OverTime,cs.EmpDutyType, cs.PfMember, CONVERT(VARCHAR(10), cs.PfDate, 120) AS PfDate, ISNULL(cs.PFAmount, 0) AS PFAmount, ISNULL(cs.IncomeTax, 0) AS TaxAmount, cs.BasicSalary,ISNULL(cs.MedicalAllownce,0) as MedicalAllownce,ISNULL(cs.FoodAllownce,0) as FoodAllownce,ISNULL(cs.ConvenceAllownce,0) as ConvenceAllownce, ISNULL(cs.HouseRent,0) as HouseRent,ISNULL(cs.TechnicalAllownce,0) as TechnicalAllownce,ISNULL(cs.OthersAllownce,0) as OthersAllownce,ISNULL(cs.EmpPresentSalary,0) as EmpPresentSalary,ISNULL(cs.AttendanceBonus,0) as AttendanceBonus,cs.LunchCount,ISNULL(cs.LunchAllownce,0) as LunchAllownce,CONVERT(VARCHAR(10), ei.EmpJoiningDate, 120) AS EmpJoiningDate,  convert(varchar(10), s.EffectiveDate,120) as EffectiveDate,cs.PaymentMethod from  Personnel_EmpSeparation s inner join dbo.Personnel_EmployeeInfo ei on  s.EmpId=ei.EmpId inner join dbo.Personnel_EmpCurrentStatus cs on ei.EmpId = cs.EmpId and cs.isActive=1 INNER JOIN dbo.HRD_EmployeeType et ON cs.EmpTypeId = et.EmpTypeId LEFT JOIN dbo.HRDGrade grd ON cs.GrdId = grd.GradeID  where cs.CompanyId = '" + CompanyId + "' AND  CONVERT(varchar(7), s.EffectiveDate, 126) = '" + YearMonth + "' AND s.IsActive = 'True' AND IsLastSeparation=1 "+ EmpId +"" ;

            string query = "select cs.SalaryCount, s.EmpSeparationId,cs.CompanyId,  CONVERT(varchar(7), s.EffectiveDate, 126) as YearMonth ,CONVERT(varchar(7), s.EffectiveDate, 126) as YearMonth,cs.DptId,cs.DsgId,grd.GrdName,cs.EmpId,cs.EmpCardNo,ei.EmpName,et.EmpType, cs.EmpTypeId,cs.EmpStatus,cs.ActiveSalary,cs.IsActive,cs.CompanyId,cs.SftId,cs.OverTime,cs.EmpDutyType, cs.PfMember, CONVERT(VARCHAR(10), cs.PfDate, 120) AS PfDate, ISNULL(cs.PFAmount, 0) AS PFAmount, ISNULL(cs.IncomeTax, 0) AS TaxAmount, cs.BasicSalary,ISNULL(cs.MedicalAllownce,0) as MedicalAllownce,ISNULL(cs.FoodAllownce,0) as FoodAllownce,ISNULL(cs.ConvenceAllownce,0) as ConvenceAllownce, ISNULL(cs.HouseRent,0) as HouseRent,ISNULL(cs.TechnicalAllownce,0) as TechnicalAllownce,ISNULL(cs.OthersAllownce,0) as OthersAllownce,ISNULL(cs.EmpPresentSalary,0) as EmpPresentSalary,ISNULL(cs.AttendanceBonus,0) as AttendanceBonus,cs.LunchCount,ISNULL(cs.LunchAllownce,0) as LunchAllownce,CONVERT(VARCHAR(10), ei.EmpJoiningDate, 120) AS EmpJoiningDate,  convert(varchar(10), s.EffectiveDate,120) as EffectiveDate,cs.PaymentMethod,isnull(s.DeductionDaysNoticePay,0) as DeductionDaysNoticePay from  Personnel_EmpSeparation s inner join dbo.Personnel_EmployeeInfo ei on  s.EmpId=ei.EmpId inner join dbo.Personnel_EmpCurrentStatus cs on ei.EmpId = cs.EmpId and cs.isActive=1 INNER JOIN dbo.HRD_EmployeeType et ON cs.EmpTypeId = et.EmpTypeId LEFT JOIN dbo.HRDGrade grd ON cs.GrdId = grd.GradeID  where cs.CompanyId = '" + CompanyId + "' AND  CONVERT(varchar(7), s.EffectiveDate, 126) = '" + YearMonth + "' AND s.IsActive = 'True' AND IsLastSeparation=1";


            return CRUD.ExecuteReturnDataTable(query);
        }
        private DataTable getMonthInfo(string  CompanyId,string Month)
        {
            string jjj = "select TotalDays,TotalWeekend ,FromDate,ToDate,TotalHoliday,TotalWorkingDays from tblMonthSetup where CompanyId='" + CompanyId + "' and MonthName='" + Month + "'";
            return CRUD.ExecuteReturnDataTable("select TotalDays,TotalWeekend ,FromDate,ToDate,TotalHoliday,TotalWorkingDays from tblMonthSetup where CompanyId='" + CompanyId + "' and MonthName='" + Month + "'"); 
            
        }
        private SalaryRecord getAttendanceStatus_Old(SalaryRecord salaryRecord)
        {
            //Leave 
            dt = new DataTable();
            dt=CRUD.ExecuteReturnDataTable("select EmpId,Sum(case when StateStatus='Casual Leave' then 1 else 0 end) as 'CL',Sum(case when StateStatus = 'Sick Leave' then 1 else 0 end) as 'SL',Sum(case when StateStatus = 'Annual Leave' then 1 else 0 end) as 'EL', Sum(case when StateStatus = 'Maternity Leave' then 1 else 0 end) as 'ML'," +
                " Sum(case when StateStatus = 'Leave Without Pay (LWP)' then 1 else 0 end) as 'LWP', count(EmpId) as Lv from v_tblAttendanceRecord where ATTStatus='lv'  AND EmpId='" + salaryRecord.EmpId + "' And AttDate >='" + salaryRecord.FromDate + "' AND AttDate <= '" + salaryRecord.ToDate + "' group by EmpId");
            if (dt!=null && dt.Rows.Count > 0)
            {             
                salaryRecord.CasualLeave = int.Parse(dt.Rows[0]["CL"].ToString());
                salaryRecord.SickLeave = int.Parse(dt.Rows[0]["SL"].ToString());
                salaryRecord.AnnualLeave = int.Parse(dt.Rows[0]["EL"].ToString());                
                salaryRecord.LWP = int.Parse(dt.Rows[0]["LWP"].ToString());
                salaryRecord.ML = int.Parse(dt.Rows[0]["ML"].ToString());
                salaryRecord.TotalLeave = int.Parse(dt.Rows[0]["Lv"].ToString());
                salaryRecord.OthersLeave = salaryRecord.TotalLeave - (salaryRecord.CasualLeave+salaryRecord.SickLeave+salaryRecord.AnnualLeave+salaryRecord.LWP+salaryRecord.ML);
               
            }
            //Present(Payable) 
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select distinct SftId, EmpId,Convert(varchar(11),ATTDate,111) as ATTDate,InHour,InMin,InSec,OutHour,OutMin,OutSec,ATTStatus from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND ATTStatus In ('P','L')  AND AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' AND PaybleDays='1' ");
            if (dt != null && dt.Rows.Count > 0)
                salaryRecord.PresentDay = dt.Rows.Count;
            //Late(Payable) 
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select distinct convert(varchar(11),AttDate,111) as AttDate, EmpId from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND ATTStatus='L' AND AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' AND PaybleDays='1' ");
            if (dt != null && dt.Rows.Count > 0)
                salaryRecord.LateDays = dt.Rows.Count;

            //Absent(not Payable) 
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select distinct convert(varchar(11),AttDate,111) as AttDate,EmpId from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND (ATTStatus='A' or StateStatus='Leave Without Pay (LWP)') AND AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' Union select distinct convert(varchar(11),AttDate,111) as AttDate,EmpId from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND ATTStatus In ('P','L')  AND AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM") + '-' + "01" + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' AND PaybleDays='0' ");
            if (dt != null && dt.Rows.Count > 0)
                salaryRecord.AbsentDay = dt.Rows.Count;

            return salaryRecord;

        }


        private SalaryRecord getAttendanceStatus_Complaince(SalaryRecord salaryRecord)
        {
            //Attendance Summary 
            dt = new DataTable();

            string query = @"WITH h AS
                    (
                    SELECT CompanyId, HDate, 'H' AS AttStatus, 'Holiday' AS StateStatus
                    FROM dbo.tblHolydayWork
                    )
                    select EmpId, sum(NightAllowCount) as NightAllowCount,sum(case  when h.HDate is null and v.ATTStatus In('P', 'L') AND PaybleDays = '1' and Isnull(isweekend, 0) = 0    then 1 else 0 end) as P,
                    sum(case when h.HDate is null and  v.ATTStatus In('L') AND PaybleDays = '1' then 1 else 0 end) as L, Sum(Case when(h.HDate is null and v.ATTStatus = 'A' and Isnull(isweekend, 0) = 0) or  v.StateStatus = 'Leave Without Pay (LWP)' or(v.ATTStatus In('P', 'L') AND PaybleDays = '0')  then 1 else 0 end) as A,Sum(case when v.StateStatus = 'Casual Leave' then 1 else 0 end) as 'CL',Sum(case when v.StateStatus = 'Sick Leave' then 1 else 0 end) as 'SL',Sum(case when v.StateStatus = 'Annual Leave' then 1 else 0 end) as 'EL', Sum(case when v.StateStatus = 'Maternity Leave' then 1 else 0 end) as 'ML', Sum(case when v.StateStatus = 'Leave Without Pay (LWP)' then 1 else 0 end) as 'LWP',sum(case when v.ATTStatus = 'Lv'then 1 else 0 end) as Lv from v_tblAttendanceRecord v left outer join h on v.ATTDate=h.HDate  where  EmpId='" + salaryRecord.EmpId + "' And AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' group by EmpId";

            dt = CRUD.ExecuteReturnDataTable(query);
            if (dt != null && dt.Rows.Count > 0)
            {
                salaryRecord.PresentDay = int.Parse(dt.Rows[0]["P"].ToString());
                salaryRecord.LateDays = int.Parse(dt.Rows[0]["L"].ToString());
                salaryRecord.AbsentDay = int.Parse(dt.Rows[0]["A"].ToString());
                salaryRecord.CasualLeave = int.Parse(dt.Rows[0]["CL"].ToString());
                salaryRecord.SickLeave = int.Parse(dt.Rows[0]["SL"].ToString());
                salaryRecord.AnnualLeave = int.Parse(dt.Rows[0]["EL"].ToString());
                salaryRecord.LWP = int.Parse(dt.Rows[0]["LWP"].ToString());
                salaryRecord.ML = int.Parse(dt.Rows[0]["ML"].ToString());
                salaryRecord.TotalLeave = int.Parse(dt.Rows[0]["Lv"].ToString());
                salaryRecord.OthersLeave = salaryRecord.TotalLeave - (salaryRecord.CasualLeave + salaryRecord.SickLeave + salaryRecord.AnnualLeave + salaryRecord.LWP + salaryRecord.ML);
                salaryRecord.NightBillDays = int.Parse(dt.Rows[0]["NightAllowCount"].ToString());

            }
            return salaryRecord;
        }

        private SalaryRecord getAttendanceStatus(SalaryRecord salaryRecord)
        {
            //Attendance Summary 
            dt = new DataTable();

            string query = "select EmpId,sum(NightAllowCount) as NightAllowCount,sum(case when ATTStatus In ('P','L') AND PaybleDays='1' then 1 else 0 end  ) as P,sum(case when ATTStatus In ('L') AND PaybleDays='1' then 1 else 0 end  ) as L, Sum(Case when ATTStatus='A' or  StateStatus='Leave Without Pay (LWP)' or (ATTStatus In ('P','L') AND PaybleDays='0' ) then 1 else 0 end ) as A,Sum(case when StateStatus='Casual Leave' then 1 else 0 end) as 'CL',Sum(case when StateStatus = 'Sick Leave' then 1 else 0 end) as 'SL',Sum(case when StateStatus = 'Annual Leave' then 1 else 0 end) as 'EL', Sum(case when StateStatus = 'Maternity Leave' then 1 else 0 end) as 'ML', Sum(case when StateStatus = 'Leave Without Pay (LWP)' then 1 else 0 end) as 'LWP',sum(case when ATTStatus ='Lv'then 1 else 0 end  )  as Lv from v_tblAttendanceRecord where  EmpId='" + salaryRecord.EmpId + "' And AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' group by EmpId";

            dt = CRUD.ExecuteReturnDataTable(query);
            if (dt != null && dt.Rows.Count > 0)
            {
                salaryRecord.PresentDay = int.Parse(dt.Rows[0]["P"].ToString());
                salaryRecord.LateDays = int.Parse(dt.Rows[0]["L"].ToString());
                salaryRecord.AbsentDay = int.Parse(dt.Rows[0]["A"].ToString());
                salaryRecord.CasualLeave = int.Parse(dt.Rows[0]["CL"].ToString());
                salaryRecord.SickLeave = int.Parse(dt.Rows[0]["SL"].ToString());
                salaryRecord.AnnualLeave = int.Parse(dt.Rows[0]["EL"].ToString());
                salaryRecord.LWP = int.Parse(dt.Rows[0]["LWP"].ToString());
                salaryRecord.ML = int.Parse(dt.Rows[0]["ML"].ToString());
                salaryRecord.TotalLeave = int.Parse(dt.Rows[0]["Lv"].ToString());
                salaryRecord.OthersLeave = salaryRecord.TotalLeave - (salaryRecord.CasualLeave + salaryRecord.SickLeave + salaryRecord.AnnualLeave + salaryRecord.LWP + salaryRecord.ML);
                salaryRecord.NightBillDays = int.Parse(dt.Rows[0]["NightAllowCount"].ToString());

            }
            return salaryRecord;
        }

        private SalaryRecord getPayableDaysCalculation(SalaryRecord salaryRecord,bool hasSpesialGross,string PersentOfGross)
        {
            //WeekendHoliday
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select distinct format(ATTDate,'yyyy-MM-dd') as WeekendDate from v_tblAttendanceRecord where ATTDate>='" + salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' and  ATTDate<='" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' and EmpId='" + salaryRecord.EmpId + "' and ATTStatus='W' ");
            salaryRecord.WeekendHoliday = dt.Rows.Count;

            //FestivalHoliday
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select distinct format(ATTDate,'yyyy-MM-dd') as WeekendDate from v_tblAttendanceRecord where ATTDate>='" + salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' and  ATTDate<='" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' and EmpId='" + salaryRecord.EmpId + "' and ATTStatus='H' ");           
            salaryRecord.FestivalHoliday = dt.Rows.Count;

            double PresentSalary = salaryRecord.EmpPresentSalary;
            if (salaryRecord.FromDate.Day > 1 || salaryRecord.ToDate.Day < salaryRecord.DaysInMonth)
            {

                int TotalDays = (salaryRecord.ToDate.Day-salaryRecord.FromDate.Day) + 1;  // this line find out active days

                salaryRecord.Activeday = TotalDays - salaryRecord.WeekendHoliday - salaryRecord.FestivalHoliday;

                //-----------Get NetGross--------------------                
                PresentSalary = Round((salaryRecord.EmpPresentSalary / salaryRecord.DaysInMonth) * TotalDays);
                
                //-----------End Get NetGross----------------
            }  // else part is commented. becouse Active days for all regular employee is same, comes from Month setup.
            //else
            //{
            //    salaryRecord.Activeday = salaryRecord.DaysInMonth - salaryRecord.WeekendHoliday - salaryRecord.FestivalHoliday;
            //}
            if (hasSpesialGross)
            {              
                double percent = double.Parse(PersentOfGross);
                PresentSalary = PresentSalary * (percent / 100);
            }

            salaryRecord.EmpNetGross = PresentSalary;
            salaryRecord.PayableDays = salaryRecord.CasualLeave + salaryRecord.AnnualLeave + salaryRecord.SickLeave + salaryRecord.PresentDay + salaryRecord.WeekendHoliday + salaryRecord.FestivalHoliday;

            return salaryRecord;
        }


        private SalaryRecord getPayableDaysCalculation_Complaince(SalaryRecord salaryRecord, bool hasSpesialGross, string PersentOfGross)
        {
            //WeekendHoliday
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select distinct format(ATTDate,'yyyy-MM-dd') as WeekendDate from v_tblAttendanceRecord where ATTDate>='" + salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' and  ATTDate<='" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' and EmpId='" + salaryRecord.EmpId + "' and (ATTStatus='W' or isWeekend=1)");
            salaryRecord.WeekendHoliday = dt.Rows.Count;

            

            //FestivalHoliday
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(@"WITH h AS(SELECT CompanyId, HDate, 'H' AS AttStatus, 'Holiday' AS StateStatus
             FROM dbo.tblHolydayWork)
            select distinct format(ATTDate, 'yyyy-MM-dd') as WeekendDate from v_tblAttendanceRecord v left outer join h on v.ATTDate = h.HDate where ATTDate>='" + salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' and  ATTDate<='" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' and EmpId='" + salaryRecord.EmpId + "' and(h.HDate is not null or v.ATTStatus='H' )");
            salaryRecord.FestivalHoliday = dt.Rows.Count;

            

            double PresentSalary = salaryRecord.EmpPresentSalary;
            if (salaryRecord.FromDate.Day > 1 || salaryRecord.ToDate.Day < salaryRecord.DaysInMonth)
            {

                int TotalDays = (salaryRecord.ToDate.Day - salaryRecord.FromDate.Day) + 1;  // this line find out active days

                salaryRecord.Activeday = TotalDays - salaryRecord.WeekendHoliday - salaryRecord.FestivalHoliday;

                //-----------Get NetGross--------------------                
                PresentSalary = Round((salaryRecord.EmpPresentSalary / salaryRecord.DaysInMonth) * TotalDays);

                //-----------End Get NetGross----------------
            }  // else part is commented. becouse Active days for all regular employee is same, comes from Month setup.
            //else
            //{
            //    salaryRecord.Activeday = salaryRecord.DaysInMonth - salaryRecord.WeekendHoliday - salaryRecord.FestivalHoliday;
            //}
            if (hasSpesialGross)
            {
                double percent = double.Parse(PersentOfGross);
                PresentSalary = PresentSalary * (percent / 100);
            }

            salaryRecord.EmpNetGross = PresentSalary;
            salaryRecord.PayableDays = salaryRecord.CasualLeave + salaryRecord.AnnualLeave + salaryRecord.SickLeave + salaryRecord.PresentDay + salaryRecord.WeekendHoliday + salaryRecord.FestivalHoliday;

            return salaryRecord;
        }

        private Double Round(Double Amount)
        {
            double frac = Amount % 1;
            if (frac >= 0.5)
                Amount = Math.Ceiling(Amount);
            else
                Amount = Math.Floor(Amount);
            return Amount;
        }
        private Double getLateFine_old()
        {
            //Late Deduction
            if (salaryRecord.LateDays > 2)
            {
                int LateFineDays = salaryRecord.LateDays / 3;
                // salaryRecord.LateFine = Round(salaryRecord.BasicSalary / 30 * LateFineDays) ;
               return  Round(salaryRecord.EmpPresentSalary / 30 * LateFineDays); //static for Mollah Fashion
            }
            return 0;

        }


        private Double getLateFine(string lateDeduction)
        {
           
            JObject jObj = JObject.Parse(lateDeduction);

            int lateDaysPerDeduct = (int)jObj["lateDaysPerDeduct"];
            int deductDays = (int)jObj["deductDays"];
            string deductFrom = jObj["deductFrom"].ToString();
            if (salaryRecord.LateDays >= lateDaysPerDeduct)
            {
                int totalDeductDays = (salaryRecord.LateDays / lateDaysPerDeduct) * deductDays;

                double baseSalary = 0;
                if (deductFrom == "Basic")
                    baseSalary = salaryRecord.BasicSalary;
                else if (deductFrom == "Gross")
                    baseSalary = salaryRecord.EmpPresentSalary;

                return Round(baseSalary / 30 * totalDeductDays);
            }

            return 0;

        }








        private SalaryRecord getNetPayableCalculation(SalaryRecord salaryRecord,bool ckbAdvanceDeduction,string AbsentDeduction)
        {
            if(salaryRecord.AbsentDay>0)
                salaryRecord.AbsentDeduction = getAbsentDeduction(salaryRecord,AbsentDeduction, salaryRecord.AbsentDay);
            //string deductFrom = getAbsentDeduction(AbsentDeduction, salaryRecord.AbsentDay);
            //double amount = 0;
            //if (deductFrom == "Basic")
            //{
            //    amount= Round(salaryRecord.BasicSalary / 30 * salaryRecord.AbsentDay);
            //}
            //else
            //{
            //    amount = Round(salaryRecord.EmpPresentSalary / salaryRecord.DaysInMonth * salaryRecord.AbsentDay);
            //}
          


            // Absent Deduction
           //salaryRecord.AbsentDeduction =Round(salaryRecord.BasicSalary / 30 * salaryRecord.AbsentDay); //Always 30 days in month count for Absent Diduction at RSS
            /*salaryRecord.AbsentDeduction =Round(salaryRecord.EmpPresentSalary / 30 * salaryRecord.AbsentDay);*/ //static for Mollah Fashion
            
            double totalDeductions = salaryRecord.LateFine + salaryRecord.AbsentDeduction + salaryRecord.AdvanceDeduction + salaryRecord.ProvidentFund + salaryRecord.ProfitTax + salaryRecord.OthersDeduction;
            //Payable
            salaryRecord.Payable = Round(salaryRecord.EmpNetGross- totalDeductions);
            // Attendance Bonus

            //NetPayable (with normal OT)
            salaryRecord.NetPayable = salaryRecord.Payable + salaryRecord.AttendanceBonus + salaryRecord.OverTimeAmount+ salaryRecord.OthersPay +salaryRecord.NightbilAmount;
            //NetPayable (with actual OT)
            salaryRecord.TotalSalary = salaryRecord.Payable + salaryRecord.AttendanceBonus + salaryRecord.TotalOTAmount+ salaryRecord.OthersPay+ salaryRecord.NightbilAmount;
            if (salaryRecord.NetPayable > 0)
            {
                salaryRecord.NetPayable -= salaryRecord.Stampdeduct;
                salaryRecord.TotalSalary -= salaryRecord.Stampdeduct;
            }
            else
                salaryRecord.Stampdeduct = 0;

            return salaryRecord;
        }

        private SalaryRecord checkAttendanceBonus_old(SalaryRecord salaryRecord,string EmpDutyType)
        {

            if (salaryRecord.AbsentDay > 0 || salaryRecord.LateDays > 0 || salaryRecord.TotalLeave > 0)
                salaryRecord.AttendanceBonus = 0;
            else
            {
                //check absent 
                dt = new DataTable();
                dt = CRUD.ExecuteReturnDataTable("select distinct convert(varchar(11),AttDate,111) as AttDate,EmpId from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND (ATTStatus='A' or StateStatus='Leave Without Pay (LWP)')  AND AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM") + '-' + "01" + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd")+ "' Union select distinct convert(varchar(11),AttDate,111) as AttDate,EmpId from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND ATTStatus In ('P','L')  AND AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM") + '-' + "01" + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' AND PaybleDays='0' ");
                if (dt != null && dt.Rows.Count > 0)
                    salaryRecord.AttendanceBonus = 0;
                else
                {
                    //check leave 
                    dt = new DataTable();
                    dt = CRUD.ExecuteReturnDataTable("select distinct convert(varchar(11),AttDate,111) as AttDate,EmpId,StateStatus from v_tblAttendanceRecord where ATTStatus='lv'  AND EmpId='" + salaryRecord.EmpId + "' And AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM") + '-' + "01" + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "'");
                    if (dt != null && dt.Rows.Count > 0)
                        salaryRecord.AttendanceBonus = 0;
                    else
                    {
                        //check late 
                        dt = new DataTable();
                        dt = CRUD.ExecuteReturnDataTable("select distinct convert(varchar(11),AttDate,111) as AttDate, EmpId from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND ATTStatus='L' AND AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM") + "-01' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' AND PaybleDays='1' ");
                        if (dt != null && dt.Rows.Count > 0)
                            salaryRecord.AttendanceBonus = 0;
                        else
                        {
                            
                            //check late 
                            dt = new DataTable();
                            dt = CRUD.ExecuteReturnDataTable("select distinct format(ATTDate,'yyyy-MM-dd') as WeekendDate from v_tblAttendanceRecord where  ATTDate>='" + salaryRecord.FromDate.ToString("yyyy-MM") + "-" + "01" + "' and  ATTDate<='" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' and EmpId='" + salaryRecord.EmpId + "' and ATTStatus in('W','H') ");
                            int totalDays = dt.Rows.Count;
                            dt = new DataTable();
                            dt = CRUD.ExecuteReturnDataTable("select distinct SftId, EmpId,Convert(varchar(11),ATTDate,111) as ATTDate,InHour,InMin,InSec,OutHour,OutMin,OutSec,ATTStatus from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND ATTStatus In ('P','L')  AND AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM") + '-' + "01" + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' AND PaybleDays='1' ");
                            totalDays+= dt.Rows.Count;
                            if(totalDays!=salaryRecord.DaysInMonth)
                                salaryRecord.AttendanceBonus = 0;
                            else 
                            {                                
                                    for (int p = 0; p < dt.Rows.Count; p++)
                                    {
                                        DataTable dtTimeTable = new DataTable();
                                        DateTime Date = DateTime.Parse(dt.Rows[p]["ATTDate"].ToString());

                                        string _LoginTime = dt.Rows[p]["InHour"].ToString() + ":" + dt.Rows[p]["InMin"].ToString() + ":" + dt.Rows[p]["InSec"].ToString();
                                        if (EmpDutyType.Equals("Regular"))
                                        {
                                            dtTimeTable = new DataTable();
                                            dtTimeTable = CRUD.ExecuteReturnDataTable("select SftStartTime from HRD_SpecialTimetable where StartDate<= '" + Date.ToString("yyyy-MM-dd") + "' and  EndDate>= '" + Date.ToString("yyyy-MM-dd") + "'");

                                        }
                                        if (dtTimeTable == null || dtTimeTable.Rows.Count == 0)
                                        {
                                            dtTimeTable = new DataTable();
                                            dtTimeTable = CRUD.ExecuteReturnDataTable("select SftStartTime from HRD_Shift where SftId=" + dt.Rows[p]["SftId"].ToString());
                                        }
                                        if (dtTimeTable != null && dtTimeTable.Rows.Count > 0)
                                        {
                                            DateTime SftStartTime = DateTime.Parse(Date.ToString("yyyy-MM-dd") + " " + dtTimeTable.Rows[0]["SftStartTime"].ToString());
                                            DateTime LoginTime = DateTime.Parse(Date.ToString("yyyy-MM-dd") + " " + _LoginTime);
                                            if (SftStartTime < LoginTime)
                                            {
                                                salaryRecord.AttendanceBonus = 0;
                                                break;
                                            }
                                        }

                                    }
                            }
                           
                        }

                    }
                }

        
            }
            return salaryRecord;

        }



        private SalaryRecord checkAttendanceBonus(SalaryRecord salaryRecord, string EmpDutyType,string AttendanceBonus)
        {

              
              

            if (!HasCompleteDutyDays())
                return salaryRecord;
            if (salaryRecord.AbsentDay == salaryRecord.LWP)
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                Dictionary<string, object> data = (Dictionary<string, object>)serializer.DeserializeObject(AttendanceBonus);
                object[] rules = (object[])data["rules"];
                foreach (object ruleObj in rules)
                {
                    Dictionary<string, object> rule = (Dictionary<string, object>)ruleObj;
                    bool isValid = true;

                    if (rule.ContainsKey("emptype"))
                    {
                        int emptype = Convert.ToInt32(rule["emptype"]);
                        if (salaryRecord.EmpTypeId != emptype)
                            continue;
                    }
                    if (rule.ContainsKey("maxLeave"))
                    {
                        int maxLeave = Convert.ToInt32(rule["maxLeave"]);
                        if (salaryRecord.TotalLeave > maxLeave)
                            continue;
                    }
                    if (rule.ContainsKey("maxLate"))
                    {
                        int maxLate = Convert.ToInt32(rule["maxLate"]);
                        if (maxLate != 0 && salaryRecord.LateDays > maxLate)
                            continue;
                    }
                    if (isValid)
                    {
                        double bonus = Convert.ToDouble(rule["bonusAmount"]);
                        salaryRecord.AttendanceBonus = bonus;
                        break;
                    }
                }
                return salaryRecord;
            }
            else if (salaryRecord.AbsentDay > 0)
            { 
                return salaryRecord;
            }
            return salaryRecord;
        }


        

        


        private double getOthersPay(string EmpId)
        {
            dt = new DataTable();
            dt=CRUD.ExecuteReturnDataTable("select  ISNULL(Sum(OtherPay),0) OtherPay from Payroll_OthersPay where EmpId='" + EmpId + "' AND IsActive='1' ");
            return double.Parse(dt.Rows[0]["OtherPay"].ToString());
        }
        private double getStampDeduction_old()
        {
          
            dt = new DataTable();
            dt=CRUD.ExecuteReturnDataTable("select StampDeduct from HRD_AllownceSetting where AllownceId =(select max(AllownceId) from HRD_AllownceSetting)");
            return double.Parse(dt.Rows[0]["StampDeduct"].ToString());
        }


        private double getStampDeduction(string StampPolicy,string paymentMethod)
        {

            JObject obj = JObject.Parse(StampPolicy);
            JArray conditions = (JArray)obj["conditions"];

            foreach (JObject condition in conditions)
            {
                if (condition["paymentMethod"]?.ToString() == paymentMethod)
                {
                    return int.Parse(condition["deductAmount"]?.ToString() ?? "0");
                }
            }
            return 0;


            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select StampDeduct from HRD_AllownceSetting where AllownceId =(select max(AllownceId) from HRD_AllownceSetting)");
            return double.Parse(dt.Rows[0]["StampDeduct"].ToString());
        }

        private double getOthersDeduction(string EmpId,string MonthName)
        {
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select ISNULL(Sum(PAmount),0) PAmount from Payroll_Punishment where EmpId='" + EmpId + "' AND MonthName ='" + MonthName + "' ");
            return double.Parse(dt.Rows[0]["PAmount"].ToString());
        }
        private double getPF(DataRow employee,DateTime ToDate)
        {
            string _pfDate = employee["PfDate"].ToString();
            if (_pfDate.Trim().Length > 1)
            {
                string PFMember = employee["PfMember"].ToString();
                DateTime PfDate = DateTime.Parse(employee["PfDate"].ToString());
                if (PFMember.Equals("True") && PfDate <= ToDate)
                    return Round(double.Parse(employee["PFAmount"].ToString()));
               
            }
             return 0;
        }
        private double getAdvanceDeduction(string EmpId,DateTime FromDate)
        {
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select SL,LoanID,Month,Amount from Payroll_LoanMonthlySetup where Month='" +FromDate.ToString("yyyy-MM") + "- 01' and EmpId='" + EmpId + "'");
            if (dt != null && dt.Rows.Count > 0)
                return Round(double.Parse(dt.Rows[0]["Amount"].ToString()));
            return 0;
        }
        private double getPunishmentDeduction(string EmpId,DateTime FromDate)
        {
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select PAmount from Payroll_Punishment where EmpId='" + EmpId + "' and MonthName='"+ FromDate.ToString("MM-yyyy") + "'");
            if (dt != null && dt.Rows.Count > 0)
                return Round(double.Parse(dt.Rows[0]["PAmount"].ToString()));
            return 0;
        }
        private double getOTRate(double Salary)
        {
          //return Math.Round((Salary / 208) *2, 2); // here 208 is static.                
          return Math.Round((Salary * .005), 2); // 0.5 % of Gross for Mollah Fashion          
        }
        private double getOTAmout(string OverTime,double OTRate)
        {            
            string[] spltTime = OverTime.Split(':');
         
            double hours = double.Parse(spltTime[0]);
            double min = double.Parse(spltTime[1]);
            double secods = double.Parse(spltTime[2]);


      
            double secOttk = (OTRate / 3600) * secods;
            double minOttk = (OTRate / 60) * min;
            double hourlyot = OTRate * hours;
            return Round(secOttk+ minOttk+ hourlyot);             
        }
        private SalaryRecord getOverTime(SalaryRecord salaryRecord,DataRow employee)
        {
            //salaryRecord.OTRate = getOTRate(double.Parse(employee["BasicSalary"].ToString()));
            salaryRecord.OTRate = getOTRate(double.Parse(employee["EmpPresentSalary"].ToString())); // Gross for Mollah Fashion
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(@"DECLARE @maxOT VARCHAR(8) = '02:00:00' 
                                           Select  isnull(CAST(SUM(DATEDIFF(second, 0, case when ATTStatus='W' or ATTStatus='H' then '00:00:00' else case when TotalOverTime>@maxOT then  '02:0'+SUBSTRING(OutMin,2,1)+':'+OutSec else TotalOverTime end end)) / 3600 AS varchar(12)) + ':' + RIGHT('0' + CAST(SUM(DATEDIFF(second, 0, case when ATTStatus='W' or ATTStatus='H' then '00:00:00' else case when TotalOverTime>@maxOT then  '02:0'+SUBSTRING(OutMin,2,1)+':'+OutSec else TotalOverTime end end)) / 60 % 60 AS varchar(2)), 2) + ':' +RIGHT('0' + CAST(SUM(DATEDIFF(second, 0, case when ATTStatus='W' or ATTStatus='H' then '00:00:00' else case when TotalOverTime>@maxOT then  '02:0'+SUBSTRING(OutMin,2,1)+':'+OutSec else TotalOverTime end end)) % 60 AS varchar(2)), 2),'00:00:00') AS OverTime,isnull(CAST(SUM(DATEDIFF(second, 0, TotalOverTime)) / 3600 AS varchar(12)) + ':' + RIGHT('0' + CAST(SUM(DATEDIFF(second, 0, TotalOverTime)) / 60 % 60 AS varchar(2)), 2) + ':' +RIGHT('0' + CAST(SUM(DATEDIFF(second, 0, TotalOverTime)) % 60 AS varchar(2)), 2),'00:00:00') AS TotalOverTime from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND AttDate >='" +salaryRecord.FromDate.ToString("yyyy-MM-dd") + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "'  and IsOverTime='1' and IsActive='1'");
            if (dt!=null && dt.Rows.Count > 0)
            {
                //// normal overtime as per compliance
                //salaryRecord.OverTime = dt.Rows[0]["OverTime"].ToString();
                //salaryRecord.OverTimeAmount = getOTAmout(salaryRecord.OverTime, salaryRecord.OTRate);

                // normal overtime as per Mollah Fassion
                salaryRecord.OverTime = dt.Rows[0]["TotalOverTime"].ToString();
                salaryRecord.OverTimeAmount = getOTAmout(salaryRecord.OverTime, salaryRecord.OTRate);


                //total overtime for regular
                salaryRecord.TotalOverTime = dt.Rows[0]["TotalOverTime"].ToString();
                salaryRecord.TotalOTAmount = getOTAmout(salaryRecord.TotalOverTime, salaryRecord.OTRate);              

            }
            return salaryRecord;
        }
        private bool saveSalary(SalaryRecord salaryRecord)
        {
            int actualAbsent = salaryRecord.AbsentDay - salaryRecord.LWP;
           return  CRUD.Execute(@"insert into Payroll_MonthlySalarySheet(CompanyId,SftId,EmpId,EmpCardNo,YearMonth,DaysInMonth,Activeday,WeekendHoliday,PayableDays,CasualLeave,SickLeave,
                            AnnualLeave,OthersLeave,FestivalHoliday,AbsentDay,PresentDay,EmpPresentSalary,BasicSalary,HouseRent,MedicalAllownce,ConvenceAllownce,FoodAllownce,TechnicalAllowance,
                            OthersAllownce,AdvanceDeduction,AbsentDeduction,AttendanceBonus,Payable,OverTime,OverTimeAmount,TotalOTHour,OTRate,TotalOTAmount,NetPayable,Stampdeduct,
                            TotalSalary,DptId,DsgId,GrdName,EmpTypeId,EmpStatus,UserId,IsSeperationGeneration,GenerateDate,LateDays,LateFine,TiffinDays,TiffinTaka,TiffinBillAmount,HolidayWorkingDays,HolidayTaka,HoliDayBillAmount,ProvidentFund,
                            OthersPay,OthersDeduction,ProfitTax,NightbilAmount,NightBillDays,EmpNetGross,FromDate,ToDate,LWP,EmpSeparationId)
                            values('" + salaryRecord .CompanyId+@"',"+ salaryRecord.SftId + @",'"+ salaryRecord .EmpId+ @"','"+salaryRecord.EmpCardNo + @"','"+ salaryRecord.YearMonth.ToString("yyyy-MM-dd") + 
                            @"',"+salaryRecord.DaysInMonth+@","+salaryRecord.Activeday+@","+ salaryRecord.WeekendHoliday+ @","+ salaryRecord.PayableDays + @","+ salaryRecord.CasualLeave +
                            @"," + salaryRecord.SickLeave + @"," + salaryRecord.AnnualLeave + @"," + salaryRecord.OthersLeave + @"," + salaryRecord.FestivalHoliday + @"," + actualAbsent +
                            @"," + salaryRecord.PresentDay + @",'" + salaryRecord.EmpPresentSalary + @"','" + salaryRecord.BasicSalary + @"','" + salaryRecord.HouseRent +
                            @"','" + salaryRecord.MedicalAllownce + @"','" + salaryRecord.ConvenceAllownce + @"','" + salaryRecord.FoodAllownce +
                            @"','" + salaryRecord.TechnicalAllowance + @"','" + salaryRecord.OthersAllownce + @"','" + salaryRecord.AdvanceDeduction + @"','" + salaryRecord.AbsentDeduction +
                            @"','" + salaryRecord.AttendanceBonus + @"','" + salaryRecord.Payable +"','"+ salaryRecord .OverTime+ @"','"+ salaryRecord.OverTimeAmount + @"','" + salaryRecord.TotalOverTime + @"','" + salaryRecord.OTRate + @"','" + salaryRecord.TotalOTAmount +
                            @"','" + salaryRecord.NetPayable + @"','" + salaryRecord.Stampdeduct + @"','" + salaryRecord.TotalSalary + @"','" + salaryRecord.DptId + @"','" + salaryRecord.DsgId + @"','" + salaryRecord.GrdName +
                            @"','" + salaryRecord.EmpTypeId + @"','" + salaryRecord.EmpStatus + @"','" + salaryRecord.UserId + @"',"+ salaryRecord .IsSeperationGeneration+ ",'" + salaryRecord.GenerateDate.ToString("yyyy-MM-dd") +
                            @"','" + salaryRecord.LateDays + @"','" + salaryRecord.LateFine + @"','" + salaryRecord.TiffinDays + @"','" + salaryRecord.TiffinTaka +
                            @"','" + salaryRecord.TiffinBillAmount + @"','" + salaryRecord.HolidayWorkingDays + @"','" + salaryRecord.HolidayTaka + @"','" + salaryRecord.HoliDayBillAmount + @"','" + salaryRecord.ProvidentFund +
                            @"','" + salaryRecord.OthersPay + @"','" + salaryRecord.OthersDeduction + @"','" + salaryRecord.ProfitTax + @"','" + salaryRecord.NightbilAmount +
                            @"','" + salaryRecord.NightBillDays + @"','" + salaryRecord.EmpNetGross + @"','" + salaryRecord.FromDateForAll.ToString("yyyy-MM-dd") + @"','" + salaryRecord.ToDateForAll.ToString("yyyy-MM-dd") + @"','" + salaryRecord.LWP + @"',"+ salaryRecord.EmpSeparationId + ")");

            
         
        }



        private bool saveSalaryComplaince(SalaryRecord salaryRecord)
        {
            int actualAbsent = salaryRecord.AbsentDay - salaryRecord.LWP;
            return CRUD.Execute(@"insert into Payroll_monthlysalarysheet_Compliances(CompanyId,SftId,EmpId,EmpCardNo,YearMonth,DaysInMonth,Activeday,WeekendHoliday,PayableDays,CasualLeave,SickLeave,
                            AnnualLeave,OthersLeave,FestivalHoliday,AbsentDay,PresentDay,EmpPresentSalary,BasicSalary,HouseRent,MedicalAllownce,ConvenceAllownce,FoodAllownce,TechnicalAllowance,
                            OthersAllownce,AdvanceDeduction,AbsentDeduction,AttendanceBonus,Payable,OverTime,OverTimeAmount,TotalOTHour,OTRate,TotalOTAmount,NetPayable,Stampdeduct,
                            TotalSalary,DptId,DsgId,GrdName,EmpTypeId,EmpStatus,UserId,IsSeperationGeneration,GenerateDate,LateDays,LateFine,TiffinDays,TiffinTaka,TiffinBillAmount,HolidayWorkingDays,HolidayTaka,HoliDayBillAmount,ProvidentFund,
                            OthersPay,OthersDeduction,ProfitTax,NightbilAmount,NightBillDays,EmpNetGross,FromDate,ToDate,LWP,EmpSeparationId)
                            values('" + salaryRecord.CompanyId + @"'," + salaryRecord.SftId + @",'" + salaryRecord.EmpId + @"','" + salaryRecord.EmpCardNo + @"','" + salaryRecord.YearMonth.ToString("yyyy-MM-dd") +
                             @"'," + salaryRecord.DaysInMonth + @"," + salaryRecord.Activeday + @"," + salaryRecord.WeekendHoliday + @"," + salaryRecord.PayableDays + @"," + salaryRecord.CasualLeave +
                             @"," + salaryRecord.SickLeave + @"," + salaryRecord.AnnualLeave + @"," + salaryRecord.OthersLeave + @"," + salaryRecord.FestivalHoliday + @"," + actualAbsent +
                             @"," + salaryRecord.PresentDay + @",'" + salaryRecord.EmpPresentSalary + @"','" + salaryRecord.BasicSalary + @"','" + salaryRecord.HouseRent +
                             @"','" + salaryRecord.MedicalAllownce + @"','" + salaryRecord.ConvenceAllownce + @"','" + salaryRecord.FoodAllownce +
                             @"','" + salaryRecord.TechnicalAllowance + @"','" + salaryRecord.OthersAllownce + @"','" + salaryRecord.AdvanceDeduction + @"','" + salaryRecord.AbsentDeduction +
                             @"','" + salaryRecord.AttendanceBonus + @"','" + salaryRecord.Payable + "','" + salaryRecord.OverTime + @"','" + salaryRecord.OverTimeAmount + @"','" + salaryRecord.TotalOverTime + @"','" + salaryRecord.OTRate + @"','" + salaryRecord.TotalOTAmount +
                             @"','" + salaryRecord.NetPayable + @"','" + salaryRecord.Stampdeduct + @"','" + salaryRecord.TotalSalary + @"','" + salaryRecord.DptId + @"','" + salaryRecord.DsgId + @"','" + salaryRecord.GrdName +
                             @"','" + salaryRecord.EmpTypeId + @"','" + salaryRecord.EmpStatus + @"','" + salaryRecord.UserId + @"'," + salaryRecord.IsSeperationGeneration + ",'" + salaryRecord.GenerateDate.ToString("yyyy-MM-dd") +
                             @"','" + salaryRecord.LateDays + @"','" + salaryRecord.LateFine + @"','" + salaryRecord.TiffinDays + @"','" + salaryRecord.TiffinTaka +
                             @"','" + salaryRecord.TiffinBillAmount + @"','" + salaryRecord.HolidayWorkingDays + @"','" + salaryRecord.HolidayTaka + @"','" + salaryRecord.HoliDayBillAmount + @"','" + salaryRecord.ProvidentFund +
                             @"','" + salaryRecord.OthersPay + @"','" + salaryRecord.OthersDeduction + @"','" + salaryRecord.ProfitTax + @"','" + salaryRecord.NightbilAmount +
                             @"','" + salaryRecord.NightBillDays + @"','" + salaryRecord.EmpNetGross + @"','" + salaryRecord.FromDateForAll.ToString("yyyy-MM-dd") + @"','" + salaryRecord.ToDateForAll.ToString("yyyy-MM-dd") + @"','" + salaryRecord.LWP + @"'," + salaryRecord.EmpSeparationId + ")");



        }
        private void savePFRecord(string EmpId, string YearMonth,double PFAmount)
        {
            try
            {
                CRUD.Execute("Delete PF_PFRecord where convert(varchar(10), Month,120)='" + YearMonth + "' and EmpID='" + EmpId + "'");
                CRUD.Execute("insert into PF_PFRecord values('" + EmpId + "','" + YearMonth + "','" +
                   PFAmount + "','" + PFAmount + "','0') ");
            }
            catch { }
        }
        private void updateTaxRecord(string EmpId, string YearMonth)
        {
            try
            {
                
                CRUD.Execute("update VatTax_IncomeTaxDetailsLog set isPaid=1 where EmpId='" + EmpId + "' and Month='" + YearMonth + "'");
            }
            catch { }
        }
        private void updateLoanStatus(string EmpId,string Month )
        {
            try
            {               
                    CRUD.Execute("Update Payroll_LoanMonthlySetup set IsPaid=1 Where EmpID='"+ EmpId + "' and Month='"+ Month + "'" );          
            }
            catch { }

        }
        private void salarySheetClear(DateTime ToDate, string CompanyId,string EmpId)
        {
            try
            {
                EmpId = (EmpId == "0") ? "" : " and EmpId ='" + EmpId + "'";
                CRUD.Execute("delete from Payroll_MonthlySalarySheet where CompanyId='" + CompanyId + "'  AND YearMonth='" + ToDate.ToString("yyyy-MM") + "-01' And ToDate='" + ToDate.ToString("yyyy-MM-dd") + "' AND EmpStatus in ('1','8') AND IsSeperationGeneration='0' "+ EmpId);
            }
            catch { }
        }


        private void salarySheetClear_Complaince(DateTime ToDate, string CompanyId, string EmpId)
        {
            try
            {
                EmpId = (EmpId == "0") ? "" : " and EmpId ='" + EmpId + "'";
                CRUD.Execute("delete from Payroll_monthlysalarysheet_Compliances where CompanyId='" + CompanyId + "'  AND YearMonth='" + ToDate.ToString("yyyy-MM") + "-01' And ToDate='" + ToDate.ToString("yyyy-MM-dd") + "' AND EmpStatus in ('1','8') AND IsSeperationGeneration='0' " + EmpId);
            }
            catch { }
        }

        private void salarySheetClearForSeparation(DateTime ToDate, string CompanyId, string EmpIds)
        {
            try
            {
                // EmpId = (EmpId == "0") ? "" : " and EmpId ='" + EmpId + "'";
                //CRUD.Execute("delete from Payroll_MonthlySalarySheet where CompanyId='" + CompanyId + "'  AND YearMonth='" + ToDate.ToString("yyyy-MM") + "-01'  AND IsSeperationGeneration='1' " + EmpId);
                CRUD.Execute(@"DELETE FROM Payroll_MonthlySalarySheet 
               WHERE CompanyId = '" + CompanyId + @"' 
               AND YearMonth = '" + ToDate.ToString("yyyy-MM") + @"-01' 
               AND EmpId IN (" + EmpIds + ")");
            }
            catch { }
        }


        private void salarySheetClearForSeparation_complaince(DateTime ToDate, string CompanyId, string EmpId)
        {
            try
            {
                EmpId = (EmpId == "0") ? "" : " and EmpId ='" + EmpId + "'";
                CRUD.Execute("delete from Payroll_monthlysalarysheet_Compliances where CompanyId='" + CompanyId + "'  AND YearMonth='" + ToDate.ToString("yyyy-MM") + "-01'  AND IsSeperationGeneration='1' " + EmpId);
            }
            catch { }
        }



        private Dictionary<string,string> getPayrollPolicy(string companyId,string compailance)
        {
            Dictionary<string, string> payrollPolicyDict = new Dictionary<string, string>();

            string query = "select PolicyType,PolicyJson from Payroll_Policies where CompanyId='"+ companyId + "' and PolicyCategory like '%"+ compailance + "%'";
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(query);
            foreach (DataRow row in dt.Rows)
            {
                string policyType = row["PolicyType"].ToString();
                string policyJson = row["PolicyJson"].ToString();

                if (!payrollPolicyDict.ContainsKey(policyType))
                {
                    payrollPolicyDict.Add(policyType, policyJson);
                }
            }
            return payrollPolicyDict;
        }


        private double getAbsentDeduction(SalaryRecord salaryRecord,string AbsentDeduct,int absentDays)
        {
            JObject jObj = JObject.Parse(AbsentDeduct);
            JArray rulesArray = (JArray)jObj["rules"];

            foreach (JObject rule in rulesArray)
            {
                if (rule.ContainsKey("maxAbsent"))
                {
                    if (rule["maxAbsent"] != null)
                    {
                        int maxAbsent = (int)rule["maxAbsent"];
                        if (absentDays < maxAbsent)
                        {
                            if (rule["deductFrom"].ToString() == "Basic")
                            {
                                return Round(salaryRecord.BasicSalary / 30 * salaryRecord.AbsentDay);
                            }
                            else
                            {
                                return Round(salaryRecord.EmpPresentSalary / salaryRecord.DaysInMonth * salaryRecord.AbsentDay);
                            }
                        }

                    }
                }
                else
                {
                    if (rule["deductFrom"].ToString() == "Basic")
                    {
                        return Round(salaryRecord.BasicSalary / 30 * salaryRecord.AbsentDay);
                    }
                    else
                    {
                        return Round(salaryRecord.EmpPresentSalary / salaryRecord.DaysInMonth * salaryRecord.AbsentDay);
                    }
                }
                

              
               
            }

            return 0;
            



            //string deductFrom = getAbsentDeduction(AbsentDeduction, salaryRecord.AbsentDay);
            //double amount = 0;
            //if (deductFrom == "Basic")
            //{
            //    amount= Round(salaryRecord.BasicSalary / 30 * salaryRecord.AbsentDay);
            //}
            //else
            //{
            //    amount = Round(salaryRecord.EmpPresentSalary / salaryRecord.DaysInMonth * salaryRecord.AbsentDay);
            //}

        }


        private Dictionary<string, DataRow> getAllAdvanceDeduction(DateTime FromDate, string EmpId)
        {
            query = "select EmpID,Amount from Payroll_LoanMonthlySetup where Month='" + FromDate.ToString("yyyy-MM") + "-01'";
            if (EmpId != "")
                query += " and EmpId='" + EmpId + "'";
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(query);
            return convertDatatableToDict(dt, "EmpId");
        }

        private Dictionary<string, DataRow> getAllPunishment(string EmpId, DateTime FromDate)
        {
            string query= "select EmpId, PAmount from Payroll_Punishment where MonthName = '" + FromDate.ToString("MM-yyyy") + "'";
            if (EmpId != "")
                query += " and EmpId='" + EmpId + "'";
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(query);
            return convertDatatableToDict(dt, "EmpId");
        }


        public Dictionary<string, DataRow> convertDatatableToDict(DataTable dt, string keyName)
        {
            try
            {
                var dict = new Dictionary<string, DataRow>();

                foreach (DataRow row in dt.Rows)
                {
                    if (row[keyName] != DBNull.Value)
                    {
                        string key = row[keyName].ToString();
                        if (!dict.ContainsKey(key))
                            dict[key] = row;
                    }
                }

                return dict;
            }
            catch (Exception ex) { return null; }
        }

        private double CalculatedNightBill(string empType,string nightBillAllowance,int NightBillDays)
        {
            JObject jObj = JObject.Parse(nightBillAllowance);
            JArray rulesArray = (JArray)jObj["rules"];
            double nightBillAmount = 0;
            foreach(var rule in rulesArray)
            {
                if(empType== rule["empType"].ToString())
                {
                    nightBillAmount = Convert.ToInt32(rule["nightBill"].ToString()) * NightBillDays;
                    return nightBillAmount;
                }
            }
            return nightBillAmount;
        }


        private bool HasCompleteDutyDays()
        {
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select distinct format(ATTDate,'yyyy-MM-dd') as WeekendDate from v_tblAttendanceRecord where  ATTDate>='" + salaryRecord.FromDate.ToString("yyyy-MM") + "-" + "01" + "' and  ATTDate<='" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' and EmpId='" + salaryRecord.EmpId + "' and ATTStatus in('W','H') ");
            int totalDays = dt.Rows.Count;
            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select distinct SftId, EmpId,Convert(varchar(11),ATTDate,111) as ATTDate,InHour,InMin,InSec,OutHour,OutMin,OutSec,ATTStatus from v_tblAttendanceRecord where EmpId='" + salaryRecord.EmpId + "' AND ATTStatus In ('P','L')  AND AttDate >='" + salaryRecord.FromDate.ToString("yyyy-MM") + '-' + "01" + "' AND AttDate <= '" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' AND PaybleDays='1' ");
            totalDays += dt.Rows.Count;

            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select distinct format(ATTDate,'yyyy-MM-dd') as WeekendDate from v_tblAttendanceRecord where  ATTDate>='" + salaryRecord.FromDate.ToString("yyyy-MM") + "-" + "01" + "' and  ATTDate<='" + salaryRecord.ToDate.ToString("yyyy-MM-dd") + "' and EmpId='" + salaryRecord.EmpId + "' and ATTStatus in('LV') ");
            totalDays += dt.Rows.Count;
            if (totalDays != salaryRecord.DaysInMonth)
                return false;
            else
              return true;
        }



        private void ClearFinalSattlementSheet(DateTime ToDate, string CompanyId, string EmpId)
        {
            try
            {
                EmpId = (EmpId == "0") ? "" : " and EmpId ='" + EmpId + "'";
                CRUD.Execute("delete from Payroll_FinalSettlemnet where CompanyId='" + CompanyId + "'  AND convert(varchar(7),RetirementEffectiveDate)='" + ToDate.ToString("yyyy-MM") + "'" + EmpId);
            }
            catch (Exception ex) { }
        }



        private double getStampDeduction()
        {

            dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable("select StampDeduct from HRD_AllownceSetting where AllownceId =(select max(AllownceId) from HRD_AllownceSetting)");
            return double.Parse(dt.Rows[0]["StampDeduct"].ToString());
        }



        public void InsertPayrollFinalSettlement(string empId, string empTypeId, string empName, int dsgId, int dptId, string empCard, string empSeparationId, DateTime empJoiningDate, DateTime effectiveDate, int totalWorkingDays, float basicSalary,
       float houseRent, float medicalAllowenece, float foodAllowenece, float convenceAllowenece, float empPresentSalary, string companyId, string yearMonth, double stamDeducation, int noticeDay)
        {

            int NetPayable = 0;
            int paybleDays = 0;
            double otRate = 0;
            double totalOtAmount = 0;
            double othersDeduction = 0;
            double attendanceBonus = 0;
            double payableEarnLeaveDays = 0;
            double payableEarnLeaveAmount = 0;
            string totalOtHour = "00:00:00";
            DataTable dtEL = earnLeave(empId, yearMonth);
            DataTable dtSalary = getLastMonthSalary(empId, yearMonth, companyId);
            if (dtSalary.Rows.Count > 0)
            {
                NetPayable = Convert.ToInt32(dtSalary.Rows[0]["NetPayable"].ToString());
                paybleDays = Convert.ToInt32(dtSalary.Rows[0]["PayableDays"].ToString());
                totalOtHour = dtSalary.Rows[0]["OverTime"].ToString();
                otRate = Convert.ToDouble(dtSalary.Rows[0]["OTRate"]);
                totalOtAmount = Convert.ToDouble(dtSalary.Rows[0]["OverTimeAmount"]);
                othersDeduction = Convert.ToDouble(dtSalary.Rows[0]["OthersDeduction"]);
                attendanceBonus = Convert.ToDouble(dtSalary.Rows[0]["OthersDeduction"]);

            }
            if (dtEL.Rows.Count > 0)
            {
                payableEarnLeaveDays = Convert.ToDouble(dtEL.Rows[0]["PayableEarnLeaveDays"]);
                payableEarnLeaveAmount = Convert.ToDouble(dtEL.Rows[0]["PayableAmount"]);
                if (payableEarnLeaveAmount == 0)
                    payableEarnLeaveDays = 0;
            }
            double totalDays = (effectiveDate - empJoiningDate).TotalDays;
            // get service benefit
            var (ServiceBenefitAmount, serviceBefitDays) = CalculateServiceBenefit(empJoiningDate, effectiveDate, basicSalary, totalDays);
            double noticeDeduction = CalculateNoticePay(basicSalary, noticeDay);
            double total = (NetPayable + payableEarnLeaveAmount + ServiceBenefitAmount) - (noticeDeduction + stamDeducation);

            string insertQuery = $@"INSERT INTO Payroll_FinalSettlemnet 
                    (EmpId,EmpTypeId, DsgId, DptId, EmpCard, RegistrationId, EmpJoiningDate, RetirementEffectiveDate, TotalWorkingDays, Basic, HomeAllowence, MedicalAllowenece, FoodAllowence, ConvenceAllowence, EmpTotalSalary, MonthlyPayroll, TotalOtHours, OtRate, TotalOtAmount, AttendanceBonus, 
                    RetirementBenefits_Days, RetirementBenefits_Amount, EarnLeave, EarnLeaveAmount, StampDeduction, OthersDeducation, NoticeDeduction_Days, NoticeDeduction_Amount, ServiceBenefits_Days, ServiceBenefits_Amount, SuspensionAllowance, CompensationAmount_Days, CompensationAmount_Amount, TerminationNotice120DaysWages, Total, CompanyId,PayableDays) 
                    VALUES 
                    ('{empId}',{empTypeId}, {dsgId}, {dptId}, '{empCard}', '{empSeparationId}', '{empJoiningDate:yyyy-MM-dd}', '{effectiveDate:yyyy-MM-dd}', {totalDays}, {basicSalary}, {houseRent}, {medicalAllowenece}, {foodAllowenece}, {convenceAllowenece}, {empPresentSalary}, {NetPayable}, 
                    '{totalOtHour}', {otRate}, {totalOtAmount}, {attendanceBonus}, 
                    0, 
                    0,
                    {payableEarnLeaveDays}, {payableEarnLeaveAmount}, {stamDeducation}, {othersDeduction}, 
                    {noticeDay}, 
                    {noticeDeduction},
                    {serviceBefitDays}, -- ServiceBenefits_Days 
                    {ServiceBenefitAmount}, -- ServiceBenefits_Amount 
                    0, -- SuspensionAllowance 
                    0, -- CompensationAmount_Days 
                    0, -- CompensationAmount_Amount 
                    0, -- TerminationNotice120DaysWages 
                    {total}, '{companyId}',{paybleDays})";

            CRUD.Execute(insertQuery);

        }




        private (double ServiceBenefitAmount, double serviceBefitDays) CalculateServiceBenefit(DateTime empJoiningDate, DateTime effectiveDate, float basicSalary, double totalDays)
        {
            double payableYears = totalDays / 365;
            double serviceBenefitAmnt = 0;
            double days = 0;

            if (payableYears >= 5 && payableYears < 10)
            {
                days = Math.Round(payableYears * 14, 2);
                serviceBenefitAmnt = Math.Round((basicSalary / 30) * days, 0);
            }
            else if (payableYears >= 10)
            {
                days = Math.Round(payableYears * 30, 2);
                serviceBenefitAmnt = Math.Round((basicSalary / 30) * days, 0);
            }
            return (serviceBenefitAmnt, days);
        }


        private double CalculateNoticePay(float totalSalary, int days)
        {
            double noticeDeduction = (totalSalary / 30) * days;
            return noticeDeduction;
        }

        private DataTable earnLeave(string empId, string yearMonth)
        {
            try
            {
                string date = new DateTime(DateTime.ParseExact(yearMonth, "dd-MM-yyyy", null).Year, DateTime.ParseExact(yearMonth, "dd-MM-yyyy", null).Month, 1).ToString("yyyy-MM-dd");

                string query = "select PayableEarnLeaveDays,Round(PayableAmount,0)as PayableAmount from Payroll_EarnLeavePaymentSheet  where EmpId='" + empId + "' and YearMonth='" + date + "' and IsSeparated=1";
                DataTable dt = CRUD.ExecuteReturnDataTable(query);
                return dt;
            }
            catch (Exception ex)
            {

                return dt;
            }

        }


        private DataTable getLastMonthSalary(string empId, string yearMonth, string comapnyId)
        {
            try
            {
                string date = new DateTime(DateTime.ParseExact(yearMonth, "dd-MM-yyyy", null).Year, DateTime.ParseExact(yearMonth, "dd-MM-yyyy", null).Month, 1).ToString("yyyy-MM-dd");

                string query = "select OverTime,OverTimeAmount,OTRate,AttendanceBonus,OthersDeduction,NetPayable,PayableDays  from Payroll_MonthlySalarySheet Where CompanyId='" + comapnyId + "' and EmpId='" + empId + "' and YearMonth='" + date + "' and IsSeperationGeneration=1";
                DataTable dt = CRUD.ExecuteReturnDataTable(query);
                return dt;
            }
            catch (Exception ex)
            {
                return dt;
            }

        }

    }
}