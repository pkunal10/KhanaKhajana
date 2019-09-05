using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using KhanaKhajana.Models;

namespace KhanaKhajana.Services
{
    public class CommonFunctions
    {
        KhanaKhajanaEntities db = new KhanaKhajanaEntities();
        public string MasterDependency(long lvarSNo, string lvarDependency)
        {            

            string[] lvarSplit1 = null;
            string[] lvarSplit2 = null;

            Int16 i = default(Int16);

            lvarSplit1 = lvarDependency.Split('|');

            for (i = 0; i <= lvarSplit1.Length - 1; i++)
            {
                lvarSplit2 = lvarSplit1[i].Split('#');

                var count = db.Database.SqlQuery<int>("Select Count(*) as Count From " + lvarSplit2[0] + " Where " + lvarSplit2[2] + " = " + lvarSNo + "");

                foreach (var d in count)
                {
                    if (d > 0)
                    {
                        return "many data is dependent on this data";
                    }
                }
            }

            return "";
        }
        public CommonDetails GetCommonDetails()
        {
            CommonDetails ct = new CommonDetails();
            ct.NoOfUsers = db.Users.Count();
            ct.NoOfSales = db.Orders.Count();

            return ct;
        }
    }
}