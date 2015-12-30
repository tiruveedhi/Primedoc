<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="apd_startSecondOpinion.aspx.cs" Inherits="apd_startSecondOpinion" Title="PrimeDoc | Second Opinion Video Consultation" %>

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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Start Second Opinion Video Consultation</h2>
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
                            Second Opinion Video Consultation<small></small></h5>
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
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    Selected Speciality</label>
                                <div class="col-sm-10">
                                    <div class="i-checks">
                                        <asp:Label ID="lblSpeciality" runat="server" Text=""></asp:Label>
                                    </div>
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
                                                OnTextChanged="tbSelectedDate_TextChanged"></asp:TextBox>
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
                                    
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    
                                    <asp:Button ID="btnback" runat="server" Text="Back" 
                                    class="submit btn btn-primary" onclick="btnback_Click" />
                                   
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
