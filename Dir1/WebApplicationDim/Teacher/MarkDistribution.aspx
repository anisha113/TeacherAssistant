<%@ Page Title="MarkDistribution" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MarkDistribution.aspx.cs" Inherits="WebApplicationDim.Teacher.MarkDistribution" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <h2 class="text-info text-center"></h2>
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2 ">
            <p class="panel-heading" style="font-size: xx-large">Mark Distribution</p>
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
                                <asp:Label runat="server" AssociatedControlID="txtAttendenceMark" CssClass="col-md-4 control-label pad">Attendence Mark</asp:Label>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" ID="txtAttendenceMark" CssClass="form-control" TextMode="SingleLine" />
                                </div>
                            </div>
                            <hr />
                            <div class="form-group">
                                <div>
                                    <asp:GridView CssClass="table table-striped" runat="server" ID="gvAttendance" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:Label Text="Start" runat="server" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hfattendancesectionid" Value='<%# Eval("id") %>' />
                                                    <asp:TextBox ID="txtStart" runat="server" Width="100%" Text='<%# Eval("start") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:Label Text="End" runat="server" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEnd" runat="server"  Width="100%" Text='<%# Eval("end") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:Label Text="Mark" runat="server" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtMark" runat="server"  Width="100%" Text='<%# Eval("mark") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="col-md-7">
                                    <asp:CheckBox Text="Mark This settings as Default." ID="cbDefault" runat="server" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-5 col-md-7">
                                    <asp:Button Text="Save" runat="server" ID="btnSave" CssClass="btn btn-default" OnClick="btnSave_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
