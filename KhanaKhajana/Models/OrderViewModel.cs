using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using KhanaKhajana.Models;
using KhanaKhajana.Services;

namespace KhanaKhajana.Models
{
    public class OrderViewModel
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
        public System.DateTime OrderDate { get; set; }
        public string AddressLine1 { get; set; }
        public string City { get; set; }
        public string Province { get; set; }
        public string ZipCode { get; set; }
        public string MobileNo { get; set; }
        public int Status { get; set; }
        public List<OrderItem> OrderItems { get; set; }
        public Order order { get; set; }
    }
}