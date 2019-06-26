<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Exhibit.Master" CodeBehind="ExhibitHome.aspx.vb" Inherits="Battelle.ExhibitHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
                
                <h2>Welcome to the <i>
                    <asp:Label ID="lblConference" runat="server" Text="[Conference]"></asp:Label></i> 
                    <%=ExhibitorOrSponsor%> Website</h2>
            <asp:Panel ID="PanelExhibitOpenDate" runat="server">
            <p class="lead">
                    Booth selection and reservation for
                    <asp:Label ID="lblConfType" runat="server" Text="[Type]"></asp:Label>
                    <%=ExhibitorOrSponsor%>s will open at<br />
                    <asp:Label ID="lblTime" runat="server" Text="[Time]"></asp:Label>
                    <asp:Label ID="lblESTEDT" runat="server" Text="EST/EDT"></asp:Label>
                    on 
        <asp:Label ID="lblOpenDate" runat="server" Text="[Open Date TBD]"></asp:Label>.
                </p>
            </asp:Panel>

                <p>
                    <b>Who Should Exhibit:</b><br />
                    <asp:Label ID="lblWho" runat="server" Text="[TBD]"></asp:Label>
                </p>
                <p>
                    <b>When:</b><br />
                    <asp:Label ID="lblConfDates" runat="server" Text="[Dates TBD]"></asp:Label>
                </p>
                <p>
                    <b>Where:</b><br />
                    <asp:Label ID="lblVenue" runat="server" Text="[Venue TBD]<br />"></asp:Label>
                    <asp:Label ID="lblVenueAddress" runat="server" Text="[Venue Address TBD ]<br />"></asp:Label>
                    <asp:Label ID="lblCityState" runat="server" Text="[City, State TBD]&nbsp;"></asp:Label>
                    <asp:Label ID="lblZip" runat="server" Text="[Zip Code TBD]<br />"></asp:Label>
                    <asp:Label ID="lblPhone" runat="server" Text="[Phone TBD]" Visible="false"></asp:Label>
                    <asp:Label ID="lblVenueURL" runat="server" Text="[URL TBD]" Visible="false"></asp:Label>
                </p>
            <div class="alert alert-warning" role="alert">
                    <b><i>Please note</i>, the <asp:Label ID="lblShortConfName" runat="server" Text="[Conference Name]"></asp:Label> does not have group rate agreements with any properties other 
                    than the <asp:Label ID="lblVenue2" runat="server" Text="[Venue TBD]"></asp:Label> nor have we partnered with any travel agency or third-party for travel/hotel discounts.</b> 
                If you receive a call or an email offering assistance in making hotel reservations or changing existing reservations, we advise caution. 
                The <asp:Label ID="lblConfType3" runat="server" Text="[Conference Type]"></asp:Label> has no agreement with any organization to contact participants and offer reservation assistance, 
                nor have we provided contact information to anyone for this purpose.
                </div>
                <p>
                    For information on the
                    <asp:Label ID="lblConfType2" runat="server" Text="[Conference Type]"></asp:Label>
                    technical program and other events, visit 
        <asp:HyperLink ID="lnkConferenceSite" runat="server"></asp:HyperLink>. 
                </p>
                <asp:Panel ID="pnlWelcome" runat="server">
                <p>
                    Please be sure to complete all required information as indicated on the registration form and follow each step throughout the registration process. You will receive an email 
    confirmation once you have completed all of the steps. You will be prompted to provide names and contact information for your booth staff, but please note you are not required 
    to add staff at this time. Additionally, you have the option to register two staff to attend the Technical Program, which again is optional at this time.

                </p>
                <!--<div class="alert alert-success" role="alert">
                    <i>Please note</i>, you will be the point of contact 
                for your organization. Also, you will be asked for a <i>Participant Code</i>. As this is a new feature, 
                you will need to click the <span class="label label-primary">I need my Participant Code</span> button.
                </div>-->
                <asp:Button ID="ButtonBegin" runat="server" Text="Begin Booth Reservation Now" CssClass="btn btn-primary" />&nbsp;<asp:LinkButton ID="lnkBtnRefresh" runat="server" ToolTip="Refresh Page" Visible="False"><span class="glyphicon glyphicon-refresh"></span></asp:LinkButton><small><asp:Label ID="lblServerTime" runat="server" Text="Current Server Time: "></asp:Label>
                </asp:Panel>
                <asp:Label ID="lblClosed" runat="server" Text="<b>Exhibitor registration is not yet available.</b>" Visible="False"></asp:Label>

    <!--

                <asp:SqlDataSource ID="SqlDataSourceSponsors" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SponsorGetByConferenceID" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:Parameter Name="SponsorTypeID" Type="Int32" DefaultValue="1"/>
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Repeater ID="RepeaterSponsors" runat="server" DataSourceID="SqlDataSourceSponsors">
                    <HeaderTemplate>
                        <div class="panel panel-default">
                            <div class="panel-heading">Conference Sponsors</div>
                            <div class="panel-body">
                                <p class="text-center">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <img src="../images/sponsors/<%'# Eval("SponsorLogo")%>" title="<%'# Eval("Exhibitor")%>" alt="<%'# Eval("Exhibitor")%>" width="<%'# Eval("LogoWidth")%>" height="<%'# Eval("LogoHeight")%>" />
                    </ItemTemplate>
                    <SeparatorTemplate>
                        <br />
                        <br />
                    </SeparatorTemplate>
                    <FooterTemplate>
                        </p>
                            </div>
                            </div>
                    </FooterTemplate>
                </asp:Repeater>

                 
    -->
            </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
