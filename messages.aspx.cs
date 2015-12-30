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

public partial class messages : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DataTable dtMsgs = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                dtMsgs = getMessages();

               divMessage.InnerHtml = "<table class='footable table table-stripped toggle-arrow-tiny' data-page-size='15'>"+
                           "<tbody>";
               for (int i = 0; i < dtMsgs.Rows.Count; i++)
               {
                   divMessage.InnerHtml += "<tr><td>" + dtMsgs.Rows[i][0].ToString() + "</td><td>" + dtMsgs.Rows[i][1].ToString()
                                           + "</td></tr>";
               }
               divMessage.InnerHtml += "</tbody><tfoot><tr><td colspan='6'><ul class='pagination pull-right'></ul></td></tr></tfoot></table>";
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    private DataTable getMessages()
    {
        objGlobalBLL.UserTypeId = Convert.ToInt32(Session["userTypeId"]);
        objGlobalBLL.UserId = Convert.ToInt32(Session["userId"]);

        return (objGlobalBLL.getMessages(objGlobalBLL));
    }
}
