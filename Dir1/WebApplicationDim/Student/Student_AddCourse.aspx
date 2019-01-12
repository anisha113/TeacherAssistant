<%@ Page Title="Add a New Course" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Student_AddCourse.aspx.cs" Inherits="WebApplicationDim.Student.Student_AddCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var h2 = $('#<%:h2Success.ClientID %>');
            h2.delay(5000).fadeOut(1000);

            var hf = $('#<%:h2Fail.ClientID %>');
            hf.delay(5000).fadeOut(1000);

            <%--var hd = $('#<%:h2droped.ClientID %>');
            hd.delay(5000).fadeOut(1000);--%>
        });
    </script>
    <div class="row">
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2">
            <p class="panel-heading" style="font-size: xx-large">Add a course</p>
            <div class="panel-body">
                <div class="form-horizontal">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlCoruseName" CssClass="col-md-4 control-label pad">Select Course</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlCoruseName" Style="max-width: 280px" CssClass="form-control" runat="server"
                                        AutoPostBack="True" OnSelectedIndexChanged="ddlCoruseName_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlTeacherName" CssClass="col-md-4 control-label pad">Teacher Name</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlTeacherName" Style="max-width: 280px" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlTeacherName_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlSession" CssClass="col-md-4 control-label pad">Session</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlSession" Style="max-width: 280px" CssClass="form-control" runat="server">
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ErrorMessage="No teacher has taken this course yet."
                                        class="text-danger" ControlToValidate="ddlSession"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="form-group">
                        <div class="col-md-offset-4 col-md-8">
                            <asp:Button Text="ADD Course" runat="server" ID="btnAdd" CssClass="btn btn-default" OnClick="btnAdd_Click" />
                        </div>
                    </div>
                    <div>
                        <div class="col-md-offset-4 col-md-8">
                            <h2 class="text-info text-centre" runat="server" id="h2Success">Course Taken</h2>
                        </div>
                    </div>
                    <div>
                        <div class="col-md-offset-4 col-md-8">
                            <h2 class="text-info text-centre" runat="server" id="h2Fail">Course Already Taken</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="panel panel-primary col-md-8 col-md-offset-2">
            <p class="panel-heading" style="font-size: xx-large">Drop a course</p>
            <div class="panel-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlDropCoruseName" CssClass="col-md-4 control-label pad">Select Course</asp:Label>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlDropCoruseName" Style="max-width: 280px" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                            <br />
                            <asp:Label Text="Becareful, Drop action can't be undone." runat="server" class="text-danger" />
                             <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ErrorMessage="No course to drop :p" ControlToValidate="ddlDropCoruseName"
                                class="text-danger"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <div class="col-md-offset-4 col-md-8">
                            <asp:Button Text="DROP Course" runat="server" ID="btnDrop" CssClass="btn btn-default" OnClick="btnDrop_Click" />
                        </div>
                    </div>
                    <div>
                        <div class="col-md-offset-4 col-md-8">
                            <h2 class="text-info text-centre" runat="server" id="h2droped">Course Dropped</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
    </div>
</asp:Content>
