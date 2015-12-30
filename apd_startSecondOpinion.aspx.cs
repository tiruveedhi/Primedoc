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
using System.Collections.Generic;
using System.Globalization;

public partial class apd_startSecondOpinion : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL objClsPatBLL = new DAC.BLL.clspatientBLL();
    DAC.BLL.clsDocBLL objClsDocBLL = new DAC.BLL.clsDocBLL();
    string conslId;

    protected void Page_Load(object sender, EventArgs e)
    {
        tbSelectedDate.Attributes.Add("readonly", "readonly");
        if (Session["userName"] != null)
        {
            var docId = Request.QueryString["docId"];
            if (Session["ConslId"] != null)
            {
                conslId = Session["ConslId"].ToString();
                DataTable dtDocSplty = new DataTable();
                dtDocSplty = objClsPatBLL.getDocSpecialityandRate(conslId);

                lblSpeciality.Text = dtDocSplty.Rows[0][1].ToString();
                this.lblDocName.Text = dtDocSplty.Rows[0][0].ToString();
            }
            bindDocAvailTimings(docId);
        }
        else
            Response.Redirect("login.aspx");
    }
    private void bindDocAvailTimings(string docID)
    {
        DataTable dtAvailTimings = new DataTable();
        objClsDocBLL.DocId = Convert.ToInt32(docID);
        dtAvailTimings = objClsDocBLL.get_DocAvailSchedule(objClsDocBLL);
        gvDocAvailTimings.DataSource = dtAvailTimings;
        gvDocAvailTimings.Columns[0].Visible = true;
        gvDocAvailTimings.DataBind();
        gvDocAvailTimings.Columns[0].Visible = false;
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvDocAvailTimings.PageIndex = e.NewPageIndex;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string scheduledDate = tbSelectedDate.Text;
        string scheduledTime = ddlTime.Text;

        int availId = objClsPatBLL.chkDocAvailTimings(Request.QueryString["docId"], scheduledDate, scheduledTime);

        objClsPatBLL.DocID = Request.QueryString["docId"].ToString();
        objClsPatBLL.Consulation_id = Convert.ToInt32(conslId);
        objClsPatBLL.ScheduledDate = scheduledDate;
        objClsPatBLL.ScheduledTime = scheduledTime;

        if (availId > 0)
            Session["SchedTimeID"] = objClsPatBLL.InsPatSecondOpinionTimings(objClsPatBLL);
        else
            ScriptManager.RegisterStartupScript(this, GetType(), "kk", "alert('Doctor is not available for selected date');", true);
    }
    protected void tbSelectedDate_TextChanged(object sender, EventArgs e)
    {
        string scheduledDate = tbSelectedDate.Text;
        DataTable dtTimings = new DataTable();
        dtTimings = objClsPatBLL.getDocAvailTimings(Request.QueryString["docId"].ToString(), scheduledDate);

        if (dtTimings.Rows[0][0].ToString() != "")
        {
            ddlTime.Visible = true;

            DateTime start = DateTime.ParseExact(dtTimings.Rows[0][0].ToString(), "HH:mm:ss",
                                            CultureInfo.InvariantCulture);
            DateTime end = DateTime.ParseExact(dtTimings.Rows[0][1].ToString(), "HH:mm:ss", CultureInfo.InvariantCulture);

            int interval = 15;
            List<string> lstTimeIntervals = new List<string>();
            for (DateTime i = start; i < end; i = i.AddMinutes(interval))
                lstTimeIntervals.Add(i.ToString("HH:mm tt"));

            ddlTime.DataSource = lstTimeIntervals;
            ddlTime.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "kk", "alert('Doctor is not available for selected date');", true);
            ddlTime.Visible = false;
        }
    }
    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("apd_consultationCompleted.aspx");
    }
}
