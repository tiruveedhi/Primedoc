<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Prime Doc | Login </title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="css/animate.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />

    <script type="text/javascript" src="https://apis.google.com/js/platform.js" async
        defer></script>

    <meta name="google-signin-scope" content="profile email" />
    <meta name="google-signin-client_id" content="662724156519-9qged5td9vmo4oi46b6l6reah7rm7i5j.apps.googleusercontent.com" />

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>

    <script type="text/javascript">
    
    var emailID = '';
    var name = '';
    var firstTime=true;
      function onSignIn(googleUser) {
      if(firstTime)
      {
          firstTime=false;
          return;
      }
        var profile = googleUser.getBasicProfile();
//        alert("ID: " + profile.getId()); // Don't send this directly to your server!
//        alert("Name: " + profile.getName());
//        alert("First Name: " +  profile.getGivenName());
//        alert("Last Name: " + profile.getFamilyName());
//        alert("Email: " + profile.getEmail());
        name =  profile.getName();
        emailID = profile.getEmail();
        // The ID token you need to pass to your backend:
        var id_token = googleUser.getAuthResponse().id_token;
        console.log("ID Token: " + id_token);
        CheckUserRegistration();
      };
   
    function CheckUserRegistration() {
        $.ajax({
            type: "POST",
            url: "register.aspx/checkUserRegistration",
            data : '{email:"'+ emailID +'",name:"'+ name +'"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,
            failure: function(response) {
                alert(response.d);
            }
        });
    }
    function OnSuccess(response) {
//        alert(response.d);
        window.location = "apd_home.aspx";
    }
    </script>

    <script type="text/javascript">
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into Facebook.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '660310954105657',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.2' // use version 2.2
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.

  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
      document.getElementById('status').innerHTML =
        'Thanks for logging in, ' + response.name + '!';
    });
  }
function logout()
{
  FB.logout(function(response) {
    // user is now logged out
  });
}
    </script>

</head>
<body class="gray-bg">
    
    <form runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="loginColumns animated fadeInDown">
        <div class="row">
            <div class="col-md-6">
                <h2 class="font-bold">
                    Welcome to Prime Doc</h2>
                <p>
                    Bacon ipsum dolor amet eiusmod occaecat ad salami meatball nisi. Velit proident
                    sint picanha. Minim corned beef ut id meatball ham aliqua ad cillum venison swine
                    eiusmod.
                </p>
                <p>
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem
                    Ipsum has been the industry's standard dummy text ever since the 1500s.
                </p>
                <p>
                    officia shankle, pancetta consectetur in porchetta short ribs ut veniam est. Pariatur
                    enim drumstick capicola pork belly meatloaf picanha anim corned beef esse. Drumstick
                    laboris pork meatloaf chicken corned beef ham hock.
                </p>
                <p>
                    <small>Jowl commodo alcatra tongue. Short loin filet mignon in ball tip jerky, rump
                        prosciutto jowl alcatra ea et qui ut eu sirloin. Bresaola eu </small>
                </p>
            </div>
            <div class="col-md-6" style="margin-top: 20px;">
                <div class="ibox-content">
                    <form class="m-t" role="form" action="#">
                    <div class="form-group">
                        <asp:TextBox ID="tbUsername" runat="server" class="form-control" placeholder="Username"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="tbPassword" runat="server" class="form-control" placeholder="Password"
                            TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:DropDownList ID="ddlUserType" runat="server" Width="200px" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlUserType_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login" class="btn btn-primary block full-width m-b"
                        OnClick="btnLogin_Click" />
                    <a href="#"><small>
                        <asp:LinkButton ID="link_forget" runat="server" Text="Forgot password?" OnClick="link_forget_Click"></asp:LinkButton></small>
                    </a>
                    <p class="text-muted text-center">
                        <small>Do not have an account?</small>
                    </p>
                    <a class="btn btn-sm btn-white btn-block" href="register.aspx">Create an account</a>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="Server" UpdateMode="Always">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlUserType" EventName="SelectedIndexChanged" />
                        </Triggers>
                        <ContentTemplate>
                            <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark" id="divGmailAccount"
                                runat="server">
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <%--<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
                    </fb:login-button>
                    <button onclick="logout();">
                        Logout</button>--%>
                    <div id="status">
                    </div>
                    </form>
                    <div id="checkusername" runat="server" visible="false">
                        <asp:Label ID="lblStatus" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-6">
                <strong>Copyright</strong> Prime Doc <small>&copy; 2015 - 2020</small>
            </div>
            <div class="col-md-6 text-right">
            </div>
        </div>
    </div>
    </form>
</body>
</html>
