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
public partial class cpd_ratingclose : System.Web.UI.Page
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
            fill_reamrks();
        }

    }
    public void fill_reamrks()
    {
        DataSet ds_remarks = new DataSet();
        ds_remarks = obj_adminbll.get_remarksrating();
        gv_closerating.DataSource = ds_remarks;
        gv_closerating.DataBind();
    }

 
    protected void gv_closerating_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv_closerating.PageIndex = e.NewPageIndex;
        fill_reamrks();
    }
}
