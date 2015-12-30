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
using System.Text;
public partial class apd_liveConsultation : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL objPATBLL = new DAC.BLL.clspatientBLL();
    int returnVal;
    DataTable dtDocAvailbility = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                dtDocAvailbility = objPATBLL.chkDoctorsAvailability();
                if (dtDocAvailbility.Rows.Count > 0)
                {
                    divPatSymp.Style.Add("display", "block"); //btnLiveConsul.Visible = true;
                    lblMsgs.Style.Add("display", "none"); //lblMsgs.Visible = false;
                }
                else
                {
                    divPatSymp.Style.Add("display", "none");// btnLiveConsul.Visible = false;
                    lblMsgs.Style.Add("display", "block"); //lblMsgs.Visible = true;
                    lblMsgs.Text = "Doctors are not available. Please try later.";
                }
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
    protected void btnLiveConsul_Click(object sender, EventArgs e)
    {
        dtDocAvailbility = objPATBLL.chkDoctorsAvailability();
        if (dtDocAvailbility.Rows.Count > 0)
        {
            var rand = new Random();
            var result = dtDocAvailbility.AsEnumerable().OrderBy(r => rand.Next());

            DataRow dr1;
            dr1 = result.First();

            returnVal = objPATBLL.insLiveConsultaion(dr1[0].ToString(), Session["userId"].ToString(), "Waiting for doctor", dr1[2].ToString(), tbSymptoms.Text);
            hfLiveCnsID.Value = returnVal.ToString();

            divDocAdvice.Style.Add("display", "block");
            hfZoom.Value = "true";
            StringBuilder sb = new StringBuilder();
            sb.Append("window.open('" + dr1[2].ToString() + "','Warning', 'dependent=yes,minimizable=no,fullscreen=no,width=525,height=300,left=100,top=100,resizable=yes;status=no,toolbar=no,titlebar=no,menubar=no,location=no,scrollbars=yes');window.focus();");

            ScriptManager.RegisterStartupScript(Page, typeof(Page), "dialog", sb.ToString(), true);

        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string invokeZoom(string LiveCnsID)
    {
        apd_liveConsultation thisObject = new apd_liveConsultation();
        thisObject.dtDocAvailbility = thisObject.objPATBLL.chkDoctorsAvailability();
        if (thisObject.dtDocAvailbility.Rows.Count > 0)
        {
            return "true";
        }
        else
        {
            if (LiveCnsID != "false")
            {
                DataTable dtDocAdv = new DataTable();
                dtDocAdv = thisObject.objPATBLL.getDoctorAdvice_Live(LiveCnsID);
                if (dtDocAdv.Rows[0][0].ToString()!="")
                {
                    return "true" + "~~~" + dtDocAdv.Rows[0][0].ToString() + "~~~" + dtDocAdv.Rows[0][1].ToString(); 
                }
                else
                {
                    return "true"; 
                }
            }
            else
                return "false";
        }
        
    }
}
