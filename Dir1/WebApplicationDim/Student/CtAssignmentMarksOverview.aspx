<%@ Page Title="CT/AssignmentMarks" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CtAssignmentMarksOverview.aspx.cs" Inherits="WebApplicationDim.Student.CtAssignmentMarksOverview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <h2 class="text-info text-center"></h2>
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2 ">
            <p class="panel-heading" style="font-size: xx-large">Class Test/ Assignment Marks</p>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <asp:Label Text="Select Course" runat="server" AssociatedControlID="ddlSelectCourse" CssClass="col-md-4 control-label" />
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlSelectCourse" Style="max-width: 280px" CssClass="form-control" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlSelectCourse_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <div runat="server" id="divgv">
                                    <asp:GridView runat="server" ID="gvCtAss" AutoGenerateColumns="true" Width="100%" GridLines="Horizontal" CellPadding="5">
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
