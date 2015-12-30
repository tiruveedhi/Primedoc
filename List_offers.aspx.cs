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
public partial class List_offers : System.Web.UI.Page
{
    DAC.BLL.clsadminBLL obj_AdminBLL = new DAC.BLL.clsadminBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            Fill_Offers();
        }

    }
    public void Fill_Offers()
    {
        DataSet ds_offers = new DataSet();
        ds_offers = obj_AdminBLL.Get_offers();
        gv_offers.DataSource = ds_offers;
        gv_offers.DataBind();
        gv_offers.Columns[0].Visible = false;
    }
    protected void btnedit_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        string offer_id = row.Cells[0].Text;
     
       Response.Redirect("Editoffers_Details.aspx?offer_id=" + offer_id );
    }
}
