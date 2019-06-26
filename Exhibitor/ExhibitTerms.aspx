<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Exhibit.Master" CodeBehind="ExhibitTerms.aspx.vb" Inherits="Battelle.ExhibitTerms" %>
<%@ Register Src="~/Exhibitor/TermsConditions.ascx" TagPrefix="uc1" TagName="TermsConditions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Terms and Conditions</h1>
    <uc1:TermsConditions runat="server" ID="TermsConditions" />
</asp:Content>
