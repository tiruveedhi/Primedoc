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
using System.Xml;
using System.Text;
using System.Text.RegularExpressions;

public partial class bpd_liveConsultation : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    DataTable dtSelSpeciality = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                #region get speciality list
                dtSelSpeciality = objDocBLL.getSelectedSpecialities(Convert.ToInt32(Session["userId"]));

                if (dtSelSpeciality.Rows.Count > 0)// check for speciality count
                {
                    for (int i = 0; i < dtSelSpeciality.Rows.Count; i++)
                    {
                        if (dtSelSpeciality.Rows[i][1].ToString().Equals("General Physician"))
                        {
                            lblMsgs.Visible = false;
                            btnReady.Visible = true;
                            return;
                        }
                        else
                        {
                            btnReady.Visible = false;
                            lblMsgs.Visible = true;
                            lblMsgs.Text = "Free video consultation is only for General Physicians.";
                            //ScriptManager.RegisterStartupScript(this, GetType(), "kk", "alert('Free video consultation is only for General Physicians.');", true);
                        }
                    }
                }
                else
                {
                    btnReady.Visible = false;
                    lblMsgs.Visible = true;
                    lblMsgs.Text = "Please register your speciality before start the free video consultation";
                    //ScriptManager.RegisterStartupScript(this, GetType(), "kk", "alert('Please register your speciality before start the free consultation');window.location= 'bpd_professionalBiography.aspx';", true);
                }
                #endregion end of get speciality list

            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }

    }
    GetZoomData objGetZoomData = new GetZoomData();

    protected void btnReady_Click(object sender, EventArgs e)
    {
        if (btnReady.Text == "I am ready")
        {
            //Timer1.Enabled = true;

            Session["hostId"] = objDocBLL.getZoomHostID(Session["userId"].ToString());
            Hashtable htZoomKeys = new Hashtable();
            htZoomKeys.Add("host_id", Session["hostId"].ToString());
            htZoomKeys.Add("topic", "meeting");
            htZoomKeys.Add("type", "1");//1 means instant
            htZoomKeys.Add("option_audio", "both");

            byte[] responseData = objGetZoomData.getZoomData("https://api.zoom.us/v1/meeting/create", htZoomKeys);

            XmlDocument doc = new XmlDocument();
            string xml = Encoding.UTF8.GetString(responseData);
            doc.LoadXml(xml);

            XDocument xdoc = new XDocument();
            xdoc = XDocument.Parse(xml);

            string Join_URL = xdoc.Root.Element("join_url").Value;
            string Start_URL = xdoc.Root.Element("start_url").Value;
            Session["meetingID"] = Regex.Replace(Join_URL, @"\D", "");

            int returnVal = objDocBLL.insDocLiveConsultation(Session["userID"].ToString().Trim(), 2, Start_URL, Join_URL,"Live");// change status to ready -WAITING FOR CALL
            btnReady.Text = "WAITING FOR CALL";
            hfBtnText.Value = "WAITING FOR CALL";
        }
        if (hfBtnText.Value == "END CALL")
        {
            int returnVal = objDocBLL.endLiveConsultation(tbPrescription.Text, tbDiagnosis.Text, String.IsNullOrEmpty(Session["liveConslId"].ToString()) ? null : Session["liveConslId"].ToString());
            objDocBLL.updDocLiveConsCurrentStatus(Session["userId"].ToString(), 1);// Status is OFF LINE - "I AM READY"

            //string hostId = objDocBLL.getZoomHostID(Session["userId"].ToString());
            Hashtable htZoomKeys = new Hashtable();
            htZoomKeys.Add("host_id", Session["hostId"].ToString());
            htZoomKeys.Add("id", Session["meetingID"].ToString());

            byte[] responseData = objGetZoomData.getZoomData("https://api.zoom.us/v1/meeting/end", htZoomKeys);


            btnReady.Text = "I am ready";
            hfBtnText.Value = "I am ready";
            //Timer1.Enabled = true;
        }
    }

    //protected void Timer1_Tick(object sender, EventArgs e)
    //{
    //    if (btnReady.Text == "WAITING FOR CALL")
    //    {
    //        DataTable dtJoinURL = new DataTable();
    //        dtJoinURL = objDocBLL.getJoinURL(Session["userId"].ToString());
    //        if (dtJoinURL != null)
    //        {
    //            divDiagnosis.Visible = true;

    //            string JoinURL = dtJoinURL.Rows[0][0].ToString();
    //            Session["liveConslId"] = dtJoinURL.Rows[0][1].ToString();
    //            string StartURL = dtJoinURL.Rows[0][2].ToString();
    //            //if (JoinURL != null && JoinURL != "")
    //            //{

    //            objDocBLL.updDocLiveConsCurrentStatus(Session["userId"].ToString(), 3); // Status is "IN CALL" - END CALL
                
    //            StringBuilder sb = new StringBuilder();
    //            sb.Append("window.open('" + StartURL + "','Warning', 'dependent=yes,minimizable=no,fullscreen=no,width=525,height=300,left=100,top=100,resizable=yes;status=no,toolbar=no,titlebar=no,menubar=no,location=no,scrollbars=yes');window.focus();");

    //            ScriptManager.RegisterStartupScript(Page, typeof(Page), "dialog", sb.ToString(), true);

    //            btnReady.Text = "END CALL";
    //            Timer1.Enabled = false;
    //            //}
    //        }
    //    }
    //}

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string checkForZoom(string btnReadyText)
    {
        //string btnReadyText = "WAITING FOR CALL"; 
            bpd_liveConsultation thisObject = new bpd_liveConsultation();
        if (btnReadyText == "WAITING FOR CALL")
        {
            DataTable dtJoinURL = new DataTable();
            string uid = HttpContext.Current.Session["userId"].ToString();
            dtJoinURL = thisObject.objDocBLL.getJoinURL(HttpContext.Current.Session["userId"].ToString());
            if (dtJoinURL != null)
            {
                //do this on client side before calling ajax - 1
                //divDiagnosis.Visible = true;

                string JoinURL = dtJoinURL.Rows[0][0].ToString();
                HttpContext.Current.Session["liveConslId"] = dtJoinURL.Rows[0][1].ToString();
                string StartURL = dtJoinURL.Rows[0][2].ToString();                
                
                thisObject.objDocBLL.updDocLiveConsCurrentStatus(HttpContext.Current.Session["userId"].ToString(), 3); // Status is "IN CALL" - END CALL

                //StringBuilder sb = new StringBuilder();
                //sb.Append("window.open('" + StartURL + "','Warning', 'dependent=yes,minimizable=no,fullscreen=no,width=525,height=300,left=100,top=100,resizable=yes;status=no,toolbar=no,titlebar=no,menubar=no,location=no,scrollbars=yes');window.focus();");

                //do this on the client side - 2
                //ScriptManager.RegisterStartupScript(Page, typeof(Page), "dialog", sb.ToString(), true);
                //thisObject.divDiagnosis.Visible = true;
                return StartURL + "~~~" + dtJoinURL.Rows[0][3].ToString();                
            }            
        }
        //if (btnReadyText == "WAITING FOR CALL")
        //{
        //    thisObject.btnReady_Click(thisObject.sender, thisObject.e);
        //}
        return "";
    }
}
