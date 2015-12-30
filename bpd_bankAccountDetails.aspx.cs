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
public partial class bpd_bankAccountDetails : System.Web.UI.Page
{

    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();
    DataTable dt_details = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            Get_BankDetails();
        }
    }
    private void Get_BankDetails()
    {
        objDocBLL.DocId = Convert.ToInt32(Session["userId"]);
        dt_details = objDocBLL.GetBankDetails(objDocBLL);
        if (dt_details.Rows.Count > 0)
        {
            tbAccountNo.Text = AESEncryptionDecryption.Decrypt(dt_details.Rows[0]["DBD_ACCOUNTNUMBER"].ToString(), AESEncryptionDecryption.KeyString);
            tbCnfmAccountNo.Text = AESEncryptionDecryption.Decrypt(dt_details.Rows[0]["DBD_ACCOUNTNUMBER"].ToString(), AESEncryptionDecryption.KeyString);
            tbUserName.Text = dt_details.Rows[0]["DBD_NAMEOFACCOUNTHOLDER"].ToString();
            ddlaccounttype.SelectedValue = dt_details.Rows[0]["DBD_ACCOUNTTYPE"].ToString();
            tbIFSC.Text = dt_details.Rows[0]["DBD_SWIFTCODE"].ToString();
            tbRooting.Text = dt_details.Rows[0]["DBD_ROOTCODE"].ToString();

        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
           objDocBLL.DocId = Convert.ToInt32(Session["userId"].ToString());
           objDocBLL.Accountnumber = AESEncryptionDecryption.Encrypt(tbAccountNo.Text.ToString(), AESEncryptionDecryption.KeyString); 
            objDocBLL.Accountholdername = tbUserName.Text;
            objDocBLL.Accounttype = Convert.ToInt32(ddlaccounttype.SelectedValue);
            objDocBLL.Swiftcode = tbIFSC.Text;
            objDocBLL.Rootcode = tbRooting.Text;
            dt_details = objDocBLL.GetBankDetails(objDocBLL);
            if (dt_details.Rows.Count > 0)
            {

                int val = objDocBLL.UpdateBankDeatils(objDocBLL);
            }
            else
            {

            int val = objDocBLL.InsertAccountDeatils(objDocBLL);
            }



        }
    }

