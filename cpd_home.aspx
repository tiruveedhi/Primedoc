<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="cpd_home.aspx.cs" Inherits="cpd_home" Title="PrimeDoc | Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="sidebard-panel">
        <div>
            <h4>
                Messages
                <%--<span class="badge badge-info pull-right">4</span>--%></h4>
            <div class="feed-element">
                <a href="#" class="pull-left">
                    <img alt="image" class="img-circle" src="img/a1.jpg">
                </a>
                <div class="media-body">
                    Doctor Madhusudhan Completed Consultation with ID 23012
                    <br>
                    <small class="text-muted">Today 4:21 pm</small>
                </div>
            </div>
            <div class="feed-element">
                <a href="#" class="pull-left">
                    <img alt="image" class="img-circle" src="img/a1.jpg">
                </a>
                <div class="media-body">
                    Dr. Madhusudhan replied "I'll look into it".
                    <br>
                    <small class="text-muted">Today 4:05 pm</small>
                </div>
            </div>
            <div class="feed-element">
                <a href="#" class="pull-left">
                    <img alt="image" class="img-circle" src="img/a1.jpg">
                </a>
                <div class="media-body">
                    You have messaged Dr. Madhusudhan saying "please look into consultation Id 23012,
                    it's been open for more than 4 hours"
                    <br>
                    <small class="text-muted">Today 3:17 pm</small>
                </div>
            </div>
            <div class="feed-element">
                <a href="#" class="pull-left">
                    <img alt="image" class="img-circle" src="img/a1.jpg">
                </a>
                <div class="media-body">
                    You picked up the pending consultation with ID 23012.
                    <br>
                    <small class="text-muted">Today 3:15 pm</small>
                </div>
            </div>
        </div>
    </div>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-lg-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-danger pull-right">Active</span>
                        <h5>
                            Tickets</h5>
                    </div>
                    <div class="ibox-content" runat="server" id="tic">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-primary pull-right">Running Late</span>
                        <h5>
                            Consultations</h5>
                    </div>
                    <div class="ibox-content" id="Consult" runat="server">
                        <%-- <h1 class="no-margins">
                            5</h1>
                        <br>
                        <small>3 In Queue</small><br>
                        <small>2 Taken Up</small>--%>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-success pull-right">Online</span>
                        <h5>
                            Doctors</h5>
                    </div>
                    <div class="ibox-content" id="Doctor" runat="server">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
           <%-- <div class="col-lg-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            New doctors added</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a><a class="close-link"><i
                                class="fa fa-times"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content ibox-heading">
                        <h3>
                            3 Cardialogists Added
                            <div class="stat-percent text-navy">
                                34 Total</div>
                        </h3>
                        <small><i class="fa fa-stack-exchange"></i>Prime Doc has a network of over 15 specializations
                            and 640 doctors all over the world</small>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="pull-right text-right">
                                <span class="bar_dashboard">5,3,9,6,5,9,7,3,5,2,4,7,3,2,7,9,6,4,5,7,3,2,1,0,9,5,6,8,3,2,1</span>
                                <br />
                                <small class="font-bold">$ 20 054.43</small>
                            </div>
                            <h4>
                                NYS report new data!
                                <br />
                                <small class="m-r"><a href="#">Check the stock price! </a></small>
                            </h4>
                        </div>
                    </div>
                </div>
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
                            Read below comments and tweets</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a><a class="close-link"><i
                                class="fa fa-times"></i></a>
                        </div>
                    </div>
                    <div class="ibox-content no-padding">
                        <ul class="list-group">
                            <li class="list-group-item">
                                <p>
                                    <a class="text-info" href="#">@Alan Marry</a> I belive that. Lorem Ipsum is simply
                                    dummy text of the printing and typesetting industry.</p>
                                <small class="block text-muted"><i class="fa fa-clock-o"></i>1 minuts ago</small>
                            </li>
                            <li class="list-group-item">
                                <p>
                                    <a class="text-info" href="#">@Stock Man</a> Check this stock chart. This price
                                    is crazy!
                                </p>
                                <small class="block text-muted"><i class="fa fa-clock-o"></i>2 hours ago</small>
                            </li>
                            <li class="list-group-item">
                                <p>
                                    <a class="text-info" href="#">@Kevin Smith</a> Lorem ipsum unknown printer took
                                    a galley
                                </p>
                                <small class="block text-muted"><i class="fa fa-clock-o"></i>2 minuts ago</small>
                            </li>
                            <li class="list-group-item ">
                                <p>
                                    <a class="text-info" href="#">@Jonathan Febrick</a> The standard chunk of Lorem
                                    Ipsum</p>
                                <small class="block text-muted"><i class="fa fa-clock-o"></i>1 hour ago</small>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>--%>
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
                    <div class="ibox-content inspinia-timeline" runat="server" id="offers">
                       <%-- <div class="timeline-item">
                            <div class="row">
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
                        </div>
                        <div class="timeline-item">
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
</asp:Content>
