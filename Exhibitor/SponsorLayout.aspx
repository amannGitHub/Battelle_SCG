<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Sponsor.Master" CodeBehind="SponsorLayout.aspx.vb" Inherits="Battelle.SponsorLayout" %>

<%@ Register Src="~/Exhibitor/BoothLayout.ascx" TagPrefix="uc1" TagName="BoothLayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:BoothLayout runat="server" ID="BoothLayout" />
</asp:Content>
