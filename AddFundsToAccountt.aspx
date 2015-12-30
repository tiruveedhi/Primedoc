<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="AddFundsToAccountt.aspx.cs" Inherits="AddFundsToAccountt" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Manage Funds</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="apd_manageFunds.aspx">Account FundDetails</a></li>
                        <li class="active"><a href="AddFundsToAccountt.aspx">Add Funds To Account</a></li>
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

