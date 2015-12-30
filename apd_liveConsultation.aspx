<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_liveConsultation.aspx.cs" Inherits="apd_liveConsultation" Title="PrimeDoc | Free Consultation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script language="javascript" type="text/javascript">
        function openNewWin(url) 
        {
            var x = window.open(url, 'mynewwin', 'width=600,height=600,toolbar=1');
            x.focus();
        }
    </script>

    <script type="text/javascript"> 
function test()
{
    setTimeout(
    function()
    { 
        $.ajax({
            type: "POST",
            url: "apd_liveConsultation.aspx/invokeZoom",
            
            data : "{LiveCnsID: '"+ $("#<%= hfLiveCnsID.ClientID %>").val() + "'}",
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
    var str = response.d;
    var split = str.split('~~~');
    if(split[0] == "true" && split[1] != "")
    {
        if(document.getElementById('<%=divPatSymp.ClientID%>') !=null)
          document.getElementById('<%=divPatSymp.ClientID%>').style.display="block";
        if(document.getElementById('<%=lblMsgs.ClientID%>') !=null)
          document.getElementById('<%=lblMsgs.ClientID%>').style.display="none";  
          
        if(split.length == 1)
        {
            document.getElementById('<%=divDocAdvice.ClientID%>').style.display="none"; 
        }  
        if(split.length>1)
        {
            document.getElementById('<%=divDocAdvice.ClientID%>').style.display="block"; 
            if(document.getElementById('<%=tbPrescription.ClientID%>') !=null)
            {
                  document.getElementById('<%=tbPrescription.ClientID%>').style.display="block"; 
                  document.getElementById('<%=tbPrescription.ClientID%>').innerHTML=split[1]; 
            }
        }
        if(split.length>1)
        {
            document.getElementById('<%=divDocAdvice.ClientID%>').style.display="block"; 
            if(document.getElementById('<%=tbDiagnosis.ClientID%>') !=null)
            {
                  document.getElementById('<%=tbDiagnosis.ClientID%>').style.display="block"; 
                  document.getElementById('<%=tbDiagnosis.ClientID%>').innerHTML=split[2]; 
            }
        }
          
    }
    if(split[0] == "false")
    {
        if(document.getElementById('<%=divPatSymp.ClientID%>') !=null)
              document.getElementById('<%=divPatSymp.ClientID%>').style.display="none";
        if(document.getElementById('<%=lblMsgs.ClientID%>') !=null)
        {
              document.getElementById('<%=lblMsgs.ClientID%>').style.display="block"; 
              document.getElementById('<%=lblMsgs.ClientID%>').innerHTML="Doctors are not available. Please try later."; 
        }
    }
//   if(document.getElementById("<%= hfZoom.ClientID %>").value != "true" &&
//   document.getElementById("<%= hfZoom.ClientID %>").value == "false")
//   {
     test();
   //}
   
}
window.onload = test;
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

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
                <li class="active"><a href="apd_liveConsultation.aspx">LiveConsultation</a></li>
                <li class=""><a href="apd_liveConsultationlist.aspx">LiveConsultation list</a></li>
            </ul>
            <div class="tab-content">
                <div id="tab-1" class="tab-pane active">
                </div>
            </div>
        </div>
        <div class="ibox-content m-b-sm border-bottom">
            <div class="form-group" id="divPatSymp" runat="server" style="display: none">
                <label class="col-sm-2 control-label">
                    Symptoms :</label>
                <div class="col-sm-10 control-label">
                    <asp:TextBox ID="tbSymptoms" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                </div>
                <br />
                <asp:Button ID="btnLiveConsul" runat="server" Text="Start Live Consultation" OnClick="btnLiveConsul_Click"
                    class="btn btn-rounded btn-info" />
                <br />
                <%--<asp:Button ID="btnGetDocAdv" runat="server" Text="Get Doctor Advice" OnClick="btnGetDocAdv_Click"
                    class="btn btn-rounded btn-info" />--%>
                <div id="divDocAdvice" runat="server" class="form-group" style="display:none">
                    <label class="col-sm-2 control-label">
                        Prescription given by Doctor :</label>
                    <div class="col-sm-10 control-label">
                        <asp:TextBox ID="tbPrescription" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                    </div>
                    <br />
                    <label class="col-sm-2 control-label">
                        Diagnosis given by Doctor :</label>
                    <div class="col-sm-10 control-label">
                        <asp:TextBox ID="tbDiagnosis" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter symptoms before start the consultation."
                    ControlToValidate="tbSymptoms" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <asp:Label ID="lblMsgs" runat="server" ForeColor="Red" Width="1000px" Style="display: none"></asp:Label>
        </div>
    </div>
    <input id="hfZoom" type="hidden" runat="server" value="false" />
    <input id="hfLiveCnsID" type="hidden" runat="server" value="false" />
   
</asp:Content>
