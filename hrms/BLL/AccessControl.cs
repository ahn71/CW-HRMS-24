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
        public static int[] hasPermission(int[] PagePermissions,int [] UserPermissions)
        {
            int[] verifiedPermission;
            
            PagePermissions = new int []{ 191, 192, 194 , 193 };

            UserPermissions =new int []{120,121,123,124,125};
            verifiedPermission = PagePermissions.Intersect(UserPermissions).ToArray();

            return verifiedPermission;
        }

        public static string checkPermission()
        {
            string query = "select ur.Permissions,u.AdditionalPermissions,u.RemovedPermissions from userRoles ur inner join users u on ur.userroleId=u.userroleId where u.UserId=69";
            DataTable dt = CRUD.ExecuteReturnDataTable(query);
            DataRow dataRow = dt.Rows[0];
            string permissions = dataRow["Permissions"].ToString();
            string AdditionalPermissions = dataRow["AdditionalPermissions"].ToString();
            string RemovedPermissions = dataRow["RemovedPermissions"].ToString();
            string actualPerm = actualPermission(permissions, AdditionalPermissions, RemovedPermissions);
            return actualPerm;

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