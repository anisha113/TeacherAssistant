using AspNet.Identity.MySQL;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationDim.Teacher
{
    public partial class ClassTestAssignment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadCorurse();
            LoadGvCtAss();
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
            LoadGvCtAss();
        }

        protected void LoadGvCtAss()
        {
            MySQLDatabase data = new MySQLDatabase();
            var countCtAss = data.QueryValue("countCtAssByTCID",
                new Dictionary<string, object>
                {
                    {"@tcid", ddlSelectCourse.SelectedValue }
                }, true);
            if (countCtAss.ToString() == "0")
            {
                divp.Visible = true;
                divgv.Visible = false;
            }
            else
            {
                divp.Visible = false;
                divgv.Visible = true;
               
                var markIdSId = data.Query("GetCtAssMSIdSidByTCId",
                    new Dictionary<string, object>
                    {
                        {"@tcid", ddlSelectCourse.SelectedValue }
                    }, true);
                if (markIdSId != null)
                {
                    var rep = (List<Dictionary<string, string>>)null;
                    foreach (var list in markIdSId)
                    {
                        foreach (var dic in list)
                        {
                            if (dic.Key == "id")
                            {
                                if (rep == null)
                                {
                                    rep = data.Query("GetSidSnameMarksByMarkIdSid",
                                    new Dictionary<string, object>
                                    {
                                    {"@mrid", Convert.ToInt32(dic.Value)}
                                    }, true);
                                }
                                else
                                {
                                    var rep2 = data.Query("GetSidSnameMarksByMarkIdSid",
                                    new Dictionary<string, object>
                                    {
                                    {"@mrid", Convert.ToInt32(dic.Value)}
                                    }, true);
                                    rep.AddRange(rep2);
                                }
                            }
                        }
                    }
                    var rep3 = rep.Select(a => new
                    {
                        ID = a["id"],
                        Studentid = a["studentId"],
                        Name = a["FirstName"] + " " + a["LastName"],
                        ClassTestName = a["name"] + "(" + a["sectionPercentage"] + ")",
                        marks = a["mark"]
                    }).ToList();

                    DataTable sourceTable = new DataTable();
                    sourceTable = ToDataTable(rep3);


                    List<string> CTs = sourceTable.AsEnumerable().Select(x => x.Field<string>("ClassTestName")).Distinct().ToList();
                    DataTable pivotTable = new DataTable();
                    pivotTable.Columns.Add("StudentID", typeof(string));
                    pivotTable.Columns.Add("Name", typeof(string));
                    foreach (string ct in CTs)
                    {
                        pivotTable.Columns.Add(ct, typeof(string));
                    }

                    var students = sourceTable.AsEnumerable()
                        .GroupBy(x => new
                        {
                            Studentid = x.Field<string>("Studentid"),
                            Name = x.Field<string>("Name")
                        }).ToList();

                    foreach (var student in students)
                    {
                        DataRow newRow = pivotTable.Rows.Add();
                        newRow["Studentid"] = student.Key.Studentid;
                        newRow["Name"] = student.Key.Name;
                        foreach (DataRow row in student)
                        {
                            if (row.Field<string>("marks") == null)
                                newRow[row.Field<string>("ClassTestName")] = "0";
                            else
                            {
                                var a = row.Field<string>("marks"); 
                                newRow[row.Field<string>("ClassTestName")] = a;
                            }
                        }

                    }

                    gvCtAss.DataSource = pivotTable;
                    gvCtAss.DataBind();
                }
            }
        }

        public static DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);

            //Get all the properties
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
            //put a breakpoint here and check datatable
            return dataTable;
        }


        protected void btnCtSave_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                MySQLDatabase data = new MySQLDatabase();
                data.Execute("AddSectionName",
                    new Dictionary<string, object>
                    {
                        {"@name",txtName.Text }
                    }, true);

                var lastSecId = data.QueryValue("GetLastInsertIdOfSectionName",
                    new Dictionary<string, object> { }, true);

                data.Execute("AddMarksectionForCt",
                new Dictionary<string, object>
                {
                    {"@tcid", ddlSelectCourse.SelectedValue },
                    {"@snid", lastSecId },
                    {"@msmark", Convert.ToInt32(txtMarks.Text) }
                }, true);


                var LastMarkSectionIdForCt = data.QueryValue("GetLastInsertIdOfMarkSection4CtAssByTcid",
                    new Dictionary<string, object> {
                        {"@tcid", ddlSelectCourse.SelectedValue}
                    }, true);

                var studentTableIdlist = data.Query("GetStudentTableIdByTcid",
                    new Dictionary<string, object> {
                        {"@tcid", ddlSelectCourse.SelectedValue}
                    }, true);

                foreach (var a in studentTableIdlist)
                {
                    var val = a["studentid"];
                    data.Execute("AddMark4CtAssByMsidSid",
                        new Dictionary<string, object>
                        {
                            
                            {"@msid",LastMarkSectionIdForCt},
                            {"@sid", val}
                        }, true);
                }
                LoadGvCtAss();
            }
        }
    }
}