<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrimeDoc | Register</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet" />
    <link href="css/animate.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />

    <script type="text/javascript">
         function ValidateCheckBox(sender, args) {
             if (document.getElementById("<%=cbRegister.ClientID %>").checked == true) {
                 args.IsValid = true;
             } else {
                 args.IsValid = false;
             }
         }

         function ValidateUsernamePassword(sender, args) {
             var userName = document.getElementById("<%=tbUsername.ClientID %>").value;
             var passWord = document.getElementById("<%=tbPassword.ClientID %>").value;
             if (passWord.indexOf(userName) > -1){
                 args.IsValid = false;
             } else {
                 args.IsValid = true;
             }
         }
         
    </script>

</head>
<body class="gray-bg">
    <form runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="middle-box text-center loginscreen   animated fadeInDown">
        <div>
            <div>
                <h1 class="logo-name">
                    PD</h1>
            </div>
            <h3>
                Register to Prime Doc</h3>
            <p>
                Create account to see it in action.</p>
            <form class="m-t" role="form" action="login.aspx">
            <div class="form-group">
                <asp:DropDownList ID="ddlUserType" runat="server" Width="200px">
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:TextBox ID="tbUsername" runat="server" class="form-control" placeholder="Username"
                    AutoPostBack="true" OnTextChanged="tbUsername_TextChanged">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter user name"
                    ControlToValidate="tbUsername" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="User name should be a minimum of 6 characters"
                    ControlToValidate="tbUsername" Display="Dynamic" ValidationExpression="^[\s\S]{6,}$" />
                <asp:UpdatePanel ID="UpdatePanel1" runat="Server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="tbUsername" EventName="TextChanged" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Image ID="imgUsr" runat="server" Visible="false" />
                        <asp:Label ID="lblUsr" runat="server" Text=""></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="form-group">
                <asp:TextBox ID="tbEmail" runat="server" class="form-control" placeholder="Email"
                    AutoPostBack="true" OnTextChanged="tbEmail_TextChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredEmail" runat="server" ErrorMessage="Please enter Email ID"
                    ControlToValidate="tbEmail" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionEmail" runat="server" ErrorMessage="Invalid Email ID. Please check."
                    ControlToValidate="tbEmail" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                <asp:UpdatePanel ID="upMessage" runat="Server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="tbEmail" EventName="TextChanged" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Image ID="imgId" runat="server" Visible="false" />
                        <asp:Label ID="lblId" runat="server" Text=""></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="form-group">
                <asp:TextBox ID="tbFirstName" runat="server" class="form-control" placeholder="First Name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="First Name is mandatory. Please Check."
                    ControlToValidate="tbFirstName" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="First Name should contain only alphabets. Please check."
                    ControlToValidate="tbFirstName" Display="Dynamic" ValidationExpression="^[A-Za-z ]+$" />
            </div>
            <div class="form-group">
                <asp:TextBox ID="tbLastName" runat="server" class="form-control" placeholder="Last Name"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Last Name should contain only alphabets. Please check."
                    ControlToValidate="tbLastName" Display="Dynamic" ValidationExpression="^[A-Za-z]+$" />
            </div>
            <div class="form-group">
                <asp:TextBox ID="tbPassword" runat="server" class="form-control" placeholder="Password"
                    TextMode="Password"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="rfvNewPwd" runat="server" ErrorMessage="Please enter password"
                    ControlToValidate="tbPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="validatePasswordLength" runat="server" ErrorMessage="Password must be atleast 8 characters in length"
                    ControlToValidate="tbPassword" Display="Dynamic" ValidationExpression="^[\s\S]{8,}$" />
                <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="For security reasons, password is not allowed to contain username in it."
                    ClientValidationFunction="ValidateUsernamePassword"></asp:CustomValidator>
            </div>
            <div class="form-group">
                <asp:TextBox ID="tbConfirmPassword" runat="server" class="form-control" placeholder="Confirm Password"
                    TextMode="Password"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="rfvConfirmPwd" runat="server" ErrorMessage="Please re-enter password to confirm"
                    ControlToValidate="tbConfirmPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cmvConfirmPwd" runat="server" ControlToCompare="tbPassword"
                    ControlToValidate="tbConfirmPassword" Display="Dynamic" ErrorMessage="Password and confirm password didn't match"
                    ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <div class="checkbox i-checks">
                    <label>
                        <asp:CheckBox ID="cbRegister" runat="server" Text="Agree the terms and agreement" />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="<br>You must read and agree to the terms and conditions to continue."
                            ClientValidationFunction="ValidateCheckBox"></asp:CustomValidator><br />
                    </label>
                </div>
            </div>
            <asp:Button ID="btnRegister" runat="server" Text="Register" class="btn btn-primary block full-width m-b"
                OnClick="btnRegister_Click" />
            <p class="text-muted text-center">
                <small>Already have an account?</small></p>
            <a class="btn btn-sm btn-white btn-block" href="login.aspx">Login</a>
            </form>
            <p class="m-t">
                <strong>Copyright</strong> Prime Doc <small>&copy; 2015 - 2020</small>
            </p>
            <div id="checkusername" runat="server" visible="false">
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </div>
        </div>
    </div>
    <!-- Mainly scripts -->

    <script src="js/jquery-2.1.1.js"></script>

    <script src="js/bootstrap.min.js"></script>

    <!-- iCheck -->

    <script src="js/plugins/iCheck/icheck.min.js"></script>

    <script>
        $(document).ready(function(){
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        });
    </script>

    </form>
</body>
</html>
