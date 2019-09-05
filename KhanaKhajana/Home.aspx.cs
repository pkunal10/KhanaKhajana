using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Text;
using KhanaKhajana.Models;
using KhanaKhajana.Services;

namespace KhanaKhajana
{
    public partial class Home : System.Web.UI.Page
    {
        #region globalVariables
        List<CategoryViewModel> catList = new List<CategoryViewModel>();
        CategoryServices categoryServices = new CategoryServices();
        ProductServices productServices = new ProductServices();
        CommonFunctions commonFunction = new CommonFunctions();
        CartItems cart = new CartItems();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Master.PageHeader = "Home";
                DisplayProducts();
            }
        }

        private void DisplayProducts()
        {
            var list = productServices.GetAllFeatureProducts();
            if (list == null || list.Count == 0)
            {
                rptrProducts.DataSource = "";
                rptrProducts.DataBind();
                pnlNoFeatureProducts.Visible = true;
            }
            else
            {
                rptrProducts.DataSource = list;
                rptrProducts.DataBind();
            }
        }

        protected void rpteLbAddtoCart_Command(object sender, CommandEventArgs e)
        {
            string response = "";
            response = cart.AddItemInCart(Convert.ToInt32(e.CommandName));
            if (response == "Already")
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Product is already added.')", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Product is added.')", true);
                this.Master.NoOfProducts = cart.Count.ToString();
            }
        }

        protected void rptrlbView_Command(object sender, CommandEventArgs e)
        {
            Session["ProductId"] = e.CommandName.ToString();
            Response.Redirect("~/ProductDetails.aspx");
        }
    }
}