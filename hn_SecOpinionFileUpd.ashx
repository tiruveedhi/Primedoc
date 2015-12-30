<%@ WebHandler Language="C#" Class="hn_SecOpinionFileUpd" %>

using System;
using System.Web;

public class hn_SecOpinionFileUpd : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    DAC.BLL.clsDocBLL objDocBLL = new DAC.BLL.clsDocBLL();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        
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
                    objDocBLL.DocId = Convert.ToInt32(context.Session["userId"].ToString());
                    objDocBLL.ConsultationId = Convert.ToInt32(context.Session["consId"].ToString());
                    objDocBLL.ImageName = fileName;
                    objDocBLL.ContentType = file.ContentType;
                    objDocBLL.ImageData = imgarray;
                    objDocBLL.ContentLength = file.ContentLength;
                    int val = objDocBLL.uploadSecondOpinionFiles(objDocBLL);
                }
                catch (Exception ex)
                {

                }
            }
        } 
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}