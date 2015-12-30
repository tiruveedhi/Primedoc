<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_startConsultation.aspx.cs" Inherits="apd_startConsultation" Title="PrimeDoc | Start Consultation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />

    

    
    <script type="text/javascript">
            function Confirm() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Do you want to save data?")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
    </script>

    <script type="text/javascript">
        function CheckCheck() {
            var chkBoxList = document.getElementById('<%=gvSearch.ClientID %>');
            var chkBoxCount = chkBoxList.getElementsByTagName("input");
            var btn = document.getElementById('<%=btnGetSelected.ClientID %>');
            var i = 0;
            var tot = 0;
            for (i = 0; i < chkBoxCount.length; i++) {
                if (chkBoxCount[i].checked) {
                    tot = tot + 1;
                    //Check if selected count greater than 3
                    if (tot > 2) {
                    //Then unchecck the 4th checkbox
                        chkBoxCount[i].checked = false;
                    }
                }
            }

            if (tot > 2) {
                alert('Cannot check more than 2 check boxes');
                return false;
            }
            else {
                return false;
            }
        }
        function checkRefDoc() 
        {
            var chkBoxList = document.getElementById('<%=gvReferringDoc.ClientID %>');
            var chkBoxCount = chkBoxList.getElementsByTagName("input");
            var btn = document.getElementById('<%=btnSelRefDoc.ClientID %>');
            var i = 0;
            var tot = 0;
            for (i = 0; i < chkBoxCount.length; i++) 
            {
                if (chkBoxCount[i].checked) 
                {
                    tot = tot + 1;
                    //Check if selected count greater than 3
                    if (tot > 1) 
                    {
                    //Then unchecck the 4th checkbox
                        chkBoxCount[i].checked = false;
                    }
                }
            }

            if (tot > 1) 
            {
                alert('Cannot check more than 1 check box');
                return false;
            }
            else 
            {
                return false;
            }
        }
    </script>
  
<script type="text/javascript">
 




 $(document).ready(function(){  
    $("#<%=rbtnSpecialities.ClientID%>").change(function(){ 
     var obj = {};
     var myparam= $("#<%=rbtnSpecialities.ClientID%>").val(); //id name for dropdown list
     
     obj.doc_id = $.trim($("[id*=hidden_docid]").val());
        obj.value = myparam;    
     $.ajax({ 
      type:"POST",
      url:"apd_startConsultation.aspx/get_rates",
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
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:UpdatePanel runat="server" ID="UPanel">
        <ContentTemplate>
            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <h2>
                        Start Consultation</h2>
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
                                    Enter Details<small></small></h5>
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
                                            <asp:Label ID="lblDocName" runat="server" Text=""></asp:Label>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed">
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">
                                            Selected Speciality</label>
                                        <div class="col-sm-3">
                                            
                                            <%--    <asp:RadioButtonList ID="rbtnSpecialities" runat="server" RepeatDirection="Horizontal"
                                                   OnSelectedIndexChanged="rbtnSpecialities_SelectedIndexChanged">
                                                </asp:RadioButtonList>--%>
                                               <asp:DropDownList ID="rbtnSpecialities" runat="server" class="form-control m-b" ></asp:DropDownList>
                                     
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed">
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">
                                            Message to Doctor</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="tbMessageToDoctor" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed">
                                    </div>                                   
                                    
                                        <div class="form-group">
                                        <label class="col-sm-2 control-label">
                                            Mode of Payment</label>
                                        <div class="col-sm-10">                                            
                                               <div class="i-checks"><label> <input id="my_cb" type="radio" value="option1" name="a" checked> <i></i> Regular Mode </label>
                                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label><input type="radio" value="option" name="a"> <i></i> Express Mode </label></div>                                                    
                                        </div>
                                    </div>
                                    
                                    
                                    <div class="hr-line-dashed">
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">
                                            Consultation Charges</label>
                                        <div class="col-sm-10">
                                            <asp:Label ID="lblrate" runat="server" class="form-control" Visible="true"></asp:Label>
                                            <asp:Label ID="lbl" runat="server" class="form-control" Visible="true" Style="display: none"></asp:Label>
                                            <%-- <asp:HiddenField ID="lblexpress" runat="server" />
                                    <asp:HiddenField ID="lblregular" runat="server" />--%>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed">
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">
                                            Select alternative doctors</label>
                                        <div class="col-sm-10">
                                            <div>
                                                <asp:Label ID="lblSelectedDocs" runat="server" Text="" Visible="false"></asp:Label>
                                            </div>
                                            
                                            <br />
                                            <asp:Button ID="btnSelectDoctors" runat="server" Text="Select" class="btn btn-sm btn-primary m-t-n-xs"
                                                OnClick="btnSelectDoctors_Click" />
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed">
                                    </div>
                        <%--   <div class="form-group">
                                        <label class="col-sm-2 control-label">
                                            Referring doctor</label>
                                        <div class="col-sm-10">
                                            <div>
                                                <asp:Label ID="lblReferringDoc" runat="server" Text="" Visible="false"></asp:Label>
                                            </div>
                                            <br />
                                            <asp:Button ID="btnReferringDoc" runat="server" Text="Select" class="btn btn-sm btn-primary m-t-n-xs" />
                                            <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" DynamicServicePath=""
                                                Enabled="True" PopupControlID="pnlRefDoc" TargetControlID="btnReferringDoc" CancelControlID="btnRefCancel"
                                                BackgroundCssClass="modalBackground">
                                            </asp:ModalPopupExtender>
                                        </div>
                                    </div>--%>
                                </div>
                            </div>
                            <div class="hr-line-dashed">
                            </div>
                        </div>
                    </div>
                </div>
              <div class="row">
                    <div class="col-lg-12">
                        <asp:Button ID="btnsubmit" runat="server" Text="Proceed" class="btn btn-info center-block"
                            OnClick="btnsubmit_Click" OnClientClick="if(!confirm('Are you sure you want to proceed this user?')) return false;" /><br />
                        <br />
                    </div>
                </div>
            </div>
            <asp:Button ID="btnAlternativeDocs" runat="server" Style="display: none" />
            <asp:ModalPopupExtender ID="btnAlternativeDocs_ModalPopupExtender" runat="server"
                DynamicServicePath="" Enabled="True" PopupControlID="pnlHead" TargetControlID="btnAlternativeDocs"
                CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Panel runat="server" ID="pnlHead" BackColor="White" BorderStyle="Solid" BorderWidth="5px"
                BorderColor="#38ABC8" Width="80%" Height="100%" Style="display: none; border-radius: 5px;
                -moz-border-radius: 5px; -webkit-border-radius: 5px; padding: 50px;">
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
                            <asp:TextBox ID="txtSpecialization" runat="server" placeholder="Specialization" class="form-control"
                                ReadOnly="true"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="validateSpecializationLength" runat="server"
                                ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                                ControlToValidate="txtspecialization" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class="control-label" for="quantity">
                                Location</label>
                            <asp:TextBox ID="txtLocation" runat="server" class="form-control" placeholder="Location"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="validateLocationLength" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                                ControlToValidate="txtlocation" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class="control-label" for="status">
                                Language</label>
                            <asp:DropDownList ID="ddllanuage" runat="server" class="form-control">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class="control-label" for="status">
                                Gender</label>
                            <asp:DropDownList ID="ddlGenderList" runat="server" class="form-control">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-3 pull-right">
                        <div class="form-group">
                            <asp:Button ID="btnSearch" class="btn btn-success btn-rounded" Style="width: 100%;"
                                runat="server" Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
                <%--                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div class="ibox">--%>
                <div style="height: 300px; overflow: auto">
                    <%--   style="height: 300px; overflow: auto"--%>
                    <asp:GridView ID="gvSearch" runat="server" AutoGenerateColumns="false" class="footable table table-stripped toggle-arrow-tiny"
                        GridLines="None" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging"><%-- OnRowDataBound="gvSearch_RowDataBound"--%>
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkRow" runat="server" onclick="javascript:CheckCheck();" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DOC_DOCID" HeaderText="Doc_ID" />
                            <asp:BoundField DataField="DoctorName" HeaderText="DoctorName" />
                            <asp:BoundField DataField="SPE_SPECIALTY" HeaderText="Specialization" />
                            <asp:BoundField DataField="DOC_PROF_BIO" HeaderText="Description" />
                        </Columns>
                        <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                            PreviousPageText="<<" />
                        <PagerStyle CssClass="pager-row" />
                    </asp:GridView>
                </div>
                <asp:Button ID="btnGetSelected" runat="server" Text="Get selected records" OnClick="GetSelectedRecords"
                    class="btn btn-sm btn-primary m-t-n-xs" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-sm btn-primary m-t-n-xs" />
                <%--</div>
                                                        </div>
                                                    </div>--%></asp:Panel>
            <asp:Panel runat="server" ID="pnlRefDoc" BackColor="White" BorderStyle="Solid" BorderWidth="5px"
                BorderColor="#38ABC8" Width="80%" Height="80%" Style="display: none; border-radius: 5px;
                -moz-border-radius: 5px; -webkit-border-radius: 5px; padding: 50px;">
                
                
                 <div class="row">
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class="control-label" for="product_name">
                                Doctor Name</label>
                                <asp:HiddenField ID="hidden_docid" runat="server" />
                            <asp:TextBox ID="txt_doctor" runat="server" placeholder="Doctor Name" class="form-control"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                                ControlToValidate="txt_doctor" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class="control-label" for="price">
                                Specialization</label>
                            <asp:DropDownList ID="ddlSpeciality" runat="server" class="form-control m-b" placeholder="Specialization"
                           >
                        </asp:DropDownList>
                            
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class="control-label" for="quantity">
                                Location</label>
                            <asp:TextBox ID="txt_location" runat="server" class="form-control" placeholder="Location"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Please enter a minimum of three characters (only alphabets are allowed)"
                                ControlToValidate="txt_location" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9\s]{3,}$" />
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class="control-label" for="status">
                                Language</label>
                                <asp:DropDownList ID="ddl_lanuage" runat="server" class="form-control">
                    
                        </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class="control-label" for="status">
                                Gender</label>
                            <asp:DropDownList ID="ddl_gender" runat="server" class="form-control">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-sm-3 pull-right">
                        <div class="form-group">
                            <asp:Button ID="btn_search" class="btn btn-success btn-rounded" Style="width: 100%;"
                                runat="server" Text="Search"  OnClick="btn_search_Click"/>
                        </div>
                    </div>
                </div>
                <div>
                
                
                    <asp:GridView ID="gvReferringDoc" runat="server" GridLines="None" AutoGenerateColumns="false"
                        class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" OnPageIndexChanging="gvReferringDoc_OnPageIndexChanging">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkRow" runat="server" onclick="javascript:checkRefDoc();" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DOC_DOCID" HeaderText="Doc_ID" />
                                <asp:BoundField DataField="DoctorName" HeaderText="DoctorName" />
                                <asp:BoundField DataField="SPE_SPECIALTY" HeaderText="Specialization" />
                                <asp:BoundField DataField="DOC_PROF_BIO" HeaderText="Description" />
                        </Columns>
                        <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                            PreviousPageText="<<" />
                        <PagerStyle CssClass="pager-row" />
                    </asp:GridView>
                </div>
                <asp:Button ID="btnSelRefDoc" runat="server" Text="Select Referring Doctor" OnClick="GetSelectedRefDoc"
                    class="btn btn-sm btn-primary m-t-n-xs" />
                <asp:Button ID="btnRefCancel" runat="server" Text="Cancel" class="btn btn-sm btn-primary m-t-n-xs" />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script>
    
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
