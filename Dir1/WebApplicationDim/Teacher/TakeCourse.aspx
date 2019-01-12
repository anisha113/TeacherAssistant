<%@ Page Title="Add A Course" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TakeCourse.aspx.cs" Inherits="WebApplicationDim.Teacher.TakeCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var h2 = $('#<%:h2Success.ClientID %>');
            h2.delay(5000).fadeOut(1000);
            var h2fail = $('#<%:h2SuccessFailed.ClientID %>');
            h2fail.delay(5000).fadeOut(1000);
            var close = $('#<%:CloseSuccess.ClientID %>');
            close.delay(5000).fadeOut(1000);
            var open = $('#<%:OpenSuccess.ClientID %>');
            open.delay(5000).fadeOut(1000);
            var drop = $('#<%:DropSuccess.ClientID %>');
            drop.delay(5000).fadeOut(1000);
        });
    </script>
    <div class="row">
        <hr />
        <div class="panel panel-primary col-md-7 col-md-offset-2">
            <p class="panel-heading" style="font-size: xx-large">Add a course</p>
            <div class="panel-body">
                <div class="form-horizontal">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlVersity" CssClass="col-md-4 control-label pad">Select Versity</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlVersity" Style="max-width: 280px" CssClass="form-control" runat="server"
                                        AutoPostBack="True" OnSelectedIndexChanged="ddlVersity_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlDepartment" CssClass="col-md-4 control-label pad">Select Department</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlDepartment" Style="max-width: 280px" CssClass="form-control" runat="server"
                                        AutoPostBack="True" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlCourseTitle" CssClass="col-md-4 control-label pad">Select Course</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlCourseTitle" Style="max-width: 280px" CssClass="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="form-group">

                        <asp:Label runat="server" AssociatedControlID="ddlDegree" CssClass="col-md-4 control-label pad">Select Degree</asp:Label>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlDegree" Style="max-width: 280px" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlSession" CssClass="col-md-4 control-label pad">Select Session</asp:Label>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlSession" Style="max-width: 280px" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlSession_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlYear" CssClass="col-md-4 control-label pad">Select Year</asp:Label>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlYear" Style="max-width: 280px" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlTerm" CssClass="col-md-4 control-label pad">Select Term</asp:Label>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlTerm" Style="max-width: 280px" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <div class="col-md-offset-4 col-md-8">
                            <asp:Button Text="Procced" runat="server" ID="btnSelect" CssClass="btn btn-default" OnClick="btnSelect_Click" />
                        </div>
                    </div>
                    <div>
                        <div class="col-md-offset-4 col-md-8">
                            <h2 class="text-info text-centre" runat="server" id="h2Success">Course Taken</h2>
                        </div>
                    </div>
                    <div>
                        <div class="col-md-offset-4 col-md-8">
                            <h2 class="text-info text-centre" runat="server" id="h2SuccessFailed">Course exist already</h2>
                        </div>
                    </div>
                    <div class="form-group">
                        <br />
                        <div class="col-md-offset-4 col-md-8">
                            <a runat="server" class="btn btn-primary" href="/Teacher/AddNewCourse">Create A New Course</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-primary col-md-7 col-md-offset-2">
            <p class="panel-heading" style="font-size: xx-large">Open/Close a course</p>
            <div class="panel-body">
                <div class="form-horizontal">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                           
                           
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlDropSession" CssClass="col-md-4 control-label pad">Select Session</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlDropSession" Style="max-width: 280px" CssClass="form-control" runat="server" 
                                        OnSelectedIndexChanged="ddlDropSession_SelectedIndexChanged" AutoPostBack ="true">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                             <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlAction" CssClass="col-md-4 control-label pad">Select Action</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlAction" Style="max-width: 280px" CssClass="form-control" runat="server" 
                                        OnSelectedIndexChanged="ddlAction_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Close Open Courses" Value="1" />
                                        <asp:ListItem Text="Open Close Courses" Value="2"/>
                                        <asp:ListItem Text="Drop Courses" Value="3" Enabled="false" />
                                    </asp:DropDownList>
                                    <br />
                                    <asp:Label ID="txtDropWarning" Text="Becareful Drop action Can't be undone." runat="server" CssClass="text-danger" />
                                </div>
                            </div>
                            <br />
                             <div class="form-group">
                                <div class="col-md-8 col-md-offset-4" style="max-height:300px;overflow-y:auto">
                                    <asp:CheckBoxList runat="server" style="max-height:none; height:100%; max-width:280px; width:100%"  CssClass="form-control" ID="cblCourseName">
                                    </asp:CheckBoxList> 
                                </div>
                            </div>
                            
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="form-group">
                        <div class="col-md-offset-4 col-md-8">
                            <asp:Button Text="Procced" runat="server" ID="ButtonProcced" CssClass="btn btn-default" OnClick="ButtonProcced_Click" />
                        </div>
                    </div>
                    <div>
                        <div class="col-md-offset-4 col-md-8">
                            <h2 class="text-info text-centre" runat="server" id="CloseSuccess">Course Closed</h2>
                        </div>
                    </div>
                    <div>
                        <div class="col-md-offset-4 col-md-8">
                            <h2 class="text-info text-centre" runat="server" id="OpenSuccess">Course Opend</h2>
                        </div>
                    </div>
                    <div>
                        <div class="col-md-offset-4 col-md-8">
                            <h2 class="text-info text-centre" runat="server" id="DropSuccess">Course Droped</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
