﻿using System;
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

public partial class readMessages : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DataTable dtReadMsgs = new DataTable();

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

        dtReadMsgs = objGlobalBLL.getReadMessages(objGlobalBLL);

        gvReadMessages.DataSource = dtReadMsgs;
        gvReadMessages.DataBind();

    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvReadMessages.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
