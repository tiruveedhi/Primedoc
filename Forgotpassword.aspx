<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Forgotpassword.aspx.cs" Inherits="Forgotpassword" %>

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
         
       
    </script>

</head>
<body class="gray-bg">
    <form id="Form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="middle-box text-center loginscreen   animated fadeInDown">
        <div>
            <div>
                <h1 class="logo-name">
                    PD</h1>
            </div>
           
             <div class="form-group">
                <asp:TextBox ID="tbEmail" runat="server" class="form-control" placeholder="Email"
                    AutoPostBack="true"></asp:TextBox>
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
          <asp:Button ID="btnforget" runat="server" Text="Submit" 
                class="btn btn-primary block full-width m-b" onclick="btnforget_Click" 
              />
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
