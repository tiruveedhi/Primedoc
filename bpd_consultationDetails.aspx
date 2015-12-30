<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_consultationDetails.aspx.cs" Inherits="bpd_consultationDetails"
    Title="PrimeDoc | Consultation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
function DisplayFullImage(ctrlimg) 
    { 
        txtCode = "<HTML><HEAD>" 
        +  "</HEAD><BODY TOPMARGIN=0 LEFTMARGIN=0 MARGINHEIGHT=0 MARGINWIDTH=0><CENTER>"   
        + "<IMG src='" + ctrlimg.src + "' BORDER=0 NAME=FullImage " 
        + "onload='window.resizeTo(document.FullImage.width,document.FullImage.height)'>"  
        + "</CENTER>"   
        + "</BODY></HTML>"; 
        mywindow= window.open  ('','image',  'toolbar=0,location=0,menuBar=0,scrollbars=0,resizable=0,width=1,height=1,left=120,top=120'); 
        mywindow.document.open(); 
        mywindow.document.write(txtCode); 
        mywindow.document.close();
    }
    </script>

    <link rel="stylesheet" type="text/css" href="rating.css" />
    <style type="text/css">
        .ratingEmpty
        {
            background-image: url(img/ratingStarEmpty.gif);
            width: 18px;
            height: 18px;
        }
        .ratingFilled
        {
            background-image: url(img/ratingStarFilled.gif);
            width: 18px;
            height: 18px;
        }
        .ratingSaved
        {
            background-image: url(img/ratingStarSaved.gif);
            width: 18px;
            height: 18px;
        }
        .popup
        {
            overflow: auto;
            height: 500px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Consultation details</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <asp:ToolkitScriptManager ID="ScripManager1" runat="server" />
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
                        <div class="form-horizontal" runat="server" visible="false" id="divAnonymous">
                            <div class="col-sm-10">
                                <label class="col-sm-2 control-label">
                                </label>
                                <div class="col-sm-10">
                                    Patient selected anonymous mode
                                </div>
                            </div>
                        </div>
                        <div class="form-horizontal" runat="server" visible="false" id="divPersonalDtls">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    First Name</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblFirstName" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <%--<div class="hr-line-dashed">
                            </div>--%>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Last Name</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblLastName" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <%--<div class="hr-line-dashed">
                            </div>--%>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Gender</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblGender" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <%--<div class="hr-line-dashed">
                            </div>--%>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Date Of Birth</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblDOB" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <%--<div class="hr-line-dashed">
                            </div>--%>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Preferred Language(s)</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblLanguage" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <%--<div class="hr-line-dashed">
                            </div>--%>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Country</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblCountry" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    State</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblState" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    City</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblCity" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Address Line 1</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblAddress1" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Address Line 2</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblAddress2" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Pin Code</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblPincode" runat="server" Text=""></asp:Label>
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
                            Medical records<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Life style</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblLifeStyle" runat="server" Text=""></asp:Label>
                                </div>
                                <div>
                                    <asp:Panel ID="pnllifestyle" runat="server">
                                    </asp:Panel>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Health problem</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblHealthProb" runat="server" Text=""></asp:Label>
                                </div>
                                <div>
                                    <asp:Panel ID="pnlHealth" runat="server">
                                    </asp:Panel>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Medication</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblMedication" runat="server" Text=""></asp:Label>
                                </div>
                                <div>
                                    <asp:Panel ID="pnlMedication" runat="server">
                                    </asp:Panel>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Lab results</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblLabResults" runat="server" Text=""></asp:Label>
                                </div>
                                <div>
                                    <asp:Panel ID="pnlLabresults" runat="server">
                                    </asp:Panel>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Allergies</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblAllergies" runat="server" Text=""></asp:Label>
                                </div>
                                <asp:Panel ID="pnlAllergies" runat="server">
                                </asp:Panel>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Radiology</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblRadiology" runat="server" Text=""></asp:Label>
                                </div>
                                <div>
                                    <asp:Panel ID="pnlRadiology" runat="server">
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" id="divMessage" visible="false" runat="server">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Messages<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <center>
                                <asp:GridView ID="gvConversation" runat="server" Visible="false" GridLines="None"
                                    class='footable table table-stripped toggle-arrow-tiny' ShowHeader="false" ShowFooter="true">
                                </asp:GridView>
                            </center>
                            <div class="form-group" id="divAcitveInfo" runat="server">
                                <asp:Label ID="lblInfo" runat="server" Text="Send Message to Patient" class="col-sm-2 control-label"
                                    Font-Bold="true">
                                </asp:Label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbInfo" runat="server" TextMode="MultiLine" Width="300px"></asp:TextBox>
                                </div>
                            </div>
                            <center>
                                <asp:Button ID="btnSubmitInfo" runat="server" Text="Submit" class="btn btn-rounded btn-info"
                                    OnClick="btnSubmitInfo_Click" />
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" id="divSecOpinion" visible="false" runat="server">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Second opinion<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <asp:Label ID="lblOpinion" runat="server" Text="" Visible="false"></asp:Label>
                            <div class="form-group" id="divAcitveOpinion" runat="server">
                                <asp:Label ID="lblSecOpinion" runat="server" Text="Your second opinion" class="col-sm-2 control-label"
                                    Font-Bold="true">
                                </asp:Label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbSecOpinion" runat="server" TextMode="MultiLine" Width="300px"></asp:TextBox>
                                </div>
                            </div>
                            <div>
                                <asp:Panel ID="pnlSPFiles" runat="server">
                                </asp:Panel>
                            </div>
                            <div id="divUploadFile" runat="server" visible="true">
                                <div id="secOpi-dropzone" class="dropzone" action="#">
                                    <div class="dropzone-previews">
                                    </div>
                                </div>
                            </div>
                            <center>
                                <asp:Button ID="btnSubmitClose" runat="server" Text="Submit" class="btn btn-rounded btn-info"
                                    OnClick="btnSubmitClose_Click" />
                            </center>
                        </div>
                    </div>
                    <div class="hr-line-dashed">
                    </div>
                </div>
            </div>
        </div>
        <div class="row" id="divComments" visible="false" runat="server">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Feedback<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <center>
                                <asp:TextBox ID="txtcomment" runat="server" Text="" TextMode="MultiLine" Width="300px"
                                    ReadOnly="True"></asp:TextBox>
                            </center>
                            <div>
                                <asp:Rating ID="ratingControl" AutoPostBack="true" OnChanged="RatingControlChanged"
                                    runat="server" StarCssClass="ratingEmpty" WaitingStarCssClass="ratingSaved" EmptyStarCssClass="ratingEmpty"
                                    FilledStarCssClass="ratingFilled" ReadOnly="true">
                                </asp:Rating>
                            </div>
                            <%-- </br>
                           <div>
                            Comments:&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lbltxt" runat="server"></asp:Label>
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" id="referring_doctor" runat="server" visible="false">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Select Referred Docotor<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">
                                Referred Doctor</label>
                            <div class="col-sm-10">
                                <asp:Label ID="lblreffering" runat="server" Text=""></asp:Label>
                            </div>
                            <asp:Panel ID="Panel1" runat="server">
                            </asp:Panel>
                        </div>
                        <center>
                            <asp:Button ID="btnReferringDoc" runat="server" Text="Select" class="btn btn-rounded btn-info" />
                            <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" DynamicServicePath=""
                                Enabled="True" PopupControlID="pnlRefDoc" TargetControlID="btnReferringDoc" CancelControlID="btnRefCancel"
                                BackgroundCssClass="modalBackground">
                            </asp:ModalPopupExtender>
                        </center>
                        <center>
                        </center>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:Panel runat="server" ID="pnlRefDoc" BackColor="White" BorderStyle="Solid" BorderWidth="5px"
        BorderColor="#38ABC8" Width="80%" Height="80%" Style="display: none; border-radius: 5px;
        -moz-border-radius: 5px; -webkit-border-radius: 5px; padding: 50px;" CssClass="popup">
        <div class="row" runat="server" style="max-height: 500px; overflow: auto;">
            <div class="col-sm-3">
                <div class="form-group">
                    <label class="control-label" for="product_name">
                        Doctor Name</label>
                    <asp:TextBox ID="txt_doctor" runat="server" placeholder="Doctor Name" class="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                        ControlToValidate="txt_doctor" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class="control-label" for="price">
                        Specialization</label>
                    <asp:DropDownList ID="ddlSpeciality" runat="server" class="form-control m-b" placeholder="Specialization">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class="control-label" for="quantity">
                        Location</label>
                    <asp:TextBox ID="txt_location" runat="server" class="form-control" placeholder="Location"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                        ControlToValidate="txt_location" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class="control-label" for="status">
                        Language</label>
                    <asp:DropDownList ID="ddl_lanuage" runat="server" class="form-control">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class="control-label" for="status">
                        Gender</label>
                    <asp:DropDownList ID="ddl_gender" runat="server" class="form-control">
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-3 pull-right">
                <div class="form-group">
                    <asp:Button ID="btn_search" class="btn btn-success btn-rounded" Style="width: 100%;"
                        runat="server" Text="Search" OnClick="btn_search_Click" />
                </div>
            </div>
        </div>
        <div>
            <asp:GridView ID="gvReferringDoc" runat="server" GridLines="None" AutoGenerateColumns="false"
                class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" onclick="javascript:checkRefDoc();" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DOC_DOCID" HeaderText="Doc_ID" />
                    <asp:BoundField DataField="DoctorName" HeaderText="DoctorName" />
                    <asp:BoundField DataField="SPE_SPECIALTY" HeaderText="Specialization" />
                    <asp:BoundField DataField="DOC_PROF_BIO" HeaderText="Description" />
                </Columns>
                <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                    PreviousPageText="<<" />
                <PagerStyle CssClass="pager-row" />
            </asp:GridView>
        </div>
        <asp:Button ID="btnSelRefDoc" runat="server" Text="Select Referring Doctor" class="btn btn-sm btn-primary m-t-n-xs"
            OnClick="GetSelectedRefDoc" />
        <asp:Button ID="btnRefCancel" runat="server" Text="Cancel" class="btn btn-sm btn-primary m-t-n-xs" />
    </asp:Panel>
</asp:Content>
