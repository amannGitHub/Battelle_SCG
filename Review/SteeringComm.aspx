<%@ Page Title="Steering Committee Review" Language="vb" AutoEventWireup="false" MasterPageFile="~/Review/Review.Master" CodeBehind="SteeringComm.aspx.vb" Inherits="Battelle.SteeringComm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <a name="toreview" style="position:relative; top:-240px; display: block;"></a>
        <h1>
        <asp:Label ID="lblConferenceType" runat="server" Text="Conference"></asp:Label> 
        <%=Page.Title%></h1>
    <asp:HyperLink ID="lnkReturn" runat="server">Return to Review Dashboard</asp:HyperLink>
    <asp:SqlDataSource ID="SqlDataSourceRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewRoleGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">To Review</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceToReview" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewSteeringCommitteeAbstractsGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <small>Jump to: <a href="#myreviews">My Reviews</a> &nbsp; <a href="#finalized">Finalized</a></small>

                <asp:GridView ID="gvToReview" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceToReview" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="viewID" runat="server" Text="Review" NavigateUrl='<%#GetRouteUrl("AbstractsSteeringCommReviewAbstractRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .theme = Eval("TopicGroupID"), Key .code = Eval("AbstractCode")})%>' />
                                        </itemtemplate>
                                    </asp:TemplateField>

                        <asp:BoundField DataField="TopicGroupCode" HeaderText="Current Theme" SortExpression="TopicGroupCode" />
                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title" HtmlEncode="False" />
                        <asp:BoundField DataField="AuthorList" HeaderText="Author List"  />
                        <asp:BoundField DataField="Reviews" HeaderText="Reviews" SortExpression="Reviews" />
                    </Columns>
                </asp:GridView>
                <a name="myreviews" style="position:relative; top:-240px; display: block;"></a>

            </div>
        </div>


    <div class="panel panel-warning">
            <div class="panel-heading">
                <h3 class="panel-title">My Reviews</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceReviewed" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewSteeringCommitteeReviewedGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <small>Jump to: <a href="#toreview">To Review</a> &nbsp; <a href="#finalized">Finalized</a></small>

                <asp:GridView ID="gvReviewed" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceReviewed" CssClass="table table-striped" GridLines="None">
                    <Columns>

                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="viewID" runat="server" Text="Edit" NavigateUrl='<%#GetRouteUrl("AbstractsSteeringCommReviewAbstractRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .theme = Eval("TopicGroupID"), Key .code = Eval("AbstractCode")})%>' />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False" />
                        <asp:BoundField DataField="AuthorList" HeaderText="Author List"  />
                        <asp:BoundField DataField="Reviews" HeaderText="Reviews" SortExpression="Reviews" />
                        <asp:BoundField DataField="TopicGroupCode" HeaderText="Current Theme" SortExpression="TopicGroupCode" />
                        <asp:BoundField DataField="TopicCode" HeaderText="Suggested Topic" SortExpression="TopicCode" />
                        <asp:BoundField DataField="Decline" HeaderText="Decline" SortExpression="Decline" />
                    </Columns>
                </asp:GridView>

                <a name="finalized" style="position:relative; top:-240px; display: block;"></a>
            </div>
        </div>

    
    <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">Finalized</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceFinalized" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewSteeringCommitteeFinalizedGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <small>Jump to: <a href="#toreview">To Review</a> &nbsp; <a href="#myreviews">My Reviews</a></small>
                <asp:GridView ID="gvFinalized" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceFinalized" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsReviewViewRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>' />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                        <asp:BoundField DataField="AuthorList" HeaderText="Author List"  />
                        <asp:BoundField DataField="TopicGroupCode" HeaderText="Current Theme" SortExpression="TopicGroupCode" />
                        <asp:BoundField DataField="TopicCode" HeaderText="Current Topic" SortExpression="TopicCode" />
                    </Columns>
                </asp:GridView>


            </div>
        </div>

        <div class="panel panel-danger">
            <div class="panel-heading">
                <h3 class="panel-title">Returned to Program Chairs</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceReturned" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewSteeringCommitteeReturnedGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32"  />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <small>Jump to: <a href="#toreview">To Review</a> &nbsp; <a href="#myreviews">My Reviews</a>  &nbsp; <a href="#finalized">Finalized</a> </small>
                <asp:GridView ID="gvReturned" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceReturned" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsReviewViewRoute", New With {
                                                                Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>' />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                        <asp:BoundField DataField="AuthorList" HeaderText="Author List"  />
                    </Columns>
                </asp:GridView>


            </div>
        </div>
</asp:Content>
