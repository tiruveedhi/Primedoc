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
public partial class apd_doctorviewdetails : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clspatientBLL obj_patinetbll = new DAC.BLL.clspatientBLL();
    DataTable dtDetails = new DataTable();
    int doc_Id;

    protected void Page_Load(object sender, EventArgs e)
    {
        doc_Id = Convert.ToInt32(Request.QueryString["docId"]);

        if (!IsPostBack)
        {
            dtDetails = obj_patinetbll.get_DoctorDetails(doc_Id);
            if (dtDetails.Rows.Count > 0)
            {
                fillUserDetails();
                showProfilePic();
            }

        }
    }

    private void showProfilePic()
    {
        if (dtDetails.Rows.Count > 0)
        {
            imgProfile.Src = "~/ProfilePicHandler.ashx?id=" + dtDetails.Rows[0]["DOC_IMAGEID"].ToString();
        }
        else
            imgProfile.Src = "#";
    }

    private void fillUserDetails()
    {
        //lblFirstName.Text = dtDetails.Rows[0]["DOC_FIRSTNAME"].ToString();
        //lblLastName.Text = dtDetails.Rows[0]["DOC_LASTNAME"].ToString();
        //lblGender.Text = dtDetails.Rows[0]["GND_GENDER"].ToString();
        //lblDOB.Text = dtDetails.Rows[0]["DOC_DOB"].ToString();
        //lblLanguage.Text = dtDetails.Rows[0]["LAG_LANGUAGE"].ToString();
        //lblCountry.Text = dtDetails.Rows[0]["CNT_SHORTNAME"].ToString();
        //lblState.Text = dtDetails.Rows[0]["STT_STATENAME"].ToString();
        //lblCity.Text = dtDetails.Rows[0]["DST_DISTRICTNAME"].ToString();
        //lblAddress1.Text = dtDetails.Rows[0]["DOC_ADDRESS1"].ToString();
        //lblAddress2.Text = dtDetails.Rows[0]["DOC_ADDRESS2"].ToString();
        //lblPincode.Text = dtDetails.Rows[0]["DOC_PINCODE"].ToString();
        //lblSPECIALTY.Text = dtDetails.Rows[0]["SPE_SPECIALTY"].ToString();
        //lblProfessional.Text = dtDetails.Rows[0]["DOC_PROF_BIO"].ToString();

        //lblName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_FIRSTNAME"].ToString(), AESEncryptionDecryption.KeyString) + " "
        //    + AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_LASTNAME"].ToString(), AESEncryptionDecryption.KeyString);
        lblName.Text = dtDetails.Rows[0]["DOC_FIRSTNAME"].ToString() + " " + dtDetails.Rows[0]["DOC_LASTNAME"].ToString();
            lblSpeciality.Text = dtDetails.Rows[0]["SPE_SPECIALTY"].ToString();
        lblProfBio.Text = dtDetails.Rows[0]["DOC_PROF_BIO"].ToString();
    }
    protected void btnStartConsl_Click(object sender, EventArgs e)
    {
        //var viewDetails = (Control)sender;
        //GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        //string docId = doc_Id.ToString();
        Response.Redirect("apd_startConsultation.aspx?docId=" + doc_Id.ToString() + "&specialty=" + lblSpeciality.Text);
    }
}
