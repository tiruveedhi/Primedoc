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

public partial class bpd_liveConsultationlist : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                Fill_ConsultationList();

            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
    public void Fill_ConsultationList()
    {
        DataTable ds_livelist = new DataTable();
        ds_livelist = objDocBLL.get_liveconsulationlist(Convert.ToInt32(Session["userId"]));
        gv_list.DataSource = ds_livelist;
        gv_list.DataBind();
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv_list.PageIndex = e.NewPageIndex;
        Fill_ConsultationList();
       
    }
}
