using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using DAC;
using System.Text;
public partial class apd_newConsultation : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL obj_paientbll = new DAC.BLL.clspatientBLL();
    DAC.BLL.clsGlobalBLL obj_global = new DAC.BLL.clsGlobalBLL();
    DataSet ds_Search = new DataSet();
    DataSet dsSpeciality = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillSpeciality();
            fill_Gender();
            fill_language();
            fill();
            //btnSearch_Click(sender, e);
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
        string strQry = "";
        if (ddllanuage.SelectedIndex != 0) //(ddllanuage.SelectedItem.Text != "")
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

        //if (txtspecialization.Text != "")
        //{
        //    strQry = strQry + " and " + "SPE_SPECIALTY Like '%" + txtspecialization.Text + "%' ";
        //}
        if (ddlSpeciality.SelectedIndex != 0)
        {
                strQry = strQry + " and  SPE_SPECIALTY Like '%" + ddlSpeciality.SelectedItem.Text + "%' ";
        }
        if (txtlocation.Text != "")
        {
                strQry = strQry + " and DST_DISTRICTNAME Like '%" + txtlocation.Text + "%'";
        }

        return strQry;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string str_search = Search();// This Search basesd on Doctor Name,location ,SPECIALTY
        ds_Search = obj_paientbll.search_Doctor(str_search);
        gvsearch.Columns[0].Visible = true;
        //gvsearch.Columns[4].Visible = true;
        gvsearch.DataSource = ds_Search;
        gvsearch.DataBind();
        gvsearch.Columns[0].Visible = false;
        //gvsearch.Columns[4].Visible = false;
    }

    string docId;
    public void fill()
    {
        ds_Search = obj_paientbll.searchDoctorDisplay_Patient();
        gvsearch.DataSource = ds_Search;
        gvsearch.DataBind();
        gvsearch.Columns[0].Visible = false;
    }
    DataTable dtDetails = new DataTable();
    protected void btnstartconsulation_Click(object sender, EventArgs e)
    {
        obj_global.UserId = Convert.ToInt32(Session["userId"]);
        obj_global.UserTypeId = Convert.ToInt32(Session["userTypeId"]);

        dtDetails = obj_global.Check_MandatoryFields(obj_global);
        if (dtDetails.Rows.Count > 0)
        {

            var viewDetails = (Control)sender;
            GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

            docId = row.Cells[0].Text;
            string specialty = row.Cells[2].Text;
            string docDetails = row.Cells[1].Text + "~" + ddlSpeciality.SelectedItem.Text + "~" + ddlSpeciality.SelectedValue.ToString();
            Session["DocVariables"] = docDetails;
            Response.Redirect("apd_startConsultation.aspx?docId=" + docId + "&specialty=" + specialty);
        }
        else
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "forget", "alert('Enter all fields in personal information');", true);

        }

    }

    protected void btnviewDetails_Click(object sender, EventArgs e)
    {
        var viewDetails = (Control)sender;
        GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

        docId = row.Cells[0].Text;

        string docDetails = row.Cells[1].Text + "~" + ddlSpeciality.SelectedItem.Text + "~" + ddlSpeciality.SelectedValue.ToString();
        Session["DocVariables"] = docDetails;

        Response.Redirect("apd_doctorviewdetails.aspx?docId=" + docId);
    }

    protected void ddlSpeciality_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnSearch_Click(sender, e);
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvsearch.PageIndex = e.NewPageIndex;
        btnSearch_Click(sender, e);
    }
    //protected void gvsearch_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        if (e.Row.Cells[1].Text.Length > 30)
    //        {
    //            string a = e.Row.Cells[1].Text;
    //            string[] b = a.Split(' ');
    //            e.Row.Cells[1].Text = AESEncryptionDecryption.Decrypt(b[0], AESEncryptionDecryption.KeyString)+" "+AESEncryptionDecryption.Decrypt(b[1], AESEncryptionDecryption.KeyString);
    //        }
    //    }
    //}
}
