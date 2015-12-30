using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using DAC;
public partial class cpd_home : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL obj_Globl = new DAC.BLL.clsGlobalBLL();
    DataTable dt_admin = new DataTable();
    DAC.BLL.clsadminBLL obj_adminBLL = new DAC.BLL.clsadminBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        { }
        else
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            ticket();
            Doctor_Count();
            Consult_Fill();
           Fill_offers();
        }


    }

    public void ticket()
    {

        dt_admin = obj_Globl.GetAdminticket();
        if (dt_admin.Rows.Count > 0)
        {

            if (dt_admin.Rows.Count < 2)
            {


                tic.InnerHtml = "<h1 class='no-margins'>" + (Convert.ToInt32(dt_admin.Rows[0][0].ToString())) + "</h1>" +
               "<br><small><a href='cpd_openticket.aspx'>Open " + dt_admin.Rows[0][0].ToString() + "</a></small>"
                           + "<br><small><a href='cpd_closeticket.aspx'>Close " + 0 + "</a></small>";
            }
            else if (dt_admin.Rows.Count >= 2)
            {

                tic.InnerHtml = "<h1 class='no-margins'>" + (Convert.ToInt32(dt_admin.Rows[0][0].ToString()) + Convert.ToInt32(dt_admin.Rows[1][0].ToString())) + "</h1>" +
                             "<br><small><a href='cpd_openticket.aspx'>Open " + dt_admin.Rows[0][0].ToString() + "</a></small>"
                                         + "<br><small><a href='cpd_closeticket.aspx'>Close " + dt_admin.Rows[1][0].ToString() + "</a></small>";
            }
        }
        else
        {
            tic.InnerHtml = "<h1 class='no-margins'>" + 0 + "</h1>" +
                "<br><small> </small>" +
                       " <br><small></small>";

        }

    }
    public void Doctor_Count()
    {
        dt_admin = obj_Globl.GetdoctorCount();
        if (dt_admin.Rows.Count > 0)
        {
            Doctor.InnerHtml = "<h1 class='no-margins'>" + dt_admin.Rows[0][0].ToString() + "</h1>" +
                  "<br><small>Busy</small>"
                              + "<br><small>Idle</small>";
        }

    }
    public void Consult_Fill()
    {

        dt_admin = obj_Globl.Getconsultadmin();
        if (dt_admin.Rows.Count > 0)
        {

            if (dt_admin.Rows.Count < 2)
            {

                Consult.InnerHtml = "<h1 class='no-margins'>" +
                                       "" + (Convert.ToInt32(dt_admin.Rows[0][0].ToString())) + "</h1>" +
                                   "<br>" +
                                   "<small><a href='cpd_consultationqueue.aspx'>" + dt_admin.Rows[0][1].ToString() + " " + dt_admin.Rows[0][0].ToString() + "</a></small><br>";
                                     
                }
              

         
            
           

            else if (dt_admin.Rows.Count >= 2)
            {
                Consult.InnerHtml = "<h1 class='no-margins'>" +
                                    (Convert.ToInt32(dt_admin.Rows[0][0].ToString()) + Convert.ToInt32(dt_admin.Rows[1][0].ToString())) + "</h1>" +
                                              "<br>" +
                                              "<small><a href='cpd_consultationqueue.aspx'>Queue " + dt_admin.Rows[0][0].ToString() + "</a></small><br>" +
                                              "<small><a href='cpd_consultationpickedup.aspx'>Taken Up " + dt_admin.Rows[1][0].ToString() + " </a></small>";

            }

        }
        else
        {

            Consult.InnerHtml = " <h1 class='no-margins'>" +
                                          " " + 0 + "</h1>" +
                                       "<br>" + "<small></small><br>" +
                               "<small></small>";


        }
    }
    public void Fill_offers()
    {
        DataSet ds_offers = new DataSet();

        ds_offers = obj_adminBLL.Get_offers();

        string time_format = "";
        for (int i = 0; i < ds_offers.Tables[0].Rows.Count; i++)
        {

            DateTime dt = System.DateTime.Now;
            DateTime get_date = Convert.ToDateTime(ds_offers.Tables[0].Rows[i]["offerhours"].ToString());
                TimeSpan diff = dt.Subtract(get_date);

       
    if (diff.Days > 1)
                time_format = string.Concat(diff.Days + " days ago");
            else if (diff.Days == 1)
                time_format = "yesterday";
            else if (diff.Hours >= 1)
                time_format = string.Concat(diff.Hours + " hours ago");
    else if (diff.Minutes >= 60 && diff.Hours == 0)
                time_format = "more than an hour ago";
            else if (diff.Minutes >= 5 && diff.Hours == 0)
                time_format = string.Concat(diff.Minutes + " minutes ago");
          
           else if (diff.Minutes >= 1 && diff.Hours==0)
              
                time_format = diff.Minutes + "minutes ago";
    if (diff.Minutes == 0 && diff.Hours == 0)
               time_format = "less than a minute ago";

            offers.InnerHtml += "<div class='timeline-item'>" +
                "<div class='row'>" +
            "<div class='col-xs-3 date'>" +
                        " <i class='fa fa-file-text'></i>" + ds_offers.Tables[0].Rows[i]["offerstime"].ToString() + " " +
                         "<br />" +
                         "<small class='text-navy'>" + time_format + "</small>" +
                     "</div>" +
                        "<div class='col-xs-7 content no-top-border'>" +
                                " <p class='m-b-xs'>" +
                                     "<strong>" + ds_offers.Tables[0].Rows[i]["OFFER_NAME"].ToString() + " </strong></p>" +
                                " <p>" + ds_offers.Tables[0].Rows[i]["OFFER_DESCRIPTION"].ToString() + "</p>" +
                                 "</div>" +
                            "</div>" +

     "</div>";


        }
    }
}
