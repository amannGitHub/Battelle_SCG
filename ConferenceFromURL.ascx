<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ConferenceFromURL.ascx.vb" Inherits="Battelle.ConferenceFromURL"  %>
<asp:SqlDataSource ID="SqlDataSourceConf" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGetByURLString" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:RouteParameter Name="URLString" RouteKey="conference" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="hdnConfName" runat="server" />
<asp:HiddenField ID="hdnConfShortName" runat="server" />
<asp:HiddenField ID="hdnConfDates" runat="server" />
<asp:HiddenField ID="hdnConfLocation" runat="server" />
<asp:HiddenField ID="hdnExampleAbstract" runat="server" />
<asp:HiddenField ID="hdnTechnicalScope" runat="server" />
<asp:HiddenField ID="hdnFinalPlacement" runat="server" />
<asp:HiddenField ID="hdnPreliminaryProgram" runat="server" />
<asp:HiddenField ID="hdnConferenceEmail" runat="server" />

<asp:Image ID="imgBanner" runat="server" CssClass="img-responsive" />

