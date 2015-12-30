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

public partial class cpd_consulationclosed : System.Web.UI.Page
{

    DAC.BLL.clsadminBLL obj_adminbll = new DAC.BLL.clsadminBLL();
    DataSet ds_close = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            fillClosed();
        }

    }

    public void fillClosed()
    {
        ds_close = obj_adminbll.Get_Close();
        gvConslClosed.DataSource = ds_close;
        gvConslClosed.DataBind();
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvConslClosed.PageIndex = e.NewPageIndex;
        fillClosed();
    }
    protected void gvConslClosed_RowDataBound(object sender, GridViewRowEventArgs e)
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

