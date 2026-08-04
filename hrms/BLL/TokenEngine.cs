using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace SigmaERP.hrms.BLL
{
    public class TokenEngine
    {
        private static readonly Regex TokenPattern = new Regex(@"\{\{\s*(.*?)\s*\}\}", RegexOptions.Compiled);

        public static Dictionary<string, string> BuildFieldMap(DataRow row)
        {
            var map = new Dictionary<string, string>();
            foreach (DataColumn col in row.Table.Columns)
            {
                map[col.ColumnName] = row[col] == DBNull.Value ? string.Empty : row[col].ToString();
            }
            return map;
        }

   
        public static string Merge(string template, Dictionary<string, string> fieldValues)
        {
            return TokenPattern.Replace(template, m =>
            {
                var key = m.Groups[1].Value.Trim();
                return fieldValues.ContainsKey(key) ? fieldValues[key] : m.Value;
            });
        }

       
        public static List<string> ExtractTokens(string template)
        {
            var tokens = new List<string>();
            foreach (Match m in TokenPattern.Matches(template))
                tokens.Add(m.Groups[1].Value.Trim());
            return tokens;
        }
    }

}

