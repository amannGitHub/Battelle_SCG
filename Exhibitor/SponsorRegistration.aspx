<%@ Page Title="Sponsorship Agreement" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Sponsor.Master" CodeBehind="SponsorRegistration.aspx.vb" Inherits="Battelle.SponsorRegistration" %>

<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>
<%@ Register Src="~/Exhibitor/CompanyInfo.ascx" TagPrefix="uc1" TagName="CompanyInfo" %>
<%@ Register Src="~/Exhibitor/SponsorshipTerms.ascx" TagPrefix="uc1" TagName="TermsConditions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1><%=Page.Title%></h1>
    <asp:Label ID="lblAlert" runat="server" Text="" Visible="false"></asp:Label>
    <asp:HiddenField ID="hdnVal" runat="server" />
    <asp:Panel ID="PanelInstructions" runat="server" Visible="true">
        <p>The following items  are <b>required</b> to complete the sponsorship agreement:</p>
        <ul type="disc">
            <li>High-resolution company logo (eps file preferred)</li>
            <li>Company description (max. 200 words)</li>
            <li>Credit Card information for deposit</li>
        </ul>
        <p>View the <asp:HyperLink ID="lnkSponsorshipOpportunities" runat="server">Sponsorship Opportunities</asp:HyperLink> for an overview of the costs and benefits of available Sponsorships.</p>
    </asp:Panel>
    <asp:Panel ID="PanelClosed" runat="server" Visible="false">
        <asp:Label ID="lblClosed" runat="server" Text="Sponsor Registration is currently closed."></asp:Label>
    </asp:Panel>
    <asp:Panel ID="PanelParticipationControl" runat="server" Visible="True">
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" />
    </asp:Panel>

    <asp:Panel ID="PanelExhibitorInfo" runat="server" Visible="False">
        <h3>Company Information</h3>
        <uc1:CompanyInfo runat="server" ID="CompanyInfo" />
    </asp:Panel>

    <asp:Panel ID="PanelTerms" runat="server" Visible="False">
        <h3>Terms and Conditions</h3>
        <asp:Label ID="lblTermsMessage" runat="server" Text="" Visible="False"></asp:Label>
        <asp:Label ID="lblLiability" runat="server" Text="" Visible="False"></asp:Label>
        <uc1:TermsConditions runat="server" ID="TermsConditions" />
        <p>Please contact Susie Warner (swarner@scgcorp.com) with the Scientific Consulting Group, Inc., to discuss potential sponsorship options not listed below.</p> 
        <asp:PlaceHolder ID="PlaceHolderSponsorTypesTC" runat="server"></asp:PlaceHolder>
        <p><strong>I am authorized to enter into the Sponsorship agreement category selected and agree to the Terms and Conditions of Sponsorship outlined above.</strong></p>
        <asp:CheckBox ID="chkTerms" runat="server" Text="&nbsp;I have read and agree to the Terms and Conditions" TextAlign="Right" /><br />
        <asp:CheckBox ID="chkLiability" runat="server" Text="&nbsp;I have read and agree to the Release of Liability" Visible="False" />
        <br />
        <asp:Button ID="btnAgree" runat="server" Text="Next Step >>" CssClass="btn btn-primary" />
    </asp:Panel>

    <asp:Panel ID="PanelForm" runat="server" Visible="False">
        <asp:SqlDataSource ID="SqlDataSourceReg" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="SponsorRegistrationInsert" InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Name="PersonID" Type="Int32" />
                <asp:Parameter Name="ExhibitorID" Type="Int32" />
                <asp:Parameter Name="SponsorTypeID" Type="Int32" />
                <asp:Parameter Name="ConferenceID" Type="Int32" />
                <asp:Parameter Name="FeeTypeID" Type="Int32" />
                <asp:Parameter Name="Amount" Type="Decimal" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="CompanyDescription" Type="String" />
                <asp:Parameter Direction="InputOutput" Name="Fail" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceFees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SponsorTypeFeesGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <div class="form-group">
            <div class="container">
                (Please select one option)
                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                <div class="row">
                    <div class="col-md-12">
                        <h3>Custom Sponsorship</h3>
                        Interested in a sponsorship category not seen above? Contact the
                        <asp:Literal ID="ltlConferenceType" runat="server"></asp:Literal>
                        Office (<asp:HyperLink ID="lnkConferenceEmail" runat="server"></asp:HyperLink>) to discuss details and pricing.
                    </div>
                </div>



                <div class="row">
                    <div class="col-md-12">
                        <h3>High Resolution Company Logo* (.eps file preferred)</h3>
                        Please upload an image file to be used for marketing purposes, preferably in .eps format.<br />
                        <asp:Label ID="lblUpload" runat="server" Text="*Upload your File (preferably .eps)" AssociatedControlID="FileUploadAbstract"></asp:Label><br />
                        <asp:FileUpload ID="FileUploadAbstract" runat="server" Width="100%" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:RequiredFieldValidator ID="RequiredFileUploadAbstract" runat="server" ErrorMessage="Company logo is required." ControlToValidate="FileUploadAbstract" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3>Company Description* (max 200 words)</h3>
                        <asp:TextBox ID="txtCompanyDescription" runat="server" MaxLength="1500" TextMode="MultiLine" Rows="10" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Company Description is required." ControlToValidate="txtCompanyDescription" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        &nbsp;
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary btn-block" />
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnClear" runat="server" Text="Clear Form" CssClass="btn btn-default btn-block" />
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdnCtrls" runat="server" />
        <asp:HiddenField ID="hdnFail" runat="server" />
    </asp:Panel>

</asp:Content>
