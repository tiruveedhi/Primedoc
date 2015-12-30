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
public partial class cpd_editDoctorDetails : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clsadminBLL obj_adminBLL = new DAC.BLL.clsadminBLL();
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    Button button;
    DataSet dsGender = null;
    DataSet dsLanguage = null;
    DataSet dsCountry = null;
    DataSet dsState = null;
    DataSet dsCity = null;
    DataSet dsSpeciality = null;
    DataTable dtDetails = new DataTable();
    int doc_id, UserType_ID;
    DataTable dt_specialtyrate = null;
    int val = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        doc_id = Convert.ToInt32(Request.QueryString["docId"]);
        UserType_ID = Convert.ToInt32(Request.QueryString["Usertype"]);
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        } 
        tbDob.Attributes.Add("readonly", "readonly");
        if (!IsPostBack)
        {
            BindLists();
            getUserDetails();

            showImages();
            Rates_Bind();
        }
    }

    public void Rates_Bind()
    {
        dt_specialtyrate = objDocBLL.GET_SPECIALITIERATE(doc_id);
        if (dt_specialtyrate.Rows.Count > 0)
        {
            gv_rates.DataSource = dt_specialtyrate;
            gv_rates.DataBind();

            rates.Visible = true;
        }
    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        objDocBLL.DocId = doc_id;
        //objDocBLL.FirstName = AESEncryptionDecryption.Encrypt(tbFirstName.Text, AESEncryptionDecryption.KeyString); 
        //objDocBLL.LastName = AESEncryptionDecryption.Encrypt(tbLastName.Text, AESEncryptionDecryption.KeyString); 
        objDocBLL.FirstName = tbFirstName.Text;
        objDocBLL.LastName = tbLastName.Text;

        //objDocBLL.GenderID = Convert.ToInt32(rbtnGender.SelectedValue.ToString());
        if (!String.IsNullOrEmpty(rbtnGender.SelectedValue))
        {
            objDocBLL.GenderID = Convert.ToInt32(rbtnGender.SelectedValue.ToString());
        }
        else
            objDocBLL.GenderID = -1;

        int temp = -1;
        if (tbDob.Text != "")
            objDocBLL.Dob = AESEncryptionDecryption.Encrypt(DateTime.ParseExact(tbDob.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture).ToString(), AESEncryptionDecryption.KeyString);
        else
            objDocBLL.Dob = null;


        //objDocBLL.LanguageId = Convert.ToInt32(ddlLanguage.SelectedValue.ToString());
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

        objDocBLL.CountryId = Convert.ToInt32(ddlCountry.SelectedValue.ToString());
        objDocBLL.StateId = Convert.ToInt32(ddlState.SelectedValue.ToString());
        objDocBLL.CityId = Convert.ToInt32(ddlCity.SelectedValue.ToString());
        objDocBLL.Address1 = AESEncryptionDecryption.Encrypt(tbAddress1.Text, AESEncryptionDecryption.KeyString); 
        objDocBLL.Address2 = AESEncryptionDecryption.Encrypt(tbAddress2.Text, AESEncryptionDecryption.KeyString); 

        objDocBLL.Pincode = int.TryParse(tbPincode.Text.Trim(), out temp) ? Convert.ToInt32(tbPincode.Text) : -1;

        objDocBLL.Email = AESEncryptionDecryption.Encrypt(tbEmail.Text, AESEncryptionDecryption.KeyString);
        //objDocBLL.UserName = AESEncryptionDecryption.Encrypt(Session["userName"].ToString(), AESEncryptionDecryption.KeyString); 
        objDocBLL.Biography = txtprofessional.Text;
        //objDocBLL.SpecialityId = Convert.ToInt32(ddlSpeciality.SelectedValue.ToString());

        #region insert doctor specialities
        DataTable dtDocSpec = new DataTable();
        DataTable dt_SPECIALITIE = new DataTable();
        dtDocSpec.Columns.AddRange(new DataColumn[4] { new DataColumn("DocId", typeof(int)),
                new DataColumn("SpecialityId", typeof(int)),new DataColumn("EXPRESS", typeof(string)),new DataColumn("REGULAR", typeof(string))});

        for (int i = 0; i < ddlSpeciality.Items.Count; i++)
        {
            if (ddlSpeciality.Items[i].Selected)
            {
                int specId = Convert.ToInt32(ddlSpeciality.Items[i].Value);

                dt_SPECIALITIE = objDocBLL.GET_DOCSPECIALITIE(specId);
                dtDocSpec.Rows.Add(Convert.ToInt32(Session["userId"]), specId, dt_SPECIALITIE.Rows[0]["SPE_EXPRESS_RATE"].ToString(), dt_SPECIALITIE.Rows[0]["SPE_REGULAR_RATE"].ToString());


            }
        }


        val = objDocBLL.InsDocSpecialities(dtDocSpec);

        #endregion

        val = objDocBLL.updDocPersonalDetails_admin(objDocBLL);

        // UPdate Specialty rates
        foreach (GridViewRow gre in gv_rates.Rows)
        {
            Label lbl_ID = (Label)gre.FindControl("lbl_specialty_id");
            TextBox tb_EXPRESS = (TextBox)gre.FindControl("txtEXPRESS");
            TextBox tb_regular = (TextBox)gre.FindControl("txtREGULAR");
            val = objDocBLL.UpDATESPECIALITIE_RATE(Convert.ToInt32(lbl_ID.Text), doc_id, tb_EXPRESS.Text, tb_regular.Text);
        }
    }
    private void showImages()
    {
        pnlView.Controls.Clear();
        DataTable dt = new DataTable();
        objDocBLL.DocId = doc_id;
        dt = objDocBLL.GetDocCertificates(objDocBLL);

        //dt = FlipDataTable(dt);
        //gridImg.DataSource = dt;
        //gridImg.DataBind();

        //gridImg.Columns[0].Visible = false;
        if (dt.Rows.Count > 0)
        {
            divLoadedImages.Visible = true;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Image img = new Image();
                img.ID = dt.Rows[i][0].ToString();
                img.ImageUrl = "~/ImgHandler.ashx?id=" + dt.Rows[i][0].ToString() + "&patientDetails=No";
                img.Width = 65;
                img.Height = 65;



                pnlView.Controls.Add(img);
                pnlView.Controls.Add(new LiteralControl("&nbsp;"));
                //pnlView.Controls.Add(button);
            }
            pnlView.Controls.Add(new LiteralControl("<br/>"));
            pnlView.Controls.Add(new LiteralControl("<br/>"));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                button = new Button();
                button.ID = "btn-" + dt.Rows[i][0].ToString();
                button.Text = "Remove";
                button.Click += new EventHandler(btnRemove_Click);
                pnlView.Controls.Add(button);
                pnlView.Controls.Add(new LiteralControl("&nbsp;"));
            }
        }
        else
        {
            divLoadedImages.Visible = false;
        }
    }
    void btnRemove_Click(object obj, EventArgs e)
    {
        string id = button.ID;
        string[] idSplit = id.Split('-');
        objDocBLL.RemoveDocCertificates(idSplit[1]);

        showImages();
    }
    private void getUserDetails()
    {
        dtDetails = obj_adminBLL.Get_UserDetails(doc_id, UserType_ID);
        if (dtDetails.Rows.Count > 0)
        {
            fillUserDetails();
        }
    }
    DataTable dtSelLanguages = new DataTable();
    DataTable dtSelSpeciality = new DataTable();
    private void fillUserDetails()
    {
        // show selected languages
        dtSelLanguages = objDocBLL.getSelectedLanguages(doc_id);

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
        ddlState.SelectedValue = dtDetails.Rows[0]["DOC_STATEID"].ToString();
        ddlCity.SelectedValue = dtDetails.Rows[0]["DOC_DISTRICTID"].ToString();
        if (dtDetails.Rows[0]["DOC_ADDRESS1"].ToString() != "")
            tbAddress1.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_ADDRESS1"].ToString(), AESEncryptionDecryption.KeyString);
        if (dtDetails.Rows[0]["DOC_ADDRESS2"].ToString() != "")
            tbAddress2.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_ADDRESS2"].ToString(), AESEncryptionDecryption.KeyString);
        tbPincode.Text = dtDetails.Rows[0]["DOC_PINCODE"].ToString();
        tbEmail.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["DOC_EMAIL"].ToString(), AESEncryptionDecryption.KeyString);
        
        txtprofessional.Text = dtDetails.Rows[0]["DOC_PROF_BIO"].ToString();

        // show selected specialities
        dtSelSpeciality = objDocBLL.getSelectedSpecialities(doc_id);

        for (int i = 0; i < dtSelSpeciality.Rows.Count; i++)
        {
            int sp = Convert.ToInt32(dtSelSpeciality.Rows[i]["SPE_SPECIALTIYID"].ToString());
            ddlSpeciality.Items.FindByValue(sp.ToString()).Selected = true;
        }
        // end of show selected specialities
        //ddlSpeciality.SelectedValue = dtDetails.Rows[0]["DOC_SPECIALTIYID"].ToString();
    }
    private void BindLists()
    {
        getGenderList();
        getLanguages();
        getCountries();
        getStates();
        getCities();
        getSpecialities();
    }
    private void getSpecialities()
    {
        dsSpeciality = new DataSet();
        dsSpeciality = objGlobalBLL.getSpeciality();
        if (dsSpeciality.Tables[0].Rows.Count > 0)
        {
            ddlSpeciality.DataSource = dsSpeciality.Tables[0];
            ddlSpeciality.DataTextField = "SPE_SPECIALTY";
            ddlSpeciality.DataValueField = "SPE_SPECIALTIYID";
            ddlSpeciality.DataBind();
        }
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
        if (dsState.Tables[0].Rows.Count > 0)
        {
            ddlState.DataSource = dsState.Tables[0];
            ddlState.DataTextField = "STT_STATENAME";
            ddlState.DataValueField = "STT_STATEID";
            ddlState.DataBind();
        }
    }

    private void getCountries()
    {
        dsCountry = new DataSet();
        dsCountry = objGlobalBLL.getCountries();
        if (dsCountry.Tables[0].Rows.Count > 0)
        {
            ddlCountry.DataSource = dsCountry.Tables[0];
            ddlCountry.DataTextField = "CNT_SHORTNAME";
            ddlCountry.DataValueField = "CNT_COUNTRYID";
            ddlCountry.DataBind();
        }
    }

    private void getLanguages()
    {
        dsLanguage = new DataSet();
        dsLanguage = objGlobalBLL.getLanguages();
        if (dsLanguage.Tables[0].Rows.Count > 0)
        {
            ddlLanguage.DataSource = dsLanguage.Tables[0];
            ddlLanguage.DataTextField = "LAG_LANGUAGE";
            ddlLanguage.DataValueField = "LAG_LANGUAGEID";
            ddlLanguage.DataBind();
        }
    }

    private void getGenderList()
    {
        dsGender = new DataSet();
        dsGender = objGlobalBLL.getGenderList();
        if (dsGender.Tables[0].Rows.Count > 0)
        {
            rbtnGender.DataSource = dsGender.Tables[0];
            rbtnGender.DataTextField = "GND_GENDER";
            rbtnGender.DataValueField = "GND_GENDERID";
            rbtnGender.DataBind();
        }
    }
    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCountry.SelectedValue != "")
        {
            if (Convert.ToInt32(ddlCountry.SelectedValue) > 0)
            {
                if (ddlCountry.SelectedItem.Text.Equals("India"))
                    lblZipcode.Text = "Pin code";
                else
                    lblZipcode.Text = "Zip code";

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
