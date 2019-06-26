<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="SCG.aspx.vb" Inherits="Battelle.SCGLinks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>SCG Useful Links</h1>
    Active Session: <i>
        <asp:Label ID="lblSession" runat="server" Text="None (Refresh page if unsure)"></asp:Label></i>&nbsp;<asp:LinkButton ID="lnkbtnSession" runat="server" Visible="False">Clear Session</asp:LinkButton><br />

    <div class="row">
        <div class="col-md-4">
            <h2>Conference Management</h2>
            <ul>
                <li>

                    <asp:HyperLink ID="lnkConferences" runat="server" NavigateUrl="~/admin/conferences" Target="_blank">Conferences</asp:HyperLink>

                </li>
                <li>On-site Links
                <ul>
                    <li>
                        <asp:HyperLink ID="lnkOnSiteBadge" runat="server" NavigateUrl="~/admin/attendee/OnSiteBadgeReport" Target="_blank">On Site Badge List</asp:HyperLink></li>
                </ul>
                </li>
                <li>
                    <asp:HyperLink ID="lnkSiteLinks" runat="server" NavigateUrl="~/admin/sitelinks">Site Links</asp:HyperLink>
                    <span class="label label-success">New!</span>
                </li>
            </ul>
        </div>
        <div class="col-md-4">
            <h2>Exhibitors</h2>
            <ul>
                <li>
                    <asp:HyperLink ID="lnkExhibit" runat="server" NavigateUrl="~/admin/exhibit/list" Target="_blank">Exhibitor & Sponsor Ledgers</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="HyperLinkSponsors" runat="server" NavigateUrl="~/Admin/Exhibit/Sponsors.aspx">Sponsors Logo/Descriptions</asp:HyperLink><br />
                </li>
                <li>
                    <asp:HyperLink ID="lnkExhibitBalance" runat="server" NavigateUrl="~/admin/exhibit/exhibitorreport" Target="_blank">Exhibitor Report</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="lnkBoothStaff" runat="server" NavigateUrl="~/admin/exhibit/boothstafflist" Target="_blank">Booth Staff</asp:HyperLink></li>

                <li>
                    <asp:HyperLink ID="lnkOrgID" runat="server" NavigateUrl="~/admin/Exhibit/OrganizationIDReport" Target="_blank">Organization ID Report</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="ExhibitorLookup" runat="server" NavigateUrl="~/Admin/OrganizationInfo" Target="_blank">Organization Info</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="lnkPOCLedger" runat="server" NavigateUrl="~/admin/exhibit/LedgerByPOC" Target="_blank">POC Ledgers</asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="lnkBoothTech" runat="server" NavigateUrl="~/admin/exhibit/OnSiteStaffTechRegReport" Target="_blank">Remaining Booth Staff & Tech Reg Report</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="lnkExhibitorMailingListFee" runat="server" NavigateUrl="~/admin/Exhibit/ExhibitorMailingListReport" Target="_blank">Exhibitor Mailing List Fee Report</asp:HyperLink>

                </li>
            </ul>
        </div>
        <div class="col-md-4">
            <h2>Attendees</h2>
            <ul>
                <li>
                    <asp:HyperLink ID="lnkAttendeeBalance" runat="server" NavigateUrl="~/Admin/Attendee/Attendeereport" Target="_blank">Attendee Report</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="lnkAttendeeView" runat="server" NavigateUrl="~/admin/attendee/attendeeview" Target="_blank">Attendee Ledgers</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="lnkAttendanceCount" runat="server" NavigateUrl="~/admin/attendee/attendancecount" Target="_blank">Attendance Counts</asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="lnkBadgeReport" runat="server" NavigateUrl="~/admin/ReportBadge" Target="_blank">Badge List Report</asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="lnkProfDev" runat="server" NavigateUrl="https://www.scgcorp.com/Battelle-AttendanceLog/index">Professional Development Daily Attendee Log</asp:HyperLink>
                </li>
            </ul>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <h2>Short Course</h2>
            <ul>
                <li>
                    <asp:HyperLink ID="lnkShortCourseAtt" runat="server" NavigateUrl="~/admin/shortcourse/shortcourseattendance" Target="_blank">Short Course Attendance</asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="lnkShortCourseOverview" runat="server" NavigateUrl="~/admin/shortcourse/ShortCourseOverview" Target="_blank">Short Course Overview</asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="lnkShortCourseMaxCap" runat="server" NavigateUrl="~/admin/shortcourse/ShortCourseCapacity" Target="_blank">Short Course Max Capacity</asp:HyperLink>
                </li>
            </ul>
        </div>
        <div class="col-md-4">
            <h2>Abstracts</h2>
            <ul>
                <li>
                    <asp:HyperLink ID="lnkAbstracts" runat="server" NavigateUrl="~/admin/abstracts/manager" Target="_blank">Abstracts</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="lnkAbstractReviewRoles" runat="server" NavigateUrl="~/admin/abstracts/ConferenceRoles" Target="_blank">Abstract Review Roles</asp:HyperLink></li>

            <li>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/admin/abstracts/AbstractLock" Target="_blank">Abstract Review Group Lock</asp:HyperLink></li>
            </ul>
        </div>
        <div class="col-md-4">
            <h2>Money</h2>
            <ul>
                <li>
                    <asp:HyperLink ID="lnkBalance" runat="server" NavigateUrl="~/admin/attendee/balancesummary" Target="_blank">Balance $ummary</asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="lnkAttendeeLedger2" runat="server" NavigateUrl="~/admin/attendee/attendeeview" Target="_blank">Attendee Ledgers</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="lnkExhibitorLedger2" runat="server" NavigateUrl="~/admin/exhibit/list" Target="_blank">Exhibitor Ledgers</asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="lnkPOCLedger2" runat="server" NavigateUrl="~/admin/exhibit/LedgerByPOC" Target="_blank">POC Ledgers</asp:HyperLink>
                </li>
            </ul>
        </div>
    </div>
    <div class="row">

        <div class="col-md-4">
            <h2>Other Admin</h2>
            <ul>

                <li>
                    <asp:HyperLink ID="lnkUsers" runat="server" NavigateUrl="~/admin/users" Target="_blank">Battelle Users</asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="lnkQuery" runat="server" NavigateUrl="~/admin/querybuilder" Target="_blank">Query Builder</asp:HyperLink>
                </li>
            </ul>
        </div>
        <div class="col-md-4">
            <h2>Person Management</h2>
            <ul>
                <li>
                    <asp:HyperLink ID="lnkPerson" runat="server" NavigateUrl="~/admin/personlist" Target="_blank">Person List</asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="lnkPersonManage" runat="server" NavigateUrl="~/admin/personmanage" Target="_blank">Person Manager</asp:HyperLink><br />
                </li>
                <li>
                    <asp:HyperLink ID="lnkDuplicate" runat="server" NavigateUrl="~/admin/personduplicate" Target="_blank">Person Duplicate</asp:HyperLink>
                </li>
            </ul>
            <asp:SqlDataSource ID="SqlDataSourceParticipant" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT LastName + ', ' + FirstName + ' - ' + Employer AS FullName, PersonID, ParticipationID FROM Person"></asp:SqlDataSource>
            Search People:
        <telerik:RadAutoCompleteBox ID="txtPersonLookup" runat="server" DataSourceID="SqlDataSourceParticipant" DataTextField="FullName" InputType="Text" DropDownWidth="300"></telerik:RadAutoCompleteBox>
            <asp:Button ID="btnPersonLookup" runat="server" CausesValidation="True" Text="Find ParticipationID" />
            <asp:Label ID="lblParticipationID" runat="server"></asp:Label>
        </div>
    </div>


</asp:Content>
