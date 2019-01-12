using AspNet.Identity.MySQL;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationDim.Teacher
{
    public partial class InputMarks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCorurse();
                LoadCtAssDdl();
                LoadGvCtAss();
            }
        }

        protected void LoadCorurse()
        {
            var course = new MySQLDatabase().Query("GetAllCourselListByUserId",
                new Dictionary<string, object>
                {
                    {"@uid", User.Identity.GetUserId() }
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
            LoadCtAssDdl();
            LoadGvCtAss();
        }

        protected void LoadCtAssDdl()
        {
            var CtAss = new MySQLDatabase().Query("GetAllCtAssByTCID",
                new Dictionary<string, object>
                {
                    {"@tcid", ddlSelectCourse.SelectedValue }
                }, true);
            ddlCtAss.DataSource = CtAss.Select(x => new
            {
                t = x["name"],
                v = x["id"]
            }).ToList();
            ddlCtAss.DataTextField = "t";
            ddlCtAss.DataValueField = "v";
            ddlCtAss.DataBind();
        }

        protected void ddlCtAss_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadGvCtAss();
        }

        protected void LoadGvCtAss()
        {
            var table = new MySQLDatabase().Query("GetSidSnameMarksMarkIdByMarkSectionID",
                new Dictionary<string, object>
                {
                    {"@mrsid", ddlCtAss.SelectedValue }
                }, true);
            gvCtAss.DataSource = table.Select(x => new
            {
                StudentID = x["studentId"],
                Name = x["FirstName"] + " " + x["LastName"],
                Marks = x["mark"],
                MarkID = x["id"]
            }).ToList();
            gvCtAss.DataBind();
        }

        protected void btnGvSave_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow gr in gvCtAss.Rows)
            {
                HiddenField hf1 = (HiddenField)gr.FindControl("hfMarkId");
                TextBox tb1 = (TextBox)gr.FindControl("txtMark");

                new MySQLDatabase().Execute("UpdateMarkByMarkID",
                    new Dictionary<string, object>
                    {
                        {"@mrid", hf1.Value },
                        {"@mark", tb1.Text }
                    }, true);
            }
            LoadGvCtAss();
        }
    }
}