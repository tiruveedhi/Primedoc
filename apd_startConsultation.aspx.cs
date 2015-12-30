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
using System.Web.Script.Services;
using System.Web.Services;
using System.Collections.Generic;

public partial class apd_startConsultation : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL obj_patientbll = new DAC.BLL.clspatientBLL();
    DAC.BLL.clsGlobalBLL obj_global = new DAC.BLL.clsGlobalBLL();
    DataSet ds_rate = new DataSet();
    double fee;
    DataSet dsSearch = new DataSet();
    DataSet dsDocList = new DataSet();
    string specialityId;
    int Doctor_Usertype;
    protected void Page_Load(object sender, EventArgs e)
    {
        var doc_Id = Request.QueryString["docId"];
        hidden_docid.Value = doc_Id;
        var speciality_Id = Request.QueryString["specialty"];
        string[] str = speciality_Id.Split('/');

        if (doc_Id == null)
        {
            Response.Redirect("apd_newConsultation.aspx");
        }
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
       
        string docDetails = Session["DocVariables"].ToString();
        string[] splitDocDetails = docDetails.Split('~');
        this.lblDocName.Text = splitDocDetails[0].ToString();
      //  this.lblSpeciality.Text = splitDocDetails[1].ToString();

        if (!IsPostBack)
        {
           // fill_Mode();
            int patient_id = Convert.ToInt32(Session["userId"].ToString());

            fillLanguage();
            fill_Gender();
            fillSpeciality();
            rbtnSpecialities.DataSource = str;
            rbtnSpecialities.DataBind();

            rbtnSpecialities.Items[0].Selected = true;
           
          bindReferringDoctor();
            //bindGrid();
        }
        
        txtSpecialization.Text = rbtnSpecialities.SelectedValue;
        //specialityId = splitDocDetails[2].ToString();
        ds_rate = obj_patientbll.Get_consulationrate(doc_Id, rbtnSpecialities.SelectedItem.Value);
        if (ds_rate.Tables[0].Rows.Count > 0)
        {
            lbl.Text = ds_rate.Tables[0].Rows[0]["DSP_EXPRESS_RATE"].ToString();
            lblrate.Text = ds_rate.Tables[0].Rows[0]["DSP_REGULAR_RATE"].ToString();

            specialityId = ds_rate.Tables[0].Rows[0]["SPE_SPECIALTIYID"].ToString();
            Doctor_Usertype = Convert.ToInt32(ds_rate.Tables[0].Rows[0]["DOC_USERTYPEID"].ToString());
        }
    }

    public void fill_Gender()
    {
        DataSet ds_gender = new DataSet();
        ds_gender = obj_global.getGenderList();
        ddlGenderList.DataTextField = "GND_GENDER";
        ddlGenderList.DataValueField = "GND_GENDERID";
        ddlGenderList.DataSource = ds_gender;
        ddlGenderList.DataBind();
        //ddlGenderList.SelectedIndex = 0;
        ddlGenderList.Items.Insert(0, new ListItem("Select", string.Empty));
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
      DataSet  dsSpeciality = new DataSet();
        dsSpeciality = obj_global.getSpeciality();

        ddlSpeciality.DataSource = dsSpeciality.Tables[0];
        ddlSpeciality.DataTextField = "SPE_SPECIALTY";
        ddlSpeciality.DataValueField = "SPE_SPECIALTIYID";
        ddlSpeciality.DataBind();
        ddlSpeciality.Items.Insert(0, new ListItem("Select", string.Empty));
    }
    //public void fill_Mode()
    //{
    //    DataSet ds_tranmode = new DataSet();
    //    ds_tranmode = obj_global.GetTransaction_Mode();
    //    ddlmode.DataValueField = "CNST_CNSTYPEID";
    //    ddlmode.DataTextField = "CNST_CNSMODE";
    //    ddlmode.DataSource = ds_tranmode;
    //    ddlmode.DataBind();
    //    ddlmode.Items[0].Selected = true;
    //}
   

    //protected void Button1_Click(object sender, EventArgs e)
    //{

    //}
    int con_ID;
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        double currentbal;

        string patient_id = Session["userId"].ToString();

        string patient_usertype = Session["userTypeId"].ToString();
        var doc_Id = Request.QueryString["docId"];

        obj_patientbll.Patient_id = Convert.ToInt32(patient_id);
        obj_patientbll.UserTypeId = Convert.ToInt32(patient_usertype);
        obj_patientbll.Subject = "New Consulation";
        obj_patientbll.Message_Type = "Your Consulation Will be started";
        string options = Request.Form["a"];
         string Consultation_type="";
         int tranactionType=0;
         if (options.Equals("option"))//!String.IsNullOrEmpty(lblrate.Text)
        {
            fee = Convert.ToDouble(lblrate.Text);
            Consultation_type="1";
            tranactionType = 1;// this regualr express transaction type
        }
         if (options.Equals("option1"))//!String.IsNullOrEmpty(lbl.Text)
        {
            fee = Convert.ToDouble(lbl.Text);
            Consultation_type="2";//regular and express id
            tranactionType = 2;
        }
        else
        {
            Page.RegisterStartupScript("kk", "<script> alert('You cannot proceed further due to consultation charges');</script>");

        }
        currentbal = obj_patientbll.checkpatient_bal(patient_id, fee);// Checking Balance

        ClientScriptManager CSM = Page.ClientScript;
        if (currentbal == 0)
        {
            //Page.RegisterStartupScript("kk1", "<script> alert('Unsufficent Balance');</script>");
            ScriptManager.RegisterStartupScript(this, GetType(), "kk", "alert('Unsufficent Balance');", true);
        }
        else
        {
            double balance = currentbal - fee;

            string message = tbMessageToDoctor.Text;

   int consulation_status = 1;

            if (Session["alternateDoc1"] != null)
                alternateDocId1 = Convert.ToInt32(Session["alternateDoc1"].ToString());
            if (Session["alternateDoc2"] != null)
                alternateDocId2 = Convert.ToInt32(Session["alternateDoc2"].ToString());

            con_ID = obj_patientbll.Insert_consulations(obj_patientbll, doc_Id, specialityId, fee, consulation_status, Consultation_type
                , message, Session["Ref_Doc"] == null ? null : Session["Ref_Doc"].ToString());// insert consulation at the same time geting consulation id

            //insert alternate docs
            int val = obj_patientbll.InsertAlternateDocs(con_ID, Convert.ToInt32(doc_Id), alternateDocId1, alternateDocId2);


            int Message_insert = obj_patientbll.PatientInsert_Message(obj_patientbll, doc_Id, Doctor_Usertype);// Insert on Messagestable
            DataSet ds_id = new DataSet();
            ds_id = obj_patientbll.Get_Med_id(obj_patientbll);

            DataTable ds_MedicalFiles = new DataTable();
            ds_MedicalFiles = obj_patientbll.GetFiles(patient_id);
            string filesComposite = "";

            for (int i = 0; i < ds_MedicalFiles.Rows.Count; i++)
            {
                if (i == 0)
                    filesComposite += ds_MedicalFiles.Rows[i]["MFL_PAGENAME"].ToString() + "," + ds_MedicalFiles.Rows[i]["MFL_MEDFILEID"].ToString();
                else
                    filesComposite += "~" + ds_MedicalFiles.Rows[i]["MFL_PAGENAME"].ToString() + "," + ds_MedicalFiles.Rows[i]["MFL_MEDFILEID"].ToString();
            }
            obj_patientbll.Med_files1 = filesComposite;

            
            obj_patientbll.Consulation_id = con_ID;
            int Transaction_TypeDeatls = obj_patientbll.Insert_Transactions(patient_id, fee, tranactionType, balance, obj_patientbll, fee);// INSERT ON TRANSACTION D_PAT_BAL_TRANS

            string Lifestyle_ID = "";
            string Lab_id = "";
            string Medicine_Id = "";
            string Allergies_ID = "";
            string Radiology = "";
            string health_id = "";
            if (ds_id.Tables[0].Rows.Count > 0)
            {
                Lifestyle_ID = ds_id.Tables[0].Rows[0]["ls_id"].ToString();

                Lab_id = ds_id.Tables[0].Rows[0]["lr_id"].ToString();


                Medicine_Id = ds_id.Tables[0].Rows[0]["md_id"].ToString();

                Allergies_ID = ds_id.Tables[0].Rows[0]["al_id"].ToString();

                Radiology = ds_id.Tables[0].Rows[0]["rd_id"].ToString();
                health_id = ds_id.Tables[0].Rows[0]["hp_id"].ToString();

            }
            if (Lifestyle_ID != "")
            {
                obj_patientbll.Lifestyleid = Convert.ToInt32(Lifestyle_ID);
            }
            else
            {
                obj_patientbll.Lifestyleid = 0;
            }
            if (Lab_id != "")
            {
                obj_patientbll.Lab_id = Convert.ToInt32(Lab_id);
            }
            else
            {
                obj_patientbll.Lab_id = 0;
            }
            if (Allergies_ID != "")
            {
                obj_patientbll.Allergies_id = Convert.ToInt32(Allergies_ID);
            }
            else
            {
                obj_patientbll.Allergies_id = 0;
            }
            if (Radiology != "")
            {
                obj_patientbll.Radilogy_ID = Convert.ToInt32(Radiology);
            }
            else
            {
                obj_patientbll.Radilogy_ID = 0;
            }
            if (health_id != "")
            {
                obj_patientbll.HealthId = Convert.ToInt32(health_id);
            }
            else
            {
                obj_patientbll.HealthId = 0;
            }
            if (Medicine_Id != "")
            {
                obj_patientbll.Medicine_id = Convert.ToInt32(Medicine_Id);
            }
            else
            {
                obj_patientbll.Medicine_id = 0;
            }

            obj_patientbll.patient_InsertMedicalconsulationID(obj_patientbll, doc_Id);// INSERT MEDICALRECORD

            //alert success and clear fields
            Page.RegisterStartupScript("kk1", "<script> alert('Consultation was started successfully.');</script>");
            tbMessageToDoctor.Text = "";
            //ddlmode.SelectedIndex = 0;
        }
    }

    public void bindGrid()
    {
        var primaryDocID = Request.QueryString["docId"];
        dsSearch = obj_patientbll.Search_doctordisplaySpeciality(rbtnSpecialities.SelectedItem.Text);

        dsDocList = dsSearch.Clone();

        for (int i = 0; i < dsSearch.Tables[0].Rows.Count; i++)
        {
            if (dsSearch.Tables[0].Rows[i].ItemArray[0].ToString() != primaryDocID)
            {
                dsDocList.Tables[0].ImportRow(dsSearch.Tables[0].Rows[i]);
            }
        }

        gvSearch.DataSource = dsDocList;
        gvSearch.DataBind();
        gvSearch.Columns[1].Visible = false;
    }

    public void fillLanguage()
    {
        DataSet dsLanguage = new DataSet();
        dsLanguage = obj_global.getLanguages();

        ddllanuage.DataTextField = "LAG_LANGUAGE";
        ddllanuage.DataValueField = "LAG_LANGUAGEID";
        ddllanuage.DataSource = dsLanguage;
        ddllanuage.DataBind();
        ddllanuage.Items.Insert(0, new ListItem("Select", string.Empty));
        //Fill refering doctor
        ddl_lanuage.DataTextField = "LAG_LANGUAGE";
        ddl_lanuage.DataValueField = "LAG_LANGUAGEID";
        ddl_lanuage.DataSource = dsLanguage;
        ddl_lanuage.DataBind();
        ddl_lanuage.Items.Insert(0, new ListItem("Select", string.Empty));
    }

    private void bindReferringDoctor()
    {
      DataSet  ds_Search = obj_patientbll.searchDoctorDisplay_Patient();
        gvReferringDoc.DataSource = ds_Search;
        gvReferringDoc.DataBind();
        gvReferringDoc.Columns[1].Visible = false;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        btnAlternativeDocs_ModalPopupExtender.Show();
        var primaryDocID = Request.QueryString["docId"];
        string strSearch = Search();// This Search basesd on Doctor Name,location ,SPECIALTY
        dsSearch = obj_patientbll.search_Doctor(strSearch);

        dsDocList = dsSearch.Clone();

        for (int i = 0; i < dsSearch.Tables[0].Rows.Count; i++)
        {
            if (dsSearch.Tables[0].Rows[i].ItemArray[0].ToString() != primaryDocID)
            {
                dsDocList.Tables[0].ImportRow(dsSearch.Tables[0].Rows[i]);
            }
        }

        gvSearch.Columns[1].Visible = true;
        gvSearch.DataSource = dsDocList;
        gvSearch.DataBind();
        gvSearch.Columns[1].Visible = false;
    }
    public string Search()//This Search basesd on Doctor Name,location ,SPECIALTY
    {
        string strQry = "";
      
        if (ddllanuage.SelectedIndex != 0)//(ddllanuage.SelectedItem.Text != "")
        {
                strQry = strQry + " and (LAG_LANGUAGE Like '%" + ddllanuage.SelectedItem.Text + "%' or LAG_LANGUAGE is null) ";
        }
        if (ddlGenderList.SelectedIndex != 0)//(ddlGenderList.SelectedItem.Text != "")
        {
                strQry = strQry + " and GND_GENDER Like '%" + ddlGenderList.SelectedItem.Text + "%' ";
        }
        if (txtdoctor.Text != "")
        {
            string docName = txtdoctor.Text.Trim();
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

        if (txtSpecialization.Text != "")
        {
                strQry = strQry + " and  SPE_SPECIALTY Like '%" + txtSpecialization.Text.ToString().TrimStart() + "%' ";
        }

        if (txtLocation.Text != "")
        {
                strQry = strQry + " and DST_DISTRICTNAME Like '%" + txtLocation.Text + "%'";
        }

        return strQry;
    }

    DataTable dtSelectedDocs = new DataTable();
    int alternateDocId1 = 0, alternateDocId2 = 0;
    string alternateDocName1, alternateDocName2;
    protected void GetSelectedRecords(object sender, EventArgs e)
    {
        dtSelectedDocs.Columns.AddRange(new DataColumn[2] { new DataColumn("Id"), new DataColumn("Name") });
        foreach (GridViewRow row in gvSearch.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                if (chkRow.Checked)
                {
                    string id = row.Cells[1].Text;
                    string name = row.Cells[2].Text;
                    dtSelectedDocs.Rows.Add(id, name);
                }
            }
        }

        if (dtSelectedDocs.Rows.Count > 0)
        {
            lblSelectedDocs.Visible = true;
            StringBuilder sb = new StringBuilder();

            if (dtSelectedDocs.Rows.Count == 0)
            {
                Session["alternateDoc1"] = "0";
                Session["alternateDoc2"] = "0";
            }
            if (dtSelectedDocs.Rows.Count == 1)
            {
                Session["alternateDoc1"] = dtSelectedDocs.Rows[0][0].ToString();

                alternateDocName1 = dtSelectedDocs.Rows[0][1].ToString();
            }
            if (dtSelectedDocs.Rows.Count == 2)
            {
                Session["alternateDoc1"] = dtSelectedDocs.Rows[0][0].ToString();
                Session["alternateDoc2"] = dtSelectedDocs.Rows[1][0].ToString();

                alternateDocName1 = dtSelectedDocs.Rows[0][1].ToString();
                alternateDocName2 = dtSelectedDocs.Rows[1][1].ToString();
            }


            sb.AppendLine(alternateDocName1);
            sb.AppendLine(alternateDocName2);
            lblSelectedDocs.Text = sb.ToString().Replace(Environment.NewLine, "<br />");
        }
        else
            lblSelectedDocs.Visible = false;
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
            Session["Ref_Doc"] = dtSelectedRefDoc.Rows[0][0].ToString();
           // lblReferringDoc.Text = dtSelectedRefDoc.Rows[0][1].ToString().Replace(Environment.NewLine, "<br />"); 
        }
    }
    protected void rbtnSpecialities_SelectedIndexChanged(object sender, EventArgs e)
    {
        //var doc_Id = Request.QueryString["docId"];
        //ds_rate = obj_patientbll.Get_consulationrate(doc_Id, rbtnSpecialities.SelectedItem.Value);
        //if (ds_rate.Tables[0].Rows.Count > 0)
        //{
        //    lblrate.Text = ds_rate.Tables[0].Rows[0]["DSP_EXPRESS_RATE"].ToString();
        //    lbl.Text = ds_rate.Tables[0].Rows[0]["DSP_REGULAR_RATE"].ToString();

        //    specialityId = ds_rate.Tables[0].Rows[0]["SPE_SPECIALTIYID"].ToString();
        //    Doctor_Usertype = Convert.ToInt32(ds_rate.Tables[0].Rows[0]["DOC_USERTYPEID"].ToString());
        //}
    }


    //[WebService(Namespace = "http://tempuri.org/")]
    //[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    //[System.ComponentModel.ToolboxItem(false)]
    //// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    //[System.Web.Script.Services.ScriptService]
    //public class Test : System.Web.Services.WebService
    //{

        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]        
        public static string get_rates(string doc_id,string value)
        {

            DAC.BLL.clspatientBLL obj_patientbll = new DAC.BLL.clspatientBLL();
           DataSet ds=new DataSet();

           ds = obj_patientbll.Get_consulationrate(doc_id, value);
      
       return ds.Tables[0].Rows[0]["DSP_EXPRESS_RATE"].ToString() + "," + ds.Tables[0].Rows[0]["DSP_REGULAR_RATE"].ToString() + ", " + ds.Tables[0].Rows[0]["SPE_SPECIALTIYID"].ToString() + "," + ds.Tables[0].Rows[0]["DOC_USERTYPEID"].ToString();
      
        }
    //}
    protected void btnSelectDoctors_Click(object sender, EventArgs e)
    {
        btnSearch_Click(sender, e);
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        SaveCheckedValues();
        gvSearch.PageIndex = e.NewPageIndex;
        btnSearch_Click(sender, e);
        PopulateCheckedValues();
    }
    protected void gvReferringDoc_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvReferringDoc.PageIndex = e.NewPageIndex;
        bindReferringDoctor();
    }
    private void PopulateCheckedValues()
    {
        ArrayList userdetails = (ArrayList)Session["CHECKED_ITEMS"];
        if (userdetails != null && userdetails.Count > 0)
        {
            foreach (GridViewRow gvrow in gvSearch.Rows)
            {
                int index = (int)gvSearch.DataKeys[gvrow.RowIndex].Value;
                if (userdetails.Contains(index))
                {
                    CheckBox myCheckBox = (CheckBox)gvrow.FindControl("chkRow");
                    myCheckBox.Checked = true;
                }
            }
        }
    }
    //This method is used to save the checkedstate of values
    private void SaveCheckedValues()
    {
        ArrayList userdetails = new ArrayList();
        int index = -1;
        foreach (GridViewRow gvrow in gvSearch.Rows)
        {
            index = (int)gvSearch.DataKeys[gvrow.RowIndex].Value;
            bool result = ((CheckBox)gvrow.FindControl("chkRow")).Checked;

            // Check in the Session
            if (Session["CHECKED_ITEMS"] != null)
                userdetails = (ArrayList)Session["CHECKED_ITEMS"];
            if (result)
            {
                if (!userdetails.Contains(index))
                    userdetails.Add(index);
            }
            else
                userdetails.Remove(index);
        }
        if (userdetails != null && userdetails.Count > 0)
            Session["CHECKED_ITEMS"] = userdetails;
    }
    // Reffering doctor search
    protected void btn_search_Click(object sender, EventArgs e)
    {
        DataSet ds_reffering = new DataSet();
        string str_search = Search_RefferingDoctor();// This Search basesd on Doctor Name,location ,SPECIALTY
        ds_reffering = obj_patientbll.search_Doctor(str_search);
        gvReferringDoc.Columns[1].Visible = true;
    
        gvReferringDoc.DataSource = ds_reffering;
        gvReferringDoc.DataBind();
        gvReferringDoc.Columns[1].Visible = false;
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
    //protected void gvSearch_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        if (e.Row.Cells[2].Text.Length > 30)
    //        {
    //            string a = e.Row.Cells[2].Text;
    //            string[] b = a.Split(' ');
    //            e.Row.Cells[2].Text = AESEncryptionDecryption.Decrypt(b[0], AESEncryptionDecryption.KeyString) + " " + AESEncryptionDecryption.Decrypt(b[1], AESEncryptionDecryption.KeyString);
    //        }
    //    }
    //}
}
