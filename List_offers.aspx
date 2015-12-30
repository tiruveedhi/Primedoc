<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="List_offers.aspx.cs" Inherits="List_offers" Title="PrimeDoc| Offers Lost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
               Offers List</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                       
                        <li class=""><a href="upcoming_offers.aspx">New Offers</a></li>
                        <li class="active"><a href="List_offers.aspx">Offers List</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                               <%-- <div class="ibox-content">--%>
                                    <div class="form-horizontal">
                                     <asp:GridView ID="gv_offers" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                        class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true">
                                                        <Columns>
                                                            <asp:BoundField DataField="OFFER_ID" />
                                                            <asp:BoundField DataField="OFFER_NAME" HeaderText="Offer Title" />
                                                             <asp:BoundField DataField="OFFER_DESCRIPTION" HeaderText="Offer Desecrption" />
                                                             <asp:TemplateField>
                                                             <ItemTemplate>
                                                             <asp:Button ID="btnedit" Text="Edit offers Details" runat="server"  OnClick="btnedit_Click"/>
                                                             </ItemTemplate>
                                                             </asp:TemplateField>
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
            <%--</div>--%>
        </div>
    </div>
</asp:Content>

