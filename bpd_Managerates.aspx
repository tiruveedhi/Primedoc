<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="bpd_Managerates.aspx.cs" Inherits="bpd_Managerates" Title="PrimeDoc| Managerates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                ManageRates</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="bpd_manageFunds.aspx">Account Fund Details</a></li>
                        <li class=""><a href="bpd_viewAllTransactions.aspx">View All Transactions</a></li>
                        <li class=""><a href="bpd_bankAccountDetails.aspx">Bank Account Details</a></li>
                        <li class="active"><a href="bpd_Managerates.aspx">Manage Rates</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <%--<div class="ibox-content">--%>
                                    <div class="form-horizontal">
                                        <%--<asp:Button ID="Button1" runat="server" Text="Back" OnClick="btnBack_Click" />
                                        <br />--%>
                                        <center>
                                           <%-- <div id="divGrid" visible="true" runat="server" style="overflow: scroll; width: 100%;
                                                height: 540px">--%>
                                                <asp:GridView ID="gv_rates" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                    class='footable table table-stripped toggle-arrow-tiny' ShowHeader="true" ShowFooter="true">
                                                    <Columns>
                                                    <asp:BoundField DataField="SPE_SPECIALTY" HeaderText="SPECIALTY" />
                                                    <asp:BoundField DataField="DSP_EXPRESS_RATE" HeaderText="EXPRESSRATE" />
                                                    <asp:BoundField DataField="DSP_REGULAR_RATE" HeaderText="REGULARRATE" />
                                                    </Columns>
                                                </asp:GridView>
                                         <%--   </div>--%>
                                        </center>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
       <%-- </div>--%>
    </div>
</asp:Content>

