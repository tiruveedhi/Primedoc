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
public partial class panellist : System.Web.UI.Page
{
    DataTable dtDetails = new DataTable();
    DataTable dtMedDetails = new DataTable();
    DAC.BLL.clspatientBLL objPatBLL = new DAC.BLL.clspatientBLL();
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    int patientId, consId, docId;
    string pageName = "";
    DataTable dtConversation = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            patientId = Convert.ToInt32(Request.QueryString["pat_id"]);
            docId = Convert.ToInt32(Request.QueryString["DocID"]);
            consId = Convert.ToInt32(Request.QueryString["consID"]);
            pageName = Request.QueryString["page"];

            if (!IsPostBack)
            {
                
                if (pageName == "Completed")
                {
                    divMessages.Visible = true;
                    divSecOpinion.Visible = true;
                    divAcitveInfo.Visible = false;
                    btnSubmitInfo.Visible = false;
                    BindRatingControl();
                    divComments.Visible = true;
                    bindSecondOpinion();
                }
                fillPersonalDetails();
                fillMedicalRecords();
                bindConversations();
                ShowFiles();
            }

            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
     private void bindSecondOpinion()
    {
        objDocBLL.ConsultationId = consId;

        lblSecOpinionAnswer.Text = objDocBLL.getSecondOpinion(objDocBLL);
    }


    DataTable dtSelLanguages = new DataTable();
    private void fillPersonalDetails()
    {
        objDocBLL.PatientId = Convert.ToInt32(Request.QueryString["pat_id"]);
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
                lblFirstName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_FIRSTNAME"].ToString(), AESEncryptionDecryption.KeyString);
                lblLastName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_LASTNAME"].ToString(), AESEncryptionDecryption.KeyString);
                lblGender.Text = dtDetails.Rows[0]["GND_GENDER"].ToString();
                lblDOB.Text = dtDetails.Rows[0]["PAT_DOB"].ToString();
                //lblLanguage.Text = dtDetails.Rows[0]["Language Name"].ToString();

                // show selected languages
                dtSelLanguages = objPatBLL.getSelectedLanguages(Convert.ToInt32(Session["userId"]));
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
                lblAddress1.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_ADDRESS1"].ToString(), AESEncryptionDecryption.KeyString);
                lblAddress2.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_ADDRESS2"].ToString(), AESEncryptionDecryption.KeyString);
                lblPincode.Text = dtDetails.Rows[0]["PAT_PINCODE"].ToString();
             
                    lbl_contact.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_CONTACTNUMBER"].ToString(),AESEncryptionDecryption.KeyString);
                
                
            }
        }
    }
    private void fillMedicalRecords()
    {
        objDocBLL.PatientId = patientId;
        objDocBLL.DocId = docId;
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
    DataTable dt_Filedata = new DataTable();
    private void ShowFiles()
    {
        DataTable dt_Medical = new DataTable();
        DataRow dr;
        dt_Filedata.Columns.Add("Name", typeof(string));
        dt_Filedata.Columns.Add("Data", typeof(string));
        dt_Filedata.Columns.Add("ID", typeof(string));

        dt_Medical = objPatBLL.GetMedicalFile(docId, patientId, consId);
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
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString();
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
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString();
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
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString();
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
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString();
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
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString();
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
                            img.ImageUrl = "~/ImgHandler.ashx?id=" + dt_Filedata.Rows[k]["ID"].ToString();
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
    int returnVal = 0;
    protected void btnSubmitInfo_Click(object sender, EventArgs e)
    {
        objDocBLL.ConvDescription = tbInfo.Text;
        objDocBLL.ConsultationId = consId;
        objDocBLL.ConvType = "Patient to doc";
        objDocBLL.DocAppend = "Patient :";
        objDocBLL.PatientAppend = "You :";
        objDocBLL.UserTypeId = Convert.ToInt32(Session["userTypeId"]);
        objDocBLL.DocId = Convert.ToInt32(docId.ToString());

        returnVal = objDocBLL.insConversation(objDocBLL);//INSERT CONVERSATION AND UPDATE CONSULATATION STATUS TO QUEUED

        string patient_id = Session["userId"].ToString();
        string patient_usertype = Session["userTypeId"].ToString();
        objPatBLL.Patient_id = Convert.ToInt32(patient_id);
        objPatBLL.UserTypeId = Convert.ToInt32(patient_usertype);
        objPatBLL.Subject = "Consulation-" + consId;
        objPatBLL.Message_Type = "Patient replied.";
        int Message_insert = objPatBLL.PatientInsert_Message(objPatBLL, docId.ToString(), 2);// Insert on Messagestable


        tbInfo.Text = "";
        bindConversations();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        returnVal = objPatBLL.cancelConsultation(consId, docId.ToString()); // CANCEL CONSULTATION PROCESS

        objPatBLL.Consulation_id = consId;
        DataTable dtConslAmount = new DataTable();
        dtConslAmount = objPatBLL.GetConslAmount(objPatBLL);

        if (dtConslAmount.Rows.Count > 0)
        {
            //objPatBLL.Consulation_id = consId;
            objPatBLL.Patient_id = Convert.ToInt32(Session["userId"].ToString());
            objPatBLL.TransAmount = dtConslAmount.Rows[0][0].ToString();
            objPatBLL.TransType = Convert.ToInt32(dtConslAmount.Rows[0][1].ToString());

            returnVal = objPatBLL.InsCancelConslAmount(objPatBLL);
        }
    }
    private void bindConversations()
    {
        objDocBLL.ConsultationId = consId;

        dtConversation = objDocBLL.getConversations_Patient(objDocBLL);

        if (dtConversation.Rows.Count > 0)
        {
            divMessages.Visible = true;
            gvConversation.Visible = true;
            gvConversation.DataSource = dtConversation;
            gvConversation.DataBind();
        }
        else
        {
            divMessages.Visible = false;
            gvConversation.Visible = false;
        }
    }

    //protected void RatingControlChanged(object sender, AjaxControlToolkit.RatingEventArgs e)
    //{

    //    string comment = txtcomment.Text;
    //    int rate = ratingControl.CurrentRating;
    //    int val = objPatBLL.Insertrating(rate, docId, patientId, consId, comment);

    //}
    protected void BindRatingControl()
    {
        DataTable dt_rating = new DataTable();
        dt_rating = objPatBLL.Getrating(Convert.ToInt32(docId), consId);
        if (dt_rating.Rows.Count > 0)
        {
            ratingControl.CurrentRating = Convert.ToInt32(dt_rating.Rows[0]["RATEING"].ToString());
            txtcomment.Text = dt_rating.Rows[0]["COMMENT"].ToString();
            ratingControl.ReadOnly = true;
            txtcomment.ReadOnly = true;
            btnRating.Visible = false;
        }
        else
        {
            ratingControl.ReadOnly = false;
            txtcomment.ReadOnly = false;
            btnRating.Visible = true;
        }
    }
    protected void btnRating_Click(object sender, EventArgs e)
    {
        string comment = txtcomment.Text;
        int rate = ratingControl.CurrentRating;
      

            int val = objPatBLL.Insertrating(rate, docId, patientId, consId, comment);
        }
    }


