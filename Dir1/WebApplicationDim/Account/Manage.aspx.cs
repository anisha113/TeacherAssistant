using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.Identity;
using AspNet.Identity.MySQL;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using WebApplicationDim.Models;

namespace WebApplicationDim.Account
{
    public partial class Manage : System.Web.UI.Page
    {
        protected string SuccessMessage
        {
            get;
            private set;
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }

        public bool HasPhoneNumber { get; private set; }

        public bool TwoFactorEnabled { get; private set; }

        public bool TwoFactorBrowserRemembered { get; private set; }

        public int LoginsCount { get; set; }

        protected void Page_Load()
        {
            AsStudent();
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            if (!IsPostBack)
            {
                var ursId = User.Identity.GetUserId();
                var urs = manager.FindById(ursId);

                lblFullName.InnerText = urs.FirstName + " " + urs.LastName;
                lblEmail.InnerText = urs.Email;
                txtMobileNum.Text = urs.PhoneNumber;
                txtAddress.Text = urs.Address;
                if (urs.Sex == "Female")
                {
                    ddlSex.SelectedValue = "Female";
                }
                else if(urs.Sex == "Male")
                {
                    ddlSex.SelectedValue = "Male";
                }
                else
                {
                    ddlSex.SelectedValue = "Other";
                }

                var vdid = urs.VersityDepartmentId;
                var dept = new MySQLDatabase().QueryValue("GetDeptByVdId",
                    new Dictionary<string, object>
                    {
                        {"@vdid",vdid}
                    }, true);
                lblDepartment.InnerText = dept.ToString();

                var versity = new MySQLDatabase().QueryValue("GetVersityByVdID",
                    new Dictionary<string, object>
                    {
                        {"@vdid",vdid }
                    },true);
                lblVersityName.InnerText = versity.ToString();

                if (HasPassword(manager))
                {
                    ChangePassword.Visible = true;
                }
                else
                {
                    ChangePassword.Visible = false;
                }

                // Render success message
                var message = Request.QueryString["m"];
                if (message != null)
                {
                    // Strip the query string from action
                    Form.Action = ResolveUrl("~/Account/Manage");

                    SuccessMessage =
                        message == "ChangePwdSuccess" ? "Your password has been changed."
                        : message == "SetPwdSuccess" ? "Your password has been set."
                        : message == "RemoveLoginSuccess" ? "The account was removed."
                        : message == "AddPhoneNumberSuccess" ? "Phone number has been added"
                        : message == "RemovePhoneNumberSuccess" ? "Phone number was removed"
                        : String.Empty;
                    successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
                }
            }
        }




        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            var usr = manager.FindById(User.Identity.GetUserId());

            usr.PhoneNumber = txtMobileNum.Text;
            usr.Address = txtAddress.Text;
            usr.Sex = ddlSex.SelectedValue;
            manager.Update(usr);

            new MySQLDatabase().Execute("UpdateDesignationIDByUserId",
                new Dictionary<string, object> {
                     {"@did", ddlDesignation.SelectedValue},
                    {"@uid", User.Identity.GetUserId()}
                }, true);
        }

        protected void AsStudent()
        {
            if (User.IsInRole("Teacher"))
            {
                divStudent.Visible = !true;
                divTeacher.Visible = true;
                var designation = new MySQLDatabase().Query("GetAllDesignation", new Dictionary<string, object> {}, true);

                ddlDesignation.DataSource = designation.Select(x => new
                {
                    t = x["name"],
                    v = x["id"]
                }).ToList();
                ddlDesignation.DataValueField = "v";
                ddlDesignation.DataTextField = "t";
                var td = new MySQLDatabase().QueryValue("GetDesignationIDByUserId",
                    new Dictionary<string, object> {
                        {"@uid", User.Identity.GetUserId()}
                    }, true);
                ddlDesignation.SelectedValue = td.ToString();
                ddlDesignation.DataBind();
            }
            else
            {
                var ursId = User.Identity.GetUserId();
                var studentId = new MySQLDatabase().QueryValue("GetStudentIdByUserId",
                    new Dictionary<string, object>
                    {
                        {"@uid", ursId}
                    }, true);

                lblStudentID.InnerText = studentId.ToString();

                var batch = new MySQLDatabase().QueryValue("GetBatchByUserId",
                    new Dictionary<string, object>
                    {
                        {"@uid", ursId}
                    }, true);
                lblBatch.InnerText = batch.ToString();

                divStudent.Visible = true;
            }
               

        }
    }
}