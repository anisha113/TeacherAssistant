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
    public partial class ApproveStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDdlcourse();
                loadNotApprovedStudent();
                loadApprovedStudent();
            }
        }

        protected void loadDdlcourse()
        {
            MySQLDatabase data = new MySQLDatabase();
            var teacherId = data.QueryValue("GetTeacherIdByUserId", new Dictionary<string, object> {
                { "@uid", User.Identity.GetUserId() }
            }, true);

            var courseList = data.Query("GetCourselListByTeacherId",
                new Dictionary<string, object> {
                    {"@tid", teacherId}
                }, true);
            ddlCourseTitle.DataSource = courseList.Select(x => new
            {
                t = x["prefix"] + " " + x["course_no"] + " " + x["course_tittle"] + " " + x["postfix"] + " (" + x["session"] + ")",
                v = x["id"]
            }).ToList();
            ddlCourseTitle.DataTextField = "t";
            ddlCourseTitle.DataValueField = "v";
            ddlCourseTitle.DataBind();
        }

        protected void loadNotApprovedStudent()
        {
            var student = new MySQLDatabase().Query("GetNotApprovedStudentByTeacherCourseId",
                new Dictionary<string, object> {
                    {"@tcid",ddlCourseTitle.SelectedValue}
                }, true);
            cblRequiedApprobval.DataSource = student.Select(x => new
            {
                t = " " + x["studentId"] + " " + x["FirstName"] + " " + x["LastName"],
                v = x["id"]
            }).ToList();
            cblRequiedApprobval.DataTextField = "t";
            cblRequiedApprobval.DataValueField = "v";
            cblRequiedApprobval.DataBind();
            if(student.Count == 0)
            {
                cbSelectAll1.Checked = false;
                cbSelectAll1.Visible = false;
            }
            else
            {
                
                cbSelectAll1.Visible = true;
            }
        }

        protected void loadApprovedStudent()
        {
            var student = new MySQLDatabase().Query("GetApprovedStudentByTeacherCourseId",
                new Dictionary<string, object> {
                    {"@tcid",ddlCourseTitle.SelectedValue}
                }, true);
            cblApprovedStudent.DataSource = student.Select(x => new
            {
                t = " " + x["studentId"] + " " + x["FirstName"] + " " + x["LastName"],
                v = x["id"]
            }).ToList();
            cblApprovedStudent.DataTextField = "t";
            cblApprovedStudent.DataValueField = "v";
            cblApprovedStudent.DataBind();
            if (student.Count == 0)
            {
                cbSelectAll2.Checked = false;
                cbSelectAll2.Visible = false;
            }
            else
            {

                cbSelectAll2.Visible = true;
            }
        }

        protected void ddlCourseTitle_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadNotApprovedStudent();
            loadApprovedStudent();
        }

        protected void AddStudentForAttendence()
        {

        }

        protected void btnApprovet_Click(object sender, EventArgs e)
        {
            foreach (ListItem a in cblRequiedApprobval.Items)
            {
                if (a.Selected)
                {
                    MySQLDatabase data = new MySQLDatabase();

                    data.Execute("UpdateIsConfirmTrueByStudentCourseID",
                        new Dictionary<string, object> {
                            {"@scid",a.Value}
                        }, true);

                    var marksection = data.QueryValue("GetMarkSectionIdForAttendenceByTCID",
                        new Dictionary<string, object>
                        {
                            {"@tcid", ddlCourseTitle.SelectedValue}
                        }, true);

                    var studentid = data.QueryValue("GetStudentTableIdByScid",
                        new Dictionary<string, object>
                        {
                            {"@scid",a.Value}
                        }, true);

                    data.Execute("AddMark4attByMsidSid",
                        new Dictionary<string, object>
                        {
                            {"@mcid",marksection },
                            {"@sid",studentid }
                        }, true);

                }
            }
            loadNotApprovedStudent();
            loadApprovedStudent();
        }

        protected void btnDisapprove_Click(object sender, EventArgs e)
        {
            foreach (ListItem a in cblApprovedStudent.Items)
            {
                if (a.Selected)
                {
                    MySQLDatabase data = new MySQLDatabase();
                    data.Execute("UpdateIsConfirmFalseByStudentCourseID",
                        new Dictionary<string, object> {
                            {"@scid",a.Value}
                        }, true);

                    var marksection = data.QueryValue("GetMarkSectionIdForAttendenceByTCID",
                        new Dictionary<string, object>
                        {
                            {"@tcid", ddlCourseTitle.SelectedValue}
                        }, true);

                    var studentid = data.QueryValue("GetStudentTableIdByScid",
                        new Dictionary<string, object>
                        {
                            {"@scid",a.Value}
                        }, true);

                    data.Execute("DeleteMarkByMsidSid",
                        new Dictionary<string, object>
                        {
                            {"@msid",marksection },
                            {"@sid",studentid }
                        }, true);
                }
            }
            loadNotApprovedStudent();
            loadApprovedStudent();
        }

        protected void cbSelectAll1_CheckedChanged(object sender, EventArgs e)
        {
            if (cbSelectAll1.Checked == true)
            {
                foreach (ListItem chkitem in cblRequiedApprobval.Items)
                {
                    chkitem.Selected = true;
                }
            }
            else
            {
                foreach (ListItem chkitem in cblRequiedApprobval.Items)
                {
                    chkitem.Selected = false;
                }
            }
        }

        protected void cbSelectAll2_CheckedChanged(object sender, EventArgs e)
        {
            if (cbSelectAll2.Checked == true)
            {
                foreach (ListItem chkitem in cblApprovedStudent.Items)
                {
                    chkitem.Selected = true;
                }
            }
            else
            {
                foreach (ListItem chkitem in cblApprovedStudent.Items)
                {
                    chkitem.Selected = false;
                }
            }
        }
    }
}