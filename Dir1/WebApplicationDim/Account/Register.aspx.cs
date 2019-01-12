using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using WebApplicationDim.Models;
using System.Configuration;
using MySql.Data.MySqlClient;
using AspNet.Identity.MySQL;
using System.Collections.Generic;

namespace WebApplicationDim.Account
{
    public partial class Register : Page
    {
        public object MySqlConnection { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                setPageLayout();

                loadDropDownList();
            }
        }

        private void loadDropDownList()
        {
            string connstr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            MySqlConnection conn = new MySqlConnection(connstr);

            MySqlCommand cmd = new MySqlCommand("GetAllSalutaion", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            conn.Open();
            MySqlDataReader reader = cmd.ExecuteReader();
            ddlSalutation.DataSource = reader;
            ddlSalutation.DataTextField = "name";
            ddlSalutation.DataValueField = "id";
            ddlSalutation.DataBind();
            reader.Close();

            cmd = new MySqlCommand("GetAllDesignation", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            reader = cmd.ExecuteReader();
            ddlDesignation.DataSource = reader;
            ddlDesignation.DataTextField = "name";
            ddlDesignation.DataValueField = "id";
            ddlDesignation.DataBind();
            reader.Close();

            cmd = new MySqlCommand("GetAllVersity", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            reader = cmd.ExecuteReader();
            ddlVersity.DataSource = reader;
            ddlVersity.DataTextField = "name";
            ddlVersity.DataValueField = "id";
            ddlVersity.DataBind();
            reader.Close();

            var res = new MySQLDatabase().Query("getDeptByVersityId",
                new Dictionary<string, object>()
                {
                    {"@pid", ddlVersity.SelectedValue }
                }, true);

            ddlDepartment.DataSource = res.Select(x => new
            {
                T = x["name"],
                V = x["id"]
            }).ToList();
            ddlDepartment.DataTextField = "T";
            ddlDepartment.DataValueField = "V";
            ddlDepartment.DataBind();
            conn.Close();
        }

        protected void CreateUser_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
                var user = new ApplicationUser()
                {
                    UserName = userName.Text,
                    FirstName = firstName.Text,
                    LastName = lastName.Text,
                    Sex = Sex.SelectedValue,
                    VersityDepartmentId = Convert.ToInt32(new MySQLDatabase().QueryValue("getVersityDeptId",
                    new Dictionary<string, object>()
                    {
                        {"@vid", ddlVersity.SelectedValue },
                        {"@did", ddlDepartment.SelectedValue }
                    }, true)),
                    Email = Email.Text,
                    PhoneNumber = PhoneNumber.Text,
                    Address = Address.Text
                };
                IdentityResult result = manager.Create(user, Password.Text);
                if (result.Succeeded)
                {
                    // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                    //string code = manager.GenerateEmailConfirmationToken(user.Id);
                    //string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
                    //manager.SendEmail(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>.");

                    if (ddlRegisterAs.SelectedValue == "1")
                    {
                        var res = manager.AddToRole(user.Id, "Student");
                        if (res.Succeeded)
                        {
                            new MySQLDatabase().Execute("addStudent",
                                new Dictionary<string, object>()
                                {
                                    {"@sid", studentid.Text},
                                    {"@btc", batch.Text},
                                    {"@uid", user.Id }
                                }, true);
                        }
                        else
                        {
                            ErrorMessage.Text = result.Errors.FirstOrDefault();
                            return;
                        }

                        //throw new NotImplementedException();
                    }
                    else
                    {
                        var res = manager.AddToRole(user.Id, "Teacher");
                        if (res.Succeeded)
                        {
                            new MySQLDatabase().Execute("addTeacher",
                                new Dictionary<string, object>()
                                {
                                    {"@UId", user.Id },
                                    {"@did", ddlDesignation.SelectedValue },
                                    {"@sid", ddlSalutation.SelectedValue }
                                }, true);
                        }
                        else
                        {
                            ErrorMessage.Text = result.Errors.FirstOrDefault();
                            return;
                        }
                    }

                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);



                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);

                }
                else
                {
                    ErrorMessage.Text = result.Errors.FirstOrDefault();
                }
            }
        }

        protected void ddlRegisterAs_SelectedIndexChanged(object sender, EventArgs e)
        {
            setPageLayout();
        }

        private void setPageLayout()
        {
            if (ddlRegisterAs.SelectedValue == "2")
            {

                divTeacher.Visible = true;
                divStudent.Visible = false;

            }
            else
            {
                divTeacher.Visible = !true;
                divStudent.Visible = !false;
            }
        }

        protected void ddlVersity_SelectedIndexChanged(object sender, EventArgs e)
        {
            var res = new MySQLDatabase().Query("getDeptByVersityId",
                new Dictionary<string, object>()
                {
                    {"@pid", ddlVersity.SelectedValue }
                }, true);

            ddlDepartment.DataSource = res.Select(x => new
            {
                Text = x["name"],
                Value = x["id"]
            }).ToList();
            ddlDepartment.DataTextField = "Text";
            ddlDepartment.DataValueField = "Value";
            ddlDepartment.DataBind();
        }
    }
}