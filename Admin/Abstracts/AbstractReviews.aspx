<%@ Page Title="Abstract Review Status" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="AbstractReviews.aspx.vb" Inherits="Battelle.AbstractReviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title %></h1>
    <asp:SqlDataSource ID="SqlDataSourceAbstractReviews" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewGetByConferenceID" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <asp:ImageButton ID="ImageButtonExportXLS" runat="server" ImageUrl="~/images/Excel_XLSX.png" Visible="False" />
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceAbstractReviews" GroupPanelPosition="Top" CellSpacing="-1" GridLines="Both">
        <ExportSettings OpenInNewWindow="true" FileName="AbstractReviews" HideStructureColumns="True">
            <Excel Format="Xlsx" />
        </ExportSettings>
        <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
        </ClientSettings>
        <MasterTableView DataSourceID="SqlDataSourceAbstractReviews" AutoGenerateColumns="false">
            <GroupByExpressions>
                <telerik:GridGroupByExpression>
                    <SelectFields>
                        <telerik:GridGroupByField FieldName="AbstractID" HeaderText="Abstract" />
                    </SelectFields>
                    <GroupByFields>
                        <telerik:GridGroupByField FieldName="AbstractID" SortOrder="Ascending" />
                    </GroupByFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>
            <Columns>
                <telerik:GridBoundColumn DataField="ConferenceID" DataType="System.Int32" FilterControlAltText="Filter ConferenceID column" HeaderText="ConferenceID" SortExpression="ConferenceID" UniqueName="ConferenceID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AbstractID" DataType="System.Int32" FilterControlAltText="Filter AbstractID column" HeaderText="AbstractID" ReadOnly="True" SortExpression="AbstractID" UniqueName="AbstractID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AbstractCode" DataType="System.Int32" FilterControlAltText="Filter AbstractCode column" HeaderText="AbstractCode" SortExpression="AbstractCode" UniqueName="AbstractCode">
                </telerik:GridBoundColumn>       
                <telerik:GridBoundColumn DataField="Title" FilterControlAltText="Filter Title column" HeaderText="Title" SortExpression="Title" UniqueName="Title">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AuthorList" FilterControlAltText="Filter AuthorList column" HeaderText="AuthorList" SortExpression="AuthorList" UniqueName="AuthorList">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ReviewDate" FilterControlAltText="Filter ReviewDate column" HeaderText="ReviewDate" SortExpression="ReviewDate" UniqueName="ReviewDate">
                </telerik:GridBoundColumn> 
                <telerik:GridBoundColumn DataField="ReviewType" FilterControlAltText="Filter ReviewType column" HeaderText="ReviewType" SortExpression="ReviewType" UniqueName="ReviewType">
                </telerik:GridBoundColumn>   
                <telerik:GridBoundColumn DataField="Reviewer" FilterControlAltText="Filter Reviewer column" HeaderText="Reviewer" SortExpression="Reviewer" UniqueName="Reviewer">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ReviewFinalDate" FilterControlAltText="Filter ReviewFinalDate column" HeaderText="ReviewFinalDate" SortExpression="ReviewFinalDate" UniqueName="ReviewFinalDate">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Comments" FilterControlAltText="Filter Comments column" HeaderText="Comments" SortExpression="Comments" UniqueName="Comments">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ReadyForReview" FilterControlAltText="Filter RadyForReview column" HeaderText="ReadyForReview" SortExpression="ReadyForReview" UniqueName="ReadyForReview">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="WithdrawnDate" FilterControlAltText="Filter WithdrawnDate column" HeaderText="WithdrawnDate" SortExpression="WithdrawnDate" UniqueName="WithdrawnDate">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopicGroup" FilterControlAltText="Filter TopicGroup column" HeaderText="TopicGroup" SortExpression="TopicGroup" UniqueName="TopicGroup">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopicGroupCode" FilterControlAltText="Filter TopicGroupCode column" HeaderText="TopicGroupCode" SortExpression="TopicGroupCode" UniqueName="TopicGroupCode">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopicCode" FilterControlAltText="Filter TopicCode column" HeaderText="TopicCode" SortExpression="TopicCode" UniqueName="TopicCode">
                </telerik:GridBoundColumn>    
                <telerik:GridBoundColumn DataField="SessionCode" FilterControlAltText="Filter SessionCode column" HeaderText="SessionCode" SortExpression="SessionCode" UniqueName="SessionCode">
                </telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="PersonID" DataType="System.Int32" FilterControlAltText="Filter PersonID column" HeaderText="PersonID" SortExpression="PersonID" UniqueName="PersonID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DateReceived" FilterControlAltText="Filter DateReceived column" HeaderText="DateReceived" SortExpression="DateReceived" UniqueName="DateReceived">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PreferredFormat" FilterControlAltText="Filter PreferredFormat column" HeaderText="PreferredFormat" SortExpression="PreferredFormat" UniqueName="PreferredFormat">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SubmissionRequestedBy" FilterControlAltText="Filter SubmissionRequestedBy column" HeaderText="SubmissionRequestedBy" SortExpression="SubmissionRequestedBy" UniqueName="SubmissionRequestedBy">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AuthorComments" FilterControlAltText="Filter AuthorComments column" HeaderText="AuthorComments" SortExpression="AuthorComments" UniqueName="AuthorComments">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ApplicableTopics" FilterControlAltText="Filter ApplicableTopics column" HeaderText="ApplicableTopics" SortExpression="ApplicableTopics" UniqueName="ApplicableTopics">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ApplicableTopic1" FilterControlAltText="Filter ApplicableTopic1 column" HeaderText="ApplicableTopic1" SortExpression="ApplicableTopic1" UniqueName="ApplicableTopic1">
                </telerik:GridBoundColumn> 
                <telerik:GridBoundColumn DataField="ApplicableTopic2" FilterControlAltText="Filter ApplicableTopic2 column" HeaderText="ApplicableTopic2" SortExpression="ApplicableTopic2" UniqueName="ApplicableTopic2">
                </telerik:GridBoundColumn>     
                <telerik:GridBoundColumn DataField="TopicGroupID" DataType="System.Int32" FilterControlAltText="Filter TopicGroupID column" HeaderText="TopicGroupID" SortExpression="TopicGroupID" UniqueName="TopicGroupID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NewTopicArea" FilterControlAltText="Filter NewTopicArea column" HeaderText="NewTopicArea" SortExpression="NewTopicArea" UniqueName="NewTopicArea">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LoginNotes" FilterControlAltText="Filter LoginNotes column" HeaderText="LoginNotes" SortExpression="LoginNotes" UniqueName="LoginNotes">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SessionID" DataType="System.Int32" FilterControlAltText="Filter SessionID column" HeaderText="SessionID" SortExpression="SessionID" UniqueName="SessionID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Declined" FilterControlAltText="Filter Declined column" HeaderText="Declined" SortExpression="Declined" UniqueName="Declined">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProgramChairFinal" FilterControlAltText="Filter ProgramChairFinal column" HeaderText="ProgramChairFinal" SortExpression="ProgramChairFinal" UniqueName="ProgramChairFinal">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SteeringComFinal" FilterControlAltText="Filter SteeringComFinal column" HeaderText="SteeringComFinal" SortExpression="SteeringComFinal" UniqueName="SteeringComFinal">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ReadyForSessionChair" FilterControlAltText="Filter ReadyForSessionChair column" HeaderText="ReadyForSessionChair" SortExpression="ReadyForSessionChair" UniqueName="ReadyForSessionChair">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SessionChairFinal" FilterControlAltText="Filter SessionChairFinal column" HeaderText="SessionChairFinal" SortExpression="SessionChairFinal" UniqueName="SessionChairFinal">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ReviewNotes" FilterControlAltText="Filter ReviewNotes column" HeaderText="ReviewNotes" SortExpression="ReviewNotes" UniqueName="ReviewNotes">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FinalFormat" FilterControlAltText="Filter FinalFormat column" HeaderText="FinalFormat" SortExpression="FinalFormat" UniqueName="FinalFormat">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FinalDate" FilterControlAltText="Filter FinalDate column" HeaderText="FinalDate" SortExpression="FinalDate" UniqueName="FinalDate">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AdminPersonID" DataType="System.Int32" FilterControlAltText="Filter AdminPersonID column" HeaderText="AdminPersonID" SortExpression="AdminPersonID" UniqueName="AdminPersonID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DeclineNotes" FilterControlAltText="Filter DeclineNotes column" HeaderText="DeclineNotes" SortExpression="DeclineNotes" UniqueName="DeclineNotes">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PlatformTime" FilterControlAltText="Filter PlatformTime column" HeaderText="PlatformTime" SortExpression="PlatformTime" UniqueName="PlatformTime">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PosterNum" DataType="System.Int32" FilterControlAltText="Filter PosterNum column" HeaderText="PosterNum" SortExpression="PosterNum" UniqueName="PosterNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="UpdatedAbstractReceived"  FilterControlAltText="Filter UpdatedAbstractReceived column" HeaderText="UpdatedAbstractReceived" SortExpression="UpdatedAbstractReceived" UniqueName="UpdatedAbstractReceived">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="UpdatedAbstractNotes"  FilterControlAltText="Filter UpdatedAbstractNotes column" HeaderText="UpdatedAbstractNotes" SortExpression="UpdatedAbstractNotes" UniqueName="UpdatedAbstractNotes">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcPaperReceived"  FilterControlAltText="Filter ProcPaperReceived column" HeaderText="ProcPaperReceived" SortExpression="ProcPaperReceived" UniqueName="ProcPaperReceived">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcPaperNotes"  FilterControlAltText="Filter ProcPaperNotes column" HeaderText="ProcPaperNotes" SortExpression="ProcPaperNotes" UniqueName="ProcPaperNotes">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcPaperTitle"  FilterControlAltText="Filter ProcPaperTitle column" HeaderText="ProcPaperTitle" SortExpression="ProcPaperTitle" UniqueName="ProcPaperTitle">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcPaperAuthList"  FilterControlAltText="Filter ProcPaperAuthList column" HeaderText="ProcPaperAuthList" SortExpression="ProcPaperAuthList" UniqueName="ProcPaperAuthList">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SpeakerBioReceived"  FilterControlAltText="Filter SpeakerBioReceived column" HeaderText="SpeakerBioReceived" SortExpression="SpeakerBioReceived" UniqueName="SpeakerBioReceived">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ProcDocNum"  FilterControlAltText="Filter ProcDocNum column" HeaderText="ProcDocNum" SortExpression="ProcDocNum" UniqueName="ProcDocNum">
                </telerik:GridBoundColumn>             
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</asp:Content>