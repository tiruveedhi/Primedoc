<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="cpd_addNewDoctor.aspx.cs" Inherits="cpd_addNewDoctor" Title="PrimeDoc | Add New Doctor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Add New Doctor</h2>
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight ecommerce" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a data-toggle="tab" href="#tab-1">Personal Details</a></li>
                        <li class=""><a data-toggle="tab" href="#tab-2">Address</a></li>
                        <li class=""><a data-toggle="tab" href="#tab-3">Professional Biography</a></li>
                        <li class=""><a data-toggle="tab" href="#tab-4">Upload Files</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="ibox float-e-margins">
                                    <div class="ibox-content">
                                        <form method="get" class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                First Name</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control"></div>
                                        </div>
                                        <div class="hr-line-dashed">
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Last Name</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control"></div>
                                        </div>
                                        <div class="hr-line-dashed">
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Gender</label>
                                            <div class="col-sm-10">
                                                <div class="i-checks">
                                                    <label>
                                                        <input type="radio" value="option1" name="a">
                                                        <i></i>Male
                                                    </label>
                                                </div>
                                                <div class="i-checks">
                                                    <label>
                                                        <input type="radio" value="option1" name="a">
                                                        <i></i>Female
                                                    </label>
                                                </div>
                                                <div class="i-checks">
                                                    <label>
                                                        <input type="radio" value="option1" name="a">
                                                        <i></i>Other
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed">
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Date Of Birth</label>
                                            <div class="col-sm-10">
                                                <div class="row">
                                                    <div class="col-md-2">
                                                        <input type="text" placeholder="DD" class="form-control"></div>
                                                    <div class="col-md-2">
                                                        <input type="text" placeholder="MM" class="form-control"></div>
                                                    <div class="col-md-2">
                                                        <input type="text" placeholder="YYYY" class="form-control"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed">
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Preferred Language(s)</label>
                                            <div class="col-sm-10">
                                                <select class="form-control m-b" name="account">
                                                    <option>Telugu</option>
                                                    <option>Hindi</option>
                                                    <option>English</option>
                                                    <option>Kannada</option>
                                                </select>
                                            </div>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
</asp:Content>
