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

public partial class bpd_viewAllTransactions : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DataTable dtAllTrans = new DataTable();

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
    //protected void btnBack_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("bpd_manageFunds.aspx");
    //}
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAllTransactions.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
