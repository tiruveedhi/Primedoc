<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="changePassword.aspx.cs" Inherits="changePassword" Title="PrimeDoc | Change Password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
function ValidateUsernamePassword(sender, args) {
             var userName = document.getElementById("<% =hdnSession.ClientID %>").value;
             var passWord = document.getElementById("<%=tbNewPassword.ClientID %>").value;
             if (passWord.indexOf(userName) > -1)
             {
                 args.IsValid = false;
             } 
             else 
             {
                 args.IsValid = true;
             }
         }
        function ValidatePasswordNewPassword(sender, args) {
             var newPassword = document.getElementById("<%=tbNewPassword.ClientID %>").value;
             var passWord = document.getElementById("<%=tbOldPassword.ClientID %>").value;
             if (newPassword.indexOf(passWord) > -1)
             {
                 args.IsValid = false;
             } 
             else 
             {
                 args.IsValid = true;
             }
         } 
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
            </h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Change password<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Old password</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbOldPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvOldPwd" runat="server" ErrorMessage="Please enter old password"
                                        ControlToValidate="tbOldPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="validatePasswordLength" runat="server" ErrorMessage="Password must be atleast 8 characters in length"
                                        ControlToValidate="tbOldPassword" Display="Dynamic" ValidationExpression="^[\s\S]{8,}$" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    New password</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbNewPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNewPwd" runat="server" ErrorMessage="Please enter new password"
                                        ControlToValidate="tbNewPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="validateNewPasswordLength" runat="server" ErrorMessage="New password must be atleast 8 characters in length"
                                        ControlToValidate="tbNewPassword" Display="Dynamic" ValidationExpression="^[\s\S]{8,}$" />
                                    <asp:CustomValidator ID="cusValUserPwd" runat="server" ErrorMessage="For security reasons, password is not allowed to contain username in it."
                                        ClientValidationFunction="ValidateUsernamePassword" EnableClientScript="True"></asp:CustomValidator>
                                    <asp:CustomValidator ID="cusValOldNew" runat="server" ErrorMessage="For security reasons, password is not allowed to contain old password in it."
                                        ClientValidationFunction="ValidatePasswordNewPassword" EnableClientScript="True"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Confirm password</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbConfirmPassord" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvConfirmPwd" runat="server" ErrorMessage="Please re-enter password to confirm"
                                        ControlToValidate="tbConfirmPassord" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="New password must be atleast 8 characters in length"
                                        ControlToValidate="tbConfirmPassord" Display="Dynamic" ValidationExpression="^[\s\S]{8,}$" />
                                    <asp:CompareValidator ID="cmvConfirmPwd" runat="server" ControlToCompare="tbNewPassword"
                                        ControlToValidate="tbConfirmPassord" Display="Dynamic" ErrorMessage="New and confirm password didn't match"
                                        ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
                                </div>
                            </div>
                            <center>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                                    class="btn btn-rounded btn-info" />
                                <br />
                                <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
                                <asp:HiddenField ID="hdnSession" runat="server" Value="" />
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end -->
    </div>
</asp:Content>
