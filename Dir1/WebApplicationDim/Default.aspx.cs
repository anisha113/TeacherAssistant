using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationDim
{
	public partial class _Default : Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {

            if (User.IsInRole("Teacher"))
            {
                Response.Redirect("http://localhost:55822/Teacher/Dashboard");
            }
            else if (User.IsInRole("Student"))
            {
                Response.Redirect("http://localhost:55822/Student/Dashboard");
            }
            else
            {
                Response.Redirect("http://localhost:55822/Account/Login");
            }
        }
	}
}