<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="cpd_consultationqueue.aspx.cs" Inherits="cpd_consultationqueue" Title="PrimeDoc | Consultation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:UpdatePanel runat="server" ID="UPanel">
        <ContentTemplate>
            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <h2>
                        Consultation</h2>
                </div>
                <div class="col-lg-2">
                </div>
            </div>
            <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="tabs-container">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="cpd_consultationqueue.aspx">InQueue</a></li>
                                <li class=""><a href="cpd_consultationpickedup.aspx">PickedUp</a></li>
                                <li class=""><a href="cpd_consulationclosed.aspx">Closed</a></li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active">
                                    <div class="panel-body">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="ibox">
                                                            <%--<div style="height: 520px; overflow: auto">--%>
                                                            <asp:GridView ID="gv_queue" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                                class='footable table table-stripped toggle-arrow-tiny' OnRowDataBound="gv_queue_RowDataBound"
                                                                AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging">
                                                                <Columns>
                                                                    <asp:BoundField DataField="CNS_MESSAGE" HeaderText="Message " />
                                                                    <asp:BoundField DataField="CST_CONSTATUS" HeaderText="Status " />
                                                                    <asp:BoundField DataField="CNS_CONSULTID" HeaderText="ConsultationID " />
                                                                    <asp:BoundField DataField="CNS_PATID" HeaderText="PatienID " />
                                                                      <asp:TemplateField HeaderText="Patient Name">
                                                                    <ItemTemplate>
                                                           <asp:Label ID="lbl_patname" runat="server" Text='<%# Eval("Name") %>' />
                                                                                
                                                          </ItemTemplate>
                                                          </asp:TemplateField>
                                                                    <asp:BoundField DataField="CNS_DOCID" HeaderText="DoctorID " />
                                                                    <asp:BoundField DataField="CNST_CNSMODE" HeaderText="TypeofMode " />
                                                                    <asp:BoundField DataField="Difference" HeaderText="Difference " />
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <asp:Button runat="server" Text="Edit" ID="btnEdit" OnClick="btnEdit_Click" class="btn btn-sm btn-primary m-t-n-xs" />
                                                                            <%--<ajaxtoolkit:modalpopupextender id="mpe2" runat="server" targetcontrolid="btnDummy1"
                                                                                    popupcontrolid="panelEdit" repositionmode="RepositionOnWindowResizeAndScroll"
                                                                                    dropshadow="true" popupdraghandlecontrolid="panelEditTitle" backgroundcssclass="modalBackground"></ajaxtoolkit:modalpopupextender>
                                                                           --%>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                                                                    PreviousPageText="<<" />
                                                                <PagerStyle CssClass="pager-row" />
                                                            </asp:GridView>
                                                            <asp:Timer ID="Timer1" runat="server" Interval="120000">
                                                            </asp:Timer>
                                                            <%--</div>--%>
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
                </div>
            </div>
            <asp:Button ID="btnDummy1" runat="server" Style="display: none" />
            <asp:ModalPopupExtender ID="btnEdit_ModalPopupExtender" runat="server" DynamicServicePath=""
                Enabled="True" PopupControlID="panelEdit" TargetControlID="btnDummy1" CancelControlID="btnEditCancel"
                BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Panel ID="panelEdit" runat="server" Style="display: none; background-color: White;"
                ForeColor="Black">
                <asp:GridView ID="gvEditAlterDocs" runat="server" AutoGenerateColumns="false" OnRowEditing="gvEditAlterDocs_RowEditing"
                    DataKeyNames="CAD_DOCID" OnRowCancelingEdit="gvEditAlterDocs_RowCancelling" AlternatingRowStyle-BackColor="#EEEEEE"
                    EditRowStyle-BorderColor="Red" OnRowUpdating="gvEditAlterDocs_RowUpdating" OnRowDataBound="gvEditAlterDocs_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblSNo" Text='<%#Eval("CAD_ADID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CONSULTATION ID">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCnsId" Text='<%#Eval("CAD_CNSID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DOCID">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblDocId" Text='<%#Eval("CAD_DOCID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DOCTOR NAME">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblDocName" Text='<%#Eval("DOCTOR NAME") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ALTERTYPE">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblType" Text='<%#Eval("CAD_ALTERTYPE") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ACTIVESTATUS">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblStatus" Text='<%#Eval("CAD_ACTIVESTATUS") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnEditStatus" runat="server" CommandName="Edit" Text="Make Active" width="100px"/>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbReason" runat="server"></asp:TextBox>
                                <br />
                                <asp:LinkButton ID="lbtnUpdate" runat="server" CommandName="Update" Text="Update" />
                                <asp:LinkButton ID="lbtnCancel" runat="server" CommandName="Cancel" Text="Cancel" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                <div align="center">
                    <asp:Button ID="btnEditCancel" runat="server" Width="70" Text="Cancel" />
                </div>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
