<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Sponsor.Master" CodeBehind="SponsorHome.aspx.vb" Inherits="Battelle.SponsorHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Sponsor Booth Reservation</h1>
    <p>Welcome to the Exhibitor Website for the <i><asp:Label ID="lblConference" runat="server" Text="[Conference]"></asp:Label></i>.</p>
    <p class="lead">Booth selection and reservation for <asp:Label ID="lblConfType" runat="server" Text="[Type]"></asp:Label> 
        Sponsors will open at <asp:Label ID="lblTime" runat="server" Text="[Time]"></asp:Label> <asp:Label ID="lblESTEDT" runat="server" Text="EST/EDT"></asp:Label> on 
        <asp:Label ID="lblOpenDate" runat="server" Text="[date]"></asp:Label></p>
    <p><b>Who Should Exhibit:</b><br />
        <asp:Label ID="lblWho" runat="server" Text="[Who]"></asp:Label>
    </p>
    <p><b>When:</b><br />
        <asp:Label ID="lblConfDates" runat="server" Text="[Dates]"></asp:Label>
    </p>
    <p><b>Where:</b><br />
        <asp:Label ID="lblVenue" runat="server" Text="[Venue]<br />"></asp:Label>
        <asp:Label ID="lblVenueAddress" runat="server" Text="[VenueAddr]<br />"></asp:Label>
        <asp:Label ID="lblCityState" runat="server" Text="[City, State]&nbsp;"></asp:Label>
        <asp:Label ID="lblZip" runat="server" Text="[Zip]<br />"></asp:Label>
        <asp:Label ID="lblPhone" runat="server" Text="[Phone]" Visible="false"></asp:Label>
        <asp:Label ID="lblVenueURL" runat="server" Text="[URL]" Visible="false"></asp:Label>
    </p>
    <p>
        For information on the <asp:Label ID="lblConfType2" runat="server" Text="[Conference Type]"></asp:Label> technical program and other events, visit 
        <asp:HyperLink ID="lnkConferenceSite" runat="server"></asp:HyperLink>. 
    </p>
    <hr />
    <p>To Begin:  Click on the <b>Booth Reservation</b> Tab</p>

        <ul  class="list-unstyled">
            <li><b>Step 1:</b>  Read and  Agree to Terms and Conditions and Liability Clause (you will not be able to reserve your booth until  you have agreed to both).
            </li>
            <li><b>Step 2:</b>  Enter your point of contact information. <i>Please note</i>, you will be the point of contact 
                for your organization. Also, you will be asked for a <i>Participant Code</i>. As this is a new feature, you 
                will most likely need to click the <span class="label label-primary">I need my Participant Code</span> button.
            </li>
            <li><b>Step 3:</b>  Enter your organization information</li>
            <li><b>Step 4:</b>  Select your booth</li>
            <li><b>Step 5:</b>  Confirmation</li>
        </ul>
    <br />
    After you complete your booth reservation, you will receive a confirmation email containing your Participant Code along with booth selection.
    <br /><br />
    <asp:Button ID="ButtonBegin" runat="server" Text="Begin Booth Reservation Now" CssClass="btn btn-primary" />
</asp:Content>
