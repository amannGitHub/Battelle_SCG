<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Exhibit.Master" CodeBehind="ExhibitBooth.aspx.vb" Inherits="Battelle.ExhibitBooth" %>

<%@ Register Src="~/Exhibitor/BoothLayout.ascx" TagPrefix="uc1" TagName="BoothLayout" %>
<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>
<%@ Register Src="~/Exhibitor/CompanyInfo.ascx" TagPrefix="uc1" TagName="CompanyInfo" %>
<%@ Register Src="~/Exhibitor/TermsConditions.ascx" TagPrefix="uc1" TagName="TermsConditions" %>
<%@ Register Src="~/SessionHandler.ascx" TagPrefix="controls" TagName="SessionHandler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style type="text/css">
.booth
{
width:100%;
border-collapse:collapse;
}
.booth td, .booth th 
{
border:1px solid #c4c4c4;
padding:3px 7px 2px 7px;
}
.booth th 
{
font-size:1.1em;
text-align:left;
padding-top:5px;
padding-bottom:4px;
background-color:#033e77;
color:#fff;
}
</style>


    <h1><%=ExhibitorOrSponsor%> Booth Selection</h1>
    <asp:Panel ID="PanelProgress" runat="server">
    <div class="progress">
        <asp:Label ID="lblProgress" runat="server" Text=""></asp:Label>    
    </div>

    </asp:Panel>
    <asp:Label ID="lblAlert" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Panel ID="PanelInstructions" runat="server" Visible="false">
        Instructions go here.
    </asp:Panel>
    <asp:Panel ID="PanelParticipationControl" runat="server" >
        <div class="alert alert-info" role="alert">Please remember, you will be listed as the point of contact for your organization.</div>
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" OnFinishedLogin="ParticipationIDLogin_FinishedLogin" />
    </asp:Panel>

    <asp:Panel ID="PanelGovernmentNonProfit" runat="server" Visible="false">
        <h3>Non-Profit/Government Employee</h3>
        <p>Do you currently work for a non-profit organization or federal agency?</p>
        <div class="form-group">
          <div class="container-fluid">
             <div class="row">
                <asp:RadioButton ID="orgFedBtnYes" runat="server" GroupName="govNonProfit" Text="Yes" />&nbsp;&nbsp;
                <asp:RadioButton ID="orgFedBtnNo" runat="server" GroupName="govNonProfit" Text="No" />
            </div>
            <div class="row">
                <br />
                <asp:Button ID="BtnFinishedGovNonProfit" runat="server" Text="Next Step >>" CssClass="btn btn-primary" Visible="True" />            
             </div>
          </div>
        </div>
        <asp:HiddenField ID="hdnValGovNonProfit" runat="server" />
    </asp:Panel>

    <asp:Panel ID="PanelTerms" runat="server" Visible="False" >
        <h3>Terms and Conditions</h3>
        <asp:Label ID="lblTermsMessage" runat="server" Text="" Visible="False"></asp:Label>
        <asp:Label ID="lblLiability" runat="server" Text="" Visible="False"></asp:Label>
        <uc1:TermsConditions runat="server" id="TermsConditions" />
        
        <asp:CheckBox ID="chkTerms" runat="server" Text="&nbsp;I have read and agree to the Terms and Conditions" /><br />
        <asp:CheckBox ID="chkLiability" runat="server" Text="&nbsp;I have read and agree to the Release of Liability" Visible="False" />
        <br />
        <asp:Button ID="btnAgree" runat="server" Text="Next Step >>" CssClass="btn btn-primary" />
    </asp:Panel>
    
    <asp:Panel ID="PanelExhibitorInfo" runat="server" Visible="False" >
        <h3>Company Information</h3>
        <uc1:CompanyInfo runat="server" ID="CompanyInfo" />
    </asp:Panel>
    <asp:Panel ID="PanelBoothLayout" runat="server" Visible="False" >
        <h3>Select your booth <small>Booth Fee: US $<asp:Label ID="lblBoothFee" runat="server" Text="[TBD]"></asp:Label></small></h3>
        <uc1:BoothLayout runat="server" ID="BoothLayout"  />
    </asp:Panel>
    <asp:Panel ID="PanelConfirmation" runat="server" Visible="False">
        <h3>Booth Reservation Successful</h3>
       
        <p>You are the person listed as the booth point of contact for your organization and  will receive all correspondence and important information regarding the  upcoming conference.  Please note that  you will need to forward conference correspondence to other company staff as  necessary.</p>
    <asp:FormView ID="FormViewConfirmation" runat="server" DataSourceID="SqlDataSourceConfirmation" RenderOuterTable="False">
        <EmptyDataTemplate>
            There is a problem retrieving your data.
        </EmptyDataTemplate>
        <ItemTemplate>
           <h4>Booth Selection:<br />
            <asp:Label ID="BoothNumberLabel" runat="server" Text='<%# Bind("BoothNumber") %>' />
            <asp:Label ID="BoothNumberAndLabel" runat="server" Text="<br />"></asp:Label><asp:Label ID="BoothNumber2Label" runat="server" Text='<%# Bind("BoothNumber2")%>' />
            </h4> <br />



        </ItemTemplate>
    </asp:FormView>
        <asp:Panel ID="PanelMail" runat="server">
        <h3>Mailing List Purchase</h3>
        Contact information including mailing addresses, phone, and email of all registrants (who have not opted out) will be provided on 
        <asp:Label ID="lblMailingFirst" runat="server" Text="[Date to be determined]"></asp:Label>, and 
        <asp:Label ID="lblMailingSecond" runat="server" Text="[Date to be determined]"></asp:Label>, for a total fee of 
        US $<asp:Label ID="lblMailingFee" runat="server" Text="150.00"></asp:Label>. Both lists will be emailed in Excel format to you, the primary point of contact. 
        <br /><br />
        <asp:CheckBox ID="chkBoxMailing" runat="server" Text="&nbsp;Yes, I would like to purchase the mailing list." /><br /><br />
            </asp:Panel>

        


     
    <asp:Button ID="btnNextStep1" runat="server" Text="Next Step >>" CssClass="btn btn-primary" />
    <asp:SqlDataSource ID="SqlDataSourceConfirmation" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothConfirmationGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="ConferenceID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        


    </asp:Panel>
    <asp:SqlDataSource ID="SqlDataSourceLedger" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="ConferenceLedgerInsert" InsertCommandType="StoredProcedure" SelectCommand="ConferenceFeeGetByType" SelectCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="FeeTypeID" Type="Int32" />
            <asp:Parameter Name="Amount" Type="Decimal" />
            <asp:Parameter Name="Notes" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="FeeTypeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceBoothSelection" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="BoothConferenceLedgerInsert" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="ExhibOrSponsor" Type="String" />
            <asp:Parameter Name="BoothID1" Type="Int32" />
            <asp:Parameter Name="BoothID2" Type="Int32" />
            <asp:Parameter Name="govNonProfit" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

    <%--<controls:SessionHandler id="handler1" TargetURLForSessionTimeout="" AutomaticRedirect="false" runat="server" OnTimeOut="SessionTimeout"/>--%>
</asp:Content>
