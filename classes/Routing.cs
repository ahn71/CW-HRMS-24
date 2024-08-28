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
using SigmaERP.hrms.BLL;

namespace SigmaERP.classes
{
    public static class Routing
    {
        private static string rootURL = "hrms/";

        public static string LoginRouteName = "LoginRoute";
        public static string LoginRouteUrl = rootURL + "login";
        private static string LoginRoutePhysicalFile = "~/hrms/UI/auth/login.aspx";


       // public static string userName = "AccessControlUser";
       //// public static string userUrl = rootURL + "access-control/users";
       // public static string userUrl = rootURL + "users";
       // private static string userPhyLocation = "~/hrms/user.aspx";

        public static string dashboardRoutName = "Dashboard";
        public static string dashboardUrl = rootURL + "dashboard";
        private static string dashboardPhyLocation = "~/hrms/dashboard.aspx";

        public static string appSettingsName = "appSettings";
        public static string appSettingsUrl = rootURL + "app-settings";
        private static string appSettingsPhyLocation = "~/hrms/AppSettings.aspx";

        public static string defualtUrl = "~/" + dashboardUrl;
        public static void RegisterInitialRoutes(RouteCollection routes)
        {
            routes.Clear();
            routes.MapPageRoute(LoginRouteName, LoginRouteUrl, LoginRoutePhysicalFile);
            routes.MapPageRoute(dashboardRoutName, dashboardUrl, dashboardPhyLocation);
            routes.MapPageRoute(appSettingsName, appSettingsUrl, appSettingsPhyLocation);
            //routes.MapPageRoute(userName, userUrl, userPhyLocation);
        }



        //public class ApiResponse
        //{
        //    public int StatusCode { get; set; }
        //    public string Message { get; set; }
        //    public List<RouteDTO> Data { get; set; }
        //}

        public class ApiResponsePerm
        {
            public int StatusCode { get; set; }
            public string Message { get; set; }
            public List<PermissionRoute> Data { get; set; }
        }

        public static string ApiRootUrl = ApiConnector.RootUrl;
        private static string UserWithModuleUrl = ApiRootUrl + "/api/User/userWithModule";
        private static string UserWithPermissionUrl = ApiRootUrl + "/api/User/userWithPermission";

        private static string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJKV1RTZXJ2aWNlQWNjZXNzVG9rZW4iLCJpYXQiOiIxNzI0MjU4NjcwIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6Ikh1c0xTdEszcUdTRWFlTU9DVnNHMkE9PSIsImV4cCI6MTcyNjg1MDY3MH0.uk0BVPbbe7SdRQ08VoLarZY0L2EFMndoeXzs5MPQZLw";

        public class ParentDTO
        {
            public int ParentModuleID { get; set; }
            public string ParentModuleName { get; set; }
            public string ParentPhysicalLocation { get; set; }
            public string ParentUrl { get; set; }
        }

        public class ChildDTO
        {
            public int ChildModuleID { get; set; }
            public string ChildModuleName { get; set; }
            public string ChildPhysicalLocation { get; set; }
            public string ChildUrl { get; set; }
        }

        public class ParentChildDTO
        {
            public ParentDTO Parent { get; set; }
            public List<ChildDTO> Children { get; set; }
        }

        public class ApiResponse
        {
            public int StatusCode { get; set; }
            public string Message { get; set; }
            public List<ParentChildDTO> Data { get; set; }
        }

        public class RouteDTO
        {
            public string ModuleName { get; set; }
            public string PhysicalLocation { get; set; }
            public string Url { get; set; }
        }
        public static List<RouteDTO> FetchRoutesFromApi(string url, int userId)
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

                    // Deserialize the response
                    var apiResponse = JsonConvert.DeserializeObject<ApiResponse>(response);

                    // Map the data to RouteDTO
                    List<RouteDTO> routes = new List<RouteDTO>();

                    if (apiResponse?.Data != null)
                    {
                        foreach (var parentChild in apiResponse.Data)
                        {
                            // Add the parent module as a RouteDTO
                            routes.Add(new RouteDTO
                            {
                                ModuleName = parentChild.Parent.ParentModuleName,
                                PhysicalLocation = parentChild.Parent.ParentPhysicalLocation,
                                Url = parentChild.Parent.ParentUrl
                            });

                            // Add each child module as a RouteDTO
                            foreach (var child in parentChild.Children)
                            {
                                routes.Add(new RouteDTO
                                {
                                    ModuleName = child.ChildModuleName,
                                    PhysicalLocation = child.ChildPhysicalLocation,
                                    Url = child.ChildUrl
                                });
                            }
                        }
                    }

                    return routes;
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

       
        public static void RegisterRoutes(RouteCollection routes , int userId)
        {
           
            List <RouteDTO > moduleRoutes = FetchRoutesFromApi(UserWithModuleUrl, userId);
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