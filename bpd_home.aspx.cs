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
public partial class bpd_home : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL obj_global = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clsadminBLL obj_adminBLL = new DAC.BLL.clsadminBLL();

    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
        }
        else
        {
            Response.Redirect("login.aspx");
        }

        if (!IsPostBack)
        {
            Fill_tickets();
            Messages();
            Consult();
            Funds_fill();
            Speciality_Count();
           Fill_offers();


        }
    }
    int User_ID;
    int UserTypeId;
    public void Fill_tickets()
    {
        User_ID = Convert.ToInt32(Session["userId"]);
        UserTypeId = Convert.ToInt32(Session["userTypeId"]);

        dt = obj_global.Get_openticketsCount(User_ID, UserTypeId);

        if (dt.Rows.Count > 0)
        {
            tic.InnerHtml = "<h1 class='no-margins'>" + dt.Rows[0][0].ToString() + "</h1>" +
                     "<br><small><a href='apd_openticket.aspx'>View Opentickets</a></small>"
                                 + "<br><small><a href='contactSupport.aspx'>Start New Ticket</a></small>";

        }
        else
        {
            tic.InnerHtml = "<h1 class='no-margins'>" + 0 + "</h1>" +
                               "<br><small><a href='apd_openticket.aspx'>View all</a></small>"
                                           + "<br><small><a href='contactSupport.aspx'>Start New Ticket</a></small>";

        }


    }

    public void Messages()
    {
        DataSet ds_message = new DataSet();
        ds_message = obj_global.GetMessage(User_ID, UserTypeId);

        messages.InnerHtml = "";
        if (ds_message.Tables[0].Rows.Count > 0)
        {
            Session["count"] = ds_message.Tables[1].Rows[0]["ct"].ToString();
            for (int i = 0; i < ds_message.Tables[0].Rows.Count; i++)
            {
                messages.InnerHtml = messages.InnerHtml + "<div class='feed-element'>" +
                   " <a href='#' class='pull-left'>" +
                        "<img alt='image' class='img-circle' src='img/a1.jpg'>" +
                    "</a>" +
                   " <div class='media-body'>" +
                       ds_message.Tables[0].Rows[i]["MSG_MESSAGE"].ToString() +
                         "<br>" +
                    //"<small class='text-muted'>Today 4:21 pm</small>" +
                    "</div>" +
                "</div>";



            }


        }
        else
        {
            Session["count"] = 0;
        }
    }
    public void Consult()
    {
        dt = obj_global.GetConsultationCount(User_ID);
        if (dt.Rows.Count > 0)
        {
            consult.InnerHtml = "<h1 class='no-margins'>" + dt.Rows[0][0].ToString() + "</h1><br> ";
                               // "<small>2:30 PM (30 mins ago)</small><br>" +
                               // "<small>4:00 PM (15 mins ago)</small><br />" +
                               //"<small>6:00 PM (5 mins ago)</small>";
        }
        else
        {

            consult.InnerHtml = "<h1 class='no-margins'>0</h1><br>" +
                               "<br><small><a href='bpd_consultationActive.aspx'>Start New</a></small>";
        }
    }

    public void Funds_fill()
    {
        dt = obj_global.Get_Currentbaldoctor(User_ID);
        if (dt.Rows.Count > 0)
        {
            Funds.InnerHtml = " <h1 class='no-margins'>" +
                               " $ " + dt.Rows[0][0].ToString() + "</h1>" +
                            "<br>" +
                            "<small>Add Funds</small><br>" +
                           " <small>Refund Options</small>";

        }

        else
        {

            Funds.InnerHtml = " <h1 class='no-margins'>" +
                                          " $ " + 0 + "</h1>" +
                                       "<br><small>Add Funds</small><br>" +
                           " <small>Refund Options</small>";


        }
    }
    public void Speciality_Count()
    {
        dt = obj_global.GetdoctorCount();
        doc_count.InnerHtml = dt.Rows[0][0].ToString() + " Total"; // added newly
        DataTable dt_speciality = new DataTable();
        dt_speciality = obj_global.GetSpeciality_Count();

        if (dt_speciality.Rows.Count > 0)
        {
            speciality_count.InnerHtml = "<strong>";
            //speciality_count.InnerHtml = "<div class='stat-percent text-navy'>" + dt.Rows[0][0].ToString() + " Total</div>";
            for (int i = 0; i < dt_speciality.Rows.Count; i++)
            {
                speciality_count.InnerHtml += "<span class='line'>" + dt_speciality.Rows[i]["SPE_SPECIALTY"].ToString() + " - " + dt_speciality.Rows[i]["ct"].ToString() + "</span><br/>";
            }

            speciality_count.InnerHtml += "</strong>";
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

            else if (diff.Minutes >= 1 && diff.Hours == 0)

        time_format = diff.Minutes + "minutes ago";
            if (diff.Minutes == 0 && diff.Hours == 0)
                time_format = "less than a minute ago";
    
            offers.InnerHtml+= "<div class='timeline-item'>" +
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


