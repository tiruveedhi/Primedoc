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
using System.IO;

public partial class bpd_consultationDetails : System.Web.UI.Page
{
    DataTable dtDetails = new DataTable();
    DataTable dtMedDetails = new DataTable();
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    DAC.BLL.clspatientBLL objPatBLL = new DAC.BLL.clspatientBLL();
    DAC.BLL.clsGlobalBLL obj_global = new DAC.BLL.clsGlobalBLL();


    int patientId = 0, consId = 0;
    string pageName = "", action = "";
    string docId = "";
    int docUserType = 0;
    DataTable dtConversation = new DataTable();
    DataTable dtSelLanguages = new DataTable();
    DataTable dt_Filedata = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            docId = Session["userId"].ToString();
            patientId = Convert.ToInt32(Request.QueryString["patId"]);
            consId = Convert.ToInt32(Request.QueryString["consID"]);
            pageName = Request.QueryString["page"];
            action = Request.QueryString["action"];
            Session["consId"] = consId;
            if (!IsPostBack)
            {
                if (pageName == "Active")
                {
                    if (action == "View")
                    {
                        divMessage.Visible = true;
                        divSecOpinion.Visible = true;
                        divAcitveInfo.Visible = false;
                        divAcitveOpinion.Visible = false;
                        lblOpinion.Visible = false;
                        divUploadFile.Visible = false; 
                        btnSubmitClose.Visible = false;
                        btnSubmitInfo.Visible = false;

                    }
                    if (action == "Picked")
                    {
                        divMessage.Visible = true;
                        divSecOpinion.Visible = true;
                        divAcitveInfo.Visible = true;
                        divAcitveOpinion.Visible = true;
                        lblOpinion.Visible = false;
                        btnSubmitClose.Visible = true;
                        btnSubmitInfo.Visible = true;
                        divUploadFile.Visible = true; 
                        referring_doctor.Visible = true;
                        reffering_Doctor();
                        //fill_refferingdoctorname();
                    }
                }
                if (pageName == "Completed")
                {
                    divMessage.Visible = true;
                    divSecOpinion.Visible = true;
                    divAcitveInfo.Visible = false;
                    divAcitveOpinion.Visible = false;
                    lblOpinion.Visible = true;
                    btnSubmitClose.Visible = false;
                    btnSubmitInfo.Visible = false;
                    lblOpinion.Text = Session["ConsMessage"].ToString();
                    divComments.Visible = true;
                    divUploadFile.Visible = false;
                    BindRatingControl();

                }
                if (pageName == "Cancelled")
                {
                    divMessage.Visible = false;
                    divSecOpinion.Visible = false;
                    divAcitveInfo.Visible = false;
                    divAcitveOpinion.Visible = false;
                    lblOpinion.Visible = false;
                    divUploadFile.Visible = false; 
                    btnSubmitClose.Visible = false;
                    btnSubmitInfo.Visible = false;
                    lblOpinion.Text = Session["ConsMessage"].ToString();
                }
            }
            fillPersonalDetails();
            fillMedicalRecords();
            bindConversations();
            ShowFiles();
            fill_Gender();
            fillLanguage();
            fillSpeciality();
            ShowSecondOpinionFiles();
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    private void ShowSecondOpinionFiles() // by swathi -- accepts only doc and txt files
    {
        DataTable dtSecOpiFiles = new DataTable();
        dtSecOpiFiles = objDocBLL.getSecondOpinionFiles(docId, consId.ToString());
        if (dtSecOpiFiles.Rows.Count > 0)
        {
            for (int i = 0; i < dtSecOpiFiles.Rows.Count; i++)
            {
                HyperLink hl = new HyperLink();
                hl.ID = "hyperlink" + dtSecOpiFiles.Rows[i]["SOF_IMAGEID"].ToString();
                hl.Text = dtSecOpiFiles.Rows[i]["SOF_IMAGENAME"].ToString();
                hl.NavigateUrl = "~/DocFileHandler.ashx?ID=" + dtSecOpiFiles.Rows[i]["SOF_IMAGEID"].ToString();
                hl.ForeColor = System.Drawing.Color.Blue;
                hl.Target = "_blank";

                pnlSPFiles.Controls.Add(hl);
                pnlSPFiles.Controls.Add(new LiteralControl("&nbsp;"));
            }
        }

    }
    public void reffering_Doctor()
    {

        dtDetails = objDocBLL.get_refferingdoctor(patientId);
        if (dtDetails.Rows.Count > 0)
        {
            if ((dtDetails.Rows[0]["CNS_REFERRFROM_DOCID"]) != DBNull.Value)
            {
                int RefferDoc_id = Convert.ToInt32(dtDetails.Rows[0]["CNS_DOCID"]);

                int val = objDocBLL.update_refferto_doctor(consId, Convert.ToInt32(docId), RefferDoc_id);
                int va = objDocBLL.update_refferto_flag((Convert.ToInt32(dtDetails.Rows[0]["CNS_CONSULTID"])), patientId, Convert.ToInt32(dtDetails.Rows[0]["CNS_DOCID"]),Convert.ToInt32(dtDetails.Rows[0]["CNS_REFERRFROM_DOCID"]));
                lblreffering.Text = dtDetails.Rows[0]["DOC_FIRSTNAME"].ToString();
            }

        }
    }
    public void fillLanguage()
    {
        DataSet dsLanguage = new DataSet();
        dsLanguage = obj_global.getLanguages();

        //Fill refering doctor
        ddl_lanuage.DataTextField = "LAG_LANGUAGE";
        ddl_lanuage.DataValueField = "LAG_LANGUAGEID";
        ddl_lanuage.DataSource = dsLanguage;
        ddl_lanuage.DataBind();
        ddl_lanuage.Items.Insert(0, new ListItem("Select", string.Empty));
    }
    public void fill_Gender()
    {
        DataSet ds_gender = new DataSet();
        ds_gender = obj_global.getGenderList();
      
        // Fill refering doctor
        ddl_gender.DataTextField = "GND_GENDER";
        ddl_gender.DataValueField = "GND_GENDERID";
        ddl_gender.DataSource = ds_gender;
        ddl_gender.DataBind();
        //ddlGenderList.SelectedIndex = 0;
        ddl_gender.Items.Insert(0, new ListItem("Select", string.Empty));

    }
    //Fill Refering doctor
    private void fillSpeciality()
    {
        DataSet dsSpeciality = new DataSet();
        dsSpeciality = obj_global.getSpeciality();

        ddlSpeciality.DataSource = dsSpeciality.Tables[0];
        ddlSpeciality.DataTextField = "SPE_SPECIALTY";
        ddlSpeciality.DataValueField = "SPE_SPECIALTIYID";
        ddlSpeciality.DataBind();
        ddlSpeciality.Items.Insert(0, new ListItem("Select", string.Empty));
    }
    public string Search_RefferingDoctor()//This Search basesd on Doctor Name,location ,SPECIALTY
    {
        string strQry = "";
        if (ddl_lanuage.SelectedIndex != 0) //(ddllanuage.SelectedItem.Text != "")
        {
            strQry = strQry + " and (LAG_LANGUAGE Like '%" + ddl_lanuage.SelectedItem.Text + "%' or LAG_LANGUAGE is null) ";
        }
        if (ddl_gender.SelectedIndex != 0)//(ddlGenderList.SelectedItem.Text != "")
        {
            strQry = strQry + " and GND_GENDER Like '%" + ddl_gender.SelectedItem.Text + "%' ";
        }
        if (txt_doctor.Text != "")
        {
            string docName = txt_doctor.Text.Trim();
            string[] docNameTokens = docName.Split(' ');
            foreach (string docNameToken in docNameTokens)
            {
                if (docNameToken.Trim() != "")
                {
                    strQry = strQry + " and (DOC_FIRSTNAME Like '%" + docNameToken.Trim() + "%' or " +
                        "DOC_LASTNAME Like '%" + docNameToken.Trim() + "%' )";
                }
            }
        }

        //if (txtspecialization.Text != "")
        //{
        //    strQry = strQry + " and " + "SPE_SPECIALTY Like '%" + txtspecialization.Text + "%' ";
        //}
        if (ddlSpeciality.SelectedIndex != 0)
        {
            strQry = strQry + " and  SPE_SPECIALTY Like '%" + ddlSpeciality.SelectedItem.Text + "%' ";
        }
        if (txt_location.Text != "")
        {
            strQry = strQry + " and DST_DISTRICTNAME Like '%" + txt_location.Text + "%'";
        }

        return strQry;
    }
    protected void btn_search_Click(object sender, EventArgs e)
    {
        DataSet ds_reffering = new DataSet();
        string str_search = Search_RefferingDoctor();// This Search basesd on Doctor Name,location ,SPECIALTY
        ds_reffering = objPatBLL.search_Doctor(str_search);
        gvReferringDoc.Columns[1].Visible = true;

        gvReferringDoc.DataSource = ds_reffering;
        gvReferringDoc.DataBind();
        gvReferringDoc.Columns[1].Visible = false;
        ModalPopupExtender1.Show();
    }
    private void ShowFiles()
    {
        DataTable dt_Medical = new DataTable();
        DataRow dr;
        dt_Filedata.Columns.Add("Name", typeof(string));
        dt_Filedata.Columns.Add("Data", typeof(string));
        dt_Filedata.Columns.Add("ID", typeof(string));

        dt_Medical = objPatBLL.GetMedicalFile(Convert.ToInt32(docId), patientId, consId);
        if (dt_Medical.Rows.Count > 0)
        {
            for (int i = 0; i < dt_Medical.Rows.Count; i++)
            {

                string str_MedicalFile = dt_Medical.Rows[i]["MED_FILEID"].ToString();
                string[] str = str_MedicalFile.Split('~');

                for (int j = 0; j < str.Length; j++)
                {
                    // char[] separator = { ',' };
                    string[] splitR = str[j].Split(',');
                    DataTable dt = new DataTable();

                    dt = objPatBLL.GetFiledata(Convert.ToInt32(splitR[1].ToString()));
                    dr = dt_Filedata.NewRow();

                    dr["Name"] = dt.Rows[0][0].ToString();
                    dr["Data"] = dt.Rows[0][1].ToString();
                    dr["ID"] = dt.Rows[0][2].ToString();

                    dt_Filedata.Rows.Add(dr);

                }

                if (dt_Filedata.Rows.Count > 0)
                {


                    for (int k = 0; k < dt_Filedata.Rows.Count; k++)
                    {

                        if (dt_Filedata.Rows[k]["Data"].ToString() == "LifeStyle")
                        {
                            Image img = new Image();
                            img.ID = dt_Filedata.Rows[k]["ID"].ToString();
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString() + "&patientDetails=yes";
                            img.Width = 69;
                            img.Height = 69;
                            img.Attributes.Add("onclick", "DisplayFullImage(this);");
                            pnllifestyle.Visible = true;
                            pnllifestyle.Controls.Add(img);
                            pnllifestyle.Controls.Add(new LiteralControl("&nbsp;"));
                        }
                        //else
                        //{
                        //    pnllifestyle.Visible = false;
                        //}

                        if (dt_Filedata.Rows[k]["Data"].ToString() == "HealthProblem")
                        {

                            Image img = new Image();
                            img.ID = dt_Filedata.Rows[k]["ID"].ToString();
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString() + "&patientDetails=yes";
                            img.Width = 69;
                            img.Height = 69;
                            img.Attributes.Add("onclick", "DisplayFullImage(this);");
                            pnlHealth.Visible = true;
                            pnlHealth.Controls.Add(img);
                            pnlHealth.Controls.Add(new LiteralControl("&nbsp;"));

                        }
                        //else
                        //{
                        //    pnlHealth.Visible = false;
                        //}

                        if (dt_Filedata.Rows[k]["Data"].ToString() == "Radiology")
                        {

                            Image img = new Image();
                            img.ID = dt_Filedata.Rows[k]["ID"].ToString();
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString() + "&patientDetails=yes";
                            img.Width = 69;
                            img.Height = 69;
                            img.Attributes.Add("onclick", "DisplayFullImage(this);");
                            pnlRadiology.Visible = true;
                            pnlRadiology.Controls.Add(img);
                            pnlRadiology.Controls.Add(new LiteralControl("&nbsp;"));

                        }
                        //else
                        //{
                        //    pnlRadiology.Visible = false;
                        //}
                        if (dt_Filedata.Rows[k]["Data"].ToString() == "LabResults")
                        {

                            Image img = new Image();
                            img.ID = dt_Filedata.Rows[k]["ID"].ToString();
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString() + "&patientDetails=yes";
                            img.Width = 69;
                            img.Height = 69;
                            img.Attributes.Add("onclick", "DisplayFullImage(this);");
                            pnlLabresults.Visible = true;
                            pnlLabresults.Controls.Add(img);
                            pnlLabresults.Controls.Add(new LiteralControl("&nbsp;"));

                        }
                        //else
                        //{
                        //    pnlLabresults.Visible = false;
                        //}

                        if (dt_Filedata.Rows[k]["Data"].ToString() == "Allergies")
                        {

                            Image img = new Image();
                            img.ID = dt_Filedata.Rows[k]["ID"].ToString();
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString() + "&patientDetails=yes";
                            img.Width = 69;
                            img.Height = 69;
                            img.Attributes.Add("onclick", "DisplayFullImage(this);");
                            pnlAllergies.Visible = true;
                            pnlAllergies.Controls.Add(img);
                            pnlAllergies.Controls.Add(new LiteralControl("&nbsp;"));

                        }
                        //else
                        //{
                        //    pnlAllergies.Visible = false;
                        //}

                        if (dt_Filedata.Rows[k]["Data"].ToString() == "Medication")
                        {

                            Image img = new Image();
                            img.ID = dt_Filedata.Rows[k]["ID"].ToString();
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString() + "&patientDetails=yes";
                            img.Width = 69;
                            img.Height = 69;
                            img.Attributes.Add("onclick", "DisplayFullImage(this);");
                            pnlMedication.Visible = true;
                            pnlMedication.Controls.Add(img);
                            pnlMedication.Controls.Add(new LiteralControl("&nbsp;"));

                        }
                        //else
                        //{
                        //    pnlMedication.Visible = false;
                        //}

                    }
                }
            }
        }

    }
    private void fillPersonalDetails()//Patient personal details
    {
        objDocBLL.PatientId = patientId;
        dtDetails = objDocBLL.getPatientDetails(objDocBLL);

        if (dtDetails.Rows.Count > 0)
        {
            string patientAnonymous = dtDetails.Rows[0]["PAT_ANONYMOUS"].ToString();
            if (patientAnonymous == "True")
            {
                divPersonalDtls.Visible = false;
                divAnonymous.Visible = true;
            }
            else
            {
                divPersonalDtls.Visible = true;
                divAnonymous.Visible = false;
                lblFirstName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_FIRSTNAME"].ToString(),AESEncryptionDecryption.KeyString);
                lblLastName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_LASTNAME"].ToString(),AESEncryptionDecryption.KeyString);
                lblGender.Text = dtDetails.Rows[0]["GND_GENDER"].ToString();
                //lblDOB.Text = dtDetails.Rows[0]["PAT_DOB"].ToString();
                if (dtDetails.Rows[0]["PAT_DOB"].ToString() != "")
                {
                    DateTime date1 = Convert.ToDateTime(AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_DOB"].ToString(), AESEncryptionDecryption.KeyString).Substring(0, 10));
                    lblDOB.Text = date1.Month.ToString("00") + "/" + date1.Day.ToString("00") + "/" + date1.Year.ToString("0000");
                }

                //lblLanguage.Text = dtDetails.Rows[0]["LAG_LANGUAGE"].ToString();

                // show patient selected languages
                dtSelLanguages = objPatBLL.getSelectedLanguages(patientId);
                string strLang = "";
                for (int i = 0; i < dtSelLanguages.Rows.Count; i++)
                {
                    strLang = strLang + "/" + dtSelLanguages.Rows[i]["LAG_LANGUAGE"].ToString();
                }
                if (strLang != "")
                    strLang = strLang.Substring(1, strLang.Length - 1);
                lblLanguage.Text = strLang;
                // end of show selected languages

                lblCountry.Text = dtDetails.Rows[0]["CNT_SHORTNAME"].ToString();
                lblState.Text = dtDetails.Rows[0]["STT_STATENAME"].ToString();
                lblCity.Text = dtDetails.Rows[0]["DST_DISTRICTNAME"].ToString();
                if (dtDetails.Rows[0]["PAT_ADDRESS1"].ToString() != "")
                {
                    lblAddress1.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_ADDRESS1"].ToString(),AESEncryptionDecryption.KeyString);
                }
                if (dtDetails.Rows[0]["PAT_ADDRESS2"].ToString() != "")
                {
                    lblAddress2.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_ADDRESS2"].ToString(), AESEncryptionDecryption.KeyString);
                }
            }
        }
    }
    private void fillMedicalRecords()
    {
        objDocBLL.PatientId = patientId;
        objDocBLL.DocId = Convert.ToInt32(Session["userId"]);
        objDocBLL.ConsultationId = consId;

        dtMedDetails = objDocBLL.getMedicalDetails(objDocBLL);
        if (dtMedDetails.Rows.Count > 0)
        {
            lblLifeStyle.Text = dtMedDetails.Rows[0]["LST_LIFESTYLE"].ToString();
            lblMedication.Text = dtMedDetails.Rows[0]["MED_MEDICATIONS"].ToString();
            lblRadiology.Text = dtMedDetails.Rows[0]["RAD_RADIOLOGY"].ToString();
            lblLabResults.Text = dtMedDetails.Rows[0]["LAB_RESULTS"].ToString();
            lblHealthProb.Text = dtMedDetails.Rows[0]["HLP_HEALTHPROB"].ToString() + " - " + dtMedDetails.Rows[0]["HLP_OTHER_HEALTHPROBS"].ToString();
            lblAllergies.Text = dtMedDetails.Rows[0]["A_ALLERGIE"].ToString();
        }
    }
    protected void btnSubmitClose_Click(object sender, EventArgs e)
    {
        if (tbSecOpinion.Text != "")
        {
            objDocBLL.ConsMsg = tbSecOpinion.Text;
            objDocBLL.ConsultationId = consId;
            objDocBLL.DocId = Convert.ToInt32(Session["userId"]);

            int retVal = objDocBLL.updConsMessage(objDocBLL); // CONSULTATION CLOSED

            insertMessage();
            objDocBLL.Message_Type = "Consultation closed";
            int Message_insert = objDocBLL.Insert_Message(objDocBLL, docId, docUserType);// Insert on Messagestable

            DataTable dtTranAmnt = new DataTable();
            dtTranAmnt = objDocBLL.GetConslTransAmnt(objDocBLL);
            dtDetails = objDocBLL.Get_reffering_Docotoramount(patientId);
            if (dtTranAmnt.Rows.Count > 0)
            {
                objDocBLL.DocId = Convert.ToInt32(Session["userId"].ToString());
                objDocBLL.ConsultationId = consId;
                objDocBLL.TransAmount = dtTranAmnt.Rows[0][0].ToString();
                objDocBLL.TransType = Convert.ToInt32(dtTranAmnt.Rows[0][1].ToString());

                retVal = objDocBLL.InsDocTransaction(objDocBLL);


            }
            if (dtDetails.Rows.Count > 0)
            {
                if ((dtDetails.Rows[0]["CNS_REFERRFROM_DOCID"]) != DBNull.Value)
                {
                    objDocBLL.DocId = Convert.ToInt32(dtDetails.Rows[0]["CNS_DOCID"].ToString());
                    objDocBLL.ConsultationId = Convert.ToInt32(dtDetails.Rows[0]["CNS_CONSULTID"]);
                    double amount = 100.0000;
                    objDocBLL.TransAmount = amount.ToString();
                    objDocBLL.TransType = 6;

                    retVal = objDocBLL.InsDocTransaction(objDocBLL);
                }
            }
            
            if (retVal > 0)
            {
                tbSecOpinion.Enabled = false;
                tbInfo.Enabled = false;
            }
            else
            {
                tbSecOpinion.Enabled = true;
                tbInfo.Enabled = true;
            }
        }
        else
        {
            Page.RegisterStartupScript("k", "<script>alert('Please enter second opinion.');</script>");
        }
    }
    protected void btnSubmitInfo_Click(object sender, EventArgs e)
    {
        objDocBLL.ConvDescription = tbInfo.Text;
        objDocBLL.ConsultationId = consId;
        objDocBLL.ConvType = "Doc to patient";
        objDocBLL.DocAppend = "You :";
        objDocBLL.PatientAppend = "Doctor :";
        objDocBLL.UserTypeId = Convert.ToInt32(Session["userTypeId"]);
        objDocBLL.DocId = Convert.ToInt32(Session["userId"].ToString());

        int returnVal = objDocBLL.insConversation(objDocBLL);//INSERT CONVERSATION AND UPDATE CONSULATATION STATUS TO WAITING USER REPLY

        insertMessage();
        objDocBLL.Message_Type = "Doctor need further information";
        int Message_insert = objDocBLL.Insert_Message(objDocBLL, docId, docUserType);// Insert on Messagestable


        tbInfo.Text = "";
        bindConversations();
    }
    private void insertMessage()
    {
        docId = Session["userId"].ToString();
        docUserType = Convert.ToInt32(Session["userTypeId"].ToString());
        objDocBLL.PatientId = patientId;
        objDocBLL.UserTypeId = 1;
        objDocBLL.Subject = "Consulation-" + consId;
    }
    private void bindConversations()
    {
        objDocBLL.ConsultationId = consId;

        dtConversation = objDocBLL.getConversations(objDocBLL);

        if (dtConversation.Rows.Count > 0)
        {
            if (dtConversation.Rows[0][1].ToString() == "")
                dtConversation.Rows[0].Delete();

            gvConversation.Visible = true;
            gvConversation.DataSource = dtConversation;
            gvConversation.DataBind();
        }
        else
        {
            gvConversation.Visible = false;
        }
    }
    DataTable dtSelectedRefDoc = new DataTable();
    protected void GetSelectedRefDoc(object sender, EventArgs e)
    {
        dtSelectedRefDoc.Columns.AddRange(new DataColumn[2] { new DataColumn("Id"), new DataColumn("Name") });
        foreach (GridViewRow row in gvReferringDoc.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                if (chkRow.Checked)
                {
                    string id = row.Cells[1].Text;
                    string name = row.Cells[2].Text;
                    dtSelectedRefDoc.Rows.Add(id, name);
                }
            }
        }
        if (dtSelectedRefDoc.Rows.Count > 0)
        {
            // lblReferringDoc.Visible = true;
          //  int val = objDocBLL.Insert_Reffering_Doctor(
            int val = objDocBLL.Insert_Reffering_Doctor(Convert.ToInt32(docId), consId, patientId, Convert.ToInt32(dtSelectedRefDoc.Rows[0][0].ToString()));
            // lblReferringDoc.Text = dtSelectedRefDoc.Rows[0][1].ToString().Replace(Environment.NewLine, "<br />"); 
        }
        lblreffering.Text = dtSelectedRefDoc.Rows[0][1].ToString();
    }
      protected void RatingControlChanged(object sender, AjaxControlToolkit.RatingEventArgs e)
    {

        string comment = txtcomment.Text;
        int rate = ratingControl.CurrentRating;
        int val = objPatBLL.Insert_ratingDOC(rate, Convert.ToInt32(docId), patientId, consId, comment);

    }
    protected void BindRatingControl()
    {
        DataTable dt_rating = new DataTable();
        dt_rating = objPatBLL.Getrating(Convert.ToInt32(docId), consId);
        if (dt_rating.Rows.Count > 0)
        {
          if (Convert.ToInt32(dt_rating.Rows[0]["RATEING"].ToString()) >= 4)
         {
                divComments.Visible = true;
                ratingControl.CurrentRating = Convert.ToInt32(dt_rating.Rows[0]["RATEING"].ToString());
                txtcomment.Text = dt_rating.Rows[0]["COMMENT"].ToString();
         }
        }

            else
            {
                divComments.Visible = false;
            }
        }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvReferringDoc.PageIndex = e.NewPageIndex;
        btn_search_Click(sender, e);
    }
 
    }

    

