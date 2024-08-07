﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace SigmaERP.classes
{
    public static class Routing
    {
        private static string rootURL = "hrms";
        public static string DashboardRouteName = "DashboardRoute";
        public static string DashboardRouteUrl = rootURL+"/dashboard";
        private static string DashboardRoutePhysicalFile = "~/hrms/dashboard.aspx";
        public static string LoginRouteName = "LoginRoute";
        public static string LoginRouteUrl = rootURL+"/login";
        private static string LoginRoutePhysicalFile = "~/hrms/UI/auth/login.aspx";
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute(LoginRouteName, LoginRouteUrl, LoginRoutePhysicalFile);
            routes.MapPageRoute(DashboardRouteName, DashboardRouteUrl, DashboardRoutePhysicalFile);
        }
    }
}