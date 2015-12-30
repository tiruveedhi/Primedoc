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

public partial class bpd_consultationCompleted : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
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
        objDocBLL.DocId = Convert.ToInt32(Session["userId"]);
        dtActive = objDocBLL.getConslCompleted(objDocBLL);

        gvConslCompleted.Columns[5].Visible = true;
        gvConslCompleted.DataSource = dtActive;
        gvConslCompleted.DataBind();
        gvConslCompleted.Columns[5].Visible = false;
    }
    protected void btnViewDetails_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        string consId = row.Cells[0].Text;
        string patId = row.Cells[1].Text;

        //gvConslCompleted.Columns[4].Visible = true;
        Session["ConsMessage"] = row.Cells[5].Text;
        //gvConslCompleted.Columns[4].Visible = true;

        Response.Redirect("bpd_consultationDetails.aspx?patId=" + patId + "&consID=" + consId + "&page=Completed");
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvConslCompleted.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void gvConslCompleted_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl_patname = (Label)e.Row.FindControl("lbl_patname");
            DataRowView drv = (DataRowView)e.Row.DataItem;
            if (lbl_patname.Text == "ANONYMOUS")
            {
                lbl_patname.Text = drv["Name"].ToString();
            }
            else
            {

                lbl_patname.Text = AESEncryptionDecryption.Decrypt(drv["Name"].ToString(), AESEncryptionDecryption.KeyString);
            }
        }
    }
}
