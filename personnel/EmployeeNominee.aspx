<%@ Page Title="" Language="C#" MasterPageFile="~/Glory.Master" AutoEventWireup="true" CodeBehind="EmployeeNominee.aspx.cs" Inherits="SigmaERP.personnel.EmployeeNominee" %>
<%@ Register Assembly="AjaxControlToolkit"  Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link href="/style/jquery-ui-datepekar.css" rel="stylesheet" />
    <link href="/style/dataTables.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate><p class="message"  id="lblMessage" clientidmode="Static" runat="server"></p></ContentTemplate>
</asp:UpdatePanel>
     <asp:HiddenField ID="hdfeducation" runat="server" ClientIDMode="Static"  />
        <%--<asp:HiddenField ID="HiddenField1" runat="server" ClientIDMode="Static" />--%>

<div  style="padding:0;margin-top:25px;">
    <div class="row">
   <div class="col-lg-12">
         <div class="employee_box_header PtBoxheader">
         <h2>Nominee Panel</h2>
     </div>
     <div class="employee_box_body Ptbody">
         
         <div class="employee_box_content">
    <div class="personal_employee_education_main" runat="server" id="divEmpEducation">
                 <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                 <Triggers>
                    
                 </Triggers>
                 <ContentTemplate>
                   <div class="row">
                     <div class="col-lg-1"></div>
                     <div class="col-lg-10">
             <div class="personal_employee_education">
                 <div class="row">
                     <div class="col-lg-5">
                            <div class="form-horizontal form_horizontal_custom">
                                <div class="form-group">
                            <label for="txtNomineeName" class="col-sm-4 control-label">Nominee Name<span class="requerd1">*</span></label>
                            <div class="col-sm-7 padding_right">
                                <asp:TextBox ID="txtNomineeName" CssClass="form-control"  ClientIDMode="Static" runat="server"></asp:TextBox>
                            </div>
                            </div>
                                <div class="form-group">
                                    <label for="txtNomineeNameBN" class="col-sm-4 control-label">নমিনির  নাম</label>
                                    <div class="col-sm-7 padding_right">
                                        <asp:TextBox ID="txtNomineeNameBN" CssClass="form-control" ClientIDMode="Static" runat="server" style="font-family:SutonnyMJ;"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="txtNomineeRelation" class="col-sm-4 control-label">Relation<span class="requerd1">*</span> </label>
                                    <div class="col-sm-7 padding_right">
                                        <asp:TextBox ID="txtNomineeRelation" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="txtNomineeRelationBN" class="col-sm-4 control-label">সম্পর্ক</label>
                                    <div class="col-sm-7 padding_right">
                                        <asp:TextBox ID="txtNomineeRelationBN" CssClass="form-control" ClientIDMode="Static" runat="server" style="font-family:SutonnyMJ;"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="txtNomineeNID" class="col-sm-4 control-label">NID
                                       <%-- <span class="requerd1">*</span>--%>

                                    </label>
                                    <div class="col-sm-7 padding_right">
                                        <asp:TextBox ID="txtNomineeNID" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                        </div>
                   
                     <div class="col-lg-5">
                          <div class="form-horizontal form_horizontal_custom">
                              <div class="form-group">
                                  <label for="txtAddress" class="col-sm-4 control-label">Address <span class="requerd1">*</span></label>
                                  <div class="col-sm-7 padding_right">
                                      <asp:TextBox ID="txtNomineeAddress" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                  </div>
                              </div>
                              <div class="form-group">
                                  <label for="txtAddressBN" class="col-sm-4 control-label"> ঠিকানা</label>
                                  <div class="col-sm-7 padding_right">
                                      <asp:TextBox ID="txtNomineeAddressBN" CssClass="form-control" ClientIDMode="Static" runat="server" style="font-family:SutonnyMJ;"></asp:TextBox>
                                  </div>
                              </div>

                              <div class="form-group">
                                  <label for="txtNomineeMobileNo" class="col-sm-4 control-label">Mobile No 
                                      <%--<span class="requerd1">*</span>--%>

                                  </label>
                                  <div class="col-sm-7 padding_right">
                                      <asp:TextBox ID="txtNomineeMobileNo" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                  </div>
                              </div>

<%--                              <div class="form-group">
                                  <label for="txtNomineeGender" class="col-sm-4 control-label">Gender</label>
                                  <div class="col-sm-7 padding_right">
                                      <asp:TextBox ID="txtNomineeGender" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                  </div>
                              </div>--%>

                          <div class="form-group">
                                  <label for="ddlNomineeGender" class="col-sm-4 control-label">Gender<span class="requerd1">*</span></label>
                                  <div class="col-sm-7 padding_right">
                                      <asp:DropDownList ID="ddlNomineeGender" CssClass="form-control" ClientIDMode="Static" runat="server" >
                                           <asp:ListItem Value="0">---Select--- </asp:ListItem>
                                          <asp:ListItem Value="Male">Male</asp:ListItem>
                                          <asp:ListItem Value="Female">Female </asp:ListItem>
                                         
                                      </asp:DropDownList>


<%--                                      <asp:TextBox ID="" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>--%>
                                  </div>
                              </div> 

                              <div class="form-group">
                                  <label for="txtAge" class="col-sm-4 control-label">Age
                                     <%-- <span class="requerd1">*</span>--%>

                                  </label>
                                  <div class="col-sm-7 padding_right">
                                      <asp:TextBox ID="txtNomineeAge" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                  </div>
                              </div>
                        </div>
                     </div>

                     <div class="col-lg-2">
                         <div>
                             <asp:Image ID="imgProfile" class="profileImage" ClientIDMode="Static" runat="server" ImageUrl="~/images/profileImages/noProfileImage.jpg" />
                             <asp:FileUpload ID="FileUpload1" Style="margin-top: 20px;" runat="server" onchange="previewFile()" ClientIDMode="Static" />
           
    
                         </div>
                     </div>
                       </div>

                 </div>
              
          </div>
        </div>
        </div>
                     </ContentTemplate>
                      </asp:UpdatePanel>
              <table class="em_button_table">
                        <tr>
                             <th>
                                 <asp:Button ID="btnPrevious" ClientIDMode="Static" class="emp_btn Ptbut" runat="server" Text="<<" ToolTip="Previous Page" OnClick="btnPrevious_Click"/>
                                
                            </th>
                            <th>
                                <asp:Button ID="btnSaveNominee"  ClientIDMode="Static" class="emp_btn Ptbut" runat="server" Text="Save" OnClientClick="return InputValidation();" OnClick="btnSaveNominee_Click"/>
                            </th>
                           <th><asp:Button ID="btnCloseEmpNominee" ClientIDMode="Static"  class="emp_btn Ptbut" runat="server" Text="Close" OnClick="btnCloseEmpNominee_Click"  /></th>
                            
                            
                        </tr>
              </table>
                  <div style="width:100%; margin-top:10px; text-align:center"><h1></h1></div>
                 <div id="divEducationList" class="datatables_wrapper" style="width:100%; height:auto; max-height:500px;overflow:auto;overflow-x:hidden;"></div>
                     
         </div>
             
             </div>
             </div>
        </div>
        </div>
        </div>
    <script type="text/javascript">


        function previewFile() {
            try {
                var preview = document.querySelector('#imgProfile');
                var file = document.querySelector('#FileUpload1').files[0];
               
                var reader = new FileReader();

                reader.onloadend = function () {
                    preview.src = reader.result;
                }

                if (file) {
                    reader.readAsDataURL(file);
                } else {
                    preview.src = "";
                }
                var imagename = $('#FileUpload1').val();
                $('#HiddenField1').val(imagename);                
            }
            catch (exception) {
                lblMessage.innerText = exception;
            }

        }







         function goToNewTabandWindowsClose(url) {
            window.open(url);
            window.close();
        }
        
        function InputValidation() {
            try {
                if ($('#txtNomineeName').val().trim().length == 0 && $('#txtNomineeNameBN').val().trim().length == 0) {
                 showMessage("warning->Please type nominee name!");
    
                    // Set focus on the empty field
                    if ($('#txtNomineeName').val().trim().length == 0) {
                        $('#txtNomineeName').focus();
                    } else {
                        $('#txtNomineeNameBN').focus();
                    }

                return false;
                }

                if ($('#txtNomineeRelation').val().trim().length == 0 && $('#txtNomineeRelationBN').val().trim().length == 0) {
                 showMessage("warning->Please type nominee relation!");
    
                    // Set focus on the empty field
                    if ($('#txtNomineeRelation').val().trim().length == 0) {
                        $('#txtNomineeRelation').focus();
                    } else {
                        $('#txtNomineeRelationBN').focus();
                    }

                return false;
                }

                //if ($('#txtNomineeRelation').val().trim().length == 0) {
                //    showMessage("warning->Please type nominee relation  !");
                //    $('#txtNomineeRelation').focus();
                //    return false;
                //}


                //if ($('#txtNomineeNID').val().trim().length == 0) {
                //    showMessage("warning->Please type nominee NID ! ");
                //    $('#txtNomineeNID').focus();
                //    return false;
                //}
                if ($('#txtNomineeAddress').val().trim().length == 0 &&$('#txtNomineeAddressBN').val().trim().length == 0) {
                    showMessage("warning->Please type nominee address!");

                    // Set focus on the empty field
                    if ($('#txtNomineeAddress').val().trim().length == 0) {
                        $('#txtNomineeAddress').focus();
                    } else {
                        $('#txtNomineeAddressBN').focus();
                    }

                    return false;
                }


                //if ($('#txtNomineeAddress').val().trim().length == 0) {
                //    showMessage("warning->Please type nominee address ! ");
                //    $('#txtNomineeAddress').focus();
                //    return false;
                //}

                //if ($('#txtNomineeMobileNo').val().trim().length == 0) {
                //    showMessage("warning->Please type mobile no ! ");
                //    $('#txtNomineeMobileNo').focus();
                //    return false;
                //}

                var nomineeGender = document.getElementById('ddlNomineeGender');
                if (nomineeGender.value === "0") {
                    showMessage("warning->Please select gender ! ");
                    $('#ddlNomineeGender').focus();
                    return false; 
                }

                //if ($('#ddlNomineeGender option:selected').text().length == 0) {

                //    showMessage("warning->Please Select gender ");
                //    $('#txtNomineeMobileNo').focus();
                //    return false;
                //} 


                //if ($('#txtNomineeAge').val().trim().length < 1) {
                //    showMessage("warning->Please type nominee age ");
                //    $('#txtNomineeAge').focus();
                //    return false;
                //}

                return true;
            }
            catch (exception)
            {

            }
        }
    </script>
</asp:Content>
