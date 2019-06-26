<%@ Page Title="Battelle Conferences" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="Battelle._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Welcome to the Battelle events website.</h1>
    <h2>Upcoming events:</h2>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceUpcomingGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ConferenceID" DataSourceID="SqlDataSource1" CssClass="table">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText=" Event Name" SortExpression="Name" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
            <asp:BoundField DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate" dataformatstring="{0:MMMM d, yyyy}" />
            <asp:BoundField DataField="EndDate" HeaderText="End Date" SortExpression="EndDate" dataformatstring="{0:MMMM d, yyyy}" />
            <asp:HyperLinkField DataNavigateUrlFields="URLString" DataNavigateUrlFormatString="{0}/register" HeaderText="Attend" Text="Register" />
        </Columns>
    </asp:GridView>
&nbsp;


</asp:Content>
