using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.personnel
{
    public partial class increment_sheet_v2 : System.Web.UI.Page
    {
        string CompanyId = "";
        DataTable dt;
        DataTable dtSetPrivilege;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            if (!IsPostBack)
            {
                setPrivilege();
                classes.commonTask.LoadEmpType(rbEmpList);
                //classes.commonTask.LoadMonthName(ddlMonthName);
                if (!classes.commonTask.HasBranch())
                    ddlCompany.Enabled = false;
                ddlCompany.SelectedValue = ViewState["__CompanyId__"].ToString();
            }
            lblMessage.InnerText = "";
        }

        private void setPrivilege()
        {
            try
            {
                HttpCookie getCookies = Request.Cookies["userInfo"];
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                classes.commonTask.LoadBranch(ddlCompany, ViewState["__CompanyId__"].ToString());
                //------------load privilege setting inof from db------
                string[] AccessPermission = new string[0];
                AccessPermission = checkUserPrivilege.checkUserPrivilegeForReport(ViewState["__CompanyId__"].ToString(), getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "increment_sheet.aspx", ddlCompany, WarningMessage, tblGenerateType, btnpreview, btnPreviewDetails);
                if (AccessPermission[0] == "0")
                {
                    bntExcel.Enabled = false;
                    bntExcel.CssClass = "";
                }
                ViewState["__ReadAction__"] = AccessPermission[0];

                classes.commonTask.LoadMonthForIncreament(ddlMonthName, ViewState["__CompanyId__"].ToString());
                //classes.Employee.LoadEmpCardIncPro(ddlCardNo, "i", ViewState["__CompanyId__"].ToString());
                classes.Employee.LoadEmpCardNoForRefarencedEmp(ddlCardNo, ViewState["__CompanyId__"].ToString());
                //-----------------------------------------------------


            }
            catch { }

        }
        private void LoadDepartment(string divisionId, ListBox lst)
        {
            try
            {
                dt = new DataTable();

                sqlDB.fillDataTable("SELECT DptId, DptName FROM HRD_Department where DId=" + divisionId + "", dt);

                lst.DataValueField = "DptId";
                lst.DataTextField = "DptName";
                lst.DataSource = dt;
                lst.DataBind();
            }
            catch { }
        }
        private void AddRemoveItem(ListBox aSource, ListBox aTarget)
        {

            ListItemCollection licCollection;

            try
            {

                licCollection = new ListItemCollection();
                for (int intCount = 0; intCount < aSource.Items.Count; intCount++)
                {
                    if (aSource.Items[intCount].Selected == true)
                        licCollection.Add(aSource.Items[intCount]);
                }

                for (int intCount = 0; intCount < licCollection.Count; intCount++)
                {
                    aSource.Items.Remove(licCollection[intCount]);
                    aTarget.Items.Add(licCollection[intCount]);
                }

            }
            catch (Exception expException)
            {
                Response.Write(expException.Message);
            }
            finally
            {
                licCollection = null;
            }

        }

        private void AddRemoveAll(ListBox aSource, ListBox aTarget)
        {

            try
            {

                foreach (ListItem item in aSource.Items)
                {
                    aTarget.Items.Add(item);
                }
                aSource.Items.Clear();

            }
            catch (Exception expException)
            {
                Response.Write(expException.Message);
            }

        }

        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            AddRemoveItem(lstAll, lstSelected);
        }

        protected void btnAddAllItem_Click(object sender, EventArgs e)
        {
            AddRemoveAll(lstAll, lstSelected);
        }

        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            AddRemoveItem(lstSelected, lstAll);
        }

        protected void btnRemoveAllItem_Click(object sender, EventArgs e)
        {
            AddRemoveAll(lstSelected, lstAll);
        }

        protected void btnpreview_Click(object sender, EventArgs e)
        {

            try
            {
                CompanyId = (ddlCompany.SelectedValue == "0000") ? ViewState["__CompanyId__"].ToString() : ddlCompany.SelectedValue;
                //  HttpCookie getCookies = Request.Cookies["userInfo"];
                //if (ComplexLetters.getEntangledLetters(getCookies["__getUserType__"].ToString()).Equals("Super Admin") || ComplexLetters.getEntangledLetters(getCookies["__getUserType__"].ToString()).Equals("Master Admin"))
                //{
                //    CompanyID = ddlCompany.SelectedValue;
                //}
                //else
                //{
                //    CompanyID = ViewState["__CompanyId__"].ToString();
                //}
                if (rbEmpList.SelectedValue == "00")
                {
                    DataTable dtRunning = new DataTable();
                    if (ddlCardNo.SelectedValue == "0")
                    {
                        sqlDB.fillDataTable("Select EmpName,GrdName,DsgName,DptName,SftName,SubString(EmpCardNo,8,15) as EmpCardNo,FORMAT(EmpJoiningDate,'dd-MM-yyyy') as EmpJoiningDate,PreEmpSalary,PreIncrementAmount,Format(Convert(datetime,'01-'+EffectiveMonth,105),'MMM-yyyy') as EffectiveMonth,IncrementAmount,EmpPresentSalary,CompanyName,Remarks,Address,OrderRefNo From v_Promotion_Increment  where TypeOfChange='i' and CompanyId='" + CompanyId + "' order by SN", dtRunning);
                    }
                    else
                    {
                        sqlDB.fillDataTable("Select EmpName,GrdName,DsgName,DptName,SftName,SubString(EmpCardNo,8,15) as EmpCardNo,FORMAT(EmpJoiningDate,'dd-MM-yyyy') as EmpJoiningDate,PreEmpSalary,PreIncrementAmount,Format(Convert(datetime,'01-'+EffectiveMonth,105),'MMM-yyyy') as EffectiveMonth,IncrementAmount,EmpPresentSalary,CompanyName,Remarks,Address,OrderRefNo From v_Promotion_Increment  where TypeOfChange='i' and CompanyId='" + CompanyId + "' and EmpId='" + ddlCardNo.SelectedValue + "' order by SN", dtRunning);
                    }
                    Session["__IndivisualIncrementSheet__"] = dtRunning;
                    if (dtRunning.Rows.Count > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=IndivisualIncrementSheet');", true);  //Open New Tab for Sever side code
                    }
                    else
                    {
                        lblMessage.InnerText = "warning->No data Available";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                    }
                }
                else
                {
                    DataTable dtRunning = new DataTable();
                    if (rbEmpList.SelectedValue == "0")
                    {
                        sqlDB.fillDataTable("Select EmpName,GrdName,DsgName,DptName,SftName,SubString(EmpCardNo,8,15) as EmpCardNo,FORMAT(EmpJoiningDate,'dd-MM-yyyy') as EmpJoiningDate,PreEmpSalary,PreIncrementAmount,EffectiveMonth,IncrementAmount,EmpPresentSalary,CompanyName,Remarks,Address From v_Promotion_Increment  where TypeOfChange='i' and EffectiveMonth='" + ddlMonthName.SelectedValue + "' and CompanyId='" + CompanyId + "' order by SN", dtRunning);
                    }
                    else
                    {
                        sqlDB.fillDataTable("Select EmpName,GrdName,DsgName,DptName,SftName,SubString(EmpCardNo,8,15) as EmpCardNo,FORMAT(EmpJoiningDate,'dd-MM-yyyy') as EmpJoiningDate,PreEmpSalary,PreIncrementAmount,EffectiveMonth,IncrementAmount,EmpPresentSalary,CompanyName,Remarks,Address From v_Promotion_Increment  where TypeOfChange='i' and EffectiveMonth='" + ddlMonthName.SelectedValue + "' and EmpTypeId=" + rbEmpList.SelectedValue + " and CompanyId='" + CompanyId + "' order by SN", dtRunning);
                    }
                    Session["__IncrementSheet__"] = dtRunning;
                    if (dtRunning.Rows.Count > 0)
                    {
                        string MonthName = "";
                        string[] getmonth = ddlMonthName.SelectedItem.Text.Split('-');
                        MonthName = getmonth[0].ToUpper() + " " + getmonth[1];
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=IncrementSheet-" + MonthName + "');", true);  //Open New Tab for Sever side code
                    }
                    else
                    {
                        lblMessage.InnerText = "warning->No data Available";
                    }
                }
            }
            catch { }
        }

        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);

            CompanyId = (ddlCompany.SelectedValue == "0000") ? ViewState["__CompanyId__"].ToString() : ddlCompany.SelectedValue;
            classes.commonTask.LoadMonthForIncreament(ddlMonthName, CompanyId);
            classes.Employee.LoadEmpCardNoForRefarencedEmp(ddlCardNo, CompanyId);
        }

        protected void btnPreviewDetails_Click(object sender, EventArgs e)
        {
            try
            {
                CompanyId = (ddlCompany.SelectedValue == "0000") ? ViewState["__CompanyId__"].ToString() : ddlCompany.SelectedValue;
                //  HttpCookie getCookies = Request.Cookies["userInfo"];
                //if (ComplexLetters.getEntangledLetters(getCookies["__getUserType__"].ToString()).Equals("Super Admin") || ComplexLetters.getEntangledLetters(getCookies["__getUserType__"].ToString()).Equals("Master Admin"))
                //{
                //    CompanyID = ddlCompany.SelectedValue;
                //}
                //else
                //{
                //    CompanyID = ViewState["__CompanyId__"].ToString();
                //}  
                if (rbEmpList.SelectedValue == "00")
                {
                    DataTable dtRunning = new DataTable();
                    if (ddlCardNo.SelectedValue != "0")
                    {
                        sqlDB.fillDataTable("Select EmpName,GrdName,DsgName,DptName,SftName,SubString(EmpCardNo,8,15) as EmpCardNo,FORMAT(EmpJoiningDate,'dd-MM-yyyy') as EmpJoiningDate,PreEmpSalary,PreIncrementAmount,Format(Convert(datetime,'01-'+EffectiveMonth,105),'MMM-yyyy') as EffectiveMonth,IncrementAmount,EmpPresentSalary,CompanyName,Remarks,Address,PreBasicSalary,BasicSalary,PreOthersAllownce,OthersAllownce,PreMedicalAllownce,MedicalAllownce,PreFoodAllownce,FoodAllownce,PreHouseRent,HouseRent,OrderRefNo From v_Promotion_Increment  where TypeOfChange='i' and EmpId='" + ddlCardNo.SelectedValue + "' and CompanyId='" + CompanyId + "' order by SN", dtRunning);
                    }
                    else
                    {
                        sqlDB.fillDataTable("Select EmpName,GrdName,DsgName,DptName,SftName,SubString(EmpCardNo,8,15) as EmpCardNo,FORMAT(EmpJoiningDate,'dd-MM-yyyy') as EmpJoiningDate,PreEmpSalary,PreIncrementAmount,Format(Convert(datetime,'01-'+EffectiveMonth,105),'MMM-yyyy') as EffectiveMonth,IncrementAmount,EmpPresentSalary,CompanyName,Remarks,Address,PreBasicSalary,BasicSalary,PreOthersAllownce,OthersAllownce,PreMedicalAllownce,MedicalAllownce,PreFoodAllownce,FoodAllownce,PreHouseRent,HouseRent,OrderRefNo From v_Promotion_Increment  where TypeOfChange='i' and CompanyId='" + CompanyId + "' order by SN", dtRunning);
                    }
                    Session["__IndIncrementSheetDetails__"] = dtRunning;
                    if (dtRunning.Rows.Count > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=IndIncrementSheetDetails');", true);  //Open New Tab for Sever side code
                    }
                    else
                    {
                        lblMessage.InnerText = "warning->No data Available";
                    }
                }
                else
                {
                    DataTable dtRunning = new DataTable();
                    if (rbEmpList.SelectedValue == "0")
                    {
                        sqlDB.fillDataTable("Select EmpName,GrdName,DsgName,DptName,SftName,SubString(EmpCardNo,8,15) as EmpCardNo,FORMAT(EmpJoiningDate,'dd-MM-yyyy') as EmpJoiningDate,PreEmpSalary,PreIncrementAmount,EffectiveMonth,IncrementAmount,EmpPresentSalary,CompanyName,Remarks,Address,PreBasicSalary,BasicSalary,PreOthersAllownce,OthersAllownce,PreMedicalAllownce,MedicalAllownce,PreFoodAllownce,FoodAllownce,PreHouseRent,HouseRent From v_Promotion_Increment  where TypeOfChange='i' and EffectiveMonth='" + ddlMonthName.SelectedValue + "'  and CompanyId='" + CompanyId + "' order by SN", dtRunning);
                    }
                    else
                    {
                        sqlDB.fillDataTable("Select EmpName,GrdName,DsgName,DptName,SftName,SubString(EmpCardNo,8,15) as EmpCardNo,FORMAT(EmpJoiningDate,'dd-MM-yyyy') as EmpJoiningDate,PreEmpSalary,PreIncrementAmount,EffectiveMonth,IncrementAmount,EmpPresentSalary,CompanyName,Remarks,Address,PreBasicSalary,BasicSalary,PreOthersAllownce,OthersAllownce,PreMedicalAllownce,MedicalAllownce,PreFoodAllownce,FoodAllownce,PreHouseRent,HouseRent From v_Promotion_Increment  where TypeOfChange='i' and EffectiveMonth='" + ddlMonthName.SelectedValue + "' and EmpTypeId=" + rbEmpList.SelectedValue + " and CompanyId='" + CompanyId + "' order by SN", dtRunning);
                    }
                    Session["__IncrementSheetDetails__"] = dtRunning;
                    if (dtRunning.Rows.Count > 0)
                    {
                        string MonthName = "";
                        string[] getmonth = ddlMonthName.SelectedItem.Text.Split('-');
                        MonthName = getmonth[0].ToUpper() + " " + getmonth[1];
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindow('/All Report/Report.aspx?for=IncrementSheetDetails-" + MonthName + "');", true);  //Open New Tab for Sever side code
                    }
                    else
                    {
                        lblMessage.InnerText = "warning->No data Available";
                    }
                }



            }
            catch { }
        }

        protected void rbEmpList_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                if (rbEmpList.SelectedValue == "00")
                {
                    trCard.Visible = true;
                    trMonth.Visible = false;
                }
                else
                {
                    trCard.Visible = false;
                    trMonth.Visible = true;
                }
            }
            catch { }
        }

        protected void bntExcel_Click(object sender, EventArgs e)
        {
            if (rbEmpList.SelectedValue != "00" && ddlMonthName.SelectedValue == "0")
            {
                lblMessage.InnerText = "warning->Please select Month";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                return;
            }
            if (rblReportType.SelectedValue == "increment")
                IncrementReport();
            else
                PromotionReport();




        }
        private void PromotionReport()
        {
            try
            {
                DataTable data = new DataTable();
                Session["__eltitleReport__"] = "";

                string incrementDate = "";
                string effectiveMonths = "";
                string condition = "";
                string ordering = "";

                if (rbEmpList.SelectedValue == "00")
                {
                    condition += "cs.EmpId='" + ddlCardNo.SelectedValue + "'";
                    ordering = "SN";
                }
                else
                {
                    string date = ddlMonthName.SelectedValue.ToString();
                    DateTime effecative = DateTime.Parse(date);
                    string effectiveDate = effecative.ToString("yyyy-MM");


                    //incrementDate = ConvertToDate(date, "yyyy-MM-dd");
                    //effectiveMonths = ConvertToDate(date, "MM-yyyy");
                    ordering = "dsg.Ordering,cs.CustomOrdering";
                    if (rbEmpList.SelectedValue != "0")
                    {

                        condition += "cs.EmpTypeId = " + rbEmpList.SelectedValue + " and ";
                    }
                    condition += " FORMAT(cs.UpdatedDate, 'yyyy-MM')='" + effectiveDate + "'";
                }
                condition += " and ( cs.UpdateType in(3,4) )";


                //string query = @"select ROW_NUMBER() OVER (ORDER BY " + ordering + @") AS [SL], UpdateType,cs.PreDsgId, cs.DsgId, SUBSTRING(ei.EmpCardNo,8,6)+' ('+ei.EmpProximityNo+')' as [Emp. Card],ei.EmpName as [Name], convert(varchar(10),ei.EmpJoiningDate,105) as [Joining Date],pDpt.DptName as [Pre. Department],pDsg.DsgName as [Pre. Designation],cs.PreGrdName as [Pre. Grade] 
                // , dpt.DptName as [New Department],dsg.DsgName as [New Designation],cs.GrdName as [New Grade],cs.PreBasicSalary as [Pre. Basic],cs.PreHouseRent as [Pre. House Rent],cs.PreEmpSalary as [Pre. Gross],cs.IncrementAmount as [Increment],cs.BasicSalary as [New Basic],cs.HouseRent as [New House Rent],cs.EmpPresentSalary as [New Gross],FORMAT(cs.PromotionMonth, 'MMMM-yyyy') as [Promotion Month] 
                // From Personnel_EmployeeInfo ei inner join Personnel_EmpCurrentStatus cs on ei.EmpId = cs.EmpId  left join HRD_Department pDpt on cs.PreDptId = pDpt.DptId left join HRD_Designation pDsg on cs.PreDsgId = pDsg.DsgId   left join HRD_Department dpt on cs.DptId = dpt.DptId left join HRD_Designation dsg on cs.DsgId = dsg.DsgId where " + condition + " ORDER BY " + ordering;

                string query = @"select ROW_NUMBER() OVER (ORDER BY  " + ordering + @") AS [SL], UpdateType,cs.PreDsgId, cs.DsgId, SUBSTRING(ei.EmpCardNo,8,6)+' ('+ei.EmpProximityNo+')' as [Emp. Card],ei.EmpName as [Name], convert(varchar(10),ei.EmpJoiningDate,105) as [Joining Date],pDpt.DptName as [Pre. Department],pDsg.DsgName as [Pre. Designation],prevGrade.GrdName as [Pre. Grade] ,FORMAT(cs.UpdatedDate, 'yyyy-MM') as UpdateDate,
                 dpt.DptName as [New Department],dsg.DsgName as [New Designation],newGrade.GrdName as [New Grade],cs.PreBasicSalary as [Pre. Basic],cs.PreHouseRent as [Pre. House Rent],cs.PreEmpSalary as [Pre. Gross],cs.IncrementAmount as [Increment],cs.BasicSalary as [New Basic],cs.HouseRent as [New House Rent],cs.EmpPresentSalary as [New Gross],FORMAT(cs.PromotionMonth, 'MMMM-yyyy') as [Promotion Month] 
                 From Personnel_EmployeeInfo ei inner join Personnel_EmpCurrentStatus cs on ei.EmpId = cs.EmpId  left join HRD_Department pDpt on cs.PreDptId = pDpt.DptId left join HRD_Designation pDsg on cs.PreDsgId = pDsg.DsgId   left join HRD_Department dpt on cs.DptId = dpt.DptId left join HRD_Designation dsg on cs.DsgId = dsg.DsgId Left Join HRDGrade as prevGrade on cs.PreGrdId = prevGrade.GradeID Left join HRDGrade as newGrade on cs.GrdId = newGrade.GradeID where " + condition + " ORDER BY " + ordering;

                data = CRUD.ExecuteReturnDataTable(query);
                if (data.Rows.Count == 0)
                {
                    lblMessage.InnerText = "warning->No data Available";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                    return;
                }
                Session["__eltitleReport__"] = data;

                // string emptype = rbEmpList.SelectedValue == "1" ? "Worker" : "Staff";
                string emptype = rbEmpList.SelectedItem.Text.Trim();
                string companyId = ddlCompany.SelectedValue;
                string month = (rbEmpList.SelectedValue == "00") ? "" : ddlMonthName.SelectedValue.Replace('-', '/');
                string url = $"../payroll/salary/IncrementEntitle_Sheet.aspx?for={emptype}-{companyId}-{month}-{3}";

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", $"goToNewTabandWindow('{url}');", true);
            }
            catch (Exception ex)
            {

            }
        }
        private void IncrementReport()
        {
            try
            {
                DataTable data = new DataTable();
                Session["__eltitleReport__"] = "";

                string incrementDate = "";
                string effectiveMonths = "";
                string condition = "";
                string ordering = "";

                if (rbEmpList.SelectedValue == "00")
                {
                    condition += "ecs.EmpId='" + ddlCardNo.SelectedValue + "'";
                    ordering = "SN";
                }
                else
                {
                    //string date = ddlMonthName.SelectedValue.ToString();
                    //incrementDate = ConvertToDate(date, "yyyy-MM-dd");
                    //effectiveMonths = ConvertToDate(date, "MM-yyyy");

                    string date = ddlMonthName.SelectedValue.ToString();
                    DateTime effecative = DateTime.Parse(date);
                    string effectiveDate = effecative.ToString("yyyy-MM");


                    ordering = "hdgs.Ordering,CustomOrdering";
                    if (rbEmpList.SelectedValue != "0")
                    {

                        condition += "ecs.EmpTypeId = " + rbEmpList.SelectedValue + " and ";
                    }
                    condition += "FORMAT(ecs.UpdatedDate, 'yyyy-MM')='" + effectiveDate + "'";
                }

                if (rblIncrementType.SelectedValue == "0")
                {
                    condition += " and   ecs.UpdateType in(1,2)";
                }
                else if (rblIncrementType.SelectedValue == "2")
                {
                    condition += " and   ecs.UpdateType in(2)";
                }
                else
                {
                    condition += " and   ecs.UpdateType in(1)";
                }

                //string query = "select ecs.UpdateType,case when ecs.UpdateType=1 then 'Common' else 'Special' end as IncrementType, ecs.EmpTypeId, ecs.EmpId,SubString(ecs.EmpCardNo,8,16)+' ('+EmpProximityNo+')' EmpCardNo, ei.EmpId,ei.EmpName,hd.DptId,hd.DptName,ecs.EffectiveMonth,hdgs.DsgName,ei.EmpJoiningDate, ecs.PreEmpSalary,ecs.EmpPresentSalary,ecs.PreIncrementAmount,ecs.IncrementAmount,ecs.PreBasicSalary,ecs.BasicSalary, ecs.PreMedicalAllownce,'" + effectiveMonths + "' as n_EffecctiveMonth,ecs.CommonIncrementMonth,ecs.MedicalAllownce,ecs.PreFoodAllownce, ecs.FoodAllownce, ecs.PreConvenceAllownce, ecs.ConvenceAllownce, ecs.PreHouseRent,ecs.HouseRent, ecs.PreTechnicalAllownce,ecs.TechnicalAllownce, ecs.IncrementMonth,ecs.IsActive from Personnel_EmployeeInfo ei inner join Personnel_EmpCurrentStatus ecs on ei.EmpId=ecs.EmpId inner join HRD_Designation hdgs on ecs.DsgId=hdgs.DsgId inner join HRD_Department hd on ecs.DptId=hd.DptId where " + condition + " ORDER BY " + ordering;
                //string query = @"select ROW_NUMBER() OVER (ORDER BY " + ordering + @") AS [SL],SubString(ecs.EmpCardNo,8,16)+' ('+EmpProximityNo+')' as [Emp. Card], ei.EmpName as [Name],hd.DptName as [Department],hdgs.DsgName as [Designation],convert(varchar(10),ei.EmpJoiningDate,105) as [Joining Date],ecs.PreBasicSalary as [Pre. Basic],ecs.PreHouseRent as [Pre. House Rent],ecs.PreEmpSalary as [Pre. Gross],ecs.UpdateType,case when ecs.UpdateType=1 then 'Common' else 'Special' end as [Increment Type],FORMAT (IncrementMonth,'MMMM-yyyy') as [Increment Month],FORMAT (CommonIncrementMonth,'MMMM-yyyy') as [Increment Month (Common)],ecs.IncrementAmount as [Increment Amount],ecs.BasicSalary as [New Basic],ecs.HouseRent as [New House Rent],ecs.EmpPresentSalary as [New Gross] from Personnel_EmployeeInfo ei inner join Personnel_EmpCurrentStatus ecs on ei.EmpId=ecs.EmpId inner join HRD_Designation hdgs on ecs.DsgId=hdgs.DsgId inner join HRD_Department hd on ecs.DptId=hd.DptId where " + condition + " ORDER BY " + ordering;
                string query = @"select ROW_NUMBER() OVER (ORDER BY "+ordering+ ") AS [SL],SubString(ecs.EmpCardNo,8,16)+' ('+EmpProximityNo+')' as [Emp. Card], ei.EmpName as [Name],hd.DptName as [Department],hdgs.DsgName as [Designation],convert(varchar(10),ei.EmpJoiningDate,105) as [Joining Date],ecs.PreBasicSalary as [Pre. Basic],ecs.PreHouseRent as [Pre. House Rent],ecs.PreEmpSalary as [Pre. Gross],ecs.UpdateType,CASE WHEN ecs.UpdateType = 1 THEN 'Common Inc' WHEN ecs.UpdateType = 2 THEN 'Special Inc' WHEN ecs.UpdateType = 4 THEN 'Inc + Promotion' ELSE 'Other' END AS[Increment Type], FORMAT (UpdatedDate,'MMMM-yyyy') as [Increment Month],FORMAT (CommonIncrementMonth,'MMMM-yyyy') as [Increment Month (Common)],ecs.IncrementAmount as [Increment Amount],ecs.BasicSalary as [New Basic],ecs.HouseRent as [New House Rent],ecs.EmpPresentSalary as [New Gross] from Personnel_EmployeeInfo ei inner join Personnel_EmpCurrentStatus ecs on ei.EmpId=ecs.EmpId inner join HRD_Designation hdgs on ecs.DsgId=hdgs.DsgId inner join HRD_Department hd on ecs.DptId=hd.DptId where " + condition + " ORDER BY " + ordering;

                data = CRUD.ExecuteReturnDataTable(query);
                if (data.Rows.Count == 0)
                {
                    lblMessage.InnerText = "warning->No data Available";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "load();", true);
                    return;
                }
                Session["__eltitleReport__"] = data;

                // string emptype = rbEmpList.SelectedValue == "1" ? "Worker" : "Staff";
                string emptype = rbEmpList.SelectedItem.Text.Trim();
                string companyId = ddlCompany.SelectedValue;
                string month = (rbEmpList.SelectedValue == "00") ? "" : ddlMonthName.SelectedValue.Replace('-', '/');
                string url = $"../payroll/salary/IncrementEntitle_Sheet.aspx?for={emptype}-{companyId}-{month}-{rblIncrementType.SelectedValue.ToString()}";

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", $"goToNewTabandWindow('{url}');", true);
            }
            catch (Exception ex)
            {

            }
        }

        private string ConvertToDate(string date, string format)
        {
            try
            {
                DateTime parsedDate = DateTime.ParseExact(date, "MM-yyyy", CultureInfo.InvariantCulture);
                DateTime lastDayOfMonth = new DateTime(parsedDate.Year, parsedDate.Month, DateTime.DaysInMonth(parsedDate.Year, parsedDate.Month));
                return lastDayOfMonth.ToString(format);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        protected void rblReportType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rblReportType.SelectedValue == "increment")
                trIncrementType.Visible = true;
            else
                trIncrementType.Visible = false;
        }
    }
}