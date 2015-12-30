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

public partial class apd_scheduledConsultation : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL objClsPatBLL = new DAC.BLL.clspatientBLL();
    DAC.BLL.clsGlobalBLL objClsGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DataSet dsSearch = new DataSet();
    DataSet dsSpeciality = null;
    string docId;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillSpeciality();
            fillGender();
            fillLanguage();
            bindGrid();
        }
    }
    public void fillGender()
    {
        DataSet dsGender = new DataSet();
        dsGender = objClsGlobalBLL.getGenderList();
        ddlGenderList.DataTextField = "GND_GENDER";
        ddlGenderList.DataValueField = "GND_GENDERID";
        ddlGenderList.DataSource = dsGender;
        ddlGenderList.DataBind();
        ddlGenderList.Items.Insert(0, new ListItem("Select", string.Empty));
    }
    private void fillSpeciality()
    {
        dsSpeciality = new DataSet();
        dsSpeciality = objClsGlobalBLL.getSpeciality();

        ddlSpeciality.DataSource = dsSpeciality.Tables[0];
        ddlSpeciality.DataTextField = "SPE_SPECIALTY";
        ddlSpeciality.DataValueField = "SPE_SPECIALTIYID";
        ddlSpeciality.DataBind();
        ddlSpeciality.Items.Insert(0, new ListItem("Select", string.Empty));
    }
    public void fillLanguage()
    {
        DataSet dsLanguage = new DataSet();
        dsLanguage = objClsGlobalBLL.getLanguages();
        ddlLanuage.DataTextField = "LAG_LANGUAGE";
        ddlLanuage.DataValueField = "LAG_LANGUAGEID";
        ddlLanuage.DataSource = dsLanguage;
        ddlLanuage.DataBind();
        ddlLanuage.Items.Insert(0, new ListItem("Select", string.Empty));
    }
    public void bindGrid()
    {
        dsSearch = objClsPatBLL.searchDoctorDisplay_Patient();
        gvDocSearchList.DataSource = dsSearch;
        gvDocSearchList.DataBind();
        gvDocSearchList.Columns[0].Visible = false;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string strSearch = Search();// This Search basesd on Doctor Name,location ,SPECIALTY
        dsSearch = objClsPatBLL.search_Doctor(strSearch);
        gvDocSearchList.Columns[0].Visible = true;
        gvDocSearchList.DataSource = dsSearch;
        gvDocSearchList.DataBind();
        gvDocSearchList.Columns[0].Visible = false;
    }

    protected void btnScheduledConsultation_Click(object sender, EventArgs e)
    {
        objClsGlobalBLL.UserId = Convert.ToInt32(Session["userId"]);
        objClsGlobalBLL.UserTypeId = Convert.ToInt32(Session["userTypeId"]);

        DataTable dtPatDetails = new DataTable();
        dtPatDetails = objClsGlobalBLL.Check_MandatoryFields(objClsGlobalBLL);
        if (dtPatDetails.Rows.Count > 0)
        {
            var viewDetails = (Control)sender;
            GridViewRow row = (GridViewRow)viewDetails.NamingContainer;

            docId = row.Cells[0].Text;
            //string specialty = row.Cells[2].Text;
            string docDetails = row.Cells[1].Text + "~" + row.Cells[2].Text;// +"~" + ddlSpeciality.SelectedValue.ToString();
            Session["DocVariables"] = docDetails;
            Response.Redirect("apd_startScheduledConsultation.aspx?docId=" + docId);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "forget", "alert('Enter all fields in personal information');", true);
        }

    }
    public string Search()//This Search basesd on Doctor Name,location ,SPECIALTY
    {
        string strQry = "";
        if (ddlLanuage.SelectedIndex != 0) 
        {
            strQry = strQry + " and (LAG_LANGUAGE Like '%" + ddlLanuage.SelectedItem.Text + "%' or LAG_LANGUAGE is null) ";
        }
        if (ddlGenderList.SelectedIndex != 0)
        {
            strQry = strQry + " and GND_GENDER Like '%" + ddlGenderList.SelectedItem.Text + "%' ";
        }
        if (tbDoctorName.Text != "")
        {
            string docName = tbDoctorName.Text.Trim();
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
        if (ddlSpeciality.SelectedIndex != 0)
        {
            strQry = strQry + " and  SPE_SPECIALTY Like '%" + ddlSpeciality.SelectedItem.Text + "%' ";
        }
        if (tbLocation.Text != "")
        {
            strQry = strQry + " and DST_DISTRICTNAME Like '%" + tbLocation.Text + "%'";
        }

        return strQry;
    }
    protected void ddlSpeciality_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnSearch_Click(sender, e);
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvDocSearchList.PageIndex = e.NewPageIndex;
        btnSearch_Click(sender, e);
    }
}
