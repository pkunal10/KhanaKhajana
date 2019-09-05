using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using KhanaKhajana.Models;
using System.Data.Entity.Migrations;

namespace KhanaKhajana.Services
{
    public class ProductServices
    {
        KhanaKhajanaEntities db = new KhanaKhajanaEntities();

        public bool IsProductAlreadyExists(int id, string operation, string productName)
        {
            if (operation == "Add")
            {
                if (db.Products.Where(x => x.ProductName == productName).FirstOrDefault() != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                if (db.Products.Where(x => x.ProductName == productName && x.ProductId != id).FirstOrDefault() != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }
        public string AddProduct(Product model)
        {
            try
            {
                db.Products.Add(model);
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public string UpdateProduct(Product model)
        {
            try
            {
                db.Products.AddOrUpdate(model);
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public Product GetProductById(int id)
        {
            return db.Products.Where(x => x.ProductId == id).FirstOrDefault();
        }
        public string DeleteProduct(int id)
        {
            try
            {
                db.Products.Remove(db.Products.Where(x => x.ProductId == id).FirstOrDefault());
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public List<ProductViewModel> GetAllProducts()
        {
            List<ProductViewModel> list = new List<ProductViewModel>();
            list = (from p in db.Products
                    join cat in db.Categories
                    on p.CategoryId equals cat.CategoryId
                    orderby p.ProductName
                    select new ProductViewModel()
                    {
                        ProductId = p.ProductId,
                        ProductName = p.ProductName,
                        CategoryName = cat.CategoryName,
                        CategoryId = p.CategoryId,
                        ingredients = p.Ingredients,
                        Price = p.Price,
                        Image = p.Image,
                        IsFeature = p.IsFeature,
                        DiscountedPrice = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                                          ? p.Price - ((p.Price * db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent) / 100) : 0,
                        DiscountedPercent = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                                          ? db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent : 0
                    }).ToList();
            return list;
        }
        public List<ProductViewModel> GetAllProductsByCategoryId(int categoryId)
        {
            List<ProductViewModel> list = new List<ProductViewModel>();
            list = (from p in db.Products
                    join cat in db.Categories
                    on p.CategoryId equals cat.CategoryId
                    where p.CategoryId == categoryId
                    orderby p.ProductName
                    select new ProductViewModel()
                    {
                        ProductId = p.ProductId,
                        ProductName = p.ProductName,
                        CategoryName = cat.CategoryName,
                        CategoryId = p.CategoryId,
                        ingredients = p.Ingredients,
                        Price = p.Price,
                        Image = p.Image,
                        IsFeature = p.IsFeature,
                        DiscountedPrice = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                                          ? p.Price - ((p.Price * db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent) / 100) : 0,
                        DiscountedPercent = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                                          ? db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent : 0
                    }).ToList();
            return list;
        }
        public ProductViewModel GetProductsByIdForCart(int id)
        {
            ProductViewModel product = new ProductViewModel();
            var p = db.Products.Where(x => x.ProductId == id).FirstOrDefault();
            product.ProductId = p.ProductId;
            product.ProductName = p.ProductName;
            product.CategoryId = p.CategoryId;
            product.ingredients = p.Ingredients;
            product.Price = p.Price;
            product.Image = p.Image;
            product.IsFeature = p.IsFeature;
            product.DiscountedPrice = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                              ? p.Price - ((p.Price * db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent) / 100) : 0;
            product.DiscountedPercent = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                              ? db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent : 0;

            return product;
        }
        public ProductViewModel GetProductWithReviewsById(int productId)
        {
            ProductViewModel product = new ProductViewModel();            
            var p = db.Products.Where(x => x.ProductId == productId).FirstOrDefault();
            var list = (from r in db.Reviews
                        join u in db.Users
                        on r.UserId equals u.UserId
                        where r.ProductId == productId
                        orderby r.Date descending
                        select new ReviewModal()
                        {
                            ReviewId = r.ReviewId,
                            Review1 = r.Review1,
                            Star = r.Star,
                            Date = r.Date,
                            UserImage = u.Image,
                            UserName = u.Fname + " " + u.Lname,                            
                        }).ToList();


            product.ProductId = p.ProductId;
            product.ProductName = p.ProductName;
            product.CategoryId = p.CategoryId;
            product.CategoryName = db.Categories.Where(x => x.CategoryId == p.CategoryId).FirstOrDefault().CategoryName;
            product.ingredients = p.Ingredients;
            product.Price = p.Price;
            product.Image = p.Image;            
            product.DiscountedPrice = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                              ? p.Price - ((p.Price * db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent) / 100) : 0;
            product.DiscountedPercent = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                              ? db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent : 0;
            product.Reviews = list;

            return product;
        }
        public List<ProductViewModel> GetAllFeatureProducts()
        {
            List<ProductViewModel> list = new List<ProductViewModel>();
            list = (from p in db.Products
                    join cat in db.Categories
                    on p.CategoryId equals cat.CategoryId
                    where p.IsFeature == 1                   
                    orderby p.ProductName                     
                    select new ProductViewModel()
                    {
                        ProductId = p.ProductId,
                        ProductName = p.ProductName,
                        CategoryName = cat.CategoryName,
                        CategoryId = p.CategoryId,
                        ingredients = p.Ingredients,
                        Price = p.Price,
                        Image = p.Image,
                        IsFeature = p.IsFeature,
                        DiscountedPrice = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                                          ? p.Price - ((p.Price * db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent) / 100) : 0,
                        DiscountedPercent = db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault() != null
                                          ? db.Discounts.Where(x => x.ProductId == p.ProductId).FirstOrDefault().DiscountPercent : 0
                    }).Take(8).ToList();
            return list;
        }
        public Discount GetDiscountByProductId(int productId)
        {
            return db.Discounts.Where(x => x.ProductId == productId).FirstOrDefault();
        }
        public string AddDiscount(Discount model)
        {
            try
            {
                db.Discounts.Add(model);
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public string UpdateDiscount(Discount model)
        {
            try
            {
                db.Discounts.AddOrUpdate(model);
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public string DeleteDisocunt(int id)
        {
            try
            {
                db.Discounts.Remove(db.Discounts.Where(x => x.DiscountId == id).FirstOrDefault());
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public string AddReview(Review model)
        {
            try
            {
                db.Reviews.Add(model);
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
    }
}