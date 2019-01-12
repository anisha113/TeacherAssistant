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
    public partial class AttendanceMarksOverView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDdlCourse();
                LoadAttMarks();
                LoadGvAttendance();
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

        protected void LoadAttMarks()
        {
            var marks = new MySQLDatabase().QueryValue("GetAttMarkByTCID",
                new Dictionary<string, object>
                {
                    {"@tcid", ddlSelectCourse.SelectedValue }
                }, true);
            txtAttmarks.Text = marks.ToString();
        }

        protected void LoadGvAttendance()
        {
            MySQLDatabase data = new MySQLDatabase();
            var atTable = data.Query("GetAttendanceSecListByTCID",
                    new Dictionary<string, object>
                    {
                        {"@tcid",ddlSelectCourse.SelectedValue }
                    }, true);
            var gvtable = atTable.Select(x => new
            {
                id = x["id"],
                start = x["start"],
                end = x["end"],
                mark = x["mark"]
            }).ToList();
            gvAttendance.DataSource = gvtable;
            gvAttendance.DataBind();
        }

        protected void ddlSelectCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadAttMarks();
            LoadGvAttendance();
        }
    }
}