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
    public partial class AddCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                h3Success.Visible = false;
                loadDdl();
            }
        }

        protected void loadDdl()
        {
            var allVersity = new MySQLDatabase().Query("GetAllVersity",
                new Dictionary<string, object> { }, true);
            ddlVersity.DataSource = allVersity.Select(x => new
            {
                Text = x["name"],
                Value = x["id"]
            }).ToList();
            ddlVersity.DataValueField = "Value";
            ddlVersity.DataTextField = "Text";
            ddlVersity.DataBind();

            var dept = new MySQLDatabase().Query("getDeptByVersityId",
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

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                h3Success.Visible = true;

                var userId = User.Identity.GetUserId();

                var versityDeptId = new MySQLDatabase().QueryValue("GetVersityDeptByAllIndex",
                    new Dictionary<string, object>()
                    {
                        {"@vid", ddlVersity.SelectedValue },
                        {"@did", ddlDepartment.SelectedValue }
                    }, true);

                new MySQLDatabase().Query("AddCource",
                    new Dictionary<string, object>()
                    {
                        {"@prefix", txtPrefix.Text},
                        {"@cno", Convert.ToInt32(txtCourseNo.Text)},
                        {"@postfix",txtPostfix.Text},
                        {"@ct", txtCourseTitle.Text},
                        {"@vdid", versityDeptId},
                        {"@crd", Convert.ToDecimal(txtCredit.Text)}
                    }, true);
            }
        }

        protected void ddlVersity_SelectedIndexChanged(object sender, EventArgs e)
        {
            var dept = new MySQLDatabase().Query("getDeptByVersityId",
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

        
    }
}