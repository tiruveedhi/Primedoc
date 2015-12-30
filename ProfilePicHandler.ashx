<%@ WebHandler Language="C#" Class="ProfilePicHandler" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public class ProfilePicHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        string ConnectString = ConfigurationManager.AppSettings["conStr"];
        SqlConnection connection = new SqlConnection(ConnectString);
        SqlDataReader dr = null;
        int userType = Convert.ToInt32(context.Session["userTypeId"].ToString());
        try
        {
            connection.Open();
            string id = context.Request.QueryString["id"];

            if(context.Session["ProfilePic"].ToString().Equals("profile"))
            {
                SqlCommand command = new SqlCommand("select IMG_IMAGE from dbo.D_IMAGES where IMG_IMAGEID = " + id, connection);
                dr = command.ExecuteReader();
                dr.Read();
            }
            context.Response.BinaryWrite((Byte[])dr[0]);
            connection.Close();
            context.Response.End();
        }                

        catch (Exception ex)
        { }
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