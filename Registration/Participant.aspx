<%@ Page Title="Participant Information" Language="vb" AutoEventWireup="false" MasterPageFile="~/Registration/Registration.Master" CodeBehind="Participant.aspx.vb" Inherits="Battelle.Participant" %>

<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="PanelLogin" runat="server">
        <uc1:ParticipationIDLogin runat="server" ID="ParticipationIDLogin" />
    </asp:Panel>
    <asp:Panel ID="PanelForm" runat="server" Visible="False">
        <asp:Label ID="lblMessage" runat="server" Text="<h1>Thank you for updating your information.</h1>"></asp:Label>
    </asp:Panel>
</asp:Content>
