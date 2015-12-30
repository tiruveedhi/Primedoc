<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_closeticket.aspx.cs" Inherits="apd_closeticket" Title="PrimeDoc | Close tickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Close tickets</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="contactSupport.aspx">New ticket</a></li>
                        <li class=""><a href="apd_openticket.aspx">Open tickets</a></li>
                        <li class="active"><a href="apd_closeticket.aspx">Close tickets</a></li>
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
                                                    <asp:GridView ID="gvClosedTickets" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                        class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging">
                                                        <Columns>
                                                            <asp:BoundField DataField="TICKET_DESC" HeaderText="Ticket Type " />
                                                            <asp:BoundField DataField="TICKET_OTHER" HeaderText="Description" />
                                                            <asp:BoundField DataField="TICKET_REMARKS" HeaderText="Remarks" />
                                                        </Columns>
                                                        <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                                                            PreviousPageText="<<" />
                                                        <PagerStyle CssClass="pager-row" />
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
</asp:Content>
