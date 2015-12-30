<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_bankAccountDetails.aspx.cs" Inherits="bpd_bankAccountDetails" Title="PrimeDoc | Manage Funds" %>

<%--PrimeDoc | Bank Account Details--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
// Function to check letters and numbers
function Validations()
{
    if(document.getElementById("<%=tbIFSC.ClientID %>").value!="")
    {
        var TCode = document.getElementById("<%=tbIFSC.ClientID %>").value;
        if( /[^a-zA-Z0-9]/.test( TCode ) ) 
        {
           alert('Please enter alphanumeric characters only');
           document.getElementById("<%=tbIFSC.ClientID %>").focus();
           return false;
        }
    }
    if(document.getElementById("<%=tbUserName.ClientID %>").value!="")
    {
        var regex = /^[a-zA-Z]*$/;
        if (!regex.test(document.getElementById("<%=tbUserName.ClientID %>").value)) 
        {
            alert('Alphabets Only');
            document.getElementById("<%=tbUserName.ClientID %>").focus();
            return false;
        }
    }
    if(document.getElementById("<%=tbAccountNo.ClientID %>").value!="")
    {
        var numbers = /^[0-9]+$/;
        var accNo = document.getElementById("<%=tbAccountNo.ClientID %>").value;
        if(!accNo.match(numbers))
        {
            alert('Please input numeric characters only');
            document.getElementById("<%=tbAccountNo.ClientID %>").focus();
            return false;
        }
    }
    if(document.getElementById("<%=tbCnfmAccountNo.ClientID %>").value!="")
    {
        var numbers = /^[0-9]+$/;
        var accNo = document.getElementById("<%=tbCnfmAccountNo.ClientID %>").value;
        if(!accNo.match(numbers))
        {
            alert('Please input numeric characters only');
            document.getElementById("<%=tbCnfmAccountNo.ClientID %>").focus();
            return false;
      }
    }
}
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Manage Funds</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="bpd_manageFunds.aspx">Account Fund Details</a></li>
                        <li class=""><a href="bpd_viewAllTransactions.aspx">View All Transactions</a></li>
                        <li class="active"><a href="bpd_bankAccountDetails.aspx">Bank Account Details</a></li>
                        <li class=""><a href="bpd_Managerates.aspx">Manage Rates</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="ibox-content">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Account number :</label>
                                            <%--<asp:Label ID="lblAccountNo" runat="server" Text="Account number :" class="col-sm-2 control-label"></asp:Label>--%>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="tbAccountNo" runat="server" class="form-control" TextMode="SingleLine"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter AccountNo "
                                                    ControlToValidate="tbAccountNo" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Confirm Account number :</label>
                                            <%--<asp:Label ID="lblCnfmAccountNo" runat="server" Text="Confirm Account number :" class="col-sm-2 control-label"></asp:Label>--%>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="tbCnfmAccountNo" runat="server" class="form-control" TextMode="SingleLine"></asp:TextBox>
                                                <asp:CompareValidator ID="cmvConfirmPwd" runat="server" ControlToCompare="tbAccountNo"
                                                    ControlToValidate="tbCnfmAccountNo" Display="Dynamic" ErrorMessage="Account Number and confirmAccountNumber didn't match"></asp:CompareValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Name of the Account holder :</label>
                                            <%--<asp:Label ID="lblUserName" runat="server" Text="Name of the Account holder :" class="col-sm-2 control-label"></asp:Label>--%>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="tbUserName" runat="server" class="form-control" TextMode="SingleLine"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter Account HolderName "
                                                    ControlToValidate="tbAccountNo" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Account Type :</label>
                                            <%--<asp:Label ID="lblAccountType" runat="server" Text="Account Type :" class="col-sm-2 control-label"></asp:Label>--%>
                                            <div class="col-sm-10">
                                                <asp:DropDownList ID="ddlaccounttype" runat="server" class="form-control m-b">
                                                    <asp:ListItem Value="1">SAVINGS BANK</asp:ListItem>
                                                    <asp:ListItem Value="2">CURRENT ACCOUNT</asp:ListItem>
                                                    <asp:ListItem Value="3">CASH CREDIT</asp:ListItem>
                                                    <asp:ListItem Value="4">LOAN ACCOUNT</asp:ListItem>
                                                    <asp:ListItem Value="5">CREDIT CARD</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Swift code :</label>
                                            <%--<asp:Label ID="lblIFSC" runat="server" Text="Swift code :" class="col-sm-2 control-label"></asp:Label>--%>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="tbIFSC" runat="server" class="form-control" TextMode="SingleLine"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter Swift code "
                                                    ControlToValidate="tbIFSC" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Rooting code :</label>
                                            <%--<asp:Label ID="Label1" runat="server" Text="Rooting code :" class="col-sm-2 control-label"></asp:Label>--%>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="tbRooting" runat="server" class="form-control" TextMode="SingleLine"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please enter Rooting code "
                                                    ControlToValidate="tbRooting" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <center>
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-rounded btn-info"
                                                OnClick="btnSubmit_Click" OnClientClick="return Validations();"/></center>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
