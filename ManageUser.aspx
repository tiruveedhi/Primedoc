<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="manageUser.aspx.cs" Inherits="manageUser" Title="Prime Doc | Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Manage Users</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight ecommerce" style="padding-right: 0px !important;">
        <div class="ibox-content m-b-sm border-bottom">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox">
                        <div style="height: 520px; overflow: auto">
                            <asp:GridView ID="gv_Users" runat="server" GridLines="None" AutoGenerateColumns="false"
                                class='footable table table-stripped toggle-arrow-tiny' OnRowCommand="gv_Users_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="Select">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="Chk_Select" runat="server" Checked='<%# Eval("MRW_ISACTIVE") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="MRW_MENUNAME" HeaderText="ManageRoles" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_id" runat="server" Visible="false" Text='<%#Eval("MRW_MENUID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                            CausesValidation="false" class="btn btn-sm btn-primary m-t-n-xs" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
