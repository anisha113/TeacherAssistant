<%@ Page Title="Take Attendance" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TakeAttendance.aspx.cs" Inherits="WebApplicationDim.Teacher.TakeAttendence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../Scripts/gridviewScroll.min.js"></script>
    <link href="../Scripts/GridviewScroll.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            gridviewScroll();
        });
        var prm = Sys.WebForms.PageRequestManager.getInstance();

        prm.add_endRequest(function () {
            gridviewScroll();
        });

        (window).resize(function () {
            gridviewScroll();
        });

        function gridviewScroll() {
            var w = panelBody.clientWidth;
            gridView1 = $('#<%: gvTakeAttendence.ClientID %>').gridviewScroll({
                width: w,
                height: 200,
                wheelstep: 20,
                headerrowcount: 1,
                freezesize: 2
            });
        }
    </script>
    <div class="row">
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2">
            <p class="panel-heading" style="font-size: xx-large">Take Attendance</p>
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
                                <asp:Label Text="Select Date" AssociatedControlID="txtDate" CssClass="col-md-4 control-label pad" runat="server" />
                                <div class="col-md-4 pad">
                                    <asp:TextBox runat="server" ID="txtDate" TextMode="Date" Style="max-width: 280px" OnTextChanged="txtDate_TextChanged" AutoPostBack="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label Text="Select Date" AssociatedControlID="txtDate" CssClass="col-md-4 control-label pad" runat="server" Visible="false" />
                                <div class="col-md-4 pad">
                                    <asp:RadioButtonList runat="server" ID="cblCalssNumber" Visible="false">
                                        <asp:ListItem Text="Single class" Value="1" Selected="True" />
                                        <asp:ListItem Text="Double class" Value="2" />
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="form-group">
                                <div runat="server">
                                    <asp:GridView ID="gvTakeAttendence" runat="server" Width="100%" AutoGenerateColumns="false" GridLines="None"
                                        OnRowDataBound="gvTakeAttendence_RowDataBound">
                                        <Columns>
                                            <asp:BoundField HeaderText="StudentID" DataField="StudentID" ItemStyle-BackColor="#EFEFEF" />
                                            <asp:BoundField HeaderText="Name" DataField="Name" ItemStyle-BackColor="#EFEFEF" />
                                            <asp:TemplateField HeaderStyle-BackColor="#FFFFFF" ItemStyle-BackColor="#FFFFFF">
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="cbSelecteds" runat="server" AutoPostBack="true" OnCheckedChanged="cbSelecteds_CheckedChanged" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbSelected1" runat="server" />
                                                    <asp:HiddenField runat="server" ID="hfMarkId" Value='<%# Eval("markid") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="GridviewScrollHeader" />
                                        <RowStyle CssClass="GridviewScrollItem" />
                                        <PagerStyle CssClass="GridviewScrollPager" />
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="form-group">
                        <div class="col-md-3 col-md-offset-5">
                            <asp:Button ID="btnSave" Text="Save" CssClass="btn btn-default" runat="server" OnClick="btnSave_Click" />
                        </div>
                    </div>
                    <br />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
