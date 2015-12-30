<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="readMessages.aspx.cs" Inherits="readMessages" Title="PrimeDoc | Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--paging style--%>
    <style type="text/css">
        /* Data Pager Styles */tr.pager-row td
        {
            border-top: solid 2px #bbd9ee;
        }
        .pager
        {
            font-family: arial,sans-serif;
            text-align: center;
            padding: 6px;
            font-size: 18px;
        }
        .pager span.command, .pager span.current, .pager a.command, tr.pager-row td a
        {
            color: #5a90ce;
            padding: 0px 5px;
            text-decoration: none;
            border: none;
        }
        .pager a.command:hover, tr.pager-row td a:hover
        {
            border: solid 2px #408BB6;
            background-color: #59A5D1;
            color: #fff;
            padding: 0px 3px;
            text-decoration: none;
        }
        .pager span.current, tr.pager-row td span
        {
            border: solid 2px #3c3c3c;
            background-color: #3e3e3e;
            color: #fff;
            font-weight: bold;
            padding: 0px 6px;
        }
        tr.pager-row td
        {
            border-top: none;
            text-align: center;
        }
        tr.pager-row table
        {
            height: 35px;
            margin: 0 auto 0 auto;
        }
    </style>
    <%--end of paging style--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Messages</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="newMessages.aspx">New</a></li>
                        <li class="active"><a href="readMessages.aspx">Read</a></li>
                        <li class=""><a href="deleteMessages.aspx">Deleted</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="ibox-content">
                                    <div class="form-horizontal">
                                        <asp:GridView ID="gvReadMessages" runat="server" GridLines="None" AutoGenerateColumns="false"
                                            class='footable table table-stripped toggle-arrow-tiny' DataKeyNames="MSG_MSGID"
                                            AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging">
                                            <Columns>
                                                <asp:BoundField DataField="MSG_MESSAGE" HeaderText="Message" />
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
