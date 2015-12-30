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
using System.Collections.Generic;
using System.Data.SqlClient;
//using System.Drawing;

public partial class bpd_professionalBiography : System.Web.UI.Page
{

    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    DataSet dsSpeciality = null;
    int val = 0;
    DataTable dtDetails = new DataTable();
        Button button;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                getSpecialities();
                Session["userPic"] = null;
                getUserDetails();

            }
           showImages();
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    private void showImages()
    {
        pnlView.Controls.Clear();
        DataTable dt = new DataTable();
        objDocBLL.DocId = Convert.ToInt32(Session["userId"]);
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
                img.ImageUrl = "~/ImgHandler.ashx?id=" + dt.Rows[i][0].ToString()+"&patientDetails=no";
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
    public static DataTable FlipDataTable(DataTable dt)
    {
        DataTable table = new DataTable();
        //Get all the rows and change into columns
        for (int i = 0; i <= dt.Rows.Count; i++)
        {
            table.Columns.Add(Convert.ToString(i));
        }
        DataRow dr;
        //get all the columns and make it as rows
        for (int j = 0; j < dt.Columns.Count; j++)
        {
            dr = table.NewRow();
            dr[0] = dt.Columns[j].ToString();
            for (int k = 1; k <= dt.Rows.Count; k++)
                dr[k] = dt.Rows[k - 1][j];
            table.Rows.Add(dr);
        }

        return table;
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

    DataTable dtSelSpeciality = new DataTable();
    private void fillUserDetails()
    {
        // show selected specialities
        dtSelSpeciality = objDocBLL.getSelectedSpecialities(Convert.ToInt32(Session["userId"]));

        for (int i = 0; i < dtSelSpeciality.Rows.Count; i++)
        {
            int langId = Convert.ToInt32(dtSelSpeciality.Rows[i]["SPE_SPECIALTIYID"].ToString());
            ddlSpeciality.Items.FindByValue(langId.ToString()).Selected = true;
        }
        // end of show selected specialities


        //ddlSpeciality.SelectedValue = dtDetails.Rows[0]["DOC_SPECIALTIYID"].ToString();
        tbNPINo.Text = dtDetails.Rows[0]["DOC_NPI_NUMBER"].ToString();
        tbDEANo.Text = dtDetails.Rows[0]["DOC_DEA_NUMBER"].ToString();
        tbBiography.Text = dtDetails.Rows[0]["DOC_PROF_BIO"].ToString();

    }

    private void getSpecialities()
    {
        dsSpeciality = new DataSet();
        dsSpeciality = objGlobalBLL.getSpeciality();

        ddlSpeciality.DataSource = dsSpeciality.Tables[0];
        ddlSpeciality.DataTextField = "SPE_SPECIALTY";
        ddlSpeciality.DataValueField = "SPE_SPECIALTIYID";
        ddlSpeciality.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

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
                dtDocSpec.Rows.Add(Convert.ToInt32(Session["userId"]), specId,dt_SPECIALITIE.Rows[0]["SPE_EXPRESS_RATE"].ToString(),dt_SPECIALITIE.Rows[0]["SPE_REGULAR_RATE"].ToString());
               
                
            }
        }


        val = objDocBLL.InsDocSpecialities(dtDocSpec);

        #endregion


        objDocBLL.DocId = Convert.ToInt32(Session["userId"].ToString());
        //objDocBLL.SpecialityId = Convert.ToInt32(ddlSpeciality.SelectedValue.ToString());
        objDocBLL.NpiNo = tbNPINo.Text;
        objDocBLL.Biography = tbBiography.Text;
        objDocBLL.DeaNo = tbDEANo.Text;

        val = objDocBLL.updDocProfBioDetails(objDocBLL);
        //if (val > 0)
        //    Page.RegisterStartupScript("submit", "<script> alert('Professional biography details are submitted successfully.');</script>");

    }
}
