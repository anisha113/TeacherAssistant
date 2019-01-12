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
    public partial class TakeCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                h2Success.Visible = false;
                h2SuccessFailed.Visible = false;
                CloseSuccess.Visible = false;
                OpenSuccess.Visible = false;
                DropSuccess.Visible = false;
                txtDropWarning.Visible = false;
                LoadDdlCourse();
                HttpCookie cookie = Request.Cookies["Session"];
                if (cookie != null)
                {
                    ddlSession.SelectedValue = cookie["selected_item"];
                }
            }
        }

        protected void LoadDdlCourse()
        {
            MySQLDatabase data = new MySQLDatabase();

            loadDdlversity();

            loadDdlDept();

            loadDdlCourseCode();

            var degree = data.Query("GetAllDgree", new Dictionary<string, object> { }, true);
            ddlDegree.DataSource = degree.Select(x => new
            {
                t = x["levelName"],
                v = x["id"]
            }).ToList();
            ddlDegree.DataValueField = "v";
            ddlDegree.DataTextField = "t";
            ddlDegree.DataBind();

            var session = data.Query("GetAllSession", new Dictionary<string, object> { }, true);
            ddlSession.DataSource = session.Select(x => new
            {
                t = x["session"],
                v = x["id"]
            }).ToList();
            ddlSession.DataValueField = "v";
            ddlSession.DataTextField = "t";
            ddlSession.DataBind();

            var year = data.Query("GetAllYear", new Dictionary<string, object> { }, true);
            ddlYear.DataSource = year.Select(x => new
            {
                t = x["year"],
                v = x["id"]
            }).ToList();
            ddlYear.DataValueField = "v";
            ddlYear.DataTextField = "t";
            ddlYear.DataBind();

            var term = data.Query("GetAllTerm", new Dictionary<string, object> { }, true);
            ddlTerm.DataSource = term.Select(x => new
            {
                t = x["term"],
                v = x["id"]
            }).ToList();
            ddlTerm.DataValueField = "v";
            ddlTerm.DataTextField = "t";
            ddlTerm.DataBind();

            loadDdlDropSession();
            loadCblCourseName();




        }

        protected void loadDdlCourseCode()
        {
            MySQLDatabase data = new MySQLDatabase();
            var versityDeptId = new MySQLDatabase().QueryValue("GetVersityDeptByAllIndex", new Dictionary<string, object>(){
                {"@vid", ddlVersity.SelectedValue },
                {"@did", ddlDepartment.SelectedValue }
            }, true);

            var courseCode = data.Query("GetCouserPreFixCodeNameByVersityDeptId", new Dictionary<string, object> {
                {"@vdid", versityDeptId}
            }, true);

            ddlCourseTitle.DataSource = courseCode.Select(x => new
            {
                t = x["prefix"] + " " + x["course_no"] + " " + x["course_tittle"] + " " + x["postfix"],
                v = x["id"]
            }).ToList();
            ddlCourseTitle.DataValueField = "v";
            ddlCourseTitle.DataTextField = "t";
            ddlCourseTitle.DataBind();
        }

        protected void loadDdlversity()
        {
            MySQLDatabase data = new MySQLDatabase();
            var versity = data.Query("GetAllVersity", new Dictionary<string, object> { }, true);
            ddlVersity.DataSource = versity.Select(x => new
            {
                t = x["name"],
                v = x["id"]
            }).ToList();
            ddlVersity.DataValueField = "v";
            ddlVersity.DataTextField = "t";
            ddlVersity.DataBind();
        }

        protected void loadDdlDept()
        {
            MySQLDatabase data = new MySQLDatabase();

            var dept = data.Query("getDeptByVersityId",
                new Dictionary<string, object> {
                    {"@pid", ddlVersity.SelectedValue}
                }, true);
            ddlDepartment.DataSource = dept.Select(x => new
            {
                text = x["name"],
                value = x["id"]
            }).ToList();
            ddlDepartment.DataTextField = "text";
            ddlDepartment.DataValueField = "value";
            ddlDepartment.DataBind();
        }

        protected void loadDdlDropSession()
        {
            var userId = User.Identity.GetUserId();
            var teacherId = new MySQLDatabase().QueryValue("GetTeacherIdByUserId",
                new Dictionary<string, object>()
                {
                        {"@uid",userId }
                }, true);

            var session = new MySQLDatabase().Query("GetSessionByTeacherId",
                new Dictionary<string, object>
                {
                    {"@tid", teacherId}
                }, true);
            ddlDropSession.DataSource = session.Select(x => new
            {
                t = x["session"],
                v = x["id"]
            }).ToList();
            ddlDropSession.DataTextField = "t";
            ddlDropSession.DataValueField = "v";
            ddlDropSession.DataBind();
        }

        protected void loadCblCourseName()
        {
            MySQLDatabase data = new MySQLDatabase();
            var userId = User.Identity.GetUserId();
            var teacherId = data.QueryValue("GetTeacherIdByUserId",
                new Dictionary<string, object>()
                {
                        {"@uid",userId }
                }, true);
            if (ddlAction.SelectedValue == "3")
            {
                txtDropWarning.Visible = true;
                h2Success.Visible = false;
                h2SuccessFailed.Visible = false;
                CloseSuccess.Visible = false;
                OpenSuccess.Visible = false;
                DropSuccess.Visible = false;
                var course = data.Query("GetAllCrourseNameBySessionIDTeacherID",
                    new Dictionary<string, object> {
                        {"@tid",teacherId },
                        {"@sid", ddlDropSession.SelectedValue}
                    }, true);
                cblCourseName.DataSource = course.Select(x => new
                {
                    t = x["prefix"] + " " + x["course_no"] + " " + x["course_tittle"] + " " + x["postfix"],
                    v = x["id"]
                }).ToList();
                cblCourseName.DataTextField = "t";
                cblCourseName.DataValueField = "v";
                cblCourseName.DataBind();
            }
            else if (ddlAction.SelectedValue == "2")
            {
                txtDropWarning.Visible = false;
                var course = data.Query("GetClosedCrourseNameBySessionIDTeacherID",
                 new Dictionary<string, object> {
                        {"@tid",teacherId },
                        {"@sid", ddlDropSession.SelectedValue}
                 }, true);
                cblCourseName.DataSource = course.Select(x => new
                {
                    t = x["prefix"] + " " + x["course_no"] + " " + x["course_tittle"] + " " + x["postfix"],
                    v = x["id"]
                }).ToList();
                cblCourseName.DataTextField = "t";
                cblCourseName.DataValueField = "v";
                cblCourseName.DataBind();

            }
            else if (ddlAction.SelectedValue == "1")
            {
                txtDropWarning.Visible = false;
                var course = data.Query("GetOpenedCrourseNameBySessionIDTeacherID",
                    new Dictionary<string, object> {
                        {"@tid",teacherId },
                        {"@sid", ddlDropSession.SelectedValue}
                    }, true);
                cblCourseName.DataSource = course.Select(x => new
                {
                    t = x["prefix"] + " " + x["course_no"] + " " + x["course_tittle"] + " " + x["postfix"],
                    v = x["id"]
                }).ToList();
                cblCourseName.DataTextField = "t";
                cblCourseName.DataValueField = "v";
                cblCourseName.DataBind();

            }
        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                MySQLDatabase data = new MySQLDatabase();
                var DSYTID = data.QueryValue("GetDegreeSessionYearTermIdBYAllIndex",
                    new Dictionary<string, object>
                    {
                        { "@did", ddlDegree.SelectedValue},
                        { "@sid", ddlSession.SelectedValue},
                        { "@yid", ddlYear.SelectedValue},
                        { "@tid", ddlTerm.SelectedValue}
                    }, true);

                if (DSYTID == null)
                {
                    data.Execute("AddDegreeSessionYearTerm",
                        new Dictionary<string, object>()
                        {
                            { "@did", ddlDegree.SelectedValue},
                            { "@sid", ddlSession.SelectedValue},
                            { "@yid", ddlYear.SelectedValue},
                            { "@tid", ddlTerm.SelectedValue}
                        }, true);
                }


                var userId = User.Identity.GetUserId();
                var teacherId = data.QueryValue("GetTeacherIdByUserId",
                    new Dictionary<string, object>()
                    {
                        {"@uid",userId }
                    }, true);

                DSYTID = data.QueryValue("GetDegreeSessionYearTermIdBYAllIndex",
                    new Dictionary<string, object>
                    {
                        { "@did", ddlDegree.SelectedValue},
                        { "@sid", ddlSession.SelectedValue},
                        { "@yid", ddlYear.SelectedValue},
                        { "@tid", ddlTerm.SelectedValue}
                    }, true);

                var isTeacherCourseAvailable = data.QueryValue("GetTeacherCourceIdByTidDidCid",
                    new Dictionary<string, object>
                    {
                        {"@uid", teacherId},
                        {"@did", DSYTID},
                        {"cid", ddlCourseTitle.SelectedValue}
                    }, true);
                if (isTeacherCourseAvailable == null)
                {
                    data.Execute("AddTeacherCource",
                    new Dictionary<string, object>()
                    {
                        {"@uid", teacherId},
                        {"@did", DSYTID},
                        {"cid", ddlCourseTitle.SelectedValue}
                    }, true);

                    var teacherCourseId = data.QueryValue("GetTeacherCourceIdByTidDidCid",
                        new Dictionary<string, object>
                        {
                            {"@uid", teacherId},
                            {"@did", DSYTID},
                            {"cid", ddlCourseTitle.SelectedValue}
                        }, true);
                    data.Execute("AddMarkSectionForAttendance",
                        new Dictionary<string, object>
                        {
                            {"@tcid",teacherCourseId}
                        }, true);
                    h2Success.Visible = true;
                    h2SuccessFailed.Visible = false;
                    CloseSuccess.Visible = false;
                    OpenSuccess.Visible = false;
                    DropSuccess.Visible = false;
                    txtDropWarning.Visible = false;
                    Response.Redirect("~/Teacher/MarkDistribution");

                }
                else
                {
                    h2SuccessFailed.Visible = true;
                    h2Success.Visible = false;
                    CloseSuccess.Visible = false;
                    OpenSuccess.Visible = false;
                    DropSuccess.Visible = false;
                    txtDropWarning.Visible = false;
                }
            }
        }

        protected void ddlVersity_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDdlDept();
            loadDdlCourseCode();

        }

        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDdlCourseCode();
        }

        protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
        {
            HttpCookie cookie = new HttpCookie("Session");
            cookie["selected_item"] = ddlSession.SelectedValue;
            cookie.Expires = DateTime.Now.AddYears(1);
            Response.Cookies.Add(cookie);
        }

        protected void ddlDropSession_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadCblCourseName();
        }

        protected void ddlAction_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadCblCourseName();
        }

        protected void ButtonProcced_Click(object sender, EventArgs e)
        {
            MySQLDatabase data = new MySQLDatabase();
            var userId = User.Identity.GetUserId();
            var teacherId = data.QueryValue("GetTeacherIdByUserId",
                new Dictionary<string, object>()
                {
                        {"@uid",userId }
                }, true);
            if (ddlAction.SelectedValue == "1")
            {
                foreach (ListItem a in cblCourseName.Items)
                {
                    if (a.Selected)
                    {
                        new MySQLDatabase().Execute("ClosedTeacherCourseByTidCid",
                            new Dictionary<string, object> {
                                {"@tid",teacherId},
                                {"@cid",a.Value}
                            }, true);
                    }
                }
                CloseSuccess.Visible = true;
                h2Success.Visible = false;
                h2SuccessFailed.Visible = false;
                OpenSuccess.Visible = false;
                DropSuccess.Visible = false;
                txtDropWarning.Visible = false;
            }
            else if(ddlAction.SelectedValue == "2")
            {
                foreach (ListItem a in cblCourseName.Items)
                {
                    if (a.Selected)
                    {
                        new MySQLDatabase().Execute("OpenTeacherCourseByTidCid",
                            new Dictionary<string, object> {
                                {"@tid",teacherId},
                                {"@cid",a.Value}
                            }, true);
                    }
                }
                OpenSuccess.Visible = true;
                h2Success.Visible = false;
                h2SuccessFailed.Visible = false;
                CloseSuccess.Visible = false;
                DropSuccess.Visible = false;
                txtDropWarning.Visible = false;

            }
            else if (ddlAction.SelectedValue == "3")
            {
                foreach (ListItem a in cblCourseName.Items)
                {
                    if (a.Selected)
                    {
                        new MySQLDatabase().Execute("DeletTeachCourseByTcid",
                            new Dictionary<string, object> {
                                {"@tcid",a.Value}
                            }, true);
                    }
                }
                DropSuccess.Visible = true;
                h2Success.Visible = false;
                h2SuccessFailed.Visible = false;
                CloseSuccess.Visible = false;
                OpenSuccess.Visible = false;
                txtDropWarning.Visible = false;
            }
            loadCblCourseName();
        }
    }
}