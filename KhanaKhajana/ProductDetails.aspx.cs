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
    public partial class ProductDetails : System.Web.UI.Page
    {
        #region globalVariables
        List<CategoryViewModel> catList = new List<CategoryViewModel>();
        ProductServices productServices = new ProductServices();
        CommonFunctions commonFunction = new CommonFunctions();
        CartItems cart = new CartItems();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ProductId"] != null && Convert.ToString(Session["ProductId"]) != "")
                {
                    this.Master.PageHeader = "Product Details";
                    DisplayDetails(Convert.ToInt32(Session["ProductId"]));
                    if(Convert.ToString(Session["Source"])=="Review")
                    {
                        tbRating.Text = Convert.ToString(Session["Ratings"]);
                        tbReview.Text = Convert.ToString(Session["Review"]);
                    }
                }
                else
                {
                    Response.Redirect("~/Menu.aspx");
                }
            }
        }

        private void DisplayDetails(int p)
        {
            ProductViewModel product = new ProductViewModel();
            double overAllRating;
            int fiveStars = 0, fourStars = 0, threeStars = 0, twoStars = 0, oneStars = 0, ratingSum = 0;

            product = productServices.GetProductWithReviewsById(p);
            imgProduct.ImageUrl = product.Image;
            lblProductName.Text = product.ProductName;
            lblPrice.Text = product.DiscountedPercent == 0 ? "$ " + product.Price.ToString() : "$ " + product.DiscountedPrice.ToString();
            lbloldPrice.Text = product.DiscountedPercent != 0 ? "$ " + product.Price.ToString() : "";
            lblDiscountPercent.Text = product.DiscountedPercent != 0 ? "(" + product.DiscountedPercent + " % off)" : "";
            lblCategory.Text = product.CategoryName;
            lblProductIngridents.Text = product.ingredients;

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

        protected void lbAddToCart_Click(object sender, EventArgs e)
        {
            string response = "";
            response = cart.AddItemInCart(Convert.ToInt32(Session["ProductId"]));
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

        protected void btnSaveReview_Click(object sender, EventArgs e)
        {
            string response = "";
            if (Convert.ToString(Session["UserId"]) == "" && Session["UserId"] == null)
            {
                Session["Source"] = "Review";
                Session["Ratings"] = tbRating.Text;
                Session["Review"] = tbReview.Text;
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "alert('Login first.');window.location ='Login.aspx'", true);
            }
            else
            {
                Review review = new Review();
                review.ProductId = Convert.ToInt32(Session["ProductId"]);
                review.UserId = Convert.ToInt32(Session["UserId"]);
                review.Star = Convert.ToInt32(tbRating.Text);
                review.Review1 = tbReview.Text;
                review.Date = DateTime.Now;

                response = productServices.AddReview(review);
                if (response == "Success")
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Review is added.')", true);
                    Clear();
                    DisplayDetails(Convert.ToInt32(Session["ProductId"]));
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                }
            }
        }

        private void Clear()
        {
            tbRating.Text = "";
            tbReview.Text = "";
        }
    }
}