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

public partial class upcoming_offers : System.Web.UI.Page
{
    DAC.BLL.clsadminBLL obj_AdminBLL = new DAC.BLL.clsadminBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {

        }

    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        int val = obj_AdminBLL.insertoffers(txtoffertype.Text, tbdesc.Text);

    }
}
