using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace SigmaERP.hrms.Routs
{
    public static class Routing
    {
        public static string UserPermissionName = "PermissionsRoute";
        public static string IndexRouteUrl = "permissions";
        public static string IndexRoutePhysicalFile = "../userPermissions.aspx";

        // Method to register routes
        public static void RegisterRoutes(RouteCollection routes)
        {
            // Register the route
            routes.MapPageRoute("PermissionsRoute", "permissions", IndexRoutePhysicalFile);
        }
    }

   
}