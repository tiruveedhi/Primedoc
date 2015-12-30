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

public partial class bpd_Managerates : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL Obj_DocBLL = new DAC.BLL.clsDocBLL();
    DataTable dt_specialtyrate = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Bind();
        }
    }

    public void Bind()
    {

        dt_specialtyrate=Obj_DocBLL.GET_SPECIALITIERATE(Convert.ToInt32(Session["userId"]));
        gv_rates.DataSource = dt_specialtyrate;
        gv_rates.DataBind();
    }



}
