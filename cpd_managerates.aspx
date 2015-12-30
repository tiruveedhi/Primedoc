<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" 
CodeFile="cpd_managerates.aspx.cs" Inherits="cpd_managerates" Title="PrimeDoc | Manage Rates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
               Manage Rates</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight ecommerce" style="padding-right:0px !important;">
        <div class="ibox-content m-b-sm border-bottom">
            <div class="row">
               
            </div>
             <div class="panel-body">
                                <div class="form-horizontal">
                                    <div class="form-group">
        
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox">
                  <div style="height: 520px; overflow: auto">
                                            <asp:GridView ID="gvsepecial" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                class='footable table table-stripped toggle-arrow-tiny' > 
                                              
                                                <Columns>
                                               
                                                    <%--<asp:BoundField DataField="DOC_PROF_BIO" HeaderText="Description" />--%>
                                                   <asp:BoundField DataField="SPE_SPECIALTIYID" HeaderText="SPE_SPECIALTIYID" />
                                                    <asp:BoundField DataField="SPE_SPECIALTY" HeaderText="SPECIALTY" />
                                                   
                                                  <asp:TemplateField HeaderText="RegualerMode">
                                                        <ItemTemplate >
                                                            <asp:TextBox ID="txtregulaer"  runat="server" Text='<%# Eval("SPE_REGULAR_RATE") %>'></asp:TextBox>
                                                              
                                                            <%--CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"CommandArgument='<%#Eval("Consultaion Id") %>'--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                          <asp:TemplateField HeaderText="ExpressMode">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtexpress"  runat="server" Text='<%# Eval("SPE_EXPRESS_RATE") %>'></asp:TextBox>
                                                              
                                                          
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnsave" CommandName="More" runat="server" Text="Update"
                                                              OnClick="btnsave_Click" class="btn btn-sm btn-primary m-t-n-xs"  />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                </div>
            </div>
        </div>
    </div>
    </div>
        </div>
    </div>
</asp:Content>

