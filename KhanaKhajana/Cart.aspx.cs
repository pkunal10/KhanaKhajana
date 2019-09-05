using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanaKhajana.Models;
using KhanaKhajana.Services;
using System.Net.Mail;
using System.Text;
using System.Threading;

namespace KhanaKhajana
{
    public partial class Cart : System.Web.UI.Page
    {
        #region globalVariables
        ProductServices productServices = new ProductServices();
        CommonFunctions commonFunction = new CommonFunctions();
        User user = new User();
        UserServices userServices = new UserServices();
        CartItems cart = new CartItems();
        OrderServices orderServices = new OrderServices();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Master.PageHeader = "Cart";
                DisplayCart();
                if (Session["Source"] != null)
                {
                    if (Convert.ToString(Session["Source"]) == "Cart")
                    {
                        DisplayUserDestails();
                    }
                }
            }
        }

        private void DisplayCart()
        {
            var list = cart.GetCart();
            if (list.Count == 0)
            {
                btnCheckout.Enabled = false;
                rptrCart.DataSource = "";
                rptrCart.DataBind();
                pnlCheckout.Visible = false;
            }
            else
            {
                rptrCart.DataSource = list;
                rptrCart.DataBind();
                CalculateFinalTotal();
            }
        }

        private void CalculateFinalTotal()
        {
            double subtotal = 0;
            for (int j = 0; j < rptrCart.Items.Count; j++)
            {
                Label lblTotal = rptrCart.Items[j].FindControl("rptrlblTotalPrice") as Label;
                subtotal += Convert.ToDouble(lblTotal.Text.ToString().Split(new[] { " " }, StringSplitOptions.None)[1]);
            }
            lblSubtotal.Text = "$ " + subtotal.ToString();
        }

        protected void rptrlbDelete_Command(object sender, CommandEventArgs e)
        {
            cart.RemoveItemFromCart(Convert.ToInt32(e.CommandName));
            DisplayCart();
            this.Master.NoOfProducts = cart.Count.ToString();
        }

        protected void rptrtbQuantity_TextChanged(object sender, EventArgs e)
        {
            TextBox tb1 = ((TextBox)(sender));
            RepeaterItem rp1 = ((RepeaterItem)(tb1.NamingContainer));
            TextBox qnt = (TextBox)rp1.FindControl("rptrtbQuantity");
            Label price = (Label)rp1.FindControl("rptrlblPrice");
            Label total_lbl = (Label)rp1.FindControl("rptrlblTotalPrice");

            if (Convert.ToInt32(qnt.Text) <= 0)
            {
                total_lbl.Text = "";
                qnt.Text = "1";
                total_lbl.Text = price.Text.ToString();

            }
            else
            {
                double tot_price = Convert.ToInt32(qnt.Text) * Convert.ToDouble(price.Text.ToString().Split(new[] { " " }, StringSplitOptions.None)[1]);
                total_lbl.Text = "$ " + tot_price.ToString();
                CalculateFinalTotal();
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Convert.ToString(Session["UserId"]) == "")
            {
                Session["Source"] = "Cart";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "alert('Login first.');window.location ='Login.aspx'", true);
            }
            else
            {
                DisplayUserDestails();
            }
        }

        private void DisplayUserDestails()
        {
            pnlCheckout.Visible = true;
            pnlCheckout.Focus();
            user = userServices.GetUserById(Convert.ToInt32(Session["UserId"]));
            tbAddressLine1.Text = user.AddressLine1;
            tbCity.Text = user.City;
            tbProvince.Text = user.Province;
            tbZipCode.Text = user.ZipCode;
            tbMobileNo.Text = user.MobileNo;
        }

        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            if (tbMobileNo.Text.Length != 10)
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Invalid Mobile No.')", true);
            }
            else
            {
                Order order = new Order();
                OrderViewModel model = new OrderViewModel();
                List<OrderItem> oiList = new List<OrderItem>();

                order.UserId = Convert.ToInt32(Session["UserId"]);
                order.OrderDate = DateTime.Now;
                order.AddressLine1 = tbAddressLine1.Text;
                order.City = tbCity.Text;
                order.Province = tbProvince.Text;
                order.ZipCode = tbZipCode.Text;
                order.MobileNo = tbMobileNo.Text;
                order.Instruction = tbInstruction.Text;
                order.Status = 1;

                for (int i = 0; i < rptrCart.Items.Count; i++)
                {
                    OrderItem orderItem = new OrderItem();
                    Label lblProductid = rptrCart.Items[i].FindControl("rptrlblProductId") as Label;
                    TextBox tbQty = rptrCart.Items[i].FindControl("rptrtbQuantity") as TextBox;
                    ProductViewModel product = new ProductViewModel();
                    product = productServices.GetProductsByIdForCart(Convert.ToInt32(lblProductid.Text));

                    orderItem.ProductId = Convert.ToInt32(lblProductid.Text);
                    orderItem.Qty = Convert.ToInt32(tbQty.Text);
                    orderItem.Price = product.Price;
                    orderItem.DiscountPercent = product.DiscountedPercent;
                    orderItem.FinalPrice = product.DiscountedPrice;

                    oiList.Add(orderItem);
                }
                model.order = order;
                model.OrderItems = oiList;
                SaveOrder(model);
            }
        }

        private void SaveOrder(OrderViewModel model)
        {
            string response = "";
            response = orderServices.AddOrder(model);
            if (response == "Success")
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Order is booked.')", true);
                EmptyCart();
                // GenerateMsgForEmail(model);

                Thread email = new Thread(delegate()
                {
                    SendEmail(model);
                });
                email.IsBackground = true;
                email.Start();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
            }
        }

        public string GenerateMsgForEmail(OrderViewModel model)
        {
            string msg = "";
            double? subTot = 0;
            msg += "<table width='100%' cellspacing='2' cellpadding='4' border='0' align='center' bgcolor='#ff6600'><thead><tr><th>Product Name</th><th>Qty.</th><th>Price</th><th>Total</th></tr></thead><tbody>";
            foreach (var pr in model.OrderItems)
            {
                ProductViewModel Pmodel = new ProductViewModel();
                Pmodel = productServices.GetProductsByIdForCart(pr.ProductId);
                double? price = pr.DiscountPercent == 0 ? pr.Price : pr.FinalPrice;
                //double? tot = pr.DiscountPercent == 0 ? (pr.Price * pr.Qty) : (pr.FinalPrice * pr.Qty);                
                double? tot = price * pr.Qty;
                subTot += tot;
                msg += "<tr bgcolor='#ffffff' align='center'>";
                msg += "<td>" + Pmodel.ProductName + "</td>";
                msg += "<td>" + pr.Qty + "</td>";
                msg += "<td>$ " + price.ToString() + "</td>";
                msg += "<td>$ " + tot + "</td></tr>";
            }
            msg += "<tr><td colspan='4' align='right' style='weight:900;'>Sub Total = $ " + subTot.ToString() + "</td></tr></tbody></table>";

            return msg;
        }

        private void EmptyCart()
        {
            cart.EmptyCart();
            DisplayCart();
            this.Master.NoOfProducts = "0";
            lblSubtotal.Text = "";
        }

        private void SendEmail(OrderViewModel model)
        {
            try
            {
                User user = new User();
                user = userServices.GetUserById(model.order.UserId);
                MailMessage mm = new MailMessage();
                mm.From = new MailAddress("khajana246@gmail.com", "Khana Khajana");
                mm.To.Add(user.EmailId);
                mm.Subject = "Order Details";
                mm.Body += "<br />Hello:  " + user.Fname + " " + user.Fname + "<br /><center><font style='font-size:12px;weight:550;'>Thank you for your booking from Khana Khajana. Your order has been received.</font>";
                mm.Body += "<br/ ><b>Order Details :-</b><br/>";
                mm.Body += GenerateMsgForEmail(model);
                mm.Body += "<br /><font style='font-size:12px;'>You Will Receive Your Order At Your Delivery Address With in 40 minutes.</font></center>";

                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                smtp.UseDefaultCredentials = true;
                smtp.Port = 587;
                smtp.Credentials = new System.Net.NetworkCredential("khajana246@gmail.com", "khanakhajana@123");


                smtp.Send(mm);
            }
            catch (Exception ex)
            {
                string Mail_msg = "Mail can't be sent because of server problem: ";
                // Mail_msg += ex.Message;
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + Mail_msg + "')", true);
                //Response.Write(Mail_msg);
                // Label11.Text = Mail_msg;
            }
        }
    }
}