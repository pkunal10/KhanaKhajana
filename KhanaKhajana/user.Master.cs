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
    public partial class main : System.Web.UI.MasterPage
    {
        #region globalVariables
        CartItems cart = new CartItems();
        #endregion
        public string PageHeader
        {
            get
            {
                return lblPageHeader.Text;
            }
            set
            {
                lblPageHeader.Text = value;
            }
        }
        public string NoOfProducts
        {
            set
            {
                lblNoofProducts.Text = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            lblNoofProducts.Text = cart.Count.ToString();
            if (!IsPostBack)
            {
                if (Convert.ToString(Session["UserId"]) != "")
                {
                    //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showLink('OH')", true);
                    lbLogin.Visible = false;
                    lbOrderHistory.Visible = true;
                    lbLogout.Visible = true;
                }
                if (PageHeader == "Order History")
                {
                    if (Convert.ToString(Session["UserId"]) == "")
                    {
                        Response.Redirect("~/Login.aspx");
                    }
                }
            }
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Home.aspx");
        }
    }
}