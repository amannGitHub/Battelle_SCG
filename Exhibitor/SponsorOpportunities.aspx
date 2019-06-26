<%@ Page Title="Sponsorship Opportunities" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Sponsor.Master" CodeBehind="SponsorOpportunities.aspx.vb" Inherits="Battelle.SponsorOpportunities" %>
<%@ Register Src="~/Exhibitor/SponsorshipTerms.ascx" TagPrefix="uc1" TagName="TermsConditions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Sponsorship Opportunities</h1>
    <p>Please contact Susie Warner (swarner@scgcorp.com) with the Scientific Consulting Group, Inc., to discuss potential sponsorship options not listed below.</p>
    <asp:SqlDataSource ID="SqlDataSourceFees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SponsorTypeFeesGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:PlaceHolder ID="PlaceHolderSponsorTypes" runat="server"></asp:PlaceHolder>
</asp:Content>
