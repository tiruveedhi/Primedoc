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

public partial class cpd_manageUsers : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL obj_global = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clsadminBLL obj_admin = new DAC.BLL.clsadminBLL();
    DataSet ds_patient = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            fill();
            fill_language();
            fill_Gender();
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
    public void fill()
    {
        gvSearch.Columns[0].Visible = true;
        ds_patient = obj_admin.Search_patientdispaly();
        gvSearch.DataSource = ds_patient;
        gvSearch.DataBind();
        gvSearch.Columns[0].Visible = false;
    }

    public string Search()
    {
        string strQry = "";
        if (ddllanuage.SelectedIndex != 0) //(ddllanuage.SelectedItem.Text != "")
        {
            if (strQry == "")
                strQry = strQry + " (LAG_LANGUAGE Like '%" + ddllanuage.SelectedItem.Text + "%' or LAG_LANGUAGE is null) ";
            else
                strQry = " and LAG_LANGUAGE Like'%" + ddllanuage.SelectedItem.Text + "%' or LAG_LANGUAGE is null) ";
        }
        if (txtpatient.Text != "")
        {
            string docName = txtpatient.Text.Trim();
            string[] docNameTokens = docName.Split(' ');
            foreach (string docNameToken in docNameTokens)
            {
                if (docNameToken.Trim() != "")
                {
                    if (strQry == "")
                        strQry = strQry + " (PAT_FIRSTNAME Like '%" + docNameToken.Trim() + "%' or " +
                        "PAT_LASTNAME Like '%" + docNameToken.Trim() + "%' )";
                    else
                    strQry = strQry + " and (PAT_FIRSTNAME Like '%" + docNameToken.Trim() + "%' or " +
                        "PAT_LASTNAME Like '%" + docNameToken.Trim() + "%' )";
                }
            }

                //strQry = " and PAT_FIRSTNAME  Like '%" + txtpatient.Text + "%'";// +"and" + " DOC_LANGUAGEID '%" + ddllanuage.SelectedItem.Text + "%'";
        }
        if (ddlGenderList.SelectedIndex != 0)
        {
            if (strQry == "")
                strQry = strQry + " GND_GENDER Like '" + ddlGenderList.SelectedItem.Text + "%'";
            else
            strQry = strQry + " and GND_GENDER Like '" + ddlGenderList.SelectedItem.Text + "%'";
        }
        if (txtlocation.Text != "")
        {
            if (strQry == "")
                strQry = strQry + " DST_DISTRICTNAME Like '%" + txtlocation.Text + "%'";
            else
            strQry = strQry + " and DST_DISTRICTNAME Like '%" + txtlocation.Text + "%'";
        }
        return strQry;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string str_search = Search();// This Search basesd on Doctor Name,location ,SPECIALTY
        ds_patient = obj_admin.Search_Patient(str_search);

        gvSearch.Columns[0].Visible = true;
        gvSearch.DataSource = ds_patient;
        gvSearch.DataBind();
        gvSearch.Columns[0].Visible = false;
    }

    protected void btnSuspend_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow gvrow = (GridViewRow)btn.NamingContainer;
        gvSearch.Columns[0].Visible = true;
        lblPatientId.Text = gvrow.Cells[0].Text;
        gvSearch.Columns[0].Visible = false;
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
    protected void btnDone_Click(object sender, EventArgs e)
    {
        int upda = obj_admin.Update_patientstatus(Convert.ToInt32(lblPatientId.Text), false, tbReason.Text);
        btnSearch_Click(sender, e);
        //fill();
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        int upda = obj_admin.Update_patientstatus(Convert.ToInt32(lblPatientId.Text), true, "");
        //fill();
        btnSearch_Click(sender, e);
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSearch.PageIndex = e.NewPageIndex;
        //fill();
        btnSearch_Click(sender, e);
    }
    protected void gvSearch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[1].Text.Length > 20)
            {
                e.Row.Cells[1].Text = AESEncryptionDecryption.Decrypt(e.Row.Cells[1].Text, AESEncryptionDecryption.KeyString);
            }
        }
    }
}
