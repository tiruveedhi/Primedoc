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

public partial class apd_consultationDetails : System.Web.UI.Page
{
    DataTable dtDetails = new DataTable();
    DataTable dtMedDetails = new DataTable();
    DAC.BLL.clspatientBLL objPatBLL = new DAC.BLL.clspatientBLL();
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    int patientId, consId, docId;
    string pageName = "";
    DataTable dtConversation = new DataTable();
    DataTable dtSelLanguages = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            patientId = Convert.ToInt32(Session["userId"]);
            docId = Convert.ToInt32(Request.QueryString["DocID"]);
            consId = Convert.ToInt32(Request.QueryString["consID"]);
            pageName = Request.QueryString["page"];
            Session["docId"] = docId;
            if (!IsPostBack)
            {
                if (pageName == "Active")
                {
                    divMessages.Visible = true;
                    divSecOpinion.Visible = false;
                    btnSubmitInfo.Visible = true;
                    if (Session["canCancel"].ToString() == "True")
                        btnCancel.Visible = true;
                    else if (Session["canCancel"].ToString() == "False")
                        btnCancel.Visible = false;
                }
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

            }
            fillPersonalDetails();
            fillMedicalRecords();
            bindConversations();
            ShowFiles(); 
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
        dtSecOpiFiles = objDocBLL.getSecondOpinionFiles(docId.ToString(), consId.ToString());
        if (dtSecOpiFiles.Rows.Count > 0)
        {
            for (int i = 0; i < dtSecOpiFiles.Rows.Count; i++)
            {
                LinkButton hl = new LinkButton();
                hl.ID = "hyperlink" + dtSecOpiFiles.Rows[i]["SOF_IMAGEID"].ToString();
                hl.Text = dtSecOpiFiles.Rows[i]["SOF_IMAGENAME"].ToString();
                hl.CommandArgument = dtSecOpiFiles.Rows[i]["SOF_IMAGEID"].ToString(); // "~/DocFileHandler.ashx?ID=" + dtSecOpiFiles.Rows[i]["SOF_IMAGEID"].ToString();
                hl.Click += new EventHandler(this.View);
                hl.ForeColor = System.Drawing.Color.Blue;
                //hl.Target = "_blank";
                pnlSPFiles.Controls.Add(hl);
                pnlSPFiles.Controls.Add(new LiteralControl("&nbsp;"));
            }
        }

    }
    protected void View(object sender, EventArgs e)
    {
        int id = int.Parse((sender as LinkButton).CommandArgument);
        string embed = "<object data=\"{0}{1}\" type=\"application/pdf\" width=\"500px\" height=\"600px\">";
        embed += "If you are unable to view file, you can download from <a href = \"{0}{1}&download=1\">here</a>";
        embed += " or download <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
        embed += "</object>";
        ltEmbed.Text = string.Format(embed, ResolveUrl("~/DocFileHandler.ashx?Id="), id);
    }
    private void bindSecondOpinion()
    {
        objDocBLL.ConsultationId = consId;
        objPatBLL.Consulation_id = consId;

        lblSecOpinionAnswer.Text = objDocBLL.getSecondOpinion(objDocBLL);

        //DataTable dtSecOpiData = new DataTable();
        //dtSecOpiData = objPatBLL.getPatSecOpVideoCnsData(objPatBLL);

        //if (dtSecOpiData.Rows.Count > 0)
        //{
        //    btnSchedVideo.Visible = false;
        //    lblSecOpiVideo.Text = "Your consultation is scheduled on " + dtSecOpiData.Rows[0][0].ToString() + " at " + dtSecOpiData.Rows[0][1].ToString().Substring(0, 5);
        //}
        //else
        //{
        //    btnSchedVideo.Visible = true;
        //}
    }
    private void fillPersonalDetails()
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
                lblFirstName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_FIRSTNAME"].ToString(), AESEncryptionDecryption.KeyString);
                lblLastName.Text = AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_LASTNAME"].ToString(), AESEncryptionDecryption.KeyString);
                lblGender.Text = dtDetails.Rows[0]["GND_GENDER"].ToString();
                //lblDOB.Text = dtDetails.Rows[0]["PAT_DOB"].ToString();
                DateTime date1 = Convert.ToDateTime(AESEncryptionDecryption.Decrypt(dtDetails.Rows[0]["PAT_DOB"].ToString(), AESEncryptionDecryption.KeyString).Substring(0, 10));
                lblDOB.Text = date1.Month.ToString("00") + "/" + date1.Day.ToString("00") + "/" + date1.Year.ToString("0000");
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
    protected void btnSchedVideo_Click(object sender, EventArgs e)
    {
        Session["ConslId"] = consId;
        Response.Redirect("apd_startSecondOpinion.aspx?docId=" + docId);
    }
    protected void btnSecOpiVideo_Click(object sender, EventArgs e)
    {
        DataTable dtDocAvailbility = new DataTable();
        dtDocAvailbility = objPatBLL.get_secondopnionstarturl(consId, docId);
        
        if (dtDocAvailbility.Rows.Count > 0)
        {
                returnVal = objPatBLL.insLiveConsultaion_SecOpinion(docId.ToString(), Session["userId"].ToString(), "Waiting for doctor", dtDocAvailbility.Rows[0]["LCDS_JOIN_URL"].ToString());
                objDocBLL.updDocLiveConsCurrentStatus(docId.ToString(), 3);
                objPatBLL.updSecOpiVideoStatus(Request.QueryString["consID"].ToString());

                StringBuilder sb = new StringBuilder();
                sb.Append("window.open('" + dtDocAvailbility.Rows[0]["LCDS_START_URL"].ToString() + "','Warning', 'dependent=yes,minimizable=no,fullscreen=no,width=525,height=300,left=100,top=100,resizable=yes;status=no,toolbar=no,titlebar=no,menubar=no,location=no,scrollbars=yes');window.focus();");

                ScriptManager.RegisterStartupScript(Page, typeof(Page), "dialog", sb.ToString(), true);
        }
        else
        {
            hfBtnText.Value = "Wait for doctor to join the consultation"; 
            ScriptManager.RegisterStartupScript(this, GetType(), "startSPVideoFunction", "startSPVideoFunction();", true);          
        }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string checkSOTiming(string pageName, string cnsId)
    {
        apd_consultationDetails thisObj = new apd_consultationDetails();
        if (pageName == "Completed")
        {
            DataTable dtSecOpiData = new DataTable();
            thisObj.objPatBLL.Consulation_id = Convert.ToInt32(cnsId);
            dtSecOpiData = thisObj.objPatBLL.getPatSecOpVideoCnsData(thisObj.objPatBLL);
            if (dtSecOpiData.Rows.Count > 0 && dtSecOpiData.Rows.Count < 3)
            {
                return dtSecOpiData.Rows[0][1].ToString() + "~~~" + dtSecOpiData.Rows[0][2].ToString() + "~~~" + dtSecOpiData.Rows[0][0].ToString()
                    + "~~~" + dtSecOpiData.Rows[0][4].ToString();
            }
            if (dtSecOpiData.Rows.Count == 0)
            {
                return "Start"; // No second video consultations are done till time
            }
            else
            {
                //thisObj.btnSchedVideo.Visible = true;
                return "";
            }
        }
        return "";
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string chkSPVideoZoom(string btnName, string pageName, string cnsId)
    {
        apd_consultationDetails thisObj = new apd_consultationDetails();
        if (pageName == "Completed")
        {
            DataTable dtSecOpiData = new DataTable();
            thisObj.objPatBLL.Consulation_id = Convert.ToInt32(cnsId);
            Int64 schedTimeID = thisObj.objPatBLL.getSchedTimeID(cnsId);
            dtSecOpiData = thisObj.objPatBLL.chkIsDocPresent(thisObj.objPatBLL, schedTimeID.ToString());
            if (dtSecOpiData.Rows.Count > 0 && dtSecOpiData.Rows.Count < 3 && dtSecOpiData.Rows[0]["ST_IsDocPresent"].ToString() == "True")
            {
                if (dtSecOpiData.Rows[0]["LCDS_JOIN_URL"].ToString() != "")
                {
                    thisObj.objPatBLL.insLiveConsultaion_SecOpinion(HttpContext.Current.Session["docId"].ToString(),
                            HttpContext.Current.Session["userId"].ToString(), "Waiting for doctor", dtSecOpiData.Rows[0]["LCDS_JOIN_URL"].ToString());

                    thisObj.objDocBLL.updDocLiveConsCurrentStatus(HttpContext.Current.Session["docId"].ToString(), 3);

                    thisObj.objPatBLL.updSecOpiVideoStatus(cnsId);

                    return dtSecOpiData.Rows[0]["LCDS_JOIN_URL"].ToString();
                }
                else
                    return "false";
            }
            if (dtSecOpiData.Rows.Count == 0)
            {
                return "false"; // doc not present in video 
            }
        }
        return "false";
    }
}


