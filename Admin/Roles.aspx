<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="Roles.aspx.vb" Inherits="Battelle.Roles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AspNetRolesGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    Create Role: <asp:TextBox ID="txtRole" runat="server"></asp:TextBox> <asp:Button ID="btnCreate" runat="server" Text="Create Role" /><br />
    Existing Roles:<br />
    <asp:GridView ID="gvRoles" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
        </Columns>
    </asp:GridView>
</asp:Content>
