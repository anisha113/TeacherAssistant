<%@ Page Title="Register Course" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterCourse.aspx.cs" Inherits="WebApplicationDim.Student.RegisterCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<br/>
	<style type="text/css">
		select.form-control{
			max-width:280px;
		}
	</style>
	<script type="text/javascript">
        $(document).ready(function () {
            var h2 = $('#<%:h2Success.ClientID %>');

            h2.delay(5000).fadeOut(1000);
        });
	</script>
	<div class="row">
		<div class="panel panel-primary col-md-6 col-md-offset-3">
			<p class="panel-heading" style="font-size:xx-large">
				Register Course
			</p>
			<div class="panel-body form-horizontal">
				<asp:UpdatePanel runat="server">
					<ContentTemplate>

						<div class="form-group">
							<label class="col-md-4 text-right">
								Versity
							</label>
							<div class="col-md-8">
								<asp:Label runat="server" ID="lblVersity">versity</asp:Label>
							</div>
						</div>
						<br />

						<div class="form-group">
							<label class="col-md-4 text-right">Department</label>
							<div class="col-md-8">
								<asp:Label runat="server" ID="lblDepartment">Department</asp:Label>
							</div>
						</div>
						<br />

						<div class="form-group">
							<asp:Label AssociatedControlID="ddlDegree" CssClass="col-md-4 control-label" runat="server">Degree</asp:Label>
							<div class="col-md-8">
								<asp:DropDownList runat="server" ID="ddlDegree" CssClass="form-control"></asp:DropDownList>
							</div>
						</div>
						<br />

						<div class="form-group">
							<asp:Label AssociatedControlID="ddlYear" CssClass="col-md-4 control-label" runat="server">Year</asp:Label>
							<div class="col-md-8">
								<asp:DropDownList runat="server" ID="ddlYear" CssClass="form-control"></asp:DropDownList>
							</div>
						</div>
						<br />

						<div class="form-group">
							<asp:Label AssociatedControlID="ddlSession" CssClass="col-md-4 control-label" runat="server">Session</asp:Label>
							<div class="col-md-8">
								<asp:DropDownList runat="server" ID="ddlSession" CssClass="form-control"></asp:DropDownList>
							</div>
						</div>
						<br />


						<div class="form-group">
							<asp:Label AssociatedControlID="ddlTerm" CssClass="col-md-4 control-label" runat="server">Term</asp:Label>
							<div class="col-md-8">
								<asp:DropDownList runat="server" ID="ddlTerm" CssClass="form-control"></asp:DropDownList>
							</div>
						</div>
						<br />

						<div class="form-group">
							<asp:Label AssociatedControlID="ddlTeacher" CssClass="col-md-4 control-label" runat="server">Teacher</asp:Label>
							<div class="col-md-8">
								<asp:DropDownList runat="server" ID="ddlTeacher" CssClass="form-control"></asp:DropDownList>
							</div>
						</div>
						<br />

						<div class="form-group">
							<asp:Label AssociatedControlID="ddlCourse" CssClass="col-md-4 control-label" runat="server">Course</asp:Label>
							<div class="col-md-8">
								<asp:DropDownList runat="server" ID="ddlCourse" CssClass="form-control"></asp:DropDownList>
							</div>
						</div>
						<br />

						<div class="form-group">
							<div class="col-md-offset-4 col-md-8">
								<asp:Button Text="Request Registration" runat="server" ID="btnReqRegi" CssClass="btn btn-default" />
							</div>
						</div>
						<div>
							<div class="col-md-offset-4 col-md-8">
								<h2 class="text-info text-centre" runat="server" id="h2Success">Requested</h2>
							</div>
						</div>

						
					</ContentTemplate>
				</asp:UpdatePanel>
			</div>
		</div>
	</div>
</asp:Content>
