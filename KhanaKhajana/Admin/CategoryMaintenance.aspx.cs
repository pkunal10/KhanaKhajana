using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanaKhajana.Models;
using System.Data.Entity.Migrations;
using KhanaKhajana.Services;

namespace KhanaKhajana.Admin
{
    public partial class CategoryMaintenance : System.Web.UI.Page
    {
        #region globalVariables
        Category category = new Category();
        CategoryServices categoryServices = new CategoryServices();
        CommonFunctions commonFunction = new CommonFunctions();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Master.PageHeader = "Category Maintenance";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "hideAlert()", true);
            }


            BindCategoriesGv();
        }

        private void BindCategoriesGv()
        {
            gvCategories.DataSource = categoryServices.GetAllCategories();
            gvCategories.DataBind();
        }

        protected void gvCategories_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCategories.PageIndex = e.NewPageIndex;
            gvCategories.DataBind();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string response = "";
            if (IsValid)
            {
                if (lblCategoryId.Text == "")
                {
                    if (!categoryServices.IsCategoryAlreadyExist(0,"Add",tbCategoryName.Text))
                    {
                        category.CategoryId = 0;
                        category.CategoryName = tbCategoryName.Text;
                        response = categoryServices.AddCategory(category);
                        if (response == "Success")
                        {
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Category is added.')", true);
                            Clear();
                            BindCategoriesGv();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Category name is already exists.')", true);
                        // alert
                    }
                }
                else
                {
                    if (!categoryServices.IsCategoryAlreadyExist(Convert.ToInt32(lblCategoryId.Text),"Update",tbCategoryName.Text))
                    {
                        category.CategoryId = Convert.ToInt32(lblCategoryId.Text);
                        category.CategoryName = tbCategoryName.Text;
                        response = categoryServices.UpdateCategory(category);
                        if (response == "Success")
                        {
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Category is updated.')", true);
                            Clear();
                            BindCategoriesGv();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                        }
                    }
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Category name is already exists.')", true);
                    }
                }
            }
        }
        private void Clear()
        {
            tbCategoryName.Text = "";
            lblCategoryId.Text = "";
        }

        protected void gvLbEdit_Command(object sender, CommandEventArgs e)
        {
            category = categoryServices.GetCategoryById(Convert.ToInt32(e.CommandName));
            if (category != null)
            {
                lblCategoryId.Text = category.CategoryId.ToString();
                tbCategoryName.Text = category.CategoryName;
            }
        }

        protected void gvLbDelete_Command(object sender, CommandEventArgs e)
        {
            string response = "";
            string dependency = "Products#ProductId#CategoryId#Categories Entry - Categories";
            string msg = commonFunction.MasterDependency(Convert.ToInt32(e.CommandName), dependency);
            if (msg == "")
            {
                response = categoryServices.DeleteCategory(Convert.ToInt32(e.CommandName));
                if (response == "Success")
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Category is deleted.')", true);
                    Clear();
                    BindCategoriesGv();
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
    }
}