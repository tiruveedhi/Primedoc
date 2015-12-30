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

public partial class apd_consultationCancelled : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL objPatBLL = new DAC.BLL.clspatientBLL();
    DataTable dtActive = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    private void BindGrid()
    {
        objPatBLL.Patient_id = Convert.ToInt32(Session["userId"]);
        dtActive = objPatBLL.getConslCancelled(objPatBLL);

        gvConslCancelled.Columns[1].Visible = true;

        gvConslCancelled.DataSource = dtActive;
        gvConslCancelled.DataBind();

        gvConslCancelled.Columns[1].Visible = false;
    }
    protected void btnViewDetails_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        //gvConslCancelled.Columns[1].Visible = true;
        string consId = row.Cells[0].Text;
        string docId = row.Cells[1].Text;
        //Session["ConsMessage"] = row.Cells[5].Text;
        //gvConslCancelled.Columns[5].Visible = false;
        Response.Redirect("apd_consultationDetails.aspx?docId=" + docId + "&consID=" + consId + "&page=Cancelled");
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvConslCancelled.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void gvConslCancelled_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[2].Text.Length > 10)
            {
                e.Row.Cells[2].Text = AESEncryptionDecryption.Decrypt(e.Row.Cells[2].Text, AESEncryptionDecryption.KeyString);
            }
        }
    }
}
