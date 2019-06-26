<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="ConferenceManager.aspx.vb" Inherits="Battelle.ConferenceManager" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceFees" runat="server"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSessions" runat="server"></asp:SqlDataSource>
    <h1>Conference Information</h1>
    <asp:DetailsView ID="dvConference" runat="server"></asp:DetailsView>
    <hr />
    <h1>Fees</h1>
    <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    <hr />
    <h1>Topics/Sessions</h1><br />
    <telerik:RadGrid ID="RadGrid1" runat="server"></telerik:RadGrid>
</asp:Content>
