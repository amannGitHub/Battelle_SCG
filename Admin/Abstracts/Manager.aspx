<%@ Page Title="Abstract Manager" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="Manager.aspx.vb" Inherits="Battelle.Manager" %>

<%@ Register Src="~/ConferenceFromURL.ascx" TagPrefix="uc1" TagName="ConferenceFromURL" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
    .Hide
    {
        display: none;
    }
    </style>

    <script type="text/javascript">
        function SetFocus() {
            document.getElementById('<%=ListBoxAbstractAuthors.ClientID%>').focus();
        return false;
    }

    </script>

    <h1><%=Page.Title%></h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceAbstract" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractGetByConferenceID" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceMakeReadyForReview" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractMakeReadyForReview" SelectCommandType="StoredProcedure" DeleteCommand="AbstractMakeReadyForSessionChairReview" DeleteCommandType="StoredProcedure" UpdateCommand="AbstractMakeReadyForReview" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>&nbsp;&nbsp;
            <asp:Button ID="btnMakeReadyForReview" runat="server" Text="Release Abstracts for Review" class="btn btn-default" Visible="False" />&nbsp;&nbsp;
            <asp:Button ID="btnMakeReadyForSessionChairs" runat="server" Text="Release Abstracts for Session Chair Review" class="btn btn-default" Visible="False" /><br />
            <asp:Literal ID="ltlAlert" runat="server" Visible="False"></asp:Literal>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div id="divGrid" style="width: 100%; height: 400px; overflow: auto;">
                        <asp:GridView ID="gvAbstract" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceAbstract" AutoGenerateColumns="False" Visible="False" CssClass="table" DataKeyNames="AbstractID" SelectedRowStyle-CssClass="active">
                            <HeaderStyle CssClass="HeaderFreeze" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" SelectText="Select" />
                                <asp:BoundField DataField="AbstractCode" HeaderText="#" SortExpression="AbstractCode" />
                                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" HtmlEncode="false"/>
                                <asp:BoundField DataField="AuthorList" HeaderText="Author List" SortExpression="AuthorList" />
                                <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived" />
                                <asp:BoundField DataField="SessionCode" HeaderText="Current Session" SortExpression="SessionCode" />
                                <asp:BoundField DataField="FinalFormat" HeaderText="Current Format" SortExpression="FinalFormat" />

                            </Columns>
                            <SelectedRowStyle CssClass="info" />
                        </asp:GridView>
                        </div>
                    </div>
                    </div>
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:SqlDataSource ID="SqlDataSourceAbstractSelected" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractGetByAbstractID" SelectCommandType="StoredProcedure" UpdateCommand="AbstractUpdate" UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvAbstract" Name="AbstractID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:Parameter Name="AbstractCode" Type="Int32" />
                                <asp:Parameter Name="Title" Type="String" />
                                <asp:Parameter Name="AuthorList" Type="String" />
                                <asp:Parameter Name="DateReceived" Type="DateTime" />
                                <asp:Parameter Name="PreferredFormat" Type="String" />
                                <asp:Parameter Name="SubmissionRequestedBy" Type="String" />
                                <asp:Parameter Name="AuthorComments" Type="String" />
                                <asp:Parameter Name="ApplicableTopics" Type="String" />
                                <asp:Parameter Name="NewTopicArea" Type="String" />
                                <asp:Parameter Name="AbstractTitleAuthorBlock" Type="String" />
                                <asp:Parameter Name="AbstractBG" Type="String" />
                                <asp:Parameter Name="AbstractApproach" Type="String" />
                                <asp:Parameter Name="AbstractResults" Type="String" />
                                <asp:Parameter Name="LoginNotes" Type="String" />
                                <asp:Parameter Name="WithdrawnDate" Type="DateTime" />
                                <asp:Parameter Name="ReadyForReview" Type="DateTime" />
                                <asp:Parameter Name="SessionID" Type="Int32" />
                                <asp:Parameter Name="Declined" Type="Boolean" />
                                <asp:Parameter Name="ReviewNotes" Type="String" />
                                <asp:Parameter Name="FinalFormat" Type="String" />
                                <asp:Parameter Name="FinalDate" Type="DateTime" />
                                <asp:Parameter Name="DeclineNotes" Type="String" />
                                <asp:Parameter DbType="Time" Name="PlatformTime" />
                                <asp:Parameter Name="PosterNum" Type="Int32" />
                                <asp:Parameter Name="UpdatedAbstractReceived" Type="DateTime" />
                                <asp:Parameter Name="UpdatedAbstractNotes" Type="String" />
                                <asp:Parameter Name="ProcPaperReceived" Type="DateTime" />
                                <asp:Parameter Name="ProcPaperNotes" Type="String" />
                                <asp:Parameter Name="ProcPaperTitle" Type="String" />
                                <asp:Parameter Name="ProcPaperAuthList" Type="String" />
                                <asp:Parameter Name="SpeakerBioReceived" Type="DateTime" />
                                <asp:Parameter Name="ProcDocNum" Type="String" />
                                <asp:Parameter Name="ProcPosterReceived" Type="DateTime" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceSessionCode" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SessionCodeGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceAbstractSelected" RenderOuterTable="False" Visible="False">
                            <EditItemTemplate>
                                <div class="form-group">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Update" Text="Update" CssClass="btn btn-primary" />
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                AbstractCode: 
                    <asp:TextBox ID="AbstractCodeTextBox" runat="server" Text='<%# Bind("AbstractCode") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                Title:
                    <telerik:RadEditor ID="RadEditorAbstractTitle" runat="server" ContentAreaMode="Div" Height="40px" ToolbarMode="Default" AutoResizeHeight="true" ToolsFile="~/Content/ToolBars/BasicTools.xml" Width="100%" MaxTextLength="500" Content='<%# Bind("Title") %>'></telerik:RadEditor>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                Formatted Author List:
                    <asp:TextBox ID="AuthorListTextBox" runat="server" Text='<%# Bind("AuthorList") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                Date Received:
                    <asp:TextBox ID="DateReceivedTextBox" runat="server" Text='<%# Bind("DateReceived") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                Preferred Format:
                                                <asp:DropDownList ID="PreferredFormatDropDownList" runat="server" CssClass="form-control" SelectedValue='<%# Bind("PreferredFormat") %>'>
                                                    <asp:ListItem Text="no preference" Value="no preference"></asp:ListItem>
                                                    <asp:ListItem Text="platform" Value="platform"></asp:ListItem>
                                                    <asp:ListItem Text="poster" Value="poster"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                Submission Requested By:
                    <asp:TextBox ID="SubmissionRequestedByTextBox" runat="server" Text='<%# Bind("SubmissionRequestedBy") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                Author Comments:
                    <asp:TextBox ID="AuthorCommentsTextBox" runat="server" Text='<%# Bind("AuthorComments") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                Applicable Topics:
                    <asp:TextBox ID="ApplicableTopicsTextBox" runat="server" Text='<%# Bind("ApplicableTopics") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                New Topic Area:
                    <asp:TextBox ID="NewTopicAreaTextBox" runat="server" Text='<%# Bind("NewTopicArea") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                Login Notes:
                    <asp:TextBox ID="LoginNotesTextBox" runat="server" Text='<%# Bind("LoginNotes") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                Withdrawn Date: 
                                                <telerik:RadDatePicker ID="RadDatePickerWithdrawnDate" runat="server" DbSelectedDate='<%# Bind("WithdrawnDate")%>' DateInput-CssClass="form-control"></telerik:RadDatePicker>
                                            </div>

                                            <div class="col-md-6">
                                                Ready for Review: 
                                                <telerik:RadDatePicker ID="RadDatePickerReadyForReview" runat="server" DbSelectedDate='<%# Bind("ReadyForReview")%>' DateInput-CssClass="form-control"></telerik:RadDatePicker>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Review Notes:
                    <asp:TextBox ID="ReviewNotesTextBox" runat="server" Text='<%# Bind("ReviewNotes")%>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Decline:
                    <asp:CheckBox ID="DeclinedCheckBox" runat="server" Checked='<%# Bind("Declined") %>' />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Decline Notes:
                    <asp:TextBox ID="DeclineNotesTextBox" runat="server" Text='<%# Bind("DeclineNotes")%>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                Session Code: 
                                                <asp:DropDownList ID="SessionCodeList" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceSessionCode" SelectedValue='<%# Bind("SessionID") %>' DataTextField="SessionCodeName" DataValueField="SessionID"  CssClass="form-control">
                                                    <asp:ListItem Text="Select a Session Code" Value="" Selected="True"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Current Format:
                                                <asp:DropDownList ID="DropDownListFinalFormat" runat="server" CssClass="form-control" SelectedValue='<%# Bind("FinalFormat") %>'>
                                                    <asp:ListItem Text="Select a format" Value=""></asp:ListItem>
                                                    <asp:ListItem Text="platform" Value="platform"></asp:ListItem>
                                                    <asp:ListItem Text="platform alternate" Value="platform alternate"></asp:ListItem>
                                                    <asp:ListItem Text="platform alternate A" Value="platform alternate A"></asp:ListItem>
                                                    <asp:ListItem Text="platform alternate B" Value="platform alternate B"></asp:ListItem>
                                                    <asp:ListItem Text="platform alternate C" Value="platform alternate C"></asp:ListItem>
                                                    <asp:ListItem Text="poster" Value="poster"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Platform Time:
                                                <asp:DropDownList ID="DropDownListPlatformTime" runat="server" CssClass="form-control" SelectedValue='<%# Bind("PlatformTime")%>'>
                                                    <asp:ListItem Text="Select a time" Value=""></asp:ListItem>
                                                    <asp:ListItem Text="8:00 a.m." Value="08:00:00"></asp:ListItem>
                                                    <asp:ListItem Text="8:25 a.m." Value="08:25:00"></asp:ListItem>
                                                    <asp:ListItem Text="8:50 a.m." Value="08:50:00"></asp:ListItem>
                                                    <asp:ListItem Text="9:15 a.m." Value="09:15:00"></asp:ListItem>
                                                    <asp:ListItem Text="9:40 a.m." Value="09:40:00"></asp:ListItem>
                                                    <asp:ListItem Text="10:05 a.m." Value="10:05:00"></asp:ListItem>
                                                    <asp:ListItem Text="10:30 a.m." Value="10:30:00"></asp:ListItem>
                                                    <asp:ListItem Text="10:55 a.m." Value="10:55:00"></asp:ListItem>
                                                    <asp:ListItem Text="11:20 a.m." Value="11:20:00"></asp:ListItem>
                                                    <asp:ListItem Text="11:45 a.m." Value="11:45:00"></asp:ListItem>
                                                    <asp:ListItem Text="12:10 p.m." Value="12:10:00"></asp:ListItem>
                                                    <asp:ListItem Text="12:35 p.m." Value="12:35:00"></asp:ListItem>
                                                    <asp:ListItem Text="1:00 p.m." Value="13:00:00"></asp:ListItem>
                                                    <asp:ListItem Text="1:25 p.m." Value="13:25:00"></asp:ListItem>
                                                    <asp:ListItem Text="1:50 p.m." Value="13:50:00"></asp:ListItem>
                                                    <asp:ListItem Text="2:15 p.m." Value="14:15:00"></asp:ListItem>
                                                    <asp:ListItem Text="2:40 p.m." Value="14:40:00"></asp:ListItem>
                                                    <asp:ListItem Text="3:05 p.m." Value="15:05:00"></asp:ListItem>
                                                    <asp:ListItem Text="3:30 p.m." Value="15:30:00"></asp:ListItem>
                                                    <asp:ListItem Text="3:55 p.m." Value="15:55:00"></asp:ListItem>
                                                    <asp:ListItem Text="4:20 p.m." Value="16:20:00"></asp:ListItem>
                                                    <asp:ListItem Text="4:45 p.m." Value="16:45:00"></asp:ListItem>
                                                    <asp:ListItem Text="5:10 p.m." Value="17:10:00"></asp:ListItem>
                                                    <asp:ListItem Text="5:35 p.m." Value="17:35:00"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Poster Number:
                    <asp:TextBox ID="PosterNumTextBox" runat="server" Text='<%# Bind("PosterNum")%>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Updated Abstract Received:
                                                <telerik:RadDatePicker ID="RadDatePickerUpdatedAbstractReceived" runat="server" DbSelectedDate='<%# Bind("UpdatedAbstractReceived")%>' DateInput-CssClass="form-control"></telerik:RadDatePicker>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Updated Abstract Notes:
                    <asp:TextBox ID="UpdatedAbstractNotesTextBox" runat="server" Text='<%# Bind("UpdatedAbstractNotes")%>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Proc Paper Received:
                                                <telerik:RadDatePicker ID="RadDatePickerProcPaperReceived" runat="server" DbSelectedDate='<%# Bind("ProcPaperReceived")%>' DateInput-CssClass="form-control"></telerik:RadDatePicker>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Proc Paper Notes:
                    <asp:TextBox ID="ProcPaperNotesTextBox" runat="server" Text='<%# Bind("ProcPaperNotes")%>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Proc Paper Title:
                    <asp:TextBox ID="ProcPaperTitleTextBox" runat="server" Text='<%# Bind("ProcPaperTitle")%>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Proc Paper Author List:
                    <asp:TextBox ID="ProcPaperAuthListTextBox" runat="server" Text='<%# Bind("ProcPaperAuthList")%>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Speaker Bio Received:
                                                 <telerik:RadDatePicker ID="RadDatePickerSpeakerBioReceived" runat="server" DbSelectedDate='<%# Bind("SpeakerBioReceived")%>' DateInput-CssClass="form-control"></telerik:RadDatePicker>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Proc Doc Number:
                    <asp:TextBox ID="ProcDocNumTextBox" runat="server" Text='<%# Bind("ProcDocNum")%>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                 Proc Poster Received:
                                                 <telerik:RadDatePicker ID="RadDatePickerSpeakerProcPosterReceived" runat="server" DbSelectedDate='<%# Bind("ProcPosterReceived")%>' DateInput-CssClass="form-control"></telerik:RadDatePicker>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Update" Text="Update" CssClass="btn btn-primary" />
                                                &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <h3>Abstract</h3>
                                                
                                                <b>Title and Author Block</b><br />
                                                <telerik:RadEditor ID="RadEditorAbstractTitleAuthorBlock" runat="server" ContentAreaMode="Div" Width="100%" AutoResizeHeight="true" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" Content='<%# Bind("AbstractTitleAuthorBlock")%>'>
                                                </telerik:RadEditor>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <b>Background/Objectives</b><br />
                                                <telerik:RadEditor ID="RadEditorAbstractBG" runat="server" ContentAreaMode="Div" Width="100%" AutoResizeHeight="true" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" Content='<%# Bind("AbstractBG")%>'>
                                                </telerik:RadEditor>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <b>Approach/Activities</b><br />
                            <telerik:RadEditor ID="RadEditorAbstractApproach" runat="server" ContentAreaMode="Div" Width="100%" AutoResizeHeight="true" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" Content='<%# Bind("AbstractApproach")%>'>
                            </telerik:RadEditor>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <b>Results/Lessons Learned</b><br />
                            <telerik:RadEditor ID="RadEditorAbstractResults" runat="server" ContentAreaMode="Div" Width="100%" AutoResizeHeight="true" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" Content='<%# Bind("AbstractResults")%>'>
                            </telerik:RadEditor>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="False" CommandName="Update" Text="Update" CssClass="btn btn-primary" />
                                                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                                            </div>
                                        </div>
                                    </div>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                ConferenceID:
                    <asp:TextBox ID="ConferenceIDTextBox" runat="server" Text='<%# Bind("ConferenceID") %>' />
                                <br />
                                AbstractCode:
                    <asp:TextBox ID="AbstractCodeTextBox" runat="server" Text='<%# Bind("AbstractCode") %>' />
                                <br />
                                Title:
                    <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                                <br />
                                AuthorList:
                    <asp:TextBox ID="AuthorListTextBox" runat="server" Text='<%# Bind("AuthorList") %>' />
                                <br />
                                DateReceived:
                    <asp:TextBox ID="DateReceivedTextBox" runat="server" Text='<%# Bind("DateReceived") %>' />
                                <br />
                                PreferredFormat:
                    <asp:TextBox ID="PreferredFormatTextBox" runat="server" Text='<%# Bind("PreferredFormat") %>' />
                                <br />
                                SubmissionRequestedBy:
                    <asp:TextBox ID="SubmissionRequestedByTextBox" runat="server" Text='<%# Bind("SubmissionRequestedBy") %>' />
                                <br />
                                AuthorComments:
                    <asp:TextBox ID="AuthorCommentsTextBox" runat="server" Text='<%# Bind("AuthorComments") %>' />
                                <br />
                                ApplicableTopics:
                    <asp:TextBox ID="ApplicableTopicsTextBox" runat="server" Text='<%# Bind("ApplicableTopics") %>' />
                                <br />
                                NewTopicArea:
                    <asp:TextBox ID="NewTopicAreaTextBox" runat="server" Text='<%# Bind("NewTopicArea") %>' />
                                <br />
                                AbstractContent:
                    <asp:TextBox ID="AbstractContentTextBox" runat="server" Text='<%# Bind("AbstractContent") %>' />
                                <br />
                                LoginNotes:
                    <asp:TextBox ID="LoginNotesTextBox" runat="server" Text='<%# Bind("LoginNotes") %>' />
                                <br />
                                WithdrawnDate:
                    <asp:TextBox ID="WithdrawnDateTextBox" runat="server" Text='<%# Bind("WithdrawnDate") %>' />
                                <br />
                                Presenter:
                    <asp:CheckBox ID="PresenterCheckBox" runat="server" Checked='<%# Bind("Presenter") %>' />
                                <br />
                                FirstName:
                    <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' />
                                <br />
                                LastName:
                    <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' />
                                <br />
                                Employer:
                    <asp:TextBox ID="EmployerTextBox" runat="server" Text='<%# Bind("Employer") %>' />
                                <br />
                                AddressLine1:
                    <asp:TextBox ID="AddressLine1TextBox" runat="server" Text='<%# Bind("AddressLine1") %>' />
                                <br />
                                AddressLine2:
                    <asp:TextBox ID="AddressLine2TextBox" runat="server" Text='<%# Bind("AddressLine2") %>' />
                                <br />
                                AddressLine3:
                    <asp:TextBox ID="AddressLine3TextBox" runat="server" Text='<%# Bind("AddressLine3") %>' />
                                <br />
                                City:
                    <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />
                                <br />
                                StateProvince:
                    <asp:TextBox ID="StateProvinceTextBox" runat="server" Text='<%# Bind("StateProvince") %>' />
                                <br />
                                ZipPostal:
                    <asp:TextBox ID="ZipPostalTextBox" runat="server" Text='<%# Bind("ZipPostal") %>' />
                                <br />
                                Country:
                    <asp:TextBox ID="CountryTextBox" runat="server" Text='<%# Bind("Country") %>' />
                                <br />
                                PhoneNum:
                    <asp:TextBox ID="PhoneNumTextBox" runat="server" Text='<%# Bind("PhoneNum") %>' />
                                <br />
                                CellNum:
                    <asp:TextBox ID="CellNumTextBox" runat="server" Text='<%# Bind("CellNum") %>' />
                                <br />
                                Email:
                    <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
                                <br />
                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" CausesValidation="False" CommandName="Edit" Text="Edit Abstract" /><br />
                                <asp:HiddenField ID="hdnAbstractID" runat="server" Value='<%# Bind("AbstractID")%>' />
                                <b>Abstract Code:</b>
                    <asp:Label ID="AbstractCodeLabel" runat="server" Text='<%# Bind("AbstractCode") %>' />
                                <br />
                                <b>Title:</b>
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>' />
                                <br />
                                <b>Formatted Author List:</b>
                    <asp:Label ID="AuthorListLabel" runat="server" Text='<%# Bind("AuthorList") %>' />
                                <br />
                                <b>Date Received:</b>
                    <asp:Label ID="DateReceivedLabel" runat="server" Text='<%# Bind("DateReceived") %>' />
                                <br />
                                <b>Preferred Format:</b>
                    <asp:Label ID="PreferredFormatLabel" runat="server" Text='<%# Bind("PreferredFormat") %>' />
                                <br />
                                <b>Submission Requested By:</b>
                    <asp:Label ID="SubmissionRequestedByLabel" runat="server" Text='<%# Bind("SubmissionRequestedBy") %>' />
                                <br />
                                <b>Author Comments:</b>
                    <asp:Label ID="AuthorCommentsLabel" runat="server" Text='<%# Bind("AuthorComments") %>' />
                                <br />
                                <b>Applicable Topics:</b>
                    <asp:Label ID="ApplicableTopicsLabel" runat="server" Text='<%# Bind("ApplicableTopics") %>' />
                                <br />
                                <b>New Topic Area:</b>
                    <asp:Label ID="NewTopicAreaLabel" runat="server" Text='<%# Bind("NewTopicArea") %>' />
                                <br />
                                <b>Login Notes:</b>
                    <asp:Label ID="LoginNotesLabel" runat="server" Text='<%# Bind("LoginNotes") %>' />
                                <br />
                                <b>Withdrawn Date:</b>
                    <asp:Label ID="WithdrawnDateLabel" runat="server" Text='<%# Bind("WithdrawnDate") %>' />
                                <br />
                                 <b>Ready For Review Date:</b>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ReadyForReview") %>' />
                                <br />
                                            Admin Review by:
            <asp:Label ID="AdminLabel" runat="server" Text='<%# Bind("Admin") %>' />
            <br />
            Final Review Date:
            <asp:Label ID="FinalDateLabel" runat="server" Text='<%# Bind("FinalDate") %>' />
            <br />
            Admin Review Date:
            <asp:Label ID="AdminReviewDateLabel" runat="server" Text='<%# Bind("AdminReviewDate") %>' />
            <br />
            Review Notes:
            <asp:Label ID="ReviewNotesLabel" runat="server" Text='<%# Bind("ReviewNotes") %>' />
            <br />
            Declined:
            <asp:CheckBox ID="DeclinedCheckBox" runat="server" Checked='<%# Bind("Declined") %>' Enabled="false" />
            <br />
                                Decline Notes:
            <asp:Label ID="DeclineNotesLabel" runat="server" Text='<%# Bind("DeclineNotes") %>' />
            <br />
            
                                Session Code:
            <asp:Label ID="SessionCodeLabel" runat="server" Text='<%# Bind("SessionCode") %>' />
            <br />
             Current Format:
            <asp:Label ID="FinalFormatLabel" runat="server" Text='<%# Bind("FinalFormat") %>' />
            <br />

            
            Platform Time:
            <asp:Label ID="PlatformTimeLabel" runat="server" Text='<%# Eval("PlatformTime", "{0:t}")%>' />
            <br />
            Poster Number:
            <asp:Label ID="PosterNumLabel" runat="server" Text='<%# Bind("PosterNum")%>' />
            <br />
            Updated Abstract Received:
            <asp:Label ID="UpdatedAbstractReceivedLabel" runat="server" Text='<%# Bind("UpdatedAbstractReceived") %>' />
            <br />
            Updated Abstract Notes:
            <asp:Label ID="UpdatedAbstractNotesLabel" runat="server" Text='<%# Bind("UpdatedAbstractNotes") %>' />
            <br />
            Proc Paper Received:
            <asp:Label ID="ProcPaperReceivedLabel" runat="server" Text='<%# Bind("ProcPaperReceived") %>' />
            <br />
            Proc Paper Notes:
            <asp:Label ID="ProcPaperNotesLabel" runat="server" Text='<%# Bind("ProcPaperNotes") %>' />
            <br />
            Proc Paper Title:
            <asp:Label ID="ProcPaperTitleLabel" runat="server" Text='<%# Bind("ProcPaperTitle") %>' />
            <br />
            Proc Paper Auth List:
            <asp:Label ID="ProcPaperAuthListLabel" runat="server" Text='<%# Bind("ProcPaperAuthList") %>' />
            <br />
            Speaker Bio Received:
            <asp:Label ID="SpeakerBioReceivedLabel" runat="server" Text='<%# Bind("SpeakerBioReceived") %>' />
            <br />
            Proc Doc Num:
            <asp:Label ID="ProcDocNumLabel" runat="server" Text='<%# Bind("ProcDocNum") %>' />
            <br />
            Proc Poster Received:
            <asp:Label ID="ProcPosterReceivedLabel" runat="server" Text='<%# Bind("ProcPosterReceived") %>' />
            <br />
            <b>Abstract:</b> 
            <asp:HyperLink ID="HyperLinkAbstractFile" runat="server" NavigateUrl='<%# String.Format("~/Admin/Abstracts/AbstractFile.aspx?id={0}&name={1}", Eval("AbstractID"), Eval("FileName"))%>'><%# Eval("FileName")%></asp:HyperLink> 
            <i><%# Eval("FileSizeKB", "{0} kb")%></i>
            <div style="border: 1px solid #c7c4c4; box-shadow: 5px 5px 5px #c7c4c4; padding:5px;">
                <asp:Label ID="AbstractTitleAuthorBlockLabel" runat="server" Text='<%# Bind("AbstractTitleAuthorBlock")%>' />
                <br />
                <br />
                <asp:Label ID="AbstractBGLabel" runat="server" Text='<%# Bind("AbstractBG")%>' />
                <br />
                <br />
                <asp:Label ID="AbstractApproachLabel" runat="server" Text='<%# Bind("AbstractApproach")%>' />
                <br />
                <br />
                <asp:Label ID="AbstractResultsLabel" runat="server" Text='<%# Bind("AbstractResults")%>' />
            </div>
            <br />
                                
            <asp:Button ID="ButtonEdit" runat="server" CssClass="btn btn-primary" CausesValidation="False" CommandName="Edit" Text="Edit Abstract" />

        </ItemTemplate>


    </asp:FormView>
                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                         <asp:SqlDataSource ID="SqlDataSourceCo" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractGetCoAuthors" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvAbstract" Name="AbstractID" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <h3>Authors</h3>
                                <asp:GridView ID="gvAuthors" runat="server" DataSourceID="SqlDataSourceCo" AutoGenerateColumns="False" Visible="False" CssClass="table" OnDataBound="GetCurrentPresenter">
                                    <Columns>
                                        <asp:CheckBoxField DataField="Presenter" HeaderText="Presenter" SortExpression="Presenter" />
                                        <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                                        <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                                        <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                                        <asp:BoundField DataField="AddressLine1" HeaderText="Address Line 1" SortExpression="AddressLine1" />
                                        <asp:BoundField DataField="AddressLine2" HeaderText="Address Line 2" SortExpression="AddressLine2" />
                                        <asp:BoundField DataField="AddressLine3" HeaderText="Address Line 3" SortExpression="AddressLine3" />
                                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                                        <asp:BoundField DataField="StateProvince" HeaderText="State Province" SortExpression="StateProvince" />
                                        <asp:BoundField DataField="ZipPostal" HeaderText="Zip Postal" SortExpression="ZipPostal" />
                                        <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
                                        <asp:BoundField DataField="PhoneNum" HeaderText="Phone #" SortExpression="PhoneNum" />
                                        <asp:BoundField DataField="CellNum" HeaderText="Cell #" SortExpression="CellNum" />
                                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                        <asp:BoundField DataField="PersonID" HeaderText="Person ID" SortExpression="PersonID" ItemStyle-CssClass="Hide" HeaderStyle-CssClass="Hide"  />
                                        
                                    </Columns>
                                </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceReviews" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewsGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvAbstract" Name="AbstractID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <h3>Reviews</h3>
                        <asp:GridView ID="gvReviews" runat="server" DataSourceID="SqlDataSourceReviews" AutoGenerateColumns="false" Visible="false" CssClass="table" DataKeyNames="AbstractReviewID">
                            <Columns>
                                <asp:BoundField DataField="ReviewDate" HeaderText="Date" SortExpression="ReviewDate" />
                                <asp:BoundField DataField="ReviewType" HeaderText="Type" SortExpression="ReviewType" />
                                <asp:BoundField DataField="RelatedAbstracts" HeaderText="Related Abstracts" SortExpression="RelatedAbstracts" />
                                <asp:BoundField DataField="TopicGroupID" HeaderText="Theme" SortExpression="TopicGroupID" />
                                <asp:BoundField DataField="TopicCode" HeaderText="Topic" SortExpression="TopicCode" />
                                <asp:BoundField DataField="GeneralComments" HeaderText="Comments" SortExpression="GeneralComments" />
                                <asp:BoundField DataField="Reviewer" HeaderText="Reviewer" SortExpression="Reviewer" />
                            </Columns>
                        </asp:GridView>
                                <div class="row" id="labelCorrespondingAuthor" runat="server" visible="false">
                                    <div class="col-md-12">
                                    <b><asp:Label ID="lblAuthorResults" runat="server" ForeColor="Red" Text=""></asp:Label></b>
                                    <h4>Corresponding/Presenting Author</h4>
                                    <b><asp:Label ID="lblCorPresAuthor" runat="server" Text=""></asp:Label></b>
                                    <asp:HiddenField ID="hdnCorPres" runat="server" />  
                                    <br />
                                    <br />
                                    <asp:ListBox ID="listofDeletedAuthors" runat="server" Visible="false"></asp:ListBox>
                                    <b><asp:Label ID="lblDelAuthor" EnableViewState="False" runat="server" Text=""></asp:Label></b> 
                                    </div>
                                </div>

                                
                                <div class="row" id="listCorrespondingAuthor" runat="server" visible="false">
                                    <div class="col-md-12">
                                <asp:Label ID="lblAuthors" runat="server" Text="*Co-Authors" AssociatedControlID="ListBoxAbstractAuthors"></asp:Label><br />
                                If there are any additional authors listed on the abstract, click the &quot;Add co-authors&quot; button.
                                <br />
                                <asp:ListBox ID="ListBoxAbstractAuthors" runat="server" DataSourceID="SqlDataSourceCo" DataValueField="personID" DataTextField="FullName" AutoPostBack="True"  CssClass="form-control" Height="120px">
                                </asp:ListBox>
                                <asp:Button ID="ButtonAuthorsAdd" runat="server" Text="Add co-authors" CssClass="btn btn-primary" UseSubmitBehavior="False" />&nbsp;
                                <asp:Button ID="ButtonCorPresAuthorSet" runat="server" Text="Set as Corresponding/Presenting Author" CssClass="btn btn-success" UseSubmitBehavior="False" Visible="False" />&nbsp;
                                <asp:Button ID="ButtonAuthorsRemove" runat="server" Text="Remove selected author" Visible="False" CssClass="btn btn-warning" UseSubmitBehavior="False" />&nbsp;

                                <asp:Button ID="ButtonAuthorsEdit" runat="server" Text="Edit selected author" Visible="False" CssClass="btn btn-warning" UseSubmitBehavior="False" />&nbsp;

                                <!--<asp:Button ID="ButtonUpdateAuthors" runat="server" Text="Refresh Authors Table" OnClick="AbstractAuthorsUpdate_Click" CssClass="btn btn-default"  />--><br />
                                If you are not the corresponding/presenting author on this abstract, click another name in the box above to set as the corresponding/presenting author. If you are not one of the authors, click your name to remove. 
                                </div>
                            </div>


           <asp:Panel ID="PanelPersonUpdate" runat="server" Visible="false">
           <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LookupCountryGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
           <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LookupStateProvinceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>                    
           <asp:SqlDataSource ID="SqlDataSourcePerson" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"  SelectCommand="PersonGet" SelectCommandType="StoredProcedure" UpdateCommand="PersonUpdateByID" UpdateCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="PersonID" Type="Int32"/>
            </SelectParameters>
               <UpdateParameters>
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="Employer" Type="String" />
                <asp:Parameter Name="AddressLine1" Type="String" />
                <asp:Parameter Name="AddressLine2" Type="String" />
                <asp:Parameter Name="AddressLine3" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="StateProvince" Type="String" />
                <asp:Parameter Name="ZipPostal" Type="String" />
                <asp:Parameter Name="Country" Type="String" />
                <asp:Parameter Name="PhoneNum" Type="String" />
                <asp:Parameter Name="CellNum" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="ModifiedSource" Type="String" DefaultValue="Abstracts Admin" />
                <asp:Parameter Name="ModifiedBy" Type="String" />
                <asp:Parameter Name="PersonID" Type="Int32" />
            </UpdateParameters>
            </asp:SqlDataSource>

                <asp:FormView ID="FormViewPerson" runat="server" DataKeyNames="PersonID" DataSourceID="SqlDataSourcePerson" RenderOuterTable="False" OnDataBinding="PersonInfoUpdate_Click">
                <EditItemTemplate>
                    <br />
                    <br />
                    <h4>Edit Selected Author</h4>
                        <div class="row">
                            <div class="col-md-7">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblFirstName" runat="server" Text="First/Middle Names" AssociatedControlID="FirstNameTextBox"></asp:Label> 
                                        <small>(as preferred for citation in program/attendee list)</small></h5>
                                    <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' CssClass="form-control" MaxLength="50"/>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblLastName" runat="server" Text="Last Name (Surname)" AssociatedControlID="LastNameTextBox"></asp:Label></h5>
                                    <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' CssClass="form-control" MaxLength="50"/>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblEmployer" runat="server" Text="Employer" AssociatedControlID="EmployerTextBox"></asp:Label></h5>
                                    <asp:TextBox ID="EmployerTextBox" runat="server" Text='<%# Bind("Employer") %>' CssClass="form-control" MaxLength="100" />
                                    <h6>Parent organization—university name, corporate name, or major government agency (e.g., U.S. EPA, National Institutes of Health). 
                                        Enter departmental or division names  in Address Line 1.</h6>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblEmail" runat="server" Text="Email Address" AssociatedControlID="EmailTextBox"></asp:Label></h5>
                                    <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control"  MaxLength="100"/>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblAddress1" runat="server" Text="Mailing/Postal Address" AssociatedControlID="AddressLine1TextBox"></asp:Label> 
                                        <small>Line 1 is required; complete Lines 2 and 3 as needed for postal delivery.</small></h5>
                                    <asp:TextBox ID="AddressLine1TextBox" runat="server" Text='<%# Bind("AddressLine1") %>' CssClass="form-control" MaxLength="50"/>

                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="AddressLine2TextBox" runat="server" Text='<%# Bind("AddressLine2") %>' CssClass="form-control" MaxLength="50"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="AddressLine3TextBox" runat="server" Text='<%# Bind("AddressLine3") %>' CssClass="form-control" MaxLength="50"/>
                                </div>
                            </div>
                        </div>

                        <div class="row">

                            <div class="col-md-6">
                                <div class="form-group">
                                     <h5><span class="text-danger">*</span><asp:Label ID="lblCity" runat="server" Text="City" AssociatedControlID="CityTextBox"></asp:Label></h5>
                                    <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' CssClass="form-control" MaxLength="100"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <h5><asp:Label ID="lblStateProv" runat="server" Text="State/Province" AssociatedControlID="StateProvinceDropDownList"></asp:Label></h5>
                                    <asp:DropDownList ID="StateProvinceDropDownList" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="SqlDataSourceLookupStateProvince" DataTextField="ListStateProvinceName" DataValueField="StateProvinceAbbreviation" OnPreRender="HtmlDecode_PreRender" SelectedValue='<%# Bind("StateProvince")%>' OnDataBound="StateProvinceDropDownList_DataBound" OnDataBinding="StateProvinceDropDownList_DataBinding">
                                        <asp:ListItem Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        
                    <div class="row">

                            <div class="col-md-6">
                                <div class="form-group">
                                    <h5><asp:Label ID="lblZipPostal" runat="server" Text="Zip/Postal Code" AssociatedControlID="ZipPostalTextBox"></asp:Label></h5>      
                                    <asp:TextBox ID="ZipPostalTextBox" runat="server" Text='<%# Bind("ZipPostal") %>' CssClass="form-control" MaxLength="50"/>
                                    <h6>Insert any additional alpha or numeric characters needed for mail delivery.</h6>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblCountry" runat="server" Text="Country" AssociatedControlID="CountryDropDownList"></asp:Label></h5>
                                    <asp:DropDownList ID="CountryDropDownList" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceLookupCountry" DataTextField="CountryName" DataValueField="CountryName" CssClass="form-control" OnPreRender="HtmlDecode_PreRender" SelectedValue='<%# Bind("Country") %>' OnSelectedIndexChanged="CountryDropDownList_SelectedIndexChanged" OnDataBound="CountryDropDownList_DataBound" AutoPostBack="False">
                                        <asp:ListItem Selected="True" Value="">Please select your country</asp:ListItem>
                                    </asp:DropDownList>

                                </div>
                            </div>
                        </div>

                    <div class="row">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblPhone" runat="server" Text="Office Phone Number" AssociatedControlID="PhoneNumTextBox"></asp:Label></h5>
                                    <asp:TextBox ID="PhoneNumTextBox" runat="server" Text='<%# Bind("PhoneNum") %>' CssClass="form-control" MaxLength="50"/>
                                    <h6>U.S./Canada: format as 999-999-9999 (including hyphens). Other countries: begin with country code and use hyphens to separate the elements.</h6>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="form-group">
                                    <h5><asp:Label ID="lblCellPhone" runat="server" Text="Cell Phone Number" AssociatedControlID="CellNumTextBox"></asp:Label> 
                                    <small>(Conference office use only; will not be disseminated.)</small></h5>
                                    <asp:TextBox ID="CellNumTextBox" runat="server" Text='<%# Bind("CellNum") %>' CssClass="form-control" MaxLength="50"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">

                                <br />
                                <asp:Label ID="LabelDataValidationSummary" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="ButtonUpdateAuthor" runat="server" CausesValidation="True" CommandName="Update" Text="Update author information" CssClass="btn btn-success"  />
                                <asp:Button ID="ButtonUpdateAuthorCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                            </div>
                        </div>




                </EditItemTemplate>
                <ItemTemplate>
                    <br />
                    <br />
                    <h4>Edit Selected Author</h4>
                    Click &#39;Edit&#39; if you wish to update the information displayed here. 
                    Please note: Any change you make in your information will affect program- and registration-related information 
                    for all upcoming Battelle conferences.<br />
                    <br />
                    <div class="container-fluid">

                        <div class="row">
                            <div class="col-md-12">
                                <b>First/Middle Names:</b>
                                <asp:Label ID="Author_FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Last Name:</b>
                                <asp:Label ID="Author_LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Employer:</b>
                                <asp:Label ID="Author_EmployerLabel" runat="server" Text='<%# Bind("Employer") %>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <b>Email Address:</b>
                                <asp:Label ID="Author_EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Mailing/Postal Address:</b><br />
                                <asp:Label ID="Author_AddressLine1Label" runat="server" Text='<%# Bind("AddressLine1") %>' />
                                <br />
                                <asp:Label ID="Author_AddressLine2Label" runat="server" Text='<%# Bind("AddressLine2") %>' />
                                <br />
                                <asp:Label ID="Author_AddressLine3Label" runat="server" Text='<%# Bind("AddressLine3") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>City:</b>
                                <asp:Label ID="Author_CityLabel" runat="server" Text='<%# Bind("City") %>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <b>State/Province:</b>
                                <asp:Label ID="Author_StateProvinceLabel" runat="server" Text='<%# Bind("StateProvince") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Zip/Postal Code:</b>
                                <asp:Label ID="Author_ZipPostalLabel" runat="server" Text='<%# Bind("ZipPostal") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Country:</b>
                                <asp:Label ID="Author_CountryLabel" runat="server" Text='<%# Bind("Country") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Phone Number:</b>
                                <asp:Label ID="Author_PhoneNumLabel" runat="server" Text='<%# Bind("PhoneNum") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Cell Phone Number:</b>
                                <asp:Label ID="Author_CellNumLabel" runat="server" Text='<%# Bind("CellNum") %>' />
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-md-12">
                                &nbsp;
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <asp:LinkButton ID="EditAuthorButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                </asp:FormView>
                </asp:Panel> 





                            <asp:Panel ID="PanelPersonAdd" runat="server" Visible="False">
                                <div class="container-fluid">
                            <div class="row">
                                <div class="col-sm-12">
                                    <br />

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="panel panel-primary">

                                        <div class="panel-heading">
                                            <asp:Label ID="lblPersonEmail" runat="server" Text="Co-author Email Address" AssociatedControlID="TextBoxPersonEmail"></asp:Label>
                                            First, check to see if the co-author exists in our system by entering his or her email address.
                                        </div>
                                        <div class="panel-body">
                                            <div class="input-group">
                                                <asp:TextBox ID="TextBoxPersonEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                                <span class="input-group-btn">
                                                    <asp:Button ID="LinkButtonPersonLookup2" runat="server" Text="Search for co-author" CssClass="btn btn-primary" UseSubmitBehavior="False" ValidationGroup="ValidateEmail" /></span>
                                               
                                            </div>
                                             <asp:Button ID="ButtonSearchCancel" runat="server" CssClass="btn btn-default" Text="Cancel" UseSubmitBehavior="False" CausesValidation="False" />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter an email address." SetFocusOnError="False" ControlToValidate="TextBoxPersonEmail" CssClass="text-danger" ValidationGroup="ValidateEmail"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <asp:Label ID="LabelPersonLookupResult" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <asp:FormView ID="FormViewPersonLookup" runat="server" DataKeyNames="PersonID" DataSourceID="SqlDataSourcePersonLookup" RenderOuterTable="False" Visible="False">
                            <EmptyDataTemplate>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <asp:Button ID="ButtonNew" runat="server" Text="Enter co-author information" CausesValidation="False" CommandName="New" CssClass="btn btn-warning" /> 
                                        </div>
                                    </div>
                                </div>
                            </EmptyDataTemplate>
                            <InsertItemTemplate>


                                <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LookupCountryGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LookupStateProvinceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Label ID="LabelDataValidationSummary" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <h4>Enter Co-author Information</h4>
                                            <span class="text-danger">*</span> Indicates a required field.
                                            <h6>Please do not include professional or military titles (e.g., Dr., Professor, Ph.D., PE, PG) or other suffixes (e.g., Jr., Sr., II) in the name fields.</h6>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblFirstName" runat="server" Text="First/Middle Names" AssociatedControlID="FirstNameTextBox"></asp:Label>
                                                    <small>(as preferred for citation in program/attendee list)</small></h5>
                                                <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblLastName" runat="server" Text="Last Name (Surname)" AssociatedControlID="LastNameTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblEmployer" runat="server" Text="Employer" AssociatedControlID="EmployerTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="EmployerTextBox" runat="server" Text='<%# Bind("Employer") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="100" />
                                                <h6>Parent organization—university name, corporate name, or major government agency (e.g., U.S. EPA, National Institutes of Health). 
                                        Enter departmental or division names in Address Line 1.</h6>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                             <h5><span class="text-danger">*</span><asp:Label ID="lblEmail" runat="server" Text="Email Address" AssociatedControlID="EmailTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" OnLoad="EmailTextBox_Init" ReadOnly="true" MaxLength="100" />
                                            </div>
                                            <h6>If you have typed an incorrect email address, click <asp:LinkButton ID="LinkButtonCancel" runat="server" CommandName="Cancel" CausesValidation="False">Cancel</asp:LinkButton>.</h6>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblAddress1" runat="server" Text="Mailing/Postal Address" AssociatedControlID="AddressLine1TextBox"></asp:Label>
                                                    <small>Line 1 is required; complete Lines 2 and 3 as needed for postal delivery. Please do not repeat employer here.</small></h5>
                                                <asp:TextBox ID="AddressLine1TextBox" runat="server" Text='<%# Bind("AddressLine1") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <asp:TextBox ID="AddressLine2TextBox" runat="server" Text='<%# Bind("AddressLine2") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <asp:TextBox ID="AddressLine3TextBox" runat="server" Text='<%# Bind("AddressLine3") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblCity" runat="server" Text="City" AssociatedControlID="CityTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="100" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5>
                                                    <asp:Label ID="lblStateProv" runat="server" Text="State/Province" AssociatedControlID="StateProvinceDropDownList"></asp:Label></h5>
                                                <asp:DropDownList ID="StateProvinceDropDownList" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="SqlDataSourceLookupStateProvince" DataTextField="ListStateProvinceName" DataValueField="StateProvinceAbbreviation" OnPreRender="HtmlDecode_PreRender" SelectedValue='<%# Bind("StateProvince")%>'>
                                                    <asp:ListItem Value=""></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5>
                                                    <asp:Label ID="lblZipPostal" runat="server" Text="Zip/Postal Code" AssociatedControlID="ZipPostalTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="ZipPostalTextBox" runat="server" Text='<%# Bind("ZipPostal") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                                <h6>Insert any additional alpha or numeric characters needed for mail delivery.</h6>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblCountry" runat="server" Text="Country" AssociatedControlID="CountryDropDownList"></asp:Label></h5>
                                                <asp:DropDownList ID="CountryDropDownList" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceLookupCountry" DataTextField="CountryName" DataValueField="CountryName" CssClass="form-control" OnPreRender="HtmlDecode_PreRender" SelectedValue='<%# Bind("Country") %>' AutoPostBack="False">
                                                    <asp:ListItem Selected="True" Value="">Please select your country</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblPhone" runat="server" Text="Office Phone Number" AssociatedControlID="PhoneNumTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="PhoneNumTextBox" runat="server" Text='<%# Bind("PhoneNum") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                                <h6>U.S./Canada: format as 999-999-9999 (including hyphens). Other countries: begin with country code and use hyphens to separate the elements.</h6>
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5>
                                                    <asp:Label ID="lblCellPhone" runat="server" Text="Cell Phone Number" AssociatedControlID="CellNumTextBox"></asp:Label>
                                                    <small>(Conference office use only; will not be disseminated.)</small></h5>
                                                <asp:TextBox ID="CellNumTextBox" runat="server" Text='<%# Bind("CellNum") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Button ID="ButtonInsert" CausesValidation="True" CommandName="Insert" runat="server" Text="Add Co-author" CssClass="btn btn-primary" OnClientClick="SetFocus(1)" />&nbsp;
                                            <asp:Button ID="ButtonInsertCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                                        </div>
                                    </div>
                                </div>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <b>First/Middle Names:</b>
                                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <b>Last Name:</b>
                                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <b>Email Address:</b>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Email") %>' />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <b>City:</b>
                                            <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <b>State/Province:</b>
                                            <asp:Label ID="StateProvinceLabel" runat="server" Text='<%# Bind("StateProvince") %>' />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <b>Zip/Postal Code:</b>
                                            <asp:Label ID="ZipPostalLabel" runat="server" Text='<%# Bind("ZipPostal") %>' />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <b>Country:</b>
                                            <asp:Label ID="CountryLabel" runat="server" Text='<%# Bind("Country") %>' />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            If you believe your co-author’s information above should be updated, please send an email to 
                                            <p>ENTER HYPERLINK HERE</p>
                                             explaining what you believe should be corrected and providing the email and address for your co-author. Please copy and paste the information displayed into your email and include the title of your abstract.
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Button ID="ButtonSelect" runat="server" CausesValidation="False" CommandName="Select" OnClick="SelectButton_Click" Text="Add to co-author list" CssClass="btn btn-success" UseSubmitBehavior="False" OnClientClick="SetFocus(1)" />
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:SqlDataSource ID="SqlDataSourcePersonLookup" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"  InsertCommand="INSERT INTO [Person] ([FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [Notes]) VALUES (@FirstName, @LastName, @Employer, @AddressLine1, @AddressLine2, @AddressLine3, @City, @StateProvince, @ZipPostal, @Country, @PhoneNum, @CellNum, @Email, @Notes)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [Notes], [PersonID] FROM [Person] WHERE ([Email] = @Email)" UpdateCommand="UPDATE [Person] SET [FirstName] = @FirstName, [LastName] = @LastName, [Employer] = @Employer, [AddressLine1] = @AddressLine1, [AddressLine2] = @AddressLine2, [AddressLine3] = @AddressLine3, [City] = @City, [StateProvince] = @StateProvince, [ZipPostal] = @ZipPostal, [Country] = @Country, [PhoneNum] = @PhoneNum, [CellNum] = @CellNum, [Email] = @Email, [Notes] = @Notes WHERE [PersonID] = @original_PersonID AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([Employer] = @original_Employer) OR ([Employer] IS NULL AND @original_Employer IS NULL)) AND (([AddressLine1] = @original_AddressLine1) OR ([AddressLine1] IS NULL AND @original_AddressLine1 IS NULL)) AND (([AddressLine2] = @original_AddressLine2) OR ([AddressLine2] IS NULL AND @original_AddressLine2 IS NULL)) AND (([AddressLine3] = @original_AddressLine3) OR ([AddressLine3] IS NULL AND @original_AddressLine3 IS NULL)) AND (([City] = @original_City) OR ([City] IS NULL AND @original_City IS NULL)) AND (([StateProvince] = @original_StateProvince) OR ([StateProvince] IS NULL AND @original_StateProvince IS NULL)) AND (([ZipPostal] = @original_ZipPostal) OR ([ZipPostal] IS NULL AND @original_ZipPostal IS NULL)) AND (([Country] = @original_Country) OR ([Country] IS NULL AND @original_Country IS NULL)) AND (([PhoneNum] = @original_PhoneNum) OR ([PhoneNum] IS NULL AND @original_PhoneNum IS NULL)) AND (([CellNum] = @original_CellNum) OR ([CellNum] IS NULL AND @original_CellNum IS NULL)) AND (([Email] = @original_Email) OR ([Email] IS NULL AND @original_Email IS NULL))  AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL))">
                            <InsertParameters>
                                <asp:Parameter Name="FirstName" Type="String" />
                                <asp:Parameter Name="LastName" Type="String" />
                                <asp:Parameter Name="Employer" Type="String" />
                                <asp:Parameter Name="AddressLine1" Type="String" />
                                <asp:Parameter Name="AddressLine2" Type="String" />
                                <asp:Parameter Name="AddressLine3" Type="String" />
                                <asp:Parameter Name="City" Type="String" />
                                <asp:Parameter Name="StateProvince" Type="String" />
                                <asp:Parameter Name="ZipPostal" Type="String" />
                                <asp:Parameter Name="Country" Type="String" />
                                <asp:Parameter Name="PhoneNum" Type="String" />
                                <asp:Parameter Name="CellNum" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                                <asp:Parameter Name="Notes" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBoxPersonEmail" Name="Email" PropertyName="Text" Type="String" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="FirstName" Type="String" />
                                <asp:Parameter Name="LastName" Type="String" />
                                <asp:Parameter Name="Employer" Type="String" />
                                <asp:Parameter Name="AddressLine1" Type="String" />
                                <asp:Parameter Name="AddressLine2" Type="String" />
                                <asp:Parameter Name="AddressLine3" Type="String" />
                                <asp:Parameter Name="City" Type="String" />
                                <asp:Parameter Name="StateProvince" Type="String" />
                                <asp:Parameter Name="ZipPostal" Type="String" />
                                <asp:Parameter Name="Country" Type="String" />
                                <asp:Parameter Name="PhoneNum" Type="String" />
                                <asp:Parameter Name="CellNum" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                                <asp:Parameter Name="Notes" Type="String" />
                                <asp:Parameter Name="original_PersonID" Type="Int32" />
                                <asp:Parameter Name="original_FirstName" Type="String" />
                                <asp:Parameter Name="original_LastName" Type="String" />
                                <asp:Parameter Name="original_Employer" Type="String" />
                                <asp:Parameter Name="original_AddressLine1" Type="String" />
                                <asp:Parameter Name="original_AddressLine2" Type="String" />
                                <asp:Parameter Name="original_AddressLine3" Type="String" />
                                <asp:Parameter Name="original_City" Type="String" />
                                <asp:Parameter Name="original_StateProvince" Type="String" />
                                <asp:Parameter Name="original_ZipPostal" Type="String" />
                                <asp:Parameter Name="original_Country" Type="String" />
                                <asp:Parameter Name="original_PhoneNum" Type="String" />
                                <asp:Parameter Name="original_CellNum" Type="String" />
                                <asp:Parameter Name="original_Email" Type="String" />
                                <asp:Parameter Name="original_Notes" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                            </asp:Panel>
                                <!--end panel-->
                    </div>
                </div>
                <div class="row">

                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        /* This Script is used to maintain Grid Scroll on Partial Postback */
        var scrollTop;
        /* Register Begin Request and End Request */
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        /* Get The Div Scroll Position */
        function BeginRequestHandler(sender, args) {
            var m = document.getElementById('divGrid');
            scrollTop = m.scrollTop;
        }
        /* Set The Div Scroll Position */
        function EndRequestHandler(sender, args) {
            var m = document.getElementById('divGrid');
            m.scrollTop = scrollTop;
        }
    </script>


    <asp:FormView ID="FormView2" runat="server" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceAbstractSelected">
        <EditItemTemplate>
            AbstractID:
            <asp:Label ID="AbstractIDLabel1" runat="server" Text='<%# Eval("AbstractID") %>' />
            <br />
            ConferenceID:
            <asp:TextBox ID="ConferenceIDTextBox" runat="server" Text='<%# Bind("ConferenceID") %>' />
            <br />
            AbstractCode:
            <asp:TextBox ID="AbstractCodeTextBox" runat="server" Text='<%# Bind("AbstractCode") %>' />
            <br />
            Title:
            <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
            <br />
            AuthorList:
            <asp:TextBox ID="AuthorListTextBox" runat="server" Text='<%# Bind("AuthorList") %>' />
            <br />
            DateReceived:
            <asp:TextBox ID="DateReceivedTextBox" runat="server" Text='<%# Bind("DateReceived") %>' />
            <br />
            PreferredFormat:
            <asp:TextBox ID="PreferredFormatTextBox" runat="server" Text='<%# Bind("PreferredFormat") %>' />
            <br />
            SubmissionRequestedBy:
            <asp:TextBox ID="SubmissionRequestedByTextBox" runat="server" Text='<%# Bind("SubmissionRequestedBy") %>' />
            <br />
            AuthorComments:
            <asp:TextBox ID="AuthorCommentsTextBox" runat="server" Text='<%# Bind("AuthorComments") %>' />
            <br />
            ApplicableTopics:
            <asp:TextBox ID="ApplicableTopicsTextBox" runat="server" Text='<%# Bind("ApplicableTopics") %>' />
            <br />
            NewTopicArea:
            <asp:TextBox ID="NewTopicAreaTextBox" runat="server" Text='<%# Bind("NewTopicArea") %>' />
            <br />
            AbstractBG:
            <asp:TextBox ID="AbstractBGTextBox" runat="server" Text='<%# Bind("AbstractBG") %>' />
            <br />
            AbstractApproach:
            <asp:TextBox ID="AbstractApproachTextBox" runat="server" Text='<%# Bind("AbstractApproach") %>' />
            <br />
            AbstractResults:
            <asp:TextBox ID="AbstractResultsTextBox" runat="server" Text='<%# Bind("AbstractResults") %>' />
            <br />
            FileName:
            <asp:TextBox ID="FileNameTextBox" runat="server" Text='<%# Bind("FileName") %>' />
            <br />
            LoginNotes:
            <asp:TextBox ID="LoginNotesTextBox" runat="server" Text='<%# Bind("LoginNotes") %>' />
            <br />
            WithdrawnDate:
            <asp:TextBox ID="WithdrawnDateTextBox" runat="server" Text='<%# Bind("WithdrawnDate") %>' />
            <br />
            AbstractTitleAuthorBlock:
            <asp:TextBox ID="AbstractTitleAuthorBlockTextBox" runat="server" Text='<%# Bind("AbstractTitleAuthorBlock") %>' />
            <br />
            ReadyForReview:
            <asp:TextBox ID="ReadyForReviewTextBox" runat="server" Text='<%# Bind("ReadyForReview") %>' />
            <br />
            CorrPresAuth:
            <asp:TextBox ID="CorrPresAuthTextBox" runat="server" Text='<%# Bind("CorrPresAuth") %>' />
            <br />
            Employer:
            <asp:TextBox ID="EmployerTextBox" runat="server" Text='<%# Bind("Employer") %>' />
            <br />
            Admin:
            <asp:TextBox ID="AdminTextBox" runat="server" Text='<%# Bind("Admin") %>' />
            <br />
            SessionCode:
            <asp:TextBox ID="SessionCodeTextBox" runat="server" Text='<%# Bind("SessionCode") %>' />
            <br />
            Declined:
            <asp:CheckBox ID="DeclinedCheckBox" runat="server" Checked='<%# Bind("Declined") %>' />
            <br />
            ReviewNotes:
            <asp:TextBox ID="ReviewNotesTextBox" runat="server" Text='<%# Bind("ReviewNotes") %>' />
            <br />
            FinalFormat:
            <asp:TextBox ID="FinalFormatTextBox" runat="server" Text='<%# Bind("FinalFormat") %>' />
            <br />
            FinalDate:
            <asp:TextBox ID="FinalDateTextBox" runat="server" Text='<%# Bind("FinalDate") %>' />
            <br />
            AdminPersonID:
            <asp:TextBox ID="AdminPersonIDTextBox" runat="server" Text='<%# Bind("AdminPersonID") %>' />
            <br />
            AdminReviewDate:
            <asp:TextBox ID="AdminReviewDateTextBox" runat="server" Text='<%# Bind("AdminReviewDate") %>' />
            <br />
            DeclineNotes:
            <asp:TextBox ID="DeclineNotesTextBox" runat="server" Text='<%# Bind("DeclineNotes") %>' />
            <br />
            PlatformTime:
            <asp:TextBox ID="PlatformTimeTextBox" runat="server" Text='<%# Bind("PlatformTime") %>' />
            <br />
            PosterNum:
            <asp:TextBox ID="PosterNumTextBox" runat="server" Text='<%# Bind("PosterNum") %>' />
            <br />
            UpdatedAbstractReceived:
            <asp:TextBox ID="UpdatedAbstractReceivedTextBox" runat="server" Text='<%# Bind("UpdatedAbstractReceived") %>' />
            <br />
            UpdatedAbstractNotes:
            <asp:TextBox ID="UpdatedAbstractNotesTextBox" runat="server" Text='<%# Bind("UpdatedAbstractNotes") %>' />
            <br />
            ProcPaperReceived:
            <asp:TextBox ID="ProcPaperReceivedTextBox" runat="server" Text='<%# Bind("ProcPaperReceived") %>' />
            <br />
            ProcPaperNotes:
            <asp:TextBox ID="ProcPaperNotesTextBox" runat="server" Text='<%# Bind("ProcPaperNotes") %>' />
            <br />
            ProcPaperTitle:
            <asp:TextBox ID="ProcPaperTitleTextBox" runat="server" Text='<%# Bind("ProcPaperTitle") %>' />
            <br />
            ProcPaperAuthList:
            <asp:TextBox ID="ProcPaperAuthListTextBox" runat="server" Text='<%# Bind("ProcPaperAuthList") %>' />
            <br />
            SpeakerBioReceived:
            <asp:TextBox ID="SpeakerBioReceivedTextBox" runat="server" Text='<%# Bind("SpeakerBioReceived") %>' />
            <br />
            ProcDocNum:
            <asp:TextBox ID="ProcDocNumTextBox" runat="server" Text='<%# Bind("ProcDocNum") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            ConferenceID:
            <asp:TextBox ID="ConferenceIDTextBox" runat="server" Text='<%# Bind("ConferenceID") %>' />
            <br />
            AbstractCode:
            <asp:TextBox ID="AbstractCodeTextBox" runat="server" Text='<%# Bind("AbstractCode") %>' />
            <br />
            Title:
            <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
            <br />
            AuthorList:
            <asp:TextBox ID="AuthorListTextBox" runat="server" Text='<%# Bind("AuthorList") %>' />
            <br />
            DateReceived:
            <asp:TextBox ID="DateReceivedTextBox" runat="server" Text='<%# Bind("DateReceived") %>' />
            <br />
            PreferredFormat:
            <asp:TextBox ID="PreferredFormatTextBox" runat="server" Text='<%# Bind("PreferredFormat") %>' />
            <br />
            SubmissionRequestedBy:
            <asp:TextBox ID="SubmissionRequestedByTextBox" runat="server" Text='<%# Bind("SubmissionRequestedBy") %>' />
            <br />
            AuthorComments:
            <asp:TextBox ID="AuthorCommentsTextBox" runat="server" Text='<%# Bind("AuthorComments") %>' />
            <br />
            ApplicableTopics:
            <asp:TextBox ID="ApplicableTopicsTextBox" runat="server" Text='<%# Bind("ApplicableTopics") %>' />
            <br />
            NewTopicArea:
            <asp:TextBox ID="NewTopicAreaTextBox" runat="server" Text='<%# Bind("NewTopicArea") %>' />
            <br />
            AbstractBG:
            <asp:TextBox ID="AbstractBGTextBox" runat="server" Text='<%# Bind("AbstractBG") %>' />
            <br />
            AbstractApproach:
            <asp:TextBox ID="AbstractApproachTextBox" runat="server" Text='<%# Bind("AbstractApproach") %>' />
            <br />
            AbstractResults:
            <asp:TextBox ID="AbstractResultsTextBox" runat="server" Text='<%# Bind("AbstractResults") %>' />
            <br />
            FileName:
            <asp:TextBox ID="FileNameTextBox" runat="server" Text='<%# Bind("FileName") %>' />
            <br />
            LoginNotes:
            <asp:TextBox ID="LoginNotesTextBox" runat="server" Text='<%# Bind("LoginNotes") %>' />
            <br />
            WithdrawnDate:
            <asp:TextBox ID="WithdrawnDateTextBox" runat="server" Text='<%# Bind("WithdrawnDate") %>' />
            <br />
            AbstractTitleAuthorBlock:
            <asp:TextBox ID="AbstractTitleAuthorBlockTextBox" runat="server" Text='<%# Bind("AbstractTitleAuthorBlock") %>' />
            <br />
            ReadyForReview:
            <asp:TextBox ID="ReadyForReviewTextBox" runat="server" Text='<%# Bind("ReadyForReview") %>' />
            <br />
            CorrPresAuth:
            <asp:TextBox ID="CorrPresAuthTextBox" runat="server" Text='<%# Bind("CorrPresAuth") %>' />
            <br />
            Employer:
            <asp:TextBox ID="EmployerTextBox" runat="server" Text='<%# Bind("Employer") %>' />
            <br />
            Admin:
            <asp:TextBox ID="AdminTextBox" runat="server" Text='<%# Bind("Admin") %>' />
            <br />
            SessionID:
            <asp:TextBox ID="SessionIDTextBox" runat="server" Text='<%# Bind("SessionID") %>' />
            <br />
            SessionCode:
            <asp:TextBox ID="SessionCodeTextBox" runat="server" Text='<%# Bind("SessionCode") %>' />
            <br />
            Declined:
            <asp:CheckBox ID="DeclinedCheckBox" runat="server" Checked='<%# Bind("Declined") %>' />
            <br />
            ReviewNotes:
            <asp:TextBox ID="ReviewNotesTextBox" runat="server" Text='<%# Bind("ReviewNotes") %>' />
            <br />
            FinalFormat:
            <asp:TextBox ID="FinalFormatTextBox" runat="server" Text='<%# Bind("FinalFormat") %>' />
            <br />
            FinalDate:
            <asp:TextBox ID="FinalDateTextBox" runat="server" Text='<%# Bind("FinalDate") %>' />
            <br />
            AdminPersonID:
            <asp:TextBox ID="AdminPersonIDTextBox" runat="server" Text='<%# Bind("AdminPersonID") %>' />
            <br />
            AdminReviewDate:
            <asp:TextBox ID="AdminReviewDateTextBox" runat="server" Text='<%# Bind("AdminReviewDate") %>' />
            <br />
            DeclineNotes:
            <asp:TextBox ID="DeclineNotesTextBox" runat="server" Text='<%# Bind("DeclineNotes") %>' />
            <br />
            PlatformTime:
            <asp:TextBox ID="PlatformTimeTextBox" runat="server" Text='<%# Bind("PlatformTime") %>' />
            <br />
            PosterNum:
            <asp:TextBox ID="PosterNumTextBox" runat="server" Text='<%# Bind("PosterNum") %>' />
            <br />
            UpdatedAbstractReceived:
            <asp:TextBox ID="UpdatedAbstractReceivedTextBox" runat="server" Text='<%# Bind("UpdatedAbstractReceived") %>' />
            <br />
            UpdatedAbstractNotes:
            <asp:TextBox ID="UpdatedAbstractNotesTextBox" runat="server" Text='<%# Bind("UpdatedAbstractNotes") %>' />
            <br />
            ProcPaperReceived:
            <asp:TextBox ID="ProcPaperReceivedTextBox" runat="server" Text='<%# Bind("ProcPaperReceived") %>' />
            <br />
            ProcPaperNotes:
            <asp:TextBox ID="ProcPaperNotesTextBox" runat="server" Text='<%# Bind("ProcPaperNotes") %>' />
            <br />
            ProcPaperTitle:
            <asp:TextBox ID="ProcPaperTitleTextBox" runat="server" Text='<%# Bind("ProcPaperTitle") %>' />
            <br />
            ProcPaperAuthList:
            <asp:TextBox ID="ProcPaperAuthListTextBox" runat="server" Text='<%# Bind("ProcPaperAuthList") %>' />
            <br />
            SpeakerBioReceived:
            <asp:TextBox ID="SpeakerBioReceivedTextBox" runat="server" Text='<%# Bind("SpeakerBioReceived") %>' />
            <br />
            ProcDocNum:
            <asp:TextBox ID="ProcDocNumTextBox" runat="server" Text='<%# Bind("ProcDocNum") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            AbstractID:
            <asp:Label ID="AbstractIDLabel" runat="server" Text='<%# Eval("AbstractID") %>' />
            <br />
            ConferenceID:
            <asp:Label ID="ConferenceIDLabel" runat="server" Text='<%# Bind("ConferenceID") %>' />
            <br />
            AbstractCode:
            <asp:Label ID="AbstractCodeLabel" runat="server" Text='<%# Bind("AbstractCode") %>' />
            <br />
            Title:
            <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>' />
            <br />
            AuthorList:
            <asp:Label ID="AuthorListLabel" runat="server" Text='<%# Bind("AuthorList") %>' />
            <br />
            DateReceived:
            <asp:Label ID="DateReceivedLabel" runat="server" Text='<%# Bind("DateReceived") %>' />
            <br />
            PreferredFormat:
            <asp:Label ID="PreferredFormatLabel" runat="server" Text='<%# Bind("PreferredFormat") %>' />
            <br />
            SubmissionRequestedBy:
            <asp:Label ID="SubmissionRequestedByLabel" runat="server" Text='<%# Bind("SubmissionRequestedBy") %>' />
            <br />
            AuthorComments:
            <asp:Label ID="AuthorCommentsLabel" runat="server" Text='<%# Bind("AuthorComments") %>' />
            <br />
            ApplicableTopics:
            <asp:Label ID="ApplicableTopicsLabel" runat="server" Text='<%# Bind("ApplicableTopics") %>' />
            <br />
            NewTopicArea:
            <asp:Label ID="NewTopicAreaLabel" runat="server" Text='<%# Bind("NewTopicArea") %>' />
            <br />
            AbstractBG:
            <asp:Label ID="AbstractBGLabel" runat="server" Text='<%# Bind("AbstractBG") %>' />
            <br />
            AbstractApproach:
            <asp:Label ID="AbstractApproachLabel" runat="server" Text='<%# Bind("AbstractApproach") %>' />
            <br />
            AbstractResults:
            <asp:Label ID="AbstractResultsLabel" runat="server" Text='<%# Bind("AbstractResults") %>' />
            <br />
            FileName:
            <asp:Label ID="FileNameLabel" runat="server" Text='<%# Bind("FileName") %>' />
            <br />
            LoginNotes:
            <asp:Label ID="LoginNotesLabel" runat="server" Text='<%# Bind("LoginNotes") %>' />
            <br />
            WithdrawnDate:
            <asp:Label ID="WithdrawnDateLabel" runat="server" Text='<%# Bind("WithdrawnDate") %>' />
            <br />
            AbstractTitleAuthorBlock:
            <asp:Label ID="AbstractTitleAuthorBlockLabel" runat="server" Text='<%# Bind("AbstractTitleAuthorBlock") %>' />
            <br />
            ReadyForReview:
            <asp:Label ID="ReadyForReviewLabel" runat="server" Text='<%# Bind("ReadyForReview") %>' />
            <br />
            CorrPresAuth:
            <asp:Label ID="CorrPresAuthLabel" runat="server" Text='<%# Bind("CorrPresAuth") %>' />
            <br />
            Employer:
            <asp:Label ID="EmployerLabel" runat="server" Text='<%# Bind("Employer") %>' />
            <br />
            Admin:
            <asp:Label ID="AdminLabel" runat="server" Text='<%# Bind("Admin") %>' />
            <br />
            SessionID:
            <asp:Label ID="SessionIDLabel" runat="server" Text='<%# Bind("SessionID") %>' />
            <br />
            SessionCode:
            <asp:Label ID="SessionCodeLabel" runat="server" Text='<%# Bind("SessionCode") %>' />
            <br />
            Declined:
            <asp:CheckBox ID="DeclinedCheckBox" runat="server" Checked='<%# Bind("Declined") %>' Enabled="false" />
            <br />
            ReviewNotes:
            <asp:Label ID="ReviewNotesLabel" runat="server" Text='<%# Bind("ReviewNotes") %>' />
            <br />
            FinalFormat:
            <asp:Label ID="FinalFormatLabel" runat="server" Text='<%# Bind("FinalFormat") %>' />
            <br />
            FinalDate:
            <asp:Label ID="FinalDateLabel" runat="server" Text='<%# Bind("FinalDate") %>' />
            <br />
            AdminPersonID:
            <asp:Label ID="AdminPersonIDLabel" runat="server" Text='<%# Bind("AdminPersonID") %>' />
            <br />
            AdminReviewDate:
            <asp:Label ID="AdminReviewDateLabel" runat="server" Text='<%# Bind("AdminReviewDate") %>' />
            <br />
            DeclineNotes:
            <asp:Label ID="DeclineNotesLabel" runat="server" Text='<%# Bind("DeclineNotes") %>' />
            <br />
            PlatformTime:
            <asp:Label ID="PlatformTimeLabel" runat="server" Text='<%# Bind("PlatformTime") %>' />
            <br />
            PosterNum:
            <asp:Label ID="PosterNumLabel" runat="server" Text='<%# Bind("PosterNum") %>' />
            <br />
            UpdatedAbstractReceived:
            <asp:Label ID="UpdatedAbstractReceivedLabel" runat="server" Text='<%# Bind("UpdatedAbstractReceived") %>' />
            <br />
            UpdatedAbstractNotes:
            <asp:Label ID="UpdatedAbstractNotesLabel" runat="server" Text='<%# Bind("UpdatedAbstractNotes") %>' />
            <br />
            ProcPaperReceived:
            <asp:Label ID="ProcPaperReceivedLabel" runat="server" Text='<%# Bind("ProcPaperReceived") %>' />
            <br />
            ProcPaperNotes:
            <asp:Label ID="ProcPaperNotesLabel" runat="server" Text='<%# Bind("ProcPaperNotes") %>' />
            <br />
            ProcPaperTitle:
            <asp:Label ID="ProcPaperTitleLabel" runat="server" Text='<%# Bind("ProcPaperTitle") %>' />
            <br />
            ProcPaperAuthList:
            <asp:Label ID="ProcPaperAuthListLabel" runat="server" Text='<%# Bind("ProcPaperAuthList") %>' />
            <br />
            SpeakerBioReceived:
            <asp:Label ID="SpeakerBioReceivedLabel" runat="server" Text='<%# Bind("SpeakerBioReceived") %>' />
            <br />
            ProcDocNum:
            <asp:Label ID="ProcDocNumLabel" runat="server" Text='<%# Bind("ProcDocNum") %>' />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
        </ItemTemplate>
    </asp:FormView>
</asp:Content>

