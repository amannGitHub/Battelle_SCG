<%@ Page Title="Booth Staff List" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="BoothStaffList.aspx.vb" Inherits="Battelle.BoothStaffList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
    <asp:SqlDataSource ID="SqlDataSourceBoothStaff" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothStaffGetByConference" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
     </asp:SqlDataSource>

      <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowSorting="True" DataSourceID="SqlDataSourceBoothStaff" GroupPanelPosition="Top" AutoGenerateColumns="False" ShowGroupPanel="True">
        <ExportSettings FileName="ExhibitorExport" Excel-Format="Xlsx">
<Excel Format="Xlsx"></Excel>
        </ExportSettings>
        <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True" AllowDragToGroup="True">
        </ClientSettings>
        <MasterTableView DataKeyNames="PersonID" DataSourceID="SqlDataSourceBoothStaff" CommandItemDisplay="Top" CommandItemSettings-ShowAddNewRecordButton="False" CommandItemSettings-ShowExportToExcelButton="True">
<CommandItemSettings ShowAddNewRecordButton="False" ShowExportToExcelButton="True"></CommandItemSettings>
            <Columns>
                <telerik:GridBoundColumn DataField="BoothNumber" DataType="System.Int32" FilterControlAltText="Filter BoothNumber column" HeaderText="Booth Number" SortExpression="BoothNumber" UniqueName="BoothNumber">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FirstName" FilterControlAltText="Filter FirstName column" HeaderText="FirstName" SortExpression="First Name" UniqueName="FirstName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LastName" FilterControlAltText="Filter LastName column" HeaderText="LastName" SortExpression="Last Name" UniqueName="LastName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Employer" FilterControlAltText="Filter Employer column" HeaderText="Employer" SortExpression="Employer" UniqueName="Employer">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhoneNum" FilterControlAltText="Filter PhoneNum column" HeaderText="PhoneNum" SortExpression="PhoneNum" UniqueName="PhoneNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AddressLine1" FilterControlAltText="Filter AddressLine1 column" HeaderText="AddressLine1" SortExpression="AddressLine1" UniqueName="AddressLine1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AddressLine2" FilterControlAltText="Filter AddressLine2 column" HeaderText="AddressLine2" SortExpression="AddressLine2" UniqueName="AddressLine2">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AddressLine3" FilterControlAltText="Filter AddressLine3 column" HeaderText="AddressLine3" SortExpression="AddressLine3" UniqueName="AddressLine3">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="City" FilterControlAltText="Filter City column" HeaderText="City" SortExpression="City" UniqueName="City">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="StateProvince" FilterControlAltText="Filter StateProvince column" HeaderText="StateProvince" SortExpression="StateProvince" UniqueName="StateProvince">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ZipPostal" FilterControlAltText="Filter ZipPostal column" HeaderText="ZipPostal" SortExpression="ZipPostal" UniqueName="ZipPostal">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Country" FilterControlAltText="Filter Country column" HeaderText="Country" SortExpression="Country" UniqueName="Country">
                </telerik:GridBoundColumn>
                
                
            </Columns>
        </MasterTableView>
     </telerik:RadGrid>
</asp:Content>
