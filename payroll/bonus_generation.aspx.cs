using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ComplexScriptingSystem;
using adviitRuntimeScripting;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.Drawing;
using System.Web.SessionState;
using System.Threading;
using SigmaERP.classes;
using SigmaERP.hrms.BLL;
using Newtonsoft.Json;
using System.Configuration;

namespace SigmaERP.payroll
{
    public partial class bonus_generation : System.Web.UI.Page
    {
        //permission=(Process=401,Delete=402) 
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            lblMessage.InnerText = "";

       

            if (!IsPostBack)
            {
                ViewState["__WriteAction__"] = "0";
                ViewState["__DeletAction__"] = "0";
                int[] pagePermission = { 401, 402 };
                Session["OPERATION_PROGRESS"] = 0;
                int[] userPagePermition = AccessControl.hasPermission(pagePermission);
                if (!userPagePermition.Any())
                    Response.Redirect(Routing.defualtUrl);
                setPrivilege(userPagePermition);
                if (!classes.commonTask.HasBranch())
                    ddlCompanyList.Enabled = false;
                ddlCompanyList.SelectedValue = ViewState["__CompanyId__"].ToString();
                loadMonthInf();
                 ViewState["__IsGerments__"] = classes.commonTask.IsGarments();
                loadExistingSalary();
                
            }
        }


        private void setPrivilege(int[] permission)
        {
            try
            {
               
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                HttpContext.Current.Session["__GetUserID__"] = ViewState["__UserId__"] = getUserId;
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();

                //if (ComplexLetters.getEntangledLetters(getCookies["__getUserType__"].ToString()).Equals("Super Admin") || ComplexLetters.getEntangledLetters(getCookies["__getUserType__"].ToString()).Equals("Master Admin"))
                //{
                //    classes.commonTask.LoadBranch(ddlCompanyList);
                //    return;
                //}
                //else
                //{
                    classes.commonTask.LoadBranch(ddlCompanyList, ViewState["__CompanyId__"].ToString());

                if(permission.Contains(401))
                    ViewState["__WriteAction__"] = "1";
                if(permission.Contains(402))
                    ViewState["__DeletAction__"] = "1";
                checkInitialPermission();
                //ddlCompanyList.Enabled = false;
                ////operation.Enabled = false;
                ////operation.CssClass = "";
                //DataTable dt = new DataTable();
                //sqlDB.fillDataTable("select * from UserPrivilege where PageName='bonus_generation.aspx' and UserId=" + getCookies["__getUserId__"].ToString() + "", dt);
                //if (dt.Rows.Count > 0)
                //{
                //    if (bool.Parse(dt.Rows[0]["GenerateAction"].ToString()).Equals(true))
                //    {
                //        //btnGeneration.CssClass = "css_btn";
                //        //btnGeneration.Enabled = true;
                //    }
                //}
                //}
            }
            catch { }
        }

        private void loadMonthInf()
        {
            try
            {

                DataTable dt = new DataTable();
                string CompanyId = (ddlCompanyList.SelectedValue.ToString().Equals("0000")) ? ViewState["__CompanyId__"].ToString() : ddlCompanyList.SelectedValue.ToString();
                sqlDB.fillDataTable("select distinct convert(varchar,BId)+'-'+Convert(varchar,RId) as BId,BonusType,Year from v_Payroll_BonusMonthSetup where CompanyId='"+CompanyId+"'  order by Year desc",dt);
                ddlSelectBonusMonth.DataTextField = "BonusType";
                ddlSelectBonusMonth.DataValueField = "BId";
                ddlSelectBonusMonth.DataSource = dt;
                ddlSelectBonusMonth.DataBind();
                ddlSelectBonusMonth.Items.Insert(0, new ListItem(" ","0"));
            }
            catch { }
        
        }
       
        protected void btnGeneration_Click(object sender, EventArgs e)
        {
            loadRunningEmpForBonus();            
            loadExistingSalary();
        }
        private void loadExistingSalary()
        {
            try
            {
                DataTable dtExSalary = new DataTable();
                sqlDB.fillDataTable("select top(4) BId,BonusType, sum( case when EmpTypeId =1 then 1 else 0 end) as worker,sum(case when EmpTypeId =2 then 1 else 0 end) as staff," +
                    "count(EmpId) as Total  from v_Payroll_YearlyBonusSheet where CompanyId = '"+ddlCompanyList.SelectedValue+"' group by BId, BonusType order by BId desc", dtExSalary);// this line add for RSS ,Date: 05-02-2018
                gvSalaryList.DataSource = dtExSalary;
                gvSalaryList.DataBind();
            }
            catch { }
        }
        DataTable dtRunningEmp = new DataTable();
        private void loadRunningEmpForBonus()
        {
            try
            {
                bonus_generation bg = new bonus_generation();
                string[] getBonusInfo = ddlSelectBonusMonth.Text.Split('-');
                bg.ViewState["__UserId__"] = Session["__GetUserID__"].ToString();
                // here getBonusInfo[0]=BId
                // and  getBonusInfo[1]=RId



                DataTable dtBonusMonthInfo = new DataTable();
                DataTable dtGetCalculationDate = new DataTable();

                string CompanyId = ddlCompanyList.SelectedValue;
                sqlDB.fillDataTable("select SlabType,Chosen,Percentage,BonusType,GenerateOn,EquivalentDays,BasedOnAttStatus from Payroll_BonusMonthSetup where BId ='" + getBonusInfo[0] + "' and Chosen=1", dtBonusMonthInfo);  // get bonusn month info start 12 months then 11 months then 10 mpnths as sequqntioaly 
                string[] GetBId = ddlSelectBonusMonth.Text.Split('-');
                sqlDB.fillDataTable("select convert(varchar(11),CalculationDate,111) as CalculationDate from v_Payroll_BonusSetup_DistinctRecord where BId ='" + GetBId[0] + "' ", dtGetCalculationDate);

                //--------------this connection for old data-----------------------
                SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["local2"].ConnectionString);
                con.Open();
                //---------------------------------------

                string ExceptedEmpCardNo = "";
                if (txtExceptedEmpCardNo.Text.Trim() != "")
                {
                    ExceptedEmpCardNo = " and EmpID not in(select EmpId from Personnel_EmployeeInfo where SUBSTRING(EmpCardNo,8,6) in(" + txtExceptedEmpCardNo.Text.Trim() + ") and CompanyId='" + CompanyId + "')";
                }
                string basedOnAttStatus = string.IsNullOrEmpty(dtBonusMonthInfo.Rows[0]["BasedOnAttStatus"]?.ToString())
                          ? ""
                          : dtBonusMonthInfo.Rows[0]["BasedOnAttStatus"].ToString();
                string attStatus = "";
                if (!String.IsNullOrEmpty(basedOnAttStatus))
                {
                    List<string> statusList = JsonConvert.DeserializeObject<List<string>>(dtBonusMonthInfo.Rows[0]["dtBonusMonthInfo"].ToString());

                    attStatus = $"and at.ATTStatus in({ string.Join(",", statusList.Select(s => $"'{s}'"))})";

                }
                string sqlquery = "";
                if (getBonusInfo[1] != "0" && getBonusInfo[1] == "1") { 

                    //sqlquery = "select EmpId,EmpCardNo,EmpName,SN,EmpType,EmpTypeId,EmpStatus,ActiveSalary,Convert(varchar(11)," +
                    //   "EmpJoiningDate,111) as EmpJoiningDate,BasicSalary,EmpPresentSalary,IsActive,CompanyId,RId  from v_Personnel_EmpCurrentStatus" +
                    //   " where  EmpStatus in('1','8')  AND ActiveSalary='true' AND IsActive='1' AND CompanyId='" + CompanyId + "' " + ExceptedEmpCardNo;

                sqlquery = @"select  count(at.ATTStatus) as AttendanceDay,cs.EmpId,cs.EmpCardNo,ei.EmpName,cs.SN,cs.EmpTypeId,cs.EmpStatus,ActiveSalary,Convert(varchar(11),EmpJoiningDate,111) as EmpJoiningDate,BasicSalary,EmpPresentSalary,IsActive,cs.CompanyId,ep.RId,cs.DptId,cs.DsgId,cs.SftId   from Personnel_EmployeeInfo ei inner join Personnel_EmpCurrentStatus cs on ei.EmpId=cs.EmpId and IsActive=1 inner join Personnel_EmpPersonnal ep on cs.EmpId=ep.EmpId inner join tblAttendanceRecord at on cs.EmpId=at.EmpId 
                 where cs.EmpStatus in('1', '8')  AND cs.ActiveSalary = 'true' " + attStatus + " AND cs.CompanyId='" + CompanyId + "' "+ ExceptedEmpCardNo + "  GROUP BY cs.EmpId, cs.EmpCardNo, ei.EmpName, cs.SN, cs.EmpTypeId, cs.EmpStatus,cs.ActiveSalary, ei.EmpJoiningDate, cs.BasicSalary, cs.EmpPresentSalary, cs.IsActive, cs.CompanyId, ep.RId, cs.DptId, cs.DsgId, cs.SftId";
            }

                else
                     sqlquery = "select  EmpId,EmpCardNo,EmpName,  SN,EmpType,EmpTypeId,EmpStatus,ActiveSalary,Convert(varchar(11)," +
                    "EmpJoiningDate,111) as EmpJoiningDate,BasicSalary,EmpPresentSalary,IsActive,CompanyId,RId  from v_Personnel_EmpCurrentStatus" +
                    " where  EmpStatus in('1','8')  AND ActiveSalary='true' AND IsActive='1' AND RId='" + getBonusInfo[1] + "' CompanyId='" + CompanyId + "'" + ExceptedEmpCardNo;

                SqlDataAdapter da = new SqlDataAdapter(sqlquery, con);
                da.Fill(bg.dtRunningEmp = new DataTable());
                con.Close();
              //  sqlDB.fillDataTable(sqlquery, bg.dtRunningEmp = new DataTable());               

                

                if (bg.dtRunningEmp.Rows.Count < 1)
                {


                    return;
                }
                ClearYearlyBonusSheetByBonusType(getBonusInfo[0]);
                DataTable dt = new DataTable();
                DataTable dtWorkerAttInfo = new DataTable();
                DataTable dtBonus = CreateBonusDataTable();
                for (int i = 0; i < bg.dtRunningEmp.Rows.Count; i++)
                {

                    int getValue = 0;
                    if (i != 0) getValue = (100 * i / (bg.dtRunningEmp.Rows.Count - 1));
                    //probar.Style.Add("width", getValue.ToString()+"%");


                    //probar.InnerHtml = getValue.ToString() + "%";   

                    //System.Threading.Thread.Sleep(500);

                    string Percentage = "";

                    string BasicOrPresintSalary = "";
                    if (dtBonusMonthInfo.Rows[0]["GenerateOn"].ToString() == "Basic Salary") BasicOrPresintSalary = bg.dtRunningEmp.Rows[i]["BasicSalary"].ToString();
                    else BasicOrPresintSalary = bg.dtRunningEmp.Rows[i]["EmpPresentSalary"].ToString();

                  
                       

                    DataRow[] dr = bg.dtRunningEmp.Select("EmpCardNo='00003017'", "");

                    if (bg.dtRunningEmp.Rows[i]["EmpCardNo"].ToString() == "00003017")
                    {

                    }

                    //sqlDB.fillDataTable("select DateDiff (day,'" + bg.dtRunningEmp.Rows[i]["EmpJoiningDate"].ToString() + "','" + dtGetCalculationDate.Rows[0]["CalculationDate"].ToString() + "') as TotalDays", dt=new DataTable());
                    

                    //double attendanceDay = getAttendanceDay(bg.dtRunningEmp.Rows[i]["EmpJoiningDate"].ToString(), basedOnAttStatus, bg.dtRunningEmp.Rows[i]["EmpId"].ToString());

                    double? getBonus = CalculateBonus(BasicOrPresintSalary,Convert.ToDouble(bg.dtRunningEmp.Rows[i]["AttendanceDay"].ToString()), dtBonusMonthInfo, out Percentage);

                   

                    if (getBonus != null)
                    {


                       


                        //15-03-2026
                        //double getBounus = 0;

                        // this commentd block is ignore for RSSHRM

                        //if (bool.Parse(dtBonusMonthInfo.Rows[0]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 360) //for 12 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[0]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[0]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[1]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 330) //for 11 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[1]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[1]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[2]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 300) //for 10 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[2]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[2]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[3]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 270) //for 09 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[3]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[3]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[4]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 240) //for 08 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[4]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[4]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[5]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 210) //for 07 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[5]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[5]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[6]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 180) //for 06 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[6]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[6]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[7]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 150) //for 05 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[7]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[7]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[8]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 120) //for 04 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[8]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[8]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[9]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 90) //for 03 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[9]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[9]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[10]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 60) //for 02 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[10]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[10]["Percentage"].ToString();
                        //}

                        //else if (bool.Parse(dtBonusMonthInfo.Rows[11]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 10) //for 01 Months
                        //{
                        //    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[11]["Percentage"].ToString()) / 100, 0);
                        //    Percentage = dtBonusMonthInfo.Rows[11]["Percentage"].ToString();
                        //}
                        //else
                        //{
                        //    getBounus = 0;      // if getBonus is 0 taka then not counted as get bounus
                        //    Percentage = "0"; // if percentage is 0(%) then not counted as get bonus 
                        //                      //if (bool.Parse(ViewState["__IsGerments__"].ToString())) 
                        //                      //{
                        //    getBounus = Math.Round(Math.Round(double.Parse(BasicOrPresintSalary)) / 182.5 * int.Parse(dt.Rows[0]["TotalDays"].ToString()));
                        //    if (getBounus > 0)
                        //        Percentage = dt.Rows[0]["TotalDays"].ToString();
                        //    //Percentage = ( getBounus / Math.Round(double.Parse(BasicOrPresintSalary))*100).ToString();
                        //    //}
                        //}


                        // this below part is use to RSS                        
                        //getBounus = 0;      // if getBonus is 0 taka then not counted as get bounus  //15-03-2026
                        //Percentage = "0"; // if percentage is 0(%) then not counted as get bonus  ////15-03-2026

                        //if (bg.dtRunningEmp.Rows[i]["EmpTypeId"].ToString() == "1")
                        //{
                        //    BasicOrPresintSalary = ((double.Parse(bg.dtRunningEmp.Rows[i]["EmpPresentSalary"].ToString()) - 1100)/1.4).ToString(); 
                        //}
                        //else
                        //{
                        //    BasicOrPresintSalary = (double.Parse(bg.dtRunningEmp.Rows[i]["EmpPresentSalary"].ToString()) *.6).ToString();
                        //}


                        //15-03-2026
                        /*if (int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 182)
                            {
                                getBounus = Math.Round(double.Parse(BasicOrPresintSalary));
                                Percentage = "100";
                            }
                            else
                            {
                            getBounus = Math.Round(Math.Round(double.Parse(BasicOrPresintSalary)) / 182 * int.Parse(dt.Rows[0]["TotalDays"].ToString()));
                            Percentage = (( getBounus / double.Parse(BasicOrPresintSalary)) * 100).ToString();
                              //  Percentage = dt.Rows[0]["TotalDays"].ToString();
                            }

                        //---------------------------------------


                        if (ckbIsBonusPer.Checked && getBounus > 0)
                        {
                            getBounus= Math.Round(getBounus * (double.Parse(txtPerOfBonus.Text.Trim())/100));
                        }
                        */


                        if (getBonus != null)
                        {

                            AddBonusRow(dtBonus, ddlCompanyList.SelectedValue, bg.dtRunningEmp.Rows[i]["SftId"].ToString(), getBonusInfo[0], bg.dtRunningEmp.Rows[i]["EmpId"].ToString(), bg.dtRunningEmp.Rows[i]["EmpCardNo"].ToString(), bg.dtRunningEmp.Rows[i]["EmpTypeId"].ToString(), bg.dtRunningEmp.Rows[i]["EmpPresentSalary"].ToString(), bg.dtRunningEmp.Rows[i]["BasicSalary"].ToString(), Percentage, getBonus.Value, bg.dtRunningEmp.Rows[i]["DptId"].ToString(), bg.dtRunningEmp.Rows[i]["DsgId"].ToString(), DateTime.Now.ToString("yyyy-MM-dd"), dtBonusMonthInfo.Rows[0]["BonusType"].ToString(), Session["__GetUserID__"].ToString(), dtBonusMonthInfo.Rows[0]["GenerateOn"].ToString(), bg.dtRunningEmp.Rows[i]["AttendanceDay"].ToString());



                            //DataRow row = dtBonus.NewRow();

                            //row["SN"] = bg.dtRunningEmp.Rows[i]["SN"].ToString();
                            //row["EmpCardNo"] = bg.dtRunningEmp.Rows[i]["EmpCardNo"].ToString();
                            //row["BasicSalary"] = bg.dtRunningEmp.Rows[i]["BasicSalary"].ToString();
                            //row["BonusAmount"] = getBonus;
                            //row["Percentage"] = Percentage;
                            //row["EmpPresentSalary"] = bg.dtRunningEmp.Rows[i]["EmpPresentSalary"].ToString();
                            //row["GenerateOn"] = dtBonusMonthInfo.Rows[0]["GenerateOn"].ToString();
                            //row["TotalDays"] = dt.Rows[0]["TotalDays"].ToString();
                            //row["BId"] = getBonusInfo[0];
                            //row["CompanyId"] = ddlCompanyList.SelectedValue;

                            //dtBonus.Rows.Add(row);
                        }

                        //saveBonusInfo(bg.dtRunningEmp.Rows[i]["SN"].ToString(), bg.dtRunningEmp.Rows[i]["EmpCardNo"].ToString(), bg.dtRunningEmp.Rows[i]["BasicSalary"].ToString(), getBonus, Percentage, bg.dtRunningEmp.Rows[i]["EmpPresentSalary"].ToString(), dtBonusMonthInfo.Rows[0]["GenerateOn"].ToString(), dt.Rows[0]["TotalDays"].ToString(), getBonusInfo[0], ddlCompanyList.SelectedValue, bg);
                        //lbProcessingStatus.Items.Add("Processing completed of  " + dtRunningEmp.Rows[i]["EmpType"].ToString() + "  " +dtRunningEmp.Rows[i]["EmpName"].ToString()+"  Card No. " + dtRunningEmp.Rows[i]["EmpCardNo"].ToString() + "");
                        Session["OPERATION_PROGRESS"] = getValue;
                        //Thread.Sleep(1000);



                    }
                }
                //  System.Threading.Thread.Sleep(50);
                //  ProgressBar1.Value = 0;

                BulkInsertBonus(dtBonus);
                if (bg.isGenerated)
                {

                    //lblMessage.InnerText = "success-> Successfully Bonus Generated.";
                }

            }
            catch(Exception ex) { }
        
        }

        bool isGenerated;
        private static void saveBonusInfo(string setSN, string setEmpCardNo, string setBasicSalary, double? setBonus, string Percentage, string PresentSalary, string generateOn, string TotalDays,string BId,string smonth,bonus_generation bg)
        { 
            try
            {
                DataTable dtCertainEmp = new DataTable();
                sqlDB.fillDataTable("select EmpId,EmpTypeId,DptId,DsgId,SftId,CompanyId from v_Personnel_EmpCurrentStatus where SN ="+setSN+"",dtCertainEmp);
                try
                {
                    string[] getColumns = {"CompanyId","SftId","BID", "EmpId", "EmpCardNo", "EmpTypeId", "PresentSalary", "BasicSalary", "Percentage", "BonusAmount","DptId", "DsgId", "GenerateDate", "BonusType", "UserId", "GenerateOn", "TotalDays" };
                    string[] getValues = {dtCertainEmp.Rows[0]["CompanyId"].ToString(),dtCertainEmp.Rows[0]["SftId"].ToString(), BId,dtCertainEmp.Rows[0]["EmpId"].ToString(), setEmpCardNo, dtCertainEmp.Rows[0]["EmpTypeId"].ToString(),PresentSalary,
                                         setBasicSalary.ToString(),Percentage,setBonus.ToString(),dtCertainEmp.Rows[0]["DptId"].ToString(),dtCertainEmp.Rows[0]["DsgId"].ToString(),  
                                         DateTime.Now.ToString("yyyy-MM-dd"),smonth,
                                          bg.ViewState["__UserId__"] .ToString(),generateOn,TotalDays};
                    if (SQLOperation.forSaveValue("Payroll_YearlyBonusSheet", getColumns, getValues, sqlDB.connection) == true) bg.isGenerated = true;
                    
                }
                catch (Exception ex)
                {
                   // MessageBox.Show(ex.Message);
                }

            }
            catch { }
        
        }
        private static void ClearYearlyBonusSheetByBonusType(string smonth)
        {
            try
            {
                SQLOperation.forDeleteRecordByIdentifier("Payroll_YearlyBonusSheet", "BId", smonth, sqlDB.connection);
            }
            catch { }        
        }
        DataTable dtGetMonthSetup;
        private void loadMonthSetup(int days, int month, int year)
        {
            try
            {
                string monthName = new DateTime(year, month, days).ToString("MMM", CultureInfo.InvariantCulture);
                monthName += year.ToString().Substring(2, 2);
                SQLOperation.selectBySetCommandInDatatable("select TotalDays,TotalWeekend ,FromDate,ToDate,TotalHoliday,TotalWorkingDays from tblMonthSetup where MonthName='" + monthName + "'", dtGetMonthSetup = new DataTable(), sqlDB.connection);
            }
            catch (Exception ex)
            {

            }
        }

        protected void ddlCompanyList_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                loadMonthInf();
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "ProcessingHide();", true);
            }
            catch { }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static object Operation(string smonth,string scompanyid)
        {
            HttpSessionState session = HttpContext.Current.Session;

            //Separate thread for long running operation
            
            ThreadPool.QueueUserWorkItem(delegate
            {


                try
                {
                    bonus_generation bg = new bonus_generation();
                    string[] getBonusInfo = smonth.Split('-');
                    bg.ViewState["__UserId__"] = session["__GetUserID__"].ToString();
                    // here getBonusInfo[0]=BId
                    // and  getBonusInfo[1]=RId



                    DataTable dtBonusMonthInfo = new DataTable();
                    DataTable dtGetCalculationDate = new DataTable();

                    string CompanyId = scompanyid;
                    sqlDB.fillDataTable("select SlabType,Chosen,Percentage,BonusType,GenerateOn,EquivalentDays,BasedOnAttStatus from Payroll_BonusMonthSetup where BId ='" + getBonusInfo[0] + "'", dtBonusMonthInfo);  // get bonusn month info start 12 months then 11 months then 10 mpnths as sequqntioaly 
                    string [] GetBId = smonth.Split('-');
                    sqlDB.fillDataTable("select convert(varchar(11),CalculationDate,111) as CalculationDate from v_Payroll_BonusSetup_DistinctRecord where BId ='" +GetBId[0]+ "' ", dtGetCalculationDate);

                    if (getBonusInfo[1] != "0" && getBonusInfo[1]=="1")
                        sqlDB.fillDataTable("select distinct EmpId,EmpCardNo,EmpName, max(SN) as SN,EmpType,EmpTypeId,EmpStatus,ActiveSalary,Convert(varchar(11)," +
                            "EmpJoiningDate,111) as EmpJoiningDate,BasicSalary,EmpPresentSalary,IsActive,CompanyId,RId  from v_Personnel_EmpCurrentStatus" +
                            " group by EmpId,EmpCardNo,EmpName,SalaryType,EmpTypeId,EmpType,EmpStatus,ActiveSalary,EmpJoiningDate,BasicSalary,EmpPresentSalary,IsActive,CompanyId,RId" +
                            " having EmpStatus in('1','8')  AND ActiveSalary='true' AND IsActive='1' AND CompanyId='" + CompanyId + "' order by SN", bg.dtRunningEmp = new DataTable());
                    else
                        sqlDB.fillDataTable("select distinct EmpId,EmpCardNo,EmpName, max(SN) as SN,EmpType,EmpTypeId,EmpStatus,ActiveSalary,Convert(varchar(11)," +
                        "EmpJoiningDate,111) as EmpJoiningDate,BasicSalary,EmpPresentSalary,IsActive,CompanyId,RId  from v_Personnel_EmpCurrentStatus" +
                        " group by EmpId,EmpCardNo,EmpName,SalaryType,EmpTypeId,EmpType,EmpStatus,ActiveSalary,EmpJoiningDate,BasicSalary,EmpPresentSalary,IsActive,CompanyId,RId" +
                        " having EmpStatus in('1','8')  AND ActiveSalary='true' AND IsActive='1' AND RId='"+getBonusInfo[1]+"' CompanyId='" + CompanyId + "' order by SN", bg.dtRunningEmp = new DataTable());

                    if (bg.dtRunningEmp.Rows.Count < 1)
                    {

                        
                        return;
                    }
                    ClearYearlyBonusSheetByBonusType(getBonusInfo[0]);
                    DataTable dt = new DataTable();
                    DataTable dtWorkerAttInfo = new DataTable();
                    for (int i = 0; i < bg.dtRunningEmp.Rows.Count; i++)
                    {

                        int getValue = 0;
                        if (i != 0) getValue = (100 * i / (bg.dtRunningEmp.Rows.Count-1));
                        //probar.Style.Add("width", getValue.ToString()+"%");


                        //probar.InnerHtml = getValue.ToString() + "%";   

                        System.Threading.Thread.Sleep(500);

                        string Percentage = "";

                        string BasicOrPresintSalary = "";
                        if (dtBonusMonthInfo.Rows[0]["GenerateOn"].ToString() == "Basic Salary") BasicOrPresintSalary = bg.dtRunningEmp.Rows[i]["BasicSalary"].ToString();
                        else BasicOrPresintSalary = bg.dtRunningEmp.Rows[i]["EmpPresentSalary"].ToString();


                        DataRow[] dr = bg.dtRunningEmp.Select("EmpCardNo='00003017'", "");

                        if (bg.dtRunningEmp.Rows[i]["EmpCardNo"].ToString() == "00003017")
                        {

                        }

                        sqlDB.fillDataTable("select DateDiff (day,'" + bg.dtRunningEmp.Rows[i]["EmpJoiningDate"].ToString() + "','" + dtGetCalculationDate.Rows[0]["CalculationDate"].ToString() + "') as TotalDays", dt);
                       
                        
                     
                        if (dt.Rows.Count > 0)
                        {
                            double getBounus = 0;
                         
                                if (bool.Parse(dtBonusMonthInfo.Rows[0]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 360) //for 12 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[0]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[0]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[1]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 330) //for 11 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[1]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[1]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[2]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 300) //for 10 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[2]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[2]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[3]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 270) //for 09 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[3]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[3]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[4]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 240) //for 08 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[4]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[4]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[5]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 210) //for 07 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[5]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[5]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[6]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 180) //for 06 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[6]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[6]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[7]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 150) //for 05 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[7]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[7]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[8]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 120) //for 04 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[8]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[8]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[9]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 90) //for 03 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[9]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[9]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[10]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 60) //for 02 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[10]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[10]["Percentage"].ToString();
                                }

                                else if (bool.Parse(dtBonusMonthInfo.Rows[11]["Chosen"].ToString()) == true && int.Parse(dt.Rows[0]["TotalDays"].ToString()) >= 10) //for 01 Months
                                {
                                    getBounus = Math.Round(double.Parse(BasicOrPresintSalary) * double.Parse(dtBonusMonthInfo.Rows[11]["Percentage"].ToString()) / 100, 0);
                                    Percentage = dtBonusMonthInfo.Rows[11]["Percentage"].ToString();
                                }
                                else
                                {
                                    getBounus = 0;      // if getBonus is 0 taka then not counted as get bounus
                                    Percentage = "0";  // if percentage is 0(%) then not counted as get bonus 
                                }
                            
                           
                            // if (getBounus > 0)
                            saveBonusInfo(bg.dtRunningEmp.Rows[i]["SN"].ToString(), bg.dtRunningEmp.Rows[i]["EmpCardNo"].ToString(), bg.dtRunningEmp.Rows[i]["BasicSalary"].ToString(), getBounus, Percentage, bg.dtRunningEmp.Rows[i]["EmpPresentSalary"].ToString(), dtBonusMonthInfo.Rows[0]["GenerateOn"].ToString(), dt.Rows[0]["TotalDays"].ToString(), getBonusInfo[0], scompanyid, bg);
                            //lbProcessingStatus.Items.Add("Processing completed of  " + dtRunningEmp.Rows[i]["EmpType"].ToString() + "  " +dtRunningEmp.Rows[i]["EmpName"].ToString()+"  Card No. " + dtRunningEmp.Rows[i]["EmpCardNo"].ToString() + "");
                            session["OPERATION_PROGRESS"] = getValue;
                            Thread.Sleep(1000);


                        }
                    }
                    //  System.Threading.Thread.Sleep(50);
                    //  ProgressBar1.Value = 0;
                    if (bg.isGenerated)
                    {
                        

                    }
                   
                }
                catch { }

                
            });

            return new { progress = 0 };
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static object OperationProgress()
        {
            int operationProgress = 0;

            if (HttpContext.Current.Session["OPERATION_PROGRESS"] != null)
                operationProgress = (int)HttpContext.Current.Session["OPERATION_PROGRESS"];

            return new { progress = operationProgress };
        }

        protected void gvSalaryList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {


                if (e.CommandName == "Remove")
                {
                    int rIndex = Convert.ToInt32(e.CommandArgument.ToString());
                    string Bid = gvSalaryList.DataKeys[rIndex].Values[0].ToString();
                    if (deleteExSalary(Bid))
                    {
                        lblMessage.InnerText = "warning-> Successfully Deleted.";
                        gvSalaryList.Rows[rIndex].Visible = false;
                    }

                }
            }
            catch { }
        }
        private bool deleteExSalary(string Bid)
        {
            try
            {
               string  sqlCmd = "delete Payroll_YearlyBonusSheet where BId="+Bid+"  and CompanyId='" + ddlCompanyList.SelectedValue + "'";
                return CRUD.Execute(sqlCmd, sqlDB.connection);

            }
            catch (Exception ex) { lblMessage.InnerText = "error-> " + ex.Message; return false; }

        }

        protected void gvSalaryList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (ViewState["__DeletAction__"].ToString().Equals("0"))
                {
                    Button btnRemove = (Button)e.Row.FindControl("btnRemove");
                    btnRemove.Enabled = false;
                    btnRemove.OnClientClick = "return false";
                    btnRemove.ForeColor = Color.Silver;
                }

            }
            catch { }
        }

        private void checkInitialPermission()
        {
            if (ViewState["__WriteAction__"].ToString().Equals("0"))
            {
                btnGeneration.Enabled = false;
                btnGeneration.CssClass = "";

            }
            else
            {
                btnGeneration.Enabled = true;
                btnGeneration.CssClass = "Pbutton";
            }
    
        }


        public double? CalculateBonus(string basicSalary, double attendanceDays, DataTable dtBonusMonthInfo, out string percentage)
        {
            try
            {
                double getBonus = 0;
                percentage = "0";


                for (int i = 0; i < dtBonusMonthInfo.Rows.Count; i++)
                {
                    bool chosen = bool.Parse(dtBonusMonthInfo.Rows[i]["Chosen"].ToString());

                    if (chosen && attendanceDays >= Convert.ToDouble(dtBonusMonthInfo.Rows[i]["EquivalentDays"]))
                    {
                        double perc = double.Parse(dtBonusMonthInfo.Rows[i]["Percentage"].ToString());
                        getBonus = Math.Round(Convert.ToDouble(basicSalary) * perc / 100, 0);
                        percentage = perc.ToString();
                        break;
                    }
                }

                return getBonus;
            }
            catch (Exception ex)
            {
                percentage = null;
                return null;
               
            }
           

        }

        private static double getAttendanceDay(string empJoiningDate,string basedOnAttStatus,string empId)
        {
            string attStatus = "";
            if(!String.IsNullOrEmpty(attStatus))
            {
                List<string> statusList = JsonConvert.DeserializeObject<List<string>>(basedOnAttStatus);

                 attStatus = $"and at.ATTStatus in({ string.Join(",", statusList.Select(s => $"'{s}'"))})" ;
                 
            }
           
            string joingingDate = commonTask.ConvertTo_yyyyMMdd(empJoiningDate);
            string query = $"select count(at.ATTStatus) as AttendanceDay from Personnel_EmployeeInfo ei inner join  Personnel_EmpCurrentStatus cs on ei .EmpId=cs.EmpId and cs.IsActive=1 inner join tblAttendanceRecord at on cs.EmpId=at.EmpId where at.ATTDate>='{joingingDate}'  and at.EmpId='{empId}'";
            DataTable dt = new DataTable();
            dt = CRUD.ExecuteReturnDataTable(query);

            return dt.Rows.Count > 0 && dt.Rows[0]["AttendanceDay"] != DBNull.Value ? Convert.ToDouble(dt.Rows[0]["AttendanceDay"]): 0;
        }


        private DataTable CreateBonusDataTable()
        {
            DataTable dtBonus = new DataTable();

            dtBonus.Columns.Add("CompanyId");
            dtBonus.Columns.Add("SftId");
            dtBonus.Columns.Add("BID");
            dtBonus.Columns.Add("EmpId");
            dtBonus.Columns.Add("EmpCardNo");
            dtBonus.Columns.Add("EmpTypeId");
            dtBonus.Columns.Add("PresentSalary");
            dtBonus.Columns.Add("BasicSalary");
            dtBonus.Columns.Add("Percentage");
            dtBonus.Columns.Add("BonusAmount");
            dtBonus.Columns.Add("DptId");
            dtBonus.Columns.Add("DsgId");
            dtBonus.Columns.Add("GenerateDate");
            dtBonus.Columns.Add("BonusType");
            dtBonus.Columns.Add("UserId");
            dtBonus.Columns.Add("GenerateOn");
            dtBonus.Columns.Add("TotalDays");

            return dtBonus;
        }

        private void AddBonusRow(DataTable dtBonus,string companyId,string sftId,string bId,string empId,string empCardNo,string empTypeId,
    string presentSalary,string basicSalary,string percentage,double bonusAmount,string dptId,string dsgId,string generateDate,
    string bonusType,string userId,string generateOn,string totalDays)
        {
            DataRow row = dtBonus.NewRow();

            row["CompanyId"] = companyId;
            row["SftId"] = sftId;
            row["BID"] = bId;
            row["EmpId"] = empId;
            row["EmpCardNo"] = empCardNo;
            row["EmpTypeId"] = empTypeId;
            row["PresentSalary"] = presentSalary;
            row["BasicSalary"] = basicSalary;
            row["Percentage"] = percentage;
            row["BonusAmount"] = bonusAmount;
            row["DptId"] = dptId;
            row["DsgId"] = dsgId;
            row["GenerateDate"] = generateDate;
            row["BonusType"] = bonusType;
            row["UserId"] = userId;
            row["GenerateOn"] = generateOn;
            row["TotalDays"] = totalDays;

            dtBonus.Rows.Add(row);
        }



        private void BulkInsertBonus(DataTable dtBonus)
        {
            string connStr = ConfigurationManager.ConnectionStrings["local2"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(con))
                {
                    bulkCopy.DestinationTableName = "Payroll_YearlyBonusSheet";

                    // Performance optimization
                    bulkCopy.BatchSize = 5000;
                    bulkCopy.BulkCopyTimeout = 0;
                    //CompanyId","SftId","BID", "EmpId", "EmpCardNo", "EmpTypeId", "PresentSalary", "BasicSalary", "Percentage", "BonusAmount","DptId", "DsgId", "GenerateDate", "BonusType", "UserId", "GenerateOn", "TotalDays
                    // Column mapping (DataTable -> SQL Table)
                    bulkCopy.ColumnMappings.Add("CompanyId", "CompanyId");
                    bulkCopy.ColumnMappings.Add("SftId", "SftId");
                    bulkCopy.ColumnMappings.Add("BId", "BId");
                    bulkCopy.ColumnMappings.Add("EmpId", "EmpId");
                    bulkCopy.ColumnMappings.Add("EmpCardNo", "EmpCardNo");
                    bulkCopy.ColumnMappings.Add("EmpTypeId", "EmpTypeId");
                    bulkCopy.ColumnMappings.Add("PresentSalary", "PresentSalary");
                    bulkCopy.ColumnMappings.Add("BasicSalary", "BasicSalary");
                    bulkCopy.ColumnMappings.Add("Percentage", "Percentage");
                    bulkCopy.ColumnMappings.Add("BonusAmount", "BonusAmount");
                    bulkCopy.ColumnMappings.Add("DptId", "DptId");
                    bulkCopy.ColumnMappings.Add("DsgId", "DsgId");
                    bulkCopy.ColumnMappings.Add("GenerateDate", "GenerateDate");
                    bulkCopy.ColumnMappings.Add("BonusType", "BonusType");
                    bulkCopy.ColumnMappings.Add("UserId", "UserId");
                    bulkCopy.ColumnMappings.Add("GenerateOn", "GenerateOn");
                    bulkCopy.ColumnMappings.Add("TotalDays", "TotalDays");

                    // Insert Data
                    bulkCopy.WriteToServer(dtBonus);
                }
            }
        }
    }
} 