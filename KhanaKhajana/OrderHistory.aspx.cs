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
    public partial class OrderHistory : System.Web.UI.Page
    {
        #region globalVariables
        OrderServices orderServices = new OrderServices();
        CommonFunctions commonFunction = new CommonFunctions();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Master.PageHeader = "Order History";
                DisplayOrderHistory();
            }
        }

        private void DisplayOrderHistory()
        {
            var list = orderServices.GetOrderByUserId(Convert.ToInt32(Session["UserId"]));
            if (list != null && list.Count != 0)
            {
                rptrOrder.DataSource = list;
                rptrOrder.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','No orders for you yet.')", true);
                rptrOrder.DataSource = list;
                rptrOrder.DataBind();
            }
        }

        //protected void gvOrder_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    gvOrder.PageIndex = e.NewPageIndex;
        //    gvOrder.DataBind();
        //}

        protected void gvlbView_Command(object sender, CommandEventArgs e)
        {
            Clear();
            lblorderDetailModelTitle.Text = "Order details for of Order Id:- " + e.CommandName.ToString();
            var list = orderServices.GetOrderItemsByOrderId(Convert.ToInt32(e.CommandName));
            int status = orderServices.GetOrderById(Convert.ToInt32(e.CommandName)).Status;
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "openModal('" + status.ToString() + "');", true);
            BindOrderDetailsRptr(list, status);
        }
        private void BindOrderDetailsRptr(List<ProductViewModel> list, int status)
        {
            double subTot = 0;
            if (list != null && list.Count != 0)
            {
                foreach (var p in list)
                {
                    p.DiscountedPrice = p.DiscountedPercentNull == 0 ? 0 : Convert.ToDouble(p.Price - (p.Price * p.DiscountedPercentNull) / 100);
                    p.TotalPrice = p.DiscountedPrice != 0 ? p.DiscountedPrice * p.Qty : p.Price * p.Qty;
                    subTot += p.TotalPrice;
                }
                rptrOrderDetails.DataSource = list;
                rptrOrderDetails.DataBind();
                lblorderDetailModelSubtotal.Text = "$ " + subTot.ToString();
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showOrderStatusBar('" + status.ToString() + "')", true);
            }
        }

        private void Clear()
        {
            lblorderDetailModelTitle.Text = "";
            lblorderDetailModelSubtotal.Text = "";
            rptrOrderDetails.DataSource = "";
            rptrOrderDetails.DataBind();
        }
    }
}