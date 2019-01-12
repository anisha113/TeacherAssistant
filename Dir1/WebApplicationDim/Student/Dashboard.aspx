<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplicationDim.Student.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2">
            <p class="panel-heading" style="font-size: xx-large">At A Glance</p>
            <div class="panel-body">
                <div class="form-horizontal">
                    <div class="table-responsive" runat="server" style="max-height: 600px; overflow-y: auto">
                        <asp:GridView runat="server" ID="gvCourse" CssClass="table table-striped"></asp:GridView>
                    </div>
                    <br />
                    <div class="list-group">
                        <a runat="server" href="~/Account/Manage" class="list-group-item">Account Detail</a>
                        <a runat="server" href="~/Student/Student_AddCourse" class="list-group-item">Add Course</a>
                        <a runat="server" href="~/Student/AttendanceMarksOverView.aspx" class="list-group-item">Attendance Marks Overview</a>
                        <a runat="server" href="~/Student/CtAssignmentMarksOverview.aspx" class="list-group-item">CT/Assignments Marks Overview</a>
                        <a runat="server" href="~/Student/AttendanceOverView.aspx" class="list-group-item">Attendance Overview</a>
                    </div>
                    <br />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
