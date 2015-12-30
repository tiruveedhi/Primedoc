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
public partial class cpd_managerates : System.Web.UI.Page
{
    DAC.BLL.clsadminBLL obj_adminbll = new DAC.BLL.clsadminBLL();
    DataSet ds_special = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            fill_special();
        }

    }
    public void fill_special()
    {

        ds_special = obj_adminbll.Getspeciality();
        gvsepecial.DataSource = ds_special;
        gvsepecial.DataBind();
        gvsepecial.Columns[0].Visible = false;

    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        int speciality_ID = Convert.ToInt32(row.Cells[0].Text);



        TextBox tb_regualr = (TextBox)row.FindControl("txtregulaer");
        string Regualr = tb_regualr.Text;

        TextBox tb_Express = (TextBox)row.FindControl("txtexpress");
        string Express = tb_Express.Text;

        int Insert_Special = obj_adminbll.InsertSpecilty(speciality_ID, Regualr, Express);
       
        fill_special();
    }


}
