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
    public partial class ViewOrders : System.Web.UI.Page
    {
        #region Global Variables
        OrderServices orderServices = new OrderServices();
        CommonFunctions commonFunction = new CommonFunctions();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Master.PageHeader = "View Order";
                tbDate.Text = DateTime.Now.ToShortDateString();
                BindOrderGv(DateTime.Now);
            }
        }

        private void BindOrderGv(DateTime date)
        {
            var list = orderServices.GetOrderByDate(date);
            if (list != null && list.Count != 0)
            {
                gvOrder.DataSource = list;
                gvOrder.DataBind();
                for (int i = 0; i < gvOrder.Rows.Count; i++)
                {
                    DropDownList dropdown = gvOrder.Rows[i].FindControl("gvddlStatus") as DropDownList;
                    dropdown.SelectedValue = list[i].Status.ToString();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','No order for this date.')", true);
                gvOrder.DataSource = list;
                gvOrder.DataBind();
            }
        }

        protected void gvOrder_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var list = orderServices.GetAllStatus();
                DropDownList dropdown = e.Row.FindControl("gvddlStatus") as DropDownList;
                dropdown.DataSource = list;
                dropdown.DataTextField = "StatusName";
                dropdown.DataValueField = "StatusId";
                dropdown.DataBind();
            }
        }

        //protected void gvOrder_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    gvOrder.PageIndex = e.NewPageIndex;
        //    gvOrder.DataBind();
        //}

        protected void btnShow_Click(object sender, EventArgs e)
        {
            BindOrderGv(Convert.ToDateTime(tbDate.Text));
        }

        protected void gvlbUpdateStatus_Command(object sender, CommandEventArgs e)
        {
            string response = "";
            for (int i = 0; i < gvOrder.Rows.Count; i++)
            {
                Label lblbOrderId = gvOrder.Rows[i].FindControl("gvlblOrderId") as Label;
                if (lblbOrderId.Text == e.CommandName.ToString())
                {
                    Order order = new Order();
                    DropDownList ddlStatus = gvOrder.Rows[i].FindControl("gvddlStatus") as DropDownList;
                    order = orderServices.GetOrderById(Convert.ToInt32(e.CommandName));
                    order.Status = Convert.ToInt32(ddlStatus.SelectedValue);
                    response = orderServices.UpdateOrder(order);
                    if (response == "Success")
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Order status updated.')", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                    }
                }
            }
        }

        protected void gvlbView_Command(object sender, CommandEventArgs e)
        {
            Clear();
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "openModal();", true);
            lblorderDetailModelTitle.Text = "Order details for of Order Id:- " + e.CommandName.ToString();
            var list = orderServices.GetOrderItemsByOrderId(Convert.ToInt32(e.CommandName));
            BindOrderDetailsRptr(list);
        }

        private void BindOrderDetailsRptr(List<ProductViewModel> list)
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