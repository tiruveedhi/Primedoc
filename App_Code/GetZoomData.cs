using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Net;
using System.Text;
using System.Collections;

/// <summary>
/// Summary description for GetZoomData
/// </summary>
public class GetZoomData
{
    byte[] responsebytes;

    public byte[] getZoomData(string URL, Hashtable htKeys)
    {
        using (WebClient client = new WebClient())
        {
            System.Collections.Specialized.NameValueCollection reqparm = new System.Collections.Specialized.NameValueCollection();
            reqparm.Add("api_key", "2g9n85UTS9qpjlbOO7o6bw");
            reqparm.Add("api_secret", "aEmn7s5CvGWWhh93cBThZ9ZhS5bJsnOvkR9M");
            reqparm.Add("data_type", "XML");
            if (htKeys.Count > 0)
            {
                foreach (DictionaryEntry entry in htKeys)
                {
                    reqparm.Add(entry.Key.ToString(), entry.Value.ToString());
                }
            }
            responsebytes = client.UploadValues(URL, "POST", reqparm);

            //responsebody = Encoding.UTF8.GetString(responsebytes);
            //responsebody = responsebody.Replace("\"", "");
            //responsebody = responsebody.Replace("{", "");
            //responsebody = responsebody.Replace("}", "");
            //string[] words = responsebody.Split(',');
        }
        return responsebytes;
    }
}