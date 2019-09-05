using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using KhanaKhajana.Models;
using KhanaKhajana.Services;

namespace KhanaKhajana.Services
{
    public class UserServices
    {
        KhanaKhajanaEntities db = new KhanaKhajanaEntities();

        public string AddUser(User model)
        {
            try
            {
                db.Users.Add(model);
                db.SaveChanges();
                return "Success";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public bool IsEmailIdExists(string EmailId)
        {
            if (db.Users.Where(x => x.EmailId == EmailId).FirstOrDefault() == null)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        public string LogIn(string emailId, string password)
        {
            var user = db.Users.Where(x => x.EmailId == emailId && x.Password == password).FirstOrDefault();
            if (user != null)
            {
                return user.UserId.ToString();
            }
            else
            {
                if (emailId == "admin@gmail.com" && password == "admin")
                {
                    return "Admin";
                }
                else
                {
                    return "Invalid";
                }
            }
        }
        public User GetUserById(int id)
        {
            return db.Users.Where(x => x.UserId == id).FirstOrDefault();
        }
    }
}