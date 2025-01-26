<%@ Page Title="" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="bankEntryPanelSetup.aspx.cs" Inherits="SigmaERP.hrms.settings.bankEntryPanelSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        th {
    background: green;
    color: white;
    text-align: center;
}


        .switch {
            position: relative;
            display: inline-block;
            width: 35px;
            height: 18px;
        }

        /* Hide default HTML checkbox */
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        /* The slider */
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
        }

.slider:before {
    position: absolute;
    content: "";
    height: 16px;
    width: 16px;
    left: 4px;
    bottom: 1.5px;
    background-color: white;
    -webkit-transition: .4s;
    transition: .4s;
}

        input:checked + .slider {
            background-color: #2196F3;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(13px);
            -ms-transform: translateX(13px);
            transform: translateX(13px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

            .slider.round:before {
                border-radius: 50%;
            }
                .text-align-left {
        text-align: left; /* Or right, depending on your language */
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
<div class="row">
    <div class="col-md-3">
        <label runat="server" id="lblcompany">Company Name</label>
         <asp:DropDownList runat="server" ID="ddlCompany" CssClass="form-control"></asp:DropDownList>
    </div>
   
    <div class="col-md-3">
        <label runat="server" id="lblbnkname">Bank name</label>
        <asp:TextBox runat="server" ID="txtbankName" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="col-md-3">
        <label runat="server" id="lblbankshortname">Bank short name</label>
        <asp:TextBox runat="server" ID="txtbankshortname" CssClass="form-control"></asp:TextBox>
    </div>
    <div class="col-md-3" runat="server" id="bnkacount" visible="false">
        <label runat="server" id="lblAccountname">Bank Account</label>
        <asp:TextBox runat="server" ID="txtBankacount" CssClass="form-control"></asp:TextBox>
    </div>

   <div class="col-md-3" style="margin-top:10px;">
            <label runat="server" id="lblcheckpayer" style="opacity:0"></label>
            <asp:CheckBox runat="server" ID="chkIspayer" Text="IsPayer" AutoPostBack="true" OnCheckedChanged="chkIspayer_CheckedChanged"/>
             <label runat="server" id="lblbutton" style="opacity:0"></label>
           <asp:Button runat="server" ID="btnSave" OnClick="btnSave_Click" CssClass="btn btn-success" Text="Save"/>
      </div>

</div>
    <asp:GridView runat="server" ID="gvbanklist" OnRowCommand="gvbanklist_RowCommand" DataKeyNames="BankId" AutoGenerateColumns="false" CssClass="table" style="margin-top:10px">
        <Columns>

            <asp:TemplateField HeaderText="SL">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>


            <asp:BoundField DataField="BankName" HeaderStyle-HorizontalAlign="Left" HeaderText="Bank Name" Visible="true" ItemStyle-Height="28px" ItemStyle-HorizontalAlign="Left">
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                <ItemStyle HorizontalAlign="Left" Height="28px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="BankShortName" HeaderText="Bank shortName" Visible="true" ItemStyle-Height="28px" ItemStyle-HorizontalAlign="center">
                <ItemStyle Height="28px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="BankAccount" HeaderText="Account Number" Visible="true" ItemStyle-Height="28px" ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="english-font">
               
            </asp:BoundField>

 

            <asp:TemplateField HeaderText="Edit">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkAlter" runat="server" CommandName="Alter" CommandArgument="<%#((GridViewRow)Container).RowIndex%>" Font-Bold="true" ForeColor="Green">
                        <span><i class="fas fa-edit"></i></span>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>


             <asp:TemplateField HeaderText="Active">
            <ItemTemplate>
                <div class="form-check form-switch">
                   <%-- <asp:CheckBox ID="chkActive" runat="server" CssClass="form-check-input"
                        Checked='<%# Convert.ToBoolean(Eval("IsActive")) %>' 
                        AutoPostBack="True"  OnCheckedChanged="chkActive_CheckedChanged"/>--%>
                </div>

                 <label class="switch">
                   <asp:CheckBox ID="chkActive" runat="server" 
                        Checked='<%# Convert.ToBoolean(Eval("IsActive")) %>' 
                        AutoPostBack="True"  OnCheckedChanged="chkActive_CheckedChanged"/>

                    <%-- <input type="checkbox">--%>
                     <span class="slider round"></span>
                 </label>
            </ItemTemplate>
        </asp:TemplateField>

        </Columns>

    </asp:GridView>
  
</asp:Content>
