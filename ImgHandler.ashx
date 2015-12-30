<%@ WebHandler Language="C#" Class="ImgHandler" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public class ImgHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        string ConnectString = ConfigurationManager.AppSettings["conStr"];
        SqlConnection connection = new SqlConnection(ConnectString);
        SqlDataReader dr = null;
        int userType = Convert.ToInt32(context.Session["userTypeId"].ToString());
        string PatientDtls = "no";
        try
        {
            connection.Open();
            string id = context.Request.QueryString["id"];
            PatientDtls = context.Request.QueryString["patientDetails"];

            if (userType.ToString() == "2" && !PatientDtls.Equals("yes"))
            {
                SqlCommand command = new SqlCommand("select [IMG_IMAGEDATA] from dbo.D_DOC_CERTIFICATES where IMG_IMAGEID = " + id, connection);
                dr = command.ExecuteReader();
                dr.Read();
            }
            if (userType.ToString() == "1" || PatientDtls.Equals("yes"))
            {
                SqlCommand command = new SqlCommand("select [MFL_FILEDATA] from [dbo].[D_MED_FILES] where [MFL_MEDFILEID] = " + id, connection);
                dr = command.ExecuteReader();
                dr.Read();

            }

            if (userType.ToString() == "3" && PatientDtls.Equals("No"))
            {
                SqlCommand command = new SqlCommand("select [IMG_IMAGEDATA] from dbo.D_DOC_CERTIFICATES where IMG_IMAGEID = " + id, connection);
                dr = command.ExecuteReader();
                dr.Read();
            }
            


            context.Response.BinaryWrite((Byte[])dr[0]);
            connection.Close();
            context.Response.End();
        }

        catch (Exception ex)
        {
           //HttpContext.Current.Response.Redirect("login.aspx", true);
            
        }
        finally
        {
            connection.Close();
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}