<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="panellist.aspx.cs" Inherits="panellist" Title="Untitled Page" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
   
    <script type="text/javascript" src="rating.js"></script>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Consultation details</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <ajax:ToolkitScriptManager ID="ScripManager1" runat="server" />
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
                            <%--</br>
                            <div>
                                Comments:&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lbltxt" runat="server"></asp:Label>
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
                             <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Contact Number</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lbl_contact" runat="server" Text=""></asp:Label>
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
        <div class="row" id="divMessages" runat="server" visible="false">
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
                                    <%--<Columns>
                                    <asp:BoundField DataField="CNS_MESSAGE" HeaderText="Message" />
                                    <asp:BoundField DataField="CNV_CONVDESC" HeaderText="conversations" />
                                    </Columns>--%>
                                </asp:GridView>
                            </center>
                            <div class="form-group" id="divAcitveInfo" runat="server">
                                <asp:Label ID="lblInfo" runat="server" Text="Send reply to Doctor" class="col-sm-2 control-label"
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
                            <asp:Label ID="lblSecOpinionAnswer" runat="server" Text=""></asp:Label>
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
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtcomment" runat="server" Text="" TextMode="MultiLine" Width="300px"></asp:TextBox>
                                        </td>
                                        <td>
                                            <ajax:Rating ID="ratingControl" AutoPostBack="true" runat="server" StarCssClass="ratingEmpty"
                                                WaitingStarCssClass="ratingSaved" EmptyStarCssClass="ratingEmpty" FilledStarCssClass="ratingFilled">
                                            </ajax:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br />
                                            <asp:Button ID="btnRating" runat="server" Text="Give Rating" class="btn btn-rounded btn-info"
                                                OnClick="btnRating_Click" />
                                        </td>
                                    </tr>
                                </table>
                                <%--</br>
                            <div>
                                Comments:&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lbltxt" runat="server"></asp:Label>
                            </div>--%>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <center>
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-rounded btn-info"
                OnClick="btnCancel_Click" Visible="false" />
        </center>
        <br />
    </div>
</asp:Content>

