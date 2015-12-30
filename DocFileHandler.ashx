<%@ WebHandler Language="C#" Class="DocFileHandler" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;

public class DocFileHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        string id = context.Request.QueryString["ID"].ToString();
        string ConnectString = ConfigurationManager.AppSettings["conStr"];
        SqlConnection objConn = new SqlConnection(ConnectString);
        objConn.Open();
        string sTSQL = "select SOF_IMAGENAME,SOF_CONTENTTYPE,SOF_IMAGEDATA,SOF_CONTENT_LENGTH from dbo.D_SecondOpinion_Files where SOF_IMAGEID =@ID";
        System.Data.SqlClient.SqlCommand objCmd = new System.Data.SqlClient.SqlCommand(sTSQL, objConn);
        objCmd.CommandType = System.Data.CommandType.Text;
        objCmd.Parameters.AddWithValue("@ID", id);
        SqlDataAdapter ada = new SqlDataAdapter(objCmd);
        System.Data.DataTable file = new System.Data.DataTable();
        ada.Fill(file);
        objConn.Close();
        objCmd.Dispose();
        if (file.Rows.Count > 0)
        {
            System.Data.DataRow row = file.Rows[0];
            Byte[] data = (Byte[])row["SOF_IMAGEDATA"];

            context.Response.Clear(); 
            context.Response.Buffer = true;
            context.Response.Charset = "";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.ContentType = row["SOF_CONTENTTYPE"].ToString();
            context.Response.AddHeader("content-disposition", "inline;filename="
            + row["SOF_IMAGENAME"].ToString());
            context.Response.BinaryWrite(data);
            context.Response.Flush();
            context.Response.End();
        }  
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}