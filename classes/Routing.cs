using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Routing;

namespace SigmaERP.classes
{
    public static class Routing
    {
        private static string rootURL = "hrms/";

        public static string LoginRouteName = "LoginRoute";
        public static string LoginRouteUrl = rootURL + "login";
        private static string LoginRoutePhysicalFile = "~/hrms/UI/auth/login.aspx";

        public static void RegisterInitialRoutes(RouteCollection routes)
        {
            routes.MapPageRoute(LoginRouteName, LoginRouteUrl, LoginRoutePhysicalFile);
        }

        public class Route
        {
            public int ModuleID { get; set; }
            public string ModuleName { get; set; }
            public string ModuleUrl { get; set; }
            public string ModulePhysicalLocation { get; set; }
        }

        public class PermissionRoute
        {
            public int UserPermId { get; set; }
            public int ModuleID { get; set; }
            public string PermissionName { get; set; }
            public string Url { get; set; }
            public string PhysicalLocation { get; set; }
        }

        public class ApiResponse
        {
            public int StatusCode { get; set; }
            public string Message { get; set; }
            public List<Route> Data { get; set; }
        }

        public class ApiResponsePerm
        {
            public List<PermissionRoute> PermissionData { get; set; }
        }

        private static string ApiRootUrl = "https://localhost:7220";
        private static string UserWithModuleUrl = ApiRootUrl + "/api/User/userWithModule";
        private static string UserWithPermissionUrl = ApiRootUrl + "/api/User/userWithPermission";



        public static List<Route> FetchRoutesFromApi(string url)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            WebRequest webRequest = WebRequest.Create(url);
            webRequest.Method = "GET";

            try
            {
                using (HttpWebResponse httpWebResponse = (HttpWebResponse)webRequest.GetResponse())
                using (Stream stream = httpWebResponse.GetResponseStream())
                using (StreamReader sr = new StreamReader(stream))
                {
                    string response = sr.ReadToEnd();
                    var apiResponse = JsonConvert.DeserializeObject<ApiResponse>(response);
                    return apiResponse?.Data ?? new List<Route>();
                }
            }
            catch (WebException ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                return new List<Route>();
            }
        }

        public static List<PermissionRoute> FetchPermissionRoutesFromApi(string url)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            WebRequest webRequest = WebRequest.Create(url);
            webRequest.Method = "GET";

            try
            {
                using (HttpWebResponse httpWebResponse = (HttpWebResponse)webRequest.GetResponse())
                using (Stream stream = httpWebResponse.GetResponseStream())
                using (StreamReader sr = new StreamReader(stream))
                {
                    string response = sr.ReadToEnd();
                    Console.WriteLine("API Response: " + response);

                    var apiResponse = JsonConvert.DeserializeObject<ApiResponsePerm>(response);

                    if (apiResponse?.PermissionData == null || !apiResponse.PermissionData.Any())
                    {
                        Console.WriteLine("No data in PermissionData.");
                    }

                    return apiResponse?.PermissionData ?? new List<PermissionRoute>();
                }
            }
            catch (WebException ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                return new List<PermissionRoute>();
            }
        }
        public static void RegisterPermissionRoutes(RouteCollection routesPerm)
        {
            routesPerm.Clear();

            List<PermissionRoute> _routes = FetchPermissionRoutesFromApi(UserWithPermissionUrl);
            var filteredRoutes = _routes
                .Where(route => !string.IsNullOrEmpty(route.PhysicalLocation) || !string.IsNullOrEmpty(route.Url))
                .ToList();

            foreach (PermissionRoute _route in filteredRoutes)
            {
                routesPerm.MapPageRoute(_route.PermissionName, rootURL + _route.Url, _route.PhysicalLocation);
            }
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            List<Route> _routes = FetchRoutesFromApi(UserWithModuleUrl);

            routes.Clear();
            foreach (Route _route in _routes)
            {
                routes.MapPageRoute(_route.ModuleName, rootURL + _route.ModuleUrl, _route.ModulePhysicalLocation);
            }
        }
    }
}