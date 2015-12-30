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
public partial class contactSupport : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL obj_global = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clspatientBLL obj_patientbll = new DAC.BLL.clspatientBLL();
    DataSet ds_ticket = new DataSet();
    DataTable dtDetails = new DataTable();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                Fill_ticket();
                getContactDetails();
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    private void getContactDetails()
    {
        obj_global.UserId = Convert.ToInt32(Session["userId"]);
        obj_global.UserTypeId = Convert.ToInt32(Session["userTypeId"]);

        dtDetails = obj_global.getContactDetails(obj_global);
        if (dtDetails.Rows.Count > 0)
        {
            //fillContactDetails();
        }
    }

    private void fillContactDetails()
    {
        ddlticket.SelectedValue = dtDetails.Rows[dtDetails.Rows.Count-1]["TICKET_ID"].ToString();
        tbdesc.Text = dtDetails.Rows[dtDetails.Rows.Count - 1]["TICHET_OTHER"].ToString();
    }

    public void Fill_ticket()
    {
        ds_ticket = obj_global.Get_ticket();
        ddlticket.DataTextField = "TICKET_DESC";
        ddlticket.DataValueField = "TICKET_ID";
        ddlticket.DataSource = ds_ticket;
        ddlticket.DataBind();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
      
        obj_patientbll.Patient_id = Convert.ToInt32(Session["userId"]);
        obj_patientbll.UserTypeId = Convert.ToInt32(Session["userTypeId"]);
        obj_patientbll.Ticket_id =Convert.ToInt32(ddlticket.SelectedValue);
        
        obj_patientbll.Ticketdesc = tbdesc.Text;
        obj_patientbll.Ticket_status = 1;
        obj_patientbll.Insert_NewTicket(obj_patientbll);

        //clear the fields

        Page.RegisterStartupScript("kk", "<script> alert('Ticket is Submitted');</script>");

        ddlticket.SelectedIndex = 0;
        tbdesc.Text = "";



    }
}
