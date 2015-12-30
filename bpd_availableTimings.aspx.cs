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
using System.Globalization;
public partial class bpd_availableTimings : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL objClsDocBLL = new DAC.BLL.clsDocBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        objClsDocBLL.DocId = Convert.ToInt32(Session["userId"].ToString());
       

        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }

        if (!IsPostBack)
        {
            Fill_Schedule();
        }


       
    }

    public void Fill_Schedule()
    {
        DataTable dt_timing = new DataTable();
        dt_timing = objClsDocBLL.get_DocAvailSchedule(objClsDocBLL);
        gv_timing.DataSource = dt_timing;
        gv_timing.Columns[0].Visible = true;
        gv_timing.DataBind();
     
        gv_timing.Columns[0].Visible = false;

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
      
        int chbCheckedCount = 0;
        string daysOfWeek = "";

        foreach (ListItem item in cblDays.Items)
        {
            if (item.Selected)
            {
                if (chbCheckedCount == 0)
                    daysOfWeek = item.Text;
                else
                    daysOfWeek += "~" + item.Text;
                chbCheckedCount++;
            }
        }
       
        string From_Time = Request.Form["tbfromTime"];
        if (From_Time == "")
        {
           // ScriptManager.RegisterStartupScript(this, GetType(), "kk", "alert('Unsufficent Balance');", true);

            Page.RegisterStartupScript("kk", "<script> alert('Enter From Time');</script>");

            
        }
        string To_Time = Request.Form["tbtoTime"];
        if (To_Time == "")
        {
      Page.RegisterStartupScript("ok", "<script> alert('Enter To Time');</script>");


        }


        objClsDocBLL.ToDate = tbtoDate.Text;
       objClsDocBLL.FromDate = tbfromDate.Text;

       objClsDocBLL.FromTime = Convert.ToDateTime(From_Time);
       objClsDocBLL.ToTime = Convert.ToDateTime(To_Time);
        objClsDocBLL.DaysWeek = daysOfWeek;

        objClsDocBLL.insDocAvailSchedule(objClsDocBLL);
        Fill_Schedule();
    }




    protected void gv_timing_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int index = Convert.ToInt32(e.RowIndex);
        Label lb_id= (Label)gv_timing.Rows[e.RowIndex].Cells[0].FindControl("lbl_id");

        int result = objClsDocBLL.update_AvailSchedule(Convert.ToInt32(lb_id.Text), true);
        Fill_Schedule();

    }

    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string item = e.Row.Cells[0].Text;
            foreach (Button button in e.Row.Cells[6].Controls.OfType<Button>())
            {
                if (button.CommandName == "Delete")
                {
                    button.Attributes["onclick"] = "if(!confirm('Do you want to delete " + item + "?')){ return false; };";
                }
            }
        }
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv_timing.PageIndex = e.NewPageIndex;
        gv_timing.DataBind();
    }
}
