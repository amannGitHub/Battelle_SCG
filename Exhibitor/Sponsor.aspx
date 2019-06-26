<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Sponsor.Master" CodeBehind="Sponsor.aspx.vb" Inherits="Battelle.Sponsor" %>

<%@ Register Src="~/Exhibitor/BoothLayout.ascx" TagPrefix="uc1" TagName="BoothLayout" %>
<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>
<%@ Register Src="~/Exhibitor/CompanyInfo.ascx" TagPrefix="uc1" TagName="CompanyInfo" %>
<%@ Register Src="~/Exhibitor/TermsConditions.ascx" TagPrefix="uc1" TagName="TermsConditions" %>




<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Sponsor Booth Selection</h1>
    <div class="progress">
        <asp:Label ID="lblProgress" runat="server" Text=""></asp:Label>    
    </div>
    <asp:Panel ID="PanelInstructions" runat="server">
        <h3>Terms and Conditions</h3>
        <asp:Label ID="lblTermsMessage" runat="server" Text="" Visible="False"></asp:Label>
        <asp:Label ID="lblLiability" runat="server" Text="" Visible="False"></asp:Label>
        <uc1:TermsConditions runat="server" id="TermsConditions" />
        <div class="alert alert-info" role="alert">Please note, on the next page you will be asked for a <i>Participant Code</i>. As this is a new feature, you will need to click the <span class="label label-primary">I need my Participant Code</span> button.</div>
        <asp:CheckBox ID="chkTerms" runat="server" Text="&nbsp;I have read and agree to the Terms and Conditions" /><br />
        <asp:CheckBox ID="chkLiability" runat="server" Text="&nbsp;I have read and agree to the Release of Liability" />
        <br />
        <asp:Button ID="btnAgree" runat="server" Text="Next Step >>" CssClass="btn btn-primary" />
    </asp:Panel>
    <asp:Panel ID="PanelParticipationControl" runat="server" Visible="False" >
        <div class="alert alert-info" role="alert">Please remember, you will be listed as the point of contact for your organization.</div>
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" OnFinishedLogin="ParticipationIDLogin_FinishedLogin" />
    </asp:Panel>
    <asp:Panel ID="PanelExhibitorInfo" runat="server" Visible="False" >
        <h3>Company Information</h3>
        <uc1:CompanyInfo runat="server" ID="CompanyInfo" />
    </asp:Panel>
    <asp:Panel ID="PanelBoothLayout" runat="server" Visible="False" >
        <h3>Select your booth</h3>
        <uc1:BoothLayout runat="server" ID="BoothLayout"  />
    </asp:Panel>
    <asp:Panel ID="PanelConfirmation" runat="server" Visible="False">
        <h3>Confirmation</h3>
        <span class="text-warning">Please do not hit the back button. To view the Booth Layout and confirm your selection click the Booth Layout tab above.</span>
        <p>Thank  you for completing your booth reservation for the <i><asp:Label ID="lblConference" runat="server" Text="[Conference]"></asp:Label>.&nbsp; </i>An email confirmation has been sent you.  <u>Please keep the email confirmation for  your records</u> and reference so that you may add/update booth staff, register  Technical Program staff and retrieve your registration information as  necessary.</p>
<p>You  are the person listed as the booth point of contact for your organization and  will receive all correspondence and important 
    information regarding the  upcoming <asp:Label ID="lblConferenceType" runat="server" Text="[Conference]"></asp:Label>.  
    Please note that  you will need to forward conference correspondence to other 
    company staff as  necessary.</p>
<p>
    
    <asp:SqlDataSource ID="SqlDataSourceConfirmation" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothConfirmationGet" SelectCommandType="StoredProcedure" InsertCommand="ConferenceLedgerInsert" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="FeeTypeID" Type="Int32" />
            <asp:Parameter Name="Amount" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="Notes" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="ConferenceID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="FormViewConfirmation" runat="server" DataSourceID="SqlDataSourceConfirmation" RenderOuterTable="False">
        <EmptyDataTemplate>
            There is a problem retrieving your data.
        </EmptyDataTemplate>
        <ItemTemplate>
           <h4>Booth Selection:</h4> 
            You have reserved Booth 
            <asp:Label ID="BoothNumberLabel" runat="server" Text='<%# Bind("BoothNumber") %>' />
            <br />
            <h4>Point of Contact</h4>
            Participant Code:
            <asp:Label ID="ParticipationIDLabel" runat="server" Text='<%# Bind("ParticipationID") %>' />
            <br />
            First Name:
            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
            <br />
            Last Name:
            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
            <br />
            Address:
            <asp:Label ID="AddressLine1Label" runat="server" Text='<%# Bind("AddressLine1") %>' />
            <br />
            <asp:Label ID="AddressLine2Label" runat="server" Text='<%# Bind("AddressLine2") %>' />
            <br />
            <asp:Label ID="AddressLine3Label" runat="server" Text='<%# Bind("AddressLine3") %>' />
            <br />
            City:
            <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />
            <br />
            State/Province:
            <asp:Label ID="StateProvinceLabel" runat="server" Text='<%# Bind("StateProvince") %>' />
            <br />
            Zip/Postal Code:
            <asp:Label ID="ZipPostalLabel" runat="server" Text='<%# Bind("ZipPostal") %>' />
            <br />
            Country:
            <asp:Label ID="CountryLabel" runat="server" Text='<%# Bind("Country") %>' />
            <br />
            Office Phone Number:
            <asp:Label ID="PhoneNumLabel" runat="server" Text='<%# Bind("PhoneNum") %>' />
            <br />
            Cell Phone Number:
            <asp:Label ID="CellNumLabel" runat="server" Text='<%# Bind("CellNum") %>' />
            <br />
            Email:
            <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
            <h4>Organization Information</h4>
            Exhibitor:
            <asp:Label ID="ExhibitorLabel" runat="server" Text='<%# Bind("Exhibitor") %>' />
            <br />
            Organization ID:
            <asp:Label ID="OrganizationIDLabel" runat="server" Text='<%# Bind("OrganizationID") %>' />
            <br />
            Address:
            <asp:Label ID="ExhibAddressLine1Label" runat="server" Text='<%# Bind("ExhibAddressLine1") %>' />
            <br />
            <asp:Label ID="ExhibAddressLine2Label" runat="server" Text='<%# Bind("ExhibAddressLine2") %>' />
            <br />
            <asp:Label ID="ExhibAddressLine3Label" runat="server" Text='<%# Bind("ExhibAddressLine3") %>' />
            <br />
            City:
            <asp:Label ID="ExhibCityLabel" runat="server" Text='<%# Bind("ExhibCity") %>' />
            <br />
            State/Province:
            <asp:Label ID="ExhibStateProvinceLabel" runat="server" Text='<%# Bind("ExhibStateProvince") %>' />
            <br />
            Zip/Postal Code:
            <asp:Label ID="ExhibZipPostalLabel" runat="server" Text='<%# Bind("ExhibZipPostal") %>' />
            <br />
            Country:
            <asp:Label ID="ExhibCountryLabel" runat="server" Text='<%# Bind("ExhibCountry") %>' />

        </ItemTemplate>
    </asp:FormView>

    <p>
    </p>
    <p>
        If you have any questions, please contact <asp:Label ID="lblMeetingPlanner" runat="server" Text="[MeetingPlanner"></asp:Label> 
        with The Scientific Consulting Group, Inc., at 
        <asp:HyperLink ID="lnkMeetingPlannerEmail" runat="server"></asp:HyperLink> or by phone at 301-670-4990.</p>
    <p>
        Thank you for your support for the <asp:Label ID="lblConferenceShortName" runat="server" Text="[Conference]"></asp:Label>. 
        We look forward to seeing you in <asp:Label ID="lblLocation" runat="server" Text="[Location]"></asp:Label>!</p>
    <p>
        To return to the <asp:Label ID="lblConferenceType2" runat="server" Text="[Conference]"></asp:Label> Website Home page, 
        please click “<asp:HyperLink ID="lnkMainConf" runat="server">here</asp:HyperLink>”.
        &nbsp; General <asp:Label ID="lblConferenceType3" runat="server" Text="[Conference]"></asp:Label> information as well as 
        specific information regarding the technical program and other 
        <asp:Label ID="lblConferenceType4" runat="server" Text="[Conference]"></asp:Label> details can be found on the main 
        <asp:Label ID="lblConferenceType5" runat="server" Text="[Conference]"></asp:Label> Website.</p>

    <p>
    </p>

    <p>
    </p>

    <p>
    </p>

    <p>
    </p>

</p>
    </asp:Panel>

</asp:Content>
