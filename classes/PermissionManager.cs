
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using static SigmaERP.classes.Routing;

namespace SigmaERP.classes
{
    public static class PermissionManager
    {
        private const string SessionKey = "__UserPermissions__";

        public static void LoadPermissions(List<RouteDTO> moduleRoutes, List<PermissionRoute> permissionRoutes)
        {
            var allUrls = moduleRoutes
                .Where(m => !string.IsNullOrWhiteSpace(m.Url))
                .Select(m => m.Url.Trim().ToLower())
                .Concat(
                    permissionRoutes
                        .Where(p => !string.IsNullOrWhiteSpace(p.Url))
                        .Select(p => p.Url.Trim().ToLower())
                )
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .ToHashSet(StringComparer.OrdinalIgnoreCase);

            HttpContext.Current.Session[SessionKey] = allUrls;
        }

        public static bool IsUrlAllowed(string url)
        {
            if (HttpContext.Current.Session[SessionKey] is HashSet<string> allowedUrls)
            {
                return allowedUrls.Contains(url?.Trim().ToLower());
            }

            return false;
        }

        public static IEnumerable<string> GetAllPermissions()
        {
            if (HttpContext.Current.Session[SessionKey] is HashSet<string> allowedUrls)
            {
                return allowedUrls;
            }

            return Enumerable.Empty<string>();
        }
    }
}