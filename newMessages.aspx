<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="newMessages.aspx.cs" Inherits="newMessages" Title="PrimeDoc | Messages" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<%--paging style--%>
    <style type="text/css">
       /* Data Pager Styles */
    tr.pager-row td
    {
        border-top:solid 2px #bbd9ee;
    }
    .pager
    {
        font-family:arial,sans-serif;
        text-align:center;
        padding:6px;
        font-size:18px;
    }
    .pager span.command,
    .pager span.current,
    .pager a.command,
    tr.pager-row td a
    {
        color:#5a90ce;
        padding:0px 5px;
        text-decoration:none;
        border:none;
    }
    .pager a.command:hover,
    tr.pager-row td a:hover
    {
        border:solid 2px #408BB6;
        background-color:#59A5D1;
        color:#fff;
        padding:0px 3px;
        text-decoration:none;
    }
    .pager span.current,
    tr.pager-row td span
    {
	    border:solid 2px #3c3c3c;
        background-color:#3e3e3e;
        color:#fff;
        font-weight:bold;
        padding:0px 6px;
    }
    tr.pager-row td
    {
	    border-top:none;
	    text-align:center;
    }
     tr.pager-row table
    {
	    height:35px;
	    margin:0 auto 0 auto;
    }
    </style>
    <%--end of paging style--%>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        .modalBackground
        {
            background-color: Black;
            filter: alpha(opacity=40);
            opacity: 0.4;
        }
        .modalPopup
        {
            background-color: #FFFFFF;
            width: 300px;
            border: 3px solid #0DA9D0;
        }
        .modalPopup .header
        {
            background-color: #2FBDF1;
            height: 30px;
            color: White;
            line-height: 30px;
            text-align: center;
            font-weight: bold;
        }
        .modalPopup .body
        {
            min-height: 80px;
            line-height: 50px;
            text-align: center;
            font-weight: bold;
        }
        .modalPopup .footer
        {
            padding: 1px;
        }
        .modalPopup .yes, .modalPopup .no
        {
            height: 10px;
            color: White;
            line-height: 23px;
            text-align: center;
            font-weight: bold;
            cursor: pointer;
        }
        .modalPopup .yes
        {
            background-color: #2FBDF1;
            border: 1px solid #0DA9D0;
        }
        .modalPopup .done
        {
            background-color: #2FBDF1;
            border: 1px solid #0DA9D0;
        }
        .modalPopup .no
        {
            background-color: #9F9F9F;
            border: 1px solid #5C5C5C;
        }
    </style>

    <script type="text/javascript">

function checkAll(objRef)
{
    var GridView = objRef.parentNode.parentNode.parentNode;
    var inputList = GridView.getElementsByTagName("input");
    for (var i=0;i<inputList.length;i++)
    {
        //Get the Cell To find out ColumnIndex
        var row = inputList[i].parentNode.parentNode;
        if(inputList[i].type == "checkbox"  && objRef != inputList[i])
        {
            if (objRef.checked)
            {
                //If the header checkbox is checked check all checkboxes and highlight all rows

               // row.style.backgroundColor = "aqua";
                inputList[i].checked=true;
            }
            else
            {
                //If the header checkbox is checked uncheck all checkboxes and change rowcolor back to original
//                if(row.rowIndex % 2 == 0)
//                {
//                   //Alternating Row Color
//                   row.style.backgroundColor = "#C2D69B";
//                }
//                else
//                {
//                   row.style.backgroundColor = "white";
//                }
                inputList[i].checked=false;
            }
        }
    }
}

    </script>

    <script type="text/javascript">
    function ConfirmDelete()
    {
       var count = document.getElementById("<%=hfCount.ClientID %>").value;
       var gv = document.getElementById("<%=gvNewMessages.ClientID%>");
       var chk = gv.getElementsByTagName("input");
       for(var i=0;i<chk.length;i++)
       {
            if(chk[i].checked && chk[i].id.indexOf("chkSelectAll") == -1)
            {
                count++;
            }
       }
       if(count == 0)
       {
            alert("No records to delete.");
            return false;
       }
       else
       {
            return confirm("Do you want to delete " + count + " records.");
       }
    }
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
                        Messages</h2>
                </div>
                <div class="col-lg-2">
                </div>
            </div>
            <div class="wrapper wrapper-content animated fadeInRight" style="padding-right: 0px !important;">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="tabs-container">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="newMessages.aspx">New</a></li>
                                <li class=""><a href="readMessages.aspx">Read</a></li>
                                <li class=""><a href="deleteMessages.aspx">Deleted</a></li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active">
                                    <div class="panel-body">
                                        <div class="ibox-content">
                                            <div class="form-horizontal">
                                                <asp:Button ID="btnDelete" runat="server" Text="Delete Checked Records" OnClick="btnDelete_Click"
                                                    OnClientClick="return ConfirmDelete();" class="btn btn-sm btn-primary" />
                                                &nbsp;&nbsp;
                                                <asp:Button ID="btnRead" runat="server" Text="Mark as read" OnClick="btnRead_Click"
                                                    class="btn btn-sm btn-primary" />
                                                <asp:HiddenField ID="hfCount" runat="server" Value="0" />
                                                <asp:GridView ID="gvNewMessages" runat="server" GridLines="None" AutoGenerateColumns="false"
                                                    class='footable table table-stripped toggle-arrow-tiny' AllowPaging="true" DataKeyNames="MSG_MSGID"
                                                    OnPageIndexChanging="OnPaging">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkSelectAll" runat="server" onclick="checkAll(this);" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkRow" runat="server" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%--<asp:BoundField DataField="MSG_MSGID" HeaderText="" Visible="false"/>--%>
                                                        <asp:TemplateField HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkView" runat="server" Text='<%# Eval("MSG_MESSAGE") %>' OnClick="lnkView_Click" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" NextPageText=">>"
                                                        PreviousPageText="<<" />
                                                    <PagerStyle CssClass="pager-row" />
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:Button ID="btnView" runat="server" Style="display: none" />
            <asp:ModalPopupExtender ID="btnView_modalpopupextender" PopupControlID="pnlView"
                runat="server" TargetControlID="btnView" BackgroundCssClass="Background" CancelControlID="">
            </asp:ModalPopupExtender>
            <asp:Panel ID="pnlView" runat="server" CssClass="modalPopup" Style="display: none">
                <div class="body">
                    Message :
                    <asp:Label ID="lblMessage" runat="server" Height="20px"></asp:Label>
                    <asp:Label ID="lblMsgId" runat="server" Text="" Visible="false" />
                </div>
                <div class="footer" align="right">
                    <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" />
                </div>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvNewMessages" />
            <asp:AsyncPostBackTrigger ControlID="btnClose" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
