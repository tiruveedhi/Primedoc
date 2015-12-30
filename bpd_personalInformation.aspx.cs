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
using System.Text.RegularExpressions;

public partial class bpd_personalInformation : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();

    DataSet dsGender = null;
    DataSet dsLanguage = null;
    DataSet dsCountry = null;
    DataSet dsState = null;
    DataSet dsCity = null;

    int val = 0;
    DataTable dtDetails = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Session["userName"] != null)
        {
            tbDob.Attributes.Add("readonly", "readonly");
            if (!IsPostBack)
            {
                BindLists(); 
                getUserDetails();
               
                //BIND MULTIPLE LANGUAGES TO LISTBOX
            }



        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    private void getUserDetails()
    {
        objGlobalBLL.UserId = Convert.ToInt32(Session["userId"]);
        objGlobalBLL.UserTypeId = Convert.ToInt32(Session["userTypeId"]);

        dtDetails = objGlobalBLL.getUserDetails(objGlobalBLL);
        if (dtDetails.Rows.Count > 0)
        {
            fillUserDetails();
        }
    }
    DataTable dtSelLanguages = new DataTable();
    private void fillUserDetails()
    {
         // show selected languages
        dtSelLanguages = objDocBLL.getSelectedLanguages(Convert.ToInt32(Session["userId"]));

        for (int i = 0; i < dtSelLanguages.Rows.Count; i++)
        {
            int langId = Convert.ToInt32(dtSelLanguages.Rows[i]["LAG_LANGUAGEID"].ToString());
            ddlLanguage.Items.FindByValue(langId.ToString()).Selected = true;
        }
        // end of show selected languages


        //tbFirstName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_FIRSTNAME"].ToString(), AESEncryptionDecryption.KeyString); 
        //tbLastName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_LASTNAME"].ToString(), AESEncryptionDecryption.KeyString);
        tbFirstName.Text = dtDetails.Rows[0]["DOC_FIRSTNAME"].ToString();
        tbLastName.Text = dtDetails.Rows[0]["DOC_LASTNAME"].ToString();
        rbtnGender.SelectedValue = dtDetails.Rows[0]["DOC_GENDERID"].ToString();
        if (!dtDetails.Rows[0]["DOC_DOB"].ToString().Equals(""))
        {
            DateTime date1 = Convert.ToDateTime(AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_DOB"].ToString(), AESEncryptionDecryption.KeyString).Substring(0, 10));
            tbDob.Text = date1.Month.ToString("00") + "/" + date1.Day.ToString("00") + "/" + date1.Year.ToString("0000");
           // tbMM.Text = date1.Month.ToString();
           // tbYYYY.Text = date1.Year.ToString();
        } 
        //ddlLanguage.SelectedValue = dtDetails.Rows[0]["DOC_LANGUAGEID"].ToString();
        ddlCountry.SelectedValue = dtDetails.Rows[0]["DOC_COUNTRYID"].ToString();
        if (ddlCountry.SelectedItem.Text.Equals("India"))
            lblZipcode.Text = "Pin code";
        else
            lblZipcode.Text = "Zip code";
        getStates(); 
        ddlState.SelectedValue = dtDetails.Rows[0]["DOC_STATEID"].ToString();
        getCities();
        ddlCity.SelectedValue = dtDetails.Rows[0]["DOC_DISTRICTID"].ToString();
        if (dtDetails.Rows[0]["DOC_ADDRESS1"].ToString() != "") 
            tbAddress1.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_ADDRESS1"].ToString(), AESEncryptionDecryption.KeyString);
        if (dtDetails.Rows[0]["DOC_ADDRESS2"].ToString() != "") 
            tbAddress2.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_ADDRESS2"].ToString(), AESEncryptionDecryption.KeyString);
        tbPincode.Text = dtDetails.Rows[0]["DOC_PINCODE"].ToString();
        tbEmail.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_EMAIL"].ToString(), AESEncryptionDecryption.KeyString);
        if (dtDetails.Rows[0]["DOC_CONTACTNUMBER"].ToString() != "") 
            tbcontact.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_CONTACTNUMBER"].ToString(), AESEncryptionDecryption.KeyString);
    }
    private void BindLists()
    {
        getGenderList();
        getLanguages();
        getCountries();
        getStates();
        getCities();
    }

    private void getCities()
    {
        dsCity = new DataSet();
        objGlobalBLL.StateId = Convert.ToInt32(ddlState.SelectedValue.ToString());
        dsCity = objGlobalBLL.getCities(objGlobalBLL);
        ddlCity.DataSource = dsCity.Tables[0];
        ddlCity.DataTextField = "DST_DISTRICTNAME";
        ddlCity.DataValueField = "DST_DISTRICTID";
        ddlCity.DataBind();
    }

    private void getStates()
    {
        dsState = new DataSet();
        objGlobalBLL.CountryId = Convert.ToInt32(ddlCountry.SelectedValue.ToString());
        dsState = objGlobalBLL.getStates(objGlobalBLL);
        ddlState.DataSource = dsState.Tables[0];
        ddlState.DataTextField = "STT_STATENAME";
        ddlState.DataValueField = "STT_STATEID";
        ddlState.DataBind();
    }

    private void getCountries()
    {
        dsCountry = new DataSet();
        dsCountry = objGlobalBLL.getCountries();
        ddlCountry.DataSource = dsCountry.Tables[0];
        ddlCountry.DataTextField = "CNT_SHORTNAME";
        ddlCountry.DataValueField = "CNT_COUNTRYID";
        ddlCountry.DataBind();
        ddlCountry.SelectedIndex = 0;
    }

    private void getLanguages()
    {
        dsLanguage = new DataSet();
        dsLanguage = objGlobalBLL.getLanguages();
        ddlLanguage.DataSource = dsLanguage.Tables[0];
        ddlLanguage.DataTextField = "LAG_LANGUAGE";
        ddlLanguage.DataValueField = "LAG_LANGUAGEID";
        ddlLanguage.DataBind();
    }

    private void getGenderList()
    {
        dsGender = new DataSet();
        dsGender = objGlobalBLL.getGenderList();
        rbtnGender.DataSource = dsGender.Tables[0];
        rbtnGender.DataTextField = "GND_GENDER";
        rbtnGender.DataValueField = "GND_GENDERID";
        rbtnGender.DataBind();
        rbtnGender.SelectedIndex = 0;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        #region insert doctor languages

        DataTable dtDocLanguages = new DataTable();
        dtDocLanguages.Columns.AddRange(new DataColumn[2] { new DataColumn("DocId", typeof(int)),
                new DataColumn("LanguageId", typeof(int))});

        for (int i = 0; i < ddlLanguage.Items.Count; i++)
        {
            if (ddlLanguage.Items[i].Selected)
            {
                int languageId = Convert.ToInt32(ddlLanguage.Items[i].Value);
                dtDocLanguages.Rows.Add(Convert.ToInt32(Session["userId"]), languageId);
            }
        }
        val = objDocBLL.InsDocLanguages(dtDocLanguages);

        #endregion

        objDocBLL.DocId = Convert.ToInt32(Session["userId"].ToString());
        //objDocBLL.FirstName = AESEncryptionDecryption.Encrypt(tbFirstName.Text, AESEncryptionDecryption.KeyString);
        //objDocBLL.LastName = AESEncryptionDecryption.Encrypt(tbLastName.Text, AESEncryptionDecryption.KeyString); 
        objDocBLL.FirstName = tbFirstName.Text;
        objDocBLL.LastName = tbLastName.Text;
        if (!String.IsNullOrEmpty(rbtnGender.SelectedValue))
        {
            objDocBLL.GenderID = Convert.ToInt32(rbtnGender.SelectedValue.ToString());
        }
        else
            objDocBLL.GenderID = -1;

        int temp = -1;
        if (tbDob.Text != "")
            //objDocBLL.Dob = DateTime.ParseExact(tbDob.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            objDocBLL.Dob = AESEncryptionDecryption.Encrypt(DateTime.ParseExact(tbDob.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture).ToString(), AESEncryptionDecryption.KeyString);
        else
            objDocBLL.Dob = null;

        //if (tbDD.Text.Trim() != "" && int.TryParse(tbDD.Text.Trim(), out temp)
        //   // && tbMM.Text.Trim() != "" && int.TryParse(tbMM.Text.Trim(), out temp)
        //    //  && tbYYYY.Text.Trim() != "" && int.TryParse(tbYYYY.Text.Trim(), out temp))
        //{
        //    //string dateformat = tbMM.Text + "/" + tbDD.Text + "/" + tbYYYY.Text;
        //    objDocBLL.Dob = Convert.ToDateTime(dateformat);
        //}
        //objDocBLL.LanguageId = Convert.ToInt32(ddlLanguage.SelectedValue.ToString());
        objDocBLL.CountryId = Convert.ToInt32(ddlCountry.SelectedValue.ToString());
        objDocBLL.StateId = Convert.ToInt32(ddlState.SelectedValue.ToString());
        objDocBLL.CityId = Convert.ToInt32(ddlCity.SelectedValue.ToString());
        objDocBLL.Address1 = AESEncryptionDecryption.Encrypt(tbAddress1.Text, AESEncryptionDecryption.KeyString); 
        objDocBLL.Address2 = AESEncryptionDecryption.Encrypt(tbAddress2.Text, AESEncryptionDecryption.KeyString); 

        objDocBLL.Pincode = int.TryParse(tbPincode.Text.Trim(), out temp) ? Convert.ToInt32(tbPincode.Text) : -1;
        objDocBLL.Email = AESEncryptionDecryption.Encrypt(tbEmail.Text, AESEncryptionDecryption.KeyString);
        objDocBLL.Contact_number = AESEncryptionDecryption.Encrypt(tbcontact.Text, AESEncryptionDecryption.KeyString); 
        objDocBLL.UserName = Session["userName"].ToString();

        val = objDocBLL.updDocPersonalDetails(objDocBLL);
        //if(val > 0)
        //    Page.RegisterStartupScript("submit", "<script> alert('Personal information details are submitted successfully.');</script>");

    }

    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCountry.SelectedValue != "")
        {
            if (Convert.ToInt32(ddlCountry.SelectedValue) > 0)
            {
                if (ddlCountry.SelectedItem.Text.Equals("India"))
                {
                    lblZipcode.Text = "Pin code";
                    tbPincode.MaxLength = 6;
                }
                else
                {
                    lblZipcode.Text = "Zip code";
                    tbPincode.MaxLength = 5;
                 }   
                getStates();
                getCities();
            }
        }
    }
    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlState.SelectedValue != "")
        {
            if (Convert.ToInt32(ddlState.SelectedValue) > 0)
            {
                getCities();
            }
        }
    }
}
