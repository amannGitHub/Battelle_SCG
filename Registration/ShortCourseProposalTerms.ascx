<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ShortCourseProposalTerms.ascx.vb" Inherits="Battelle.ShortCourseProposalTerms" %>
<asp:SqlDataSource ID="SqlDataSourceTermsConditions" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseTermsConditionsGet" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="ConferenceID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:Label ID="lblTermsConditions" runat="server" Text="[Terms and Conditions Coming Soon]"></asp:Label>
