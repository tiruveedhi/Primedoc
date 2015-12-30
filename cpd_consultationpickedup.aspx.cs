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
using System.Drawing;

public partial class cpd_consultationpickedup : System.Web.UI.Page
{
    DAC.BLL.clsadminBLL obj_adminbll = new DAC.BLL.clsadminBLL();
    DataSet ds_pick = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            fillPickedup();
        }

    }

    public void fillPickedup()
    {
        gvPickedup.Columns[7].Visible = true;
        ds_pick = obj_adminbll.Get_pickedup();
        gvPickedup.DataSource = ds_pick;
        gvPickedup.DataBind();
        gvPickedup.Columns[7].Visible = false;
    }
    string conslID = "";
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = sender as Button;
            GridViewRow gr = (GridViewRow)btn.NamingContainer;
            conslID = gr.Cells[2].Text;
            //Session["conslID"] = conslID;

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

        if (dsAlterDocs.Tables[0].Rows.Count > 0)
            btnEdit_ModalPopupExtender.Show();
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

        gvEditAlterDocs.EditIndex = -1;
        getAlterDocList(CNSID.Text);

    }
    protected void gv_queue_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
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
        fillPickedup();
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPickedup.PageIndex = e.NewPageIndex;
        fillPickedup();
    }
}
