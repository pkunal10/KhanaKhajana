using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Data.Entity.Migrations;
using KhanaKhajana.Models;

namespace KhanaKhajana.Services
{
    public class CategoryServices
    {
        KhanaKhajanaEntities db = new KhanaKhajanaEntities();

        public string AddCategory(Category model)
        {
            try
            {
                db.Categories.Add(model);
                db.SaveChanges();
                return "Success";
            }            
            catch(Exception e)
            {
                return e.Message;
            }
        }
        public string UpdateCategory(Category model)
        {
            try
            {
                db.Categories.AddOrUpdate(model);
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public List<Category> GetAllCategories()
        {
            var list = from cat in db.Categories
                       orderby cat.CategoryName
                       select cat;

            return list.ToList();
        }
        public Category GetCategoryById(int id)
        {
            //Category category = new Category();
            //var category = from cat in db.Categories
            //           where cat.CategoryId == id
            //           select cat;

            var category = db.Categories.Where(x => x.CategoryId == id).FirstOrDefault();

            return category;
        }

        public string DeleteCategory(int id)
        {
            try
            {
                db.Categories.Remove(db.Categories.Where(x => x.CategoryId == id).FirstOrDefault());
                db.SaveChanges();
                return "Success";
            }
            catch(Exception e)
            {
                return e.Message;
            }
            
        }
        public bool IsCategoryAlreadyExist(int id,string operation,string categoryName)
        {
            if(operation=="Add")
            {
                if(db.Categories.Where(x => x.CategoryName == categoryName).FirstOrDefault()!=null)
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
                if(db.Categories.Where(x => x.CategoryName == categoryName&&x.CategoryId!=id).FirstOrDefault()!=null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }            
        }
        public List<CategoryViewModel> GetAllCategoriesWithNoOfProducts()
        {
            var list = (from cat in db.Categories
                       orderby cat.CategoryName
                       select new CategoryViewModel()
                       {
                           CategoryId = cat.CategoryId,
                           CategoryName = cat.CategoryName,
                           NoOfProducts = db.Products.Where(x => x.CategoryId == cat.CategoryId).Count()
                       }).ToList();
            return list;
        }
    }
}