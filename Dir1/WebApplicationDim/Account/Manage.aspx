<%@ Page Title="Account Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="WebApplicationDim.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        span.form-control {
            max-width: 280px;
        }

        select.form-control {
            max-width: 280px;
        }
    </style>
    <br />
    <div class="row">
        <div class="panel panel-primary col-md-offset-2 col-md-8">
            <h2 class="panel-heading"><%: Title %></h2>
            <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
                <p class="text-success"><%: SuccessMessage %></p>
            </asp:PlaceHolder>
            <div class="form-horizontal panel-body">
                <%--<h4>Change your account detail</h4>--%>
                <hr />
                <div class="form-group">
                    <label class="col-md-4 text-right">Name</label>
                    <div class="col-md-8">
                        <label id="lblFullName" runat="server">Name</label>
                    </div>
                </div>
                <br />
                <div id="divStudent" runat="server">
                    <div class="form-group">
                        <label class="col-md-4 text-right">Student ID</label>
                        <div class="col-md-8">
                            <label id="lblStudentID" runat="server">Student ID</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 text-right">Batch</label>
                        <div class="col-md-8">
                            <label id="lblBatch" runat="server">name</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-4 text-right">Versity Name</label>
                    <div class="col-md-8">
                        <label id="lblVersityName" runat="server">name</label>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <label class="col-md-4 text-right">Department</label>
                    <div class="col-md-8">
                        <label id="lblDepartment" runat="server">Department</label>
                    </div>
                </div>
                <br />
                <div id="divTeacher" runat="server" visible="false">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlDesignation" CssClass="col-md-4 control-label pad">Designation</asp:Label>
                        <div class="col-md-8">
                            <asp:DropDownList runat="server" ID="ddlDesignation" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <br />
                </div>
                <div class="form-group">
                    <label class="col-md-4 text-right">Email</label>
                    <div class="col-md-8">
                        <label id="lblEmail" runat="server">Email</label>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtMobileNum" CssClass="col-md-4 control-label pad">Phone / Mobile number</asp:Label>
                    <div class="col-md-8">
                        <asp:TextBox runat="server" ID="txtMobileNum" CssClass="form-control" TextMode="SingleLine" />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtAddress" CssClass="col-md-4 control-label pad">Address</asp:Label>
                    <div class="col-md-8">
                        <asp:TextBox runat="server" Style="max-width: 280px" ID="txtAddress" CssClass="form-control" TextMode="MultiLine" />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="ddlSex" CssClass="col-md-4 control-label pad">Gender</asp:Label>
                    <div class="col-md-8">
                        <asp:DropDownList runat="server" ID="ddlSex" CssClass="form-control">
                            <asp:ListItem Text="Male" />
                            <asp:ListItem Text="Female" />
                            <asp:ListItem Text="Other" />
                        </asp:DropDownList>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <div class="col-md-offset-4 col-md-8">
                        <asp:Button runat="server" Text="Update" ID="btnUpdate" OnClick="btnUpdate_Click" CssClass="btn btn-default" />
                    </div>
                </div>
                <hr />
                <div class="dl-horizontal">
                    <div class="form-group">
                        <label for="ChangePassword" class="col-md-4 text-right">Password</label>
                        <div class="col-md-8">
                            <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
