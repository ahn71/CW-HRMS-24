using System;
using System.Web;
using System.Web.UI;

namespace SigmaERP.hrms
{
    public partial class userdashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Attendance and leave data are loaded client-side from the
            // Attendance/Leave APIs using the session's company/employee/token.
        }
    }
}
