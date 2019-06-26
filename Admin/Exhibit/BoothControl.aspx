<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="BoothControl.aspx.vb" Inherits="Battelle.BoothControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="UPDATE    Booth
SET              BoothStatus = 'Disabled', ExhibitorID = Null
WHERE     (ConferenceID = 1) AND (BoothNumber &lt;&gt; 119)" SelectCommand="Select BoothNumber,BoothStatus,ExhibitorID From Booth" UpdateCommand="UPDATE    Booth
SET              BoothStatus = 'Available', ExhibitorID = Null
WHERE     (ConferenceID = 1) AND (BoothStatus &lt;&gt; 'Reserved')"></asp:SqlDataSource>
    <asp:Button ID="ButtonOpen" runat="server" Text="Open" />
    <asp:Button ID="ButtonClose" runat="server" Text="Close" Enabled="False" />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" DataSourceID="SqlDataSource1"></asp:GridView>
</asp:Content>
