<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Exhibit.Master" CodeBehind="ExhibitStaff.aspx.vb" Inherits="Battelle.ExhibitorStaff" %>

<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=ExhibitorOrSponsor%> Staff Selection</h1>

    <asp:SqlDataSource ID="SqlDataSourceConfirmation" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothConfirmationGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="ConferenceID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ExhibitorBoothInfoGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="ConferenceID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceLedger" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="ConferenceLedgerInsert" InsertCommandType="StoredProcedure" SelectCommand="ConferenceLedgerFeeTypeCount" SelectCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="FeeTypeID" DefaultValue="5" Type="Int32" />
            <asp:Parameter Name="Amount" Type="Decimal" />
            <asp:Parameter Name="Notes" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
            <asp:Parameter DefaultValue="5" Name="FeeTypeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceFees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceFeeGetByType" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="FeeTypeID" DefaultValue="5" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceStaffMatrix" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AttendanceExhibitorCheck" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="ExhibitorID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    
    <asp:HiddenField ID="hdnItemCount" runat="server" />
    
    <asp:HiddenField ID="hdnStaffCount" runat="server" />

    <asp:HiddenField ID="hdnLateFeeAmount" runat="server" />

    <asp:HiddenField ID="hdnLateFeeDate" runat="server" />
    
    <asp:Panel ID="PanelProgress" runat="server" Visible="False">
        <div class="progress">
            <asp:Label ID="lblProgress" runat="server" Text=""></asp:Label>
        </div>
    </asp:Panel>
    <asp:Label ID="lblAlert" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Panel ID="PanelPreInstructions" runat="server" Visible="true">

    </asp:Panel>

    <asp:Panel ID="PanelParticipationControl" runat="server" Visible="False">
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" OnFinishedLogin="ParticipationIDLogin_FinishedLogin" />
    </asp:Panel>
    <asp:Panel ID="PanelExhibitor" runat="server" Visible="False">
        <br />
        <div class="panel panel-info">
          <div class="panel-heading">
            <h3 class="panel-title"><span class="label label-warning">!</span> Exhibitor Staff Registration</h3>
          </div>
          <div class="panel-body">
             We're sorry, it appears that you are not the booth Point of Contact for your company. For billing purposes, only the registered Point of Contact may Add/Edit booth staff.
          </div>
        </div>
        <%--No need to look up Exhibitor, only POC can add staff --%>
        <%--<asp:Label ID="lblCompanyName" runat="server" Text=""></asp:Label>
        <asp:SqlDataSource ID="SqlDataSourceOrgID" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ExhibitorCheckbyOrganizationID" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="OrganizationID" Type="String" />
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource><asp:HiddenField ID="hdnFee" runat="server" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-4">

                    <div class="form-group">
                        
                    <asp:Label ID="lblOrgID" runat="server" Text="Enter your Organization ID:" AssociatedControlID="txtOrgID"></asp:Label><br />
                        <asp:Label ID="lblMessage" runat="server" Text="Only the Point of Contact may Add/Edit staff.<br />" CssClass="bg-danger" Visible="False"></asp:Label>
                    <div class="input-group">
                        <asp:TextBox ID="txtOrgID" runat="server" CssClass="form-control"></asp:TextBox>
                        <span class="input-group-btn">
                            <asp:Button ID="btnOrgID" runat="server" Text="Look Up Organization" CssClass="btn btn-default" /></span>
                    </div></div>
                </div>
            </div>

        </div>--%>
    </asp:Panel>
    <asp:Panel ID="PanelStaff" runat="server" Visible="False">
        <asp:Label ID="lblCompanyName" runat="server" Text=""></asp:Label>
        <asp:HiddenField ID="hdnFee" runat="server" />
        <asp:SqlDataSource ID="SqlDataSourceStaff" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothStaffGet" SelectCommandType="StoredProcedure" InsertCommand="BoothStaffInsert" InsertCommandType="StoredProcedure" DeleteCommand="BoothStaffRemove" DeleteCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:SessionParameter Name="BoothID" SessionField="BoothID" Type="Int32" />
                <asp:Parameter Name="PersonID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="BoothID" SessionField="BoothID" Type="Int32" />
                <asp:Parameter Name="PersonID" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
                <asp:SessionParameter Name="ExhibitorID" SessionField="ExhibitorID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:GridView ID="gvStaff" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceStaff" EmptyDataText="Your organization has not assigned any booth staff." CssClass="table" DataKeyNames="PersonID">
            <Columns>
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                <asp:BoundField DataField="PhoneNum" HeaderText="Phone Number" SortExpression="PhoneNum" />
                <asp:BoundField DataField="CellNum" HeaderText="Cell Number" SortExpression="CellNum" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:TemplateField HeaderText="Remove">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButtonDelete" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to remove this staff member from your booth? Fees associated with the staff member will not automatically be removed from your balance. If you are replacing this person with another person, your balance will not be affected.');"><span class="glyphicon glyphicon-remove"></span></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
            </Columns>
        </asp:GridView>

        
        <div class="panel panel-default">
            <div class="panel-heading">
                    <asp:Panel ID="PanelInstructions" runat="server" Visible="false">
        You have <b><asp:Label ID="lblComplimentary" runat="server" Text="2"></asp:Label></b> complimentary booth staff registrations remaining. Click the <span class="label label-success">Add Staff Member</span> button to enter their contact information. 
        You also have the opportunity to register additional 
        booth staff at the rate of US $<asp:Literal ID="ltlFee" runat="server"></asp:Literal> per person. <!--SCGTODO--> If you do not 
        know staff information at this time, you may click <span class="label label-primary">Next Step >></span> to continue. <br /><br />
    </asp:Panel>
<asp:Button ID="btnAddStaff" runat="server" Text="Add a Staff Member" CssClass="btn btn-success" UseSubmitBehavior="False" />
        &nbsp;<span class="label label-info"><asp:Label ID="lblFeeLabel" runat="server" Text="Fee: US $"></asp:Label><asp:Label ID="lblFee" runat="server" Text=""></asp:Label></span>
                <asp:Label ID="lblLedgerHasMoreStaff" runat="server" Text="<i>(No fee because additional staff have already been added to your ledger.)</i>" Visible="false"></asp:Label>
        <asp:Panel ID="PanelPersonAdd" runat="server" Visible="False">

            <br />
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-primary">

                            <div class="panel-heading">
                                <asp:Label ID="lblPersonEmail" runat="server" Text="Staff Email Address" AssociatedControlID="TextBoxPersonEmail"></asp:Label>
                                <i>First, check to see if the staff member exists in our system by entering their <b>email address</b>.</i>
                            </div>
                            <div class="panel-body">
                                <div class="input-group">
                                    <asp:TextBox ID="TextBoxPersonEmail" runat="server" CssClass="form-control" ValidationGroup="StaffLookup" placeholder="Enter staff email address"></asp:TextBox>
                                    
                                    <span class="input-group-btn">
                                        <asp:Button ID="LinkButtonPersonLookup2" runat="server" Text="Search by Staff Member Email" CssClass="btn btn-primary" UseSubmitBehavior="False" /></span>
                                </div>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="TextBoxPersonEmail" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="StaffLookup" CssClass="text-danger">Please enter a valid email address.</asp:RegularExpressionValidator>
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

        </asp:Panel>
                </div>
            <div class="panel-body">
                <asp:Label ID="lblStaffLimitReached" runat="server" Text="The limit for the total number of booth staff has been reached." Visible="false"></asp:Label>
            <asp:Panel ID="PanelPersonLookup" runat="server" Visible="false">
             <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [CountryName], [CountryCode] FROM [LookupCountry] Order By [ListOrder]"></asp:SqlDataSource>

                    <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT StateProvinceName, StateProvinceAbbreviation as StateProvince FROM LookupStateProvince Order by StateProvince">
                    </asp:SqlDataSource>
            <asp:FormView ID="FormViewPersonLookup" runat="server" DataKeyNames="PersonID" DataSourceID="SqlDataSourcePersonLookup" RenderOuterTable="False" Visible="False">
                <EmptyDataTemplate>
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Button ID="ButtonNew" runat="server" Text="Enter staff information" CausesValidation="False" CommandName="New" CssClass="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                </EmptyDataTemplate>
                <InsertItemTemplate>

                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-12">
                                <h4>Enter Staff Member Information</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblFirstName" runat="server" Text="*First/Middle Names" AssociatedControlID="FirstNameTextBox"></asp:Label>
                                    <i>(as preferred for citation in program/attendee list)</i><br />
                                    <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblLastName" runat="server" Text="*Last Name (Surname)" AssociatedControlID="LastNameTextBox"></asp:Label><br />
                                    <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblEmployer" runat="server" Text="*Employer" AssociatedControlID="EmployerTextBox"></asp:Label><br />
                                    <asp:TextBox ID="EmployerTextBox" runat="server" Text='<%# Bind("Employer") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="100" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblEmail" runat="server" Text="*Email Address" AssociatedControlID="EmailTextBox"></asp:Label>
                                    <%--<asp:Label ID="lblEmailField" runat="server" Text=''></asp:Label>--%>
                                    <asp:TextBox ID="EmailTextBoxDisabled" runat="server" Text='' CssClass="form-control" Enabled="False" MaxLength="100" />
                                    <asp:HiddenField ID="EmailTextBox" Value='<%# Bind("Email") %>' runat="server" />
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Label ID="lblAddress1" runat="server" Text="*Mailing/Postal Address" AssociatedControlID="AddressLine1TextBox"></asp:Label>
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
                                    <asp:Label ID="lblCity" runat="server" Text="City" AssociatedControlID="CityTextBox"></asp:Label><br />
                                    <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="100" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblStateProv" runat="server" Text="State/Province" AssociatedControlID="StateProvinceDropDownList"></asp:Label><br />
                                    <asp:DropDownList ID="StateProvinceDropDownList" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="SqlDataSourceLookupStateProvince" DataTextField="StateProvinceName" DataValueField="StateProvince" OnPreRender="HtmlDecode_PreRender" SelectedValue='<%# Bind("StateProvince")%>'>
                                        <asp:ListItem Selected="True" Value="NA">N/A</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblZipPostal" runat="server" Text="Zip/Postal Code" AssociatedControlID="ZipPostalTextBox"></asp:Label><br />
                                    <asp:TextBox ID="ZipPostalTextBox" runat="server" Text='<%# Bind("ZipPostal") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />

                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblCountry" runat="server" Text="*Country" AssociatedControlID="CountryDropDownList"></asp:Label><br />
                                    <asp:DropDownList ID="CountryDropDownList" runat="server" AppendDataBoundItems="False" DataSourceID="SqlDataSourceLookupCountry" DataTextField="CountryName" DataValueField="CountryName" CssClass="form-control" OnPreRender="HtmlDecode_PreRender" SelectedValue='<%# Bind("Country") %>'>
                                        <asp:ListItem Selected="True" Value=" ">Please select your country</asp:ListItem>
                                    </asp:DropDownList>

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <asp:Label ID="lblPhone" runat="server" Text="* Office Phone Number" AssociatedControlID="PhoneNumTextBox"></asp:Label><br />
                                    <asp:TextBox ID="PhoneNumTextBox" runat="server" Text='<%# Bind("PhoneNum") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="form-group">
                                    <asp:Label ID="lblCellPhone" runat="server" Text="Cell Phone Number" AssociatedControlID="CellNumTextBox"></asp:Label>
                                    <i>(Conference office use only; will not be disseminated.)</i><br />
                                    <asp:TextBox ID="CellNumTextBox" runat="server" Text='<%# Bind("CellNum") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="LabelDataValidationSummary" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="ButtonInsert" CausesValidation="True" CommandName="Insert" runat="server" Text="Enter Staff Member Contact Information" CssClass="btn btn-primary" />&nbsp;
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
                                <asp:Button ID="ButtonSelect" runat="server" CausesValidation="False" CommandName="Select" OnClick="SelectButton_Click" Text="Add to Staff List" CssClass="btn btn-warning" UseSubmitBehavior="False" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="SqlDataSourcePersonLookup" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Person] WHERE [PersonID] = @original_PersonID AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([Employer] = @original_Employer) OR ([Employer] IS NULL AND @original_Employer IS NULL)) AND (([AddressLine1] = @original_AddressLine1) OR ([AddressLine1] IS NULL AND @original_AddressLine1 IS NULL)) AND (([AddressLine2] = @original_AddressLine2) OR ([AddressLine2] IS NULL AND @original_AddressLine2 IS NULL)) AND (([AddressLine3] = @original_AddressLine3) OR ([AddressLine3] IS NULL AND @original_AddressLine3 IS NULL)) AND (([City] = @original_City) OR ([City] IS NULL AND @original_City IS NULL)) AND (([StateProvince] = @original_StateProvince) OR ([StateProvince] IS NULL AND @original_StateProvince IS NULL)) AND (([ZipPostal] = @original_ZipPostal) OR ([ZipPostal] IS NULL AND @original_ZipPostal IS NULL)) AND (([Country] = @original_Country) OR ([Country] IS NULL AND @original_Country IS NULL)) AND (([PhoneNum] = @original_PhoneNum) OR ([PhoneNum] IS NULL AND @original_PhoneNum IS NULL)) AND (([CellNum] = @original_CellNum) OR ([CellNum] IS NULL AND @original_CellNum IS NULL)) AND (([Email] = @original_Email) OR ([Email] IS NULL AND @original_Email IS NULL))  AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL))" InsertCommand="INSERT INTO [Person] ([FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [Notes]) VALUES (@FirstName, @LastName, @Employer, @AddressLine1, @AddressLine2, @AddressLine3, @City, @StateProvince, @ZipPostal, @Country, @PhoneNum, @CellNum, @Email, @Notes)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [Notes], [PersonID] FROM [Person] WHERE ([Email] = @Email) and ([PersonArchive] <> 1)" UpdateCommand="UPDATE [Person] SET [FirstName] = @FirstName, [LastName] = @LastName, [Employer] = @Employer, [AddressLine1] = @AddressLine1, [AddressLine2] = @AddressLine2, [AddressLine3] = @AddressLine3, [City] = @City, [StateProvince] = @StateProvince, [ZipPostal] = @ZipPostal, [Country] = @Country, [PhoneNum] = @PhoneNum, [CellNum] = @CellNum, [Email] = @Email, [Notes] = @Notes WHERE [PersonID] = @original_PersonID AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([Employer] = @original_Employer) OR ([Employer] IS NULL AND @original_Employer IS NULL)) AND (([AddressLine1] = @original_AddressLine1) OR ([AddressLine1] IS NULL AND @original_AddressLine1 IS NULL)) AND (([AddressLine2] = @original_AddressLine2) OR ([AddressLine2] IS NULL AND @original_AddressLine2 IS NULL)) AND (([AddressLine3] = @original_AddressLine3) OR ([AddressLine3] IS NULL AND @original_AddressLine3 IS NULL)) AND (([City] = @original_City) OR ([City] IS NULL AND @original_City IS NULL)) AND (([StateProvince] = @original_StateProvince) OR ([StateProvince] IS NULL AND @original_StateProvince IS NULL)) AND (([ZipPostal] = @original_ZipPostal) OR ([ZipPostal] IS NULL AND @original_ZipPostal IS NULL)) AND (([Country] = @original_Country) OR ([Country] IS NULL AND @original_Country IS NULL)) AND (([PhoneNum] = @original_PhoneNum) OR ([PhoneNum] IS NULL AND @original_PhoneNum IS NULL)) AND (([CellNum] = @original_CellNum) OR ([CellNum] IS NULL AND @original_CellNum IS NULL)) AND (([Email] = @original_Email) OR ([Email] IS NULL AND @original_Email IS NULL))  AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL))">
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
            </div>
</div>
    </asp:Panel>
    <asp:HiddenField ID="hdnNewStart" runat="server" />
    <asp:HiddenField ID="hdnStaffSlots" runat="server" />

    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" Visible="False" />
    <asp:Button ID="btnNext" runat="server" Text="Next Step >>>"  CssClass="btn btn-primary"/>
</asp:Content>
