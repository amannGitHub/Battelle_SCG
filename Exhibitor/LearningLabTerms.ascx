<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LearningLabTerms.ascx.vb" Inherits="Battelle.LearningLabTerms" %>
<asp:SqlDataSource ID="SqlDataSourceTermsConditions" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LearningLabTermsConditionsGet" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="ConferenceID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:Label ID="lblTermsConditions" runat="server" Text="[Terms and Conditions Coming Soon]"></asp:Label>
