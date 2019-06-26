<%@ Page Title="Short Course Overview" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="ShortCourseOverview.aspx.vb" Inherits="Battelle.ShortCourseOverview" %>

<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%= Page.Title %></h1>

    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>

    <asp:SqlDataSource ID="SqlDataSourceAttendance" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseAttendanceGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceShortCourses" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseAttendanceGetByCourse" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <h2>Attendance</h2>

    <asp:GridView ID="gvAttendance" DataSourceID="SqlDataSourceAttendance" runat="server" AutoGenerateColumns="true" CssClass="table"></asp:GridView>

    <h2>Attendees</h2>

    <asp:GridView ID="gvShortCourse" DataSourceID="SqlDataSourceShortCourses" runat="server" AutoGenerateColumns="false" CssClass="table">
        <Columns>
            <asp:BoundField DataField="CourseName" HeaderText="Course Name" ReadOnly="True" SortExpression="CourseName" /> 
            <asp:BoundField DataField="LastName" HeaderText="Last Name" ReadOnly="True" SortExpression="LastName" /> 
            <asp:BoundField DataField="FirstName" HeaderText="First Name" ReadOnly="True" SortExpression="FirstName" />
            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" /> 
            <asp:BoundField DataField="Employer" HeaderText="Organization" ReadOnly="True" SortExpression="Employer" /> 
        </Columns>
    </asp:GridView>
</asp:Content>