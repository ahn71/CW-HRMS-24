<%@ Page Title="Employee Profile" Language="C#" MasterPageFile="~/personnel_NestedMaster.Master" AutoEventWireup="true" CodeBehind="employee_profile.aspx.cs" Inherits="SigmaERP.personnel.employee_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>   
      
      .tdWidth{
            width:400px;
            height:40px;
        }
    
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
                  <div class="col-md-12 ">
               <div class="ds_nagevation_bar">
                   <ul>
                       <li><a href="/default.aspx">Dashboard</a></li>
                       <li><a href="#">/</a></li>
                        <li> <a href="<%= Session["__topMenuForPersonnel__"] %>">Personnel</a></li>
                       <li><a href="#">/</a></li>
                       <li><a href="#" class="ds_negevation_inactive Ptactive">Employees Profile</a></li>
                   </ul>               
             </div>
          
             </div>
       </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate><p class="message"  id="lblMessage" clientidmode="Static" runat="server"></p></ContentTemplate>
</asp:UpdatePanel>

    <asp:HiddenField ID="upSuperAdmin" runat="server" ClientIDMode="Static" />
    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
          <Triggers>
             
              <asp:AsyncPostBackTrigger ControlID="rblEmpType" />             
              <asp:AsyncPostBackTrigger ControlID="ddlBranch" />
          </Triggers>
          <ContentTemplate>
    <div class="row Ptrow">
        
        <div class="employee_box_header PtBoxheader">
            <h2>Employee Profile Report</h2>
        </div>
        <div class="employee_box_body">
            <div class="employee_box_content">

                <div class="punishment_against">
                    <h1  runat="server" visible="false" id="WarningMessage"  style="color:red; text-align:center"></h1>
                    <table runat="server" id="tblGenerateType" class="employee_table"  >

                        <tr>
                            <td>Company
                            </td>
                            <td>:</td>
                            <td class="tdWidth">
                                <asp:DropDownList ID="ddlBranch" ClientIDMode="Static" CssClass="form-control select_width" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Employee Type</td>
                            <td>:</td>
                            <td class="tdWidth">
                                <asp:RadioButtonList runat="server" ID="rblEmpType" AutoPostBack="true" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblEmpType_SelectedIndexChanged">
                                </asp:RadioButtonList>
                            </td>
                        </tr>

                        <tr runat="server" id="divindivisual">
                            <td>Card No / Name
                            </td>
                            <td>:</td>
                            <td class="tdWidth">
                                <asp:DropDownList ID="ddlCardNo" ClientIDMode="Static" CssClass="form-control select_width"  runat="server"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </div> 
                
                                     <div id="divDepartmentList" runat="server" class="id_card" style="background-color:white; width:61%;">
                            <div class="id_card_left EilistL">
                                <asp:ListBox ID="lstAll" runat="server" CssClass="lstdata EilistCec" SelectionMode="Multiple"></asp:ListBox>
                            </div>
                            <div class="id_card_center EilistC">
                                <table style="margin-top:0px;" class="employee_table">                  
                              <tr>
                                    <td >
                                        <asp:Button ID="btnAddItem" Class="arrow_button" runat="server" Text=">" OnClick="btnAddItem_Click" />
                                    </td>
                               </tr>
                            <tr>
                                    <td>
                                        <asp:Button ID="btnAddAllItem" Class="arrow_button" runat="server" Text=">>" OnClick="btnAddAllItem_Click"  />
                                    </td>
                               </tr>
                            <tr>
                                    <td>
                                        <asp:Button ID="btnRemoveItem" Class="arrow_button" runat="server" Text="<" OnClick="btnRemoveItem_Click"   />
                                    </td>
                               </tr>
                            <tr>
                                    <td>
                                        <asp:Button ID="btnRemoveAllItem" Class="arrow_button" runat="server" Text="<<" OnClick="btnRemoveAllItem_Click"  />
                                    </td>
                               </tr>
                        </table>
                    </div>
                     <div class="id_card_right EilistR">
                                <asp:ListBox ID="lstSelected" SelectionMode="Multiple" CssClass="lstdata EilistCec"  ClientIDMode="Static" runat="server"></asp:ListBox>
                            </div>
                </div>
                <div class="punishment_button_area">
                    <table class="emp_button_table">
                        <tbody>
                            <tr>
                                <th><asp:Button ID="btnPrintpreview" runat="server" CssClass="css_btn Ptbut" ClientIDMode="Static" Text="Profile" OnClick="btnPrintpreview_Click" /></th>
                                <th><asp:Button ID="btnClose" PostBackUrl="~/personnel_defult.aspx" Text="Close" runat="server" CssClass="css_btn Ptbut" /></th>                                   
                         </tr>
                    </tbody>
                  </table>
                </div>

        </div>
      </div>
    </div>
              </ContentTemplate>
        </asp:UpdatePanel>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ddlCardNo").select2();

        });
        function loadcardNo() {
            $("#ddlCardNo").select2();
        }
        function goToNewTabandWindow(url) {
            window.open(url);
            loadcardNo();
        }
    </script>
</asp:Content>
