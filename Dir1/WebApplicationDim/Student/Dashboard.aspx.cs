using AspNet.Identity.MySQL;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationDim.Student
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadGvCourse();
            }
        }

        protected void loadGvCourse()
        {
            MySQLDatabase data = new MySQLDatabase();
            var studentId = data.QueryValue("GetStudentTableIdByUserId",
                new Dictionary<string, object> {
                    {"@uid", User.Identity.GetUserId()}
                },true);
            var gvtable = data.Query("GetTNameCNameCsBySID",
                new Dictionary<string, object>
                {
                    {"@sid", studentId }
                },true);
            gvCourse.DataSource = gvtable.Select(x => new
            {
                Courses = x["prefix"] + " " + x["course_no"] + " " + x["course_tittle"] + " " + x["postfix"],
                Teacher = x["FirstName"] + " " + x["LastName"],
                Status = (x["isconfirmed"].ToString() == "True") ? "Approved" : "Not Approved"
            }).ToList();
            gvCourse.DataBind();
        }
    }
}