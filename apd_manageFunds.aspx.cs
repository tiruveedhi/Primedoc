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

public partial class apd_manageFunds : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL objPatBLL = new DAC.BLL.clspatientBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                objPatBLL.Patient_id = Convert.ToInt32(Session["userId"]);

                DataTable dt = new DataTable();
                dt = objPatBLL.GetAvailBalance(objPatBLL);
                if (dt.Rows.Count > 0)
                {
                    lblAvailBalance.Text = dt.Rows[0][0].ToString();
                    lblLatestTrans.Text = dt.Rows[0][1].ToString();
                    lblReserBal.Text = dt.Rows[0][2].ToString();
                    lblTransType.Text = dt.Rows[0][3].ToString();
                }
                else
                {
                    lblAvailBalance.Text = "0";
                    lblLatestTrans.Text = "0";
                    lblReserBal.Text = "0";
                    //Page.RegisterStartupScript("k", "<script>alert('No transactions are done.')</script>");
                }
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
    protected void btnViewAllTrans_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewAllTransactions.aspx");
    }
}
