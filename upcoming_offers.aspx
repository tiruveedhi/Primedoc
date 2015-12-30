<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="upcoming_offers.aspx.cs" Inherits="upcoming_offers" Title="PrimeDoc|Offers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
               Manage Offers</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                       
                        <li class="active"><a href="upcoming_offers.aspx">New Offers</a></li>
                        <li class=""><a href="List_offers.aspx">Offers List</a></li>
                    </ul>
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
                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter Description"
                    ControlToValidate="tbdesc" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed">
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                              Offer Description</label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="tbdesc" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Description"
                    ControlToValidate="tbdesc" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed">
                                            <asp:Button ID="btnsubmit" runat="server" class="btn btn-primary pull-right" 
                                                Text="Submit" onclick="btnsubmit_Click"
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

