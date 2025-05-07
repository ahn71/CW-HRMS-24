using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SigmaERP.hrms.DTO
{
    public class ShiftDTO
    {
        public int SftId { get; set; }

        public string SftName { get; set; }

        public string SftStartTime { get; set; }
        public string StartingIN { get; set; }
        public string EndingIN { get; set; }


        public string SftEndTime { get; set; }
        public string StartingOUT { get; set; }
        public string EndingOUT { get; set; }

        public short? SftAcceptableLate { get; set; }
        public short? SftAcceptableEarlyOut { get; set; }
        public bool? SftOverTime { get; set; }
        public bool? IsActive { get; set; }
        public string Notes { get; set; }

        public string CompanyId { get; set; }

        public string DptId { get; set; }

        public string SftNameBangla { get; set; }
        public bool? IsNight { get; set; }
    }
}