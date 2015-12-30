<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="cpd_manageUsers.aspx.cs" Inherits="cpd_manageUsers" Title="PrimeDoc| ManageUsers " %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--
    <script type="text/javascript">
            function Confirm() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Do you want to save data?")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
    </script>--%>
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        .modalBackground
        {
            background-color: Black;
            filter: alpha(opacity=40);
            opacity: 0.4;
        }
        .modalPopup
        {
            background-color: #FFFFFF;
            width: 300px;
            border: 3px solid #0DA9D0;
        }
        .modalPopup .header
        {
            background-color: #2FBDF1;
            height: 30px;
            color: White;
            line-height: 30px;
            text-align: center;
            font-weight: bold;
        }
        .modalPopup .body
        {
            min-height: 80px;
            line-height: 50px;
            text-align: center;
            font-weight: bold;
        }
        .modalPopup .footer
        {
            padding: 1px;
        }
        .modalPopup .yes, .modalPopup .no
        {
            height: 10px;
            color: White;
            line-height: 23px;
            text-align: center;
            font-weight: bold;
            cursor: pointer;
        }
        .modalPopup .yes
        {
            background-color: #2FBDF1;
            border: 1px solid #0DA9D0;
        }
        .modalPopup .done
        {
            background-color: #2FBDF1;
            border: 1px solid #0DA9D0;
        }
        .modalPopup .no
        {
            background-color: #9F9F9F;
            border: 1px solid #5C5C5C;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel runat="server" ID="UPanel">
        <ContentTemplate>
            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <h2>
                        Existing Users</h2>
                </div>
                <div class="col-lg-2">
                </div>
            </div>
            <div class="wrapper wrapper-content animated fadeInRight ecommerce" style="padding-right: 0px !important;">
                <div class="ibox-content m-b-sm border-bottom">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label" for="product_name">
                                    patient Name</label>
                                <asp:TextBox ID="txtpatient" runat="server" placeholder="Patient Name" class="form-control"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="validateDoctorNameLength" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                                    ControlToValidate="txtpatient" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" /></div>
                        </div>
                        <div class="col-sm-3">
                            <label class="control-label" for="status">
                                Gender</label>
                            <asp:DropDownList ID="ddlGenderList" runat="server" class="form-control">
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label" for="quantity">
                                    Location</label>
                                <asp:TextBox ID="txtlocation" runat="server" class="form-control" placeholder="Location"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="validateLocationLength" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                                    ControlToValidate="txtlocation" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label" for="status">
                                    Language</label>
                                <asp:DropDownList ID="ddllanuage" runat="server" class="form-control">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-3 pull-right">
                            <div class="form-group">
                                <asp:Button ID="btnSearch" class="btn btn-success btn-rounded" Style="width: 100%;"
                                    runat="server" Text="Search" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="ibox">
                                            <%--<div style="height: 520px; overflow: auto">--%>
                                            <asp:GridView ID="gvSearch" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging"
                                                OnRowDataBound="gvSearch_RowDataBound">
                                                <Columns>
                                                    <asp:BoundField DataField="PAT_PATID" HeaderText="PAT_PATID" />
                                                    <asp:BoundField DataField="PAT_FIRSTNAME" HeaderText="PatientName" />
                                                    <asp:BoundField DataField="GND_GENDER" HeaderText="Gender" />
                                                    <asp:BoundField DataField="DST_DISTRICTNAME" HeaderText="Location" />
                                                    <asp:TemplateField> 
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnSuspend" runat="server" Text='<%# Eval("Status") %>' OnClick="btnSuspend_Click"
                                                                class="btn btn-sm btn-primary m-t-n-xs" PostBackUrl="" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                                                    PreviousPageText="<<" />
                                                <PagerStyle CssClass="pager-row" />
                                            </asp:GridView>
                                            <%-- </div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
            </asp:ToolkitScriptManager>
            <asp:Button ID="btnSuspend" runat="server" Style="display: none" />
            <asp:ModalPopupExtender ID="btnSuspend_modalpopupextender" PopupControlID="pnlSuspend"
                runat="server" TargetControlID="btnSuspend" BackgroundCssClass="Background" CancelControlID="btnSuspendCancel">
            </asp:ModalPopupExtender>
            <asp:Panel ID="pnlSuspend" runat="server" CssClass="modalPopup" Style="display: none">
                <div class="body">
                    Reason :
                    <asp:TextBox ID="tbReason" runat="server" Height="20px"></asp:TextBox>
                </div>
                <div class="footer" align="right">
                    <asp:Button ID="btnDone" runat="server" Text="Done" OnClick="btnDone_Click" />
                    <asp:Button ID="btnSuspendCancel" runat="server" Text="Cancel" />
                    <asp:Label ID="lblPatientId" runat="server" Text="" Visible="false" />
                </div>
            </asp:Panel>
            <asp:Button ID="btnActive" runat="server" Style="display: none" />
            <asp:ModalPopupExtender ID="btnActive_ModalPopupExtender" PopupControlID="pnlActive"
                runat="server" TargetControlID="btnActive" BackgroundCssClass="Background" CancelControlID="btnNo">
            </asp:ModalPopupExtender>
            <asp:Panel ID="pnlActive" runat="server" CssClass="modalPopup" Style="display: none">
                <div class="header">
                    Confirmation
                </div>
                <div class="body">
                    Do you want to activate the Patient?
                </div>
                <div class="footer" align="right">
                    <asp:Button ID="btnYes" runat="server" Text="Yes" OnClick="btnYes_Click" />
                    <asp:Button ID="btnNo" runat="server" Text="No" />
                </div>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvSearch" />
            <asp:AsyncPostBackTrigger ControlID="btnDone" />
            <asp:AsyncPostBackTrigger ControlID="btnYes" />
            <asp:AsyncPostBackTrigger ControlID="btnNo" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
