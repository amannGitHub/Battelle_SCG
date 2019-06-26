<%@ Page Title="Program Chair Review" Language="vb" AutoEventWireup="false" MasterPageFile="~/Review/Review.Master" CodeBehind="ProgramChair.aspx.vb" Inherits="Battelle.ProgramChair" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <a name="toreview" style="position:relative; top:-240px; display: block;"></a> <h1>
        <asp:Label ID="lblConferenceType" runat="server" Text="Conference"></asp:Label> 
        <%=Page.Title%></h1>
    <asp:HyperLink ID="lnkReturn" runat="server">Return to Review Dashboard</asp:HyperLink> &nbsp; <asp:HyperLink ID="lnkProgramChair2" runat="server">View Overall Standings</asp:HyperLink><br />
    <asp:SqlDataSource ID="SqlDataSourceRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewRoleGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">To Review</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceToReview" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewProgramChairAbstractsGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <small>Jump to: <a href="#myreviews">My Reviews</a> &nbsp; <a href="#finalized">Finalized</a> &nbsp; <a href="#declined">Declined</a></small>

                <asp:GridView ID="gvToReview" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceToReview" CssClass="table table-striped" GridLines="None">
                    <Columns>

                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="viewID" runat="server" Text="Review" NavigateUrl='<%#GetRouteUrl("AbstractsProgramChairReviewAbstractRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>' />
                                        </itemtemplate>
                                    </asp:TemplateField>

                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title" HtmlEncode="False" />
                        <asp:BoundField DataField="AuthorList" HeaderText="Author List"  />
                    </Columns>
                </asp:GridView>

            <a name="myreviews" style="position:relative; top:-240px; display: block;"></a>
            </div>
        </div>
    

    <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">My Reviews</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceToFinalize" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewProgramChairToFinalizeGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <small>Jump to: <a href="#toreview">To Review</a> &nbsp; <a href="#finalized">Finalized</a> &nbsp; <a href="#declined">Declined</a></small>

                <asp:GridView ID="gvToFinalize" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceToFinalize" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="viewID" runat="server" Text="Edit" NavigateUrl='<%#GetRouteUrl("AbstractsProgramChairReviewAbstractRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>' />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False" />
                        <asp:BoundField DataField="AuthorList" HeaderText="Author List"  />
                        <asp:BoundField DataField="TopicGroupCode" HeaderText="Suggested Theme" SortExpression="TopicGroupCode" />
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
                <asp:SqlDataSource ID="SqlDataSourceFinalized" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewProgramChairFinalizedGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <small>Jump to: <a href="#toreview">To Review</a> &nbsp; <a href="#myreviews">My Reviews</a> &nbsp; <a href="#declined">Declined</a></small>
                <asp:GridView ID="gvFinalized" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceFinalized" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsReviewViewRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>'  />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                        <asp:BoundField DataField="AuthorList" HeaderText="AuthorList"  />
                        <asp:BoundField DataField="TopicGroupCode" HeaderText="Suggested Theme" SortExpression="TopicGroupCode" />
                        <asp:BoundField DataField="TopicCode" HeaderText="Suggested Topic" SortExpression="TopicCode" />
                    </Columns>
                </asp:GridView>
                <a name="returned" style="position:relative; top:-240px; display: block;"></a>

            </div>
        </div>
    <%--<div class="panel panel-warning">
        <div class="panel-heading">
            <h3 class="panel-title">Returned to Program Chairs</h3>
        </div>
        <div class="panel-body">
            <asp:SqlDataSource ID="SqlDataSourceReturned" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewProgramChairReturnedGet" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="ConferenceID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <small>Jump to: <a href="#toreview">To Review</a> &nbsp; <a href="#myreviews">My Reviews</a>  &nbsp; <a href="#finalized">Finalized</a> &nbsp; <a href="#declined">Declined</a> </small>
            <asp:GridView ID="gvReturned" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceReturned" CssClass="table table-striped" GridLines="None">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                                    <itemtemplate>
                                            <asp:HyperLink ID="viewID" runat="server" Text="Review" NavigateUrl='<%#GetRouteUrl("AbstractsProgramChairReviewAbstractRoute", New With {
                                                            Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>' />
                                    </itemtemplate>
                                </asp:TemplateField>
                    <asp:BoundField DataField="AbstractCode" HeaderText="Code" SortExpression="AbstractCode" />
                    <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                    <asp:BoundField DataField="AuthorList" HeaderText="AuthorList"  />
                    <asp:BoundField DataField="TopicGroupCode" HeaderText="Suggested Theme" SortExpression="TopicGroupCode" />
                    <asp:BoundField DataField="TopicCode" HeaderText="Suggested Topic" SortExpression="TopicCode" />
                </Columns>
            </asp:GridView>
            <a name="declined" style="position:relative; top:-240px; display: block;"></a>
        </div>
    </div>--%>

    <div class="panel panel-danger">
        <div class="panel-heading">
            <h3 class="panel-title">Declined for Conference</h3>
        </div>
        <div class="panel-body">
            <asp:SqlDataSource ID="SqlDataSourceDeclined" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewProgramChairDeclinedGet" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="ConferenceID" Type="Int32" />
                    <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <small>Jump to: <a href="#toreview">To Review</a> &nbsp; <a href="#myreviews">My Reviews</a> &nbsp; <a href="#finalized">Finalized</a></small>
            <asp:GridView ID="gvDeclined" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceDeclined" CssClass="table table-striped" GridLines="None">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                                    <itemtemplate>
                                            <asp:HyperLink ID="viewID" runat="server" Text="Review" NavigateUrl='<%#GetRouteUrl("AbstractsProgramChairReviewAbstractRoute", New With {
                                                            Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>' />
                                    </itemtemplate>
                                </asp:TemplateField>
                    <asp:BoundField DataField="AbstractCode" HeaderText="Code" SortExpression="AbstractCode" />
                    <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                    <asp:BoundField DataField="AuthorList" HeaderText="AuthorList"  />
                    <asp:BoundField DataField="TopicGroupCode" HeaderText="Suggested Theme" SortExpression="TopicGroupCode" />
                    <asp:BoundField DataField="TopicCode" HeaderText="Suggested Topic" SortExpression="TopicCode" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

