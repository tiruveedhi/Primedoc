<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="bpd_secondopinoinliveconsultation.aspx.cs" Inherits="bpd_secondopinoinliveconsultation" Title="Prime Dco | Sechduled Consultation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
            url: "bpd_secondopinoinliveconsultation.aspx/checkForZoom",
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
      
       document.getElementById('<%= hfBtnText.ClientID %>').value = "END CALL";
       document.getElementById('<%= btnReady.ClientID %>').value = "END CALL";  


      
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Live Consultation</h2>
        </div>
        <div class="col-lg-2">
        
        </div>
     </div>
     <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                        <asp:Button ID="btnReady" runat="server" Text="Waiting For Patient" 
                            class="btn btn-rounded btn-info" onclick="btnReady_Click" />
                        
                    </div>
                </div>
                </div>
 
                  <input id="hfPatSymp" type="hidden" runat="server" value="" />
    <input id="hfBtnText" type="hidden" runat="server" value="Waiting For Patient" />
    <input id="hfZoom" type="hidden" runat="server" value="false" />
           
</asp:Content>

