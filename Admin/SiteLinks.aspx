<%@ Page Title="Battelle Site Links" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="SiteLinks.aspx.vb" Inherits="Battelle.SiteLinks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <asp:Panel ID="pnlLinks" runat="server" Visible="False">
        <ul class="list-group">
            <li class="list-group-item list-group-item-info">For the most error free copying and pasting of the URL, <i>Right click -> Copy Link Address (or Copy Shortcut/Link Location depending on browser)</i>.</li>
            <li class="list-group-item list-group-item-warning">Be sure to verify that a page is ready before distributing the URL.</li>
        </ul>

        <table class="table table-hover">
            <thead>
                <th>Link Type</th>
                <th>URL</th>
            </thead>
            <tbody>
                <tr>
                    <th colspan="2" class="info">Registration</th>
                </tr>
                <tr>
                    <td>Standard Registration (industry, government, student, etc.)</td>
                    <td>
                        <asp:HyperLink ID="lnkRegistration" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Discounted Technical Registration</td>
                    <td>
                        <asp:HyperLink ID="lnkRegistrationTechReg" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>One Day Pass</td>
                    <td>
                        <asp:HyperLink ID="lnkRegistrationOneDayPass" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Exhibit Hall Only Pass</td>
                    <td>
                        <asp:HyperLink ID="lnkRegistrationExhibPass" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Waiver (Free Registration)</td>
                    <td>
                        <asp:HyperLink ID="lnkRegistrationWaiver" runat="server"></asp:HyperLink> <span class="label label-warning">Use Discretion</span></td>
                </tr>
                <tr>
                    <td>Balance (Payment)</td>
                    <td>
                        <asp:HyperLink ID="lnkBalance" runat="server"></asp:HyperLink> <span class="label label-success">$</span></td>
                </tr>
                <tr>
                    <td>Participant Code Retrival (general use for all users)</td>
                    <td>
                        <asp:HyperLink ID="lnkParticipant" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <th colspan="2" class="info">Exhibitors/Sponsors</th>
                </tr>
                <tr>
                    <td>Sponsor Registration</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorSponsorRegistration" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Sponsor Booth Reservation</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorSponsorBoothReservation" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Sponsor Terms and Conditions</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorSponsorTC" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Sponsor Balance (Payment)</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorSponsorBalance" runat="server"></asp:HyperLink> <span class="label label-success">$</span></td>
                </tr>
                <tr>
                    <td>Sponsor Booth Layout (uses Sponsor T&C menu)</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorSponsorLayout" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Exhibitor Booth Layout</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorBoothLayout" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Exhibitor Booth Reservation</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorBoothReservation" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Exhibitor Terms and Conditions</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorTC" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Exhibitor Balance (Payment)</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorBalance" runat="server"></asp:HyperLink> <span class="label label-success">$</span></td>
                </tr>
                <tr>
                    <td>Add/Edit Booth Staff</td>
                    <td>
                        <asp:HyperLink ID="lnkExhibitorStaff" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Learning Lab Proposal Submission</td>
                    <td>
                        <asp:HyperLink ID="lnkLearningLab" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <th colspan="2" class="info">Short Courses</th>
                </tr>
                <tr>
                    <td>Short Course Proposal Submission</td>
                    <td>
                        <asp:HyperLink ID="lnkShortCourseProposal" runat="server"></asp:HyperLink></td>
                </tr>

                <tr>
                    <td>Short Course Selection</td>
                    <td>
                        <asp:HyperLink ID="lnkShortCourse" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Short Course Balance (Payment)</td>
                    <td>
                        <asp:HyperLink ID="lnkShortCourseBalance" runat="server"></asp:HyperLink> <span class="label label-success">$</span></td>
                </tr>
                <tr>
                    <th colspan="2" class="info">Abstracts</th>
                </tr>
                <tr>
                    <td>Abstract Submission</td>
                    <td>
                        <asp:HyperLink ID="lnkAbstract" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td>Abstract Review</td>
                    <td>
                        <asp:HyperLink ID="lnkAbstractReview" runat="server"></asp:HyperLink></td>
                </tr>
                <tr>
                    <th colspan="2" class="info">Attendee Log</th>
                </tr>
                <tr>
                    <td>Professional Development Daily Attendee Log</td>
                    <td>
                        <asp:HyperLink ID="lnkProfDev" runat="server" NavigateUrl="https://www.scgcorp.com/Battelle-AttendanceLog/index">https://www.scgcorp.com/Battelle-AttendanceLog/index</asp:HyperLink></td>
                </tr>
            </tbody>
        </table>
    </asp:Panel>
</asp:Content>
