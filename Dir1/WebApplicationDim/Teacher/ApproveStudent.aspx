<%@ Page Title="Approve Student" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApproveStudent.aspx.cs" Inherits="WebApplicationDim.Teacher.ApproveStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2">
            <p class="panel-heading" style="font-size: xx-large">Approve Student</p>
            <div class="panel-body">
                <div class="form-horizontal">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlCourseTitle" CssClass="col-md-4 control-label pad">Select Course</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlCourseTitle" Style="max-width: 280px" CssClass="form-control" runat="server"
                                        OnSelectedIndexChanged="ddlCourseTitle_SelectedIndexChanged" AutoPostBack="True">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <hr />
                            <h3 class="text-info text-center">Required Approval</h3>
                            <div class="form-group">
                                <div class="col-md-8 col-md-offset-4">
                                    <asp:CheckBox Text="Select All" runat="server" ID="cbSelectAll1" OnCheckedChanged="cbSelectAll1_CheckedChanged" AutoPostBack="true" />
                                </div>
                                <div class="col-md-8 col-md-offset-4" style="max-height: 300px; overflow-y: auto">
                                    <asp:CheckBoxList runat="server" CssClass="table table-striped table-hover" Style="max-height: none; height: 100%; max-width: 280px"
                                        ID="cblRequiedApprobval" CellPadding="10">
                                    </asp:CheckBoxList>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-offset-4 col-md-8">
                                    <asp:Button Text="Approve" runat="server" ID="btnApprovet" CssClass="btn btn-default" OnClick="btnApprovet_Click" />
                                </div>
                            </div>

                            <hr />
                            <h3 class="text-info text-center">Approved students</h3>
                            <div class="form-group">
                                <div class="col-md-8 col-md-offset-4">
                                    <asp:CheckBox Text="Select All" runat="server" ID="cbSelectAll2" OnCheckedChanged="cbSelectAll2_CheckedChanged" AutoPostBack="true" />
                                </div>
                                <div class="col-md-8 col-md-offset-4" style="max-height: 300px; overflow-y: auto">
                                    <asp:CheckBoxList runat="server" CssClass="table table-striped table-hover" Style="max-height: none; height: 100%; max-width: 280px" ID="cblApprovedStudent">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-4 col-md-8">
                                    <asp:Button Text="Disapprove" runat="server" ID="btnDisapprove" CssClass="btn btn-default" OnClick="btnDisapprove_Click" />
                                </div>
                            </div>
                            <hr />
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
