<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_personalInformation.aspx.cs" Inherits="apd_personalInformation"
    Title="PrimeDoc | Personal Information" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">
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
    if(document.getElementById("<%=rbtnGenderList.ClientID %>").selectIndex==0)
    {
        alert('Enter Gender');
        document.getElementById("<%=rbtnGenderList.ClientID %>").focus();
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
    if(document.getElementById("<%=txtaddress1.ClientID %>").value=="")
    {
        alert('Enter Address1');
        document.getElementById("<%=txtaddress1.ClientID %>").focus();
        return false;
    }
    if(document.getElementById("<%=txtaddress2.ClientID %>").value=="")
    {
        alert('Enter Address2');
        document.getElementById("<%=txtaddress2.ClientID %>").focus();
        return false;
    }
    if(document.getElementById("<%=txtpincode.ClientID %>").value=="")
    {
        var code=document.getElementById("<%=lblZipcode.ClientID %>").innerText;
        alert('Enter ' + code);
        document.getElementById("<%=txtpincode.ClientID %>").focus();
        return false;
    }

    if(document.getElementById("<%=tbcontact.ClientID %>").value=="")
    {
        alert('Enter Contact Number');
        document.getElementById("<%=tbcontact.ClientID %>").focus();
        return false;
    }


    if(document.getElementById("<%=txtpincode.ClientID %>").value!="")
    {
        var zipcode = document.getElementById("<%=txtpincode.ClientID %>").value;

        var code=document.getElementById("<%=lblZipcode.ClientID %>").innerText;
        var isValid;
        if(code == 'Pin code')
            isValid = /^[0-9]{6}?$/.test(zipcode);
        else
            isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(zipcode);

        if (!isValid)
        {
            alert('Invalid ' + code);
            document.getElementById("<%=txtpincode.ClientID %>").focus();
            return false;
        }
    }
    if(document.getElementById("<%=txtaddress1.ClientID %>").value!="")
    {
        var addr2 = document.getElementById("<%=txtaddress1.ClientID %>").value;
        var streetregex = /^[a-zA-Z0-9-\/] ?([a-zA-Z0-9-\/]|[a-zA-Z0-9-\/] )*[a-zA-Z0-9-\/]$/;
        if (! streetregex.test(addr2) ) 
        {
            alert('Please enter alphanumeric and -,/ only');
            document.getElementById("<%=txtaddress1.ClientID %>").focus();
            return false;
        } 
    }       
    if(document.getElementById("<%=txtaddress2.ClientID %>").value!="")
    {
        var addr2 = document.getElementById("<%=txtaddress2.ClientID %>").value;
        var streetregex = /^[a-zA-Z0-9-\/] ?([a-zA-Z0-9-\/]|[a-zA-Z0-9-\/] )*[a-zA-Z0-9-\/]$/;
        if (! streetregex.test(addr2) ) 
        {
            alert('Please enter alphanumeric and -,/ only');
            document.getElementById("<%=txtaddress2.ClientID %>").focus();
            return false;
        } 
    }
}

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
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
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    First Name</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbFirstName" runat="server" class="form-control"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="First Name should contain only alphabets. Please check."
                                        ControlToValidate="tbFirstName" Display="Dynamic" ValidationExpression="^[A-Za-z ]+$" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Last Name</label>
                                <div class="col-sm-10">
                                    <%--<input type="text" class="form-control">--%>
                                    <asp:TextBox ID="tbLastName" runat="server" class="form-control"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Last Name should contain only alphabets. Please check."
                                        ControlToValidate="tbLastName" Display="Dynamic" ValidationExpression="^[A-Za-z ]+$" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Gender</label>
                                <div class="col-sm-10">
                                    <div class="i-checks">
                                        <asp:RadioButtonList ID="rbtnGenderList" runat="server" RepeatDirection="Horizontal">
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
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
                                    <asp:ListBox ID="ddlLanguage" placeholder="Preferred Languages " runat="server" CssClass="form-control chosen-select"
                                        SelectionMode="Multiple"></asp:ListBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Country</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlcountry" runat="server" class="form-control m-b" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlcountry_SelectedIndexChanged">
                                        <%-- <asp:ListItem>China</asp:ListItem>
                                    <asp:ListItem>India</asp:ListItem>
                                    <asp:ListItem>USA</asp:ListItem>
                                    <asp:ListItem>Zimbabwe</asp:ListItem>--%>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    State</label>
                                <div class="col-sm-10">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="Server" UpdateMode="Always">
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlcountry" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlstate" runat="server" class="form-control m-b" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlstate_SelectedIndexChanged" />
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
                                            <asp:AsyncPostBackTrigger ControlID="ddlstate" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlcity" runat="server" class="form-control m-b" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Address Line 1</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtaddress1" runat="server" class="form-control"></asp:TextBox></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Address Line 2</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtaddress2" runat="server" class="form-control"> </asp:TextBox>
                                    <%--                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Address should allow alphanumeric, - and / only"
                                        ControlToValidate="txtaddress2" Display="Dynamic" ValidationExpression="/^[a-zA-Z0-9-\/] ?([a-zA-Z0-9-\/]|[a-zA-Z0-9-\/] )*[a-zA-Z0-9-\/]$/" />
--%>
                                </div>
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
                                    <asp:TextBox ID="txtpincode" runat="server" class="form-control" MaxLength="6"> </asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtpincode"
                                        runat="server" ErrorMessage="Pincode should contain only numbers. Please check."
                                        Display="Dynamic" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Contact Number</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbcontact" runat="server" class="form-control" MaxLength="13"> </asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="tbcontact"
                                        runat="server" ErrorMessage="Contact number should contain only numbers. Please check."
                                        ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Contact number should allow only 10 digits"
                                        ControlToValidate="tbcontact" Display="Dynamic" ValidationExpression="\d{10}" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- other details -->
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Other Details<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Mode</label>
                                <div class="col-sm-10">
                                    <div class="i-checks">
                                        <asp:RadioButtonList ID="rbnanonymous" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="0" Selected="True">Visible</asp:ListItem>
                                            <asp:ListItem Value="1">Anonymous</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                    <span class="help-block m-b-none">In VISIBLE MODE, the doctor can see your personal
                                        information like your name, city, etc.
                                        <br>
                                        In ANONYMOUS MODE, the doctor won't be able to see such data.</span>
                                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click"
                                        class="btn btn-primary pull-right" OnClientClick="return mandatory();" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
