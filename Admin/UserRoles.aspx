<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="UserRoles.aspx.vb" Inherits="Battelle.UserRoles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AspNetRolesGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUserRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AspNetUserRolesGetbyUser" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="UserID" QueryStringField="userid" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:DropDownList ID="ddlRoles" runat="server" DataSourceID="SqlDataSourceRoles" DataTextField="Name" DataValueField="Name"></asp:DropDownList><asp:Button ID="btnAddRole" runat="server" Text="Add Role" /><br />
    Current Roles:<br />
    <asp:GridView ID="gvUserRoles" runat="server" DataSourceID="SqlDataSourceUserRoles"></asp:GridView>
</asp:Content>
