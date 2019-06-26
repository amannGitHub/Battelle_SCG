<%@ Page Title="Panelists Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="ReportPanelists.aspx.vb" Inherits="Battelle.ReportPanelists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:ImageButton ID="ImageButtonExportXLS" runat="server" ImageUrl="~/images/Excel_XLSX.png" Visible="False" />
    <br />
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>


    <asp:SqlDataSource ID="SqlDataSourcePanelist" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PanelistsGetByConference" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" DataSourceID="SqlDataSourcePanelist" GroupPanelPosition="Top" CellSpacing="-1" GridLines="Both">
        <ExportSettings OpenInNewWindow="True" FileName="Panelists" HideStructureColumns="True">
            <Excel Format="Xlsx" />
        </ExportSettings>
        <MasterTableView DataSourceID="SqlDataSourcePanelist" AutoGenerateColumns="False">
            <Columns>
                <telerik:GridBoundColumn DataField="PersonID" FilterControlAltText="Filter Person ID column" HeaderText="Person ID" SortExpression="PersonID" UniqueName="PersonID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FirstName" FilterControlAltText="Filter First Name column" HeaderText="First Name" SortExpression="FirstName" UniqueName="FirstName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Employer" FilterControlAltText="Filter Employer column" HeaderText="Employer" SortExpression="Employer" UniqueName="Employer">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

</asp:Content>