<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_professionalBiography.aspx.cs" Inherits="bpd_professionalBiography"
    Title="PrimeDoc | Professional Biography" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">                
 <script type="text/javascript">
function Validations()
{
    if(document.getElementById("<%=tbDEANo.ClientID %>").value!="")
    {
        var TCode = document.getElementById("<%=tbDEANo.ClientID %>").value;
        if( /[^a-zA-Z0-9]/.test( TCode ) ) 
        {
           alert('Please enter alphanumeric characters only');
           document.getElementById("<%=tbDEANo.ClientID %>").focus();
           return false;
        }
    }
    if(document.getElementById("<%=tbNPINo.ClientID %>").value!="")
    {
        var TCode = document.getElementById("<%=tbNPINo.ClientID %>").value;
        if( /[^a-zA-Z0-9]/.test( TCode ) ) 
        {
           alert('Please enter alphanumeric characters only');
           document.getElementById("<%=tbNPINo.ClientID %>").focus();
           return false;
        }
    }
}
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Professional Biography</h2>
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
                            Speciality<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Specilaities</label>
                                <div class="col-sm-10">
                                    <asp:ListBox ID="ddlSpeciality" placeholder="Preferred Specialities"  
                                        runat="server" cssClass="form-control chosen-select" SelectionMode="Multiple" 
                                        multiple>
                                    </asp:ListBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end of other details -->
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            License Numbes<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    National Provider Identifier (NPI)</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbNPINo" runat="server" class="form-control" MaxLength="10"></asp:TextBox>
                                </div>
                            </div>
                            <%--<div class="hr-line-dashed">
                            </div>--%>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    DEA Number</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbDEANo" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end of other details -->
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Professional Biography<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Professioanl Biography</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbBiography" runat="server" class="form-control" TextMode="MultiLine"
                                        placeholder="Please enter here the details like university attended, primary speciality, other specialties that you can handle, experience details, etc"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <center>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                            class="btn btn-rounded btn-info"  OnClientClick="return Validations();"/></center>
                </div>
            </div>
            <!-- end of other details -->
            <!-- show images -->
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

                                <%--<asp:GridView ID="gridImg" runat="server" AutoGenerateColumns="true">
                                    <Columns>
                                        <asp:BoundField DataField="0" HeaderText="ImageId" />
                                        <asp:TemplateField HeaderText="Images">
                                            <ItemTemplate>
                                                <asp:Image ID="img" runat="server" Height="75px" Width="75px" ImageUrl='<%#"ImgHandler.ashx?id="+ Eval("IMG_IMAGEID")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Images">
                                            <ItemTemplate>
                                                <asp:Button ID="btnRemove" runat="server" Text="Remove" OnClick="btnRemove_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>--%>
                            </div>
                        </div>
                        <div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end of show images -->
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
