<%@ Page Title="Short Courses" Language="vb" AutoEventWireup="false" MasterPageFile="~/Registration/Registration.Master" CodeBehind="ComingSoon.aspx.vb" Inherits="Battelle.ComingSoon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:Label ID="lblClosed" runat="server" Text="Short Course Registration will open soon."></asp:Label>
</asp:Content>
