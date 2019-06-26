<%@ Page Title="Exhibitor Mailing List Fee Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="ExhibitorMailingListReport.aspx.vb" Inherits="Battelle.ExhibitorMailingListReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSourceExhibitors" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ExhibitorMailingListFeeByConferenceID" SelectCommandType="StoredProcedure">
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
                <telerik:GridBoundColumn DataField="SponsorType" FilterControlAltText="Filter Sponsor Type column" HeaderText="Sponsor Type" SortExpression="SponsorType" UniqueName="SponsorType">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FirstName" FilterControlAltText="Filter First name column" HeaderText="FirstName" SortExpression="FirstName" UniqueName="FirstName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LastName" FilterControlAltText="Filter Last name column" HeaderText="LastName" SortExpression="LastName" UniqueName="LastName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FeeType" FilterControlAltText="Fee Type column" HeaderText="FeeType" SortExpression="FeeType" UniqueName="FeeType">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ExhibBalance" FilterControlAltText="Exhibit Balance column" HeaderText="ExhibBalance" SortExpression="ExhibBalance" UniqueName="ExhibBalance">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</asp:Content>