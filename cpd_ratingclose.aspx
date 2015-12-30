<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="cpd_ratingclose.aspx.cs" Inherits="cpd_ratingclose" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Close</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                     <li class=""><a href="cpd_rating.aspx">Active</a></li>
                   <li class="active"><a href="cpd_ratingclose.aspx">Close</a></li>
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
                                                    <asp:GridView ID="gv_closerating" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                        class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" onpageindexchanging="gv_closerating_PageIndexChanging" 
                                                        >
                                                        <Columns>
                                                            <asp:BoundField DataField="PAT_ID" HeaderText="Patientid" />
                                                    <asp:BoundField DataField="DOC_ID" HeaderText="Doctorid" />
                                                    <asp:BoundField DataField="CONSULT_ID" HeaderText="Consultationid" />
                                                    <asp:BoundField DataField="REMARKS" HeaderText="Remarks" />
                                                    
                                                        </Columns>
                                                         <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                                                                    PreviousPageText="<<" />
                                                                <PagerStyle CssClass="pager-row" />
                                                    </asp:GridView>
                                                    <%-- </div>--%>
                                                </div>
    </div> </div> </div> </div> </div> </div> </div> </div> </div> </div>
</asp:Content>

