<%@ Page Title="Marks Overview" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MarksOverview.aspx.cs" Inherits="WebApplicationDim.Teacher.MarksOverview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <div class="row">
        <hr />
        <div class="panel panel-primary col-md-8 col-md-offset-2">
            <p class="panel-heading" style="font-size: xx-large">Marks Overview</p>
            <div class="panel-body">
                <div class="form-horizontal">
                    <asp:UpdatePanel runat="server">
                       <ContentTemplate>
                           <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlCourse" CssClass="col-md-4 control-label pad">Select Course</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlCourse" Style="max-width: 280px" CssClass="form-control" runat="server" 
                                        OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                            </div>
                           <br />
                             <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlTerm" CssClass="col-md-4 control-label pad">Select Term</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlTerm" Style="max-width: 280px" CssClass="form-control" runat="server" 
                                        OnSelectedIndexChanged="ddlTerm_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                             <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlSession" CssClass="col-md-4 control-label pad">Select Session</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlSession" Style="max-width: 280px" CssClass="form-control" runat="server" 
                                        OnSelectedIndexChanged="ddlSession_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                             <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="ddlStudentId" CssClass="col-md-4 control-label pad">Select Student ID</asp:Label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlStudentId" Style="max-width: 280px" CssClass="form-control" runat="server" 
                                        OnSelectedIndexChanged="ddlStudentId_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                            </div>
                           <br />
                           <asp:GridView runat="server"  ID="gvMarksOverview" CssClass="table table-striped table-hover" style="border-color:transparent" HeaderStyle-CssClass="text-info">

                           </asp:GridView>

                       </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
