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
    public partial class Menu : System.Web.UI.Page
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
            if(!IsPostBack)
            {
                DisplayAllCategories();
                DisplayProducts(0);
                this.Master.PageHeader = "Menu";
            }
        }

        private void DisplayAllCategories()
        {
            int totalProducts = 0;
            catList = categoryServices.GetAllCategoriesWithNoOfProducts();
            foreach(var cat in catList)
            {
                totalProducts += cat.NoOfProducts;
            }
            CategoryViewModel model=new CategoryViewModel();
            model.CategoryId=0;
            model.CategoryName="All Products";
            model.NoOfProducts=totalProducts;
            catList.Insert(0, model);
            rptrCategories.DataSource = catList;
            rptrCategories.DataBind();
        }

        protected void lbRptrCategories_Command(object sender, CommandEventArgs e)
        {
            DisplayProducts(Convert.ToInt32(e.CommandName));
        }
        public void DisplayProducts(int catId)
        {
            if(catId==0)
            {
                var list = productServices.GetAllProducts();
                if (list.Count == 0)
                {
                    pnlNoProducts.Visible = true;
                }
                else
                {
                    lblSelectedCategory.Text = "All Products";
                    rptrProducts.DataSource = list;
                    rptrProducts.DataBind();
                }
            }
            else
            {
                var list = productServices.GetAllProductsByCategoryId(catId);
                if (list.Count == 0)
                {
                    pnlNoProducts.Visible = true;
                }
                else
                {
                    lblSelectedCategory.Text = list[0].CategoryName;
                    rptrProducts.DataSource = list;
                    rptrProducts.DataBind();
                }
            }            
        }

        protected void rpteLbAddtoCart_Command(object sender, CommandEventArgs e)
        {
            string response = "";
            response=cart.AddItemInCart(Convert.ToInt32(e.CommandName));
            if(response=="Already")
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