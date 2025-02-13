using adviitRuntimeScripting;
using ComplexScriptingSystem;
using SigmaERP.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaERP.ControlPanel
{
    public partial class authority_access_control : System.Web.UI.Page
    {
        DataTable dt;        
        string CompanyId = "";
        string sqlCmd = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.InnerText = "";
            if (!IsPostBack)
            {
                ViewState["__ReadAction__"] = "0";
                ViewState["__WriteAction__"] = "0";
                ViewState["__UpdateAction__"] = "0";
                ViewState["__DeletAction__"] = "0";
                classes.commonTask.LoadEmpTypeWithAll(rblEmpType);
                createBlankdt();
                if (Request.Url.AbsoluteUri.ToLower().Contains("out-duty-authority"))
                {
                    rblAutoritySetupType.SelectedValue = "OD";
                }
                else
                {
                    rblAutoritySetupType.SelectedValue = "Lv";
                }
                setPrivilege();
            }
        }
        private void setPrivilege()
        {
            try
            {

                HttpCookie getCookies = Request.Cookies["userInfo"];          
                string getUserId = getCookies["__getUserId__"].ToString();
                ViewState["__CompanyId__"] = getCookies["__CompanyId__"].ToString();
                ViewState["__UserType__"] = getCookies["__getUserType__"].ToString();
                //string[] AccessPermission = new string[0];
                classes.commonTask.LoadBranch(ddlCompany, ViewState["__CompanyId__"].ToString());
                //AccessPermission = checkUserPrivilege.checkUserPrivilegeForSettigs(ViewState["__CompanyId__"].ToString(), getUserId, ComplexLetters.getEntangledLetters(ViewState["__UserType__"].ToString()), "authority_access_control.aspx", ddlCompany, gvEmployeeList, btnSubmit);
                //ViewState["__ReadAction__"] = AccessPermission[0];
                //ViewState["__WriteAction__"] = AccessPermission[1];
                //ViewState["__UpdateAction__"] = AccessPermission[2];
                //ViewState["__DeletAction__"] = AccessPermission[3];
                classes.commonTask.LoadDepartment(ViewState["__CompanyId__"].ToString(), lstAll);
                loadAllAuthority();
           //     classes.commonTask.getAuthorityList(ViewState["__CompanyId__"].ToString(),ckblAuthorityList);
                if (!classes.commonTask.HasBranch())
                    ddlCompany.Enabled = false;
                ddlCompany.SelectedValue = ViewState["__CompanyId__"].ToString();
              
            }


            catch { }

        }
        private void loadEmployee()
        {
            try {
                string EmpType = rblEmpType.SelectedValue == "All" ? "" : " and e.EmpTypeId=" + rblEmpType.SelectedValue;
                CompanyId = (ddlCompany.SelectedValue == "0000") ? ViewState["__CompanyId__"].ToString() : ddlCompany.SelectedValue;
                if (rblAutoritySetupType.SelectedValue == "Lv")
                    sqlCmd = @"SELECT 
                        pei.EmpId,
                        SUBSTRING(pei.EmpCardNo, 8, 6) AS EmpCardNo,
                        pei.EmpName,
                        dsg.DsgName,
                        dpt.DptName,
                        pecs.DptId,
                        es.EmpType,
                        CASE 
                            WHEN upa.IsDirectApprove = 1 THEN 'This employee is allowed for direct approval'
                            ELSE STRING_AGG(
                                Auth.EmpName + 
                                CASE 
                                    WHEN upa.AuthorityAction IS NULL THEN '' 
                                    ELSE '(' + CONVERT(VARCHAR, upa.AuthorityPosition) + ') [' + 
                                        CASE 
                                            WHEN upa.AuthorityAction = 0 THEN 'Forward & Approve' 
                                            WHEN upa.AuthorityAction = 1 THEN 'Forward' 
                                            ELSE 'Approve' 
                                        END + ']' 
                                END, ', '
                            ) 
                        END AS Authority
                    FROM 
                        Personnel_EmployeeInfo AS pei
                    INNER JOIN 
                        Personnel_EmpCurrentStatus AS pecs ON pei.EmpId = pecs.EmpId 
                        AND pecs.IsActive = 1
                    INNER JOIN 
                        HRD_EmployeeType AS es ON pei.EmpTypeId = es.EmpTypeId
                    LEFT JOIN 
                        Hrd_Department AS dpt ON pecs.DptId = dpt.DptId
                    LEFT JOIN 
                        HRD_Designation AS dsg ON pecs.DsgId = dsg.DsgId
                    LEFT JOIN 
                        UserApprovalAuthorityPanels AS upa ON pei.EmpId = upa.EmpID 
                        AND pecs.IsActive = 1
                    LEFT JOIN users as u ON upa.AuthorityID = u.UserId
                    left join Personnel_EmployeeInfo as Auth on u.ReferenceID=Auth.EmpID
                    WHERE 
                        pecs.CompanyId = '"+CompanyId+"' AND pecs.EmpStatus IN (1, 8) AND pecs.DptId " + classes.commonTask.getDepartmentList(lstSelected) + " GROUP BY   pei.EmpId, pei.EmpCardNo, pei.EmpName, dsg.DsgName, dpt.DptName, pecs.DptId, es.EmpType, upa.IsDirectApprove ORDER BY  pecs.DptId, pei.EmpCardNo";


                //sqlCmd = @"SELECT 
                //    e.EmpId,
                //    SUBSTRING(e.EmpCardNo, 8, 6) AS EmpCardNo,
                //    e.EmpName,
                //    e.DsgName,
                //    e.DptName,
                //    e.DptId,
                //    CustomOrdering,
                //    CASE 
                //        WHEN a.IsDirectApprove = 1 THEN 'This employee is allowed for direct approval'
                //        ELSE STRING_AGG(
                //            u.EmpName + 
                //            CASE 
                //                WHEN a.AuthorityAction IS NULL THEN '' 
                //                ELSE '(' + CONVERT(VARCHAR, a.AuthorityPosition) + ') [' + 
                //                    CASE 
                //                        WHEN a.AuthorityAction = 0 THEN 'Forward & Approve' 
                //                        WHEN a.AuthorityAction = 1 THEN 'Forward' 
                //                        ELSE 'Approve' 
                //                    END + ']' 
                //            END, ', '
                //        )
                //    END AS Authority,
                //    e.EmpType
                //FROM 
                //    v_EmployeeDetails e
                //LEFT JOIN 
                //    UserApprovalAuthorityPanels a ON e.EmpId = a.EmpID AND e.IsActive = 1
                //LEFT JOIN 
                //    v_UserAccount u ON a.AuthorityID = u.UserId
                //WHERE e.CompanyId = '" + CompanyId + "' AND e.EmpStatus = 1 AND e.DptId " + classes.commonTask.getDepartmentList(lstSelected) + " AND e.IsActive = 1  " + EmpType + "  GROUP BY  e.EmpId, e.EmpCardNo, e.EmpName, e.DsgName, e.DptName, e.DptId, CustomOrdering, a.IsDirectApprove,    e.EmpType ORDER BY e.DptId,  CustomOrdering";

                //sqlCmd = "select e.EmpId,substring(e.EmpCardNo,8,6) as EmpCardNo, e.EmpName,e.DsgName,e.DptName,e.DptId, CustomOrdering,case when a.IsDirectApprove=1 then 'This employee is allowed for direct approval' else  STRING_AGG( u.EmpName + case when a.AuthorityAction is null then '' else  '('+convert(varchar,a.AuthorityPosition)+')'+' ['+case when  a.AuthorityAction=0 then 'Forward & Approve' else case when  a.AuthorityAction=1 then 'Forward' else 'Approve' end end+']' end,', ') end as Authority,e.EmpType from v_EmployeeDetails e left join tblLeaveAuthorityAccessControl a on e.EmpId=a.EmpID and e.IsActive=1 left join v_UserAccount u on a.AuthorityID=u.UserId  where e.CompanyId='" + CompanyId + "' and e.EmpStatus=1 and e.DptId " + classes.commonTask.getDepartmentList(lstSelected) + " and IsActive=1 "+ EmpType + "  group by e.EmpId,e.EmpCardNo, e.EmpName,e.DsgName,e.DptName,e.DptId, CustomOrdering,a.IsDirectApprove,e.EmpType order by e.DptId, CustomOrdering";
                else
                    sqlCmd = "select e.EmpId,substring(e.EmpCardNo,8,6) as EmpCardNo, e.EmpName,e.DsgName,e.DptName,e.DptId, CustomOrdering,case when a.IsDirectApprove=1 then 'This employee is allowed for direct approval' else  STRING_AGG( u.EmpName + case when a.AuthorityAction is null then '' else  '('+convert(varchar,a.AuthorityPosition)+')'+' ['+case when  a.AuthorityAction=0 then 'Forward & Approve' else case when  a.AuthorityAction=1 then 'Forward' else 'Approve' end end+']' end,', ') end as Authority,e.EmpType from v_EmployeeDetails e left join tblOutDutyAuthorityAccessControl a on e.EmpId=a.EmpID and e.IsActive=1 left join v_UserAccount u on a.AuthorityID=u.UserId  where e.CompanyId='" + CompanyId + "' and e.EmpStatus=1 and e.DptId " + classes.commonTask.getDepartmentList(lstSelected) + " and IsActive=1 " + EmpType + " group by e.EmpId,e.EmpCardNo, e.EmpName,e.DsgName,e.DptName,e.DptId, CustomOrdering,a.IsDirectApprove,e.EmpType order by e.DptId, CustomOrdering";
                DataTable dt = new DataTable();
                sqlDB.fillDataTable(sqlCmd, dt);
                gvEmployeeList .DataSource = dt;
                gvEmployeeList.DataBind();               
            }
            catch (Exception ex) { }
        }
        private void loadSelectedAuthority()
        {
            try
            {
                string UserIDList = "0";

                
                CompanyId = (ddlCompany.SelectedValue == "0000") ? ViewState["__CompanyId__"].ToString() : ddlCompany.SelectedValue;
                //sqlCmd = "select UserId,EmpId,EmpCardNo,EmpName,DptName,DsgName,LvAuthorityOrder from v_UserAccount where CompanyId='" + CompanyId + "' and( isLvAuthority=1 or isODAuthority=1) and UserId in(" + UserIDList + ") order by LvAuthorityOrder";

                sqlCmd = @"
                        SELECT 
                        UserId,
                        us.IsGuestUser,
                        ReferenceID,
                        pei.EmpCardNo,
                        pei.EmpName,
						us.FirstName,
						us.LastName,
                        pecs.DptID,
                        pecs.DsgId,
                        dpt.DptName,
                        CASE 
                            WHEN us.IsGuestUser = 1 THEN 'GuestUse'
                            ELSE dsg.dsgName 
                        END AS dsgName,
                        CASE 
                            WHEN us.IsGuestUser = 1 THEN us.FirstName + ' ' + us.LastName
                            ELSE pei.EmpName 
                        END AS EmpName
                    FROM users AS us
                    LEFT JOIN Personnel_EmployeeInfo AS pei ON us.ReferenceID = pei.EmpId
                    LEFT JOIN Personnel_EmpCurrentStatus AS pecs ON us.ReferenceID = pecs.EmpId 
                        AND pecs.IsActive = 1
                    LEFT JOIN Hrd_Department AS dpt ON pecs.DptId = dpt.DptId
                    LEFT JOIN HRD_Designation AS dsg ON pecs.DsgId = dsg.DsgId
                    WHERE us.CompanyId = '"+CompanyId+ "' and UserId in(" + UserIDList + ") AND IsApprovingAuthority = 1 AND (us.Deleted IS NULL OR us.Deleted = 0) ";


                DataTable dt = new DataTable();
                sqlDB.fillDataTable(sqlCmd, dt);
                gvSelectedAuthorityList.DataSource = dt;
                gvSelectedAuthorityList.DataBind();
            }
            catch (Exception ex) { }
        }
        private void createBlankdt()
        {
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("rIndexAll", typeof(int));
                dt.Columns.Add("UserId", typeof(int));
                dt.Columns.Add("EmpCardNo", typeof(string));
                dt.Columns.Add("EmpName", typeof(string));
                dt.Columns.Add("DptName", typeof(string));
                dt.Columns.Add("DsgName", typeof(string));
                dt.Columns.Add("LvAuthorityOrder", typeof(string));
                dt.Columns.Add("LvAuthorityAction", typeof(string));
               
                ViewState["__selectedAuthority__"] = dt;
            } catch (Exception ex) { }
        }
        private void addAuthority(string rIndexAll, string UserId,string EmpCardNo,string EmpName,string DptName,string DsgName, string LvAuthorityOrder,string LvAuthorityAction)
        {
            try
            {
                dt = new DataTable();
                dt = (DataTable)ViewState["__selectedAuthority__"];
                dt.Rows.Add(rIndexAll, UserId,  EmpCardNo,  EmpName, DptName,DsgName,  LvAuthorityOrder,  LvAuthorityAction);
                gvSelectedAuthorityList.DataSource = dt;
                gvSelectedAuthorityList.DataBind();
                ViewState["__selectedAuthority__"] = dt;
            }
            catch (Exception ex) { }
        }
        private void loadAllAuthority()
        {
            try
            {                

                CompanyId = (ddlCompany.SelectedValue == "0000") ? ViewState["__CompanyId__"].ToString() : ddlCompany.SelectedValue;
                sqlCmd = @"SELECT 
                        UserId,
                        us.IsGuestUser,
                        ReferenceID,
                        pei.EmpCardNo,
                        pei.EmpName,
						us.FirstName,
						us.LastName,
                        pecs.DptID,
                        pecs.DsgId,
                        dpt.DptName,
                        CASE 
                            WHEN us.IsGuestUser = 1 THEN 'GuestUse'
                            ELSE dsg.dsgName 
                        END AS dsgName,
                        CASE 
                            WHEN us.IsGuestUser = 1 THEN us.FirstName + ' ' + us.LastName
                            ELSE pei.EmpName 
                        END AS EmpName
                    FROM users AS us
                    LEFT JOIN Personnel_EmployeeInfo AS pei ON us.ReferenceID = pei.EmpId
                    LEFT JOIN Personnel_EmpCurrentStatus AS pecs ON us.ReferenceID = pecs.EmpId 
                        AND pecs.IsActive = 1
                    LEFT JOIN Hrd_Department AS dpt ON pecs.DptId = dpt.DptId
                    LEFT JOIN HRD_Designation AS dsg ON pecs.DsgId = dsg.DsgId
                    WHERE us.CompanyId = '"+CompanyId+"' AND IsApprovingAuthority = 1 AND (us.Deleted IS NULL OR us.Deleted = 0)";

                //sqlCmd = "select UserId,EmpId, substring(EmpCardNo,8,6) as EmpCardNo,EmpName,DptName,DsgName,LvAuthorityOrder from v_UserAccount where CompanyId='" + CompanyId + "' and( isLvAuthority=1)  order by LvAuthorityOrder";


                DataTable dt = new DataTable();
                sqlDB.fillDataTable(sqlCmd, dt);
                gvAllAuthorityList.DataSource = dt;
                gvAllAuthorityList.DataBind();
            }
            catch (Exception ex) { }
        }


        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveItem(lstAll, lstSelected);
            loadEmployee();
        }

        protected void btnAddAllItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveAll(lstAll, lstSelected);
            loadEmployee();
        }

        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            classes.commonTask.AddRemoveItem(lstSelected, lstAll);
            loadEmployee();
        }

        protected void btnRemoveAllItem_Click(object sender, EventArgs e)
        {
           
            classes.commonTask.AddRemoveAll(lstSelected, lstAll);
            loadEmployee();
        }

        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            lstSelected.Items.Clear();
            gvEmployeeList = null;
            gvEmployeeList.DataBind();
            classes.commonTask.LoadDepartment(ddlCompany.SelectedValue, lstAll);
            //  classes.commonTask.getAuthorityList(ViewState["__CompanyId__"].ToString(), ckblAuthorityList);
            loadAllAuthority();
        }

        protected void ckblAuthorityList_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadSelectedAuthority();
        }

        protected void gvAllAuthorityList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try {
                if (e.CommandName.Equals("Add"))
                {
                    int rIndex = Convert.ToInt32(e.CommandArgument.ToString());
                    TextBox txtLvAuthorityOrder = (TextBox)gvAllAuthorityList.Rows[rIndex].FindControl("txtLvAuthorityOrder");
                    try {
                        int a = int.Parse(txtLvAuthorityOrder.Text.Trim());
                        if (a <1)
                        {
                            lblMessage.InnerText = "warning->Authority Position Must Be greater than 0.";
                            txtLvAuthorityOrder.Focus();
                            return;
                        }
                            
                    }
                    catch
                    {
                        lblMessage.InnerText = "warning-> Please enter valid Authority Possition.";
                        txtLvAuthorityOrder.Focus();
                        return;
                    }
                    
                    string UserId = gvAllAuthorityList.DataKeys[rIndex].Values[0].ToString();
                    string EmpCardNo = gvAllAuthorityList.Rows[rIndex].Cells[0].Text.Trim();
                    string EmpName = gvAllAuthorityList.Rows[rIndex].Cells[1].Text.Trim();
                    string DsgName = gvAllAuthorityList.Rows[rIndex].Cells[2].Text.Trim();
                    string DptName = gvAllAuthorityList.Rows[rIndex].Cells[3].Text.Trim();
                    
                    RadioButtonList rblAuthorityAction = (RadioButtonList)gvAllAuthorityList.Rows[rIndex].FindControl("rblAuthorityAction");
                    addAuthority(rIndex.ToString(),UserId,EmpCardNo,EmpName,DptName,DsgName,txtLvAuthorityOrder.Text,rblAuthorityAction.SelectedValue);
                    gvAllAuthorityList.Rows[rIndex].Visible = false;
                }
            }
            catch(Exception ex) { }
        }

        protected void gvSelectedAuthorityList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName.Equals("Remove"))
                {
                    int rIndex = Convert.ToInt32(e.CommandArgument.ToString());
                    int rIndexAll =int.Parse(gvSelectedAuthorityList.DataKeys[rIndex].Values[0].ToString());
                    string UserId = gvSelectedAuthorityList.DataKeys[rIndex].Values[1].ToString();
                    string EmpCardNo = gvSelectedAuthorityList.Rows[rIndex].Cells[0].Text.Trim();
                    string EmpName = gvSelectedAuthorityList.Rows[rIndex].Cells[1].Text.Trim();
                    string DsgName = gvSelectedAuthorityList.Rows[rIndex].Cells[2].Text.Trim();
                    string DptName = gvSelectedAuthorityList.Rows[rIndex].Cells[3].Text.Trim();
                    TextBox txtLvAuthorityOrder = (TextBox)gvSelectedAuthorityList.Rows[rIndex].FindControl("txtLvAuthorityOrder");
                    RadioButtonList rblAuthorityAction = (RadioButtonList)gvSelectedAuthorityList.Rows[rIndex].FindControl("rblAuthorityAction");                   
                    gvSelectedAuthorityList.Rows[rIndex].Visible = false;
                    gvAllAuthorityList.Rows[rIndexAll].Visible = true;
                    dt = new DataTable();
                    dt = (DataTable)ViewState["__selectedAuthority__"];
                    dt.Rows.RemoveAt(rIndex);
                    ViewState["__selectedAuthority__"] = dt;


                }
            }
            catch (Exception ex) { }
        }

        protected void gvSelectedAuthorityList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try {
                RadioButtonList radioButtonList = (RadioButtonList)e.Row.FindControl("rblAuthorityAction");
                radioButtonList.SelectedValue = gvSelectedAuthorityList.DataKeys[e.Row.RowIndex].Values[2].ToString(); ;
            }
            catch (Exception ex) { }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                submission();
            }
            catch (Exception ex)
            {
            }
        }
        private void submission()
        {
            try
            {

                if (gvSelectedAuthorityList == null || gvSelectedAuthorityList.Rows.Count==0)
                {
                    lblMessage.InnerText = "warning-> Please, Add Authority";
                    return;
                }
                foreach (GridViewRow row in gvSelectedAuthorityList.Rows)
                {
                    TextBox txtLvAuthorityOrder = (TextBox)row.FindControl("txtLvAuthorityOrder");
                    try
                    {
                        int a = int.Parse(txtLvAuthorityOrder.Text.Trim());
                        if (a < 1)
                        {
                            lblMessage.InnerText = "warning->Authority Position Must Be greater than 0.";
                            txtLvAuthorityOrder.Focus();
                            return;
                        }
                    }
                    catch
                    {
                        lblMessage.InnerText = "warning-> Please enter valid Authority Possition.";
                        txtLvAuthorityOrder.Focus();
                        return;
                    }
                }
                if (gvEmployeeList != null && gvEmployeeList.Rows.Count > 0)
                {
                    string tbl = "";
                    if (rblAutoritySetupType.SelectedValue == "Lv")
                        tbl = "UserApprovalAuthorityPanels";
                    else
                        tbl = "tblOutDutyAuthorityAccessControl";

                    foreach (GridViewRow row in gvEmployeeList.Rows)
                    {
                        CheckBox ckbEmp = (CheckBox)row.FindControl("ckbEmp");
                        if (ckbEmp.Checked)
                        {
                            string EmpID = gvEmployeeList.DataKeys[row.RowIndex].Values[0].ToString();
                            delete(tbl,EmpID);
                            foreach (GridViewRow rowAuth in gvSelectedAuthorityList.Rows)
                            {
                                string AuthorityID = gvSelectedAuthorityList.DataKeys[rowAuth.RowIndex].Values[1].ToString();
                                string AuthorityPosition = ((RadioButtonList)rowAuth.FindControl("rblAuthorityAction")).SelectedValue;
                                string AuthorityAction =((TextBox) rowAuth.FindControl("txtLvAuthorityOrder")).Text.Trim() ;
                               
                                
                                sqlCmd = @"INSERT INTO [dbo].["+ tbl +@"]
                                        ([CompanyID]
                                        ,[EmpID]
                                        ,[AuthorityID]
                                        ,[AuthorityPosition]
                                        ,[AuthorityAction])
                                    VALUES
                                        ('" + ddlCompany.SelectedValue + "','"+ EmpID + "',"+ AuthorityID + ","+ AuthorityAction + ","+ AuthorityPosition + ")";                               
                                CRUD.Execute(sqlCmd,sqlDB.connection);
                            }
                        }
                    }
                    lblMessage.InnerText = "success-> Successfully Submited.";
                    loadEmployee();
                }
                else
                {
                    lblMessage.InnerText = "warning-> Please, Add Employee";
                }
            }
            catch (Exception ex)
            {
            }
        }
        private void delete(string tbl, string EmpID)
        {
            sqlCmd = "Delete " + tbl + " where EmpID='" + EmpID + "'";
            CRUD.Execute(sqlCmd, sqlDB.connection);
        }
        private void directApprove(string tbl, string EmpID)
        {   

            sqlCmd = @"INSERT INTO [dbo].[" + tbl + @"]
                                        ([CompanyID]
                                        ,[EmpID]                                       
                                        ,[IsDirectApprove])
                                    VALUES
                                        ('" + ddlCompany.SelectedValue + "','" + EmpID + "'," + 1 + ")";
            CRUD.Execute(sqlCmd, sqlDB.connection);
        }
        protected void rblAutoritySetupType_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadEmployee();
        }

        protected void gvEmployeeList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName.Equals("remove"))
                {
                    int rIndex = Convert.ToInt32(e.CommandArgument.ToString());
                   
                    string EmpID = gvEmployeeList.DataKeys[rIndex].Values[0].ToString();
                    if(rblAutoritySetupType.SelectedValue=="Lv")
                    delete("tblLeaveAuthorityAccessControl", EmpID);
                    else
                    delete("tblOutDutyAuthorityAccessControl", EmpID);
                    loadEmployee();
                    lblMessage.InnerText = "success-> Successfully Deleted.";
                  
                }
                else if (e.CommandName.Equals("directApproval"))
                {
                    int rIndex = Convert.ToInt32(e.CommandArgument.ToString());

                    string EmpID = gvEmployeeList.DataKeys[rIndex].Values[0].ToString();
                    if (rblAutoritySetupType.SelectedValue == "Lv")
                    {
                        delete("tblLeaveAuthorityAccessControl", EmpID);
                        directApprove("tblLeaveAuthorityAccessControl", EmpID);
                    }

                    else
                    {
                        delete("tblOutDutyAuthorityAccessControl", EmpID);
                        directApprove("tblOutDutyAuthorityAccessControl", EmpID);
                    }
                       
                    loadEmployee();
                    lblMessage.InnerText = "success-> Successfully Approved.";

                }
            }
            catch (Exception ex) { }
        }

        protected void ckbEmpAll_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox ckbAll =(CheckBox)gvEmployeeList.HeaderRow.FindControl("ckbEmpAll");
            foreach (GridViewRow row in gvEmployeeList.Rows)
            {
                CheckBox ckb = (CheckBox)row.FindControl("ckbEmp");
                ckb.Checked = ckbAll.Checked;
            }
        }

        protected void gvEmployeeList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Attributes["onmouseover"] = "javascript:SetMouseOver(this)";
                    e.Row.Attributes["onmouseout"] = "javascript:SetMouseOut(this)";
                }
            }
            catch { }
            try {
                CheckBox ckbEmp = (CheckBox)e.Row.FindControl("ckbEmp");
                if (gvEmployeeList.DataKeys[e.Row.RowIndex].Values[1].ToString().Equals(""))
                    ckbEmp.Checked = true;
                else
                    ckbEmp.Checked = false;
                if(ckbEmp.Checked==false)
                    ((CheckBox)gvEmployeeList.HeaderRow.FindControl("ckbEmpAll")).Checked=false;
            } catch(Exception ex) { }
        }

        protected void rblEmpType_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadEmployee();
        }
    }
}