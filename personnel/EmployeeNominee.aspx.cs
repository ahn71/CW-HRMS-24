using adviitRuntimeScripting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;


namespace SigmaERP.personnel
{
    public partial class EmployeeNominee : System.Web.UI.Page
    {
        DataTable dt;
        static string imageName = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            sqlDB.connectionString = Glory.getConnectionString();
            sqlDB.connectDB();
            if (!IsPostBack)
            {
                ViewState["__IsSave__"] = "";
                LoadEmpNomineeDetails();
            }


        }


        private void LoadEmpNomineeDetails()
        {
            try
            {
                string EmpId = Request.QueryString["EmpId"].ToString();
                ViewState["_EmpId_"] = EmpId;
                DataTable dta = new DataTable();
                if (!string.IsNullOrEmpty(EmpId))
                {
                    sqlDB.fillDataTable("Select * From Personnel_EmpNominee where EmpId='" + ViewState["_EmpId_"] + "'", dta);
                    if (dta.Rows.Count > 0)
                    {
                        ViewState["__NomineeId__"] = dta.Rows[0]["SL"].ToString();
                        txtNomineeName.Text = dta.Rows[0]["NomineeName"].ToString();
                        txtNomineeNameBN.Text = dta.Rows[0]["NomineeNameBN"].ToString();
                        txtNomineeRelation.Text = dta.Rows[0]["NomineeRelation"].ToString();
                        txtNomineeRelationBN.Text = dta.Rows[0]["NomineeRelationBN"].ToString();
                        txtNomineeNID.Text = dta.Rows[0]["NomineeNID"].ToString();
                        txtNomineeAddress.Text = dta.Rows[0]["NomineeAddress"].ToString();
                        txtNomineeAddressBN.Text = dta.Rows[0]["NomineeAddressBN"].ToString();
                        txtNomineeMobileNo.Text = dta.Rows[0]["NomineeMobile"].ToString();
                        ddlNomineeGender.SelectedValue = dta.Rows[0]["NomineeGender"].ToString();
                        txtNomineeAge.Text = dta.Rows[0]["NomineeAge"].ToString();
                        ViewState["_EmpNomineePictureName_"] = dta.Rows[0]["NomineeImage"].ToString().Trim();
                        imageName = dta.Rows[0]["NomineeImage"].ToString();
                        string url = @"/EmployeeImages/EmpNomineeImage/" + Path.GetFileName(imageName);
                        imgProfile.ImageUrl = url;

                        btnSaveNominee.Text = "Update";
                    }
                    else
                    {
                        ViewState["__IsSave__"] = "Yes";
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTab('/personnel/employee.aspx');", true);
                }



            }
            catch (Exception ex) { }
        }






        protected void btnCloseEmpNominee_Click(object sender, EventArgs e)
        {
            closeTab();
        }
        private void closeTab()
        {
            ViewState["__EmpId__"] = "";
            ClientScript.RegisterClientScriptBlock(Page.GetType(), "script", "window.close();", true);  //Close New Tab for Sever side code
        }

        protected void btnSaveNominee_Click(object sender, EventArgs e)
        {




            if (btnSaveNominee.Text == "Save")
            {
                saveEmpSaveNominee();
                if (ViewState["_EmpId_"] != null)
                {
                    ViewState["__EmpId__"] = "";
                    ClientScript.RegisterClientScriptBlock(Page.GetType(), "script", "window.close();", true);  //Close New Tab for Sever side code
                }
            }
            else
            {
                updateEmpNominee();
                ClientScript.RegisterClientScriptBlock(Page.GetType(), "script", "window.close();", true);
            }
        }

        private string saveImg(string nomineeId)
        {
            try
            {
                string imgName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                if (imgName.Length > 10)
                    imgName = imgName.Substring(imgName.Length - 10);
                imgName = nomineeId + "_" + imgName;




                //string imagePath = Server.MapPath("/EmployeeImages/EmpNomineeImage/" + imgName);
                //// Check if the image exists, and delete it if it does


                System.Drawing.Image image = System.Drawing.Image.FromStream(FileUpload1.PostedFile.InputStream);
                int width = 120;
                int height = 150;
                using (System.Drawing.Image thumbnail = image.GetThumbnailImage(width, height, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero))
                {
                    using (MemoryStream memoryStream = new MemoryStream())
                    {
                        thumbnail.Save(Server.MapPath("/EmployeeImages/EmpNomineeImage/" + imgName), System.Drawing.Imaging.ImageFormat.Png);
                        return imgName;
                        //thumbnail.Save(imagePath, System.Drawing.Imaging.ImageFormat.Png);
                        //return imgName;
                    }
                }
            }

            catch (Exception ex)
            {
                lblMessage.InnerText = "error->" + ex.Message;
                return "";
            }
        }



        //private string saveImg(string nomineeId)
        //{
        //    try
        //    {
        //        string imgName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        //        if (imgName.Length > 10)
        //            imgName = imgName.Substring(imgName.Length - 10);
        //        imgName = nomineeId + "_" + imgName;
        //        System.Drawing.Image image = System.Drawing.Image.FromStream(FileUpload1.PostedFile.InputStream);
        //        int width = 100;
        //        int height = 100;
        //        using (System.Drawing.Image thumbnail = image.GetThumbnailImage(width, height, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero))
        //        {
        //            using (MemoryStream memoryStream = new MemoryStream())
        //            {
        //                thumbnail.Save(Server.MapPath("/EmployeeImages/EmpNomineeImage/" + imgName), System.Drawing.Imaging.ImageFormat.Png);
        //                return imgName;
        //            }
        //        }
        //    }
        //    catch { return ""; }
        //}

        private int saveEmpSaveNominee()
        {
            int nomineeId = 0; // Initialize the variable to hold the last inserted ID

            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Personnel_EmpNominee" +
                    " (EmpId, NomineeName, NomineeNameBN, NomineeRelation, NomineeRelationBN, NomineeNID, NomineeAddress, NomineeAddressBN, NomineeMobile, NomineeGender, NomineeAge) " +
                    " VALUES (@EmpId, @NomineeName, @NomineeNameBN, @NomineeRelation, @NomineeRelationBN, @NomineeNID, @NomineeAddress, @NomineeAddressBN, @NomineeMobile, @NomineeGender, @NomineeAge); " +
                    "SELECT SCOPE_IDENTITY();", sqlDB.connection);

                // Set parameter values
                //cmd.Parameters.AddWithValue("@EmpId", Session["_EmpId_"].ToString());
                cmd.Parameters.AddWithValue("@EmpId", ViewState["_EmpId_"].ToString());
                cmd.Parameters.AddWithValue("@NomineeName", txtNomineeName.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeNameBN", txtNomineeNameBN.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeRelation", txtNomineeRelation.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeRelationBN", txtNomineeRelationBN.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeNID", txtNomineeNID.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeAddress", txtNomineeAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeAddressBN", txtNomineeAddressBN.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeMobile", txtNomineeMobileNo.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeGender", ddlNomineeGender.SelectedValue);
                cmd.Parameters.AddWithValue("@NomineeAge", txtNomineeAge.Text.Trim());
                nomineeId = Convert.ToInt32(cmd.ExecuteScalar());

                //if (HiddenField1.Value.ToString().Length == 0)
                //{
                //    cmd.Parameters.AddWithValue("@NomineeImage", "");
                //}
                //else
                //{
                //    cmd.Parameters.AddWithValue("@NomineeImage", nomineeId + HiddenField1.Value.ToString());
                //}

                // Execute the command and retrieve the last inserted ID


                if (nomineeId > 0)
                {
                    if (FileUpload1.HasFile)
                    {
                        string ImgName = saveImg(nomineeId.ToString());
                        if (ImgName != "")
                        {
                            classes.CRUD.Execute("Update Personnel_EmpNominee set NomineeImage='" + ImgName + "' where SL='" + nomineeId + "'", sqlDB.connection);
                        }
                    }
                    lblMessage.InnerText = "success->Successfully saved";
                }
                else
                {
                    lblMessage.InnerText = "error->Unable to save";
                }
            }
            catch (Exception ex)
            {
                lblMessage.InnerText = "error->" + ex.Message;
            }

            // Return the last inserted ID
            return nomineeId;
        }

        // Store the last inserted ID in a variable



        //private Boolean saveEmpSaveNominee()
        //{
        //    try
        //    {

        //        SqlCommand cmd = new SqlCommand("Insert into  Personnel_EmpNominee" +
        //            " (EmpId, NomineeName, NomineeNameBN ,NomineeRelation,NomineeRelationBN,NomineeNID,NomineeAddress, NomineeAddressBN,NomineeMobile, NomineeGender, NomineeAge)  "
        //        + " values (@EmpId, @NomineeName, @NomineeNameBN ,@NomineeRelation,@NomineeRelationBN,@NomineeNID,@NomineeAddress, @NomineeAddressBN,@NomineeMobile, @NomineeGender, @NomineeAge) ", sqlDB.connection);
        //        cmd.Parameters.AddWithValue("@EmpId", Session["_EmpId_"].ToString());
        //        cmd.Parameters.AddWithValue("@NomineeName", txtNomineeName.Text.Trim());
        //        cmd.Parameters.AddWithValue("@NomineeNameBN", txtNomineeNameBN.Text.Trim());
        //        cmd.Parameters.AddWithValue("@NomineeRelation", txtNomineeRelation.Text.Trim());
        //        cmd.Parameters.AddWithValue("@NomineeRelationBN", txtNomineeRelationBN.Text.Trim());
        //        cmd.Parameters.AddWithValue("@NomineeNID", txtNomineeNID.Text.Trim());
        //        cmd.Parameters.AddWithValue("@NomineeAddress", txtNomineeAddress.Text.Trim());
        //        cmd.Parameters.AddWithValue("@NomineeAddressBN", txtNomineeAddressBN.Text.Trim());
        //        cmd.Parameters.AddWithValue("@NomineeMobile", txtNomineeMobileNo.Text.Trim());
        //        cmd.Parameters.AddWithValue("@NomineeGender", ddlNomineeGender.SelectedValue);
        //        cmd.Parameters.AddWithValue("@NomineeAge", txtNomineeAge.Text.Trim());



        //        int result = (int)cmd.ExecuteNonQuery();

        //        if (result > 0) lblMessage.InnerText = "success->Successfully saved";
        //        else lblMessage.InnerText = "error->Unable to save";

        //        return true;

        //    }
        //    catch (Exception ex)
        //    {
        //        lblMessage.InnerText = "error->" + ex.Message;
        //        return false;
        //    }
        //}

        private Boolean updateEmpNominee()
        {
            try
            {

                SqlCommand cmd = new SqlCommand("update Personnel_EmpNominee  Set  NomineeName=@NomineeName, NomineeNameBN=@NomineeNameBN, NomineeRelation=@NomineeRelation, NomineeRelationBN=@NomineeRelationBN, NomineeNID=@NomineeNID, NomineeAddress=@NomineeAddress, NomineeAddressBN=@NomineeAddressBN, NomineeMobile=@NomineeMobile, NomineeGender=@NomineeGender, NomineeAge=@NomineeAge where SL=@SL ", sqlDB.connection);
                cmd.Parameters.AddWithValue("@SL", ViewState["__NomineeId__"]).ToString();
                cmd.Parameters.AddWithValue("@NomineeName", txtNomineeName.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeNameBN", txtNomineeNameBN.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeRelation", txtNomineeRelation.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeRelationBN", txtNomineeRelationBN.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeNID", txtNomineeNID.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeAddress", txtNomineeAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeAddressBN", txtNomineeAddressBN.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeMobile", txtNomineeMobileNo.Text.Trim());
                cmd.Parameters.AddWithValue("@NomineeGender", ddlNomineeGender.SelectedValue);
                cmd.Parameters.AddWithValue("@NomineeAge", txtNomineeAge.Text.Trim());
                int isRowInsert = cmd.ExecuteNonQuery();


                if (isRowInsert > 0)
                {
                    if (FileUpload1.HasFile)
                    {

                        if (ViewState["_EmpNomineePictureName_"].ToString() != "")
                        {
                            string DBimagePath = Server.MapPath("/EmployeeImages/EmpNomineeImage/" + ViewState["_EmpNomineePictureName_"].ToString());
                            File.Delete(DBimagePath);

                        }
                        string ImgName = saveImg(ViewState["__NomineeId__"].ToString());
                        if (ImgName != "")
                        {
                            classes.CRUD.Execute("Update Personnel_EmpNominee set NomineeImage='" + ImgName + "' where SL='" + ViewState["__NomineeId__"].ToString() + "'", sqlDB.connection);
                        }
                    }

                    lblMessage.InnerText = "success->Successfully saved";
                }
                return true;

            }
            catch (Exception ex)
            {
                lblMessage.InnerText = "error->" + ex.Message;
                return false;
            }
        }

        public bool ThumbnailCallback()
        {
            return false;
        }




        protected void btnPrevious_Click(object sender, EventArgs e)
        {

            string EmpId = ViewState["_EmpId_"].ToString().Trim();

            if (EmpId != null && EmpId != "")
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "call me", "goToNewTabandWindowsClose('/personnel/EmployeeEducation.aspx?EmpId=" + EmpId + "');", true);  //Open New Tab for Sever side code
            }
            else
            {
                closeTab();
            }
        }
    }
}