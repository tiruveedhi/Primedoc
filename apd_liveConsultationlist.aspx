<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="apd_liveConsultationlist.aspx.cs" Inherits="apd_liveConsultationlist" Title="Prime Doc | Consultation List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Consultation List</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="apd_liveConsultation.aspx">LiveConsultation</a></li>
                        <li class="active"><a href="apd_liveConsultationlist.aspx">LiveConsultation list</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                           <div class="panel-body">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="ibox">
                                                          
                                                            <asp:GridView ID="gv_list" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" > 
                                                 
                                                <Columns>
                                                                                               
                                                    <asp:BoundField DataField="LC_PAT_SYMPTOMS" HeaderText="Symptoms" />
                                                    <asp:BoundField DataField="LC_PRESCRIPTION" HeaderText="Perscriptions" />
                                                    <asp:BoundField DataField="LC_START_DTM" HeaderText="Date" />
                                                   
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
                </div>
            </div>
        </div>
    </div>
    
   
</asp:Content>

