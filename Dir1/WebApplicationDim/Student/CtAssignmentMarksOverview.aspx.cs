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
    public partial class CtAssignmentMarksOverview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDdlCourse();
                LoadGvCtAss();
            }
        }

        protected void LoadDdlCourse()
        {
            var data = new MySQLDatabase();

            var sid = data.Query("GetStudentTableIdByUserId",
                new Dictionary<string, object>
                {
                     {"@uid", User.Identity.GetUserId() }
                }, true);
            var a = sid.First()["id"];
            var course = data.Query("GetAllCTitleSessionBySID",
                 new Dictionary<string, object>
                 {
                    {"@sid", a}
                 }, true);
            ddlSelectCourse.DataSource = course.Select(x => new
            {
                t = x["prefix"] + " " + x["course_no"] + " " + x["course_tittle"] + " " + x["postfix"] + " (" + x["session"] + ")",
                v = x["id"]
            }).ToList();
            ddlSelectCourse.DataTextField = "t";
            ddlSelectCourse.DataValueField = "v";
            ddlSelectCourse.DataBind();
        }

        protected void ddlSelectCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadGvCtAss();
        }

        protected void LoadGvCtAss()
        {
            var data = new MySQLDatabase();

            var sid = data.Query("GetStudentTableIdByUserId",
                new Dictionary<string, object>
                {
                     {"@uid", User.Identity.GetUserId() }
                }, true);
            var a = sid.First()["id"];

            var table = data.Query("GetAllCtAssNameMarkByTcidSid",
                new Dictionary<string, object>
                {
                    {"@tcid", ddlSelectCourse.SelectedValue },
                    {"@sid", a }
                }, true);
            gvCtAss.DataSource = table.Select(x => new
            {
                Name = x["name"],
                Marks = x["mark"]
            }).ToList();
            gvCtAss.DataBind();
        }
    }
}