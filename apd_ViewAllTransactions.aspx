<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_ViewAllTransactions.aspx.cs" Inherits="apd_ViewAllTransactions"
    Title="Prime Doc | View All Transcation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                View all transactions</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="apd_manageFunds.aspx">Account FundDetails</a></li>
                        <li class=""><a href="AddFundsToAccountt.aspx">Add Funds To Account</a></li>
                        <li class=""><a href="apd_RequestRefund.aspx">Request a Refund</a></li>
                        <li class="active"><a href="apd_ViewAllTransactions.aspx">View All Transactions</a></li>
                        <%--<li class=""><a href="apd_labResults.aspx">Lab Results</a></li>
                        <li class=""><a href="apd_radiology.aspx">Radiology</a></li>--%>
                    </ul>
                    <%--  <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="col-lg-12">
                                    <div class="ibox float-e-margins">
                                       <div class="ibox-title">
                       <h5>
                            Account Fund Details<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                    <div class="ibox float-e-margins">
                        <div class="ibox-content">
                            <div class="form-horizontal">
                                <%--<asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Visible="false" />--%>
                                <br />
                                <center>
                                    <div id="divGrid" visible="false" runat="server">
                                        <%-- style="overflow: scroll; width: 100%;
                                        height: 560px"--%>
                                        <asp:GridView ID="gvAllTransactions" runat="server" GridLines="None" AutoGenerateColumns="true"
                                            class='footable table table-stripped toggle-arrow-tiny' ShowHeader="true" ShowFooter="true"
                                            AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging">
                                            <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                                                PreviousPageText="<<" />
                                            <PagerStyle CssClass="pager-row" />
                                        </asp:GridView>
                                    </div>
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
