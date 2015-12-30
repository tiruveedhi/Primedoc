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
public partial class manageUser : System.Web.UI.Page
{
    DAC.BLL.clsadminBLL Obj_AdminBLL = new DAC.BLL.clsadminBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userName"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {

          Fill_Roles();
        }

    }
    DataTable dt_Roles = new DataTable();
    private void Fill_Roles()
    {

        dt_Roles = Obj_AdminBLL.Get_Roles_Patient();


        gv_Users.DataSource = dt_Roles;
        gv_Users.DataBind();
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        foreach (GridViewRow gre in gv_Users.Rows)
        {
            CheckBox check = (CheckBox)gre.FindControl("Chk_Select");
            string ID = "";
            if (check.Checked == true)
            {
                Label lbl_ID = (Label)gre.FindControl("lbl_id");

                int val = Obj_AdminBLL.UpdateAdminRoles(Convert.ToInt32(lbl_ID.Text), true);


            }
            else
            {

                Label lbl_ID = (Label)gre.FindControl("lbl_id");

                int val = Obj_AdminBLL.UpdateAdminRoles(Convert.ToInt32(lbl_ID.Text), false);

            }




        }
    }



    protected void gv_Users_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        

    }
    //protected void gv_Users_DataBound(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow gre in gv_Users.Rows)
    //    {
    //        dt_Roles = Obj_AdminBLL.Get_Roles_Patient();
    //        for (int i = 0; i < dt_Roles.Rows.Count; i++)
    //        {

    //            if (dt_Roles.Rows[i]["MRW_ISACTIVE"].ToString() == "True")
    //            {
    //                Label lbl_ID = (Label)gre.FindControl("lbl_id");
    //                ID = lbl_ID.Text.ToString();
    //                CheckBox check = (CheckBox)gre.FindControl("Chk_Select");

    //                check.Checked = true;


    //            }

    //            else
    //            {

    //             CheckBox check = (CheckBox)gre.FindControl("Chk_Select");

    //                    check.Checked = false;


    //                }
    //        }

    //            }
    //        }

        }

    

