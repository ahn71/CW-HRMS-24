using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Routing;
using SigmaERP.hrms.DTO;
namespace SigmaERP.classes
{
    public static class Routing
    {
        private static string rootURL = "hrms/";

        public static string LoginRouteName = "LoginRoute";
        public static string LoginRouteUrl = rootURL + "login";
        private static string LoginRoutePhysicalFile = "~/hrms/UI/auth/login.aspx";


        public static string userName = "AccessControlUser";
       // public static string userUrl = rootURL + "access-control/users";
        public static string userUrl = rootURL + "users";
        private static string userPhyLocation = "~/hrms/user.aspx";

        public static string dashboardRoutName = "Dashboard";
        public static string dashboardUrl = rootURL + "dashboard";
        private static string dashboardPhyLocation = "~/hrms/dashboard.aspx";
        public static void RegisterInitialRoutes(RouteCollection routes)
        {
            routes.Clear();
            routes.MapPageRoute(LoginRouteName, LoginRouteUrl, LoginRoutePhysicalFile);
            routes.MapPageRoute(dashboardRoutName, dashboardUrl, dashboardPhyLocation);
            //routes.MapPageRoute(userName, userUrl, userPhyLocation);
        }



        public class ApiResponse
        {
            public int StatusCode { get; set; }
            public string Message { get; set; }
            public List<RouteDTO> Data { get; set; }
        }

        public class ApiResponsePerm
        {
            public int StatusCode { get; set; }
            public string Message { get; set; }
            public List<PermissionRoute> Data { get; set; }
        }
      
        private static string ApiRootUrl = "https://localhost:7220";
        private static string UserWithModuleUrl = ApiRootUrl + "/api/User/userWithModule";
        private static string UserWithPermissionUrl = ApiRootUrl + "/api/User/userWithPermission";

        private static string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJKV1RTZXJ2aWNlQWNjZXNzVG9rZW4iLCJpYXQiOiIxNzI0MjU4NjcwIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6Ikh1c0xTdEszcUdTRWFlTU9DVnNHMkE9PSIsImV4cCI6MTcyNjg1MDY3MH0.uk0BVPbbe7SdRQ08VoLarZY0L2EFMndoeXzs5MPQZLw";
        public static List<RouteDTO> FetchRoutesFromApi(string url, int userId)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            // Append UserId as a query string parameter to the URL
            string fullUrl = $"{url}?userId={userId}";

            WebRequest webRequest = WebRequest.Create(fullUrl);
            webRequest.Method = "GET";
            webRequest.Headers["Authorization"] = $"Bearer {token}";

            try
            {
                using (HttpWebResponse httpWebResponse = (HttpWebResponse)webRequest.GetResponse())
                using (Stream stream = httpWebResponse.GetResponseStream())
                using (StreamReader sr = new StreamReader(stream))
                {
                    string response = sr.ReadToEnd();
                    var apiResponse = JsonConvert.DeserializeObject<ApiResponse>(response);
                    return apiResponse?.Data ?? new List<RouteDTO>();
                }
            }
            catch (WebException ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                return new List<RouteDTO>();
            }
        }



        public static List<PermissionRoute> FetchPermissionRoutesFromApi(string url , int userId)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            string fullUrl = $"{url}?userId={userId}";

            WebRequest webRequest = WebRequest.Create(fullUrl);
            webRequest.Method = "GET";
            webRequest.Headers["Authorization"] = $"Bearer {token}";
            try
            {
                using (HttpWebResponse httpWebResponse = (HttpWebResponse)webRequest.GetResponse())
                using (Stream stream = httpWebResponse.GetResponseStream())
                using (StreamReader sr = new StreamReader(stream))
                {
                    string response = sr.ReadToEnd();
                    
                    var apipermResponse = JsonConvert.DeserializeObject<ApiResponsePerm>(response);
                    return apipermResponse?.Data ?? new List<PermissionRoute>();
                }
            }
            catch (WebException ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                return new List<PermissionRoute>();
            }
        }
        //public static void RegisterPermissionRoutes(RouteCollection routesPerm)
        //{
        //    routesPerm.Clear();

        //    List<PermissionRoute> _routes = FetchPermissionRoutesFromApi(UserWithPermissionUrl);

        //    foreach (PermissionRoute _route in _routes)
        //    {
        //        routesPerm.MapPageRoute(_route.PermissionName, rootURL + _route.Url, _route.PhysicalLocation);
        //    }

        //    List<Route> _routes = FetchRoutesFromApi(UserWithModuleUrl);

        //    routes.Clear();
        //    foreach (Route _route in _routes)
        //    {
        //        routes.MapPageRoute(_route.ModuleName, rootURL + _route.ModuleUrl, _route.ModulePhysicalLocation);
        //    }
        //}
       
        public static void RegisterRoutes(RouteCollection routes , int userId)
        {
            //int userId = Int32.Parse( HttpContext.Current.Session["__GetUID__"]);

            List <RouteDTO > moduleRoutes = FetchRoutesFromApi(UserWithModuleUrl, userId);
            //  routes.Clear();
            RegisterInitialRoutes(routes);
            foreach (RouteDTO moduleRoute in moduleRoutes)
            {
                //if (moduleRoute.PhysicalLocation == "~/hrms/user.aspx")
                //{
                //    //routes.MapPageRoute(moduleRoute.ModuleName, rootURL + moduleRoute.Url, moduleRoute.PhysicalLocation);

                //}
                
                
                 routes.MapPageRoute(moduleRoute.ModuleName, rootURL + moduleRoute.Url, moduleRoute.PhysicalLocation);
                
               
            }
 
            List<PermissionRoute> permissionRoutes = FetchPermissionRoutesFromApi(UserWithPermissionUrl, userId);
            foreach (PermissionRoute permissionRoute in permissionRoutes)
            {
                routes.MapPageRoute(permissionRoute.PermissionName, rootURL + permissionRoute.Url, permissionRoute.PhysicalLocation);
            }
            //routes.MapPageRoute("ErrorRoute", "{*.aspx}", "~/Error.aspx");
            //routes.RouteExistingFiles = true;
        }

    }
}