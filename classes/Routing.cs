using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace SigmaERP.classes
{
    public static class Routing
    {
        private static string rootURL = "hrms";
        //public static string DashboardRouteName = "DashboardRoute";
        //public static string DashboardRouteUrl = rootURL+"/dashboard";
        //private static string DashboardRoutePhysicalFile = "~/hrms/dashboard.aspx";

        public static string LoginRouteName = "LoginRoute";
        public static string LoginRouteUrl = rootURL+"/login";
        private static string LoginRoutePhysicalFile = "~/hrms/UI/auth/login.aspx";
        public static void RegisterInitialRoutes(RouteCollection routes)
        {
            routes.MapPageRoute(LoginRouteName, LoginRouteUrl, LoginRoutePhysicalFile);          
        }
        class Route
        {
           public string Name { get; set; }
           public string Url { get; set; }
           public string PhysicalFile { get; set; }
        }
        public static void RegisterRoutes(RouteCollection routes)
        {
       
        List<Route> _routes = new List<Route> {
            new Route {Name= "DashboardRoute",Url= rootURL + "/dashboard",PhysicalFile= "~/hrms/dashboard.aspx" },
            new Route {Name= "DepartmentRoute",Url= rootURL + "/settings/departments",PhysicalFile= "~/hrd/department.aspx" }
        };
            // Route Registration
            foreach (Route _route in _routes)
            {                
                routes.MapPageRoute(_route.Name, _route.Url, _route.PhysicalFile);
            }
          //  routes.MapPageRoute(DashboardRouteName, DashboardRouteUrl, DashboardRoutePhysicalFile);
        }
    }
}