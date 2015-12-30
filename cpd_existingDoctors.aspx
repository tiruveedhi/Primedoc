<%@ Page Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true"
    CodeFile="cpd_existingDoctors.aspx.cs" Inherits="cpd_existingDoctors" Title="PrimeDoc | Doctors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>
                Existing Doctors</h2>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight ecommerce" style="padding-right: 0px !important;">
        <div class="ibox-content m-b-sm border-bottom">
            <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="product_name">
                            Doctor Name</label>
                        <input type="text" id="product_name" name="product_name" value="" placeholder="Doctor Name"
                            class="form-control">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="price">
                            Specialization</label>
                        <input type="text" id="price" name="price" value="" placeholder="Specialization"
                            class="form-control">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="quantity">
                            Location</label>
                        <input type="text" id="quantity" name="quantity" value="" placeholder="Location"
                            class="form-control">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="control-label" for="status">
                            Language</label>
                        <select name="status" id="status" class="form-control">
                            <option value="1" selected>Telugu</option>
                            <option value="1" selected>Hindi</option>
                            <option value="1" selected>English</option>
                            <option value="1" selected>Kannada</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-3 pull-right">
                    <div class="form-group">
                        <a class="btn btn-success btn-rounded" style="width: 100%;" href="#">Search</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox">
                    <div class="ibox-content">
                        <table class="footable table table-stripped toggle-arrow-tiny" data-page-size="15">
                            <thead>
                                <tr>
                                    <th data-toggle="true">
                                        Doctor Name
                                    </th>
                                    <th data-hide="phone">
                                        Specialization
                                    </th>
                                    <th data-hide="all">
                                        Description
                                    </th>
                                    <th data-hide="phone">
                                        Status
                                    </th>
                                    <th class="text-right" data-sort-ignore="true">
                                        Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        Example Doctor 1
                                    </td>
                                    <td>
                                        Specialization 1
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                        <td>
                                            <span class="label label-primary">Online</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="btn-group">
                                                <button class="btn-white btn btn-xs">
                                                    Edit Doctor Details</button><br>
                                                <br>
                                                <button class="btn-white btn btn-xs">
                                                    Suspend Account</button>
                                            </div>
                                        </td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 2
                                    </td>
                                    <td>
                                        Specialization 2
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 3
                                    </td>
                                    <td>
                                        Specialization 3
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-danger">Offline</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 4
                                    </td>
                                    <td>
                                        Specialization 4
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 5
                                    </td>
                                    <td>
                                        Specialization 5
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-warning">Busy</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 6
                                    </td>
                                    <td>
                                        Specialization 6
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-danger">Offline</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 7
                                    </td>
                                    <td>
                                        Specialization 7
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-danger">Offline</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 8
                                    </td>
                                    <td>
                                        Specialization 8
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 9
                                    </td>
                                    <td>
                                        Specialization 9
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 10
                                    </td>
                                    <td>
                                        Specialization 10
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 1
                                    </td>
                                    <td>
                                        Specialization 1
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 2
                                    </td>
                                    <td>
                                        Specialization 2
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 3
                                    </td>
                                    <td>
                                        Specialization 3
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-warning">Busy</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 4
                                    </td>
                                    <td>
                                        Specialization 4
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 5
                                    </td>
                                    <td>
                                        Specialization 5
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 6
                                    </td>
                                    <td>
                                        Specialization 6
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 7
                                    </td>
                                    <td>
                                        Specialization 7
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 8
                                    </td>
                                    <td>
                                        Specialization 8
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 9
                                    </td>
                                    <td>
                                        Specialization 9
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Example Doctor 10
                                    </td>
                                    <td>
                                        Specialization 10
                                    </td>
                                    <td>
                                        It is a long established fact that a reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it
                                        has a more-or-less normal distribution of letters, as opposed to using 'Content
                                        here, content here', making it look like readable English.
                                    </td>
                                    <td>
                                        <span class="label label-primary">Online</span>
                                    </td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <button class="btn-white btn btn-xs">
                                                Edit Doctor Details</button><br>
                                            <br>
                                            <button class="btn-white btn btn-xs">
                                                Suspend Account</button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="6">
                                        <ul class="pagination pull-right">
                                        </ul>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
