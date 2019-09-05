using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanaKhajana.Models;
using KhanaKhajana.Services;

namespace KhanaKhajana.Admin
{
    public partial class ProductMaintenance : System.Web.UI.Page
    {
        #region Global Variables
        CategoryServices categoryServices = new CategoryServices();
        ProductServices productServices = new ProductServices();
        CommonFunctions commonFunction = new CommonFunctions();
        Product product = new Product();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Master.PageHeader = "Product Maintenance";
                PopulateCategoryDropdown();
                BindProductsGv();
            }
        }

        private void PopulateCategoryDropdown()
        {
            ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", "0"));
            ddlCategoryShowProduct.Items.Insert(0, new ListItem("-- All Category --", "0"));
            List<Category> listCategory = new List<Category>();
            listCategory = categoryServices.GetAllCategories();
            if (listCategory != null)
            {
                for (int i = 0; i < listCategory.Count; i++)
                {
                    ddlCategory.Items.Insert(i + 1, new ListItem(listCategory[i].CategoryName, listCategory[i].CategoryId.ToString()));
                    ddlCategoryShowProduct.Items.Insert(i + 1, new ListItem(listCategory[i].CategoryName, listCategory[i].CategoryId.ToString()));
                }
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string response = "";
            if (lblProductId.Text == "")
            {
                if (!productServices.IsProductAlreadyExists(0, "Add", tbProductName.Text))
                {
                    string ext = System.IO.Path.GetExtension(fileProductImage.FileName);
                    if (ext.ToLower() == ".jpg" || ext.ToLower() == ".png" || ext.ToLower() == ".jpeg" || ext.ToLower() == ".gif")
                    {
                        fileProductImage.SaveAs(Server.MapPath("~/Admin/ProductImages/" + fileProductImage.FileName));
                        product.ProductName = tbProductName.Text;
                        product.CategoryId = Convert.ToInt32(ddlCategory.SelectedValue);
                        product.Price = Convert.ToDouble(tbPrice.Text);
                        product.IsFeature = Convert.ToByte(chkIsFeature.Checked);
                        product.Ingredients = tbProductIngridents.Text;
                        product.Image = "~/Admin/ProductImages/" + fileProductImage.FileName;

                        response = productServices.AddProduct(product);
                        if (response == "Success")
                        {
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Product is added.')", true);
                            Clear();
                            BindProductsGv();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Please select image only.')", true);
                    }


                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Product name is already exists.')", true);
                }
            }
            else
            {
                if (!productServices.IsProductAlreadyExists(Convert.ToInt32(lblProductId.Text), "Update", tbProductName.Text))
                {
                    if (fileProductImage.HasFile)
                    {
                        string ext = System.IO.Path.GetExtension(fileProductImage.FileName);
                        if (ext.ToLower() == ".jpg" || ext.ToLower() == ".png" || ext.ToLower() == ".jpeg" || ext.ToLower() == ".gif")
                        {
                            fileProductImage.SaveAs(Server.MapPath("~/Admin/ProductImages/" + fileProductImage.FileName));
                            Product oldProduct = new Product();
                            oldProduct = productServices.GetProductById(Convert.ToInt32(lblProductId.Text));
                            oldProduct.ProductName = tbProductName.Text;
                            oldProduct.CategoryId = Convert.ToInt32(ddlCategory.SelectedValue);
                            oldProduct.Price = Convert.ToDouble(tbPrice.Text);
                            oldProduct.IsFeature = Convert.ToByte(chkIsFeature.Checked);
                            oldProduct.Ingredients = tbProductIngridents.Text;
                            oldProduct.Image = "~/Admin/ProductImages/" + fileProductImage.FileName;

                            response = productServices.UpdateProduct(oldProduct);
                            if (response == "Success")
                            {
                                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Product is updated.')", true);
                                Clear();
                                BindProductsGv();
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Please select image only.')", true);
                        }
                    }
                    else
                    {
                        Product oldProduct = new Product();
                        oldProduct = productServices.GetProductById(Convert.ToInt32(lblProductId.Text));
                        oldProduct.ProductName = tbProductName.Text;
                        oldProduct.CategoryId = Convert.ToInt32(ddlCategory.SelectedValue);
                        oldProduct.Price = Convert.ToDouble(tbPrice.Text);
                        oldProduct.IsFeature = Convert.ToByte(chkIsFeature.Checked);
                        oldProduct.Ingredients = tbProductIngridents.Text;

                        response = productServices.UpdateProduct(oldProduct);
                        if (response == "Success")
                        {
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Product is updated.')", true);
                            Clear();
                            BindProductsGv();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Product name is already exists.')", true);
                }
            }
        }

        private void BindProductsGv()
        {
            gvProducts.DataSource = productServices.GetAllProducts();
            gvProducts.DataBind();
        }
        protected void gvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProducts.PageIndex = e.NewPageIndex;
            gvProducts.DataBind();
        }
        private void Clear()
        {
            tbProductName.Text = "";
            lblProductId.Text = "";
            ddlCategory.SelectedValue = "0";
            tbPrice.Text = "";
            tbProductIngridents.Text = "";
            chkIsFeature.Checked = false;
            lblDiscountModalDiscountedPrice.Text = "";
            lblDiscountModalOriginalPrice.Text = "";
            lblDiscountModalTitle.Text = "";
            tbDisocountModalDiscountPer.Text = "";
        }

        protected void gvLbEdit_Command(object sender, CommandEventArgs e)
        {
            product = productServices.GetProductById(Convert.ToInt32(e.CommandName));
            if (product != null)
            {
                lblProductId.Text = product.ProductId.ToString();
                tbProductName.Text = product.ProductName;
                tbProductIngridents.Text = product.Ingredients;
                ddlCategory.SelectedValue = product.CategoryId.ToString();
                tbPrice.Text = product.Price.ToString();
                chkIsFeature.Checked = Convert.ToBoolean(product.IsFeature);
            }
        }

        protected void gvLbDelete_Command(object sender, CommandEventArgs e)
        {
            string response = "";
            string dependency = "Orderitems#OrderitemId#ProductId#Products Entry - Products|Discount#DiscountId#ProductId#Products Entry - Products";
            string msg = commonFunction.MasterDependency(Convert.ToInt32(e.CommandName), dependency);
            if (msg == "")
            {
                response = productServices.DeleteProduct(Convert.ToInt32(e.CommandName));
                if (response == "Success")
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Product is deleted.')", true);
                    Clear();
                    BindProductsGv();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + msg + "')", true);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            if (ddlCategoryShowProduct.SelectedValue == "0")
            {
                BindProductsGv();
            }
            else
            {
                gvProducts.DataSource = productServices.GetAllProductsByCategoryId(Convert.ToInt32(ddlCategoryShowProduct.SelectedValue));
                gvProducts.DataBind();
            }
        }

        protected void gvLbDiscount_Command(object sender, CommandEventArgs e)
        {
            Clear();
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "openModal();", true);
            var discount = productServices.GetDiscountByProductId(Convert.ToInt32(e.CommandName));
            product = productServices.GetProductById(Convert.ToInt32(e.CommandName));
            lblDiscountModalTitle.Text = "Discount For " + product.ProductName;
            lblDiscountModalOriginalPrice.Text = "Original Price :- $ " + product.Price;
            tbPriceforUse.Text = product.Price.ToString();
            lblDiscountModalProductId.Text = product.ProductId.ToString();
            if (discount != null)
            {                
                tbDisocountModalDiscountPer.Text = discount.DiscountPercent.ToString();
                lblDiscountModalDiscountId.Text = discount.DiscountId.ToString();
                btnDiscountModalDelete.Enabled = true;
            }
        }

        protected void btnDiscountModalSave_Click(object sender, EventArgs e)
        {
            string response = "";
            Discount discount = new Discount();
            discount.DiscountId = lblDiscountModalDiscountId.Text.ToString() != "" ? Convert.ToInt32(lblDiscountModalDiscountId.Text) : 0;
            discount.ProductId = Convert.ToInt32(lblDiscountModalProductId.Text);
            discount.DiscountPercent = Convert.ToDouble(tbDisocountModalDiscountPer.Text);
            if(discount.DiscountId==0)
            {
                response = productServices.AddDiscount(discount);
                if (response == "Success")
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Discount is added.')", true);
                    Clear();                    
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                }
            }
            else
            {
                response = productServices.UpdateDiscount(discount);
                if (response == "Success")
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Discount is updated.')", true);
                    Clear();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                }
            }
        }

        protected void btnDiscountModalDelete_Click(object sender, EventArgs e)
        {
            string response = "";
            response = productServices.DeleteDisocunt(Convert.ToInt32(lblDiscountModalDiscountId.Text));
            if (response == "Success")
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Discount is removed.')", true);
                Clear();
                BindProductsGv();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
            }
        }

        protected void GVLbReiew_Command(object sender, CommandEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "openReviewModal();", true);
            ProductViewModel product = new ProductViewModel();
            double overAllRating;
            int fiveStars = 0, fourStars = 0, threeStars = 0, twoStars = 0, oneStars = 0, ratingSum = 0;

            product = productServices.GetProductWithReviewsById(Convert.ToInt32(e.CommandName));
            lblReviewMOdalTitle.Text = "Reviews For " + product.ProductName;
            if (product.Reviews != null && product.Reviews.Count != 0)
            {
                foreach (var li in product.Reviews)
                {
                    ratingSum += li.Star;
                    if (li.Star == 5)
                    {
                        fiveStars += 1;
                    }
                    else if (li.Star == 4)
                    {
                        fourStars += 1;
                    }
                    else if (li.Star == 3)
                    {
                        threeStars += 1;
                    }
                    else if (li.Star == 2)
                    {
                        twoStars += 1;
                    }
                    else
                    {
                        oneStars += 1;
                    }
                }
                overAllRating = Math.Round((Convert.ToDouble(ratingSum) / Convert.ToDouble(product.Reviews.Count)), 1);
                lblOverAllRating.Text = overAllRating.ToString();
                lblNoOfReviews.Text = product.Reviews.Count.ToString();
                lblNoOfReviews2.Text = product.Reviews.Count.ToString();
                lblNoOf1Star.Text = oneStars.ToString();
                lblNoOf2Star.Text = twoStars.ToString();
                lblNoOf3Star.Text = threeStars.ToString();
                lblNoOf4Star.Text = fourStars.ToString();
                lblNoOf5Star.Text = fiveStars.ToString();

                rptrReview.DataSource = product.Reviews;
                rptrReview.DataBind();
            }
            else
            {
                lblOverAllRating.Text = "0.0";
                lblNoOfReviews.Text = "0";
                lblNoOfReviews2.Text = "0";
                lblNoOf1Star.Text = "0";
                lblNoOf2Star.Text = "0";
                lblNoOf3Star.Text = "0";
                lblNoOf4Star.Text = "0";
                lblNoOf5Star.Text = "0";

                rptrReview.DataSource = "";
                rptrReview.DataBind();
            }
        }
    }
}