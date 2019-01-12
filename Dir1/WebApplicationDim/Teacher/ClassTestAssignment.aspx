<%@ Page Title="ClassTest and Assignment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClassTestAssignment.aspx.cs" Inherits="WebApplicationDim.Teacher.ClassTestAssignment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <h2 class="text-info text-center"></h2>
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2 ">
            <p class="panel-heading" style="font-size: xx-large">Class Test/ Assignment</p>
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
                            <div>
                                <h2 class="text-info text-center">ADD CT/Assignment</h2>
                            </div>
                            <div class="form-group">
                                <asp:Label Text="CT/Assignment Name" runat="server" AssociatedControlID="txtName" CssClass="col-md-4 control-label" />
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtName" ToolTip="IE: Class test 1"/>
                                    <asp:RequiredFieldValidator ErrorMessage="This filed can't be left empty." ControlToValidate="txtName"
                                        CssClass="text-danger" runat="server" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <asp:Label Text="CT/Assignment Marks" runat="server" AssociatedControlID="txtMarks" CssClass="col-md-4 control-label" />
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtMarks" runat="server" ToolTip="IE: 30"/>
                                    <asp:RequiredFieldValidator ErrorMessage="This filed can't be left empty." ControlToValidate="txtMarks"
                                        CssClass="text-danger" runat="server" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-md-offset-4 col-md-2">
                                    <asp:Button Text="Save" CssClass="btn btn-default" ID="btnCtSave" runat="server" OnClick="btnCtSave_Click" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <div>
                                    <h2 class="text-info text-center">Summary</h2>
                                </div>
                                <hr />
                                <div runat="server" id="divp">
                                    <p class="text-align: center">You haven't taken any class test or assignment on this course yet. :P</p>
                                </div>
                                <div runat="server" id="divgv" style="width: 100%; height: 100%; overflow: auto">
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
