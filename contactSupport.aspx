<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="contactSupport.aspx.cs" Inherits="contactSupport" Title="PrimeDoc | Contact Support" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                New Ticket</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="contactSupport.aspx">New ticket</a></li>
                        <li class=""><a href="apd_openticket.aspx">Open tickets</a></li>
                        <li class=""><a href="apd_closeticket.aspx">Close tickets</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="ibox-content">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Type of Ticket</label>
                                            <div class="col-sm-10">
                                                <div class="i-checks">
                                                    <asp:DropDownList ID="ddlticket" runat="server" class="form-control m-b">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed">
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Description</label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="tbdesc" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Description"
                    ControlToValidate="tbdesc" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed">
                                            <asp:Button ID="Button1" runat="server" class="btn btn-primary pull-right" Text="Submit"
                                                OnClick="Button1_Click" />
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
    <%--<div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Upload Files</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="dropzone" action="#">
                        <div class="dropzone-previews">
                        </div>
                    <button type="submit" class="btn btn-primary pull-right">
                            Upload Files</button>
                        <asp:Button ID="btnUploadFiles" runat="server" Text="Upload Files" class="btn btn-primary pull-right"/>
                        </div>
                        <div>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
    </div>
</asp:Content>
