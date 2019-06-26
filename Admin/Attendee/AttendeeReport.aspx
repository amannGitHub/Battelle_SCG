<%@ Page Title="Attendee Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="AttendeeReport.aspx.vb" Inherits="Battelle.AttendeeReport" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
    <asp:SqlDataSource ID="SqlDataSourceAttendees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AttendeeGetByConferenceWithBooth" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="btnExport" runat="server" Text="Export to Excel" CssClass="btn btn-default" Visible="False" />
    <asp:GridView ID="gvAttendeeList" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceAttendees" AutoGenerateColumns="False" CssClass="table table-striped" >
        <Columns>
            

            
            <asp:HyperLinkField DataNavigateUrlFields="PersonID,ConferenceID" DataNavigateUrlFormatString="PersonLedger.aspx?pid={0}&cid={1}" Target="_blank" Text="Conf. Ledger" />
            

            
            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
            <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
            <asp:BoundField DataField="AmountPaid" HeaderText="Amount Paid" ReadOnly="True" SortExpression="AmountPaid" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="TotalExpenses" HeaderText="Total Expenses" ReadOnly="True" SortExpression="TotalExpenses" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="AttendeeBalance" HeaderText="Attendee Balance" SortExpression="AttendeeBalance" ReadOnly="True" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="OutstandingBalance" HeaderText="Outstanding Balance" SortExpression="OutstandingBalance" ReadOnly="True" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="RegistrationType" HeaderText="Registration Type" SortExpression="RegistrationType" />
            <asp:BoundField DataField="ParticipationID" HeaderText="Participant Code" SortExpression="ParticipationID" />
            <asp:BoundField DataField="AddressLine1" HeaderText="Address Line 1" SortExpression="AddressLine1" />

            <asp:BoundField DataField="AddressLine2" HeaderText="Line 2" SortExpression="AddressLine2" />
            <asp:BoundField DataField="AddressLine3" HeaderText="Line 3" SortExpression="AddressLine3" />
            

            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="StateProvince" HeaderText="State Province" SortExpression="StateProvince" />
            <asp:BoundField DataField="ZipPostal" HeaderText="Zip Postal" SortExpression="ZipPostal" />
            <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
            <asp:BoundField DataField="PhoneNum" HeaderText="Phone #" SortExpression="PhoneNum" />
            <asp:BoundField DataField="CellNum" HeaderText="Cell #" SortExpression="CellNum" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            
            
            <asp:BoundField DataField="SpecialNeeds" HeaderText="Special Needs" SortExpression="SpecialNeeds" />
            <asp:BoundField DataField="RegListOptOut" HeaderText="Reg List Opt-Out" SortExpression="RegListOptOut" />
            <asp:BoundField DataField="OneDayPassDate" HeaderText="One Day Pass Date" SortExpression="OneDayPassDate" />
            <asp:BoundField DataField="RegisterDate" HeaderText="Register Date" SortExpression="RegisterDate" />
            <asp:BoundField DataField="Exhibitor" HeaderText="Exhibitor" SortExpression="Exhibitor" />
            <asp:BoundField DataField="OrganizationID" HeaderText="Organization ID" SortExpression="OrganizationID" />
            <asp:BoundField DataField="BoothNumber" HeaderText="Booth Number" SortExpression="BoothNumber" />
            <asp:HyperLinkField DataNavigateUrlFields="PersonID" DataNavigateUrlFormatString="PersonLedger.aspx?pid={0}" Target="_blank" Text="Full Ledger" />
        </Columns>
    </asp:GridView>
</asp:Content>
