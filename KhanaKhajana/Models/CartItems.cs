using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using KhanaKhajana.Models;
using KhanaKhajana.Services;

namespace KhanaKhajana.Models
{
    public class CartItems
    {
        List<int> productIds = new List<int>();
        ProductServices productService = new ProductServices();
        public CartItems()
        {
            //if (HttpContext.Current.Session["ProductIds"] != null)
            //{
            //    productIds = (List<int>)HttpContext.Current.Session["ProductIds"];
            //}
        }
        public string AddItemInCart(int productId)
        {
            if ((List<int>)HttpContext.Current.Session["ProductIds"] != null)
            {
                productIds = (List<int>)HttpContext.Current.Session["ProductIds"];
            }

            if (productIds.Contains(productId))
            {
                return "Already";
            }
            else
            {
                productIds.Add(productId);
                HttpContext.Current.Session["ProductIds"] = productIds;
                return "Added.";
            }            
        }
        public void RemoveItemFromCart(int productId)
        {
            if ((List<int>)HttpContext.Current.Session["ProductIds"] != null)
            {
                productIds = (List<int>)HttpContext.Current.Session["ProductIds"];
            }
            productIds.Remove(productId);
            HttpContext.Current.Session["ProductIds"] = productIds;
        }
        public void EmptyCart()
        {
            if ((List<int>)HttpContext.Current.Session["ProductIds"] != null)
            {
                productIds = (List<int>)HttpContext.Current.Session["ProductIds"];
            }
            productIds.Clear();
            HttpContext.Current.Session["ProductIds"] = productIds;
        }
        public int Count
        {
            get
            {
                if ((List<int>)HttpContext.Current.Session["ProductIds"] != null)
                {
                    productIds = (List<int>)HttpContext.Current.Session["ProductIds"];
                }
                return productIds.Count;
            }
        }

        public List<ProductViewModel> GetCart()
        {
            List<ProductViewModel> cart = new List<ProductViewModel>();
            if ((List<int>)HttpContext.Current.Session["ProductIds"] != null)
            {
                productIds = (List<int>)HttpContext.Current.Session["ProductIds"];
                for(int i=0;i<productIds.Count;i++)
                {
                    cart.Add(productService.GetProductsByIdForCart(productIds[i]));
                }                
            }
            return cart;
        }
    }
}