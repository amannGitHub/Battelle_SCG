<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="Default.aspx.vb" Inherits="Battelle._Default1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Welcome to the Admin Section

    <h3>Reports</h3>
        <asp:HyperLink ID="HyperLinkAbsPresenters" runat="server" NavigateUrl="~/Admin/Abstracts/ReportAbstractPresenters.aspx">Abstracts and Presenters Report</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkAbsCoAuthors" runat="server" NavigateUrl="~/Admin/Abstracts/ReportAbstractCoAuthors.aspx">Abstracts and Co-Authors Report</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkSessionChairs" runat="server" NavigateUrl="~/Admin/Abstracts/ReportSessionChairs.aspx">Sessions and Chairs Report</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkAbstractOverview" runat="server" NavigateUrl="~/Admin/AbstractOverview.aspx">Abstracts Overview</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkAbstractReviews" runat="server" NavigateUrl="~/Admin/Abstracts/AbstractReviews.aspx">Abstract Review Status</asp:HyperLink><br />
        <asp:HyperLink ID="HyperExhibitorReport" runat="server" NavigateUrl="~/Admin/Exhibit/ExhibitorReport.aspx">Exhibitor Report</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkShortCourses" runat="server" NavigateUrl="~/Admin/ShortCourse/ShortCourseAttendance.aspx">Short Course Registration</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkPanelists" runat="server" NavigateUrl="~/Admin/ReportPanelists.aspx">Panelists Report</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkBadge" runat="server" NavigateUrl="~/Admin/ReportBadge.aspx">Badge List Report</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkPersonRoles" runat="server" NavigateUrl="~/Admin/PersonRoleLookup.aspx">Conference Role Lookup</asp:HyperLink><br />
    <h3>Manage</h3>
        <asp:HyperLink ID="HyperLinkAbstracts" runat="server" NavigateUrl="~/Admin/Abstracts/Manager.aspx">Abstracts</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkAbstractReviewGroupLock" runat="server" NavigateUrl="~/Admin/Abstracts/AbstractLock.aspx">Abstract Review Group Lock</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkAbstractEditor" runat="server" NavigateUrl="~/Admin/AbstractOverviewEditor.aspx">Abstract Review Placement Editor</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkAbstractReviewRoles" runat="server" NavigateUrl="~/Admin/Abstracts/ConferenceRoles.aspx">Abstract Review Roles</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkSessions" runat="server" NavigateUrl="~/Admin/Abstracts/Sessions.aspx">Sessions</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkShortCourse" runat="server" NavigateUrl="~/Admin/ShortCourse/ShortCourseManager.aspx">Short Course</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkShortCourseGroups" runat="server" NavigateUrl="~/Admin/ShortCourse/ShortCourseGroups.aspx">Short Course Groups</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkLearningLab" runat="server" NavigateUrl="~/Admin/Exhibit/LearningLabManager.aspx">Learning Lab</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkSponsors" runat="server" NavigateUrl="~/Admin/Exhibit/Sponsors.aspx">Sponsors Logo/Descriptions</asp:HyperLink><br />
        <asp:HyperLink ID="lnkPersonManage" runat="server" NavigateUrl="~/admin/personmanage" Target="_blank">Person Manager</asp:HyperLink><br />
        <asp:HyperLink ID="lnkDuplicate" runat="server" NavigateUrl="~/admin/personduplicate" Target="_blank">Person Duplicate</asp:HyperLink><br />
        <asp:HyperLink ID="HyperLinkQueryBuilder" runat="server" NavigateUrl="~/Admin/QueryBuilder.aspx">Query Builder</asp:HyperLink><br />
</asp:Content>
