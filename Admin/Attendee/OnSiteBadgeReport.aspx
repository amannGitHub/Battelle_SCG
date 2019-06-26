<%@ Page Title="Onsite Badge Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="OnSiteBadgeReport.aspx.vb" Inherits="Battelle.OnSiteBadgeReport" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSourceAttendees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AttendanceOnSiteBadgeReport" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button Id="btnRefresh" Text="Refresh" OnClick="btnRefresh_Click" runat="server" Visible="false" />Badges given: <asp:Label ID="lblBadgeCount" runat="server"></asp:Label><br />
    Need badges:
    <asp:GridView ID="gvAttendeeList" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceAttendees" OnDataBound="gvAttendeeList_DataBound" OnRowDataBound="gvAttendeeList_RowDataBound" AutoGenerateColumns="False" CssClass="table table-striped" >
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />            
            <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="StateProvince" HeaderText="StateProvince" SortExpression="StateProvince" />
            <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
            <asp:BoundField DataField="RegisterDate" DataFormatString="{0:t}" HeaderText="Register Timestamp" SortExpression="RegisterDate" />
            <asp:BoundField DataField="RegistrationType" HeaderText="Registration Type" SortExpression="RegistrationType" />
            <asp:BoundField DataField="BoothNumber" HeaderText="Booth #" SortExpression="BoothNumber" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button id="btnBadged" Text="Badged" OnClick="btnBadged_Click" runat="server" />
                    <asp:HiddenField ID="hdnPersonID" Value='<%# Bind("PersonID")%>' runat="server" />
                    <asp:HiddenField ID="hdnConferenceID" Value='<%# Bind("ConferenceID")%>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="PersonID" DataNavigateUrlFormatString="~/Admin/Attendee/SingleBadge.aspx?id={0}" Target="_blank" Text="Print Badge" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceBadged" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AttendanceOnSiteBadgesGiven" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    Badges issued:
    <asp:GridView ID="gvAttendeeBadged" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceBadged" OnDataBound="gvAttendeeBadged_DataBound" AutoGenerateColumns="False" CssClass="table table-striped" >
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />            
            <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="StateProvince" HeaderText="StateProvince" SortExpression="StateProvince" />
            <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
            <asp:BoundField DataField="RegisterDate" DataFormatString="{0:t}" HeaderText="Register Timestamp" SortExpression="RegisterDate" />
            <asp:BoundField DataField="RegistrationType" HeaderText="Registration Type" SortExpression="RegistrationType" />
            <asp:BoundField DataField="BoothNumber" HeaderText="Booth #" SortExpression="BoothNumber" />
            <asp:HyperLinkField DataNavigateUrlFields="PersonID" DataNavigateUrlFormatString="~/Admin/Attendee/SingleBadge.aspx?id={0}" Target="_blank" Text="Print Badge" />
        </Columns>
    </asp:GridView>
</asp:Content>