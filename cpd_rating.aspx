<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="cpd_rating.aspx.cs" Inherits="cpd_rating" Title="Untitled Page" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  <asp:UpdatePanel runat="server" ID="UPanel">
        <ContentTemplate>
            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <h2>
                      Active</h2>
                </div>
                <div class="col-lg-2">
                </div>
            </div>
            <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="tabs-container">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="cpd_rating.aspx">Active</a></li>
                                <li class=""><a href="cpd_ratingclose.aspx">Close</a></li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active">
                                    <div class="panel-body">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="ibox">
                                                            <%--<div style="height: 520px; overflow: auto">--%>
                                                            <asp:GridView ID="gvrating" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" 
                                                                onpageindexchanging="gvrating_PageIndexChanging" > 
                                              
                                                <Columns>
                                               
                                                    <%--<asp:BoundField DataField="DOC_PROF_BIO" HeaderText="Description" />--%>
                                                    <asp:BoundField DataField="ID" />
                                                   <asp:BoundField DataField="PAT_ID" HeaderText="Patientid" />
                                                    <asp:BoundField DataField="DOC_ID" HeaderText="Doctorid" />
                                                    <asp:BoundField DataField="CONSULT_ID" HeaderText="Consultationid" />
                                                    <asp:BoundField DataField="COMMENT" HeaderText="Comment" />
                                                    
                                                     <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btndeatils" CommandName="More" runat="server" Text="View Details"
                                                               class="btn btn-sm btn-primary m-t-n-xs" OnClick="btndeatils_Click"  />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                 
                                                    <asp:TemplateField HeaderText="Remarks">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnremarks" CommandName="More" runat="server" Text="Remarks"
                                                               class="btn btn-sm btn-primary m-t-n-xs" OnClick="btnremarks_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                                            <%--</div>--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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
            <asp:Button ID="btnremarks" runat="server" Style="display: none" />
            <asp:ModalPopupExtender ID="btnremarks_modalpopupextender" PopupControlID="pnlClose"
                runat="server" TargetControlID="btnremarks" BackgroundCssClass="Background" >
            </asp:ModalPopupExtender>
            <asp:Panel ID="pnlClose" runat="server" CssClass="modalPopup" Style="display: none">
                <div class="body">
                    Remarks :
                    <asp:TextBox ID="tbRemarks" runat="server" Height="20px"></asp:TextBox>
                </div>
                <div class="footer" align="right">
                    <asp:Button ID="btnDone" runat="server" Text="Done" OnClick="btnDone_Click" />
               <%--   <asp:Button ID="btnCancel" runat="server" Text="Cancel" />--%>
                    <asp:Label ID="lblratingid" runat="server" Text="" Visible="false" />
                    <asp:Label ID="lblUserId" runat="server" Text="" Visible="false" />
                    <asp:Label ID="lblUserTypeId" runat="server" Text="" Visible="false" />
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

