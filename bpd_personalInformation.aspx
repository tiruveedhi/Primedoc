<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_personalInformation.aspx.cs" Inherits="bpd_personalInformation"
    Title="PrimeDoc | Personal Information" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .test .ajax__calendar_body
        {
            width: 500px;
        }
    </style>

    <script type="text/javascript">
    
    function mandatory()
    {
        if(document.getElementById("<%=tbFirstName.ClientID %>").value=="")
        {
            alert('Enter FirstName');
            document.getElementById("<%=tbFirstName.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=tbLastName.ClientID %>").value=="")
        {
            alert('Enter LastName');
            document.getElementById("<%=tbLastName.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=rbtnGender.ClientID %>").selectIndex==0)
        {
            alert('Enter Gender');
            document.getElementById("<%=rbtnGender.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=tbDob.ClientID %>").value=="")
        {
            alert('Enter Dob');
            document.getElementById("<%=tbDob.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=ddlLanguage.ClientID %>").value=="")
        {
            alert('Select Language');
            document.getElementById("<%=ddlLanguage.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=tbAddress1.ClientID %>").value=="")
        {
            alert('Enter Address1');
            document.getElementById("<%=tbAddress1.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=tbAddress2.ClientID %>").value=="")
        {
            alert('Enter Address2');
            document.getElementById("<%=tbAddress2.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=tbPincode.ClientID %>").value=="")
        {
            var code=document.getElementById("ctl00_ContentPlaceHolder1_lblZipcode").innerHTML;
            alert('Enter ' + code);
            document.getElementById("<%=tbPincode.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=tbcontact.ClientID %>").value=="")
        {
            alert('Enter Contact Number');
            document.getElementById("<%=tbcontact.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=tbPincode.ClientID %>").value!="")
        {
            var zipcode = document.getElementById("<%=tbPincode.ClientID %>").value;
            var code=document.getElementById("ctl00_ContentPlaceHolder1_lblZipcode").innerHTML;
            var isValid;
            if(code == 'Pin code')
            isValid = /^[0-9]{6}?$/.test(zipcode);
            else
            isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(zipcode);

            if (!isValid)
            {
                alert('Invalid '+ code);
                document.getElementById("<%=tbPincode.ClientID %>").focus();
                return false;
            }
       }
       if(document.getElementById("<%=tbAddress1.ClientID %>").value!="")
       {
            var addr2 = document.getElementById("<%=tbAddress1.ClientID %>").value;
            var streetregex = /^[a-zA-Z0-9-\/] ?([a-zA-Z0-9-\/]|[a-zA-Z0-9-\/] )*[a-zA-Z0-9-\/]$/;
            if (! streetregex.test(addr2) ) 
            {
               alert('Please enter alphanumeric and -,/ only');
               document.getElementById("<%=tbAddress1.ClientID %>").focus();
               return false;
            } 
            
       }       
       if(document.getElementById("<%=tbAddress2.ClientID %>").value!="")
       {
            var addr2 = document.getElementById("<%=tbAddress2.ClientID %>").value;
            var streetregex = /^[a-zA-Z0-9-\/] ?([a-zA-Z0-9-\/]|[a-zA-Z0-9-\/] )*[a-zA-Z0-9-\/]$/;
            if (! streetregex.test(addr2) ) 
            {
               alert('Please enter alphanumeric and -,/ only');
               document.getElementById("<%=tbAddress2.ClientID %>").focus();
               return false;
            } 
            
       }

  }
    
    
   
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ajax:ToolkitScriptManager ID="toolkit1" runat="server">
    </ajax:ToolkitScriptManager>
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Personal Information</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Personal Details<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Email ID</label>
                                <div class="col-sm-10 control-label">
                                    <asp:Label ID="tbEmail" runat="server" CssClass="pull-left"></asp:Label>
                                </div>
                            </div>
                            <div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    First Name</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbFirstName" runat="server" class="form-control"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="First Name should contain only alphabets. Please check."
                                        ControlToValidate="tbFirstName" Display="Dynamic" ValidationExpression="^[A-Za-z ]+$" />
                                </div>
                            </div>
                            <div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Last Name</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbLastName" runat="server" class="form-control"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Last Name should contain only alphabets. Please check."
                                        ControlToValidate="tbLastName" Display="Dynamic" ValidationExpression="^[A-Za-z ]+$" />
                                </div>
                            </div>
                            <div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Gender</label>
                                <div class="col-sm-10">
                                    <div class="i-checks">
                                        <i></i>
                                        <asp:RadioButtonList ID="rbtnGender" runat="server" RepeatDirection="Horizontal">
                                            <%--Enabled="False" EnableTheming="False"--%>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>
                            <div>
                            </div>
                            <div class="form-group" id="data_1">
                                <label class="col-sm-2 control-label">
                                    Date Of Birth<br />
                                    <small style="text-decoration: none;"></small>
                                </label>
                                <div class="col-sm-10">
                                    <div class="input-group date">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        <asp:TextBox ID="tbDob" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                    <%-- placeholder="dd/MM/yyyy"--%>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Preferred Language(s)</label>
                                <div class="col-sm-10">
                                    <%--<asp:ListBox ID="ddlLanguage" placeholder="Preferred Languages " runat="server" CssClass="form-contorl chosen-select"
                                        SelectionMode="Multiple"></asp:ListBox>--%>
                                    <asp:ListBox ID="ddlLanguage" placeholder="Preferred Languages " runat="server" CssClass="form-control chosen-select"
                                        SelectionMode="Multiple"></asp:ListBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end of personal details -->
        <!-- Demographics -->
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Address<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <%--<form method="get" class="form-horizontal">--%>
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Country</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlCountry" runat="server" class="form-control m-b" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    State</label>
                                <div class="col-sm-10">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="Server" UpdateMode="Always">
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlState" runat="server" class="form-control m-b" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    City</label>
                                <div class="col-sm-10">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="Server" UpdateMode="Always">
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlState" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlCity" runat="server" class="form-control m-b">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Address Line 1</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbAddress1" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Address Line 2</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbAddress2" runat="server" class="form-control"></asp:TextBox>
<%--                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="Address should be alphanumeric"
                                        ControlToValidate="tbAddress2" Display="Dynamic" ValidationExpression="/^[a-zA-Z0-9-\/] ?([a-zA-Z0-9-\/]|[a-zA-Z0-9-\/] )*[a-zA-Z0-9-\/]$/" />
--%>                                </div>
                            </div>
                            <div class="form-group">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="Server" UpdateMode="Always">
                                    <ContentTemplate>
                                        <label class="col-sm-2 control-label">
                                            <asp:Label ID="lblZipcode" runat="server" Width="100px" Text="Zip code"></asp:Label>
                                        </label>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbPincode" runat="server" class="form-control" onBlur="return Zipcode();"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="tbPincode"
                                        runat="server" ErrorMessage="Pincode should contain only numbers. Please check."
                                        Display="Dynamic" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Contact Number</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbcontact" runat="server" class="form-control" MaxLength="13"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="tbcontact"
                                        runat="server" ErrorMessage="Contact number should contain only numbers. Please check."
                                        ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Contact number should allow only 10 digits"
                                        ControlToValidate="tbcontact" Display="Dynamic" ValidationExpression="\d{10}" />
                                </div>
                            </div>
                            <center>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                                    class="btn btn-rounded btn-info" OnClientClick="return mandatory();" /></center>
                        </div>
                        <%-- </form>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
