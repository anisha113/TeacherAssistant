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
    public partial class TakeAttendence : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadTxtDate();
                LoadCorurse();
                bindGridView();
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

        protected void loadTxtDate()
        {
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }

        protected void bindGridView()
        {
            gvTakeAttendence_dataBound();
            
        }

        protected void gvTakeAttendence_dataBound()
        {
            MySQLDatabase data = new MySQLDatabase();
            var markIdSId = data.Query("GetMSIdSidByTCId",
                new Dictionary<string, object>
                {
                        {"@tcid", ddlSelectCourse.SelectedValue }
                }, true);
            if (markIdSId != null)
            {
                var rep = from x in markIdSId
                          let v = data.Query("GetSidSnameBysid",
                          new Dictionary<string, object>
                          {
                                  {"@sid", x["studentId"] }
                          }, true)
                          select new
                          {
                              studentid = v[0]["studentId"],
                              name = v[0]["FirstName"] + " " + v[0]["LastName"],
                              markid = x["id"]
                          };
                gvTakeAttendence.DataSource = rep.ToList();
                gvTakeAttendence.DataBind();
            }
        }

        protected void gvTakeAttendence_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (cblCalssNumber.SelectedValue == "1")
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    HiddenField hf1 = e.Row.FindControl("hfMarkId") as HiddenField;
                    CheckBox cb1 = e.Row.FindControl("cbSelected1") as CheckBox;
                    var isDateExist = new MySQLDatabase().QueryValue("GetAttendanceIdByMarkIdDate",
                        new Dictionary<string, object>
                        {
                            {"@mrid", Convert.ToInt32(hf1.Value) },
                            {"@dt", txtDate.Text}
                        }, true);
                    if (isDateExist != null)
                    {
                        var present = new MySQLDatabase().QueryValue("GetPresentByAttnId",
                            new Dictionary<string, object>
                            {
                                {"@atnid",isDateExist}
                            }, true);
                        if (present.ToString() == "True")
                        {
                            cb1.Checked = true;
                        }
                        else
                        {
                            cb1.Checked = false;
                        }
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow gr in gvTakeAttendence.Rows)
            {
                HiddenField hf1 = (HiddenField)gr.FindControl("hfMarkId");
                CheckBox cb1 = (CheckBox)gr.FindControl("cbSelected1");

                var isDateExist = new MySQLDatabase().QueryValue("GetAttendanceIdByMarkIdDate",
                    new Dictionary<string, object>
                    {
                            {"@mrid", Convert.ToInt32(hf1.Value) },
                            {"@dt", txtDate.Text}
                    }, true);
                if (isDateExist != null)
                {
                    int a = 0;
                    if (cb1.Checked == true)
                    {
                        a = 1;
                    }
                    var present = new MySQLDatabase().Execute("UpdateAttendanceByAtnIdPresent",
                        new Dictionary<string, object>
                        {
                            {"@atnid",isDateExist },
                            {"@pr", a}
                        }, true);
                }
                else
                {
                    int a = 0;
                    if (cb1.Checked == true)
                    {
                        a = 1;
                    }
                    new MySQLDatabase().Execute("AddAttendance",
                        new Dictionary<string, object>
                        {
                            {"@mrid", Convert.ToInt32(hf1.Value) },
                            {"@date", txtDate.Text },
                            {"@pr",a }
                        }, true);
                }
            }
            bindGridView();
        }

        protected void ddlSelectCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            bindGridView();
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            bindGridView();
        }

        protected void cbSelecteds_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox cbSelects = (CheckBox)sender;

            foreach (GridViewRow gridViewRow in this.gvTakeAttendence.Rows)
            {
                CheckBox cbSelected = (CheckBox)gridViewRow.FindControl("cbSelected1");
                cbSelected.Checked = cbSelects.Checked;
            }
        }
    }
}