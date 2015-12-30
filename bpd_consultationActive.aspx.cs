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
using System.Drawing;

public partial class bpd_consultationActive : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    DataTable dtActive = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                fill();  
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
    public void fill()
    {
        objDocBLL.DocId = Convert.ToInt32(Session["userId"]);
        dtActive = objDocBLL.getConslActive(objDocBLL);

        gvConslActive.DataSource = dtActive;
        gvConslActive.DataBind();
        gvConslActive.Columns[5].Visible = false;
    }

    protected void btnViewDetails_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        string consId = row.Cells[0].Text;
        string patId = row.Cells[1].Text;

        Response.Redirect("bpd_consultationDetails.aspx?patId=" + patId + "&consID=" + consId + "&page=Active&action=View");
    }
    protected void btnPickedup_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        string consId = row.Cells[0].Text;
        string patId = row.Cells[1].Text;

        objDocBLL.updConsCancelled(consId, Session["userId"].ToString());// UPDATE CONSULTATION CANCEL STATUS TO '0'

        Response.Redirect("bpd_consultationDetails.aspx?patId=" + patId + "&consID=" + consId + "&page=Active&action=Picked");
    }


    protected void gvConslActive_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int hour = (DataBinder.Eval(e.Row.DataItem, "Difference") == DBNull.Value) ? 0 :
                Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Difference"));
            if (hour <= 4)
            {
                e.Row.BackColor = ColorTranslator.FromHtml("#18a689");// Color.Green;
                e.Row.ForeColor = Color.White;
            }
            if (hour > 4)
            {
                e.Row.BackColor = ColorTranslator.FromHtml("#ed5565");//Color.Red;
                e.Row.ForeColor = Color.White;
            }

         
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
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        fill();
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvConslActive.PageIndex = e.NewPageIndex;
        fill();
    }
}
