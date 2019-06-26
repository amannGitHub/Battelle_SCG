<%@ Page Title="Abstract Submission Form" Language="vb" AutoEventWireup="false" MasterPageFile="~/Abstract/Abstracts.Master" CodeBehind="Abstracts.aspx.vb" Inherits="Battelle.AbstractsForm" MaintainScrollPositionOnPostback="False" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/SessionHandler.ascx" TagPrefix="controls" TagName="SessionHandler" %>
<%@ Register Src="../ParticipationIDLogin.ascx" TagName="ParticipationIDLogin" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/Abstract/Abstracts.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hdnEmail" runat="server" />
    <asp:HiddenField ID="hdnEmail2" runat="server" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <link href='<%= Telerik.Web.SkinRegistrar.GetWebResourceUrl(me, GetType(RadEditor), "Telerik.Web.UI.Skins.Editor.css") %>'
            rel="stylesheet" type="text/css" />
        <link href='<%= Telerik.Web.SkinRegistrar.GetWebResourceUrl(me, GetType(RadEditor), "Telerik.Web.UI.Skins.Default.Editor.Default.css") %>'
            rel="stylesheet" type="text/css" />
        <link href='<%= Telerik.Web.SkinRegistrar.GetWebResourceUrl(me, GetType(RadWindow), "Telerik.Web.UI.Skins.Window.css") %>'
            rel="stylesheet" type="text/css" />
        <link href='<%= Telerik.Web.SkinRegistrar.GetWebResourceUrl(me, GetType(RadWindow), "Telerik.Web.UI.Skins.Default.Window.Default.css") %>'
            rel="stylesheet" type="text/css" />
    </telerik:RadCodeBlock>
    <script type="text/javascript">
        function SetFocus() {
            document.getElementById('<%=ListBoxAbstractAuthors.ClientID%>').focus();
            return false;
        }

    </script>
    <h1>Abstract Submission</h1>


    <asp:Panel ID="PanelAbstractTop" runat="server">
        <asp:SqlDataSource ID="SqlDataSourceSession" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SessionGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceRequested" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT     a.ConferenceID, a.PersonID, a.SessionID, b.LastName, b.FirstName, c.TopicCode, c.SessionName, b.Employer, 
FirstName + ' ' + LastName + ' ' + Employer + ' ' + TopicCode as SubmitName,   LastName + ', ' + FirstName + ' (' + Employer + ') - ' + TopicCode + ': ' + SessionName as DisplayName
	FROM         ConferencePersonRoles a INNER JOIN
					Person b ON a.PersonID = b.personID INNER JOIN
					Session c ON c.sessionID = a.SessionID
	WHERE     RoleID = 3 AND a.ConferenceID = @ConferenceID AND Accepted = 1 ORDER BY LastName">
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <!--<div class="jumbotron">
            <div class="container">
                Battelle conferences now utilize a <b>"Participant Code"</b> for all contacts. If you have 
                attended or have been a co-author on an abstract for a recent Battelle conference, you may already have a 
                Participant Code. The Participant Code will be used to retrieve your contact information 
                when you submit abstracts or register for this and future conferences. After accepting the terms below you will be 
                prompted to enter your Participant Code if you already know it or it will be generated and emailed to you for future use.
            </div>
        </div>-->
        <h3>Submission Instructions</h3>
        You will need the following in order to complete this form and submit an abstract:
        <ul>
            <li>An abstract (maximum one 8.5”x11”  page) in Microsoft® WORD format, prepared according to the instructions in the 
                <asp:HyperLink ID="lnkExampleAbstract" runat="server" Target="_blank">example abstract</asp:HyperLink>. Have the abstract file open—you will copy and paste sections of it into the submission form. You will then be <u>required</u> to upload the WORD document.</li>
            <li>Complete contact information—postal address, office phone number, and 
                email address— for every author listed on the abstract.</li>
        </ul>
        <strong>For optimal screen view and navigation, please use Windows&reg; IE Version 10 (or higher), Google Chrome, or Mozilla Firefox&reg;.</strong>
        <h3>Submission Terms &amp; Conditions</h3>

        Abstract submission terms and conditions are subject to change at any time, without notice. Battelle reserves the right to edit abstracts for required formatting and for grammatical, punctuation, and 
                capitalization errors. If significant editing is required, we will ask you to resubmit the abstract with the 
                required changes. Battelle reserves the right to decline any abstract that contains excessive promotional/marketing 
                content and/or does not fit the
                <asp:HyperLink ID="lnkTechnicalScope" runat="server" Target="_blank">technical scope</asp:HyperLink>.
                <br />
        By submitting the abstract, you confirm that the proposed presentation will be original and that you have 
                obtained any necessary permission (e.g., client approval, copyright) for the content. In addition, you agree 
                to the following:
        <ol>
            <li>Battelle will circulate the abstract for review among members of the
                <asp:Label ID="lblConference2" runat="server" Text="[TBD]"></asp:Label>
                Program Committee and the chairs of applicable sessions. </li>
            <li>If the proposed presentation is accepted for the program, Battelle will:
                <ul>
                    <li>Include the citation information (title and authors’ names) in the Preliminary <%--Program (to be posted at 
                        the
                        <asp:Label ID="lblConfType1" runat="server" Text="Conference"></asp:Label>
                        website in
                        <asp:Label ID="lblPreliminaryProgram" runat="server" Text="[TBD]"></asp:Label>)--%> and Final Program materials.</li>
                    <li>Reproduce the abstract and any associated presentation file, including PowerPoints (as a PDF, without speaker notes) for 
                        platform presentations and poster PDFs, in printed and/or digital documents. Examples include, but are not limited to, an abstract collection 
                        and/or mobile scheduling application released shortly before the 
                        <%=sConferenceType%>
                        and the proceedings released 
                        after the
                        <%=sConferenceType%>. 
                        You will have an opportunity to submit an updated 
                        abstract before the
                        <%=sConferenceType%>; 
                        details will be provided with program placement notification emails.</li>
                </ul>
            </li>
            <li>Battelle may contact you and any authors appearing on the abstract with information about the
                <asp:Label ID="lblConference3" runat="server" Text="Label"></asp:Label>
                and other Battelle conferences.</li>
            <li>The corresponding/presenting author is the person who intends to give the platform or poster presentation at the 
                <%=sConferenceType%>. This person will be the contact for all 
                communication from the
                <%=sConferenceType%>
                Office about this 
                abstract. If there is a change in the corresponding/presenting author for this abstract, please notify us 
                immediately by sending an email to
                <asp:HyperLink ID="lnkSubjectEmail" runat="server" Target="_blank"></asp:HyperLink>
            </li>
            <li>If you are not the corresponding/presenting author or if the corresponding/presenting author changes later, you will communicate these Submission Terms to the corresponding/presenting author. </li>
        </ol>
        <asp:Button ID="btnBegin" runat="server" Text="I understand the terms and I am ready to submit an abstract" CssClass="btn btn-primary" />
    </asp:Panel>

    <asp:Panel ID="PanelParticipationControl" runat="server" Visible="False">
        <asp:Label ID="lblParticipantCodeNote" runat="server" Text="<b>Note:</b> If you are submitting this abstract on behalf of the corresponding/presenting author, proceed using <u>your</u> participant code. You will be able to change the corresponding/presenting author designation on the abstract submittal screen.<br />"></asp:Label>

        <uc1:ParticipationIDLogin ID="ParticipationIDLoginAbstracts" runat="server" OnFinishedLogin="ParticipationIDLoginAbstracts_FinishedLogin" />
    </asp:Panel>

    <asp:UpdatePanel ID="UpdatePanelAbstract" runat="server">
        <ContentTemplate>

            <asp:Panel ID="PanelAbstractsMain" runat="server" Visible="False">

                
                <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [CountryName], [CountryCode] FROM [LookupCountry] Order By [ListOrder]"></asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT     LookupStateProvince.StateProvinceAbbreviation, (LookupStateProvince.StateProvinceName + ' (' + LookupStateProvince.CountryCode + ')') as ListStateProvinceName
FROM         LookupStateProvince LEFT OUTER JOIN
                      LookupCountry ON LookupStateProvince.CountryCode = LookupCountry.CountryCode
ORDER BY LookupCountry.ListOrder, LookupStateProvince.StateProvinceName"></asp:SqlDataSource>
                <h3>Author Information and Abstract Submission</h3>
                <strong>Completing the Form</strong>
                <ul>
                    <li>Do not use the “Enter” key to move from field-to-field, this may cause an incomplete and/or duplicate abstract submission. Use the tab key or your mouse to move from one field to the next.</li>
                    <li>Use standard capitalization &mdash; do not use ALL CAPITAL or all lower case letters.</li>
                </ul>
                <strong>Submission Confirmation.</strong> You, as the submitter, and the corresponding/presenting author will each receive a copy of the abstract confirmation email after you complete the submission. If you do not receive a confirmation email please contact the <%=sConferenceType%> Office at <strong><asp:HyperLink ID="lnkSubjectEmail3" runat="server" Target="_blank"></asp:HyperLink></strong>.
                <h4>Corresponding/Presenting Author</h4>
                <strong>As the person submitting this form, you are automatically listed as the corresponding/presenting author</strong>. If you are not the person that will be presenting this abstract at the <%=sConferenceType%> and you are submitting it on behalf of the corresponding/presenting author, you must enter that person as a co-author and then follow the instructions under the Co-Authors box to change the corresponding/presenting author designation. 
                <asp:Label ID="LabelAbstractValidation" runat="server"></asp:Label>
                <div class="form-group">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Literal ID="LiteralAlertDivOpen" runat="server" Text='<div class="alert alert-info" role="alert">'></asp:Literal>
                                
                                <h4>Corresponding/Presenting Author</h4>

                                <b><asp:Label ID="lblCorPresAuthor" runat="server" Text=""></asp:Label></b>
                                <asp:HiddenField ID="hdnCorPres" runat="server" />
                                <asp:Label ID="lblCorPresAuthorWarning" runat="server" Text="You cannot remove the Corresponding/Presenting Author without selecting a replacement." Visible="False"></asp:Label>
                                <asp:Literal ID="LiteralAlertDivClose" runat="server" Text="</div>"></asp:Literal>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblAuthors" runat="server" Text="*Co-Authors" AssociatedControlID="ListBoxAbstractAuthors"></asp:Label><br />
                                <strong>Add Co-Authors.</strong> If there are additional authors listed on the abstract, click the blue "Add co-authors" button below. Wait for the prompt to appear to search for your co-author’s email address in our database. Complete contact information—postal address, office phone number, and email address—is required for every author listed on the abstract. 
                                <br />
                                <br />
                                <strong>Co-Presenters.</strong> Only one person may be designated as the corresponding/presenting author—co-presenters <strong>are not</strong> permitted.
                                <br />
                                <br />
                                <strong>Change the Corresponding/Presenting Author.</strong> Enter the corresponding/presenting author as a co-author. Click on their name in the box below and wait for the green “Set as Corresponding/Presenting Author” button to appear. Click the button to change them to the corresponding/presenting author.
                                <br />
                                <br />
                                <strong>Remove Yourself (or another Author) as a Co-Author.</strong> If you are not one of the authors, or have entered someone by mistake, click on the name you want to remove and wait for the orange “Remove Selected Author” button to appear. Click the button to remove the selected name. 
                                <asp:ListBox ID="ListBoxAbstractAuthors" runat="server" AutoPostBack="True" CssClass="form-control" Height="120px"></asp:ListBox>
                                <asp:Button ID="ButtonAuthorsAdd" runat="server" Text="Add co-authors" CssClass="btn btn-primary" UseSubmitBehavior="False" />&nbsp;
                                <asp:Button ID="ButtonCorPresAuthorSet" runat="server" Text="Set as Corresponding/Presenting Author" CssClass="btn btn-success" UseSubmitBehavior="False" Visible="False" />&nbsp;
                                <asp:Button ID="ButtonAuthorsRemove" runat="server" Text="Remove selected author" Visible="False" CssClass="btn btn-warning" UseSubmitBehavior="False" /><br /> 
                            </div>
                        </div>
                    </div>
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
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblFirstName" runat="server" Text="First Name/Middle Initial" AssociatedControlID="FirstNameTextBox"></asp:Label>
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
                                            <h6>If you have typed an incorrect email address, click
                                                <asp:LinkButton ID="LinkButtonCancel" runat="server" CommandName="Cancel" CausesValidation="False">Cancel</asp:LinkButton>.</h6>
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
                                                    <small>(<%=sConferenceType%>office use only; will not be disseminated.)</small></h5>
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
                                            <b>First Name/Middle Initial:</b>
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
                                            <asp:HyperLink ID="HyperLinkCoAuth" runat="server" NavigateUrl='<%#hdnEmail2.Value%>'><%=hdnEmail.Value%></asp:HyperLink>
                                            explaining what you believe should be corrected and provide the email and address for your co-author. Please copy and paste the information displayed into your email and include the title of your abstract.
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
                        <asp:SqlDataSource ID="SqlDataSourcePersonLookup" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Person] WHERE [PersonID] = @original_PersonID AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([Employer] = @original_Employer) OR ([Employer] IS NULL AND @original_Employer IS NULL)) AND (([AddressLine1] = @original_AddressLine1) OR ([AddressLine1] IS NULL AND @original_AddressLine1 IS NULL)) AND (([AddressLine2] = @original_AddressLine2) OR ([AddressLine2] IS NULL AND @original_AddressLine2 IS NULL)) AND (([AddressLine3] = @original_AddressLine3) OR ([AddressLine3] IS NULL AND @original_AddressLine3 IS NULL)) AND (([City] = @original_City) OR ([City] IS NULL AND @original_City IS NULL)) AND (([StateProvince] = @original_StateProvince) OR ([StateProvince] IS NULL AND @original_StateProvince IS NULL)) AND (([ZipPostal] = @original_ZipPostal) OR ([ZipPostal] IS NULL AND @original_ZipPostal IS NULL)) AND (([Country] = @original_Country) OR ([Country] IS NULL AND @original_Country IS NULL)) AND (([PhoneNum] = @original_PhoneNum) OR ([PhoneNum] IS NULL AND @original_PhoneNum IS NULL)) AND (([CellNum] = @original_CellNum) OR ([CellNum] IS NULL AND @original_CellNum IS NULL)) AND (([Email] = @original_Email) OR ([Email] IS NULL AND @original_Email IS NULL))  AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL))" InsertCommand="INSERT INTO [Person] ([FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [Notes]) VALUES (@FirstName, @LastName, @Employer, @AddressLine1, @AddressLine2, @AddressLine3, @City, @StateProvince, @ZipPostal, @Country, @PhoneNum, @CellNum, @Email, @Notes)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [Notes], [PersonID] FROM [Person] WHERE ([Email] = @Email OR [AltPOC] = @Email)" UpdateCommand="UPDATE [Person] SET [FirstName] = @FirstName, [LastName] = @LastName, [Employer] = @Employer, [AddressLine1] = @AddressLine1, [AddressLine2] = @AddressLine2, [AddressLine3] = @AddressLine3, [City] = @City, [StateProvince] = @StateProvince, [ZipPostal] = @ZipPostal, [Country] = @Country, [PhoneNum] = @PhoneNum, [CellNum] = @CellNum, [Email] = @Email, [Notes] = @Notes WHERE [PersonID] = @original_PersonID AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([Employer] = @original_Employer) OR ([Employer] IS NULL AND @original_Employer IS NULL)) AND (([AddressLine1] = @original_AddressLine1) OR ([AddressLine1] IS NULL AND @original_AddressLine1 IS NULL)) AND (([AddressLine2] = @original_AddressLine2) OR ([AddressLine2] IS NULL AND @original_AddressLine2 IS NULL)) AND (([AddressLine3] = @original_AddressLine3) OR ([AddressLine3] IS NULL AND @original_AddressLine3 IS NULL)) AND (([City] = @original_City) OR ([City] IS NULL AND @original_City IS NULL)) AND (([StateProvince] = @original_StateProvince) OR ([StateProvince] IS NULL AND @original_StateProvince IS NULL)) AND (([ZipPostal] = @original_ZipPostal) OR ([ZipPostal] IS NULL AND @original_ZipPostal IS NULL)) AND (([Country] = @original_Country) OR ([Country] IS NULL AND @original_Country IS NULL)) AND (([PhoneNum] = @original_PhoneNum) OR ([PhoneNum] IS NULL AND @original_PhoneNum IS NULL)) AND (([CellNum] = @original_CellNum) OR ([CellNum] IS NULL AND @original_CellNum IS NULL)) AND (([Email] = @original_Email) OR ([Email] IS NULL AND @original_Email IS NULL))  AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL))">
                            <DeleteParameters>
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
                            </DeleteParameters>
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
                    <br />
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <h4>Citation</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">

                                <asp:Label ID="lblTitle" runat="server" Text="*Title" AssociatedControlID="RadEditorAbstractTitle"></asp:Label><br />
                                If pasting the title from your abstract, click your right mouse button and select the &quot;<strong>Paste as Plain Text</strong>&quot; option, or click the clipboard icon below.<br />
                                <telerik:RadEditor ID="RadEditorAbstractTitle" runat="server" Height="40px" ToolbarMode="Default" ToolsFile="~/Content/ToolBars/BasicTools.xml" Width="100%" MaxTextLength="500" ViewStateMode="Enabled" ContentAreaCssFile="~/Content/radEditor.css"></telerik:RadEditor>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Label ID="lblAuthorList" runat="server" Text="*Formatted Author List." AssociatedControlID="TextBoxAuthorList"></asp:Label><br />
                                <ul>
                                    <li>Enter the <strong>initials and last name only</strong> of each author in the order shown on the abstract separated by commas. Do not include employer, address, or contact information. </li>
                                    <li>Capitalize the first letter in each element of the name and include the "and" before the last author listed. </li>
                                </ul>
                                For example, if the authors on your abstract (including the corresponding/presenting author) are Thomas N. Jones, Nathan L. Smith, and Elizabeth Baker type the author list as follows:<br />
                                <strong>T.N. Jones, N.L. Smith, and E. Baker</strong>


                                <asp:TextBox ID="TextBoxAuthorList" runat="server" CssClass="form-control"></asp:TextBox>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h4>Format and Placement Preference</h4>
                                Placement and final presentation format (platform or poster) cannot be guaranteed. Final decisions on placement will be based on best overall 
                            design of the <%=sConferenceType%> program. By
                            <asp:Label ID="lblFinalPlacement" runat="server" Text=""></asp:Label>, 
                            an email will be sent to the 
                            corresponding/presenting author of each abstract, stating the placement decision. If the abstract 
                            was accepted for presentation in the technical program, this email will state the platform or poster session to which it was assigned 
                            and provide information on preparing the presentation and submitting an updated abstract a 
                            few weeks before the <%=sConferenceType%>.<br />
                                <br />
                                <asp:Label ID="lblPreferredFormat" runat="server" Text="*Preferred Format" AssociatedControlID="RadioButtonListAbstractFormat"></asp:Label>
                                <asp:RadioButtonList ID="RadioButtonListAbstractFormat" runat="server" AppendDataBoundItems="False" DataSourceID="SqlDataSourceAbstractFormat" DataTextField="FormatType" DataValueField="FormatType" CellPadding="2" CellSpacing="2" CssClass="radio"></asp:RadioButtonList>
                                <asp:SqlDataSource ID="SqlDataSourceAbstractFormat" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [FormatType] FROM [AbstractFormat]"></asp:SqlDataSource>

                                <br />

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblSubReqBy" runat="server" Text="Submission Requested By." AssociatedControlID="ddlRequestedBy"></asp:Label>
                                If this abstract was requested by a prospective Session Chair, select that person's name in the drop-down box.<br />
                                <asp:DropDownList ID="ddlRequestedBy" runat="server" DataSourceID="SqlDataSourceRequested" DataTextField="DisplayName" DataValueField="SubmitName" AppendDataBoundItems="true" CssClass="form-control" Visible="true">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblAppTopics" runat="server" Text="Applicable Topics." AssociatedControlID="ddlApplicableTopics1"></asp:Label>
                                In order of preference, choose up to two topic areas from the  
                                <asp:HyperLink ID="lnkTechProgScope" runat="server" Target="_blank">Technical Program Scope</asp:HyperLink>
                                &nbsp;to indicate which topics you believe are the best match for the proposed presentation. Note: Not all topics will become stand-alone sessions and final placement is based on best overall design of the <%=sConferenceType%> program.
                                <br />
                                <asp:DropDownList id="ddlApplicableTopics1" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="TopicCode" AppendDataBoundItems="true" CssClass="form-control">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                <asp:DropDownList id="ddlApplicableTopics2" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="TopicCode" AppendDataBoundItems="true" CssClass="form-control">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblNewTopic" runat="server" Text="New Topic Area." AssociatedControlID="TextBoxAbstractNewTopicArea"></asp:Label>
                                If you don’t believe the content of your abstract fits any of the topic areas 
                                but does fit within the overall scope of the <%=sConferenceType%>, you may suggest a new topic area to be considered by the Program Committee. (Maximum 15 words)<br />
                                <asp:TextBox ID="TextBoxAbstractNewTopicArea" runat="server" MaxLength="200" CssClass="form-control"></asp:TextBox>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h4>Abstract</h4>
                                In the field below, paste the title and author block from your abstract.
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblTitleAuthorBlock" runat="server" Text="*Title and Author Block" AssociatedControlID="RadEditorAbstractTitleAuthorBlock"></asp:Label><br />
                                <telerik:RadEditor ID="RadEditorAbstractTitleAuthorBlock" runat="server" Width="100%" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" StripFormattingOnPaste="NoneSupressCleanMessage" StripFormattingOptions="NoneSupressCleanMessage" ContentAreaCssFile="~/Content/radEditor.css">
                                </telerik:RadEditor>
                                <br />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblAbstractBackground" runat="server" Text="*Background/Objectives" AssociatedControlID="RadEditorAbstractBackground"></asp:Label><br />
                                <telerik:RadEditor ID="RadEditorAbstractBackground" runat="server" Width="100%" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" DialogHandlerUrl="Telerik.Web.UI.DialogHandler.axd" StripFormattingOnPaste="NoneSupressCleanMessage" StripFormattingOptions="NoneSupressCleanMessage" ContentAreaCssFile="~/Content/radEditor.css">
                                    <Content><b>Background/Objectives.</b>&nbsp;</Content>
                                    <TrackChangesSettings CanAcceptTrackChanges="False" />
                                </telerik:RadEditor>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblAbstractApproach" runat="server" Text="*Approach/Activities" AssociatedControlID="RadEditorAbstractApproach"></asp:Label><br />
                                <telerik:RadEditor ID="RadEditorAbstractApproach" runat="server" Width="100%" ContentFilters="MakeUrlsAbsolute, DefaultFilters" DialogHandlerUrl="Telerik.Web.UI.DialogHandler.axd" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" StripFormattingOnPaste="NoneSupressCleanMessage" StripFormattingOptions="NoneSupressCleanMessage" ContentAreaCssFile="~/Content/radEditor.css">
                                    <TrackChangesSettings CanAcceptTrackChanges="False" />
                                </telerik:RadEditor>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblAbstractResults" runat="server" Text="*Results/Lessons Learned" AssociatedControlID="RadEditorAbstractResults"></asp:Label><br />
                                <telerik:RadEditor ID="RadEditorAbstractResults" runat="server" Width="100%" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" DialogHandlerUrl="Telerik.Web.UI.DialogHandler.axd" StripFormattingOnPaste="NoneSupressCleanMessage" StripFormattingOptions="NoneSupressCleanMessage" ContentAreaCssFile="~/Content/radEditor.css">
                                </telerik:RadEditor>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                Please close your abstract WORD document (.doc or .docx) before clicking the "Choose File" button. Uploading the file while the document is open will create a file name error.<br />
                                <asp:Label ID="lblUpload" runat="server" Text="*Upload your File (.doc, .docx)" AssociatedControlID="FileUploadAbstract"></asp:Label><br />
                                <asp:FileUpload ID="FileUploadAbstract" runat="server" Width="100%" />
                                <!--<br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidatorUpload" runat="server" ErrorMessage="Only .doc or .docx files are accepted." ControlToValidate="FileUploadAbstract" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.doc|.DOC|.docx|.DOCX)$" CssClass="alert alert-danger" Display="Dynamic"></asp:RegularExpressionValidator>-->
                            </div>
                        </div>


                    </div>

                    <br />
                    <asp:Button ID="ButtonSubmitAbstract" runat="server" Text="Submit Form and Upload Abstract" CssClass="btn btn-primary" UseSubmitBehavior="False" />
            </asp:Panel>

            <asp:Panel ID="PanelAbstractConfirmation" runat="server" Visible="False">
                <h3>Thank you. The abstract you submitted has been received and recorded as shown below.</h3>
                <br />
                <br />
                <div class="alert alert-danger" role="alert">
                    Warning! Do not refresh this page or hit the back button on your browser as you 
                    could cause an erroneous or duplicate submission.
                </div>
                You will receive an email confirmation soon from
                <asp:Label ID="lblMeetingPlannerEmail" runat="server" Text="swarner@scgcorp.com"></asp:Label>. 
                The person listed as the corresponding/presenting author will also receive a confirmation email. Only the corresponding/presenting author will be contacted from this point forward with information related to this abstract, including the final acceptance decision.<br />
                <br />
                If you have any questions, please contact Gina Melaragno (Battelle) at 
                <asp:HyperLink ID="lnkSubjectEmail2" runat="server"></asp:HyperLink>, or by phone at 614-424-7866.<br />
                <br />
                In
                <asp:Label ID="lblPlacementDate" runat="server" Text="[PlacementDate]"></asp:Label>, the 
                corresponding/presenting author will receive an email stating the placement decision.
                <asp:Label ID="LabelAbstractConfirmationResult" runat="server"></asp:Label>
                <br />
                Submitting another abstract? Select an option below:<br />
                <ul>
                    <li>
                        <asp:LinkButton ID="lnkNewAbstractKeepAuthors" runat="server">Submit a new abstract with a similar author list</asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="lnkNewAbstractNewAuthors" runat="server">Submit a new abstract with new authors</asp:LinkButton>
                    </li>
                </ul>
                <p>
                    &nbsp;
                </p>
            </asp:Panel>

            <br />
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="ButtonSubmitAbstract" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgressAbstract" runat="server" AssociatedUpdatePanelID="UpdatePanelAbstract">
        <ProgressTemplate>
            <div style="background-image: url('<%= Page.ResolveUrl("~/images/processingbg.png") %>'); background-repeat: repeat; position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 999; text-align: center;">
                <div style="position: absolute; top: 50%; left: 0px; width: 100%; height: 25px; text-align: center">
                    <h4>
                        <img src='<%= Page.ResolveUrl("~/images/indicator.gif") %>' alt="Processing your request..." />
                        Processing...</h4>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <%--<controls:SessionHandler id="handler1" TargetURLForSessionTimeout="" AutomaticRedirect="false" runat="server" OnTimeOut="SessionTimeout"/>--%>
</asp:Content>
