<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_liveConsultation.aspx.cs" Inherits="bpd_liveConsultation" Title="PrimeDoc | Free Consultation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript"> 
    
//var isZoomOpened = false;
function test()
{
setTimeout(
function()
{ 
//alert("Hello");
var rbSelected =  $("#<%= hfBtnText.ClientID %>").val();
$.ajax({
            type: "POST",
            url: "bpd_liveConsultation.aspx/checkForZoom",
            data : "{btnReadyText: '"+ rbSelected + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,
            failure: function(response) {
                alert(response.d);
            }
        }); 
        
}
, 1000);
}
function OnSuccess(response) 
{
    if(response.d != "")
    {
        var str = response.d;
        var result = str.split('~~~');
       document.getElementById('<%= lblPatSymptoms.ClientID %>').innerHTML  = result[1];
       document.getElementById('<%= hfBtnText.ClientID %>').value = "END CALL";
       document.getElementById('<%= btnReady.ClientID %>').value = "END CALL";  

       if(document.getElementById('<%=divDiagnosis.ClientID%>') !=null)
          document.getElementById('<%=divDiagnosis.ClientID%>').style.display="block";
      
       window.open(result[0]);
    }
   if(document.getElementById("<%= hfBtnText.ClientID %>").value != "END CALL")
   {
     test();
   }
}
window.onload = test;
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Live Consultation</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight ecommerce" style="padding-right: 0px !important;">
        <div class="tabs-container">
            <ul class="nav nav-tabs">
                <li class="active"><a href="bpd_liveConsultation.aspx">LiveConsultation</a></li>
                <li class=""><a href="bpd_liveConsultationlist.aspx">LiveConsultation list</a></li>
            </ul>
            <div class="tab-content">
                <div id="tab-1" class="tab-pane active">
                </div>
            </div>
        </div>
        <div class="ibox-content m-b-sm border-bottom">
            <div class="row" id="divDiagnosis" runat="server" style="display: none">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Patient Symptoms :</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="lblPatSymptoms" runat="server" TextMode="MultiLine" class="form-control"
                                        Enabled="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Prescription :</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbPrescription" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Prescription."
                                        ControlToValidate="tbPrescription" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Diagnosis :</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="tbDiagnosis" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter Diagnosis."
                                        ControlToValidate="tbDiagnosis" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                        <asp:Button ID="btnReady" runat="server" Text="I am ready" OnClick="btnReady_Click"
                            Visible="false" class="btn btn-rounded btn-info" />
                        <asp:Label ID="lblMsgs" runat="server" ForeColor="Red" Width="1000px"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="hfPatSymp" type="hidden" runat="server" value="" />
    <input id="hfBtnText" type="hidden" runat="server" value="I am ready" />
    <input id="hfZoom" type="hidden" runat="server" value="false" />
    <%--</ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
        </Triggers>
    </asp:UpdatePanel>--%>
    <%--<asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick" Enabled="false">
    </asp:Timer>--%>
</asp:Content>
