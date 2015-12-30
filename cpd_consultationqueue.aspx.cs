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
using System.Drawing;
public partial class cpd_consultationqueue : System.Web.UI.Page
{
    DAC.BLL.clsadminBLL obj_adminbll = new DAC.BLL.clsadminBLL();
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DataSet ds_queue = new DataSet();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            fill_queue();
        }

    }

    public void fill_queue()
    {
        ds_queue = obj_adminbll.Get_queues();
        gv_queue.DataSource = ds_queue;
        gv_queue.DataBind();
        gv_queue.Columns[7].Visible = false;
    }
    string conslID = "";
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = sender as Button;
            GridViewRow gr = (GridViewRow)btn.NamingContainer;
            conslID = gr.Cells[2].Text;
            Session["PatID"] = gr.Cells[3].Text;

            getAlterDocList(conslID);

            //btnEdit_ModalPopupExtender.Show();
        }
        catch
        {
            return;
        }
    }
    private void getAlterDocList(string conslID)
    {
        DataSet dsAlterDocs = new DataSet();
        dsAlterDocs = obj_adminbll.getAlterDocsList(conslID);
        gvEditAlterDocs.Columns[0].Visible = true;
        gvEditAlterDocs.DataSource = dsAlterDocs.Tables[0];
        gvEditAlterDocs.DataBind();
        gvEditAlterDocs.Columns[0].Visible = false;


        if (dsAlterDocs.Tables[0].Rows.Count > 1)
        {
            if (dsAlterDocs.Tables[1].Rows.Count > 0)//consultation status has picked up in previos transactions
                ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect",
                             "alert('You cannot change alternative doctor because case has been picked up.');", true);
            else
                btnEdit_ModalPopupExtender.Show();
        }
        else // Alternative doctors are not selected for the consultation
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect",
                 "alert('Alternative doctors are not selected by the patient.');", true);
            btnEdit_ModalPopupExtender.Hide();
        }
    }
    
    protected void gvEditAlterDocs_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvEditAlterDocs.EditIndex = e.NewEditIndex;
        //conslID = Session["conslID"].ToString();
        Label CNSID = gvEditAlterDocs.Rows[e.NewEditIndex].FindControl("lblCnsId") as Label;
        getAlterDocList(CNSID.Text);
        //btnEdit_ModalPopupExtender.Show();
    }

    protected void gvEditAlterDocs_RowCancelling(object sender, GridViewCancelEditEventArgs e)
    {
        gvEditAlterDocs.EditIndex = -1;
        Label CNSID = gvEditAlterDocs.Rows[e.RowIndex].FindControl("lblCnsId") as Label;
        getAlterDocList(CNSID.Text);
        //btnEdit_ModalPopupExtender.Show();
    }

    protected void gvEditAlterDocs_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string s = gvEditAlterDocs.DataKeys[e.RowIndex].Value.ToString();

        Label SNo = gvEditAlterDocs.Rows[e.RowIndex].FindControl("lblSNo") as Label;
        Label CNSID = gvEditAlterDocs.Rows[e.RowIndex].FindControl("lblCnsId") as Label;
        Label DOCID = gvEditAlterDocs.Rows[e.RowIndex].FindControl("lblDocId") as Label;
        TextBox REASON = gvEditAlterDocs.Rows[e.RowIndex].FindControl("tbReason") as TextBox;

        int retVal = obj_adminbll.UpdateAltDocStatus(SNo.Text, CNSID.Text, DOCID.Text, REASON.Text);
        if (retVal > 0)
        {
            objGlobalBLL.ToId = Convert.ToInt32(Session["PatID"].ToString());
            objGlobalBLL.ToTypeId = 1;//Patient user type
            objGlobalBLL.Subject = "Alternative Doctor";
            objGlobalBLL.Message = "Consultation process is assigned to other doctor.";
            int Message_insert = objGlobalBLL.InsMessages(objGlobalBLL);
        }
        gvEditAlterDocs.EditIndex = -1;
        getAlterDocList(CNSID.Text);
    }
    protected void gvEditAlterDocs_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            // Show 'make active' link only for activestatus - false
            Label obj = (Label)e.Row.FindControl("lblStatus");
            LinkButton lnkEdit = (LinkButton)e.Row.FindControl("lbtnEditStatus");
            if (obj.Text == "True" && lnkEdit.Visible == true)
            {
                lnkEdit.Visible = false;
            }
            if (obj.Text == "False" && lnkEdit != null)
            {
                lnkEdit.Visible = true;
            }

           
            

        }
    }
    protected void gv_queue_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // color coding 
            int hour = (DataBinder.Eval(e.Row.DataItem, "Difference") == DBNull.Value) ? 0 :
                Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Difference"));
            if (hour <= 4)
            {
                e.Row.BackColor = ColorTranslator.FromHtml("#18a689");// Color.Green;
                e.Row.ForeColor = Color.White;
            }
            if (hour > 4)
            {
                e.Row.BackColor = ColorTranslator.FromHtml("#ed5565");//Color.Red;
                e.Row.ForeColor = Color.White;
            }

            Label lbl_patname = (Label)e.Row.FindControl("lbl_patname");
            DataRowView drv = (DataRowView)e.Row.DataItem;
            if (lbl_patname.Text == "ANONYMOUS")
            {
                lbl_patname.Text = drv["Name"].ToString();
            }
            else
            {

                lbl_patname.Text = AESEncryptionDecryption.Decrypt(drv["Name"].ToString(), AESEncryptionDecryption.KeyString);
            }

        }
    }    
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        fill_queue();
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv_queue.PageIndex = e.NewPageIndex;
        fill_queue();
    }
    
}
