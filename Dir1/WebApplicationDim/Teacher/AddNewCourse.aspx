<%@ Page Title="Creat a new course" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddNewCourse.aspx.cs" Inherits="WebApplicationDim.Teacher.AddCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var h3 = $('#<%:h3Success.ClientID %>');

            h3.delay(5000).fadeOut(1000);
        });
    </script>
    <div class="row">
        <h2 class="text-info text-center"></h2>
        <hr />
        <div class="panel panel-primary col-md-6 col-md-offset-3">
            <p class="panel-heading" style="font-size: xx-large">Create A New Course</p>
            <div class="panel-body">
                <div class="form-horizontal">

                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlVersity" CssClass="col-md-4 control-label pad">Select Versity</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlVersity" Style="max-width: 280px" CssClass="form-control" runat="server" 
                                        OnSelectedIndexChanged="ddlVersity_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlDepartment" CssClass="col-md-4 control-label pad">Select Department</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlDepartment" Style="max-width: 280px" CssClass="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPrefix" CssClass="col-md-4 control-label pad">Prefix</asp:Label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtPrefix" Style="max-width: 280px" CssClass="form-control" runat="server" PlaceHolder="IE: CSE">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtPrefix" runat="server" ErrorMessage="Field cannot be empty" ControlToValidate="txtPrefix" CssClass="text-danger"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtCourseNo" CssClass="col-md-4 control-label pad">Course No</asp:Label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtCourseNo" Style="max-width: 280px" CssClass="form-control" runat="server" PlaceHolder="IE: 2201">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtCourseNo" runat="server" ErrorMessage="Field cannot be empty" ControlToValidate="txtCourseNo"  CssClass="text-danger"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidatortxtCourseNo" runat="server" ErrorMessage="Value must be a number" ControlToValidate="txtCourseNo" Operator="DataTypeCheck" Type="Integer" CssClass="text-danger"></asp:CompareValidator>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPostfix" CssClass="col-md-4 control-label pad">Postfix</asp:Label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtPostfix" Style="max-width: 280px" CssClass="form-control" runat="server" PlaceHolder="IE: ACD">
                            </asp:TextBox>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtCourseTitle" CssClass="col-md-4 control-label pad">Course Title</asp:Label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtCourseTitle" Style="max-width: 280px" CssClass="form-control" runat="server" PlaceHolder="IE: Physics 1">
                            </asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtCourseTitle" runat="server" ErrorMessage="Field cannot be empty" ControlToValidate="txtCourseTitle"  CssClass="text-danger"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtCredit" CssClass="col-md-4 control-label pad">Credit</asp:Label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtCredit" Style="max-width: 280px" CssClass="form-control" runat="server" PlaceHolder="IE: 3.0">
                            </asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtCredit" runat="server" ErrorMessage="Field cannot be empty" ControlToValidate="txtCredit"  CssClass="text-danger"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <div class="col-md-offset-4 col-md-8">
                            <asp:Button Text="Create" runat="server" ID="btnCreate" CssClass="btn btn-default" OnClick="btnCreate_Click" />
                        </div>
                    </div>
                    <div>
                        <div class="col-md-offset-4 col-md-8">
                            <h3 class="text-info text-centre" runat="server" id="h3Success">Course Created</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
