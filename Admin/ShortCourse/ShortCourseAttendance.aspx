<%@ Page Title="Short Course Attendance" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="ShortCourseAttendance.aspx.vb" Inherits="Battelle.ShortCourseAttendance" EnableEventValidation="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
    <asp:SqlDataSource ID="SqlDataSourceShortCourse" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCoursePersonGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="btnExport" runat="server" Text="Export to Excel" CssClass="btn btn-default" Visible="False" />
    <asp:GridView ID="gvShortCourse" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceShortCourse" CssClass="table table-striped">
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
            <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="ReservationDate" HeaderText="Reservation Date" SortExpression="ReservationDate" />
            <asp:BoundField DataField="CourseName" HeaderText="Course Name" SortExpression="CourseName" />
            <asp:BoundField DataField="GroupName" HeaderText="Group Name" SortExpression="GroupName" />
        </Columns>
    </asp:GridView>
</asp:Content>
