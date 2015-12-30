<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_newConsultation.aspx.cs" Inherits="apd_newConsultation" Title="PrimeDoc | New Consultation" %>

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
                        <asp:TextBox ID="txtdoctor" runat="server" placeholder="Doctor Name" class="form-control"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="validateDoctorNameLength" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                            ControlToValidate="txtdoctor" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="price">
                            Specialization</label>
                        <%--CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"CommandArgument='<%#Eval("Consultaion Id") %>'--%>
                        <asp:DropDownList ID="ddlSpeciality" runat="server" class="form-control m-b" placeholder="Specialization"
                            OnSelectedIndexChanged="ddlSpeciality_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="quantity">
                            Location</label>
                        <asp:TextBox ID="txtlocation" runat="server" class="form-control" placeholder="Location"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="validateLocationLength" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                            ControlToValidate="txtlocation" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="status">
                            Language</label>
                        <%--CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"CommandArgument='<%#Eval("Consultaion Id") %>'--%>
                        <asp:DropDownList ID="ddllanuage" runat="server" class="form-control">
                            <%-- <asp:ListItem Value="1" Text="Telugu" ></asp:ListItem>
                        <asp:ListItem Value="1" Text="Hindi" ></asp:ListItem>
                        <asp:ListItem Value="1" Text="English" ></asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="status">
                            Gender</label>
                        <%--</div>--%>
                        <asp:DropDownList ID="ddlGenderList" runat="server" class="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-3 pull-right">
                    <div class="form-group">
                        <%--   <script>
        function CallMethod(clickedId) {
            window.location.assign("apd_startConsultation.aspx?docId="+clickedId)           
        }
    </script>--%>
                        <asp:Button ID="btnSearch" class="btn btn-success btn-rounded" Style="width: 100%;"
                            runat="server" Text="Search" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox">
                        <%--<div style="height: 520px; overflow: auto">--%>
                        <asp:GridView ID="gvsearch" runat="server" GridLines="None" AutoGenerateColumns="false"
                            class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging"
                            ><%--OnRowDataBound="gvsearch_RowDataBound"--%>
                            <Columns>
                                <asp:BoundField DataField="DOC_DOCID" HeaderText="Doc_ID" />
                                <asp:BoundField DataField="DoctorName" HeaderText="DoctorName" />
                                <asp:BoundField DataField="SPE_SPECIALTY" HeaderText="Specialization" />
                                <asp:BoundField DataField="DOC_PROF_BIO" HeaderText="Description" />
                                <%--<asp:BoundField DataField="SPE_SPECIALTY_ID"  />--%>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnviewDetails" CommandName="More" runat="server" Text="View Details"
                                            OnClick="btnviewDetails_Click" class="btn btn-sm btn-primary m-t-n-xs" />
                                        <%--CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"CommandArgument='<%#Eval("Consultaion Id") %>'--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="DOC_DOCID" CommandName="More" runat="server" Text="Start Consultation"
                                            OnClick="btnstartconsulation_Click" class="btn btn-sm btn-primary m-t-n-xs" />
                                        <%--CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"CommandArgument='<%#Eval("Consultaion Id") %>'--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                                PreviousPageText="<<" />
                            <PagerStyle CssClass="pager-row" />
                        </asp:GridView>
                        <%--</div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--   <script>
        function CallMethod(clickedId) {
            window.location.assign("apd_startConsultation.aspx?docId="+clickedId)           
        }
    </script>--%>
</asp:Content>
