using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanaKhajana.Models
{
    public class ReviewModal
    {
        public int ReviewId { get; set; }
        public int ProductId { get; set; }
        public int UserId { get; set; }
        public int Star { get; set; }
        public string Review1 { get; set; }
        public System.DateTime Date { get; set; }
        public string UserName { get; set; }
        public string UserImage { get; set; }
    }
}