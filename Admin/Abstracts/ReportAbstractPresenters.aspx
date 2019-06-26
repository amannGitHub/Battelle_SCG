<%@ Page Title="Abstract Presenter Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="ReportAbstractPresenters.aspx.vb" Inherits="Battelle.ReportAbstractPresenters" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
            <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
    <asp:SqlDataSource ID="SqlDataSourceReport" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractPresentersGetByConference" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
    <asp:ImageButton ID="ImageButtonExportXLS" runat="server" ImageUrl="~/images/Excel_XLSX.png" Visible="False" />
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceReport" GroupPanelPosition="Top" CellSpacing="-1" GridLines="Both">
        <ExportSettings OpenInNewWindow="True" FileName="AbstractPresenters" HideStructureColumns="True">
        <Excel Format="Xlsx" />
        </ExportSettings>
        <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
        </ClientSettings>
        <MasterTableView DataSourceID="SqlDataSourceReport" AutoGenerateColumns="False">
            <Columns>
                <telerik:GridBoundColumn DataField="ConferenceID" DataType="System.Int32" FilterControlAltText="Filter ConferenceID column" HeaderText="ConferenceID" SortExpression="ConferenceID" UniqueName="ConferenceID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AbstractID" DataType="System.Int32" FilterControlAltText="Filter AbstractID column" HeaderText="AbstractID" ReadOnly="True" SortExpression="AbstractID" UniqueName="AbstractID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AbstractCode" DataType="System.Int32" FilterControlAltText="Filter AbstractCode column" HeaderText="AbstractCode" SortExpression="AbstractCode" UniqueName="AbstractCode">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Title" FilterControlAltText="Filter Title column" HeaderText="Title" SortExpression="Title" UniqueName="Title">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AuthorList" FilterControlAltText="Filter AuthorList column" HeaderText="AuthorList" SortExpression="AuthorList" UniqueName="AuthorList">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopicCode" FilterControlAltText="Filter TopicCode column" HeaderText="TopicCode" SortExpression="TopicCode" UniqueName="TopicCode">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SessionCode" FilterControlAltText="Filter SessionCode column" HeaderText="SessionCode" SortExpression="SessionCode" UniqueName="SessionCode">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PreferredFormat" FilterControlAltText="Filter PreferredFormat column" HeaderText="PreferredFormat" SortExpression="PreferredFormat" UniqueName="PreferredFormat">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CurrentFormat" FilterControlAltText="Filter CurrentFormat column" HeaderText="CurrentFormat" SortExpression="CurrentFormat" UniqueName="CurrentFormat">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PlatformTime" DataType="System.TimeSpan" FilterControlAltText="Filter PlatformTime column" HeaderText="PlatformTime" SortExpression="PlatformTime" UniqueName="PlatformTime">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PosterNum" DataType="System.Int32" FilterControlAltText="Filter PosterNum column" HeaderText="PosterNum" SortExpression="PosterNum" UniqueName="PosterNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="UpdatedAbstractReceived" DataType="System.DateTime" FilterControlAltText="Filter UpdatedAbstractReceived column" HeaderText="UpdatedAbstractReceived" SortExpression="UpdatedAbstractReceived" UniqueName="UpdatedAbstractReceived">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="UpdatedAbstractNotes" FilterControlAltText="Filter UpdatedAbstractNotes column" HeaderText="UpdatedAbstractNotes" SortExpression="UpdatedAbstractNotes" UniqueName="UpdatedAbstractNotes">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcPaperReceived" DataType="System.DateTime" FilterControlAltText="Filter ProcPaperReceived column" HeaderText="ProcPaperReceived" SortExpression="ProcPaperReceived" UniqueName="ProcPaperReceived">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcPaperNotes" FilterControlAltText="Filter ProcPaperNotes column" HeaderText="ProcPaperNotes" SortExpression="ProcPaperNotes" UniqueName="ProcPaperNotes">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcPaperTitle" FilterControlAltText="Filter ProcPaperTitle column" HeaderText="ProcPaperTitle" SortExpression="ProcPaperTitle" UniqueName="ProcPaperTitle">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcPaperAuthList" FilterControlAltText="Filter ProcPaperAuthList column" HeaderText="ProcPaperAuthList" SortExpression="ProcPaperAuthList" UniqueName="ProcPaperAuthList">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcPosterReceived" FilterControlAltText="Filter ProcPaperAuthList column" HeaderText="ProcPosterReceived" SortExpression="ProcPosterReceived" UniqueName="ProcPosterReceived">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SpeakerBioReceived" DataType="System.DateTime" FilterControlAltText="Filter SpeakerBioReceived column" HeaderText="SpeakerBioReceived" SortExpression="SpeakerBioReceived" UniqueName="SpeakerBioReceived">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcDocNum" DataType="System.Int32" FilterControlAltText="Filter ProcDocNum column" HeaderText="ProcDocNum" SortExpression="ProcDocNum" UniqueName="ProcDocNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SessionName" FilterControlAltText="Filter SessionName column" HeaderText="SessionName" SortExpression="SessionName" UniqueName="SessionName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PlatformDate" DataType="System.DateTime" FilterControlAltText="Filter PlatformDate column" HeaderText="PlatformDate" SortExpression="PlatformDate" UniqueName="PlatformDate">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PosterDate" DataType="System.DateTime" FilterControlAltText="Filter PosterDate column" HeaderText="PosterDate" SortExpression="PosterDate" UniqueName="PosterDate">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PlatformBreakfast" FilterControlAltText="Filter PlatformBreakfast column" HeaderText="PlatformBreakfast" SortExpression="PlatformBreakfast" UniqueName="PlatformBreakfast">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PersonID" DataType="System.Int32" FilterControlAltText="Filter PersonID column" HeaderText="PersonID" ReadOnly="True" SortExpression="PersonID" UniqueName="PersonID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ParticipationID" FilterControlAltText="Filter ParticipationID column" HeaderText="ParticipationID" SortExpression="ParticipationID" UniqueName="ParticipationID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FirstName" FilterControlAltText="Filter FirstName column" HeaderText="FirstName" SortExpression="FirstName" UniqueName="FirstName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LastName" FilterControlAltText="Filter LastName column" HeaderText="LastName" SortExpression="LastName" UniqueName="LastName">
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
                <telerik:GridBoundColumn DataField="StateProvince" FilterControlAltText="Filter StateProvince column" HeaderText="StateProvince" SortExpression="StateProvince" UniqueName="StateProvince">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ZipPostal" FilterControlAltText="Filter ZipPostal column" HeaderText="ZipPostal" SortExpression="ZipPostal" UniqueName="ZipPostal">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Country" FilterControlAltText="Filter Country column" HeaderText="Country" SortExpression="Country" UniqueName="Country">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhoneNum" FilterControlAltText="Filter PhoneNum column" HeaderText="PhoneNum" ReadOnly="True" SortExpression="PhoneNum" UniqueName="PhoneNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CellNum" FilterControlAltText="Filter CellNum column" HeaderText="CellNum" ReadOnly="True" SortExpression="CellNum" UniqueName="CellNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ExhibitorID" DataType="System.Int32" FilterControlAltText="Filter ExhibitorID column" HeaderText="ExhibitorID" SortExpression="ExhibitorID" UniqueName="ExhibitorID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Exhibitor" FilterControlAltText="Filter Exhibitor column" HeaderText="Exhibitor" SortExpression="Exhibitor" UniqueName="Exhibitor">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AttendanceConferenceID" DataType="System.Int32" FilterControlAltText="Filter AttendanceConferenceID column" HeaderText="AttendanceConferenceID" SortExpression="AttendanceConferenceID" UniqueName="AttendanceConferenceID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RegListOptOut" DataType="System.Boolean" FilterControlAltText="Filter RegListOptOut column" HeaderText="RegListOptOut" SortExpression="RegListOptOut" UniqueName="RegListOptOut">
                </telerik:GridBoundColumn> 
                <telerik:GridBoundColumn DataField="SpecialNeeds" FilterControlAltText="Filter SpecialNeeds column" HeaderText="SpecialNeeds" SortExpression="SpecialNeeds" UniqueName="SpecialNeeds">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RegistrationType" FilterControlAltText="Filter RegistrationType column" HeaderText="RegistrationType" SortExpression="RegistrationType" UniqueName="RegistrationType">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="OneDayPassDate" DataType="System.DateTime" FilterControlAltText="Filter OneDayPassDate column" HeaderText="OneDayPassDate" SortExpression="OneDayPassDate" UniqueName="OneDayPassDate">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RegisterDate" DataType="System.DateTime" FilterControlAltText="Filter RegisterDate column" HeaderText="RegisterDate" SortExpression="RegisterDate" UniqueName="RegisterDate">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
        </telerik:RadGrid>
</asp:Content>
