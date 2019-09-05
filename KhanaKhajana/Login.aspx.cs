using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanaKhajana.Models;
using KhanaKhajana.Services;

namespace KhanaKhajana
{
    public partial class Login : System.Web.UI.Page
    {
        #region Global Variables

        User user = new User();
        UserServices userServices = new UserServices();

        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                this.Master.PageHeader = "Login";
                tbEmailId.Focus();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string response = "";
            response = userServices.LogIn(tbEmailId.Text, tbPassword.Text);
            if(response=="Invalid")
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Invalid emailid or password.')", true);
            }
            else if(response=="Admin")
            {
                Session["AdminUserId"] = "Admin";
                Response.Redirect("~/Admin/Dashboard.aspx");
            }
            else
            {
                Session["UserId"]=response;
                if (Session["Source"] != null)
                {
                    if (Convert.ToString(Session["Source"]) == "Cart")
                    {
                        Response.Redirect("~/Cart.aspx");
                    }
                    else if(Convert.ToString(Session["Source"]) == "Review")
                    {
                        Response.Redirect("~/ProductDetails.aspx");
                    }
                    
                }
                Response.Redirect("~/Home.aspx");             
            }
        }
    }
}