<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Abstract/Abstracts.Master" CodeBehind="AbstractList.aspx.vb" Inherits="Battelle.AbstractList" %>

<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <asp:Panel ID="PanelParticipationControl" runat="server" Visible="False">
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" OnFinishedLogin="ParticipationIDLogin_FinishedLogin" />
    </asp:Panel>
    <asp:Panel ID="PanelAbstractList" runat="server">
        <asp:SqlDataSource ID="SqlDataSourceAbstracts" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractGetByConferenceIDPersonID" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
                <asp:Parameter Name="PersonID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="gvAbstracts" runat="server" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceAbstracts">
            <Columns>
                <asp:BoundField DataField="AbstractID" HeaderText="AbstractID" InsertVisible="False" ReadOnly="True" SortExpression="AbstractID" />
                <asp:BoundField DataField="ConferenceID" HeaderText="ConferenceID" SortExpression="ConferenceID" />
                <asp:BoundField DataField="AbstractCode" HeaderText="AbstractCode" SortExpression="AbstractCode" />
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="AuthorList" HeaderText="AuthorList" SortExpression="AuthorList" />
                <asp:BoundField DataField="DateReceived" HeaderText="DateReceived" SortExpression="DateReceived" />
                <asp:BoundField DataField="PreferredFormat" HeaderText="PreferredFormat" SortExpression="PreferredFormat" />
                <asp:BoundField DataField="SubmissionRequestedBy" HeaderText="SubmissionRequestedBy" SortExpression="SubmissionRequestedBy" />
                <asp:BoundField DataField="AuthorComments" HeaderText="AuthorComments" SortExpression="AuthorComments" />
                <asp:BoundField DataField="ApplicableTopics" HeaderText="ApplicableTopics" SortExpression="ApplicableTopics" />
                <asp:BoundField DataField="NewTopicArea" HeaderText="NewTopicArea" SortExpression="NewTopicArea" />
                <asp:BoundField DataField="AbstractBG" HeaderText="AbstractBG" SortExpression="AbstractBG" />
                <asp:BoundField DataField="AbstractApproach" HeaderText="AbstractApproach" SortExpression="AbstractApproach" />
                <asp:BoundField DataField="AbstractResults" HeaderText="AbstractResults" SortExpression="AbstractResults" />
                <asp:BoundField DataField="FileName" HeaderText="FileName" SortExpression="FileName" />
                <asp:BoundField DataField="LoginNotes" HeaderText="LoginNotes" SortExpression="LoginNotes" />
                <asp:BoundField DataField="WithdrawnDate" HeaderText="WithdrawnDate" SortExpression="WithdrawnDate" />
                <asp:CheckBoxField DataField="Presenter" HeaderText="Presenter" SortExpression="Presenter" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                <asp:BoundField DataField="AddressLine1" HeaderText="AddressLine1" SortExpression="AddressLine1" />
                <asp:BoundField DataField="AddressLine2" HeaderText="AddressLine2" SortExpression="AddressLine2" />
                <asp:BoundField DataField="AddressLine3" HeaderText="AddressLine3" SortExpression="AddressLine3" />
                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                <asp:BoundField DataField="StateProvince" HeaderText="StateProvince" SortExpression="StateProvince" />
                <asp:BoundField DataField="ZipPostal" HeaderText="ZipPostal" SortExpression="ZipPostal" />
                <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
                <asp:BoundField DataField="PhoneNum" HeaderText="PhoneNum" SortExpression="PhoneNum" />
                <asp:BoundField DataField="CellNum" HeaderText="CellNum" SortExpression="CellNum" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            </Columns>
        </asp:GridView>
    </asp:Panel>
</asp:Content>
