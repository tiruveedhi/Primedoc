<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_startSecondOpinion.aspx.cs" Inherits="bpd_startSecondOpinion" Title="PrimeDoc | Second Opinion Video Consultation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Consultations</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="bpd_consultationActive.aspx">Active</a></li>
                        <li class=""><a href="bpd_consultationCompleted.aspx">Completed</a></li>
                        <li class="active"><a href="bpd_startSecondOpinion.aspx">Scheduled Consultations</a></li>
                        <li class=""><a href="bpd_consultationCancelled.aspx">Cancelled</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <div style="height: 520px; overflow: auto">
                                            <asp:GridView ID="gvPatSecondOpinion" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging">
                                                <Columns>
                                                    <%--<asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblId" runat="server" Text='<%#Eval("ST_SCHID") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                                    <asp:BoundField DataField="ST_SCHID" HeaderText="SCHID" />
                                                    <asp:BoundField DataField="CNS_PATID" HeaderText="Patient Id" />
                                                    <asp:BoundField DataField="ST_SCHED_DATE" HeaderText="Scheduled Date" />
                                                    <asp:BoundField DataField="ST_SCHED_TIME" HeaderText="Scheduled Time" />
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnjoin" runat="server" Text="Join Meeting" class="btn-sm btn-primary m-t-n-xs"
                                                                OnClick="btnjoin_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                                                    PreviousPageText="<<" />
                                                <PagerStyle CssClass="pager-row" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
