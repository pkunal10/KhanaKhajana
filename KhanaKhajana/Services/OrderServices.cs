using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Data.Entity.Migrations;
using KhanaKhajana.Models;

namespace KhanaKhajana.Services
{
    public class OrderServices
    {
        KhanaKhajanaEntities db = new KhanaKhajanaEntities();
        public string AddOrder(OrderViewModel model)
        {
            try
            {
                db.Orders.Add(model.order);
                db.SaveChanges();
                foreach (var oi in model.OrderItems)
                {
                    oi.OrderId = model.order.OrderId;
                    db.OrderItems.Add(oi);
                    db.SaveChanges();
                }
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public List<OrderViewModel> GetOrderByDate(DateTime date)
        {
            var list = (from o in db.Orders
                        join u in db.Users
                        on o.UserId equals u.UserId
                        where DbFunctions.TruncateTime(o.OrderDate) == date.Date
                        select new OrderViewModel()
                        {
                            OrderId = o.OrderId,
                            UserName = u.Fname + " " + u.Lname,
                            OrderDate = o.OrderDate,
                            AddressLine1 = o.AddressLine1,
                            City = o.City,
                            MobileNo = o.MobileNo,
                            Status = o.Status
                        }).ToList();

            return list;
        }
        public List<ProductViewModel> GetOrderItemsByOrderId(int orderId)
        {
            var list = (from oi in db.OrderItems
                        join p in db.Products
                        on oi.ProductId equals p.ProductId
                        where oi.OrderId == orderId
                        select new ProductViewModel()
                        {
                            ProductId = p.ProductId,
                            ProductName = p.ProductName,
                            Price = oi.Price,
                            DiscountedPercentNull = oi.DiscountPercent,
                            Qty = oi.Qty,
                            Image = p.Image
                        }).ToList();
            return list;
        }
        public List<Status> GetAllStatus()
        {
            var list = from s in db.Status select s;
            return list.ToList();
        }
        public string UpdateOrder(Order model)
        {
            try
            {
                db.Orders.AddOrUpdate(model);
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public Order GetOrderById(int orderId)
        {
            return db.Orders.Where(x => x.OrderId == orderId).FirstOrDefault();
        }
        public List<OrderViewModel> GetOrderByUserId(int usrId)
        {
            var list = (from o in db.Orders
                        join u in db.Users
                        on o.UserId equals u.UserId
                        where o.UserId == usrId
                        orderby o.OrderId descending
                        select new OrderViewModel()
                        {
                            OrderId = o.OrderId,
                            UserName = u.Fname + " " + u.Lname,
                            OrderDate = o.OrderDate,
                            AddressLine1 = o.AddressLine1,
                            ZipCode = o.ZipCode,
                            City = o.City,
                            MobileNo = o.MobileNo,
                            Status = o.Status
                        }).ToList();

            return list;
        }
        public List<ChartViewModal> GetWeeklyChart()
        {
            DateTime today = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            DateTime weekBefore = Convert.ToDateTime(DateTime.Now.AddDays(-7).ToShortDateString());
            var list = db.Orders.Where(x => DbFunctions.TruncateTime(x.OrderDate) > weekBefore && DbFunctions.TruncateTime(x.OrderDate) <= today).GroupBy(x => DbFunctions.TruncateTime(x.OrderDate)).Select(z => new ChartViewModal()
            {
                NoOfOrders = z.Count(),
                Date = z.Key
            }).ToList();

            return list;
        }
        public List<ChartViewModal> GetMonthlyChart()
        {
            DateTime today = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            DateTime weekBefore = Convert.ToDateTime(DateTime.Now.AddDays(-30).ToShortDateString());
            var list = db.Orders.Where(x => DbFunctions.TruncateTime(x.OrderDate) > weekBefore && DbFunctions.TruncateTime(x.OrderDate) <= today).GroupBy(x => DbFunctions.TruncateTime(x.OrderDate)).Select(z => new ChartViewModal()
            {
                NoOfOrders = z.Count(),
                Date = z.Key
            }).ToList();

            return list;
        }
    }
}