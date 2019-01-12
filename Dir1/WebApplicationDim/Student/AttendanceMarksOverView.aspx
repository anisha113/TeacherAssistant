<%@ Page Title="Att. Marks Overview" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AttendanceMarksOverView.aspx.cs" Inherits="WebApplicationDim.Student.AttendanceMarksOverView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div class="row">
        <h2 class="text-info text-center"></h2>
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2 ">
            <p class="panel-heading" style="font-size: xx-large">AttenDance Marks Overview</p>
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
                                <asp:Label runat="server" AssociatedControlID="txtAttmarks" CssClass="col-md-4 control-label pad">Attendence Mark</asp:Label>
                                <div class="col-md-8">
                                    <asp:Label ID="txtAttmarks" CssClass="control-label" runat="server" />
                                    <%--<asp:TextBox runat="server" ID="txtAttendenceMark" CssClass="form-control" TextMode="SingleLine" />--%>
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
                                                    <asp:Label Text='<%# Eval("start") %>' ID="txtStart" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:Label Text="End" runat="server" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label Text='<%# Eval("end") %>' ID="txtEnd" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:Label Text="Mark" runat="server" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label Text='<%# Eval("mark") %>' ID="txtMark" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
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
