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

public partial class bpd_scheduledConsultation : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL objClsDocBLL = new DAC.BLL.clsDocBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                bindPatScheduledConsultations();
            }
        }
        else
            Response.Redirect("login.aspx");
    }

    private void bindPatScheduledConsultations()
    {
        DataTable dtPatSchedConsultations = new DataTable();
        objClsDocBLL.DocId = Convert.ToInt32(Session["userId"].ToString());

        dtPatSchedConsultations = objClsDocBLL.getPatScheduledConsultations(objClsDocBLL);

        gvPatSchedConsultations.DataSource = dtPatSchedConsultations;
        gvPatSchedConsultations.Columns[0].Visible = true;
        gvPatSchedConsultations.DataBind();
        gvPatSchedConsultations.Columns[0].Visible = false;
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPatSchedConsultations.PageIndex = e.NewPageIndex;
    }
}
