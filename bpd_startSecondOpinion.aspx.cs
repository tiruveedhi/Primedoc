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

public partial class bpd_startSecondOpinion : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL objClsDocBLL = new DAC.BLL.clsDocBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                bindPatSecondOpinionConsultations();
            }
        }
        else
            Response.Redirect("login.aspx");
    }
    private void bindPatSecondOpinionConsultations()
    {
        DataTable dtPatSecOpinionConsultations = new DataTable();
        objClsDocBLL.DocId = Convert.ToInt32(Session["userId"].ToString());

        dtPatSecOpinionConsultations = objClsDocBLL.getPatSecOpinionConsultations(objClsDocBLL);

        gvPatSecondOpinion.Columns[0].Visible = true;
        gvPatSecondOpinion.DataSource = dtPatSecOpinionConsultations;
        gvPatSecondOpinion.DataBind();
        gvPatSecondOpinion.Columns[0].Visible = false;
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPatSecondOpinion.PageIndex = e.NewPageIndex;
        bindPatSecondOpinionConsultations();
    }

    protected void btnjoin_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        string ID = row.Cells[0].Text;

        Response.Redirect("bpd_secondopinoinliveconsultation.aspx?schedTimeId=" + ID);
    }
}
