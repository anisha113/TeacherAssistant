<%@ Page Title="Input marks" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InputMarks.aspx.cs" Inherits="WebApplicationDim.Teacher.InputMarks" %>

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
                                        OnSelectedIndexChanged="ddlSelectCourse_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <asp:Label Text="Select CT/Assignment" runat="server" AssociatedControlID="ddlCtAss" CssClass="col-md-4 control-label" />
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlCtAss" Style="max-width: 280px" CssClass="form-control" runat="server" 
                                        OnSelectedIndexChanged="ddlCtAss_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div runat="server" id="divgv">
                                <asp:GridView runat="server" ID="gvCtAss" AutoGenerateColumns="false" Width="100%" GridLines="Horizontal" CellPadding="5">
                                    <Columns>
                                            <asp:BoundField HeaderText="StudentID" DataField="StudentID" HeaderStyle-BackColor="#FFFFFF"
                                                ItemStyle-BackColor="#FFFFFF" />
                                            <asp:BoundField HeaderText="Name" DataField="Name" HeaderStyle-BackColor="#FFFFFF"
                                                ItemStyle-BackColor="#FFFFFF" />
                                            <asp:TemplateField HeaderStyle-BackColor="#FFFFFF" ItemStyle-BackColor="#FFFFFF">
                                                <HeaderTemplate>
                                                    <asp:Label Text="Marks" runat="server" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Eval("Marks") %>' ID="txtMark" />
                                                    <asp:HiddenField runat="server" ID="hfMarkId" Value='<%# Eval("MarkID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                </asp:GridView>
                                <br />
                                <div class="col-md-3 col-md-offset-5">
                                    <asp:Button ID="btnGvSave" CssClass="btn btn-default" Text="Save" runat="server" OnClick="btnGvSave_Click"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
