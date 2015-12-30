<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="cpd_consulationclosed.aspx.cs" Inherits="cpd_consulationclosed" Title="PrimeDoc | Consultation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Consultation</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="cpd_consultationqueue.aspx">InQueue</a></li>
                        <li class=""><a href="cpd_consultationpickedup.aspx">PickedUp</a></li>
                        <li class="active"><a href="cpd_consulationclosed.aspx">Closed</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="ibox">
                                                    <%-- <div style="height: 520px; overflow: auto">--%>
                                                    <asp:GridView ID="gvConslClosed" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                        class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" 
                                                        OnPageIndexChanging="OnPageIndexChanging" 
                                                        onrowdatabound="gvConslClosed_RowDataBound">
                                                        <Columns>
                                                            <asp:BoundField DataField="CNS_MESSAGE" HeaderText="Message " />
                                                            <asp:BoundField DataField="CST_CONSTATUS" HeaderText="Status " />
                                                            <asp:BoundField DataField="CNS_CONSULTID" HeaderText="ConsultationID " />
                                                            <asp:BoundField DataField="CNS_PATID" HeaderText="PatienID " />
                                                            <asp:TemplateField HeaderText="Patient Name">
                                                                    <ItemTemplate>
                                                           <asp:Label ID="lbl_patname" runat="server" Text='<%# Eval("Name") %>' />
                                                                                
                                                          </ItemTemplate>
                                                          </asp:TemplateField>
                                                            <asp:BoundField DataField="CNS_DOCID" HeaderText="DoctorID " />
                                                            <asp:BoundField DataField="CNST_CNSMODE" HeaderText="TypeofMode " />
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
