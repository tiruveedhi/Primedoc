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
using DAC.BLL;

public partial class changePassword : System.Web.UI.Page
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new clsGlobalBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] != null)
        {
            if (!IsPostBack)

                hdnSession.Value = Session["userName"].ToString();
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            objGlobalBLL.UserTypeId = Convert.ToInt32(Session["userTypeId"]);
            objGlobalBLL.UserId = Convert.ToInt32(Session["userId"]);
            objGlobalBLL.OldPassword = AESEncryptionDecryption.Encrypt(tbOldPassword.Text, AESEncryptionDecryption.KeyString); 
            objGlobalBLL.Password = AESEncryptionDecryption.Encrypt(tbNewPassword.Text, AESEncryptionDecryption.KeyString);

            //read the return value (i.e status) from the stored procedure
            int retVal = objGlobalBLL.changePassword(objGlobalBLL);
            if (retVal == 1)
            {
                lblStatus.Text = "<br><strong>Password has been changed successfully.</strong>";
            }
            else
            {
                lblStatus.Text = "<br><strong>Wrong old password. Please re-enter.</strong>";
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Oops!! following error occured : " + ex.Message.ToString() + "');", true);
        }
    }
}
