<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="viewAllTransactions.aspx.cs" Inherits="viewAllTransactions" Title="PrimeDoc | View all transactions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                View all transactions</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Transactions<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <asp:Button ID="btnBack" runat="server" Text="Back" onclick="btnBack_Click" />
                            <br />
                            <center>
                                <div id="divGrid" visible="false" runat="server" style="overflow: scroll; width: 100%;
                                    height: 540px">
                                    <asp:GridView ID="gvAllTransactions" runat="server" GridLines="None" AutoGenerateColumns="true"
                                        class='footable table table-stripped toggle-arrow-tiny' ShowHeader="true" ShowFooter="true">
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
