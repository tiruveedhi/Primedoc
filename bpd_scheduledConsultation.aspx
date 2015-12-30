<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_scheduledConsultation.aspx.cs" Inherits="bpd_scheduledConsultation"
    Title="PrimeDoc | Scheduled Video Consultation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Scheduled Video Consultation</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <%--<div class="ibox-title">
                        <h5>
                            Scheduled Video Consultation<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>--%>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label>
                                    Patient Scheduled Consultations</label>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-10">
                                    <asp:GridView ID="gvPatSchedConsultations" runat="server" GridLines="None" AutoGenerateColumns="false"
                                        class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblId" runat="server" Visible="false" Text='<%#Eval("DST_SCHEDID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DST_PATID" HeaderText="Patient Id" />
                                            <asp:BoundField DataField="DST_SCHED_DATE" HeaderText="Scheduled Date" />
                                            <asp:BoundField DataField="DST_SCHED_TIME" HeaderText="Scheduled Time" />
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
</asp:Content>
