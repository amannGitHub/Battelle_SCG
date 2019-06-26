<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="Conferences.aspx.vb" Inherits="Battelle.Conferences"  %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceConfSubjects" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceSubjectGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceConferenceDetails" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="ConferenceInsert" InsertCommandType="StoredProcedure" SelectCommand="ConferenceGetByID" SelectCommandType="StoredProcedure" UpdateCommand="ConferenceUpdate" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="SubjectID" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="ShortName" Type="String" />
            <asp:Parameter Name="URLString" Type="String" />
            <asp:Parameter Name="StartDate" Type="DateTime" />
            <asp:Parameter Name="EndDate" Type="DateTime" />
            <asp:Parameter Name="Venue" Type="String" />
            <asp:Parameter Name="VenueAddress" Type="String" />
            <asp:Parameter Name="VenuePhone" Type="String" />
            <asp:Parameter Name="VenueURL" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="ZipCode" Type="String" />
            <asp:Parameter Name="ConferenceType" Type="String" />
            <asp:Parameter Name="ReturnURL" Type="String" />
            <asp:Parameter Name="AbstractsDueDate" Type="DateTime" />
            <asp:Parameter Name="ExampleAbstractURL" Type="String" />
            <asp:Parameter Name="AbstractReturnURL" Type="String" />
            <asp:Parameter Name="TechnicalProgramScopeURL" Type="String" />
            <asp:Parameter Name="PreliminaryProgramDate" Type="DateTime" />
            <asp:Parameter Name="FinalPlacementDate" Type="DateTime" />
            <asp:Parameter Name="SponsorOpportunityURL" Type="String" />
            <asp:Parameter Name="SponsorReservationDate" Type="DateTime" />
            <asp:Parameter Name="ExhibitPageOpen" Type="Boolean" />
            <asp:Parameter Name="ExhibitRegistrationDate" Type="DateTime" />
            <asp:Parameter Name="ExhibitRegistrationCloseDate" Type="DateTime" />
            <asp:Parameter Name="ExhibitPayByDate" Type="DateTime" />
            <asp:Parameter Name="ExhibitCancelByDate" Type="DateTime" />
            <asp:Parameter Name="WhoShouldExhibit" Type="String" />
            <asp:Parameter Name="BoothStaffCount" Type="Int32" />
            <asp:Parameter Name="BoothStaffRegisterByDate" Type="DateTime" />
            <asp:Parameter Name="BoothStaffChangeFee" Type="Int32" />
            <asp:Parameter Name="TermsConditions" Type="String" />
            <asp:Parameter Name="SponsorTermsConditions" Type="String" />
            <asp:Parameter Name="TechSessionStaffCount" Type="Int32" />
            <asp:Parameter Name="TechSessionFee" Type="Int32" />
            <asp:Parameter Name="TechSessionStaffCancelByDate" Type="DateTime" />
            <asp:Parameter Name="TechSessionCancelServiceFee" Type="Int32" />
            <asp:Parameter Name="MailingListFirstDate" Type="DateTime" />
            <asp:Parameter Name="MailingListSecondDate" Type="DateTime" />
            <asp:Parameter Name="MailingListFee" Type="Int32" />
            <asp:Parameter Name="RegistrationFeeIncreaseDate" Type="DateTime" />
            <asp:Parameter Name="RegistrationCancelByDate" Type="DateTime" />
            <asp:Parameter Name="RegistrationCloseDate" Type="DateTime" />
            <asp:Parameter Name="ShortCourseOpen" Type="DateTime" />
            <asp:Parameter Name="ShortCourseClose" Type="DateTime" />
            <asp:Parameter Name="NoRefundDate" Type="DateTime" />
            <asp:Parameter Name="MeetingPlannerPersonID" Type="Int32" />
            <asp:Parameter Name="MeetingPlanner" Type="String" />
            <asp:Parameter Name="ConferenceEmail" Type="String" />
            <asp:Parameter Name="SCGContractCode" Type="String" />
            <asp:Parameter Name="CouponCode" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvConferences" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="SubjectID" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="ShortName" Type="String" />
            <asp:Parameter Name="URLString" Type="String" />
            <asp:Parameter Name="StartDate" Type="DateTime" />
            <asp:Parameter Name="EndDate" Type="DateTime" />
            <asp:Parameter Name="Venue" Type="String" />
            <asp:Parameter Name="VenueAddress" Type="String" />
            <asp:Parameter Name="VenuePhone" Type="String" />
            <asp:Parameter Name="VenueURL" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="ZipCode" Type="String" />
            <asp:Parameter Name="ConferenceType" Type="String" />
            <asp:Parameter Name="ReturnURL" Type="String" />
            <asp:Parameter Name="AbstractsDueDate" Type="DateTime" />
            <asp:Parameter Name="ExampleAbstractURL" Type="String" />
            <asp:Parameter Name="AbstractReturnURL" Type="String" />
            <asp:Parameter Name="TechnicalProgramScopeURL" Type="String" />
            <asp:Parameter Name="PreliminaryProgramDate" Type="DateTime" />
            <asp:Parameter Name="FinalPlacementDate" Type="DateTime" />
            <asp:Parameter Name="SponsorOpportunityURL" Type="String" />
            <asp:Parameter Name="SponsorReservationDate" Type="DateTime" />
            <asp:Parameter Name="ExhibitPageOpen" Type="Boolean" />
            <asp:Parameter Name="ExhibitRegistrationDate" Type="DateTime" />
            <asp:Parameter Name="ExhibitRegistrationCloseDate" Type="DateTime" />
            <asp:Parameter Name="ExhibitPayByDate" Type="DateTime" />
            <asp:Parameter Name="ExhibitCancelByDate" Type="DateTime" />
            <asp:Parameter Name="WhoShouldExhibit" Type="String" />
            <asp:Parameter Name="BoothStaffCount" Type="Int32" />
            <asp:Parameter Name="BoothStaffRegisterByDate" Type="DateTime" />
            <asp:Parameter Name="BoothStaffChangeFee" Type="Int32" />
            <asp:Parameter Name="TermsConditions" Type="String" />
            <asp:Parameter Name="SponsorTermsConditions" Type="String" />
            <asp:Parameter Name="TechSessionStaffCount" Type="Int32" />
            <asp:Parameter Name="TechSessionFee" Type="Int32" /> 
            <asp:Parameter Name="TechSessionStaffCancelByDate" Type="DateTime" />
            <asp:Parameter Name="TechSessionCancelServiceFee" Type="Int32" />
            <asp:Parameter Name="MailingListFirstDate" Type="DateTime" />
            <asp:Parameter Name="MailingListSecondDate" Type="DateTime" />
            <asp:Parameter Name="MailingListFee" Type="Int32" />
            <asp:Parameter Name="RegistrationFeeIncreaseDate" Type="DateTime" />
            <asp:Parameter Name="RegistrationCancelByDate" Type="DateTime" />
            <asp:Parameter Name="RegistrationCloseDate" Type="DateTime" />
            <asp:Parameter Name="ShortCourseOpen" Type="DateTime" />
            <asp:Parameter Name="ShortCourseClose" Type="DateTime" />
            <asp:Parameter Name="NoRefundDate" Type="DateTime" />
            <asp:Parameter Name="MeetingPlannerPersonID" Type="Int32" />
            <asp:Parameter Name="MeetingPlanner" Type="String" />
            <asp:Parameter Name="ConferenceEmail" Type="String" />
            <asp:Parameter Name="SCGContractCode" Type="String" />
            <asp:Parameter Name="CouponCode" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceConferenceList" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:LinkButton ID="btnNew" runat="server">Create New Conference</asp:LinkButton>
    <asp:DetailsView ID="dvConference" runat="server" AutoGenerateRows="False" DataKeyNames="ConferenceID" DataSourceID="SqlDataSourceConferenceDetails" Visible="False">
        <Fields>

            <asp:BoundField DataField="ConferenceID" HeaderText="ConferenceID" SortExpression="ConferenceID" InsertVisible="False" ReadOnly="True" />
            
                        <asp:TemplateField HeaderText="Subject">
                <InsertItemTemplate>
                    <asp:DropDownList ID="ddlSubject" runat="server" DataSourceID="SqlDataSourceConfSubjects" DataTextField="Subject" DataValueField="SubjectID" SelectedValue='<%# Bind("SubjectID")%>'></asp:DropDownList>
                </InsertItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlSubject" runat="server" DataSourceID="SqlDataSourceConfSubjects" DataTextField="Subject" DataValueField="SubjectID" SelectedValue='<%# Bind("SubjectID")%>'></asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSubject" runat="server" Text='<%# Bind("Subject") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText="Long Name" SortExpression="Name" ControlStyle-Width="600px" NullDisplayText='<span class="label label-danger">Name Not Set</span>' >
<ControlStyle Width="600px"></ControlStyle>
            </asp:BoundField>
            <asp:BoundField DataField="ShortName" HeaderText="Short Name" SortExpression="ShortName"  ControlStyle-Width="300px" NullDisplayText='<span class="label label-danger">Short Name Not Set</span>' >
<ControlStyle Width="300px"></ControlStyle>
            </asp:BoundField>
            <asp:BoundField DataField="URLString" HeaderText="URL String (e.g. sediments2017)" SortExpression="URLString" NullDisplayText='<span class="label label-danger">URL String Not Set</span>' />
            <asp:BoundField DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="EndDate" HeaderText="End Date" SortExpression="EndDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="Venue" HeaderText="Venue" SortExpression="Venue" NullDisplayText='<span class="label label-danger">Venu Not Set</span>' />
            <asp:BoundField DataField="VenueAddress" HeaderText="Venue Address" SortExpression="VenueAddress" NullDisplayText='<span class="label label-warning">Venue Address Not Set</span>' />
            <asp:BoundField DataField="VenuePhone" HeaderText="Venue Phone" SortExpression="VenuePhone" NullDisplayText='<span class="label label-warning">Venue Phone Number Not Set</span>' />
            <asp:BoundField DataField="VenueURL" HeaderText="Venue URL" SortExpression="VenueURL"  ControlStyle-Width="600px" NullDisplayText='<span class="label label-warning">URL Not Set</span>'  >
<ControlStyle Width="600px"></ControlStyle>
            </asp:BoundField>
            <asp:BoundField DataField="City" HeaderText="Venue City" SortExpression="City" NullDisplayText='<span class="label label-danger">Venu City Not Set</span>' />
            <asp:BoundField DataField="State" HeaderText="Venue State" SortExpression="State" NullDisplayText='<span class="label label-danger">Venu State Not Set</span>' />
            <asp:BoundField DataField="ZipCode" HeaderText="Venue Zip Code" SortExpression="ZipCode" NullDisplayText='<span class="label label-warning">Venu Zip Code Not Set</span>' />
            <asp:BoundField DataField="ConferenceType" HeaderText="Conference Type" SortExpression="ConferenceType" NullDisplayText='<span class="label label-danger">Conference Type Not Set</span>' />
            <asp:BoundField DataField="ReturnURL" HeaderText="Battelle Conference URL" SortExpression="ReturnURL"  ControlStyle-Width="600px" NullDisplayText='<span class="label label-danger">Conference URL Not Set</span>'>
<ControlStyle Width="600px"></ControlStyle>
            </asp:BoundField>
            <asp:BoundField DataField="AbstractsDueDate" HeaderText="Abstracts Due Date" SortExpression="AbstractsDueDate"  NullDisplayText='<span class="label label-danger">No Date Set</span>'/>
            <asp:BoundField DataField="ExampleAbstractURL" HeaderText="Example Abstract URL (from Battelle)" SortExpression="ExampleAbstractURL" ControlStyle-Width="600px"  NullDisplayText='<span class="label label-warning">URL Not Set</span>' >
<ControlStyle Width="600px"></ControlStyle>
            </asp:BoundField>
            <asp:BoundField DataField="AbstractReturnURL" HeaderText="Abstract Return URL (from Battelle)" SortExpression="AbstractReturnURL" ControlStyle-Width="600px" NullDisplayText='<span class="label label-warning">URL Not Set</span>' >
<ControlStyle Width="600px"></ControlStyle>
            </asp:BoundField>
            <asp:BoundField DataField="TechnicalProgramScopeURL" HeaderText="Technical Program Scope URL (from Battelle)" SortExpression="TechnicalProgramScopeURL"  ControlStyle-Width="600px" NullDisplayText='<span class="label label-warning">URL Not Set</span>'>
<ControlStyle Width="600px"></ControlStyle>
            </asp:BoundField>
            <asp:BoundField DataField="PreliminaryProgramDate" HeaderText="Preliminary Program Date" SortExpression="PreliminaryProgramDate"  NullDisplayText='<span class="label label-danger">No Date Set</span>'/>
            <asp:BoundField DataField="FinalPlacementDate" HeaderText="Final Placement Date" SortExpression="FinalPlacementDate"  NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="SponsorOpportunityURL" HeaderText="Sponsor Opportunity URL (from Battelle)" SortExpression="SponsorOpportunityURL"  ControlStyle-Width="600px" NullDisplayText='<span class="label label-warning">URL Not Set</span>'>
<ControlStyle Width="600px"></ControlStyle>
            </asp:BoundField>
            <asp:BoundField DataField="SponsorReservationDate" HeaderText="Sponsor Reservation Date" SortExpression="SponsorReservationDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="ExhibitPageOpen" HeaderText="Open Exhibit Pages?" SortExpression="ExhibitPageOpen" NullDisplayText='<span class="label label-danger">Not Set</span>' />
            <asp:BoundField DataField="ExhibitRegistrationDate" HeaderText="Exhibit Registration Open Date" SortExpression="ExhibitRegistrationDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="ExhibitRegistrationCloseDate" HeaderText="Exhibitor Registration Close Date" SortExpression="ExhibitRegistrationCloseDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="ExhibitPayByDate" HeaderText="Exhibitor Pay By Date" SortExpression="ExhibitPayByDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="ExhibitCancelByDate" HeaderText="Exhibitor Cancel By Date" SortExpression="ExhibitCancelByDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="WhoShouldExhibit" HeaderText="Who Should Exhibit" SortExpression="WhoShouldExhibit" NullDisplayText='<span class="label label-danger">No text</span>' />
            <asp:BoundField DataField="BoothStaffCount" HeaderText="Booth Staff Allowed (must be set in Conference Staff Limit table by developer)" SortExpression="BoothStaffCount"  NullDisplayText='<span class="label label-warning">Add a number when this is set by developer (make sure they add two rows in Conference Staff Limit if booth limit is 2)</span>' />
            <asp:BoundField DataField="BoothStaffRegisterByDate" HeaderText="Booth Staff Register By Date" SortExpression="BoothStaffRegisterByDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="BoothStaffChangeFee" HeaderText="Booth Staff Change Fee" SortExpression="BoothStaffChangeFee" NullDisplayText='<span class="label label-danger">Fee Not Set</span>' />
            <asp:TemplateField HeaderText="Exhibitor Terms Conditions (use class table-bordered for tables)" SortExpression="TermsConditions">
                <EditItemTemplate>
                    <telerik:RadEditor ID="RadEditorTermsConditions" runat="server" Width="100%" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" StripFormattingOnPaste="NoneSupressCleanMessage" StripFormattingOptions="NoneSupressCleanMessage" ContentAreaCssFile="~/Content/radEditor.css" Content='<%# Bind("TermsConditions")%>'>
                                </telerik:RadEditor>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <telerik:RadEditor ID="RadEditorTermsConditions" runat="server" Width="100%" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" StripFormattingOnPaste="NoneSupressCleanMessage" StripFormattingOptions="NoneSupressCleanMessage" ContentAreaCssFile="~/Content/radEditor.css" Content='<%# Bind("TermsConditions")%>'>
                                </telerik:RadEditor>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("TermsConditions") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sponsor Terms & Conditions (use class table-bordered for tables)" SortExpression="SponsorTermsConditions">
                <EditItemTemplate>
                    <telerik:RadEditor ID="RadEditorSponsorTermsConditions" runat="server" Width="100%" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" StripFormattingOnPaste="NoneSupressCleanMessage" StripFormattingOptions="NoneSupressCleanMessage" ContentAreaCssFile="~/Content/radEditor.css" Content='<%# Bind("SponsorTermsConditions")%>'>
                                </telerik:RadEditor>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <telerik:RadEditor ID="RadEditorSponsorTermsConditions" runat="server" Width="100%" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" StripFormattingOnPaste="NoneSupressCleanMessage" StripFormattingOptions="NoneSupressCleanMessage" ContentAreaCssFile="~/Content/radEditor.css" Content='<%# Bind("SponsorTermsConditions")%>'>
                                </telerik:RadEditor>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("SponsorTermsConditions") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TechSessionStaffCount" HeaderText="Tech Session Staff Count (Set by Developer)" SortExpression="TechSessionStaffCount" NullDisplayText='<span class="label label-warning">Add a number when this is set by developer</span>' />
            <asp:BoundField DataField="TechSessionFee" HeaderText="Tech Session Fee (Set by Developer)" SortExpression="TechSessionFee" NullDisplayText='<span class="label label-warning">Add a number when this is set by developer</span>' />
            <asp:BoundField DataField="TechSessionStaffCancelByDate" HeaderText="Tech Session Staff Cancel By Date" SortExpression="TechSessionStaffCancelByDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="TechSessionCancelServiceFee" HeaderText="Tech Session Cancellation Service Fee" SortExpression="TechSessionCancelServiceFee" NullDisplayText='<span class="label label-danger">Fee Not Set</span>' />
            <asp:BoundField DataField="MailingListFirstDate" HeaderText="First Mailing List Date" SortExpression="MailingListFirstDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="MailingListSecondDate" HeaderText="Second Mailing List Date" SortExpression="MailingListSecondDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="MailingListFee" HeaderText="Mailing List Fee" SortExpression="MailingListFee" NullDisplayText='<span class="label label-danger">Fee Not Set</span>' />
            <asp:BoundField DataField="RegistrationFeeIncreaseDate" HeaderText="Registration Fee Increase Date" SortExpression="RegistrationFeeIncreaseDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="RegistrationCancelByDate" HeaderText="Registration Cancel By Date" SortExpression="RegistrationCancelByDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="RegistrationCloseDate" HeaderText="Registration Close Date" SortExpression="RegistrationCloseDate" NullDisplayText='<span class="label label-danger">No Date Set</span>'  />
            <asp:BoundField DataField="ShortCourseOpen" HeaderText="Short Course Open Date" SortExpression="ShortCourseOpen" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="ShortCourseClose" HeaderText="Short Course Close Date" SortExpression="ShortCourseClose" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="NoRefundDate" HeaderText="No Refund Date" SortExpression="NoRefundDate" NullDisplayText='<span class="label label-danger">No Date Set</span>' />
            <asp:BoundField DataField="MeetingPlannerPersonID" HeaderText="Meeting Planner PersonID (Susie is 215)" SortExpression="MeetingPlannerPersonID"  NullDisplayText='<span class="label label-danger">Set to 215 (if Susie)</span>'/>
            <asp:BoundField DataField="MeetingPlanner" HeaderText="Meeting Planner Name" SortExpression="MeetingPlanner"  NullDisplayText='<span class="label label-danger">Set to Susie Warner</span>'/>
            <asp:BoundField DataField="ConferenceEmail" HeaderText="Conference Email" SortExpression="ConferenceEmail"  NullDisplayText='<span class="label label-danger">Add email address</span>'/>
            <asp:BoundField DataField="SCGContractCode" HeaderText="SCG Charge #" SortExpression="SCGContractCode"  NullDisplayText='<span class="label label-danger">Add charge code (for payments)</span>'/>
           
            <asp:BoundField DataField="CouponCode" HeaderText="Coupon Code" SortExpression="CouponCode"  NullDisplayText='<span class="label label-info">No value for free registration set</span>'/>

            
            <asp:BoundField DataField="CreateDate" HeaderText="CreateDate" SortExpression="CreateDate" InsertVisible="False" ReadOnly="True" />
            <asp:CommandField ShowEditButton="True" ShowInsertButton="True" ButtonType="Button" EditText="Edit This Conference" NewText="Add a New Conference" UpdateText="Update This Conference" >
            <ControlStyle CssClass="btn btn-primary" />
            </asp:CommandField>
            <asp:ImageField HeaderText="Page Banner" DataImageUrlField="URLString" DataImageUrlFormatString="~/images/banners/{0}.jpg" ReadOnly="True" InsertVisible="False" />
            <asp:ImageField HeaderText="Email Banner" DataImageUrlField="URLString" DataImageUrlFormatString="~/images/emailbanners/{0}.jpg" ReadOnly="True" InsertVisible="False" />
        </Fields>
    </asp:DetailsView>
    <br /><br />
    <asp:GridView ID="gvConferences" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ConferenceID" DataSourceID="SqlDataSourceConferenceList">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkbtnSelect" runat="server" CommandName="Select">Select</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ConferenceID" HeaderText="ConferenceID" InsertVisible="False" ReadOnly="True" SortExpression="ConferenceID" />
            <asp:BoundField DataField="URLString" HeaderText="URLString" SortExpression="URLString" />
            <asp:BoundField DataField="ShortName" HeaderText="ShortName" SortExpression="ShortName" />
            
            
            
            
            <asp:BoundField DataField="StartDate" HeaderText="StartDate" SortExpression="StartDate" />
            <asp:BoundField DataField="EndDate" HeaderText="EndDate" SortExpression="EndDate" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" />
        </Columns>
    </asp:GridView>
</asp:Content>
