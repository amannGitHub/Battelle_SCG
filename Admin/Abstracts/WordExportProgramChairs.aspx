<%@ Page Title="Abstract Export" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="WordExportProgramChairs.aspx.vb" Inherits="Battelle.WordExportProgramChairs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
<asp:SqlDataSource ID="SqlDataSourceAbstracts" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractExport" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="btnExport" runat="server" Text="Save Word Files" />
    <%-- Normal export
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceAbstracts">
            <Columns>
                <asp:BoundField DataField="AbstractCode" HeaderText="AbstractCode" SortExpression="AbstractCode" />
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="AuthorList" HeaderText="AuthorList" SortExpression="AuthorList" />
                <asp:BoundField DataField="AbstractTitleAuthorBlock" HeaderText="AbstractTitleAuthorBlock" SortExpression="AbstractTitleAuthorBlock" />
                <asp:BoundField DataField="AbstractBG" HeaderText="AbstractBG" SortExpression="AbstractBG" />
                <asp:BoundField DataField="AbstractApproach" HeaderText="AbstractApproach" SortExpression="AbstractApproach" />
                <asp:BoundField DataField="AbstractResults" HeaderText="AbstractResults" SortExpression="AbstractResults" />
                <asp:BoundField DataField="FinalDate" HeaderText="FinalDate" SortExpression="FinalDate" />
                <asp:BoundField DataField="FinalFormat" HeaderText="FinalFormat" SortExpression="FinalFormat" />
                <asp:BoundField DataField="SessionCode" HeaderText="SessionCode" SortExpression="SessionCode" />
                <asp:BoundField DataField="AbstractID" HeaderText="AbstractID" ReadOnly="True" SortExpression="AbstractID" InsertVisible="False" /> 
            </Columns>
        </asp:GridView>  --%> 
    <%-- Program Chair Export --%>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceAbstracts">
            <Columns>
                <asp:BoundField DataField="AbstractCode" HeaderText="AbstractCode" SortExpression="AbstractCode" />
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="AuthorList" HeaderText="AuthorList" SortExpression="AuthorList" />
                <asp:BoundField DataField="AbstractTitleAuthorBlock" HeaderText="AbstractTitleAuthorBlock" SortExpression="AbstractTitleAuthorBlock" />
                <asp:BoundField DataField="AbstractBG" HeaderText="AbstractBG" SortExpression="AbstractBG" />
                <asp:BoundField DataField="AbstractApproach" HeaderText="AbstractApproach" SortExpression="AbstractApproach" />
                <asp:BoundField DataField="AbstractResults" HeaderText="AbstractResults" SortExpression="AbstractResults" />
                <asp:BoundField DataField="FinalDate" HeaderText="FinalDate" SortExpression="FinalDate" />
                <asp:BoundField DataField="FinalFormat" HeaderText="FinalFormat" SortExpression="FinalFormat" />
                <asp:BoundField DataField="AbstractID" HeaderText="AbstractID" ReadOnly="True" SortExpression="AbstractID" InsertVisible="False" />
                <asp:BoundField DataField="CorrPresAuthor" HeaderText="CorrPresAuthor" SortExpression="CorrPresAuthor" />
                <asp:BoundField DataField="PreferredFormat" HeaderText="PreferredFormat" SortExpression="PreferredFormat" />
                <asp:BoundField DataField="SubmissionRequestedBy" HeaderText="SubmissionRequestedBy" SortExpression="SubmissionRequestedBy" />
                <asp:BoundField DataField="AuthorComments" HeaderText="AuthorComments" SortExpression="AuthorComments" />
                <asp:BoundField DataField="ApplicableTopics" HeaderText="ApplicableTopics" SortExpression="ApplicableTopics" />
                <asp:BoundField DataField="NewTopicArea" HeaderText="NewTopicArea" SortExpression="NewTopicArea" />
                <asp:BoundField DataField="LoginNotes" HeaderText="LoginNotes" SortExpression="LoginNotes" />
                <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
            </Columns>
        </asp:GridView>
</asp:Content>

