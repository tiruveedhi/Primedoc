<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="Editoffers_Details.aspx.cs" Inherits="Editoffers_Details" Title="PrimeDoc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
             Offer details</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                   
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="ibox-content">
                                    <div class="form-horizontal">
                                         <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Offer Title</label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtoffertype" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                            
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed">
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                              Offer Description</label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtdesc" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                              
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed">
                                         <asp:Button ID="btnback" runat="server" class="btn btn-primary pull-right" 
                                                Text="Back" onclick="btnback_Click"/>
                                       
                                            <asp:Button ID="btnsubmit" runat="server" class="btn btn-primary pull-right" 
                                                Text="update" OnClick="btnsubmit_Click"
                                                 />
                                              
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

