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
using System.IO;
using System.Xml;
using System.Text;

public partial class register : System.Web.UI.Page
{
    DAC.BLL.clsRegisterBLL objRegisterBLL = new DAC.BLL.clsRegisterBLL();
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();

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

    GetZoomData objGetZoomData = new GetZoomData();
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (lblId.Text != "Email already registered" && lblUsr.Text != "Username not available")
        {
            //all validations are happening at the client end...       
            objRegisterBLL.UserTypeId = Convert.ToInt32(ddlUserType.SelectedValue.ToString());
            objRegisterBLL.Email = AESEncryptionDecryption.Encrypt(tbEmail.Text, AESEncryptionDecryption.KeyString);
            if (!ddlUserType.SelectedItem.Text.Equals("Doctor"))
            {
                objRegisterBLL.FirstName = AESEncryptionDecryption.Encrypt(tbFirstName.Text, AESEncryptionDecryption.KeyString);
                objRegisterBLL.LastName = AESEncryptionDecryption.Encrypt(tbLastName.Text, AESEncryptionDecryption.KeyString);
            }
            else
            {
                objRegisterBLL.FirstName = tbFirstName.Text;
                objRegisterBLL.LastName = tbLastName.Text;
            }
            objRegisterBLL.Password = AESEncryptionDecryption.Encrypt(tbPassword.Text, AESEncryptionDecryption.KeyString);
            objRegisterBLL.ConfirmPassword = tbConfirmPassword.Text;
            objRegisterBLL.UserName = AESEncryptionDecryption.Encrypt(tbUsername.Text, AESEncryptionDecryption.KeyString);

            long size = (new FileInfo(Server.MapPath("~/img/a1.jpg"))).Length;
            FileStream fs = new FileStream(Server.MapPath("~/img/a1.jpg"), FileMode.Open, FileAccess.Read);
            byte[] data = new byte[size];
            try
            {
                fs.Read(data, 0, (int)size);
            }
            finally
            {
                fs.Close();
                fs.Dispose();
            }

            objRegisterBLL.DefaultImage = data;
            Session["userId"] = objRegisterBLL.insRegisterDetails(objRegisterBLL);
            string testMail = tbUsername.Text + "_" + Session["userId"].ToString() + "@zoltglobal.com";
            string zoomId = AESEncryptionDecryption.Encrypt(tbUsername.Text + "_" + Session["userId"].ToString() + "@zoltglobal.com", AESEncryptionDecryption.KeyString);// AESEncryptionDecryption.Encrypt(tbUsername.Text + "_" + Session["userId"].ToString(), AESEncryptionDecryption.KeyString);
            //Session["ZoomId"] = objRegisterBLL.ZoomId;

            if (ddlUserType.SelectedValue.ToString().Equals("2"))
            {

                // --- user creation at zoom 
                Hashtable htZoomKeys = new Hashtable();
                htZoomKeys.Add("email", AESEncryptionDecryption.Decrypt(zoomId, AESEncryptionDecryption.KeyString));
                htZoomKeys.Add("type", "1");
                htZoomKeys.Add("password", tbUsername.Text + "_" + Session["userId"].ToString() + "_123");

                byte[] responseData = objGetZoomData.getZoomData("https://api.zoom.us/v1/user/autocreate", htZoomKeys);

                XmlDocument doc = new XmlDocument();
                string xml = Encoding.UTF8.GetString(responseData);
                doc.LoadXml(xml);

                XDocument xdoc = new XDocument();
                xdoc = XDocument.Parse(xml);

                string hostID = xdoc.Root.Element("id").Value;

                objRegisterBLL.updZoomHostID(zoomId, hostID, Session["userId"].ToString());
                // --- end of user creation at zoom 
            }

            // Insert welcome message
            objGlobalBLL.ToId = Convert.ToInt32(Session["userId"].ToString());
            objGlobalBLL.ToTypeId = Convert.ToInt32(ddlUserType.SelectedValue);
            objGlobalBLL.Subject = "Welcome message";
            objGlobalBLL.Message = "Dear " + tbFirstName.Text + "!, Welcome to Prime Doc";
            int Message_insert = objGlobalBLL.InsMessages(objGlobalBLL);
            //end of Insert welcome message

            ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect",
                "alert('Registration Successful. Please login by entering your credentials.'); window.location='" +
                Request.ApplicationPath + "/login.aspx';", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect",
                  "alert('Username/Email already registered. Please register with new Id');", true);
        }
    }

    protected void tbEmail_TextChanged(object sender, EventArgs e)
    {        
        if (!string.IsNullOrEmpty(tbEmail.Text))
        {
            objRegisterBLL.UserTypeId = Convert.ToInt32(ddlUserType.SelectedValue);
            objRegisterBLL.Email = AESEncryptionDecryption.Encrypt(tbEmail.Text.Trim().ToString(), AESEncryptionDecryption.KeyString);
            int result = objRegisterBLL.checkEmail(objRegisterBLL);

            if (result >= 1)
            {
                imgId.ImageUrl = "~/img/unavailable.png";
                imgId.Visible = true;
                lblId.Text = "Email already registered";
                lblId.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                imgId.ImageUrl = "~/img/tick.png";
                imgId.Visible = true;
                lblId.Text = "Available";
                lblId.ForeColor = System.Drawing.Color.Green;
            }
        }
    }

    protected void tbUsername_TextChanged(object sender, EventArgs e)
    {       
        if (!string.IsNullOrEmpty(tbUsername.Text))
        {
            objRegisterBLL.UserTypeId = Convert.ToInt32(ddlUserType.SelectedValue);
            objRegisterBLL.UserName = AESEncryptionDecryption.Encrypt(tbUsername.Text.Trim().ToString(), AESEncryptionDecryption.KeyString);
            int result = objRegisterBLL.checkUserName(objRegisterBLL);

            if (result >= 1)
            {
                imgUsr.ImageUrl = "~/img/unavailable.png";
                imgUsr.Visible = true;
                lblUsr.Text = "Username not available";
                lblUsr.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                imgUsr.ImageUrl = "~/img/tick.png";
                imgUsr.Visible = true;
                lblUsr.Text = "Available";
                lblUsr.ForeColor = System.Drawing.Color.Green;
            }
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static void checkUserRegistration(string email,string name)
    {
        try
        {
            register objRegister = new register();
            int returnVal = objRegister.chkGmailMailID(email);
            if (returnVal == 0)
            {
                objRegister.objRegisterBLL.UserTypeId = 1;
                objRegister.objRegisterBLL.Email = AESEncryptionDecryption.Encrypt(email, AESEncryptionDecryption.KeyString);
                objRegister.objRegisterBLL.FirstName = AESEncryptionDecryption.Encrypt(name.Replace(" ", ""), AESEncryptionDecryption.KeyString);
                objRegister.objRegisterBLL.LastName = AESEncryptionDecryption.Encrypt(name.Replace(" ", ""), AESEncryptionDecryption.KeyString); 
                objRegister.objRegisterBLL.Password = AESEncryptionDecryption.Encrypt("primedoc123", AESEncryptionDecryption.KeyString);
                string[] parts = email.Split('@');
                objRegister.objRegisterBLL.UserName = AESEncryptionDecryption.Encrypt(parts[0], AESEncryptionDecryption.KeyString);

                //System.Web.Hosting.HostingEnvironment.MapPath("path of folder where you want to save image");
                long size = (new FileInfo(System.Web.Hosting.HostingEnvironment.MapPath("~/img/a1.jpg"))).Length;
                FileStream fs = new FileStream(System.Web.Hosting.HostingEnvironment.MapPath("~/img/a1.jpg"), FileMode.Open, FileAccess.Read);
                byte[] data = new byte[size];
                try
                {
                    fs.Read(data, 0, (int)size);
                }
                finally
                {
                    fs.Close();
                    fs.Dispose();
                }

                objRegister.objRegisterBLL.DefaultImage = data;

                HttpContext.Current.Session["userId"] = objRegister.objRegisterBLL.insRegisterDetails(objRegister.objRegisterBLL);
            }
            else
             {
                System.Globalization.CultureInfo cultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture;
                System.Globalization.TextInfo textInfo = cultureInfo.TextInfo;
                string[] parts = email.Split('@');
                HttpContext.Current.Session["userTypeId"] = 1;

                objRegister.objRegisterBLL.UserTypeId = 1;
                objRegister.objRegisterBLL.UserName = AESEncryptionDecryption.Encrypt(parts[0], AESEncryptionDecryption.KeyString);

                objRegister.objRegisterBLL.Password = AESEncryptionDecryption.Encrypt("primedoc123", AESEncryptionDecryption.KeyString);

                DataSet dsMenuList = new DataSet();
                dsMenuList = objRegister.objRegisterBLL.chkLoginDetails(objRegister.objRegisterBLL);


                if (dsMenuList.Tables.Count == 2)
                {
                    string activeStatus = dsMenuList.Tables[1].Rows[0][2].ToString();
                    string loginstatus = dsMenuList.Tables[1].Rows[0][4].ToString();
                    string firstname = dsMenuList.Tables[1].Rows[0][1].ToString();
                    string Lastname = dsMenuList.Tables[1].Rows[0][3].ToString(); 
                    
                    if (activeStatus == "True")
                    {
                        //if (!dsMenuList.Tables[0].Rows[0][0].ToString().Equals(""))
                        //{
                        HttpContext.Current.Session["userName"] = parts[0];
                        HttpContext.Current.Session["menuList"] = dsMenuList.Tables[0];
                        firstname = textInfo.ToTitleCase(AESEncryptionDecryption.Decrypt(firstname, AESEncryptionDecryption.KeyString)).Replace("+","");
                        HttpContext.Current.Session["firstname"] = firstname;
                        Lastname = AESEncryptionDecryption.Decrypt(Lastname, AESEncryptionDecryption.KeyString).Replace("+", "");
                        HttpContext.Current.Session["LastName"] = Lastname;
                        HttpContext.Current.Session["userId"] = dsMenuList.Tables[1].Rows[0][0].ToString();
                        objRegister.objRegisterBLL.Result = "successfully";
                        int val = objRegister.objRegisterBLL.Insert_Loginnattempt(objRegister.objRegisterBLL);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private int chkGmailMailID(string email)
    {
        objRegisterBLL.UserTypeId = 1;
        objRegisterBLL.Email = AESEncryptionDecryption.Encrypt(email, AESEncryptionDecryption.KeyString);
        int result = objRegisterBLL.checkEmail(objRegisterBLL);
        return result;
    }

}
