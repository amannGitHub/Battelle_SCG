<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SponsorshipTerms.ascx.vb" Inherits="Battelle.SponsorshipTerms" %>
<asp:SqlDataSource ID="SqlDataSourceTermsConditions" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SponsorRegTermsConditionsGet" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="ConferenceID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:Label ID="lblTermsConditions" runat="server" Text="[Terms and Conditions]"></asp:Label>
