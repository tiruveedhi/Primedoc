<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_consultationCancelled.aspx.cs" Inherits="apd_consultationCancelled"
    Title="PrimeDoc | Consultation" %>

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
                        <li class=""><a href="apd_consultationActive.aspx">Active</a></li>
                        <li class=""><a href="apd_consultationCompleted.aspx">Completed</a></li>
                        <li class="active"><a href="apd_consultationCancelled.aspx">Cancelled</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <%--<div style="height: 520px; overflow: auto">--%>
                                        <asp:GridView ID="gvConslCancelled" runat="server" GridLines="None" AutoGenerateColumns="false"
                                            class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging"
                                            OnRowDataBound="gvConslCancelled_RowDataBound">
                                            <Columns>
                                                <asp:BoundField DataField="CNS_CONSULTID" HeaderText="Consultation Id" />
                                                <asp:BoundField DataField="Doctor Id" HeaderText="Doctor Id" />
                                                <asp:BoundField DataField="Doctor Name" HeaderText="Doctor Name" />
                                                <asp:BoundField DataField="Consultation status" HeaderText="Consultation status" />
                                                <asp:BoundField DataField="Consultation Mode" HeaderText="Consultation Mode" />
                                                <asp:BoundField DataField="SPECIALITY" HeaderText="Doctor Speciality" />
                                                <%--<asp:BoundField DataField="CNS_MESSAGE" HeaderText="Message" />--%>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnViewDetails" CommandName="More" runat="server" Text="View details"
                                                            OnClick="btnViewDetails_Click" class="btn btn-sm btn-primary m-t-n-xs" />
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
</asp:Content>
