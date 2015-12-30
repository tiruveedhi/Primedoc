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
public partial class Editoffers_Details : System.Web.UI.Page
{
    DAC.BLL.clsadminBLL obj_AdminBLL = new DAC.BLL.clsadminBLL();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        var offer_id = Request.QueryString["offer_id"];
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            Fill_datils();
        }
    }
    DataSet ds_deatils = new DataSet();
    public void Fill_datils()
    {
        var offer_id = Request.QueryString["offer_id"];
        ds_deatils = obj_AdminBLL.get_offerdetails(Convert.ToInt32(offer_id));
        txtoffertype.Text = ds_deatils.Tables[0].Rows[0]["OFFER_NAME"].ToString();
        txtdesc.Text = ds_deatils.Tables[0].Rows[0]["OFFER_DESCRIPTION"].ToString();
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        var offer_id = Request.QueryString["offer_id"];
        int val = obj_AdminBLL.Update_offers(Convert.ToInt32(offer_id), txtoffertype.Text, txtdesc.Text);
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("List_offers.aspx");
    }
}
