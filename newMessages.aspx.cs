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
using System.Collections.Generic;

public partial class newMessages : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DataTable dtNewMsgs = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }

        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    private void BindGrid()
    {
        objGlobalBLL.UserTypeId = Convert.ToInt32(Session["userTypeId"]);
        objGlobalBLL.UserId = Convert.ToInt32(Session["userId"]);

        dtNewMsgs = objGlobalBLL.getNewMessages(objGlobalBLL);

        gvNewMessages.DataSource = dtNewMsgs;
        gvNewMessages.DataBind();

    }
    protected void chkboxSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox ChkBoxHeader = (CheckBox)gvNewMessages.HeaderRow.FindControl("chkboxSelectAll");
        foreach (GridViewRow row in gvNewMessages.Rows)
        {
            CheckBox ChkBoxRows = (CheckBox)row.FindControl("chkRow");
            if (ChkBoxHeader.Checked == true)
            {
                ChkBoxRows.Checked = true;
            }
            else
            {
                ChkBoxRows.Checked = false;
            }
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow gvrow in gvNewMessages.Rows)
        {
            //Finiding checkbox control in gridview for particular row
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkRow");
            //Condition to check checkbox selected or not
            if (chkdelete.Checked)
            {
                //Getting UserId of particular row using datakey value
                string MessageID = gvNewMessages.DataKeys[gvrow.RowIndex].Value.ToString();
                objGlobalBLL.updMsgstatus_Delete(MessageID);
            }
        }
        BindGrid();
    }
    private void ShowMessage(int count)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("alert('");
        sb.Append(count.ToString());
        sb.Append(" records deleted.');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),
                        "script", sb.ToString());
    }
    protected void OnPaging(object sender, GridViewPageEventArgs e)
    {
        SaveCheckedValues();
        gvNewMessages.PageIndex = e.NewPageIndex;
        BindGrid();
        PopulateCheckedValues();
    }
    //This method is used to populate the saved checkbox values
    private void PopulateCheckedValues()
    {
        ArrayList userdetails = (ArrayList)Session["CHECKED_ITEMS"];
        if (userdetails != null && userdetails.Count > 0)
        {
            foreach (GridViewRow gvrow in gvNewMessages.Rows)
            {
                int index = (int)gvNewMessages.DataKeys[gvrow.RowIndex].Value;
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
        foreach (GridViewRow gvrow in gvNewMessages.Rows)
        {
            index = (int)gvNewMessages.DataKeys[gvrow.RowIndex].Value;
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
    protected void btnRead_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow gvrow in gvNewMessages.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkRow");
            if (chkdelete.Checked)
            {
                string MessageID = gvNewMessages.DataKeys[gvrow.RowIndex].Value.ToString();
                objGlobalBLL.updMsgstatus_Read(MessageID);
            }
        }
        BindGrid();

    }
    protected void lnkView_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow gvrow = (GridViewRow)btn.NamingContainer;
        lblMessage.Text = btn.Text;
        lblMsgId.Text = gvNewMessages.DataKeys[gvrow.RowIndex].Value.ToString();
        btnView_modalpopupextender.Show();
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        objGlobalBLL.updMsgstatus_Read(lblMsgId.Text);
        BindGrid();
    }
}
