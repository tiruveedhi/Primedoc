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
using System.IO;
using System.Text;
using System.Security.Cryptography;
using DAC;
using System.Globalization;

public partial class apd_personalInformation : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL obj_global = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clspatientBLL obj_patientbll = new DAC.BLL.clspatientBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            tbDob.Attributes.Add("readonly", "readonly");
           
            if (!IsPostBack)
            {
                fill_Gender();
                fill_languages();
                fill_country();
                fill_state();
                fill_city();
                getUserDetails();
                
            }
                
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
    DataTable dtDetails = new DataTable();
    private void getUserDetails()
    {
        obj_global.UserId = Convert.ToInt32(Session["userId"]);
        obj_global.UserTypeId = Convert.ToInt32(Session["userTypeId"]);

        dtDetails = obj_global.getUserDetails(obj_global);
        if (dtDetails.Rows.Count > 0)
        {
            fillUserDetails();
        }
    }

    DataTable dtSelLanguages = new DataTable();
    private void fillUserDetails()
    {
        // show selected languages
        dtSelLanguages = obj_patientbll.getSelectedLanguages(Convert.ToInt32(Session["userId"]));

        for (int i = 0; i < dtSelLanguages.Rows.Count; i++)
        {
            int langId = Convert.ToInt32(dtSelLanguages.Rows[i]["LAG_LANGUAGEID"].ToString());
            ddlLanguage.Items.FindByValue(langId.ToString()).Selected = true;
        }
        // end of show selected languages

        tbEmail.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_EMAIL"].ToString(), AESEncryptionDecryption.KeyString); 
        tbFirstName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_FIRSTNAME"].ToString(), AESEncryptionDecryption.KeyString);
        tbLastName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_LASTNAME"].ToString(), AESEncryptionDecryption.KeyString);
        rbtnGenderList.SelectedValue = dtDetails.Rows[0]["PAT_GENDERID"].ToString();
        if (!dtDetails.Rows[0]["PAT_DOB"].ToString().Equals(""))
        {
            string dob = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_DOB"].ToString(), AESEncryptionDecryption.KeyString);
            DateTime date1 = Convert.ToDateTime(dob.Substring(0,10));
            tbDob.Text = date1.Month.ToString("00") + "/" + date1.Day.ToString("00") + "/" + date1.Year.ToString("0000");
        }
        //ddlLanguage.SelectedValue = dtDetails.Rows[0]["PAT_LANGUAGEID"].ToString();
        ddlcountry.SelectedValue = dtDetails.Rows[0]["PAT_COUNTRYID"].ToString();
        if (ddlcountry.SelectedItem.Text.Equals("India"))
            lblZipcode.Text = "Pin code";
        else
            lblZipcode.Text = "Zip code";
        fill_state();
        ddlstate.SelectedValue = dtDetails.Rows[0]["PAT_STATEID"].ToString();
        fill_city();
        ddlcity.SelectedValue = dtDetails.Rows[0]["PAT_DISTRICTID"].ToString();
        if (dtDetails.Rows[0]["PAT_ADDRESS1"].ToString() != "")
            txtaddress1.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_ADDRESS1"].ToString(), AESEncryptionDecryption.KeyString);
        if (dtDetails.Rows[0]["PAT_ADDRESS2"].ToString() != "")
            txtaddress2.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_ADDRESS2"].ToString(), AESEncryptionDecryption.KeyString);
        txtpincode.Text = dtDetails.Rows[0]["PAT_PINCODE"].ToString();
        if (dtDetails.Rows[0]["PAT_CONTACTNUMBER"].ToString() != "") 
            tbcontact.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_CONTACTNUMBER"].ToString(), AESEncryptionDecryption.KeyString);
        if (dtDetails.Rows[0]["PAT_ANONYMOUS"].ToString() == "False")
            rbnanonymous.SelectedValue = "0";
        if (dtDetails.Rows[0]["PAT_ANONYMOUS"].ToString() == "True")
            rbnanonymous.SelectedValue = "1";
    }

    public void fill_Gender()
    {

        DataSet ds_gender = new DataSet();
        ds_gender = obj_global.getGenderList();
        rbtnGenderList.DataSource = ds_gender;
        rbtnGenderList.DataTextField = "GND_GENDER";
        rbtnGenderList.DataValueField = "GND_GENDERID";
        rbtnGenderList.DataBind();
        rbtnGenderList.SelectedIndex = 0;

    }
    public void fill_languages()
    {
        DataSet ds_language = new DataSet();
        ds_language = obj_global.getLanguages();
        ddlLanguage.DataSource = ds_language;
        ddlLanguage.DataTextField = "LAG_LANGUAGE";
        ddlLanguage.DataValueField = "LAG_LANGUAGEID";
        ddlLanguage.DataBind();

    }
    public void fill_country()
    {
        DataSet ds_country = new DataSet();
        ds_country = obj_global.getCountries();
        ddlcountry.DataSource = ds_country.Tables[0];
        ddlcountry.DataTextField = "CNT_SHORTNAME";
        ddlcountry.DataValueField = "CNT_COUNTRYID";
        ddlcountry.DataBind();
        ddlcountry.SelectedIndex = 0;
    }
    public void fill_state()
    {
        DataSet ds_state = new DataSet();
        obj_global.CountryId = Convert.ToInt32(ddlcountry.SelectedValue.ToString());
        ds_state = obj_global.getStates(obj_global);
        ddlstate.DataSource = ds_state.Tables[0];
        ddlstate.DataTextField = "STT_STATENAME";
        ddlstate.DataValueField = "STT_STATEID";
        ddlstate.DataBind();

    }
    public void fill_city()
    {
        DataSet ds_city = new DataSet();
        obj_global.StateId = Convert.ToInt32(ddlstate.SelectedValue.ToString());
        ds_city = obj_global.getCities(obj_global);
        ddlcity.DataSource = ds_city.Tables[0];
        ddlcity.DataTextField = "DST_DISTRICTNAME";
        ddlcity.DataValueField = "DST_DISTRICTID";
        ddlcity.DataBind();

    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        //string selLanguages = "";
        //for (int i = 0; i < ddlLanguage.Items.Count; i++)
        //{
        //    if (ddlLanguage.Items[i].Selected)
        //    {
        //        selLanguages += ddlLanguage.Items[i].Value;
        //    }
        //}
        
        DataTable dtPatLanguages = new DataTable();
        dtPatLanguages.Columns.AddRange(new DataColumn[2] { new DataColumn("PatId", typeof(int)),
                new DataColumn("LanguageId", typeof(int))});

        for (int i = 0; i < ddlLanguage.Items.Count; i++)
        {
            if (ddlLanguage.Items[i].Selected)
            {
                int languageId = Convert.ToInt32(ddlLanguage.Items[i].Value);
                dtPatLanguages.Rows.Add(Convert.ToInt32(Session["userId"]), languageId);
            }
        }
        int val = obj_patientbll.InsPatientLanguages(dtPatLanguages);

        int temp = -1;

        obj_patientbll.Patient_id = Convert.ToInt32(Session["userId"]); 
        obj_patientbll.FirtsName1 = AESEncryptionDecryption.Encrypt(tbFirstName.Text, AESEncryptionDecryption.KeyString); 
        obj_patientbll.LastName1 = AESEncryptionDecryption.Encrypt(tbLastName.Text, AESEncryptionDecryption.KeyString);
        if (!String.IsNullOrEmpty(rbtnGenderList.SelectedValue))
        {
            obj_patientbll.Gender_id = Convert.ToInt32(rbtnGenderList.SelectedValue.ToString());
        }
        else
            obj_patientbll.Gender_id = -1;

        obj_patientbll.CounteryID = Convert.ToInt32(ddlcountry.SelectedValue);
        obj_patientbll.Stateid = Convert.ToInt32(ddlstate.SelectedValue);
        obj_patientbll.Cityid = int.TryParse(ddlcity.SelectedValue, out temp) ? Convert.ToInt32(ddlcity.SelectedValue) : -1;

        if (tbDob.Text != "")
            //obj_patientbll.Dob = DateTime.ParseExact(tbDob.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            obj_patientbll.Dob = AESEncryptionDecryption.Encrypt(DateTime.ParseExact(tbDob.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture).ToString(), AESEncryptionDecryption.KeyString);
        else
            obj_patientbll.Dob = null;
     
        obj_patientbll.Language = ddlLanguage.SelectedValue;
        obj_patientbll.Address1 = AESEncryptionDecryption.Encrypt(txtaddress1.Text, AESEncryptionDecryption.KeyString);
        obj_patientbll.Address2 = AESEncryptionDecryption.Encrypt(txtaddress2.Text, AESEncryptionDecryption.KeyString);
        obj_patientbll.Pincode = int.TryParse(txtpincode.Text.Trim(), out temp) ? Convert.ToInt32(txtpincode.Text) : -1;
        obj_patientbll.Contactnumber = AESEncryptionDecryption.Encrypt(tbcontact.Text, AESEncryptionDecryption.KeyString);
        obj_patientbll.Imageid = 1;
        obj_patientbll.Anonmous = rbnanonymous.SelectedValue;

        int returnVal = obj_patientbll.Updatepatieninformation(obj_patientbll);

        //if (returnVal > 0)
        //    Page.RegisterStartupScript("submit", "<script> alert('Personal information details are submitted successfully.');</script>");

    }


    protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlcountry.SelectedValue != "")
        {
            if (Convert.ToInt32(ddlcountry.SelectedValue) > 0)
            {
                if (ddlcountry.SelectedItem.Text.Equals("India"))
                {
                    lblZipcode.Text = "Pin code";
                    txtpincode.MaxLength = 6;
                }
                else
                {
                    lblZipcode.Text = "Zip code";
                    txtpincode.MaxLength = 5;
                }
                fill_state();
                fill_city();
            }
        }
    }
    protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlstate.SelectedValue != "")
        {
            if (Convert.ToInt32(ddlstate.SelectedValue) > 0)
            {
                fill_city();
            }
        }

    }
    
}
