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

public partial class viewAllTransactions : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DataTable dtAllTrans = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                int userId = Convert.ToInt32(Session["userId"]);
                int userTypeId = Convert.ToInt32(Session["userTypeId"]);

                dtAllTrans = objGlobalBLL.GetAllTransactions(userId, userTypeId);
                if (dtAllTrans.Rows.Count > 0)
                {
                    divGrid.Visible = true;
                    gvAllTransactions.DataSource = dtAllTrans;
                    gvAllTransactions.DataBind();
                }
                else
                {
                    divGrid.Visible = false;
                }
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }

    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        int userTypeId = Convert.ToInt32(Session["userTypeId"]);
        if (userTypeId == 1)
            Response.Redirect("apd_manageFunds.aspx");
        if(userTypeId==2)
            Response.Redirect("bpd_manageFunds.aspx");
    }
}
