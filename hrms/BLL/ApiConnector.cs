﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

namespace SigmaERP.hrms.BLL
{
    public  class ApiConnector
    {
       //public static string RootUrl = "https://localhost:7220";
       public static string RootUrl = ConfigurationManager.AppSettings["rootURLForAPI"];

        public string Login(string url, string userName, string userPassword, string CompanyId)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            string requestUrl = $"{RootUrl+url}?CompanyId={Uri.EscapeDataString(CompanyId)}";

            WebRequest webRequest = WebRequest.Create(requestUrl);
            webRequest.Method = "POST";
            webRequest.ContentType = "application/json";
            var requestBody = new
            {
                userName = userName,
                userPassword = userPassword
            };

            string json = JsonConvert.SerializeObject(requestBody);

            try
            {
                using (var streamWriter = new StreamWriter(webRequest.GetRequestStream()))
                {
                    streamWriter.Write(json);
                    streamWriter.Flush();
                    streamWriter.Close();
                }
                using (HttpWebResponse httpWebResponse = (HttpWebResponse)webRequest.GetResponse())
                using (Stream stream = httpWebResponse.GetResponseStream())
                {
                    StreamReader sr = new StreamReader(stream);
                    string response = sr.ReadToEnd();
                    sr.Close();
                    return response;
                }
            }
            catch (WebException ex)
            {
                using (Stream stream = ex.Response.GetResponseStream())
                using (StreamReader reader = new StreamReader(stream))
                {
                    string errorResponse = reader.ReadToEnd();
                    Console.WriteLine("Error: " + errorResponse);
                    return errorResponse;
                }
            }
        }
    }
}