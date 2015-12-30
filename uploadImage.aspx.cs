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

public partial class uploadImage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            Session["userPic"] = true;                                                                                             
            //int userTypeId = Convert.ToInt32(Session["userTypeId"].ToString());
            //if (userTypeId == 1)
            //    Response.Redirect("apd_home.aspx");
            //if (userTypeId == 2)
            //    Response.Redirect("bpd_home.aspx");
            //if (userTypeId == 3)
            //    Response.Redirect("cpd_home.aspx");
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
}
