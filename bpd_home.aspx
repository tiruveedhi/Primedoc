﻿<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="bpd_home.aspx.cs" Inherits="bpd_home" Title="PrimeDoc | Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="sidebard-panel">
        <div>
            <h4>
                Messages
                <%--<span class="badge badge-info pull-right"><%=Session["count"]%></span>--%></h4>
            <div id="messages" runat="server">
            </div>
            <%-- <div class="feed-element">   
                        <a href="#" class="pull-left">
                            <img alt="image" class="img-circle" src="img/a1.jpg">
                        </a>                 
                        <div class="media-body">
                            You have successfully submitted the Second opinion for the Consultation with ID 342221.
                            <br>
                            <small class="text-muted">Today 4:21 pm</small>
                        </div>
                    </div>
                    <div class="feed-element">                       
                        <a href="#" class="pull-left">
                            <img alt="image" class="img-circle" src="img/a1.jpg">
                        </a>   
                        <div class="media-body">
                            There is a reply to your query for the consultation with ID 342221.
                            <br>
                            <small class="text-muted">Yesterday 2:45 pm</small>
                        </div>
                    </div>
                    <div class="feed-element">                        
                        <a href="#" class="pull-left">
                            <img alt="image" class="img-circle" src="img/a1.jpg">
                        </a>   
                        <div class="media-body">
                            You have raised a query for the patient with consultation ID 342221.
                            <br>
                            <small class="text-muted">Yesterday 1:10 pm</small>
                        </div>
                    </div>
                    <div class="feed-element">                        
                        <a href="#" class="pull-left">
                            <img alt="image" class="img-circle" src="img/a1.jpg">
                        </a>   
                        <div class="media-body">
                            You have picked up the consultation ID 342221. Please provide your second opinion within 4 hours.
                            <br>
                            <small class="text-muted">Monday 8:37 pm</small>
                        </div>
                    </div>--%>
        </div>
    </div>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-lg-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-primary pull-right">Waiting</span>
                        <h5>
                            Queue</h5>
                    </div>
                    <div class="ibox-content" id="consult" runat="server">
                        <%--   <h1 class="no-margins">3</h1><br>                             
                                <small>2:30 PM (30 mins ago)</small><br>
                                <small>4:00 PM (15 mins ago)</small><br />
                                <small>6:00 PM (5 mins ago)</small>--%>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-success pull-right">Available</span>
                        <h5>
                            Funds</h5>
                    </div>
                    <div class="ibox-content" id="Funds" runat="server">
                        <%--  <h1 class="no-margins">$10500</h1><br>      
                                <small>View Details</small><br>     
                                <small>Request A Refund</small>--%>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-danger pull-right">Open</span>
                        <h5>
                            Tickets</h5>
                    </div>
                    <div class="ibox-content" id="tic" runat="server">
                    </div>
                </div>
            </div>
        </div>
        <%-- <div class="row">
            <div class="col-lg-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            List of Doctors added</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a><a class="close-link"><i
                                class="fa fa-times"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content ibox-heading" id="speciality_count" runat="server">--%>
        <%--<h3>3 Cardialogists Added
                            <div class="stat-percent text-navy">34 Total</div>
                        </h3>
                        <small><i class="fa fa-stack-exchange"></i> Prime Doc has a network of over 15 specializations and 640 doctors all over the world</small>--%>
        <%-- </div>--%>
        <%-- <div class="ibox-content">
                            <div>

                                <div class="pull-right text-right">

                                    <span class="bar_dashboard">5,3,9,6,5,9,7,3,5,2,4,7,3,2,7,9,6,4,5,7,3,2,1,0,9,5,6,8,3,2,1</span>
                                    <br/>
                                    <small class="font-bold">$ 20 054.43</small>
                                </div>
                                <h4>NYS report new data!
                                    <br/>
                                    <small class="m-r"><a href="#"> Check the stock price! </a> </small>
                                </h4>
                            </div>
                        </div>--%>
        <%--</div>
                <div class="ibox float-e-margins">--%>
        <%-- <div class="ibox-title">
                            <h5>Read below comments and tweets</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>                              
                                <a class="close-link">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content no-padding">
                            <ul class="list-group">
                                <li class="list-group-item">
                                    <p><a class="text-info" href="#">@Alan Marry</a> I belive that. Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
                                    <small class="block text-muted"><i class="fa fa-clock-o"></i> 1 minuts ago</small>
                                </li>
                                <li class="list-group-item">
                                    <p><a class="text-info" href="#">@Stock Man</a> Check this stock chart. This price is crazy! </p>
                                    <small class="block text-muted"><i class="fa fa-clock-o"></i> 2 hours ago</small>
                                </li>
                                <li class="list-group-item">
                                    <p><a class="text-info" href="#">@Kevin Smith</a> Lorem ipsum unknown printer took a galley </p>
                                    <small class="block text-muted"><i class="fa fa-clock-o"></i> 2 minuts ago</small>
                                </li>
                                <li class="list-group-item ">
                                    <p><a class="text-info" href="#">@Jonathan Febrick</a> The standard chunk of Lorem Ipsum</p>
                                    <small class="block text-muted"><i class="fa fa-clock-o"></i> 1 hour ago</small>
                                </li>
                            </ul>
                        </div>--%>
        <%--</div>
            </div>--%>
        <div class="row">
            <div class="col-lg-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            List of Doctors added</h5>
                        <span class="label label-primary" id="doc_count" runat="server">
                            <%--Special--%></span>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a><a class="close-link"><i
                                class="fa fa-times"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content inspinia-timeline">
                        <div class="timeline-item">
                            <div class="row">
                                <div class="col-xs-10" id="speciality_count" runat="server">
                                    <%--<p class="m-b-xs">
                                        <strong><div class="ibox-content ibox-heading" id="Div1" runat="server"></strong></p>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Upcoming Offers</h5>
                        <span class="label label-primary">Special</span>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a><a class="close-link"><i
                                class="fa fa-times"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content inspinia-timeline"  runat="server" id="offers">
            <%-- <div class="timeline-item">
                          <div class="row"   >
                                <div class="col-xs-3 date">
                                    <i class="fa fa-briefcase"></i>6:00 am
                                    <br />
                                    <small class="text-navy">2 hour ago</small>
                                </div>
                                <div class="col-xs-7 content no-top-border">
                                    <p class="m-b-xs">
                                        <strong>Inauguration Offer</strong></p>
                                    <p>
                                        50% off on all consultations for one month as a part of our Inauguration promo</p>
                                </div>
                            </div>
                        </div>
                      <div class="timeline-item">
                            <div class="row">
                                <div class="col-xs-3 date">
                                    <i class="fa fa-file-text"></i>7:00 am
                                    <br />
                                    <small class="text-navy">3 hour ago</small>
                                </div>
                                <div class="col-xs-7 content">
                                    <p class="m-b-xs">
                                        <strong>Send documents to Mike</strong></p>
                                    <p>
                                        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem
                                        Ipsum has been the industry's standard dummy text ever since.</p>
                                </div>
                            </div>
                        </div>--%>
                         <%-- <div class="timeline-item">
                            <div class="row">
                                <div class="col-xs-3 date">
                                    <i class="fa fa-coffee"></i>8:00 am
                                    <br />
                                </div>
                                <div class="col-xs-7 content">
                                    <p class="m-b-xs">
                                        <strong>Coffee Break</strong></p>
                                    <p>
                                        Go to shop and find some products. Lorem Ipsum is simply dummy text of the printing
                                        and typesetting industry. Lorem Ipsum has been the industry's.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="timeline-item">
                            <div class="row">
                                <div class="col-xs-3 date">
                                    <i class="fa fa-phone"></i>11:00 am
                                    <br />
                                    <small class="text-navy">21 hour ago</small>
                                </div>
                                <div class="col-xs-7 content">
                                    <p class="m-b-xs">
                                        <strong>Phone with Jeronimo</strong></p>
                                    <p>
                                        Lorem Ipsum has been the industry's standard dummy text ever since.
                                    </p>
                                </div>
                            </div>
                        </div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="right-sidebar">
        <div class="sidebar-container">
            <ul class="nav nav-tabs navs-3">
                <li class="active"><a data-toggle="tab" href="#tab-1">Notes </a></li>
                <li><a data-toggle="tab" href="#tab-2">Projects </a></li>
                <li class=""><a data-toggle="tab" href="#tab-3"><i class="fa fa-gear"></i></a></li>
            </ul>
            <div class="tab-content">
                <div id="tab-1" class="tab-pane active">
                    <div class="sidebar-title">
                        <h3>
                            <i class="fa fa-comments-o"></i>Latest Notes</h3>
                        <small><i class="fa fa-tim"></i>You have 10 new message.</small>
                    </div>
                    <div>
                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a1.jpg">
                                    <div class="m-t-xs">
                                        <i class="fa fa-star text-warning"></i><i class="fa fa-star text-warning"></i>
                                    </div>
                                </div>
                                <div class="media-body">
                                    There are many variations of passages of Lorem Ipsum available.
                                    <br>
                                    <small class="text-muted">Today 4:21 pm</small>
                                </div>
                            </a>
                        </div>
                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a2.jpg">
                                </div>
                                <div class="media-body">
                                    The point of using Lorem Ipsum is that it has a more-or-less normal.
                                    <br>
                                    <small class="text-muted">Yesterday 2:45 pm</small>
                                </div>
                            </a>
                        </div>
                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a3.jpg">
                                    <div class="m-t-xs">
                                        <i class="fa fa-star text-warning"></i><i class="fa fa-star text-warning"></i><i
                                            class="fa fa-star text-warning"></i>
                                    </div>
                                </div>
                                <div class="media-body">
                                    Mevolved over the years, sometimes by accident, sometimes on purpose (injected humour
                                    and the like).
                                    <br>
                                    <small class="text-muted">Yesterday 1:10 pm</small>
                                </div>
                            </a>
                        </div>
                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a4.jpg">
                                </div>
                                <div class="media-body">
                                    Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the
                                    <br>
                                    <small class="text-muted">Monday 8:37 pm</small>
                                </div>
                            </a>
                        </div>
                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a8.jpg">
                                </div>
                                <div class="media-body">
                                    All the Lorem Ipsum generators on the Internet tend to repeat.
                                    <br>
                                    <small class="text-muted">Today 4:21 pm</small>
                                </div>
                            </a>
                        </div>
                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a7.jpg">
                                </div>
                                <div class="media-body">
                                    Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes
                                    from a line in section 1.10.32.
                                    <br>
                                    <small class="text-muted">Yesterday 2:45 pm</small>
                                </div>
                            </a>
                        </div>
                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a3.jpg">
                                    <div class="m-t-xs">
                                        <i class="fa fa-star text-warning"></i><i class="fa fa-star text-warning"></i><i
                                            class="fa fa-star text-warning"></i>
                                    </div>
                                </div>
                                <div class="media-body">
                                    The standard chunk of Lorem Ipsum used since the 1500s is reproduced below.
                                    <br>
                                    <small class="text-muted">Yesterday 1:10 pm</small>
                                </div>
                            </a>
                        </div>
                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a4.jpg">
                                </div>
                                <div class="media-body">
                                    Uncover many web sites still in their infancy. Various versions have.
                                    <br>
                                    <small class="text-muted">Monday 8:37 pm</small>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="tab-2" class="tab-pane">
                    <div class="sidebar-title">
                        <h3>
                            <i class="fa fa-cube"></i>Latest projects</h3>
                        <small><i class="fa fa-tim"></i>You have 14 projects. 10 not completed.</small>
                    </div>
                    <ul class="sidebar-list">
                        <li><a href="#">
                            <div class="small pull-right m-t-xs">
                                9 hours ago</div>
                            <h4>
                                Business valuation</h4>
                            It is a long established fact that a reader will be distracted.
                            <div class="small">
                                Completion with: 22%</div>
                            <div class="progress progress-mini">
                                <div style="width: 22%;" class="progress-bar progress-bar-warning">
                                </div>
                            </div>
                            <div class="small text-muted m-t-xs">
                                Project end: 4:00 pm - 12.06.2014</div>
                        </a></li>
                        <li><a href="#">
                            <div class="small pull-right m-t-xs">
                                9 hours ago</div>
                            <h4>
                                Contract with Company
                            </h4>
                            Many desktop publishing packages and web page editors.
                            <div class="small">
                                Completion with: 48%</div>
                            <div class="progress progress-mini">
                                <div style="width: 48%;" class="progress-bar">
                                </div>
                            </div>
                        </a></li>
                        <li><a href="#">
                            <div class="small pull-right m-t-xs">
                                9 hours ago</div>
                            <h4>
                                Meeting</h4>
                            By the readable content of a page when looking at its layout.
                            <div class="small">
                                Completion with: 14%</div>
                            <div class="progress progress-mini">
                                <div style="width: 14%;" class="progress-bar progress-bar-info">
                                </div>
                            </div>
                        </a></li>
                        <li><a href="#"><span class="label label-primary pull-right">NEW</span>
                            <h4>
                                The generated</h4>
                            <!--<div class="small pull-right m-t-xs">9 hours ago</div>-->
                            There are many variations of passages of Lorem Ipsum available.
                            <div class="small">
                                Completion with: 22%</div>
                            <div class="small text-muted m-t-xs">
                                Project end: 4:00 pm - 12.06.2014</div>
                        </a></li>
                        <li><a href="#">
                            <div class="small pull-right m-t-xs">
                                9 hours ago</div>
                            <h4>
                                Business valuation</h4>
                            It is a long established fact that a reader will be distracted.
                            <div class="small">
                                Completion with: 22%</div>
                            <div class="progress progress-mini">
                                <div style="width: 22%;" class="progress-bar progress-bar-warning">
                                </div>
                            </div>
                            <div class="small text-muted m-t-xs">
                                Project end: 4:00 pm - 12.06.2014</div>
                        </a></li>
                        <li><a href="#">
                            <div class="small pull-right m-t-xs">
                                9 hours ago</div>
                            <h4>
                                Contract with Company
                            </h4>
                            Many desktop publishing packages and web page editors.
                            <div class="small">
                                Completion with: 48%</div>
                            <div class="progress progress-mini">
                                <div style="width: 48%;" class="progress-bar">
                                </div>
                            </div>
                        </a></li>
                        <li><a href="#">
                            <div class="small pull-right m-t-xs">
                                9 hours ago</div>
                            <h4>
                                Meeting</h4>
                            By the readable content of a page when looking at its layout.
                            <div class="small">
                                Completion with: 14%</div>
                            <div class="progress progress-mini">
                                <div style="width: 14%;" class="progress-bar progress-bar-info">
                                </div>
                            </div>
                        </a></li>
                        <li><a href="#"><span class="label label-primary pull-right">NEW</span>
                            <h4>
                                The generated</h4>
                            <!--<div class="small pull-right m-t-xs">9 hours ago</div>-->
                            There are many variations of passages of Lorem Ipsum available.
                            <div class="small">
                                Completion with: 22%</div>
                            <div class="small text-muted m-t-xs">
                                Project end: 4:00 pm - 12.06.2014</div>
                        </a></li>
                    </ul>
                </div>
                <div id="tab-3" class="tab-pane">
                    <div class="sidebar-title">
                        <h3>
                            <i class="fa fa-gears"></i>Settings</h3>
                        <small><i class="fa fa-tim"></i>You have 14 projects. 10 not completed.</small>
                    </div>
                    <div class="setings-item">
                        <span>Show notifications </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="example">
                                <label class="onoffswitch-label" for="example">
                                    <span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="setings-item">
                        <span>Disable Chat </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" checked class="onoffswitch-checkbox" id="example2">
                                <label class="onoffswitch-label" for="example2">
                                    <span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="setings-item">
                        <span>Enable history </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="example3">
                                <label class="onoffswitch-label" for="example3">
                                    <span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="setings-item">
                        <span>Show charts </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="example4">
                                <label class="onoffswitch-label" for="example4">
                                    <span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="setings-item">
                        <span>Offline users </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" checked name="collapsemenu" class="onoffswitch-checkbox" id="example5">
                                <label class="onoffswitch-label" for="example5">
                                    <span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="setings-item">
                        <span>Global search </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" checked name="collapsemenu" class="onoffswitch-checkbox" id="example6">
                                <label class="onoffswitch-label" for="example6">
                                    <span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="setings-item">
                        <span>Update everyday </span>
                        <div class="switch">
                            <div class="onoffswitch">
                                <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="example7">
                                <label class="onoffswitch-label" for="example7">
                                    <span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="sidebar-content">
                        <h4>
                            Settings</h4>
                        <div class="small">
                            I belive that. Lorem Ipsum is simply dummy text of the printing and typesetting
                            industry. And typesetting industry. Lorem Ipsum has been the industry's standard
                            dummy text ever since the 1500s. Over the years, sometimes by accident, sometimes
                            on purpose (injected humour and the like).
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
