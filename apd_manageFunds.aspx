<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_manageFunds.aspx.cs" Inherits="apd_manageFunds" Title="PrimeDoc | Manage Funds" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Manage Funds</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="apd_manageFunds.aspx">Account FundDetails</a></li>
                        <li class=""><a href="AddFundsToAccountt.aspx">Add Funds To Account</a></li>
                        <li class=""><a href="apd_RequestRefund.aspx">Request a Refund</a></li>
                        <li class=""><a href="apd_ViewAllTransactions.aspx">View All Transactions</a></li>
                        <%--<li class=""><a href="apd_labResults.aspx">Lab Results</a></li>
                        <li class=""><a href="apd_radiology.aspx">Radiology</a></li>--%>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="col-lg-12">
                                    <div class="ibox float-e-margins">
                                        <%-- <div class="ibox-title">
                       <h5>
                            Account Fund Details<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>--%>
                                        <div class="ibox-content">
                                            <div class="form-horizontal">
                                                <div class="alert alert-success">
                                                    Total Available Balance &nbsp;
                                                    <%--<button class="btn btn-primary  btn-small-dim" style="margin-left: 30px;" type="button">--%>
                                                    <i class="fa fa-dollar"></i>
                                                    <asp:Label ID="lblAvailBalance" runat="server" Text=""></asp:Label></button>
                                                </div>
                                                <div class="alert alert-warning">
                                                    Reserved Balance &nbsp;
                                                    <%--<button class="btn btn-warning btn-small-dim" style="margin-left: 60px;" type="button">--%>
                                                    <i class="fa fa-dollar"></i>
                                                    <asp:Label ID="lblReserBal" runat="server" Text=""></asp:Label></button>
                                                </div>
                                                <div class="alert alert-info">
                                                    Latest Transaction &nbsp;
                                                    <%--<button class="btn btn-info btn-small-dim" style="margin-left: 60px;" type="button">--%>
                                                    <i class="fa fa-dollar"></i>
                                                    <asp:Label ID="lblLatestTrans" runat="server" Text=""></asp:Label>
                                                    <%--Added To Account--%><asp:Label ID="lblTransType" runat="server" Text=""></asp:Label>
                                                </div>
                                                <div>
                                                    <%-- <asp:Button ID="btnAddFunds" runat="server" Text="Add Funds To Account" class="btn btn-rounded btn-primary" />
                                <asp:Button ID="btnReqWithdrawal" runat="server" Text="Request a Refund" class="btn btn-rounded btn-warning" />
                                <asp:Button ID="btnViewAllTrans" runat="server" Text="View All Transactions" class="btn btn-rounded btn-info"--%>
                                                    <%--   OnClick="btnViewAllTrans_Click" />--%>
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
