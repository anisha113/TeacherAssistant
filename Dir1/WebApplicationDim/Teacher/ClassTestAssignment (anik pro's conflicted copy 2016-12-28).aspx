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
                            <div class="form-group">
                                <div class="col-md-8 col-md-offset-4">
                                    <asp:RadioButtonList runat="server" ID="radioBtnList" OnSelectedIndexChanged="radioBtnList_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Take a new Class Test" Value="1" />
                                        <asp:ListItem Text="Take a new Assaignment" Value="2" />
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div runat="server" id="divCt" visible="false">
                                <div class="form-group">
                                    <asp:Label Text="Class Test Name" runat="server" AssociatedControlID="ddlCtName" CssClass="col-md-4 control-label" />
                                    <div class="col-md-8">
                                        <asp:DropDownList ID="ddlCtName" Style="max-width: 280px" CssClass="form-control" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <br />
                                <div class="form-group">
                                    <asp:Label Text="Class Test Marks" runat="server" AssociatedControlID="txtCtMarks" CssClass="col-md-4 control-label" />
                                    <div class="col-md-8">
                                        <asp:TextBox ID="txtCtMarks" runat="server" />
                                        <asp:RequiredFieldValidator ErrorMessage="This filed can't be left empty." ControlToValidate="txtCtMarks"
                                            CssClass="text-danger" runat="server" />
                                    </div>
                                </div>
                                <br />
                                <div class="form-group">
                                    <asp:Button Text="Save" ID="btnCtSave" runat="server" OnClick="btnCtSave_Click" />
                                </div>
                                <br />
                            </div>
                            <div runat="server" id="divAss" visible="false">
                                <div class="form-group">
                                    <asp:Label Text="Assignment Name" runat="server" AssociatedControlID="ddlAssName" CssClass="col-md-4 control-label" />
                                    <div class="col-md-8">
                                        <asp:DropDownList ID="ddlAssName" Style="max-width: 280px" CssClass="form-control" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <br />
                                <div class="form-group">
                                    <asp:Label Text="Class Test Marks" runat="server" AssociatedControlID="txtAssMarks" CssClass="col-md-4 control-label" />
                                    <div class="col-md-8">
                                        <asp:TextBox ID="txtAssMarks" runat="server" />
                                        <asp:RequiredFieldValidator ErrorMessage="This filed can't be left empty." ControlToValidate="txtAssMarks"
                                            CssClass="text-danger" runat="server" />
                                    </div>
                                </div>
                                <br />
                                <div class="form-group">
                                    <asp:Button Text="Save" ID="btnAssSave" runat="server" OnClick="btnAssSave_Click" />
                                </div>
                                <br />
                            </div>
                            <div class="form-group">
                                <div>
                                    <h2 class="text-info text-center">Summary</h2>
                                </div>
                                <hr />
                                <div runat="server" id="divp">
                                    <p>You haven't taken any class test or assignment on this course yet. :P</p>
                                </div>
                                <div runat="server" id="divgv">
                                    <asp:GridView runat="server" ID="gvCtAss" AutoGenerateColumns="true" Width="100%" GridLines="Horizontal" CellPadding="5">
                                    </asp:GridView>
                                    <br />
                                    <div class="col-md-3 col-md-offset-5">
                                        <asp:Button ID="btnGvSave" CssClass="btn btn-default" Text="Save" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
