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
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
public partial class login : System.Web.UI.Page
{
    DAC.BLL.clsRegisterBLL objRegisterBLL = new DAC.BLL.clsRegisterBLL();
    DataSet dsMenuList = null;
    int userTypeId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillUserType();
        }
    }

    private void fillUserType()
    {
        DataSet dsUsertypes = new DataSet();
        dsUsertypes = objRegisterBLL.getUserTypes();

        ddlUserType.DataSource = dsUsertypes.Tables[0];
        ddlUserType.DataTextField = "UST_USERTYPE";
        ddlUserType.DataValueField = "UST_USERTYPEID";
        ddlUserType.DataBind();
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        CultureInfo cultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture;
        TextInfo textInfo = cultureInfo.TextInfo;
        if (!String.IsNullOrEmpty(tbUsername.Text.Trim().ToString()) && !String.IsNullOrEmpty(tbPassword.Text.Trim().ToString()))
        {
            userTypeId = Convert.ToInt32(ddlUserType.SelectedValue.ToString());

            Session["userTypeId"] = userTypeId;

            objRegisterBLL.UserTypeId = userTypeId;
            objRegisterBLL.UserName = AESEncryptionDecryption.Encrypt(tbUsername.Text, AESEncryptionDecryption.KeyString);
            
            objRegisterBLL.Password = AESEncryptionDecryption.Encrypt(tbPassword.Text, AESEncryptionDecryption.KeyString);
       
            dsMenuList = new DataSet();
            dsMenuList = objRegisterBLL.chkLoginDetails(objRegisterBLL);
            

            if (dsMenuList.Tables.Count == 2)
            {
                
                string activeStatus = dsMenuList.Tables[1].Rows[0][2].ToString();
                string loginstatus = dsMenuList.Tables[1].Rows[0][4].ToString();
                string firstname = dsMenuList.Tables[1].Rows[0][1].ToString();
                string Lastname = dsMenuList.Tables[1].Rows[0][3].ToString();
            
                if (userTypeId == 3)
                {

                    Session["userName"] = tbUsername.Text;

                    Session["LastName"] = AESEncryptionDecryption.Decrypt(Lastname, AESEncryptionDecryption.KeyString); 
                    firstname = textInfo.ToTitleCase(AESEncryptionDecryption.Decrypt(firstname, AESEncryptionDecryption.KeyString));
                    Session["firstname"] = firstname;
                    Session["menuList"] = dsMenuList.Tables[0];

                    Session["userId"] = dsMenuList.Tables[1].Rows[0][0].ToString();
                    objRegisterBLL.Result = "successfully";

                    int val = objRegisterBLL.Insert_Loginnattempt(objRegisterBLL);
                  

                    Response.Redirect("cpd_home.aspx");
                }
                else if (userTypeId == 5)
                {

                    Session["userName"] = tbUsername.Text;
                   
                    Session["LastName"] = AESEncryptionDecryption.Decrypt(Lastname, AESEncryptionDecryption.KeyString);
                    Session["menuList"] = dsMenuList.Tables[0];
                    firstname = textInfo.ToTitleCase(AESEncryptionDecryption.Decrypt(firstname, AESEncryptionDecryption.KeyString));
                    Session["firstname"] = firstname;
                    Session["userId"] = dsMenuList.Tables[1].Rows[0][0].ToString();
                    objRegisterBLL.Result = "successfully";
                    int val = objRegisterBLL.Insert_Loginnattempt(objRegisterBLL);

                    Response.Redirect("cpd_home.aspx");
                }

                else if (userTypeId == 6)
                {
                    Session["userName"] = tbUsername.Text;

                    Session["LastName"] = AESEncryptionDecryption.Decrypt(Lastname, AESEncryptionDecryption.KeyString);
                    firstname = textInfo.ToTitleCase(AESEncryptionDecryption.Decrypt(firstname, AESEncryptionDecryption.KeyString));
                    Session["firstname"] = firstname;
                    Session["menuList"] = dsMenuList.Tables[0];
                    Session["userId"] = dsMenuList.Tables[1].Rows[0][0].ToString();
                    Response.Redirect("manageUser.aspx");
                }
                else
                {
                    if (activeStatus == "True" )
                    {
                        //if (!dsMenuList.Tables[0].Rows[0][0].ToString().Equals(""))
                        //{
                        Session["userName"] = tbUsername.Text;
                        Session["menuList"] = dsMenuList.Tables[0];

                        if (userTypeId != 2)
                        {
                            Session["LastName"] = AESEncryptionDecryption.Decrypt(Lastname, AESEncryptionDecryption.KeyString);
                            firstname = textInfo.ToTitleCase(AESEncryptionDecryption.Decrypt(firstname, AESEncryptionDecryption.KeyString));
                            Session["firstname"] = firstname;
                        }
                        else
                        {
                            Session["LastName"] = Lastname;
                            Session["firstname"] = firstname;
                        }
                        Session["userId"] = dsMenuList.Tables[1].Rows[0][0].ToString();
                        objRegisterBLL.Result = "successfully";
                        int val = objRegisterBLL.Insert_Loginnattempt(objRegisterBLL);
                       // val = objRegisterBLL.updateloginstaus(Convert.ToInt32(Session["userId"]), true, userTypeId);//Login Status
                        if (userTypeId == 1)
                            Response.Redirect("apd_home.aspx");
                        if (userTypeId == 2)
                            Response.Redirect("bpd_home.aspx");
                    }
                    else
                    {
                        checkusername.Visible = false;
                        lblStatus.Text = "Account was deactivated by Admin.";
                        Page.RegisterStartupScript("k", "<script>alert('Account was deactivated by Admin.')</script>");
                        int val = objRegisterBLL.Insert_Loginnattempt(objRegisterBLL);
                    }
                }
            }
            else
            {
                checkusername.Visible = false;
                lblStatus.Text = "Invalid credentials.";
                objRegisterBLL.Result = lblStatus.Text;
                lblStatus.ForeColor = Color.Red;
                int val = objRegisterBLL.Insert_Loginnattempt(objRegisterBLL);
                Page.RegisterStartupScript("alert", "<script>alert('Invalid credentials')</script>");
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "login","alert('Please entere username/password.');", true);

        }
    }

    protected void link_forget_Click(object sender, EventArgs e)
    {
       Response.Redirect("Forgotpassword.aspx");
    }
    protected void ddlUserType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlUserType.SelectedItem.Text.Equals("Patient"))
            divGmailAccount.Style.Add("display", "block");//divGmailAccount.Visible = true;
        else
            divGmailAccount.Style.Add("display", "none");//divGmailAccount.Visible = false;
    }
}
