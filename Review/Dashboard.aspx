<%@ Page Title="Abstract Review" Language="vb" AutoEventWireup="false" MasterPageFile="~/Review/Review.Master" CodeBehind="Dashboard.aspx.vb" Inherits="Battelle.Dashboard" %>

<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        <asp:Label ID="lblConferenceType" runat="server" Text="Conference"></asp:Label>
        <%=Page.Title%></h1>

    <asp:Panel ID="PanelParticipationControl" runat="server" Visible="True">
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" />
    </asp:Panel>
    <asp:SqlDataSource ID="SqlDataSourceRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewRoleGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel ID="PanelProgramChair" runat="server" Visible="false">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Program Chair Review</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceProgChair" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewProgramChairCountGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="gvProgChair" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProgChair" CssClass="table table-striped" BorderWidth="0" BorderStyle="NotSet" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="ToReview" HeaderText="To Review" ReadOnly="True" SortExpression="ToReview" />
                        <asp:BoundField DataField="ToFinalize" HeaderText="My Reviews" ReadOnly="True" SortExpression="ToFinalize" />
                        <asp:BoundField DataField="Finalized" HeaderText="Finalized" ReadOnly="True" SortExpression="Finalized" />
                        <asp:BoundField DataField="Declined" HeaderText="Declined for Conference" ReadOnly="true" SortExpression="Declined" />
                    </Columns>
                </asp:GridView>
                <asp:HyperLink ID="lnkProgChairReview" runat="server">Go to Review</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="lnkProgChairOverall" runat="server">Go to Overall Standings</asp:HyperLink>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="PanelReturnedToProgramChairs" runat="server" Visible="false">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Returned to Program Chairs</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceReturned" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReReviewProgramChairCountGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="gvReturned" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceReturned" CssClass="table table-striped" BorderWidth="0" BorderStyle="NotSet" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="ToReview" HeaderText="To Review" ReadOnly="true" SortExpression="ToReview" />
                        <asp:BoundField DataField="MyReviews" HeaderText="My Reviews" ReadOnly="true" SortExpression="MyReviews" />
                        <asp:BoundField DataField="Finalized" HeaderText="Finalized" ReadOnly="True" SortExpression="Finalized" />
                        <asp:BoundField DataField="Declined" HeaderText="Declined for Conference" ReadOnly="true" SortExpression="Declined" />
                    </Columns>
                </asp:GridView>
                <asp:HyperLink ID="lnkProgChairReReview" runat="server">Go to Review</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="lnkReReviewOverall" runat="server">Go to Overall Standings</asp:HyperLink>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="PanelSteeringCommittee" runat="server" Visible="false">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Steering Committee Review</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceSteeringComm" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewSteeringCommitteeCountGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="gvSteeringComm" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceSteeringComm" CssClass="table table-striped" BorderWidth="0" BorderStyle="NotSet" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="ToReview" HeaderText="To Review" ReadOnly="True" SortExpression="ToReview" />
                        <asp:BoundField DataField="Reviewed" HeaderText="My Reviews" ReadOnly="True" SortExpression="Reviewed" />
                        <asp:BoundField DataField="Finalized" HeaderText="Finalized" ReadOnly="True" SortExpression="Finalized" />
                        <asp:BoundField DataField="Declined" HeaderText="Returned to Program Chairs" ReadOnly="True" SortExpression="Declined" />
                    </Columns>
                </asp:GridView>
                <asp:HyperLink ID="lnkSteeringComm" runat="server">Go to Review</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="lnkSteeringCommOverall" runat="server">Go to Overall Standings</asp:HyperLink>
            </div>
        </div>
     </asp:Panel>

    <asp:Panel ID="PanelSessionChair" runat="server" Visible="false">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Session Chair Review</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceSessionChair" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewSessionChairCountGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="gvSessionChair" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceSessionChair" CssClass="table table-striped" BorderWidth="0" BorderStyle="NotSet" GridLines="None" Enabled="False">
                    <Columns>
                        <asp:BoundField DataField="ToReview" HeaderText="To Review" ReadOnly="True" SortExpression="ToReview" />
                        <asp:BoundField DataField="Reviewed" HeaderText="My Reviews" ReadOnly="True" SortExpression="Reviewed" />
                        <asp:BoundField DataField="Finalized" HeaderText="Finalized" ReadOnly="True" SortExpression="Finalized" />
                        <asp:BoundField DataField="Declined" HeaderText="Returned to Program Chairs" ReadOnly="True" SortExpression="Declined" />
                    </Columns>
                </asp:GridView>
                <asp:HyperLink ID="lnkSessionChairReview" runat="server">Go to Review</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="lnkSessionChairOverall" runat="server">Go to Overall Standings</asp:HyperLink>
            </div>
        </div>
    </asp:Panel>



        <asp:Panel ID="PanelAdmin" runat="server" Visible="false">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Admin Review</h3>
            </div>
            <div class="panel-body">
                <asp:HyperLink ID="lnkAdminReview" runat="server">Go to Review</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="lnkAdminOverall" runat="server">Go to Overall Standings</asp:HyperLink>
            </div>
        </div>


    </asp:Panel>
    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
</asp:Content>
