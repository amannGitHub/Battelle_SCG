<%@ Page Title="Attendance Count" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="AttendanceCount.aspx.vb" Inherits="Battelle.AttendanceCount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
    <asp:SqlDataSource ID="SqlDataSourceAttendance" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="RegistrationCountGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceAttendance" CellPadding="0" CssClass="table">
        <Columns>
            <asp:BoundField DataField="BoothStaff" HeaderText="BoothStaff" ReadOnly="True" SortExpression="BoothStaff" />
            <asp:BoundField DataField="Attendance" HeaderText="Attendance" ReadOnly="True" SortExpression="Attendance" />
            <asp:BoundField DataField="ShortCourse" HeaderText="ShortCourse" ReadOnly="True" SortExpression="ShortCourse" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceRegType" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AttendanceTypeCountGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvRegType" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="0" CssClass="table" DataSourceID="SqlDataSourceRegType">
        <Columns>
            <asp:BoundField DataField="RegistrationType" HeaderText="RegistrationType" SortExpression="RegistrationType" />
            <asp:BoundField DataField="RegCount" HeaderText="RegCount" ReadOnly="True" SortExpression="RegCount" />
        </Columns>
    </asp:GridView>
</asp:Content>
