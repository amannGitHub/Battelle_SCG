<%@ Page Title="Exhibitor Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="ExhibitorReport.aspx.vb" Inherits="Battelle.ExhibitorReport" %>
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
    <p><b>Note:</b> Before sending a list to the exhibit decorator, filter the Booth Number column for <i>NotIsNull</i> to remove any sponsors that have not reserved a booth.</p>
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowSorting="True" DataSourceID="SqlDataSourceExhibitors" GroupPanelPosition="Top" AutoGenerateColumns="False">
        <ExportSettings FileName="ExhibitorExport" HideStructureColumns="True" OpenInNewWindow="True">
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
                <telerik:GridBoundColumn DataField="SponsorType" FilterControlAltText="Filter Sponsor column" HeaderText="Sponsor Type" SortExpression="SponsorType" UniqueName="SponsorType">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TotalExpenses" DataType="System.Decimal" FilterControlAltText="Filter TotalExpenses column" HeaderText="Total Expenses" ReadOnly="True" SortExpression="TotalExpenses" UniqueName="TotalExpenses" DataFormatString="{0:c}">
                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AmountPaid" DataType="System.Decimal" FilterControlAltText="Filter AmountPaid column" HeaderText="Paid to Date" ReadOnly="True" SortExpression="AmountPaid" UniqueName="AmountPaid" DataFormatString="{0:c}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ExhibBalance" DataType="System.Decimal" FilterControlAltText="Filter ExhibBalance column" HeaderText="Balance" ReadOnly="True" SortExpression="ExhibBalance" UniqueName="ExhibBalance" DataFormatString="{0:c}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ParticipationID" FilterControlAltText="Filter ParticipationID column" HeaderText="POC Participation Code" SortExpression="ParticipationID" UniqueName="ParticipationID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FirstName" FilterControlAltText="Filter FirstName column" HeaderText="FirstName" SortExpression="FirstName" UniqueName="FirstName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LastName" FilterControlAltText="Filter LastName column" HeaderText="LastName" SortExpression="LastName" UniqueName="LastName">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="PersonID" DataType="System.Int32" FilterControlAltText="Filter PersonID column" HeaderText="PersonID" ReadOnly="True" SortExpression="PersonID" UniqueName="PersonID" Visible="False">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="POCAddressLine1" FilterControlAltText="Filter POCAddressLine1 column" HeaderText="POC Address Line 1" SortExpression="POCAddressLine1" UniqueName="POCAddressLine1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="POCAddressLine2" FilterControlAltText="Filter POCAddressLine2 column" HeaderText="POC Address Line 2" SortExpression="POCAddressLine2" UniqueName="POCAddressLine2">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="POCAddressLine3" FilterControlAltText="Filter POCAddressLine3 column" HeaderText="POC AddressLine 3" SortExpression="POCAddressLine3" UniqueName="POCAddressLine3">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="POCCity" FilterControlAltText="Filter POCCity column" HeaderText="POCCity" SortExpression="POC City" UniqueName="POCCity">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="POCStateProvince" FilterControlAltText="Filter POCStateProvince column" HeaderText="POC State Province" SortExpression="POCStateProvince" UniqueName="POCStateProvince">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="POCZipPostal" FilterControlAltText="Filter POCZipPostal column" HeaderText="POC Zip Postal" SortExpression="POCZipPostal" UniqueName="POCZipPostal">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="POCCountry" FilterControlAltText="Filter POCCountry column" HeaderText="POC Country" SortExpression="POCCountry" UniqueName="POCCountry">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="POCPhoneNum" FilterControlAltText="Filter POCPhoneNum column" HeaderText="POC Phone #" SortExpression="POCPhoneNum" UniqueName="POCPhoneNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="POCCellNum" FilterControlAltText="Filter POCCellNum column" HeaderText="POC Cell #" SortExpression="POCCellNum" UniqueName="POCCellNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="OrganizationID" FilterControlAltText="Filter OrganizationID column" HeaderText="Organization ID" SortExpression="OrganizationID" UniqueName="OrganizationID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AddressLine1" FilterControlAltText="Filter AddressLine1 column" HeaderText="Address Line 1" SortExpression="AddressLine1" UniqueName="AddressLine1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AddressLine2" FilterControlAltText="Filter AddressLine2 column" HeaderText="Address Line 2" SortExpression="AddressLine2" UniqueName="AddressLine2">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AddressLine3" FilterControlAltText="Filter AddressLine3 column" HeaderText="Address Line 3" SortExpression="AddressLine3" UniqueName="AddressLine3">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="City" FilterControlAltText="Filter City column" HeaderText="City" SortExpression="City" UniqueName="City">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="StateProvince" FilterControlAltText="Filter StateProvince column" HeaderText="State Province" SortExpression="StateProvince" UniqueName="StateProvince">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ZipPostal" FilterControlAltText="Filter ZipPostal column" HeaderText="Zip Postal" SortExpression="ZipPostal" UniqueName="ZipPostal">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Country" FilterControlAltText="Filter Country column" HeaderText="Country" SortExpression="Country" UniqueName="Country">
                </telerik:GridBoundColumn>

                
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>                        
</asp:Content>
