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
public partial class cpd_managedoctor : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL obj_paientbll = new DAC.BLL.clspatientBLL();
    DAC.BLL.clsGlobalBLL obj_global = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clsadminBLL obj_admin = new DAC.BLL.clsadminBLL();
    DataSet ds_Search = new DataSet();
    DataSet dsSpeciality = null;
    
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            fillSpeciality(); 
            fill();
            fill_language();
            fill_Gender();
        }

    }

    private void fillSpeciality()
    {
        dsSpeciality = new DataSet();
        dsSpeciality = obj_global.getSpeciality();

        ddlSpeciality.DataSource = dsSpeciality.Tables[0];
        ddlSpeciality.DataTextField = "SPE_SPECIALTY";
        ddlSpeciality.DataValueField = "SPE_SPECIALTIYID";
        ddlSpeciality.DataBind();
        ddlSpeciality.Items.Insert(0, new ListItem("Select", string.Empty));
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
    }
    public void fill_language()
    {
        DataSet ds_language = new DataSet();
        ds_language = obj_global.getLanguages();
        ddllanuage.DataTextField = "LAG_LANGUAGE";
        ddllanuage.DataValueField = "LAG_LANGUAGEID";
        ddllanuage.DataSource = ds_language;
        ddllanuage.DataBind();
        ddllanuage.Items.Insert(0, new ListItem("Select", string.Empty));
    }

    public string Search()//This Search basesd on Doctor Name,location ,SPECIALTY
    {

        //string strQry = "LAG_LANGUAGE Like'%" + ddllanuage.SelectedItem.Text + "%'";
       
        // strQry = strQry + " and " + "GND_GENDER Like '%" + ddlGenderList.SelectedItem.Text + "%' ";

        string strQry = "";
        if (ddllanuage.SelectedIndex != 0) //(ddllanuage.SelectedItem.Text != "")
        {
            if (strQry == "")
                strQry = strQry + " (LAG_LANGUAGE Like '%" + ddllanuage.SelectedItem.Text + "%' or LAG_LANGUAGE is null) ";
            else
                strQry = strQry + " and (LAG_LANGUAGE Like '%" + ddllanuage.SelectedItem.Text + "%' or LAG_LANGUAGE is null) ";
        }
        if (ddlGenderList.SelectedIndex != 0)//(ddlGenderList.SelectedItem.Text != "")
        {
            if (strQry == "")
                strQry = strQry + " GND_GENDER Like '%" + ddlGenderList.SelectedItem.Text + "%' ";
            else
                strQry = strQry + " and GND_GENDER Like '%" + ddlGenderList.SelectedItem.Text + "%' ";
        }
       
        if (txtdoctor.Text != "")
        {
            //strQry = strQry + " and " + "DOC_FIRSTNAME+ ' ' +  DOC_LASTNAME Like '%" + txtdoctor.Text + "%'";// +"and" + " DOC_LANGUAGEID '%" + ddllanuage.SelectedItem.Text + "%'";
            string docName = txtdoctor.Text.Trim();
            string[] docNameTokens = docName.Split(' ');
            foreach (string docNameToken in docNameTokens)
            {
                if (docNameToken.Trim() != "")
                {
                    if (strQry == "")
                        strQry = strQry + " (DOC_FIRSTNAME Like '%" + docNameToken.Trim() + "%' or " +
                          "DOC_LASTNAME Like '%" + docNameToken.Trim() + "%' )";
                    else
                        strQry = strQry + " and (DOC_FIRSTNAME Like '%" + docNameToken.Trim() + "%' or " +
                            "DOC_LASTNAME Like '%" + docNameToken.Trim() + "%' )";
                }
            }
        }
        //if (txtspecialization.Text != "")
        //{



        //    strQry = strQry + " and " + "SPE_SPECIALTY Like '%" + txtspecialization.Text + "%'";
        //}
        if (ddlSpeciality.SelectedIndex != 0)
        {
            if (strQry == "")
                strQry = strQry + " SPE_SPECIALTY Like '%" + ddlSpeciality.SelectedItem.Text + "%' ";
            else
                strQry = strQry + " and  SPE_SPECIALTY Like '%" + ddlSpeciality.SelectedItem.Text + "%' ";
        }


        if (txtlocation.Text != "")
        {
            if (strQry == "")
                strQry = strQry + " DST_DISTRICTNAME Like '%" + txtlocation.Text + "%'";
            else
                strQry = strQry + " and DST_DISTRICTNAME Like '%" + txtlocation.Text + "%'";
            //strQry = strQry + " and " + "DST_DISTRICTNAME Like '%" + txtlocation.Text + "%'";
        }
        return strQry;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {

        string str_search = Search();// This Search basesd on Doctor Name,location ,SPECIALTY
        ds_Search = obj_paientbll.searchDoctorAdmin(str_search);
        gvsearch.Columns[0].Visible = true;
        gvsearch.Columns[1].Visible = true;
        gvsearch.DataSource = ds_Search;
        gvsearch.DataBind();
        gvsearch.Columns[0].Visible = false;
        gvsearch.Columns[1].Visible = false;

    }
    protected void ddlSpeciality_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnSearch_Click(sender, e);
    }
    string docId;
    string Usertype;
    public void fill()
    {
        gvsearch.Columns[0].Visible = true;
        gvsearch.Columns[1].Visible = true;
        ds_Search = obj_paientbll.search_Doctordisplay();
        gvsearch.DataSource = ds_Search;
        gvsearch.DataBind();
        gvsearch.Columns[0].Visible = false;
        gvsearch.Columns[1].Visible = false;

    }
    protected void btnEditDetails_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        docId = row.Cells[0].Text;
        Usertype = row.Cells[1].Text;
        Response.Redirect("cpd_Editdoctordetails.aspx?docId=" + docId + "&UserType=" + Usertype);

    }

    protected void btnSuspend_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow gvrow = (GridViewRow)btn.NamingContainer;
        lblDocId.Text = gvrow.Cells[0].Text;

        if (btn.Text == "Suspend")
        {
            btnSuspend_modalpopupextender.Show();
            btnActive_ModalPopupExtender.Hide();
        }
        else
        {
            btnSuspend_modalpopupextender.Hide();
            btnActive_ModalPopupExtender.Show();
        }
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        int upda = obj_admin.Updatedoctorstatus(Convert.ToInt32(lblDocId.Text), true, "");
        fill();
    }

    protected void btnDone_Click(object sender, EventArgs e)
    {
        int upda = obj_admin.Updatedoctorstatus(Convert.ToInt32(lblDocId.Text), false, tbReason.Text);
        fill();
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvsearch.PageIndex = e.NewPageIndex;
        //fill();
        btnSearch_Click(sender, e);
    }
    //protected void gvsearch_RowDataBound(object sender, GridViewRowEventArgs e)
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

