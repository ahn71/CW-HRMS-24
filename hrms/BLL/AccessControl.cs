using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SigmaERP.hrms.BLL
{
    public static class AccessControl
    {
        public static int[] hasPermission(int[] PagePermissions)
        {
            int[] verifiedPermission;
            int[] userPermissionArray = HttpContext.Current.Session["__ActualPermission__"].ToString().Split(',').Select(int.Parse).ToArray();
            verifiedPermission = PagePermissions.Intersect(userPermissionArray).ToArray();

            return verifiedPermission;
        }

        public static void checkPermission(int userId)
        {
            string query = "select ur.Permissions,u.AdditionalPermissions,u.RemovedPermissions from userRoles ur inner join users u on ur.userroleId=u.userroleId where u.UserId="+userId;
            DataTable dt = CRUD.ExecuteReturnDataTable(query);
            DataRow dataRow = dt.Rows[0];
            string permissions = dataRow["Permissions"].ToString();
            string AdditionalPermissions = dataRow["AdditionalPermissions"].ToString();
            string RemovedPermissions = dataRow["RemovedPermissions"].ToString();
            string actualPerm = actualPermission(permissions, AdditionalPermissions, RemovedPermissions);
            HttpContext.Current.Session["__ActualPermission__"] = actualPerm;
        }

        private static string actualPermission(string permissions, string AdditionalPermissions, string RemovedPermissions)
        {
            List<int> addPermissionList = new List<int>();
            List<int> removePermissionList = new List<int>();


            List<int> permissionList = permissions.Trim('[', ']').Split(',').Select(int.Parse).ToList();
            if (!string.IsNullOrEmpty(AdditionalPermissions))
                addPermissionList = AdditionalPermissions.Trim('[', ']').Split(',').Select(int.Parse).ToList();
            if (!string.IsNullOrEmpty(RemovedPermissions))
                removePermissionList = RemovedPermissions.Trim('[', ']').Split(',').Select(int.Parse).ToList();
            foreach (int perm in addPermissionList)
            {
                if (!permissionList.Contains(perm))
                {
                    permissionList.Add(perm);
                }
            }
            foreach (int perm in removePermissionList)
            {
                permissionList.Remove(perm);
            }

            string actualPermission = string.Join(",", permissionList);
            return actualPermission;
        }


    }
}