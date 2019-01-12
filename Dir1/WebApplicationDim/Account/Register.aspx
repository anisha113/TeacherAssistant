<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="WebApplicationDim.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %></h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Create a new account</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="PhoneNumber" CssClass="col-md-4 text-danger">Be carefull. * marked are not changeable later.</asp:Label>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ddlRegisterAs" CssClass="col-md-2 control-label pad">Register as</asp:Label>
            <div class="col-md-10">
                <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddlRegisterAs_SelectedIndexChanged" ID="ddlRegisterAs" Style="max-width: 280px" CssClass="form-control"
                    runat="server">
                    <asp:ListItem Text="Teacher" Value="2" />
                    <asp:ListItem Text="Student" Value="1" />
                </asp:DropDownList>
            </div>
        </div>
        <br />
        <div runat="server" id="divTeacher">
            <div class="form-group" id="divSalutaion" runat="server">
                <asp:Label runat="server" AssociatedControlID="ddlSalutation" CssClass="col-md-2 control-label pad">Salutation</asp:Label>
                <div class="col-md-10">
                    <asp:DropDownList ID="ddlSalutation" Style="max-width: 280px" CssClass="form-control" runat="server">
                    </asp:DropDownList>
                </div>
            </div>
            <br />

            <div class="form-group" id="divDesignation" runat="server">
                <asp:Label runat="server" AssociatedControlID="ddlDesignation" CssClass="col-md-2 control-label pad">Designation</asp:Label>
                <div class="col-md-10">
                    <asp:DropDownList ID="ddlDesignation" Style="max-width: 280px" CssClass="form-control" runat="server">
                    </asp:DropDownList>
                </div>
            </div>

            <br />
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="firstName" CssClass="col-md-2 control-label pad">First Name *</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="firstName" CssClass="form-control" TextMode="SingleLine" AutoPostBack="false" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="firstName"
                    CssClass="text-danger" ErrorMessage="The first name field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="lastName" CssClass="col-md-2 control-label pad">Last Name *</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="lastName" CssClass="form-control" TextMode="SingleLine" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="lastName"
                    CssClass="text-danger" ErrorMessage="The last name is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Sex" CssClass="col-md-2 control-label pad">Gender</asp:Label>
            <div class="col-md-10">
                <asp:DropDownList runat="server" ID="Sex" CssClass="form-control" Style="max-width: 280px">
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Other" Value="Other" />
                </asp:DropDownList>
            </div>
        </div>
        <br />
        <div id="divStudent" runat="server">
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="studentid" CssClass="col-md-2 control-label pad">Student ID *</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="studentid" CssClass="form-control" TextMode="SingleLine" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="studentid"
                        CssClass="text-danger" ErrorMessage="The Student ID is required." />
                </div>
            </div>
           
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="batch" CssClass="col-md-2 control-label pad">Batch *</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="batch" CssClass="form-control" TextMode="SingleLine" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="batch"
                        CssClass="text-danger" ErrorMessage="The Batch is required." />
                </div>
            </div>
           
        </div>

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="ddlVersity" CssClass="col-md-2 control-label pad">Select Versity *</asp:Label>
                    <div class="col-md-10">
                        <asp:DropDownList ID="ddlVersity" Style="max-width: 280px" CssClass="form-control"
                            runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVersity_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="ddlDepartment" CssClass="col-md-2 control-label pad">Select Department *</asp:Label>
                    <div class="col-md-10">
                        <asp:DropDownList ID="ddlDepartment" Style="max-width: 280px" CssClass="form-control"
                            runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <br />

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="userName" CssClass="col-md-2 control-label pad">Username *</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="userName" CssClass="form-control" TextMode="SingleLine" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="userName"
                    CssClass="text-danger" ErrorMessage="The username is required." />
            </div>
        </div>
        <br />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label pad">Email *</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="The email field is required." />
                <asp:RegularExpressionValidator CssClass="text-danger" ErrorMessage="This is not a valid email address."
                    ControlToValidate="Email" runat="server" ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label pad">Password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="The password field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label pad">Confirm password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" placeholder="Write the same password again"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
            </div>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="PhoneNumber" CssClass="col-md-2 control-label pad">Phone / Mobile number</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="PhoneNumber" CssClass="form-control" TextMode="SingleLine" AutoPostBack="false" />
            </div>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Address" CssClass="col-md-2 control-label pad">Address</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" Style="max-width: 280px" ID="Address" CssClass="form-control" AutoPostBack="false" TextMode="MultiLine" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-default" />
            </div>
        </div>
    </div>
</asp:Content>
