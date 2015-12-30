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
public partial class apd_closeticket : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL obj_patientbll = new DAC.BLL.clspatientBLL();

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

    public void BindGrid()
    {
        DataSet ds_open = new DataSet();
        //int UserTypeId = Convert.ToInt32(Session["userTypeId"]);

        obj_patientbll.Patient_id = Convert.ToInt32(Session["userId"]);
        obj_patientbll.UserTypeId = Convert.ToInt32(Session["userTypeId"]);

        ds_open = obj_patientbll.closetickets(obj_patientbll);
        gvClosedTickets.DataSource = ds_open;
        gvClosedTickets.DataBind();

        //doctorsList.InnerHtml = "<table class='footable table table-stripped toggle-arrow-tiny' " +
        //    "data-page-size='15'> <thead> <tr><th data-toggle='true'>Ticket Type </th> <th data-hide='phone'> " +
        //     " Description </th><th data-hide='phone'> " +
        //       "</tr></thead> " + "<tbody> ";
        //for (int i = 0; i < ds_open.Tables[0].Rows.Count; i++)
        //{
        //    doctorsList.InnerHtml += "<tr><td>" + ds_open.Tables[0].Rows[i]["TICKET_DESC"] +
        //        "</td><td>" + ds_open.Tables[0].Rows[i]["TICHET_OTHER"] + "</td><td> " +
        //         " </div></td></td></tr>";
        //}
        //doctorsList.InnerHtml += " </tbody><tfoot> <tr><td colspan='6'><ul class='pagination pull-right'>" +
        //                               " </ul></td></tr></tfoot> </table>";
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvClosedTickets.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
