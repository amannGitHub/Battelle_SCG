<%@ Page Title="Badge List Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="ReportBadge.aspx.vb" Inherits="Battelle.ReportBadge" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:ImageButton ID="ImageButtonExportXLS" runat="server" ImageUrl="~/images/Excel_XLSX.png" Visible="False" />
    <br />
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>


    <asp:SqlDataSource ID="SqlDataSourceBadge" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BadgeListGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceBadge" GroupPanelPosition="Top" CellSpacing="-1" GridLines="Both">
        <ExportSettings OpenInNewWindow="True" FileName="BadgeList" HideStructureColumns="True">
            <Excel Format="Xlsx" />
        </ExportSettings>
        <MasterTableView DataSourceID="SqlDataSourceBadge" AutoGenerateColumns="False">
            <Columns>
                <telerik:GridBoundColumn DataField="PersonID" FilterControlAltText="Filter PersonID column" HeaderText="PersonID" SortExpression="PersonID" UniqueName="PersonID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LastName" FilterControlAltText="Filter Last Name column" HeaderText="Last Name" SortExpression="LastName" UniqueName="LastName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FirstName" FilterControlAltText="Filter First Name column" HeaderText="First Name" SortExpression="FirstName" UniqueName="FirstName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Employer" FilterControlAltText="Filter Employer column" HeaderText="Employer" SortExpression="Employer" UniqueName="Employer">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AddressLine1" FilterControlAltText="Filter AddressLine1 column" HeaderText="AddressLine1" SortExpression="AddressLine1" UniqueName="AddressLine1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AddressLine2" FilterControlAltText="Filter AddressLine2 column" HeaderText="AddressLine2" SortExpression="AddressLine2" UniqueName="AddressLine2">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AddressLine3" FilterControlAltText="Filter AddressLine3 column" HeaderText="AddressLine3" SortExpression="AddressLine3" UniqueName="AddressLine3">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="City" FilterControlAltText="Filter City column" HeaderText="City" SortExpression="City" UniqueName="City">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="StateProvince" FilterControlAltText="Filter StateProvince column" HeaderText="State/Province" SortExpression="StateProvince" UniqueName="StateProvince">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Country" FilterControlAltText="Filter Country column" HeaderText="Country" SortExpression="Country" UniqueName="Country">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ZipPostal" FilterControlAltText="Filter ZipPostal column" HeaderText="Zip/Postal" SortExpression="ZipPostal" UniqueName="ZipPostal">
                </telerik:GridBoundColumn>
                <%--<telerik:GridBoundColumn DataField="PhoneNum" FilterControlAltText="Filter PhoneNum column" HeaderText="Phone #" SortExpression="PhoneNum" UniqueName="PhoneNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CellNum" FilterControlAltText="Filter CellNum column" HeaderText="Cell #" SortExpression="CellNum" UniqueName="CellNum">
                </telerik:GridBoundColumn>--%>
                <telerik:GridBoundColumn DataField="Attendee" FilterControlAltText="Filter Attendee column" HeaderText="Attendee" SortExpression="Attendee" UniqueName="Attendee">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PassDates" FilterControlAltText="Filter PassDates column" HeaderText="Pass Dates" SortExpression="PassDates" UniqueName="PassDates">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Poster" FilterControlAltText="Filter Poster column" HeaderText="Poster" SortExpression="Poster" UniqueName="Poster">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Platform" FilterControlAltText="Filter Platform column" HeaderText="Platform" SortExpression="Platform" UniqueName="Platform">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Chair" FilterControlAltText="Filter Chair column" HeaderText="Chair" SortExpression="Chair" UniqueName="Chair">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Booth" FilterControlAltText="Filter Booth column" HeaderText="Booth" SortExpression="Booth" UniqueName="Booth">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Panel" FilterControlAltText="Filter Panel column" HeaderText="Panel" SortExpression="Panel" UniqueName="Panel">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="OmitFromMassEmails" FilterControlAltText="Filter Opt Out column" HeaderText="Opt Out" SortExpression="OmitFromMassEmails" UniqueName="OmitFromMassEmails">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

</asp:Content>