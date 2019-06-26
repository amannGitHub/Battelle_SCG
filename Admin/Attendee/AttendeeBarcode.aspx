<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="AttendeeBarcode.aspx.vb" Inherits="Battelle.AttendeeBarcode" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceBarcode" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BarcodeGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceBarcode" GroupPanelPosition="Top">
        
        <ExportSettings FileName="BarCode" Excel-Format="Xlsx">
<Excel Format="Xlsx"></Excel>
        </ExportSettings>
        <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceBarcode"  CommandItemSettings-ShowAddNewRecordButton="False" CommandItemDisplay="Top" CommandItemSettings-ShowExportToExcelButton="True">
            <Columns>
                <telerik:GridBoundColumn DataField="PersonID" DataType="System.Int32" FilterControlAltText="Filter PersonID column" HeaderText="PersonID" ReadOnly="True" SortExpression="PersonID" UniqueName="PersonID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Desc" FilterControlAltText="Filter Desc column" HeaderText="Desc" ReadOnly="True" SortExpression="Desc" UniqueName="Desc">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TheBarCode" FilterControlAltText="Filter TheBarCode column" HeaderText="TheBarCode" ReadOnly="True" SortExpression="TheBarCode" UniqueName="TheBarCode">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</asp:Content>
