<%@ Page Title="Learning Lab Proposal Submission" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Exhibit.Master" CodeBehind="LearningLabProposal.aspx.vb" Inherits="Battelle.LearningLabProposal" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>
<%@ Register Src="~/Exhibitor/CompanyInfo.ascx" TagPrefix="uc1" TagName="CompanyInfo" %>
<%@ Register Src="~/Exhibitor/LearningLabTerms.ascx" TagPrefix="uc1" TagName="TermsConditions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hdnEmail" runat="server" />
    <asp:HiddenField ID="hdnEmail2" runat="server" />

    <script type="text/javascript">
        function SetFocus() {
            document.getElementById('<%=ListBoxAbstractInstructors.ClientID%>').focus();
            return false;
        }

    </script>
    <h1><%=Page.Title%></h1>
    <asp:Label ID="lblAlert" runat="server" Text="" Visible="false"></asp:Label>
    <asp:HiddenField ID="hdnVal" runat="server" />
    <asp:Panel ID="PanelInstructions" runat="server" Visible="false">
        Instructions go here.
    </asp:Panel>
    <asp:Panel ID="PanelClosed" runat="server" Visible="false">
        <asp:Label ID="lblClosed" runat="server" Text="Learning Lab Submission is currently closed."></asp:Label>
    </asp:Panel>
    <asp:Panel ID="PanelParticipationControl" runat="server" Visible="False">
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" />
    </asp:Panel>
    <asp:Panel ID="PanelExhibitorInfo" runat="server" Visible="False">
        <h3>Company Information</h3>
        <uc1:CompanyInfo runat="server" ID="CompanyInfo" />
    </asp:Panel>
    <asp:Panel ID="PanelTerms" runat="server" Visible="True">
        <%--<h3>Terms and Conditions</h3>--%>
        <asp:Label ID="lblTermsMessage" runat="server" Text="" Visible="False"></asp:Label>
        <asp:Label ID="lblLiability" runat="server" Text="" Visible="False"></asp:Label>
        <uc1:TermsConditions runat="server" ID="TermsConditions" />
        

        <div class="alert alert-info" role="alert">
            <asp:CheckBox ID="chkTerms" runat="server" Text="&nbsp;&nbsp;I have read and agree to the Terms and Conditions" TextAlign="Right" />
        </div>
        <br />
        <asp:Button ID="btnAgree" runat="server" Text="Next Step >>" CssClass="btn btn-primary" />
    </asp:Panel>
    <asp:UpdatePanel ID="UpdatePanelAbstract" runat="server">
        <ContentTemplate>
            <asp:Panel ID="PanelForm" runat="server" Visible="False">
                <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [CountryName], [CountryCode] FROM [LookupCountry] Order By [ListOrder]"></asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT     LookupStateProvince.StateProvinceAbbreviation, (LookupStateProvince.StateProvinceName + ' (' + LookupStateProvince.CountryCode + ')') as ListStateProvinceName
FROM         LookupStateProvince LEFT OUTER JOIN
                      LookupCountry ON LookupStateProvince.CountryCode = LookupCountry.CountryCode
ORDER BY LookupCountry.ListOrder, LookupStateProvince.StateProvinceName"></asp:SqlDataSource>
                <p><strong>Completing the Form</strong></p>
                <ul type="disc">
                    <li><strong><u>Do not use the &ldquo;Enter&rdquo; key</u></strong> to move from field-to-field, this may cause an incomplete and/or duplicate submission. 
      Use the tab key or your mouse to move from one field to the next.</li>
                    <li>Use standard capitalization—do not use ALL CAPITAL or all lower-case letters.</li>
                </ul>
                <p>
                    <strong>Submission Confirmation.</strong>&nbsp;You,  as the submitter, will receive the proposal confirmation email after you complete the submission. 
    If you do not receive a confirmation email, please contact  the Conference Office at 
    <strong>
        <asp:HyperLink ID="lnkConferenceEmail" runat="server">the conference email address</asp:HyperLink></strong>.
                </p>

                <h4>Point-of-Contact (POC) &amp;  Instructors</h4>
                <p><strong>As the person submitting this form, you are  automatically listed as the POC and Instructor for the demonstration</strong>.  
                    If you are not the POC and you are submitting the proposal on behalf of someone  else, you must enter that person as a Co-Instructor 
                    and then follow the  instructions under the Co-Instructors box to change the POC designation. </p>


                <asp:Label ID="LabelAbstractValidation" runat="server"></asp:Label>
                <div class="form-group">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Literal ID="LiteralAlertDivOpen" runat="server" Text='<div class="alert alert-info" role="alert">'></asp:Literal>

                                <h4>Point of Contact</h4>

                                <b>
                                    <asp:Label ID="lblCorPresInstructor" runat="server" Text=""></asp:Label></b>
                                <asp:HiddenField ID="hdnCorPres" runat="server" />
                                <asp:Label ID="lblCorPresInstructorWarning" runat="server" Text="You cannot remove the Point of Contact without selecting a replacement." Visible="False"></asp:Label>
                                <asp:Literal ID="LiteralAlertDivClose" runat="server" Text="</div>"></asp:Literal>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblInstructors" runat="server" Text="*Co-Instructors" AssociatedControlID="ListBoxAbstractInstructors"></asp:Label><br />
                                <strong>Add Co-Instructors.</strong> If there are additional Instructors listed on the abstract, click the blue "Add Co-Instructors" button below. 
                                Wait for the prompt to appear to search for your Co-Instructor’s email address in our database. Complete contact information—postal address, 
                                office phone number, and email address—is required for each Instructor. 
                                <br />
                                <br />
                                <strong>Change the Poin-of-Contact (POC).</strong> Enter the corresponding/presenting Instructor as a Co-Instructor. Click on their name in the box 
                                below and wait for the green “Set as Point-of-Contact” button to appear. Click the button to change them to the corresponding/presenting Instructor.
                                <br />
                                <br />
                                <strong>Remove Yourself (or another Instructor) as a Co-Instructor.</strong> If you are not one of the Instructors, or have entered someone by mistake, click on the name you want to remove and wait for the orange “Remove Selected Instructor” button to appear. Click the button to remove the selected name. 
                                <asp:ListBox ID="ListBoxAbstractInstructors" runat="server" AutoPostBack="True" CssClass="form-control" Height="120px"></asp:ListBox>
                                <asp:Button ID="ButtonInstructorsAdd" runat="server" Text="Add Co-Instructors" CssClass="btn btn-primary" UseSubmitBehavior="False" />&nbsp;
                                <asp:Button ID="ButtonCorPresInstructorSet" runat="server" Text="Set as Point-of-Contact" CssClass="btn btn-success" UseSubmitBehavior="False" Visible="False" />&nbsp;
                                <asp:Button ID="ButtonInstructorsRemove" runat="server" Text="Remove selected Instructor" Visible="False" CssClass="btn btn-warning" UseSubmitBehavior="False" /><br />
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
                                            <asp:Label ID="lblPersonEmail" runat="server" Text="Co-Instructor Email Address" AssociatedControlID="TextBoxPersonEmail"></asp:Label>
                                            First, check to see if the Co-Instructor exists in our system by entering his or her email address.
                                        </div>
                                        <div class="panel-body">
                                            <div class="input-group">
                                                <asp:TextBox ID="TextBoxPersonEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                                <span class="input-group-btn">
                                                    <asp:Button ID="LinkButtonPersonLookup2" runat="server" Text="Search for Co-Instructor" CssClass="btn btn-primary" UseSubmitBehavior="False" ValidationGroup="ValidateEmail" /></span>

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
                                            <asp:Button ID="ButtonNew" runat="server" Text="Enter Co-Instructor information" CausesValidation="False" CommandName="New" CssClass="btn btn-warning" />
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
                                            <h4>Enter Co-Instructor Information</h4>
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
                                            <asp:Button ID="ButtonInsert" CausesValidation="True" CommandName="Insert" runat="server" Text="Add Co-Instructor" CssClass="btn btn-primary" OnClientClick="SetFocus(1)" />&nbsp;
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
                                            If you believe your Co-Instructor’s information above should be updated, please send an email to 
                                            <asp:HyperLink ID="HyperLinkCoAuth" runat="server" NavigateUrl='<%#hdnEmail2.Value%>'><%=hdnEmail.Value%></asp:HyperLink>
                                            explaining what you believe should be corrected and provide the email and address for your Co-Instructor. Please copy and paste the information displayed into your email and include the title of your abstract.
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Button ID="ButtonSelect" runat="server" CausesValidation="False" CommandName="Select" OnClick="SelectButton_Click" Text="Add to Co-Instructor list" CssClass="btn btn-success" UseSubmitBehavior="False" OnClientClick="SetFocus(1)" />
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:SqlDataSource ID="SqlDataSourcePersonLookup" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Person] WHERE [PersonID] = @original_PersonID AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([Employer] = @original_Employer) OR ([Employer] IS NULL AND @original_Employer IS NULL)) AND (([AddressLine1] = @original_AddressLine1) OR ([AddressLine1] IS NULL AND @original_AddressLine1 IS NULL)) AND (([AddressLine2] = @original_AddressLine2) OR ([AddressLine2] IS NULL AND @original_AddressLine2 IS NULL)) AND (([AddressLine3] = @original_AddressLine3) OR ([AddressLine3] IS NULL AND @original_AddressLine3 IS NULL)) AND (([City] = @original_City) OR ([City] IS NULL AND @original_City IS NULL)) AND (([StateProvince] = @original_StateProvince) OR ([StateProvince] IS NULL AND @original_StateProvince IS NULL)) AND (([ZipPostal] = @original_ZipPostal) OR ([ZipPostal] IS NULL AND @original_ZipPostal IS NULL)) AND (([Country] = @original_Country) OR ([Country] IS NULL AND @original_Country IS NULL)) AND (([PhoneNum] = @original_PhoneNum) OR ([PhoneNum] IS NULL AND @original_PhoneNum IS NULL)) AND (([CellNum] = @original_CellNum) OR ([CellNum] IS NULL AND @original_CellNum IS NULL)) AND (([Email] = @original_Email) OR ([Email] IS NULL AND @original_Email IS NULL))  AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL))" InsertCommand="INSERT INTO [Person] ([FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [Notes]) VALUES (@FirstName, @LastName, @Employer, @AddressLine1, @AddressLine2, @AddressLine3, @City, @StateProvince, @ZipPostal, @Country, @PhoneNum, @CellNum, @Email, @Notes)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [Notes], [PersonID] FROM [Person] WHERE ([Email] = @Email OR [AltPOC] =@Email)" UpdateCommand="UPDATE [Person] SET [FirstName] = @FirstName, [LastName] = @LastName, [Employer] = @Employer, [AddressLine1] = @AddressLine1, [AddressLine2] = @AddressLine2, [AddressLine3] = @AddressLine3, [City] = @City, [StateProvince] = @StateProvince, [ZipPostal] = @ZipPostal, [Country] = @Country, [PhoneNum] = @PhoneNum, [CellNum] = @CellNum, [Email] = @Email, [Notes] = @Notes WHERE [PersonID] = @original_PersonID AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([Employer] = @original_Employer) OR ([Employer] IS NULL AND @original_Employer IS NULL)) AND (([AddressLine1] = @original_AddressLine1) OR ([AddressLine1] IS NULL AND @original_AddressLine1 IS NULL)) AND (([AddressLine2] = @original_AddressLine2) OR ([AddressLine2] IS NULL AND @original_AddressLine2 IS NULL)) AND (([AddressLine3] = @original_AddressLine3) OR ([AddressLine3] IS NULL AND @original_AddressLine3 IS NULL)) AND (([City] = @original_City) OR ([City] IS NULL AND @original_City IS NULL)) AND (([StateProvince] = @original_StateProvince) OR ([StateProvince] IS NULL AND @original_StateProvince IS NULL)) AND (([ZipPostal] = @original_ZipPostal) OR ([ZipPostal] IS NULL AND @original_ZipPostal IS NULL)) AND (([Country] = @original_Country) OR ([Country] IS NULL AND @original_Country IS NULL)) AND (([PhoneNum] = @original_PhoneNum) OR ([PhoneNum] IS NULL AND @original_PhoneNum IS NULL)) AND (([CellNum] = @original_CellNum) OR ([CellNum] IS NULL AND @original_CellNum IS NULL)) AND (([Email] = @original_Email) OR ([Email] IS NULL AND @original_Email IS NULL))  AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL))">
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
                                <h4>Learning Lab Information</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">

                                <asp:Label ID="lblTitle" runat="server" Text="*Title" AssociatedControlID="txtTitle"></asp:Label><br />
                                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Label ID="lblExhibitorYN" runat="server" Text="*My company is also an Exhibitor." AssociatedControlID="rblExhibitorYN"></asp:Label><br />

                                <asp:RadioButtonList ID="rblExhibitorYN" runat="server" CssClass="radio">
                                    <asp:ListItem Value="True" Text="YES, my company is an Exhibitor."></asp:ListItem>
                                    <asp:ListItem Value="False" Text="NO, my company is not an Exhibitor."></asp:ListItem>
                                </asp:RadioButtonList>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Label ID="lblShippingFreightYN" runat="server" Text="*I will be shipping freight with my equipment for the Learning Lab demonstration." AssociatedControlID="rblShippingFreightYN"></asp:Label><br />
                                <br />
                                <i>This may result in labor charges from the show decorator.</i>
                                <asp:RadioButtonList ID="rblShippingFreightYN" runat="server" CssClass="radio">
                                    <asp:ListItem Value="True" Text="YES, I will be shipping freight."></asp:ListItem>
                                    <asp:ListItem Value="False" Text="NO, I will not be shipping freight."></asp:ListItem>
                                </asp:RadioButtonList>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Label ID="lblFreightTruckYN" runat="server" Text="*Will you require a freight truck to move your equipment to the Learning Lab space on-site at your assigned demonstration time?" AssociatedControlID="rblFreightTruckYN"></asp:Label><br />
                                <br />
                                <i>This may result in labor charges from the show decorator.</i>
                                <asp:RadioButtonList ID="rblFreightTruckYN" runat="server" CssClass="radio">
                                    <asp:ListItem Value="True" Text="YES, my equipment will need to be moved with a freight truck."></asp:ListItem>
                                    <asp:ListItem Value="False" Text="NO, I will not require a freight truck."></asp:ListItem>
                                </asp:RadioButtonList>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Label ID="lblFreightStorageYN" runat="server" Text="*Will you require freight storage for your equipment on-site or will you be able to store your equipment in an exhibit booth?" AssociatedControlID="rblFreightStorageYN"></asp:Label><br />
                                <br />
                                <i>This may result in labor charges from the show decorator.</i>
                                <asp:RadioButtonList ID="rblFreightStorageYN" runat="server" CssClass="radio">
                                    <asp:ListItem Value="True" Text="YES, I will require freight storage."></asp:ListItem>
                                    <asp:ListItem Value="False" Text="NO, I will not require freight storage."></asp:ListItem>
                                </asp:RadioButtonList>
                                <br />
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblObjective" runat="server" Text="Learning Lab Objective." AssociatedControlID="txtObjective"></asp:Label>
                                Provide only <b>a sentence or two</b> that will give an overview of the information you believe the participants will gain
from the demonstration. Describe the audience that would benefit most from the material you will be presenting (e.g., engineers, site managers, regulators).
                                <br />
                                <asp:TextBox ID="txtObjective" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblDescription" runat="server" Text="Learning Lab Description." AssociatedControlID="txtDescription"></asp:Label>
                                Provide a concise <b>(maximum 300 words)</b> description below of the product, technology, software, tool, etc., that will be demonstrated.
                                <br />
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="10"></asp:TextBox>
                                <br />
                            </div>
                        </div>




                    </div>

                    <br />
                    <asp:Button ID="ButtonSubmitAbstract" runat="server" Text="Submit Form" CssClass="btn btn-primary" UseSubmitBehavior="False" />
            </asp:Panel>

            <asp:Panel ID="PanelAbstractConfirmation" runat="server" Visible="False">
                <h3>Thank you. The Learning Lab Proposal you submitted has been received and recorded as shown below.</h3>
                <br />
                <br />
                <div class="alert alert-danger" role="alert">
                    Warning! Do not refresh this page or hit the back button on your browser as you 
                    could cause an erroneous or duplicate submission.
                </div>
                You will receive an email confirmation soon from
                <asp:Label ID="lblMeetingPlannerEmail" runat="server" Text="swarner@scgcorp.com"></asp:Label>. 
                The person listed as the Point-of-Contact (POC) Instructor will also receive a confirmation email. Only the POC will be contacted from this point forward with information related to this proposal, including the final acceptance decision.<br /><br />
                
                <b>Note:&nbsp;No financial  assistance is available to support registration or other costs of attending the <asp:Literal ID="ltlConferenceType" runat="server"></asp:Literal>. All instructors and co-instructors are expected to register  and pay the applicable technical-program registration fees. 
                    This policy is  necessary because registration fees are the major source of funding for the <asp:Literal ID="ltlConferenceType2" runat="server"></asp:Literal> and a significant percentage of registrants will make presentations.</b></p>
                <h4>Learning Lab Inquiries</h4>
                Questions about Learning Lab Proposal submittal should be addressed to <asp:HyperLink ID="lnkSubjectEmail2" runat="server"></asp:HyperLink>, with the subject line "Learning Lab Proposal Inquiry," or contact Gina Melaragno (Battelle) at 614-424-7866.
                <br />
                <br />
                <%--In
                <asp:Label ID="lblPlacementDate" runat="server" Text="[PlacementDate]"></asp:Label>, the 
                corresponding/presenting Instructor will receive an email stating the placement decision.--%>
               
                <h4>Learning Lab Proposal Summary</h4>               
                 <asp:Label ID="LabelAbstractConfirmationResult" runat="server"></asp:Label>
                <br />
                Submitting another Learning Lab Proposal? Select an option below:<br />
                <ul>
                    <li>
                        <asp:LinkButton ID="lnkNewAbstractKeepInstructors" runat="server">Submit a new proposal with a similar Instructor list</asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="lnkNewAbstractNewInstructors" runat="server">Submit a new proposal with new Instructors</asp:LinkButton>
                    </li>
                </ul>
                <p>
                    &nbsp;
                </p>
            </asp:Panel>
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
</asp:Content>
