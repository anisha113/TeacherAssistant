using AspNet.Identity.MySQL;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web.UI.WebControls;

namespace WebApplicationDim.Teacher
{
    public partial class AttendanceOverView : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCorurse();
                gvAttendence_dataBound();
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

        protected void gvAttendence_dataBound()
        {
            MySQLDatabase data = new MySQLDatabase();
            var markIdSId = data.Query("GetAttendanceMSIdSidByTCId",
                new Dictionary<string, object>
                {
                        {"@tcid", ddlSelectCourse.SelectedValue }
                }, true);
            if (markIdSId != null)
            {
                var rep = (List<Dictionary<string,string>>)null;
                foreach(var list in markIdSId)
                {
                    foreach(var dic in list)
                    {
                        if(dic.Key == "id")
                        {
                            if(rep == null)
                            {
                                rep = data.Query("GetSidSnameDatePresentByMarkIdSid",
                                new Dictionary<string, object>
                                {
                                    {"@mrid", Convert.ToInt32(dic.Value)}
                                }, true);
                            }
                            else
                            {
                                var rep2 = data.Query("GetSidSnameDatePresentByMarkIdSid",
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
                    Date = Convert.ToDateTime(a["dateColumn"]).ToString("dd-MM"),
                    Present = a["present"]
                }).ToList();

                DataTable sourceTable = new DataTable();
                sourceTable= ToDataTable(rep3);
                

                List<string> dates = sourceTable.AsEnumerable().Select(x => x.Field<string>("Date")).Distinct().ToList();
                DataTable pivotTable = new DataTable();
                pivotTable.Columns.Add("StudentID", typeof(string));
                pivotTable.Columns.Add("Name", typeof(string));
                foreach (string date in dates)
                {
                    pivotTable.Columns.Add(date, typeof(string));
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
                        if (row.Field<string>("Present") == "True")
                            newRow[row.Field<string>("Date")] = "P";
                        else
                            newRow[row.Field<string>("Date")] = "A";
                    }

                }

                gvAttendence.DataSource = pivotTable;
                gvAttendence.DataBind();
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

        protected void ddlSelectCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvAttendence_dataBound();
        }

    }
}