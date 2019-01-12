
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
    public partial class Student_AddCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                h2Success.Visible = false;
                h2Fail.Visible = false;
                //h2droped.Visible = false;
                loadDdlcourse();
                loadDdlteacher();
                loadDdlsession();
                //loadDdlDropCoruseName();
            }
        }

        protected void ddlCoruseName_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDdlteacher();
            loadDdlsession();
        }

        protected void ddlTeacherName_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDdlsession();
        }

        protected void loadDdlcourse()
        {
            var usr = User.Identity.GetUserId();
            var vdid = new MySQLDatabase().QueryValue("GetVersityDeptIdByUserId",
                new Dictionary<string, object> {
                    {"@uid", usr }
                }, true);
            var courseName = new MySQLDatabase().Query("GetCouserPreFixCodeNameByVersityDeptId",
                new Dictionary<string, object>
                {
                    {"@vdid",vdid }
                }, true);
            ddlCoruseName.DataSource = courseName.Select(x => new
            {
                t = x["prefix"] + " " + x["course_no"] + " " + x["course_tittle"] + " " + x["postfix"],
                v = x["id"]
            }).ToList();
            ddlCoruseName.DataValueField = "v";
            ddlCoruseName.DataTextField = "t";
            ddlCoruseName.DataBind();
        }

        protected void loadDdlteacher()
        {
            var teacherName = new MySQLDatabase().Query("GetTeacherNameByCourseId",
                new Dictionary<string, object> {
                    {"cid", ddlCoruseName.SelectedValue}
                }, true);
            ddlTeacherName.DataSource = teacherName.Select(x => new
            {
                t = x["FirstName"] + " " + x["LastName"],
                v = x["teacherId"]
            }).ToList();
            ddlTeacherName.DataTextField = "t";
            ddlTeacherName.DataValueField = "v";
            ddlTeacherName.DataBind();
        }

        protected void loadDdlsession()
        {
            var session = new MySQLDatabase().Query("GetSessionByTeacherIdCourseId",
                new Dictionary<string, object>
                {
                    {"@tid", ddlTeacherName.SelectedValue },
                    {"@cid", ddlCoruseName.SelectedValue }
                }, true);
            ddlSession.DataSource = session.Select(x => new
            {
                t = x["session"],
                v = x["id"]
            }).ToList();
            ddlSession.DataTextField = "t";
            ddlSession.DataValueField = "v";
            ddlSession.DataBind();

        }

        //protected void loadDdlDropCoruseName()
        //{
        //    var usr = User.Identity.GetUserId();
        //    var StudentId = new MySQLDatabase().QueryValue("GetStudentTableIdByUserId",
        //        new Dictionary<string, object> {
        //            {"@uid", usr }
        //        }, true);
        //    var courseName = new MySQLDatabase().Query("GetCorseNameByStudentId",
        //        new Dictionary<string, object>
        //        {
        //            {"@sid",StudentId }
        //        }, true);
        //    ddlDropCoruseName.DataSource = courseName.Select(x => new
        //    {
        //        t = x["prefix"] + " " + x["course_no"] + " " + x["course_tittle"] + " " + x["postfix"],
        //        v = x["id"],
        //        a = x["isconfirmed"]
        //    }).ToList();
        //    ddlDropCoruseName.DataValueField = "v";
        //    ddlDropCoruseName.DataTextField = "t";
        //    ddlDropCoruseName.DataBind();

        //}

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {

                var studentId = new MySQLDatabase().QueryValue("GetStudentTableIdByUserId", new Dictionary<string, object> {
                    {"@uid",User.Identity.GetUserId()}
                }, true);

                var studentcourse = new MySQLDatabase().QueryValue("GetStudentCourseIDbyTeacherCourseIdStudentId",
                    new Dictionary<string, object>
                    {
                    {"@tcid",ddlSession.SelectedValue},
                    {"@sid",studentId.ToString()}
                    }, true);

                if (studentcourse == null)
                {
                    new MySQLDatabase().Execute("AddStudentUserCourse",
                        new Dictionary<string, object>
                        {
                        {"@tcid",ddlSession.SelectedValue },
                        {"@sid",studentId.ToString()}
                        }, true);
                    h2Success.Visible = true;
                    //loadDdlDropCoruseName();
                }
                else
                {
                    h2Fail.Visible = true;
                }
                
            }
        }

        //protected void btnDrop_Click(object sender, EventArgs e)
        //{
        //    if(IsValid)
        //    {
        //        var studentId = new MySQLDatabase().QueryValue("GetStudentTableIdByUserId", new Dictionary<string, object> {
        //            {"@uid",User.Identity.GetUserId()}
        //        }, true);
        //        new MySQLDatabase().Query("DeleteStudentCourseBySCID",
        //            new Dictionary<string, object>
        //            {
        //            {"@scid",ddlDropCoruseName.SelectedValue }
        //            }, true);
        //        loadDdlDropCoruseName();
        //        h2droped.Visible = true;
        //    }
        //}
    }
}