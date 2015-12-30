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
public partial class cpd_openticket : System.Web.UI.Page
{
    DAC.BLL.clsadminBLL obj_adminbll = new DAC.BLL.clsadminBLL();
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            fill();
        }

    }
    public void fill()
    {
        DataSet ds_open = new DataSet();
        //int UserTypeId = Convert.ToInt32(Session["userTypeId"]);

        ds_open = obj_adminbll.Search_opentickets();
       
        gvOpenTicket.Columns[0].Visible = true;
        gvOpenTicket.Columns[1].Visible = true;
        gvOpenTicket.Columns[2].Visible = true;
       
        gvOpenTicket.DataSource = ds_open;
        gvOpenTicket.DataBind();
        
        gvOpenTicket.Columns[0].Visible = false;
        gvOpenTicket.Columns[1].Visible = false;
        gvOpenTicket.Columns[2].Visible = false;
    }
    int ticketid, User_id, UserType_id;
    protected void btnclose_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        //ticketid =Convert.ToInt32(row.Cells[0].Text);
        //User_id=Convert.ToInt32(row.Cells[1].Text);
        //UserType_id=Convert.ToInt32(row.Cells[2].Text);

        lblTicketId.Text = row.Cells[0].Text;
        lblUserId.Text = row.Cells[1].Text;
        lblUserTypeId.Text = row.Cells[2].Text;
        btnClose_modalpopupextender.Show();

        //int status = 2;
        //int close_ticket = obj_adminbll.Updateclose_ticket(ticketid, status);
      
        //objGlobalBLL.ToId = User_id;
        //objGlobalBLL.ToTypeId = UserType_id;
        //objGlobalBLL.Subject = "Closed Tickets";
        //objGlobalBLL.Message = "Ticket closed";
        //int Message_insert = objGlobalBLL.InsMessages(objGlobalBLL);
        //fill();
    }
    protected void btnDone_Click(object sender, EventArgs e)
    {
        int status = 2;
        int close_ticket = obj_adminbll.Updateclose_ticket(Convert.ToInt32(lblTicketId.Text),tbRemarks.Text, status);

        objGlobalBLL.ToId = Convert.ToInt32(lblUserId.Text);
        objGlobalBLL.ToTypeId = Convert.ToInt32(lblUserTypeId.Text);
        objGlobalBLL.Subject = "Closed Tickets";
        objGlobalBLL.Message = "Ticket closed";
        int Message_insert = objGlobalBLL.InsMessages(objGlobalBLL);
        fill();
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvOpenTicket.PageIndex = e.NewPageIndex;
        fill();
    }
}
