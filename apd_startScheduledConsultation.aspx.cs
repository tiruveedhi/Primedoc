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
using System.Web.Script.Services;
using System.Web.Services;

public partial class apd_startScheduledConsultation : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL objClsDocBLL = new DAC.BLL.clsDocBLL();
    DAC.BLL.clspatientBLL objClsPatBLL = new DAC.BLL.clspatientBLL();
    string specialityId;
    int docUsertype;
    string docDetails, conslId;

    protected void Page_Load(object sender, EventArgs e)
    {
       // tbSelectedDate.Attributes.Add("readonly", "readonly");

        if (Session["userName"] != null)
        {
            var docId = Request.QueryString["docId"];
            hidden_docid.Value = docId;
            if (Session["DocVariables"] != null)
            {
                docDetails = Session["DocVariables"].ToString();

                string[] splitDocDetails = docDetails.Split('~');
                this.lblDocName.Text = splitDocDetails[0].ToString();
                string[] docSpeciality = splitDocDetails[1].Split('/');

                rbtnSpecialities.DataSource = docSpeciality;
                rbtnSpecialities.DataBind();
                rbtnSpecialities.Items[0].Selected = true;
                DataSet dsSpecialityRates = new DataSet();
                dsSpecialityRates = objClsPatBLL.Get_consulationrate(docId, rbtnSpecialities.SelectedItem.Value);
                if (dsSpecialityRates.Tables[0].Rows.Count > 0)
                {
                   lbl.Text = dsSpecialityRates.Tables[0].Rows[0]["DSP_EXPRESS_RATE"].ToString();
                    lblrate.Text = dsSpecialityRates.Tables[0].Rows[0]["DSP_REGULAR_RATE"].ToString();

                    specialityId = dsSpecialityRates.Tables[0].Rows[0]["SPE_SPECIALTIYID"].ToString();
                    docUsertype = Convert.ToInt32(dsSpecialityRates.Tables[0].Rows[0]["DOC_USERTYPEID"].ToString());
                }
            }
            bindDocAvailTimings(docId);
        }
        else
            Response.Redirect("login.aspx");

    }
    protected void rbtnSpecialities_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DataSet dsSpecialityRates = new DataSet();
        //dsSpecialityRates = objClsPatBLL.Get_consulationrate(Request.QueryString["docId"], rbtnSpecialities.SelectedItem.Value);
        //if (dsSpecialityRates.Tables[0].Rows.Count > 0)
        //{
        //    lblExpressRate.Text = dsSpecialityRates.Tables[0].Rows[0]["DSP_EXPRESS_RATE"].ToString();
        //    lblRegularRate.Text = dsSpecialityRates.Tables[0].Rows[0]["DSP_REGULAR_RATE"].ToString();

        //    specialityId = dsSpecialityRates.Tables[0].Rows[0]["SPE_SPECIALTIYID"].ToString();
        //    docUsertype = Convert.ToInt32(dsSpecialityRates.Tables[0].Rows[0]["DOC_USERTYPEID"].ToString());
        //}
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
        if (availId > 0)
            objClsPatBLL.InsPatScheduledTimings(availId, Request.QueryString["docId"], Session["userId"].ToString(), scheduledDate, scheduledTime);
        else
            ScriptManager.RegisterStartupScript(this, GetType(), "kk", "alert('Doctor is not available for selected date');", true);
    }
    protected void tbSelectedDate_TextChanged(object sender, EventArgs e)
    {
        string scheduledDate = tbSelectedDate.Text;
        DataTable dtTimings = new DataTable();
        dtTimings = objClsPatBLL.getDocAvailTimings(Request.QueryString["docId"].ToString(), scheduledDate);

        //ddlTime.DataSource = dtTimings;
        //ddlTime.DataBind();

        if (dtTimings.Rows[0][0].ToString() != "")
        {
            ddlTime.Visible = true;

            DateTime start = DateTime.ParseExact(dtTimings.Rows[0][0].ToString(), "HH:mm:ss",
                                            CultureInfo.InvariantCulture);
            //DateTime.ParseExact(dtTimings.Rows[0][0].ToString(), "HH:mm tt", CultureInfo.InvariantCulture);
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

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string get_specialtyrates(string doc_id, string value)
    {

        DAC.BLL.clspatientBLL objClsPatBLL = new DAC.BLL.clspatientBLL();
        DataSet ds = new DataSet();

        ds = objClsPatBLL.Get_consulationrate(doc_id, value);

        return ds.Tables[0].Rows[0]["DSP_EXPRESS_RATE"].ToString() + "," + ds.Tables[0].Rows[0]["DSP_REGULAR_RATE"].ToString() + ", " + ds.Tables[0].Rows[0]["SPE_SPECIALTIYID"].ToString() + "," + ds.Tables[0].Rows[0]["DOC_USERTYPEID"].ToString();

    }
}
