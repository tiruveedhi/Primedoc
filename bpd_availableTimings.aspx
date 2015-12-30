<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_availableTimings.aspx.cs" Inherits="bpd_availableTimings" Title="PrimeDoc | Available Timings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/gridpagingstyle.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
function checkAll(objRef) 
{
    var inputList = document.getElementsByTagName("input");
    for (var i=0;i<inputList.length;i++)
    {
        var row = inputList[i].parentNode.parentNode;
        if(inputList[i].type == "checkbox" && objRef != inputList[i])
        {
            if (objRef.checked)
            {
                inputList[i].checked=true;
            }
            else
            {
                inputList[i].checked=false;
            }
         }   
    }
}



    </script>
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
//        else if(parseInt(sHours) == 0)
//            sHours = "0";
        else if (sHours <10)
            sHours = sHours;

        if(sMinutes == "" || isNaN(sMinutes) || parseInt(sMinutes)>59)
        {
            alert("Invalid Time format");
            obj.value="";
            return false;
        }
//        else if(parseInt(sMinutes) == 0)
//            sMinutes = "0";
        else if (sMinutes <10)
            sMinutes = sMinutes;    

        obj.value = sHours + ":" + sMinutes;        
    }

    return true;    
}

</script>

   


<script type="text/javascript">
function mandatory()
{


if(document.getElementById("<%=tbfromDate.ClientID %>").value=="")
{
alert('Enter From Date');
document.getElementById("<%=tbfromDate.ClientID %>").focus();
return false;
}


if(document.getElementById("<%=tbtoDate.ClientID %>").value=="")
{
alert('Enter To Date');
document.getElementById("<%=tbtoDate.ClientID %>").focus();
return false;
}

 var CHK = document.getElementById("<%=cblDays.ClientID%>");
   var checkbox = CHK.getElementsByTagName("input");
   var counter=0;
  var atLeast=1;
   for (var i=0;i<checkbox.length;i++)
   {
       if (checkbox[i].checked)
       {
            counter++;
       }
   }
   if(atLeast>counter)
{
        alert('Please select atleast one chekbox');
        return false;
  }
  return true;

}
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        
        <div class="col-lg-10">
            <h2>
                Available Timings</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <%--<h5>
                            Personal Details<small></small></h5>--%>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <%--<form method="get" class="form-horizontal">--%>
                        <div class="datepicker datepicker-inline" style="display: block;">
                            <div class="datepicker-days" style="display: block;">
                                <%--<table class=" table-condensed">
                                    <thead>
                                        <tr>
                                            <th class="prev" style="visibility: visible;">
                                                <i class="icon-arrow-left"></i>
                                            </th>
                                            <th colspan="5" class="switch">
                                                July 2015
                                            </th>
                                            <th class="next" style="visibility: visible;">
                                                <i class="icon-arrow-right"></i>
                                            </th>
                                        </tr>
                                        <tr>
                                            <th class="dow">
                                                Su
                                            </th>
                                            <th class="dow">
                                                Mo
                                            </th>
                                            <th class="dow">
                                                Tu
                                            </th>
                                            <th class="dow">
                                                We
                                            </th>
                                            <th class="dow">
                                                Th
                                            </th>
                                            <th class="dow">
                                                Fr
                                            </th>
                                            <th class="dow">
                                                Sa
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="day old _day_0 _date_2015-06-28">
                                                28
                                            </td>
                                            <td class="day old _day_1 _date_2015-06-29">
                                                29
                                            </td>
                                            <td class="day old _day_2 _date_2015-06-30">
                                                30
                                            </td>
                                            <td class="day _day_3 _date_2015-07-01">
                                                1
                                            </td>
                                            <td class="day _day_4 _date_2015-07-02">
                                                2
                                            </td>
                                            <td class="day _day_5 _date_2015-07-03">
                                                3
                                            </td>
                                            <td class="day _day_6 _date_2015-07-04">
                                                4
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="day _day_0 _date_2015-07-05">
                                                5
                                            </td>
                                            <td class="day _day_1 _date_2015-07-06">
                                                6
                                            </td>
                                            <td class="day _day_2 _date_2015-07-07">
                                                7
                                            </td>
                                            <td class="day _day_3 _date_2015-07-08">
                                                8
                                            </td>
                                            <td class="day _day_4 _date_2015-07-09">
                                                9
                                            </td>
                                            <td class="day _day_5 _date_2015-07-10">
                                                10
                                            </td>
                                            <td class="day _day_6 _date_2015-07-11">
                                                11
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="day _day_0 _date_2015-07-12">
                                                12
                                            </td>
                                            <td class="day today active _day_1 _date_2015-07-13">
                                                13
                                            </td>
                                            <td class="day _day_2 _date_2015-07-14">
                                                14
                                            </td>
                                            <td class="day _day_3 _date_2015-07-15">
                                                15
                                            </td>
                                            <td class="day _day_4 _date_2015-07-16">
                                                16
                                            </td>
                                            <td class="day _day_5 _date_2015-07-17">
                                                17
                                            </td>
                                            <td class="day _day_6 _date_2015-07-18">
                                                18
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="day _day_0 _date_2015-07-19">
                                                19
                                            </td>
                                            <td class="day _day_1 _date_2015-07-20">
                                                20
                                            </td>
                                            <td class="day _day_2 _date_2015-07-21">
                                                21
                                            </td>
                                            <td class="day _day_3 _date_2015-07-22">
                                                22
                                            </td>
                                            <td class="day _day_4 _date_2015-07-23">
                                                23
                                            </td>
                                            <td class="day _day_5 _date_2015-07-24">
                                                24
                                            </td>
                                            <td class="day _day_6 _date_2015-07-25">
                                                25
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="day _day_0 _date_2015-07-26">
                                                26
                                            </td>
                                            <td class="day _day_1 _date_2015-07-27">
                                                27
                                            </td>
                                            <td class="day _day_2 _date_2015-07-28">
                                                28
                                            </td>
                                            <td class="day _day_3 _date_2015-07-29">
                                                29
                                            </td>
                                            <td class="day _day_4 _date_2015-07-30">
                                                30
                                            </td>
                                            <td class="day _day_5 _date_2015-07-31">
                                                31
                                            </td>
                                            <td class="day new _day_6 _date_2015-08-01">
                                                1
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="day new _day_0 _date_2015-08-02">
                                                2
                                            </td>
                                            <td class="day new _day_1 _date_2015-08-03">
                                                3
                                            </td>
                                            <td class="day new _day_2 _date_2015-08-04">
                                                4
                                            </td>
                                            <td class="day new _day_3 _date_2015-08-05">
                                                5
                                            </td>
                                            <td class="day new _day_4 _date_2015-08-06">
                                                6
                                            </td>
                                            <td class="day new _day_5 _date_2015-08-07">
                                                7
                                            </td>
                                            <td class="day new _day_6 _date_2015-08-08">
                                                8
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="7" class="today" style="display: none;">
                                                Today
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>--%>
                            </div>
                            <div class="datepicker-months" style="display: none;">
                                <table class="table-condensed">
                                    <thead>
                                        <tr>
                                            <th class="prev" style="visibility: visible;">
                                                <i class="icon-arrow-left"></i>
                                            </th>
                                            <th colspan="5" class="switch">
                                                2015
                                            </th>
                                            <th class="next" style="visibility: visible;">
                                                <i class="icon-arrow-right"></i>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="7">
                                                <span class="month">Jan</span><span class="month">Feb</span><span class="month">Mar</span><span
                                                    class="month">Apr</span><span class="month">May</span><span class="month">Jun</span><span
                                                        class="month active">Jul</span><span class="month">Aug</span><span class="month">Sep</span><span
                                                            class="month">Oct</span><span class="month">Nov</span><span class="month">Dec</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="7" class="today" style="display: none;">
                                                Today
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                            <div class="datepicker-years" style="display: none;">
                                <table class="table-condensed">
                                    <thead>
                                        <tr>
                                            <th class="prev" style="visibility: visible;">
                                                <i class="icon-arrow-left"></i>
                                            </th>
                                            <th colspan="5" class="switch">
                                                2010-2019
                                            </th>
                                            <th class="next" style="visibility: visible;">
                                                <i class="icon-arrow-right"></i>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="7">
                                                <span class="year old">2009</span><span class="year">2010</span><span class="year">2011</span><span
                                                    class="year">2012</span><span class="year">2013</span><span class="year">2014</span><span
                                                        class="year active">2015</span><span class="year">2016</span><span class="year">2017</span><span
                                                            class="year">2018</span><span class="year">2019</span><span class="year old">2020</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="7" class="today" style="display: none;">
                                                Today
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                   <%--     <button class="create btn btn-primary">
                            <i class="icon-plus"></i>Create New Available Time
                        </button>--%>
                       <div class="modal-header">
                            <h3 id="myModalLabel">
                                Create Available Time</h3>
                        </div>
                        <div class="modal-body">
                          <%--  <button class="create btn btn-primary">
                                <i class="icon-plus"></i>Recurring
                            </button>--%>
                            <div class="control-group date">
                                <label class="control-label" for="inputDate">
                                    Date and Time
                                </label>
                                <div class="controls">
                                    <div class="col-sm-10">
                                        <div class="row">
                                            <div class="col-md-3" id="data_2">
                                                <small style="text-decoration: none;"></small>
                                            <div class="input-group date">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                <%--<input type="text" id="fromDate" runat="server" placeholder="01-07-2015" class="form-control">--%>
                                                <asp:TextBox ID="tbfromDate" runat="server"  class="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                           
                                            <div class="col-md-2"  >
                                                    <input type="text" id="timepicker_input1"   name="tbfromTime"  readonly="readonly" class="txtfield"/>
                                            </div>
                                            <div class="col-md-1">
                                                <label>
                                                    </label></div>
                                          <div class="col-md-3" id="data_2">
                                                <small style="text-decoration: none;"></small>
                                            <div class="input-group date">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>      <%--<input type="text" id="toDate" runat="server" placeholder="31-07-2015" class="form-control">--%>
                                                <asp:TextBox ID="tbtoDate" runat="server" class="form-control"></asp:TextBox>
                                            </div>
                                            </div>
                                            
                                            <div class="col-md-2"  >
                                                <%--<input type="text" id="toTime" runat="server" placeholder="13:00" class="form-control">--%>
                                            
                                        <input type="text" id="timepicker_input"  name="tbtoTime"  readonly="readonly" class="txtfield" />

                                            </div>
                                              
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <br />
                            <br />
                            <div class="control-group daysOfWeek">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">
                                        Repeating Days</label>
                                    <div class="col-sm-10">
                                        <label class="checkbox-inline">
                                            <input type="checkbox" value="option1" id="Checkbox1" onclick="checkAll(this);" />
                                            ALL
                                        </label>
                                        <label class="checkbox-inline">
                                            <asp:CheckBoxList ID="cblDays" runat="server" RepeatDirection="Horizontal" 
                                            EnableTheming="True" Width="400px">
                                                <asp:ListItem>MON</asp:ListItem>
                                                <asp:ListItem>TUE</asp:ListItem>
                                                <asp:ListItem>WED</asp:ListItem>
                                                <asp:ListItem>THU</asp:ListItem>
                                                <asp:ListItem>FRI</asp:ListItem>
                                                <asp:ListItem>SAT</asp:ListItem>
                                                <asp:ListItem>SUN</asp:ListItem>
                                            </asp:CheckBoxList>
                                         </label>
                                       <%-- <label class="checkbox-inline">
                                            <input type="checkbox" runat="server" value="option1" id="inlineCheckbox1" />
                                            MON
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" runat="server" value="option2" id="inlineCheckbox2" />
                                            TUE
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" runat="server" value="option3" id="inlineCheckbox3" />
                                            WED
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" runat="server" value="option4" id="inlineCheckbox4" />
                                            THE
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" runat="server" value="option5" id="inlineCheckbox5" />
                                            FRI
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" runat="server" value="option6" id="inlineCheckbox6" />
                                            SAT
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" runat="server" value="option7" id="inlineCheckbox7" />
                                            SUN
                                        </label>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <%--<button type="submit" class="submit btn btn-primary" data-loading-text="<i class='icon-spinner icon-spin'></i> Creating...">
                                Save
                            </button>--%>
                            <asp:Button ID="btnSave" runat="server" Text="Save" class="submit btn btn-primary"
                                 OnClick="btnSave_Click" OnClientClick="return mandatory();" />
                                
                            <button class="btn" data-dismiss="modal" aria-hidden="true">
                                Cancel
                            </button>
                            <ul class="errorMsg">
                            </ul>
                        </div>
                            <div class="form-group">
                                        <%--<div style="height: 400px; overflow: auto">--%>
                                        <asp:GridView ID="gv_timing" runat="server" GridLines="None" AutoGenerateColumns="false"
                                            class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" onrowdeleting="gv_timing_RowDeleting"  
                                           OnRowDataBound = "OnRowDataBound" OnPageIndexChanging="OnPageIndexChanging" >
                                            <Columns>
                                           <%-- <asp:BoundField DataField="DSC_DOCSCHEDID" />--%>
                                             <asp:TemplateField>
                                                <ItemTemplate>
                                                <asp:Label ID="lbl_id" runat="server" Visible="false" Text='<%#Eval("DSC_DOCSCHEDID") %>'></asp:Label>
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="DSC_FROMDATE" HeaderText="From Date" />
                                              
                                                <asp:BoundField DataField="DSC_FROMTIME" HeaderText="From Time" />
                                                <asp:BoundField DataField="DSC_TODATE" HeaderText="To Date" />
                                                <asp:BoundField DataField="DSC_TOTIME" HeaderText=" To Time" />
                                                <asp:BoundField DataField="DCS_DAYSOFWEEK" HeaderText=" Days of Week" />
                                                
                                              <asp:CommandField ShowDeleteButton="True" ButtonType="Button" ControlStyle-CssClass="submit btn btn-primary" />
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
        <!-- end of personal details -->
        
    </div>
    
</asp:Content>
