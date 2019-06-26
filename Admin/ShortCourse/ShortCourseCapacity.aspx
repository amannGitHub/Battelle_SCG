<%@ Page Title="Short Course Capacity" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="ShortCourseCapacity.aspx.vb" Inherits="Battelle.ShortCourseCapacity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:ImageButton ID="ImageButtonExportXLS" runat="server" ImageUrl="~/images/Excel_XLSX.png" Visible="False" />
    <br />
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>


    <asp:SqlDataSource ID="SqlDataSourceShortCourse" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseAttendeeCountGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceShortCourse" GroupPanelPosition="Top" CellSpacing="-1" GridLines="Both" ShowGroupPanel="True">
        <ExportSettings OpenInNewWindow="True" FileName="BadgeList" HideStructureColumns="True">
            <Excel Format="Xlsx" />
        </ExportSettings>
        <MasterTableView DataSourceID="SqlDataSourceShortCourse" AutoGenerateColumns="False">
            <Columns>
                <telerik:GridBoundColumn DataField="GroupName" FilterControlAltText="Filter date column" HeaderText="Date" SortExpression="GroupName" UniqueName="GroupName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CourseName" FilterControlAltText="Filter Course Name column" HeaderText="Course" SortExpression="CourseName" UniqueName="CourseName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MaxCapacity" FilterControlAltText="Filter Max Capacity column" HeaderText="Max Capacity" SortExpression="MaxCapacity" UniqueName="MaxCapacity">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Attendees" FilterControlAltText="Filter Attendees column" HeaderText="Attendees" SortExpression="Attendees" UniqueName="Attendees">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</asp:Content>
