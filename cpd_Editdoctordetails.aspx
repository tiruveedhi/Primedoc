<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="cpd_editDoctorDetails.aspx.cs" Inherits="cpd_editDoctorDetails" Title="PrimeDoc | Edit Doctor details" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="toolkit1" runat="server">
    </asp:ToolkitScriptManager>
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Personal Information</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Personal Details<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    First Name</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbFirstName" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Last Name</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbLastName" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Gender</label>
                                <div class="col-sm-10">
                                    <div class="i-checks">
                                        <i></i>
                                        <asp:RadioButtonList ID="rbtnGender" runat="server">
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="form-group" id="data_1">
                                <label class="col-sm-2 control-label">
                                    Date Of Birth<br />
                                    <small style="text-decoration: none;"></small>
                                </label>
                                <div class="col-sm-10">
                                    <div class="input-group date">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        <asp:TextBox ID="tbDob" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Preferred Language(s)</label>
                                <div class="col-sm-10">
                                    
                                    <asp:ListBox ID="ddlLanguage" placeholder="Preferred Languages " runat="server" CssClass="form-control chosen-select"
                                        SelectionMode="Multiple" multiple></asp:ListBox>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end of personal details -->
        <!-- Demographics -->
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Address<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <%--<form method="get" class="form-horizontal">--%>
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Country</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlCountry" runat="server" class="form-control m-b" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    State</label>
                                <div class="col-sm-10">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="Server" UpdateMode="Always">
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlState" runat="server" class="form-control m-b" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    City</label>
                                <div class="col-sm-10">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="Server" UpdateMode="Always">
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlState" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlCity" runat="server" class="form-control m-b">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Address Line 1</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbAddress1" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Address Line 2</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbAddress2" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="Server" UpdateMode="Always">
                                    <ContentTemplate>
                                        <label class="col-sm-2 control-label">
                                            <asp:Label ID="lblZipcode" runat="server" Width="100px" Text="Zip code"></asp:Label>
                                        </label>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbPincode" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Email</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbEmail" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <%-- <div class="hr-line-dashed">
                            </div>
                            
                            
                        </div>
                         </form>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Professional Biography<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                        <div class="ibox-content">
                            <%--<form method="get" class="form-horizontal">--%>
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">
                                        Professional Biography</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txtprofessional" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="hr-line-dashed">
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">
                                        Specilaities</label>
                                    <div class="col-sm-10">
                                        <%--<asp:DropDownList ID="ddlSpeciality" runat="server" class="form-control m-b">
                                        </asp:DropDownList>--%>
                                        <asp:ListBox ID="ddlSpeciality" placeholder="Preferred Specialities" runat="server"
                                            CssClass="form-control chosen-select" SelectionMode="Multiple" multiple></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins" visible="false" id="rates" runat="server">
                    <div class="ibox-title">
                        <h5>
                            Speciality Rates<small></small></h5>
                        <%-- <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>--%>
                        <%-- <div class="ibox-content">--%>
                        <%--<form method="get" class="form-horizontal">--%>
                        <div class="form-horizontal">
                            <%--<asp:Button ID="Button1" runat="server" Text="Back" OnClick="btnBack_Click" />
                                        <br />--%>
                            <center>
                                <%-- <div id="divGrid" visible="true" runat="server" style="overflow: scroll; width: 100%;
                                                height: 540px">--%>
                                <asp:GridView ID="gv_rates" runat="server" GridLines="None" AutoGenerateColumns="false"
                                    class='footable table table-stripped toggle-arrow-tiny' ShowHeader="true" ShowFooter="true">
                                    <Columns>
                                        <asp:BoundField DataField="SPE_SPECIALTY" HeaderText="SPECIALTY" />
                                        <asp:TemplateField HeaderText="EXPRESSRATE">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtEXPRESS" runat="server" Text='<%# Eval("DSP_EXPRESS_RATE") %>'></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="REGULARRATE">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtREGULAR" runat="server" Text='<%# Eval("DSP_REGULAR_RATE") %>'></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="REGULARRATE" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_specialty_id" runat="server" Text='<%# Eval("DSP_SPECID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <%--   </div>--%>
                            </center>
                        </div>
                    </div>
                </div>
                <center>
                    <asp:Button ID="btnupdate" runat="server" Text="Update" class="btn btn-rounded btn-info"
                        OnClick="btnupdate_Click" /></center>
            </div>
        </div>
        <%--</div>--%>
        <div class="row">
            <div class="col-lg-12" id="divLoadedImages" runat="server" visible="false">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Already uploaded files</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div id="Div1" action="#">
                            <div>
                                <asp:Panel ID="pnlView" runat="server">
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Option to upload Degree Certificate, Specialty Certificate, etc</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div id="my-awesome-dropzone" class="dropzone" action="#">
                            <div class="dropzone-previews">
                            </div>
                            <%--<button type="submit" class="btn btn-primary pull-right">
                                Upload Files</button>--%>
                            <%-- <asp:Button ID="btnUploadFiles" runat="server" Text="Upload Files" class="btn btn-primary pull-right"
                            OnClick="btnUploadFiles_Click" />--%>
                        </div>
                        <div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
