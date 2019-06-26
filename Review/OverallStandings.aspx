<%@ Page Title="Overall Standings" Language="vb" AutoEventWireup="false" CodeBehind="OverallStandings.aspx.vb" MasterPageFile="~/Review/Review.Master" Inherits="Battelle.OverallStandings" %>


<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title %></h1>
    <asp:SqlDataSource ID="SqlDataSourceProgChair" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractOverallStandingsAdmin" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvProgChair" runat="server" AutoGenerateColumns="false" DataKeyNames="SessionName" DataSourceID="SqlDataSourceProgChair" CssClass="table" Visible="false">
        <Columns>
            <asp:BoundField DataField="TopicCode" HeaderText="Code" SortExpression="TopicCode" />
            <asp:BoundField DataField="SessionName" HeaderText="Session" SortExpression="SessionName" />
            <asp:BoundField DataField="abstractCount" HeaderText="Number of Abstracts Assigned to Theme/Session" SortExpression="abstractCount" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceSteeringComm" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractOverallStandingsSteeringCommittee" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="PersonID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvSteeringComm" runat="server" AutoGenerateColumns="false" DataKeyNames="SessionName" DataSourceID="SqlDataSourceSteeringComm" CssClass="table" Visible="false">
        <Columns>
            <asp:BoundField DataField="TopicCode" HeaderText="Code" SortExpression="TopicCode" />
            <asp:BoundField DataField="SessionName" HeaderText="Session" SortExpression="SessionName" />
            <asp:BoundField DataField="abstractCount" HeaderText="Number of Abstracts Assigned to Theme/Session" SortExpression="abstractCount" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceSessionChair" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractOverallStandingsSessionChair" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="PersonID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvSessionChair" runat="server" AutoGenerateColumns="false" DataKeyNames="SessionName" DataSourceID="SqlDataSourceSessionChair" CssClass="table" Visible="false">
        <Columns>
            <asp:BoundField DataField="TopicCode" HeaderText="Code" SortExpression="TopicCode" />
            <asp:BoundField DataField="SessionName" HeaderText="Session" SortExpression="SessionName" />
            <asp:BoundField DataField="abstractCount" HeaderText="Number of Abstracts Assigned to Theme/Session" SortExpression="abstractCount" />
        </Columns>
    </asp:GridView>
</asp:Content>