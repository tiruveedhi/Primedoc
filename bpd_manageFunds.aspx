<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_manageFunds.aspx.cs" Inherits="bpd_manageFunds" Title="PrimeDoc | Manage Funds" %>

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
                        <li class="active"><a href="bpd_manageFunds.aspx">Account Fund Details</a></li>
                        <li class=""><a href="bpd_viewAllTransactions.aspx">View All Transactions</a></li>
                        <li class=""><a href="bpd_bankAccountDetails.aspx">Bank Account Details</a></li>
                         <li class=""><a href="bpd_Managerates.aspx">Manage Rates</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="ibox-content">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <div class="alert alert-success">
                                                Total Available Balance &nbsp;
                                                <%--<button class="btn btn-primary  btn-small-dim" style="margin-left: 30px;" type="button">--%>
                                                <i class="fa fa-dollar"></i>
                                                <asp:Label ID="lblAvailBalance" runat="server" Text=""></asp:Label></button>
                                            </div>
                                            <div class="alert alert-info">
                                                Latest Transaction &nbsp;
                                                <%--<button class="btn btn-info btn-small-dim" style="margin-left: 60px;" type="button">--%>
                                                <i class="fa fa-dollar"></i>
                                                <asp:Label ID="lblLatestTrans" runat="server" Text=""></asp:Label>
                                                <%--Added To Account--%><asp:Label ID="lblTransType" runat="server" Text=""></asp:Label>
                                            </div>
                                           <%-- <div class="hr-line-dashed">
                                            </div>--%>
                                        </div>
                                        <%--<div class="hr-line-dashed">
                                        </div>--%>
                                       <%-- <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Description</label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="tbdesc" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed">
                                            <asp:Button ID="Button1" runat="server" class="btn btn-primary pull-right" Text="Submit"
                                                OnClick="Button1_Click" />
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Account Fund Details<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="alert alert-success">
                                Total Available Balance &nbsp;
                                <i class="fa fa-dollar"></i>
                                <asp:Label ID="lblAvailBalance" runat="server" Text=""></asp:Label></button>
                            </div>
                            <div class="alert alert-info">
                                Latest Transaction &nbsp;
                                <i class="fa fa-dollar"></i>
                                <asp:Label ID="lblLatestTrans" runat="server" Text=""></asp:Label>
                               <asp:Label ID="lblTransType" runat="server" Text=""></asp:Label>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <asp:Button ID="btnViewAllTrans" runat="server" Text="View All Transactions" class="btn btn-rounded btn-info"
                                OnClick="btnViewAllTrans_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
    </div>
</asp:Content>
