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
public partial class cpd_closeticket : System.Web.UI.Page
{

    DAC.BLL.clsadminBLL obj_adminbll = new DAC.BLL.clsadminBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            fill_Closeticket();
        }

    }
    public void fill_Closeticket()
    {
        DataSet ds_open = new DataSet();
      
        ds_open = obj_adminbll.Close_ticket();

        gvClosedTickets.DataSource = ds_open;
        gvClosedTickets.DataBind();
       
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvClosedTickets.PageIndex = e.NewPageIndex;
        fill_Closeticket();
    }
}
