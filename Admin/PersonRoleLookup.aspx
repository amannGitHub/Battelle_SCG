<%@ Page Title="Person Role Lookup" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="PersonRoleLookup.aspx.vb" Inherits="Battelle.PersonRoleLookup" %>

<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%= Page.Title %></h1>

    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>
    <br />
    <asp:Label ID="lblWarning" runat="server" Text="Please select a conference before searching for a person's role." ForeColor="Red" Visible="false"></asp:Label>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSourceParticipant" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT LastName + ', ' + FirstName + ' - ' + Employer AS FullName, PersonID, ParticipationID FROM Person"></asp:SqlDataSource>
    Search People:
        <telerik:RadAutoCompleteBox ID="txtPersonLookup" runat="server" DataSourceID="SqlDataSourceParticipant" DataTextField="FullName" DataValueField="PersonID" InputType="Text" DropDownWidth="300"></telerik:RadAutoCompleteBox>
    <asp:Button ID="btnPersonLookup" runat="server" CausesValidation="True" Text="Search" OnClick="btnPersonLookup_Click" />
    <br />
    <asp:GridView ID="GridView1" runat="server" DataSourceID="" AutoGenerateColumns="true" CssClass="table">
    </asp:GridView>

</asp:Content>
