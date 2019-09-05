using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanaKhajana.Models
{
    public class ProductViewModel
    {
        public int ProductId { get; set; }
        public int CategoryId { get; set; }
        public string ProductName { get; set; }
        public string ingredients { get; set; }
        public string Image { get; set; }
        public double Price { get; set; }
        public byte IsFeature { get; set; }
        public string CategoryName { get; set; }
        public double DiscountedPrice { get; set; }
        public double DiscountedPercent { get; set; }
        public double? DiscountedPercentNull { get; set; }
        public int Qty { get; set; }
        public double TotalPrice { get; set; }
        public List<ReviewModal> Reviews { get; set; }
    }
}