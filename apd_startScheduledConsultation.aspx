<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_startScheduledConsultation.aspx.cs" Inherits="apd_startScheduledConsultation"
    Title="PrimeDoc | Scheduled Video Consultation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />

    <script type="text/JavaScript">
   function validateTime(obj)
{
    var timeValue = obj.value;
    if(timeValue == "" || timeValue.indexOf(":")<0)
    {
        alert("Invalid Time format");
         obj.value="";
        return false;
    }
    else
    {
        var sHours = timeValue.split(':')[0];
        var sMinutes = timeValue.split(':')[1];

        if(sHours == "" || isNaN(sHours) || parseInt(sHours)>23)
        {
            alert("Invalid Time format");
            obj.value="";
            return false;
        }
        else if (sHours <10)
            sHours = sHours;

        if(sMinutes == "" || isNaN(sMinutes) || parseInt(sMinutes)>59)
        {
            alert("Invalid Time format");
            obj.value="";
            return false;
        }

        else if (sMinutes <10)
            sMinutes = sMinutes;    

        obj.value = sHours + ":" + sMinutes;        
    }

    return true;    
}

    </script>
<script type ="text/javascript">

 $(document).ready(function(){  
    $("#<%=rbtnSpecialities.ClientID%>").change(function(){ 
     var obj = {};
     var myparam= $("#<%=rbtnSpecialities.ClientID%>").val(); //id name for dropdown list
     
     obj.doc_id = $.trim($("[id*=hidden_docid]").val());
        obj.value = myparam;    
     $.ajax({ 
      type:"POST",
      url:"apd_startScheduledConsultation.aspx/get_specialtyrates",
      data: JSON.stringify(obj),
      contentType:"application/json; charset=utf-8",
      success: function(data)
      {  
      var dt=data.d;
    var dd = dt.split(',');
   
    document.getElementById('<%= lblrate.ClientID %>').innerHTML  = dd[1]
    document.getElementById('<%= lbl.ClientID %>').innerHTML  = dd[0];
    
      } 
  }); 
 });
});  

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Start Scheduled Video Consultation</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Scheduled Video Consultation<small></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Selected Doctor</label>
                                <div class="col-sm-10">
                                   <asp:HiddenField ID="hidden_docid" runat="server" />
                                    <asp:Label ID="lblDocName" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Selected Speciality</label>
                                <div class="col-sm-3">
                                   
                                        <asp:DropDownList ID="rbtnSpecialities" runat="server" class="form-control m-b" ></asp:DropDownList>
                                   
                                </div>
                            </div>
                                   <div class="form-group">
                                        <label class="col-sm-2 control-label">
                                            Mode of Payment</label>
                                        <div class="col-sm-10">                                            
                                               <div class="i-checks"><label> <input id="my_cb" type="radio" value="option1" name="a" checked> <i></i> Regular Mode </label>
                                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label><input type="radio" value="option" name="a"> <i></i> Express Mode </label></div>                                                    
                                        </div>
                                    </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Consultation Charges</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblrate" runat="server" class="form-control" Visible="true"></asp:Label>
                                            <asp:Label ID="lbl" runat="server" class="form-control" Visible="true" Style="display: none"></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Doctor Available Timings</label>
                                <div class="col-sm-10">
                                    <asp:GridView ID="gvDocAvailTimings" runat="server" GridLines="None" AutoGenerateColumns="false"
                                        class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblId" runat="server" Visible="false" Text='<%#Eval("DSC_DOCSCHEDID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DSC_FROMDATE" HeaderText="From Date" />
                                            <asp:BoundField DataField="DSC_FROMTIME" HeaderText="From Time" />
                                            <asp:BoundField DataField="DSC_TODATE" HeaderText="To Date" />
                                            <asp:BoundField DataField="DSC_TOTIME" HeaderText=" To Time" />
                                            <asp:BoundField DataField="DCS_DAYSOFWEEK" HeaderText=" Days of Week" />
                                        </Columns>
                                        <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                                            PreviousPageText="<<" />
                                        <PagerStyle CssClass="pager-row" />
                                    </asp:GridView>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Select Appointment Date and Time</label>
                                <div class="col-sm-10">
                                    <div class="col-md-3" id="data_2">
                                        <small style="text-decoration: none;"></small>
                                        <div class="input-group date">
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            <asp:TextBox ID="tbSelectedDate" runat="server" class="form-control" AutoPostBack="true"
                                                ontextchanged="tbSelectedDate_TextChanged"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <%--<asp:TextBox ID="tbSelectedTime" runat="server" placeholder="HH:MM" class="form-control"
                                            MaxLength="5" onchange="validateTime(this);"></asp:TextBox>--%>
                                        <asp:DropDownList ID="ddlTime" runat="server" class="form-control" Visible="false">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="submit btn btn-primary"
                                    OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <scrip>
    
function hide_row_metod() {
    console.debug("hide_row_metod");
    if(document.getElementById('my_cb').checked){                
            $("#<%=lblrate.ClientID%>").show();
            $("#<%=lbl.ClientID%>").hide();
        }        
    else {        
        $("#<%=lbl.ClientID%>").show();
            $("#<%=lblrate.ClientID%>").hide();
    }
}



$("#my_cb").on("ifChanged", hide_row_metod);

</script>
</asp:Content>
