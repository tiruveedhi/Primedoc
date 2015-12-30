<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_labResults.aspx.cs" Inherits="apd_labResults" Title="PrimeDoc | Lab Results" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
function DisplayFullImage(ctrlimg) 
    { 
        txtCode = "<HTML><HEAD>" 
        +  "</HEAD><BODY TOPMARGIN=0 LEFTMARGIN=0 MARGINHEIGHT=0 MARGINWIDTH=0><CENTER>"   
        + "<IMG src='" + ctrlimg.src + "' BORDER=0 NAME=FullImage " 
        + "onload='window.resizeTo(document.FullImage.width,document.FullImage.height)'>"  
        + "</CENTER>"   
        + "</BODY></HTML>"; 
        mywindow= window.open  ('','image',  'toolbar=0,location=0,menuBar=0,scrollbars=0,resizable=0,width=1,height=1,left=120,top=120'); 
        mywindow.document.open(); 
        mywindow.document.write(txtCode); 
        mywindow.document.close();
    }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Lab Results</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right:0px !important;">
        <div class="row">
            <div class="col-sm-12">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class=""><a href="apd_lifeStyle.aspx">Life Style</a></li>
                        <li class=""><a href="apd_healthProblems.aspx">Health Problems</a></li>
                        <li class=""><a href="apd_medications.aspx">Medications</a></li>
                        <li class=""><a href="apd_allergies.aspx">Allergies</a></li>
                        <li class="active"><a href="apd_labResults.aspx">Lab Results</a></li>
                        <li class=""><a href="apd_radiology.aspx">Radiology</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <div class="ibox-content">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                Lab Results</label>
                                            <div class="col-sm-10">
                                                <%--<textarea class="form-control"></textarea>--%>
                                                <asp:TextBox ID="tbLabResults" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox></div>
                                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Labresults"
                    ControlToValidate="tbLabResults" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                        <%--<div class="hr-line-dashed">
                                        </div>--%>
                                        <asp:Button ID="Button1" runat="server" class="btn btn-primary pull-right" Text="Submit"
                                            OnClick="Button1_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--</div>--%>
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
                            Upload files</h5>
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
</asp:Content>
