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

public partial class apd_consultationActive : System.Web.UI.Page
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
        dtActive = objPatBLL.getConslActive(objPatBLL);

        gvConslActive.Columns[1].Visible = true;
        gvConslActive.Columns[6].Visible = true;

        gvConslActive.DataSource = dtActive;
        gvConslActive.DataBind();

        gvConslActive.Columns[6].Visible = false;
        gvConslActive.Columns[1].Visible = false;
    }
    protected void btnViewDetails_Click(object sender, EventArgs e)
    {
        //gvConslActive.Columns[1].Visible = true;
        //gvConslActive.Columns[6].Visible = true;
        //BindGrid();

        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        string consId = row.Cells[0].Text;
        string docId = row.Cells[1].Text;
        Session["canCancel"] = row.Cells[6].Text;
        Response.Redirect("apd_consultationDetails.aspx?docId=" + docId + "&consID=" + consId + "&page=Active");
    }




    protected void gvConslActive_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    int hour = (DataBinder.Eval(e.Row.DataItem, "Difference") == DBNull.Value) ? 0 :
        //        Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Difference"));
        //    if (hour <= 4)
        //    {
        //        e.Row.BackColor = ColorTranslator.FromHtml("#afd07b");// Color.Green;
        //        e.Row.ForeColor = Color.White;
        //    }
        //    if (hour > 4)
        //    {
        //        e.Row.BackColor = ColorTranslator.FromHtml("#d24242");//Color.Red;
        //        e.Row.ForeColor = Color.White;
        //    }
        //}

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[2].Text.Length > 10)
            {
                e.Row.Cells[2].Text = AESEncryptionDecryption.Decrypt(e.Row.Cells[2].Text, AESEncryptionDecryption.KeyString);
            }
        }
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvConslActive.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
