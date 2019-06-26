<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Review/Review.Master" CodeBehind="ProgramChairPart2.aspx.vb" Inherits="Battelle.ProgramChairPart2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <a name="toreview" style="position:relative; top:-240px; display: block;"></a> <h1>
        <asp:Label ID="lblConferenceType" runat="server" Text="Conference"></asp:Label> 
        <%=Page.Title%></h1>
    <asp:HyperLink ID="lnkReturn" runat="server">Return to Review Dashboard</asp:HyperLink> &nbsp; <asp:HyperLink ID="lnkProgramChair" runat="server">Program Chair Review</asp:HyperLink><br />
    <asp:SqlDataSource ID="SqlDataSourceRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewRoleGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    



    <div class="panel panel-warning">
            <div class="panel-heading">
                <h3 class="panel-title">Overall Standings</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceFinalized" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewOverviewGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:GridView ID="gvFinalized" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceFinalized" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="hlMID" runat="server" Text="Review" NavigateUrl='<%#GetRouteUrl("AbstractsProgramChairReviewAbstractRoute", New With {
                                                                            Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>'  />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                        <asp:BoundField DataField="AuthorList" HeaderText="AuthorList"  />
                        <asp:BoundField DataField="TopicGroupCode" HeaderText="Suggested Theme" SortExpression="TopicGroupCode" />
                        <asp:BoundField DataField="TopicCode" HeaderText="Suggested Topic" SortExpression="TopicCode" />
                        <asp:BoundField DataField="Decline" HeaderText="Declined" SortExpression="Decline" />
                        <asp:BoundField DataField="SessionCode" HeaderText="Session Code" SortExpression="SessionCode" />
                        <asp:BoundField DataField="FinalFormat" HeaderText="Current Format" SortExpression="FinalFormat" />
                    </Columns>
                </asp:GridView>

            </div>
        </div>
  
</asp:Content>

