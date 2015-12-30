using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using DAC;

public partial class AdminMaster : System.Web.UI.MasterPage
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    DAC.BLL.clsRegisterBLL objRegisterBLL = new DAC.BLL.clsRegisterBLL();
    DataTable ds = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            Session["ProfilePic"] = "profile";
            if (!IsPostBack)
            {
                string curUrl = HttpContext.Current.Request.Url.AbsoluteUri;
                ds = (DataTable)Session["menuList"];
                MenuList.InnerHtml = "<ul class='nav metismenu' id='side-menu'>";
                for (int i = 0; i < ds.Rows.Count; i++)
                {
                    MenuList.InnerHtml += "<li"
                        + (curUrl.Contains(ds.Rows[i][1].ToString()) ? " class='active'" : "")
                        + "><a href='" + ds.Rows[i][1].ToString() + "' title='" + ds.Rows[i][0].ToString() + "'> "
                        + "<i class='" + ds.Rows[i][2].ToString() + "'></i> " +
                                            "<span class='nav-label'>" + ds.Rows[i][0].ToString() + "</span></a></li>";
                }
                MenuList.InnerHtml += "</ul>";

                //show bell messages
                objGlobalBLL.UserTypeId = Convert.ToInt32(Session["userTypeId"]);
                objGlobalBLL.UserId = Convert.ToInt32(Session["userId"]);
                DataTable dtNewMsgsCount = new DataTable();
                dtNewMsgsCount = objGlobalBLL.getNewMessagesCount(objGlobalBLL);
                if (dtNewMsgsCount.Rows.Count > 0)
                {
                    Session["UnreadMsgsCount"] = dtNewMsgsCount.Rows[0][0].ToString();
                    Session["UnreadMsgsTimeDiff"] = dtNewMsgsCount.Rows[0][1].ToString();
                }
            }
            showProfilePic();
        }
        else
        {
            // suppose your login page name is login.aspx
            Response.Redirect("login.aspx", false);
        }
    }

    private void showProfilePic()
    {
        int userId = Convert.ToInt32(Session["userId"]);
        int userTypeId = Convert.ToInt32(Session["userTypeId"]);

        DataTable dt = objGlobalBLL.GetProfilePic(userId, userTypeId);

        if (dt.Rows.Count > 0)
        {
            imgProfile.Src = "~/ProfilePicHandler.ashx?id=" + dt.Rows[0]["IMG_IMAGEID"].ToString();
        }
        else
            imgProfile.Src = "img/a1.jpg"; ;// Server.MapPath(@"/img/a1.jpg");
    }

    protected void lbtnLogout_Click(object sender, EventArgs e)
    {
        //int id=Convert.ToInt32(Session["ID"]);
        //int usertypeid =Convert.ToInt32( Session["userTypeId"]);
        //int val = objRegisterBLL.updateloginstaus(id, false, usertypeid);
        Session.Abandon();
        Session.Clear();
        Session.RemoveAll();
        System.Web.Security.FormsAuthentication.SignOut();
        Response.Redirect("login.aspx", false);
    }

}
