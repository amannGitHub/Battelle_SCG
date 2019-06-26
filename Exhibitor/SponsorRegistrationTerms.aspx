<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Sponsor.Master" CodeBehind="SponsorRegistrationTerms.aspx.vb" Inherits="Battelle.SponsorRegistrationTerms" %>
<%@ Register Src="~/Exhibitor/SponsorshipTerms.ascx" TagPrefix="uc1" TagName="TermsConditions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Terms and Conditions</h1>
    <uc1:TermsConditions runat="server" ID="TermsConditions" />

</asp:Content>
