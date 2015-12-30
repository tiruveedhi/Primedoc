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
using System.Net.Mail;
using System.IO;
using System.Net;
public partial class Forgotpassword : System.Web.UI.Page
{
    DAC.BLL.clsRegisterBLL objRegisterBLL = new DAC.BLL.clsRegisterBLL();
    DataSet ds_forget = new DataSet();
    string AESKey = "Key@AES1234";
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnforget_Click(object sender, EventArgs e)
    {
        objRegisterBLL.UserTypeId = Convert.ToInt32(Session["userTypeId"]);
        objRegisterBLL.Email = AESEncryptionDecryption.Encrypt(tbEmail.Text, AESEncryptionDecryption.KeyString);
        ds_forget = objRegisterBLL.Forgetpassword(objRegisterBLL);
        if (ds_forget.Tables[0].Rows.Count > 0)
        {
            if (objRegisterBLL.UserTypeId == 1 || objRegisterBLL.UserTypeId == 2 || objRegisterBLL.UserTypeId == 3)
            {

                if (ds_forget.Tables[0].Rows[0]["password"].ToString() != "")
                {
                    string password = AESEncryptionDecryption.Decrypt(ds_forget.Tables[0].Rows[0]["password"].ToString(), AESEncryptionDecryption.KeyString);
                    MailMessage Msg = new MailMessage();
                    Msg.From = new MailAddress(tbEmail.Text);
                    Msg.To.Add(tbEmail.Text);
                    Msg.Subject = "Your Password Details";
                    Msg.Body = "Hi,<br/>Please check your Login Detailss<br/>Your Password: " + password + "<br/><br/>http://primedoc.dyndns.org/primedoc/login.aspx";
                    Msg.IsBodyHtml = true;
                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = "smtp.gmail.com";
                    smtp.Port = 587;
                    smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                    smtp.UseDefaultCredentials = false;
                    NetworkCredential NetworkCred = new NetworkCredential("sailajareddy.ravula@gmail.com", "sailajareddy1229");
                    smtp.Credentials = NetworkCred;
                    smtp.EnableSsl = true;
                    smtp.Send(Msg);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "forget", "alert('Your Password Details Sent to your mail');", true);

                }
                else
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "login", "alert('Enter correct Email');", true);

                }
            }
        }
        

            }


    
}
