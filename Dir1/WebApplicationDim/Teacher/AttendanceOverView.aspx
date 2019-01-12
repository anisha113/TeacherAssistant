<%@ Page Title="Attendence Overview" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AttendanceOverView.aspx.cs" Inherits="WebApplicationDim.Teacher.AttendanceOverView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2">
            <p class="panel-heading" style="font-size: xx-large">Attendance Overview</p>
            <div class="panel-body" id="panelBody">
                <div class="form-horizontal">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <asp:Label Text="Select Course" AssociatedControlID="ddlSelectCourse" CssClass="col-md-4 control-label pad" runat="server" />
                                <div class="col-md-4 pad">
                                    <asp:DropDownList runat="server" ID="ddlSelectCourse" Style="max-width: 280px" CssClass="form-control"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlSelectCourse_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <div style="width: 100%; height: 100%; overflow: auto">
                                    <asp:GridView runat="server" ID="gvAttendence" AutoGenerateColumns="true" Width="100%" GridLines="Horizontal" CellPadding="5">
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
