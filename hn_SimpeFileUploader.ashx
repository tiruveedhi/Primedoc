<%@ WebHandler Language="C#" Class="hn_SimpeFileUploader" %>

using System;
using System.Web;
using System.IO;
using System.Drawing;
using System.Data.SqlClient;
using System.Configuration;
using DAC;

public class hn_SimpeFileUploader : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    DAC.BLL.clsGlobalBLL objGlobalBLL = new DAC.BLL.clsGlobalBLL();
    int val;

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        //string dirFullPath = HttpContext.Current.Server.MapPath("~/MediaUploader/");
        //string[] files;
        //int numFiles;
        //files = System.IO.Directory.GetFiles(dirFullPath);
        //numFiles = files.Length;
        //numFiles = numFiles + 1;

        string str_image = "";
        string UserName = Convert.ToString(HttpContext.Current.Session["userId"]);

        string userPicStatus = Convert.ToString(HttpContext.Current.Session["userPic"]);
        foreach (string s in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files[s];
            string fileName = file.FileName;
            string fileExtension = file.ContentType;
            byte[] imgarray = new byte[file.ContentLength];
            file.InputStream.Read(imgarray, 0, file.ContentLength);

            if (!string.IsNullOrEmpty(fileName))
            {
                try
                {
                    if (context.Session["pageName"] != null)
                        objGlobalBLL.PageName = context.Session["pageName"].ToString();
                    objGlobalBLL.UserId = Convert.ToInt32(context.Session["userId"].ToString());
                    objGlobalBLL.ImageName = fileName;
                    objGlobalBLL.ContentType = file.ContentType;
                    objGlobalBLL.ImageData = imgarray;
                    objGlobalBLL.UserTypeId = Convert.ToInt32(context.Session["userTypeId"].ToString());

                    if (userPicStatus.Equals(""))
                    {
                        if (objGlobalBLL.UserTypeId == 2)
                            val = objGlobalBLL.uploadCertificates(objGlobalBLL);
                        if (objGlobalBLL.UserTypeId == 1)
                            val = objGlobalBLL.uploadMedFiles(objGlobalBLL);
                    }
                    else
                    {

                        int val = objGlobalBLL.uploadImage(objGlobalBLL);
                    }
                }
                catch (Exception ex)
                {

                }
            }
        }
        context.Response.Write(str_image);
        if (userPicStatus != "")
            HttpContext.Current.Response.Redirect("~/uploadImage.aspx");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
    

