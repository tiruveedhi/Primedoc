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
public partial class apd_allergies : System.Web.UI.Page
{
    DAC.BLL.clspatientBLL obj_patientbll = new DAC.BLL.clspatientBLL();
    DataTable dtDetails = new DataTable();
    Button button;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            Session["pageName"] = "Allergies";
            Session["userPic"] = null;
            if (!IsPostBack)
            {
                getAllergies();
            }
            showFiles();
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    private void showFiles()
    {
        pnlView.Controls.Clear();
        DataTable dt = new DataTable();
        obj_patientbll.Patient_id = Convert.ToInt32(Session["userId"]);
        obj_patientbll.PageName = Session["pageName"].ToString();
        dt = obj_patientbll.GetMedicalFiles(obj_patientbll);

        if (dt.Rows.Count > 0)
        {
            divLoadedImages.Visible = true;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Image img = new Image();
                img.ID = dt.Rows[i][0].ToString();
                img.ImageUrl = "~/ImgHandler.ashx?id=" + dt.Rows[i][0].ToString();
                img.Width = 69;
                img.Height = 69;
                img.Attributes.Add("onclick", "DisplayFullImage(this);");

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
                button.CssClass = "btn-sm btn-danger"; 
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
        Button b = (Button)obj;

        string id = b.ID;
        string[] idSplit = id.Split('-');
        obj_patientbll.RemoveMedicalFiles(idSplit[1]);

        showFiles();
    }
    private void getAllergies()
    {
        obj_patientbll.Patient_id = Convert.ToInt32(Session["userId"]);

        dtDetails = obj_patientbll.getAllergies(obj_patientbll);
        if (dtDetails.Rows.Count > 0)
        {
            tbAllergies.Text = dtDetails.Rows[dtDetails.Rows.Count - 1]["A_ALLERGIE"].ToString();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        obj_patientbll.Patient_id = Convert.ToInt32(Session["userId"]);
        obj_patientbll.ALLERGIES = tbAllergies.Text;
        obj_patientbll.UnitID = 1;
        obj_patientbll.WTUNITID = 1;
        int med_id = obj_patientbll.PatientmedicalRecord_Insert(obj_patientbll);

        obj_patientbll.Medrecord_id = med_id;
        obj_patientbll.patientallergies_Insert(obj_patientbll);
    }
}
