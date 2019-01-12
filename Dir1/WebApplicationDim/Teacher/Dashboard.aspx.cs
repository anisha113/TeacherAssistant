using AspNet.Identity.MySQL;
using Microsoft.AspNet.Identity;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationDim.Teacher
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvCourse.Visible = true;
                bindGridView();
            }
        }

        protected void bindGridView()
        {
            MySQLDatabase data = new MySQLDatabase();
            var courseName = data.Query("GetAllCourselListByUserId",
                new Dictionary<string, object>
                {
                    {"@uid", User.Identity.GetUserId()}
                },true);
            var count = from x in courseName
                        let v = data.Query("GetStudentCourseIdByTCID",
                        new Dictionary<string, object>
                        {
                            {"@tcid", x["id"] }
                        }, true)
                        select new
                        {
                            Courses = x["prefix"] + " " + x["course_no"]
                            + " " + x["course_tittle"] + " " + x["postfix"] +
                            " (" + x["session"] + ")",
                            Students = v.Count.ToString(),
                            Status = (x["isclosed"].ToString() == "True") ? "Close" : "Open"
                        };
            gvCourse.DataSource = count.ToList();
            gvCourse.DataBind();
        }

    }
}