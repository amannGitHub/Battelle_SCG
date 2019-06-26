<%@ Page Title="Exhibitor Organization ID Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="OrganizationIDReport.aspx.vb" Inherits="Battelle.OrganizationIDReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSourceExhibitors" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ExhibitorGetByConference" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowSorting="True" DataSourceID="SqlDataSourceExhibitors" GroupPanelPosition="Top" AutoGenerateColumns="False">
        <ExportSettings FileName="ExhibitorExport" Excel-Format="Xlsx">
<Excel Format="Xlsx"></Excel>
        </ExportSettings>
        <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
        </ClientSettings>
        <MasterTableView DataSourceID="SqlDataSourceExhibitors" CommandItemDisplay="Top" CommandItemSettings-ShowAddNewRecordButton="False" CommandItemSettings-ShowExportToExcelButton="True">
            <Columns>
                <telerik:GridBoundColumn DataField="Exhibitor" FilterControlAltText="Filter Exhibitor column" HeaderText="Exhibitor" SortExpression="Exhibitor" UniqueName="Exhibitor">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BoothNumber" DataType="System.Int32" FilterControlAltText="Filter BoothNumber column" HeaderText="Booth Number" SortExpression="BoothNumber" UniqueName="BoothNumber">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="OrganizationID" FilterControlAltText="Filter OrganizationID column" HeaderText="Organization ID" SortExpression="OrganizationID" UniqueName="OrganizationID">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</asp:Content>