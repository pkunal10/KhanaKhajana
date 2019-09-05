using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;
using Microsoft.AspNet.FriendlyUrls.Resolvers;

namespace KhanaKhajana
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings,new MyUrlResolver());

            //routes.Ignore("{resource}.axd/{*pathInfo}");

            //routes.MapPageRoute("AdmCategoryMaintenance", "Admin/CategoryMaintenance", "~/Admin/CategoryMaintenance.aspx");
            //routes.MapPageRoute("UsrHome", "Home", "~/Home.aspx");
            //routes.MapPageRoute("UsrSignUp", "Signup", "~/Signup.aspx");
        }
        public class MyUrlResolver : WebFormsFriendlyUrlResolver
        {
            protected override bool TrySetMobileMasterPage(HttpContextBase ctx, System.Web.UI.Page page, string mobileSuffix)
            {
                return false;
            }
        }
    }
}
