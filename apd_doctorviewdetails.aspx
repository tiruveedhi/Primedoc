<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_doctorviewdetails.aspx.cs" Inherits="apd_doctorviewdetails" Title="PrimeDoc | Doctor details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Doctor details</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Doctor details<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox float-e-margins">
                        <div class="form-group">
                            <div class="ibox-content">
                                <table width="100%">
                                    <tr>
                                        <td align="left" width="30%">
                                            <img id="imgProfile" runat="server" alt="image" class="img-circle" src="#" style="width: 80px;
                                                height: 80px" />
                                        </td>
                                        <td align="right" width="70%">
                                            <asp:Button ID="btnStartConsl" runat="server" Text="Start Consultation" class="btn btn-sm btn-primary m-t-n-xs"
                                                OnClick="btnStartConsl_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" width="100%">
                                            <div class="ibox-content">
                                               <%-- <b>Name :</b>--%>
                                                <asp:Label ID="lblName" runat="server" Text="Label"></asp:Label>
                                            </div>
                                            <div class="ibox-content">
                                                <b>Speciality :</b>
                                                <asp:Label ID="lblSpeciality" runat="server" Text="Label"></asp:Label>
                                            </div>
                                            <div class="ibox-content">
                                                <b>Professional biography :</b>
                                                <p>
                                                    <asp:Label ID="lblProfBio" runat="server" Text="Label"></asp:Label></p>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
