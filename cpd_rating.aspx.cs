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
public partial class cpd_rating : System.Web.UI.Page
{
    DAC.BLL.clsadminBLL obj_AdminBLL = new DAC.BLL.clsadminBLL();
    DataSet ds_rating = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            fill_rating();
        }
    }
    public void fill_rating()
    {
        ds_rating = obj_AdminBLL.get_rating();

        for (int i = 0; i< ds_rating.Tables[0].Rows.Count; i++)
        {
                gvrating.DataSource = ds_rating;
                gvrating.Columns[0].Visible = true;
                gvrating.DataBind();
                gvrating.Columns[0].Visible = false;  
           
        }
       
    }
    protected void btnremarks_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;
        lblratingid.Text = row.Cells[0].Text;
        btnremarks_modalpopupextender.Show();
    }
    protected void btnDone_Click(object sender, EventArgs e)
    {

        int val = obj_AdminBLL.update_starrating(tbRemarks.Text, true, Convert.ToInt32(lblratingid.Text));
        fill_rating();
    }

    protected void gvrating_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvrating.PageIndex = e.NewPageIndex;
        fill_rating();
    }
    protected void btndeatils_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;
        string pat_id = row.Cells[1].Text;
        string consId = row.Cells[3].Text;
        string DocID = row.Cells[2].Text;
        Response.Redirect("panellist.aspx?DocID=" + DocID + "&consID=" + consId + "&pat_id=" + pat_id + "&page=Completed");
    }

}
