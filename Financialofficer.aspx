<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="Financialofficer.aspx.cs" Inherits="Financialofficer" Title="Prime Doc|Financial officer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
               Financila Officer</h2>
        </div>
        <div class="col-lg-2">
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox">
                  <div style="height: 520px; overflow: auto">
                                            <asp:GridView ID="gv_admin" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                class='footable table table-stripped toggle-arrow-tiny' 
                                                 >
                                                 
                                              <Columns>
                                              
                                              <asp:TemplateField HeaderText="Select">
                                              <ItemTemplate>
                                        <asp:CheckBox ID="Chk_Select" runat="server"  Checked='<%# Eval("MRW_ISACTIVE") %>'/>
                                              
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
                             <asp:Button ID="btnSubmit"  runat="server" Text="Submit" 
             class="btn btn-sm btn-primary m-t-n-xs" onclick="btnSubmit_Click"/>           
                </div>
            </div>
        </div>
        
            
    </div>
</asp:Content>

