using AspNet.Identity.MySQL;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using WebApplicationDim.Models;

namespace WebApplicationDim
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            createRoles();
        }

        private void createRoles()
        {
            ApplicationDbContext context = new ApplicationDbContext();
            var roleStore = new RoleStore<IdentityRole>(context);
            var roleManager = new RoleManager<IdentityRole>(roleStore);

            if (!roleManager.RoleExists("Teacher"))
            {
                var res = roleManager.Create(new IdentityRole("Teacher"));
                if (!res.Succeeded)
                    throw new Exception(res.Errors.FirstOrDefault());
            }
            if (!roleManager.RoleExists("Student"))
            {
                var res = roleManager.Create(new IdentityRole("Student"));
                if (!res.Succeeded)
                    throw new Exception(res.Errors.FirstOrDefault());
            }
        }
    }
}