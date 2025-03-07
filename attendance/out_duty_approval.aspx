﻿<%@ Page Title="Out Duty Approval" Language="C#" MasterPageFile="~/attendance_nested.master" AutoEventWireup="true" CodeBehind="out_duty_approval.aspx.cs" Inherits="SigmaERP.attendance.out_duty_approval" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../scripts/jquery-1.8.2.js"></script>
        <script type="text/javascript">

            var oldgridcolor;
            function SetMouseOver(element) {
                oldgridcolor = element.style.backgroundColor;
                element.style.backgroundColor = '#ffeb95';
                element.style.cursor = 'pointer';
                // element.style.textDecoration = 'underline';
            }
            function SetMouseOut(element) {
                element.style.backgroundColor = oldgridcolor;
                // element.style.textDecoration = 'none';

            }

</script>
    <style>
        #ContentPlaceHolder1_MainContent_gvForApprovedList td, th {
            text-align: center;
        }

            #ContentPlaceHolder1_MainContent_gvForApprovedList td:first-child, th:first-child {
                text-align: left;
                padding-left: 3px;
            }

        .tblSelection {
            width: 95%;
            margin: 0px auto;
        }

        .tdWidth {
           width:25%;
        }
        .pnlpopup {
            background-color: #93c9ea;
            width: 800px;
            height: auto;
            color: #000;
            padding: 16px;
            overflow: hidden;
        }
        .closebtn {
            position: absolute;
            right: 10px;
            top: 5px;
            font-size: 15px;
            background: #bbb9b9;
            width: 25px;
            height: 25px;
            text-align: center;
            padding: 2px 0px;
            border-radius: 50%;
            overflow: hidden;
            color: #000;
            font-weight: bold;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
       <div class="row">
        <div class="col-md-12">
            <div class="ds_nagevation_bar">
                <ul>
                    <li><a href="/default.aspx">Dashboard</a></li>
                    <li>/</li>
                   <li><a href="<%=  Session["__topMenu__"] %>">Attendance</a></li>
                    <li>/</li>
                    <li><a href="#" class="ds_negevation_inactive Mactive">Out Duty Approval</a></li>
                </ul>
            </div>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="uplMessage" runat="server" >
    <ContentTemplate>
        <p class="message" id="lblMessage" clientidmode="Static" runat="server"></p>
    </ContentTemplate>
</asp:UpdatePanel>
    
    <%--<div class="list_main_box">

                <div style="width: 80%; background-color:#27235C" class="list_main_content_box_header"  id="divElementContainer"  runat="server"> --%>
     <div class="main_box Lbox">
        <div runat="server" id="divElementContainer" class="main_box_header_leave LBoxheader">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <Triggers>
                     
                            <asp:AsyncPostBackTrigger ControlID="ddlCompanyList" />
                            <asp:AsyncPostBackTrigger ControlID="ddlShiftName" />
                            <asp:AsyncPostBackTrigger ControlID="ddlDepartmentList" />
                            <asp:AsyncPostBackTrigger ControlID="ddlFindingType" />
                            
                            
                        </Triggers>
                        <ContentTemplate>
                      <h2 style="border-bottom:1px solid white">Out Duty Approval Panel</h2>
                              <asp:RadioButtonList runat="server" ID="rblEmpType" AutoPostBack="true" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblEmpType_SelectedIndexChanged" >
                                </asp:RadioButtonList>

                            <div class="pull-right">
                                <asp:Button ID="btnForword"  Text="Forword" CommandName="Forword" runat="server" Width="80px" Height="30px" Font-Bold="true" ForeColor="Blue" OnClientClick="return confirm('Do you want to forword all selectd application ?')" CssClass="hand" OnClick="btnForword_Click" />
                                <asp:Button ID="btnYes"  Text="Approve" CommandName="Yes" runat="server" Width="80px" Height="30px" Font-Bold="true" ForeColor="Green" OnClientClick="return confirm('Do you want to approve all selectd application?')" CssClass="hand" OnClick="btnYes_Click" />
                                <asp:Button ID="btnNot"  Text="Reject" CommandName="No" Font-Bold="true" Height="30px" ForeColor="red" runat="server" OnClientClick="return confirm('Do you want to reject all selectd application ?')" Width="80px" OnClick="btnNot_Click" />
                            </div>

                             <asp:Label runat="server" ID="lblpu"></asp:Label>                         
                            <asp:ModalPopupExtender runat="server" ClientIDMode="Static" ID="mpe" PopupControlID="pnlPopUp" TargetControlID="lblpu"  CancelControlID="lblpuCancel" >
                            </asp:ModalPopupExtender>


                   


                 <asp:Panel runat="server" ClientIDMode="Static" ID="pnlPopUp" CssClass="pnlpopup" >
                     <div>
                       <h2>Details</h2>         
                             <asp:GridView HeaderStyle-BackColor="#27235C" ID="gvDetails" runat="server" AutoGenerateColumns="false"  HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="14px"  Width="100%">
                        
                          <Columns>
                              <asp:TemplateField HeaderText="SL" >
                                <ItemTemplate>
                                 <%#Container.DataItemIndex+1 %> 
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:BoundField DataField="ClientName" HeaderText="Client" ItemStyle-Height="25px" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Height="28px"  />
                              <asp:BoundField DataField="InTime" HeaderText="In Time"   ItemStyle-Height="25px" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Height="28px"  />
                              <asp:BoundField DataField="OutTime" HeaderText="Out Time" ItemStyle-Height="25px" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Height="28px"  />                             
                              <asp:BoundField DataField="Purpose" HeaderText="Purpose" ItemStyle-Height="25px" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Height="28px"  />                             
                              </Columns>
                                 </asp:GridView>
                         <asp:Label runat="server" CssClass="closebtn" ID="lblpuCancel" >X</asp:Label>
                     </div>
                 </asp:Panel>
               <div hidden="hidden" >
                         <table class="tblSelection">
                              <tr>
                                  
                                        <td>Company</td>
                                        <td>:</td>
                                        <td class="tdWidth">
                                        <asp:DropDownList ID="ddlCompanyList" ClientIDMode="Static" style="margin-left: 10px; width: 96%;"   CssClass="form-control select_width" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCompanyList_SelectedIndexChanged"  >              
                                         </asp:DropDownList>
                                        </td>         
                          <asp:Panel ID="Panel1" runat="server" Visible="false">
                                  <td>Shift</td>
                                        <td>:</td>
                                        <td class="tdWidth">
                                            <asp:DropDownList ID="ddlShiftName" CssClass="form-control select_width" runat="server" Width="96%" AutoPostBack="True" OnSelectedIndexChanged="ddlShiftName_SelectedIndexChanged" ></asp:DropDownList>
                                        </td>
                                  </asp:Panel>
                                 <td>
                                     Department
                                 </td>
                                 <td>:</td>
                                 <td class="tdWidth">
                                     <asp:DropDownList runat="server" ID="ddlDepartmentList" CssClass="form-control text_box_width style" Width="96%" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartmentList_SelectedIndexChanged" ></asp:DropDownList>
                                 </td>
                                                    
                                 
                                  <td>
                                     Type
                                 </td>
                                 <td>:</td>
                                 <td>
                                     <asp:DropDownList runat="server" ID="ddlFindingType" CssClass="form-control text_box_width style" Width="95px" AutoPostBack="True" OnSelectedIndexChanged="ddlFindingType_SelectedIndexChanged" >
                                        <%-- <asp:ListItem Value="Today">Today</asp:ListItem>--%>
                                         <asp:ListItem Value="All">All</asp:ListItem>
                                     </asp:DropDownList>
                                 </td>
                                  <td><h2 style="float: right;"><asp:LinkButton runat="server" ID="lnkRefresh" Text="Refresh" ForeColor="white" OnClick="lnkRefresh_Click"></asp:LinkButton></h2></td>
                                  <td style="color:gray;font-size:medium; ">|</td>
                                  <td><h2 style="float: right; "><a style="color:white" href="../leave_default.aspx">Close</a></h2></td>
                                 
                             </tr>
                         </table>
                  
                     </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                   <div class="loding_img">
                       <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <span style=" font-family:'Times New Roman'; font-size:20px; color:green;font-weight:bold;float:left"><p>&nbsp;</p> </span> <br />
                                        <img cursor:pointer; float:left" src="/images/loader-2.gif"/>  
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                  </div>
                <asp:UpdatePanel runat="server" ID="up2">
                    <Triggers>
                        

                    </Triggers>
                    <ContentTemplate>

                     <div  style="width: 100%; background-color:#fff;margin: auto;">
                        
                     <asp:GridView HeaderStyle-BackColor="#27235C" ID="gvForApprovedList" runat="server" AutoGenerateColumns="false"  HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="14px"  Width="100%" DataKeyNames="SL,EmpId,Type" OnRowCommand="gvForApprovedList_RowCommand" OnRowDataBound="gvForApprovedList_RowDataBound" >
                         <PagerStyle CssClass="gridview" />
                          <Columns>
                              <asp:TemplateField HeaderText="Card No" >
                                <ItemTemplate>
                                    <asp:Label ID="lblEmpCardNo" runat="server" Text='<%# Eval("EmpCardNo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:BoundField DataField="EmpName" HeaderText="Name" Visible="true"  ItemStyle-Height="25px" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Height="28px"  />
                              <asp:BoundField DataField="DsgName" HeaderText="Designation" Visible="true" ItemStyle-Height="25px" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Height="28px"  />
                              <asp:BoundField DataField="DptName" HeaderText="Department" Visible="true" ItemStyle-Height="25px" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Height="28px"  />
                             <asp:BoundField DataField="TypeName" HeaderText="Type" Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="188px"  />
                              <asp:TemplateField HeaderText="Date" >
                                <ItemTemplate>
                                    <asp:Label ID="lblDate" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Straight from home" >
                                <ItemTemplate>
                                    <asp:CheckBox  ID="ckbsfhome" runat="server" Enabled="false" Checked='<%# Eval("StraightFromHome") %>' />                                   
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Straight to home" >
                                <ItemTemplate>
                                    <asp:CheckBox ID="ckbsthome" runat="server" Enabled="false" Checked='<%# Eval("StraightToHome") %>' />                                   
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Remarks" >
                                <ItemTemplate>
                                    <asp:Label ID="lblRemark" runat="server" Text='<%# Eval("Remark") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField HeaderText="Chosen" HeaderStyle-Width="35px">
                                    <HeaderTemplate>
                                        <asp:CheckBox runat="server" ClientIDMode="Static" ID="ckbAll" Text="All" OnCheckedChanged="ckbAll_CheckedChanged" AutoPostBack="true" />
                                    </HeaderTemplate>
                                  <ItemTemplate>
                                      <asp:CheckBox runat="server" ClientIDMode="Static" ID="ckbChosen"  AutoPostBack="true" OnCheckedChanged="ckbChosen_CheckedChanged" />                                     
                                  </ItemTemplate>
                              </asp:TemplateField>

                              <asp:TemplateField>
                                            <HeaderTemplate>
                                                Details
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="btnShow"  Text="Details" CommandName="Show" runat="server" Width="80px" Height="30px" Font-Bold="true" ForeColor="Blue"  CommandArgument='<%#((GridViewRow)Container).RowIndex%>' CssClass="hand" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                              <asp:TemplateField>
                                            <HeaderTemplate>
                                                View
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="btnView" runat="server" Text="View" Font-Bold="true" CommandName="View" ForeColor="Black" CommandArgument="<%# Container.DataItemIndex%>" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                          <asp:TemplateField HeaderText="Approval" HeaderStyle-Width="80px">
                                  <ItemTemplate>
                                      <asp:Table ID="Table2" runat="server" >
                                          <asp:TableRow>
                                                 <asp:TableCell>
                                                   
                                              </asp:TableCell>
                                               <asp:TableCell>
                                                  |
                                              </asp:TableCell>
                                                 <asp:TableCell>
                                                   <asp:Button ID="btnForword"  Text="Forword" CommandName="Forword" runat="server" Width="80px" Height="30px" Font-Bold="true" ForeColor="Blue" OnClientClick="return confirm('Do you want to forword ?')" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' CssClass="hand" />
                                              </asp:TableCell>
                                              <asp:TableCell>
                                                  |
                                              </asp:TableCell>
                                              <asp:TableCell>
                                                   <asp:Button ID="btnYes"  Text="Approve" CommandName="Yes" runat="server" Width="80px" Height="30px" Font-Bold="true" ForeColor="Green" OnClientClick="return confirm('Do you want to approve ?')" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' CssClass="hand" />
                                              </asp:TableCell>
                                              <asp:TableCell>
                                                  |
                                              </asp:TableCell>
                                              <asp:TableCell>
                                                  <asp:Button ID="btnNot"  Text="Reject" CommandName="No" Font-Bold="true" Height="30px" ForeColor="red" runat="server" OnClientClick="return confirm('Do you want to reject ?')" Width="80px" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'  />
                                              </asp:TableCell>
                                          </asp:TableRow>
                                      </asp:Table>
                                     <%--  --%>
                                     <%-- <asp:Label ID="btnSeperator"  Text="|" CommandName="No" runat="server"  />--%>
                                       

                                  </ItemTemplate>
                              </asp:TemplateField>
                                                                   
                          </Columns>
                         <HeaderStyle BackColor="#5EC1FF" ForeColor="White" Height="28px" />
                     </asp:GridView>
                         <div id="divRecordMessage" runat="server" visible="false" style="color: red; font-weight: bold; text-align: center; padding-top: 75px; font-size: 32px; height: 118px">
                         </div>
                </div>
                   </ContentTemplate>
                </asp:UpdatePanel>
        </div>
    
    <style type=”text/css”>
    .hand { cursor: pointer; cursor: hand; } /* cross browser hand */
</style>
    <script type="text/javascript">
        function LeaveDaysCaclulate(ob) {


            var start = new Date("2014-06-01");
            var td = ob.value;
            var end = new Date(td);
            var diff = new Date(end - start);
            var days = diff / 1000 / 60 / 60 / 24;
            alert(days);
            var par = $(ob).closest('tr');
            var d = par[0];
            var r = d.find('td');
        }
        function goToNewTabandWindow(url) {
            window.open(url);
        }
    </script>

</asp:Content>