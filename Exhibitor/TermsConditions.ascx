<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TermsConditions.ascx.vb" Inherits="Battelle.TermsConditions" %>
<asp:SqlDataSource ID="SqlDataSourceTermsConditions" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceTermsConditionsGet" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="ConferenceID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:Label ID="lblTermsConditions" runat="server" Text="[Terms and Conditions]"></asp:Label>