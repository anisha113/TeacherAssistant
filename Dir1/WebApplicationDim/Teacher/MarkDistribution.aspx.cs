using AspNet.Identity.MySQL;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationDim.Teacher
{
    public partial class MarkDistribution : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCorurse();
                LoadTxtAttendenceMark();
                LoadGvAttendance();
                loadcb();
            }
        }

        protected void LoadTxtAttendenceMark()
        {
            var atmark = new MySQLDatabase().QueryValue("GetAttendancePersentaheByTCID",
                new Dictionary<string, object>
                {
                    {"@tcid", ddlSelectCourse.SelectedValue }
                },true);
            txtAttendenceMark.Text = atmark.ToString();
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

        protected void loadcb()
        {
            var a = new MySQLDatabase().QueryValue("GetAttendanceAsdefaultBytcid",
                new Dictionary<string, object>
                {
                    {"@tcid", ddlSelectCourse.SelectedValue }
                }, true);
            if (a != null)
                cbDefault.Checked = true;
            else
                cbDefault.Checked = false;
        }

        protected void LoadGvAttendance()
        {
            MySQLDatabase data = new MySQLDatabase();
            // checking this TCID has any default settings
            var isdefault = data.QueryValue("CountAttendanceSectionIdByTcidAsDefault",
                new Dictionary<string, object>
                {
                    {"@tcid",ddlSelectCourse.SelectedValue }
                }, true);
            var atTable = data.Query("GetAttendanceSecListByTCID",
                    new Dictionary<string, object>
                    {
                        {"@tcid",ddlSelectCourse.SelectedValue }
                    }, true);
            if (atTable.Count != 0)
            {
                LoadDefaultGridview();
            }
            else if (isdefault.ToString() == "0")
            {
                var teacherid = data.QueryValue("GetTeacherIdByUserId",
                    new Dictionary<string, object>
                    {
                        {"@uid", User.Identity.GetUserId() }
                    }, true);
                if (teacherid == null)
                {
                    DataTable table = CreatDefault();
                    foreach (DataRow row in table.Rows)
                    {
                        data.Execute("AddAttendanceSection",
                            new Dictionary<string, object>
                            {
                            {"@start", row.Field<int>(0)},
                            {"@end", row.Field<int>(1)},
                            {"@mark", row.Field<int>(2)},
                            {"@tcid", ddlSelectCourse.SelectedValue },
                            {"@default", 0 }
                            }, true);
                    }
                    LoadDefaultGridview();
                }
                else
                {
                    var teacherCourses = data.Query("GetTCIDByTID",
                        new Dictionary<string, object>
                        {
                            {"@tid", Convert.ToInt32(teacherid.ToString()) }
                        }, true);
                    bool a = false;
                    foreach (var list in teacherCourses)
                    {
                        foreach (var dic in list)
                        {
                            var istcid = data.QueryValue("CountAttendanceSectionIdByTcid",
                            new Dictionary<string, object>
                            {
                                {"@tcid",Convert.ToInt32(dic.Value)}
                            }, true);
                            if (istcid.ToString() != "0")
                            {
                                var atTables = data.Query("GetAttendanceSecListByTCID",
                                     new Dictionary<string, object>
                                    {
                                        {"@tcid",Convert.ToInt32(dic.Value) }
                                    }, true);
                                foreach (var c in atTables)
                                {
                                    int s = 0;
                                    int e = 0;
                                    int m = 0;
                                    foreach (var b in c)
                                    {
                                        if (b.Key == "start")
                                        {
                                            s = Convert.ToInt32(b.Value);
                                        }
                                        if (b.Key == "end")
                                        {
                                            e = Convert.ToInt32(b.Value);
                                        }
                                        if (b.Key == "mark")
                                        {
                                            m = Convert.ToInt32(b.Value);
                                        }
                                    }
                                    data.Execute("AddAttendanceSection",
                                     new Dictionary<string, object>
                                     {
                                        {"@start", s},
                                        {"@end", e},
                                        {"@mark", m},
                                        {"@tcid", ddlSelectCourse.SelectedValue },
                                        {"@default", 0 }
                                     }, true);

                                }
                                a = true;
                                break;
                            }
                        }
                        if (a == true)
                            break;
                    }
                    if (a == false)
                    {
                        LoadDefaultGridview();
                    }
                }
            }
        }

        protected void LoadDefaultGridview()
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

        protected DataTable CreatDefault()
        {
            DataTable table = new DataTable();

            table.Columns.Add("Start", typeof(int));
            table.Columns.Add("End", typeof(int));
            table.Columns.Add("Mark", typeof(int));

            table.Rows.Add(1, 10, 1);
            table.Rows.Add(11, 20, 2);
            table.Rows.Add(21, 30, 3);
            table.Rows.Add(31, 40, 4);
            table.Rows.Add(41, 50, 5);
            table.Rows.Add(51, 60, 6);
            table.Rows.Add(61, 70, 7);
            table.Rows.Add(71, 80, 8);
            table.Rows.Add(81, 90, 9);
            table.Rows.Add(91, 100, 10);

            return table;
        }

        protected void ddlSelectCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTxtAttendenceMark();
            LoadGvAttendance();
            loadcb();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                foreach (GridViewRow gr in gvAttendance.Rows)
                {
                    HiddenField hf = (HiddenField)gr.FindControl("hfattendancesectionid");
                    TextBox txtstart = (TextBox)gr.FindControl("txtStart");
                    TextBox txtend = (TextBox)gr.FindControl("txtEnd");
                    TextBox txtmark = (TextBox)gr.FindControl("txtMark");
                    int a = 0;
                    if (cbDefault.Checked)
                        a = 1;
                    new MySQLDatabase().Execute("UpdateAttendanceSectionByid",
                    new Dictionary<string, object>
                    {
                            {"@id", Convert.ToInt32(hf.Value) },
                            {"@start", Convert.ToInt32(txtstart.Text) },
                            {"@end", Convert.ToInt32(txtend.Text) },
                            {"@mark", Convert.ToInt32(txtmark.Text) },
                            {"@de", a }
                    }, true);
                }
                new MySQLDatabase().Execute("UpdateAttendancemarkperBytcid",
                    new Dictionary<string, object>
                    {
                        {"@tcid", ddlSelectCourse.SelectedValue },
                        {"@mr", Convert.ToInt32(txtAttendenceMark.Text)}
                    }, true);
            }
        }
    }
}