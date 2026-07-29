using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SigmaERP.hrms.DTO
{
    public class EmployeeImportErrorItem
    {
         public string EmpType { get; set; }
    public string SalaryType { get; set; }
    public string Salary { get; set; }
    public string FullName { get; set; }
    public string NameBangla { get; set; }
    public string Department { get; set; }
    public string Designation { get; set; }
    public string Group { get; set; }
    public string Shift { get; set; }
    public string EmpCardNo { get; set; }
    public string RegID { get; set; }
    public string EmpStatus { get; set; }
    public string Type { get; set; }
    public string DutyType { get; set; }
    public string WeekendType { get; set; }
    public string WeekendDayName { get; set; }
    public string JoiningDate { get; set; }
    public string CompanyName { get; set; }
    public string UnitName { get; set; }
    public string ErrorReason { get; set; }
    }
}
