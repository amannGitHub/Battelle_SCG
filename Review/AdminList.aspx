<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Review/Review.Master" CodeBehind="AdminList.aspx.vb" Inherits="Battelle.AdminList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <a name="notreviewed" style="position:relative; top:-240px; display: block;"></a>
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
                <h3 class="panel-title">Not Finalized by Session Chairs</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceSessionNotFinalized" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractAdminSessionNotFinalizedGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                <small>Jump to: <a href="#finalsessionaccept">Finalized and Accepted by Session Chairs</a> &nbsp; <a href="#finalsessiondecline">Finalized and Declined by Session Chairs</a> &nbsp; <a href="#finaladmin">Finalized by Admin</a></small>
                <asp:GridView ID="gvNotFinalized" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceSessionNotFinalized" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsAdminReviewFinalRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode"), Key .admin = "true"})%>'  />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                        <asp:BoundField DataField="AuthorList" HeaderText="AuthorList"  />
                        <asp:BoundField DataField="TopicCode" HeaderText="Session Chairs' Decision" SortExpression="TopicCode" />
                        <asp:BoundField DataField="PresentationFormat" HeaderText="Format" SortExpression="PresentationFormat" />
                    </Columns>
                </asp:GridView>
                
                <a name="finalsessionaccept" style="position:relative; top:-240px; display: block;"></a>

            </div>
        </div>

        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">Finalized and Accepted by Session Chairs</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceSessionFinalizedAccepted" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractAdminSessionFinalizedGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:Parameter Name="decline" Type="Int32" DefaultValue="0" />
                    </SelectParameters>
                </asp:SqlDataSource>

             
                <small>Jump to: <a href="#notreviewed">Not Reviewed by Session Chairs</a> &nbsp; <a href="#finalsessiondecline">Finalized and Declined by Session Chairs</a> &nbsp; <a href="#finaladmin">Finalized by Admin</a></small>
                <asp:GridView ID="gvFinalizedAccepted" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceSessionFinalizedAccepted" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsAdminReviewFinalRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode"), Key .admin = "true"})%>'  />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                        <asp:BoundField DataField="AuthorList" HeaderText="AuthorList"  />
                        <asp:BoundField DataField="TopicCode" HeaderText="Session Chairs' Decision" SortExpression="TopicCode" />
                        <asp:BoundField DataField="PresentationFormat" HeaderText="Format" SortExpression="PresentationFormat" />
                    </Columns>
                </asp:GridView>

                <a name="finalsessiondecline" style="position:relative; top:-240px; display: block;"></a>

            </div>
        </div>

        
        <div class="panel panel-warning">
            <div class="panel-heading">
                <h3 class="panel-title">Finalized and Declined by Session Chairs</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceSessionFinalizedDeclined" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractAdminSessionFinalizedGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:Parameter Name="decline" Type="Int32" DefaultValue="1" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                <small>Jump to: <a href="#notreviewed">Not Reviewed by Session Chairs</a> &nbsp; <a href="#finalsessionaccept">Finalized and Accepted by Session Chairs</a> &nbsp; <a href="#finaladmin">Finalized by Admin</a></small>
                <asp:GridView ID="gvFinalizedDeclined" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceSessionFinalizedDeclined" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsAdminReviewFinalRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode"), Key .admin = "true"})%>'  />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                        <asp:BoundField DataField="AuthorList" HeaderText="AuthorList"  />
                    </Columns>
                </asp:GridView>
                
                <a name="finaladmin" style="position:relative; top:-240px; display: block;"></a>

            </div>
        </div>


        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Finalized by Admin</h3>
            </div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSourceAdminFinalized" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractAdminFinalizedGet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>  
                <small>Jump to: <a href="#notreviewed">Not Reviewed by Session Chairs</a> &nbsp; <a href="#finalsessionaccept">Finalized and Accepted by Session Chairs</a> &nbsp; <a href="#finalsessiondecline">Finalized and Declined by Session Chairs</a></small>

                <asp:GridView ID="gvAdminFinalized" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceAdminFinalized" CssClass="table table-striped" GridLines="None">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsAdminReviewFinalRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode"), Key .admin = "true"})%>'  />
                                        </itemtemplate>
                                    </asp:TemplateField>
                        <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                        <asp:BoundField DataField="Title" HeaderText="Title"  HtmlEncode="False"  />
                        <asp:BoundField DataField="AuthorList" HeaderText="AuthorList"  />
                        <asp:BoundField DataField="TopicCode" HeaderText="Administrators' Decision" SortExpression="TopicCode" />
                        <asp:BoundField DataField="FinalFormat" HeaderText="Format" SortExpression="FinalFormat" />
                    </Columns>
                </asp:GridView>

 
            </div>
        </div>


</asp:Content>
