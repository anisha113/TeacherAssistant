<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplicationDim.Teacher.Dashboard" %>

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
                        <a runat="server" href="~/Teacher/TakeCourse" class="list-group-item">Add/Remove/Close Course</a>
                        <a runat="server" href="~/Teacher/ApproveStudent" class="list-group-item">Approve/Disapprove Student</a>
                        <a runat="server" href="~/Teacher/TakeAttendance2" class="list-group-item">Take Attendace</a>
                        <a runat="server" href="~/Teacher/AttendanceOverView.aspx" class="list-group-item">Attendance Overview</a>
                        <a runat="server" href="~/Teacher/MarkDistribution" class="list-group-item">Marks Distribution</a>
                        <a runat="server" href="~/Teacher/ClassTestAssignment" class="list-group-item">Class Test/Assignment</a>
                        <%--<a runat="server" href="~/Info/Marks%20Distribution%20Overview" class="list-group-item">Marks Distribution Overview</a>--%>
                       <a runat="server" href="~/Teacher/InputMarks" class="list-group-item">Marks Input</a>
                       <a runat="server" href="~/Teacher/MarksOverview" class="list-group-item">Marks Overview</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
