<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="Users.aspx.vb" Inherits="Battelle.Users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AspNetUsersGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="UserID" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="UserID" DataNavigateUrlFormatString="UserRoles.aspx?userid={0}" Text="Roles" />
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
        </Columns>
    </asp:GridView>
</asp:Content>
