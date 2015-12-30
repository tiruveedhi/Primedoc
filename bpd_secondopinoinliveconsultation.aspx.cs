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
using System.Text.RegularExpressions;
using System.Text;
using System.Xml;
public partial class bpd_secondopinoinliveconsultation : System.Web.UI.Page
{
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    Hashtable htZoomKeys = new Hashtable();
    byte[] responseData;
    GetZoomData objGetZoomData = new GetZoomData();
    string schedTimeId;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            schedTimeId = Request.QueryString["schedTimeId"];
            Session["schedTimeId"] = schedTimeId;
            objDocBLL.updIsDocPresentStatus(schedTimeId);

            if (!IsPostBack)
            {

                Session["hostId"] = objDocBLL.getZoomHostID(Session["userId"].ToString());

                htZoomKeys.Add("host_id", Session["hostId"].ToString());
                htZoomKeys.Add("topic", "meeting");
                htZoomKeys.Add("type", "1");//1 means instant
                htZoomKeys.Add("option_audio", "both");

                responseData = objGetZoomData.getZoomData("https://api.zoom.us/v1/meeting/create", htZoomKeys);

                XmlDocument doc = new XmlDocument();
                string xml = Encoding.UTF8.GetString(responseData);
                doc.LoadXml(xml);

                XDocument xdoc = new XDocument();
                xdoc = XDocument.Parse(xml);

                string Join_URL = xdoc.Root.Element("join_url").Value;
                string Start_URL = xdoc.Root.Element("start_url").Value;
                Session["meetingID"] = Regex.Replace(Join_URL, @"\D", "");
                int returnVal = objDocBLL.insDocLiveConsultation_SP(Session["userID"].ToString().Trim(), 2, Start_URL, Join_URL, "SECOND OPINION", schedTimeId);// change status to ready -WAITING FOR CALL
                hfBtnText.Value = "Waiting For Patient";
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

     [System.Web.Services.WebMethod(EnableSession = true)]
    public static string checkForZoom(string btnReadyText)
    {
            bpd_secondopinoinliveconsultation thisObject = new bpd_secondopinoinliveconsultation();
        if (btnReadyText == "Waiting For Patient")
        {
            DataTable dtStartURL = new DataTable();
            string uid = HttpContext.Current.Session["userId"].ToString();
            dtStartURL = thisObject.objDocBLL.getdtStartURL_SP(HttpContext.Current.Session["userId"].ToString(), HttpContext.Current.Session["schedTimeId"].ToString());
            if (dtStartURL != null)
            {
                //HttpContext.Current.Session["liveConslId"] = dtJoinURL.Rows[0][1].ToString();
                string StartURL = dtStartURL.Rows[0][0].ToString();                
                
                thisObject.objDocBLL.updDocLiveConsCurrentStatus(HttpContext.Current.Session["userId"].ToString(), 3); // Status is "IN CALL" - END CALL

                return StartURL;                
            }            
        }
     
        return "";
    }
     protected void btnReady_Click(object sender, EventArgs e)
     {
         if (hfBtnText.Value == "END CALL")
         {
             objDocBLL.updDocLiveConsCurrentStatus(Session["userId"].ToString(), 1);// Status is OFF LINE - "I AM READY"
            
             htZoomKeys.Add("host_id", Session["hostId"].ToString());
             htZoomKeys.Add("id", Session["meetingID"].ToString());

             responseData = objGetZoomData.getZoomData("https://api.zoom.us/v1/meeting/end", htZoomKeys);
             Response.Redirect("bpd_startSecondOpinion.aspx");
         }
     }
}
