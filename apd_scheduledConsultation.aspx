<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_scheduledConsultation.aspx.cs" Inherits="apd_scheduledConsultation"
    Title="PrimeDoc | Scheduled Video Consultation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Doctors List</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight ecommerce" style="padding-right: 0px !important;">
        <div class="ibox-content m-b-sm border-bottom">
            <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="product_name">
                            Doctor Name</label>
                        <asp:TextBox ID="tbDoctorName" runat="server" placeholder="Doctor Name" class="form-control"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="validateDoctorNameLength" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                            ControlToValidate="tbDoctorName" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="price">
                            Specialization</label>
                        <asp:DropDownList ID="ddlSpeciality" runat="server" class="form-control m-b" placeholder="Specialization"
                            OnSelectedIndexChanged="ddlSpeciality_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="quantity">
                            Location</label>
                        <asp:TextBox ID="tbLocation" runat="server" class="form-control" placeholder="Location"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="validateLocationLength" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                            ControlToValidate="tbLocation" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="status">
                            Language</label>
                        <asp:DropDownList ID="ddlLanuage" runat="server" class="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="status">
                            Gender</label>
                        <asp:DropDownList ID="ddlGenderList" runat="server" class="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-3 pull-right">
                    <div class="form-group">
                        <asp:Button ID="btnSearch" class="btn btn-success btn-rounded" Style="width: 100%;"
                            runat="server" Text="Search" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox">
                        <asp:GridView ID="gvDocSearchList" runat="server" GridLines="None" AutoGenerateColumns="false"
                            class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" 
                            OnPageIndexChanging="OnPageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="DOC_DOCID" HeaderText="DoctorId" />
                                <asp:BoundField DataField="DoctorName" HeaderText="DoctorName" />
                                <asp:BoundField DataField="SPE_SPECIALTY" HeaderText="Specialization" />
                                <asp:BoundField DataField="DOC_PROF_BIO" HeaderText="Description" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnScheduledConsultation" CommandName="More" runat="server" Text="Schedule Video Consultation"
                                            OnClick="btnScheduledConsultation_Click" class="btn btn-sm btn-primary m-t-n-xs" />
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
</asp:Content>
