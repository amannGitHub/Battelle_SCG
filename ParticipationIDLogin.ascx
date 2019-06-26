<%@ Control Language="vb" AutoEventWireup="true" CodeBehind="ParticipationIDLogin.ascx.vb" Inherits="Battelle.ParticipationIDLogin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
        <div style="background-image: url('<%= Page.ResolveUrl("~/images/processingbg.png") %>'); background-repeat: repeat; position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 999; text-align: center;">
            <div style="position: absolute; top: 50%; left: 0px; width: 100%; height: 25px; text-align: center">
                <h4>
                    <img src='<%= Page.ResolveUrl("~/images/indicator.gif") %>' alt="Processing your request..."/>
                    Processing...</h4>
            </div>
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>



<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:SqlDataSource ID="SqlDataSourcePersonIDFromParticipationID" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGetByParticipationID" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBoxParticipationID" Name="ParticipationID" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourcePersonIDFromEmail" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGetByEmail" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBoxEmail" Name="Email" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourcePerson" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="INSERT INTO [Person] ([ParticipationID], [FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [AltPOC]) VALUES (@ParticipationID, @FirstName, @LastName, @Employer, @AddressLine1, @AddressLine2, @AddressLine3, @City, @StateProvince, @ZipPostal, @Country, @PhoneNum, @CellNum, @Email, @AltPOC)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [PersonID], [ParticipationID], [FirstName], [LastName], [Employer], [AddressLine1], [AddressLine2], [AddressLine3], [City], [StateProvince], [ZipPostal], [Country], [PhoneNum], [CellNum], [Email], [AltPOC] FROM [Person] WHERE ([PersonID] = @PersonID)" UpdateCommand="UPDATE [Person] SET [ParticipationID] = @ParticipationID, [FirstName] = @FirstName, [LastName] = @LastName, [Employer] = @Employer, [AddressLine1] = @AddressLine1, [AddressLine2] = @AddressLine2, [AddressLine3] = @AddressLine3, [City] = @City, [StateProvince] = @StateProvince, [ZipPostal] = @ZipPostal, [Country] = @Country, [PhoneNum] = @PhoneNum, [CellNum] = @CellNum, [Email] = @Email, [AltPOC] = @AltPOC WHERE [PersonID] = @original_PersonID" DeleteCommand="DELETE FROM [Person] WHERE [PersonID] = @original_PersonID">
            <DeleteParameters>
                <asp:Parameter Name="original_PersonID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ParticipationID" Type="String" />
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
                <asp:Parameter Name="AltPOC" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="PersonID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ParticipationID" Type="String" />
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
                <asp:Parameter Name="AltPOC" Type="String" />
                <asp:Parameter Name="original_PersonID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <h3><asp:Label ID="lblParticipantCodeAction" runat="server" Text="Participant Code Retrieval"></asp:Label></h3>
        <asp:Panel ID="PanelParticipationOptions" runat="server">
            If you have attended, submitted an abstract, been listed as a co-author on an abstract, or managed an exhibit at a recent 
            or upcoming Battelle conference, your contact information may already be in our system. If you know your Participant Code, 
            please click &quot;I know my Participant Code&quot; to enter it. Otherwise, click &quot;I need my Participant Code&quot; and 
            then carefully type in your email address to retrieve your Participant Code if one already exists or to generate your code. 
        <br />
            <br />
            <asp:Button ID="ButtonParticipationID" runat="server" Text="I know my Participant Code" CssClass="btn btn-primary" UseSubmitBehavior="False" />
            <asp:Button ID="ButtonEmail" runat="server" Text="I need my Participant Code" CssClass="btn btn-primary" UseSubmitBehavior="False" />
            <br />
            <br />
        </asp:Panel>
        <asp:Panel ID="PanelParticipationID" runat="server" Visible="False">
            <div class="form-group">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label ID="lblEnterParticID" runat="server" Text="Please enter your Participant Code:" AssociatedControlID="TextBoxParticipationID"></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-5 col-md-3">
                            <div class="input-group">
                                <asp:TextBox ID="TextBoxParticipationID" runat="server" CssClass="form-control"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:Button ID="ButtonCheckParticipationID" runat="server" Text="Go" CssClass="btn btn-default" ValidationGroup="ParticipationIDGroup" /></span>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorParticipationID" runat="server" ErrorMessage="Please enter a valid ID" ControlToValidate="TextBoxParticipationID" SetFocusOnError="True" ValidationGroup="ParticipationIDGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label ID="LabelCheckParticipationIDResult" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

        </asp:Panel>
        <asp:Panel ID="PanelEmail" runat="server" Visible="False">
            <div class="form-group">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label ID="lblEnterEmail" runat="server" Text="Please enter your email address; use the email you use most commonly for professional activities." AssociatedControlID="TextBoxEmail"></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="input-group">
                                <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="form-control" ValidationGroup="EmailValidate"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:Button ID="ButtonCheckEmail" runat="server" Text="Go" CssClass="btn btn-default" ValidationGroup="EmailValidate" /></span>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="Please enter a valid email." ControlToValidate="TextBoxEmail" ValidationGroup="EmailValidate"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label ID="LabelCheckEmailResult" runat="server" Text=""></asp:Label>
                            <asp:Button ID="ButtonPersonEmptyInsert" runat="server" Text="New User" CssClass="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="PanelPerson" runat="server" Visible="False">
            <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [CountryName], [CountryCode] FROM [LookupCountry] Order By [ListOrder]"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT     LookupStateProvince.StateProvinceAbbreviation, (LookupStateProvince.StateProvinceName + ' (' + LookupStateProvince.CountryCode + ')') as ListStateProvinceName
FROM         LookupStateProvince LEFT OUTER JOIN
                      LookupCountry ON LookupStateProvince.CountryCode = LookupCountry.CountryCode
ORDER BY LookupCountry.ListOrder, LookupStateProvince.StateProvinceName"></asp:SqlDataSource>
            <asp:FormView ID="FormViewPerson" runat="server" DataKeyNames="PersonID" DataSourceID="SqlDataSourcePerson" RenderOuterTable="False">
                <EditItemTemplate>

                    <h4>Update your contact information</h4>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">

                                <b>Participant Code:</b>
                                <asp:Label ID="ParticipationIDLabel" runat="server" Text='<%# Bind("ParticipationID")%>' /><br /><br />
                                
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h6>Please do not include professional or military titles (e.g., Dr., Professor, Ph.D., PE, PG) or other suffixes (e.g., Jr., Sr., II) in the name fields.</h6>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblFirstName" runat="server" Text="First/Middle Names" AssociatedControlID="FirstNameTextBox"></asp:Label> 
                                        <small>(as preferred for citation in program/attendee list)</small></h5>
                                    <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' CssClass="form-control" MaxLength="50"/>
                                </div>
                            </div>
                            <div class="col-md-6">
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
                                    <h5><asp:Label ID="lblAltPOC" runat="server" Text="Secondary Email Address" AssociatedControlID="AltPOCTextBox"></asp:Label></h5>
                                    <asp:TextBox ID="AltPOCTextBox" runat="server" Text='<%# Bind("AltPOC") %>' CssClass="form-control"  MaxLength="100"/>
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
                                        <asp:ListItem Value="">Please select your country</asp:ListItem>
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
                                <asp:Button ID="ButtonUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Update my information" CssClass="btn btn-success" />
                                <asp:Button ID="ButtonUpdateCanel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                            </div>
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                   After you have completed this page, you will receive an email with a Participant Code that you can use for this and future Battelle conferences.<br />
                    <br />

                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <h6>Please do not include professional or military titles (e.g., Dr., Professor, Ph.D., PE, PG) or other suffixes (e.g., Jr., Sr., II) in the name fields.</h6> 
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblFirstName" runat="server" Text="First/Middle Names" AssociatedControlID="FirstNameTextBox"></asp:Label> 
                                    <small>(as preferred for citation in program/attendee list)</small></h5>
                                    <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' CssClass="form-control" MaxLength="50" />
                                    
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <h5><span class="text-danger">*</span><asp:Label ID="lblLastName" runat="server" Text="Last Name (Surname)" AssociatedControlID="LastNameTextBox"></asp:Label></h5>
                                    <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' CssClass="form-control" MaxLength="50" />
                                   
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
                                    <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control" OnInit="EmailTextBox_Init" ReadOnly="True" />
                                    <h5><asp:Label ID="lblAltPOC" runat="server" Text="Secondary Email Address" AssociatedControlID="AltPOCTextBox"></asp:Label></h5>
                                    <asp:TextBox ID="AltPOCTextBox" runat="server" Text='<%# Bind("AltPOC") %>' CssClass="form-control"  MaxLength="100"/>
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
                                    <asp:TextBox ID="AddressLine3TextBox" runat="server" Text='<%# Bind("AddressLine3") %>' CssClass="form-control" MaxLength="50" />
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
                                        <asp:ListItem Selected="True" Value=""></asp:ListItem>
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
                                <br />
                                <asp:Button ID="ButtonInsert" runat="server" CausesValidation="True" CommandName="Insert" Text="Submit Contact Information" CssClass="btn btn-default" />
                            </div>
                        </div>
                    </div>
                </InsertItemTemplate>
                <ItemTemplate>
                    Click &#39;Edit&#39; if your information displayed is incorrect or out of date. 
                    Any change you make will affect your program- and registration-related information for the 
                    <asp:Label ID="lblConference" runat="server" Text="current conference"></asp:Label>
                    and other Battelle Conferences. In particular, be consistent in using the same email address each time.
                    <br />
                    <br />
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <b>Participant Code:</b>
                                <asp:Label ID="ParticipationIDLabel" runat="server" Text='<%# Bind("ParticipationID") %>' />
                            </div>
                        </div>
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
                                <b>Employer:</b>
                                <asp:Label ID="EmployerLabel" runat="server" Text='<%# Bind("Employer") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Email Address:</b>
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Alternate Email Address:</b>
                                <asp:Label ID="AltPOCLabel" runat="server" Text='<%# Bind("AltPOC") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Mailing/Postal Address:</b><br />
                                <asp:Label ID="AddressLine1Label" runat="server" Text='<%# Bind("AddressLine1") %>' />
                                <br />
                                <asp:Label ID="AddressLine2Label" runat="server" Text='<%# Bind("AddressLine2") %>' />
                                <br />
                                <asp:Label ID="AddressLine3Label" runat="server" Text='<%# Bind("AddressLine3") %>' />
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
                                <b>Phone Number:</b>
                                <asp:Label ID="PhoneNumLabel" runat="server" Text='<%# Bind("PhoneNum") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Cell Phone Number:</b>
                                <asp:Label ID="CellNumLabel" runat="server" Text='<%# Bind("CellNum") %>' />
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-md-12">
                                &nbsp;
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                            </div>
                        </div>
                    </div>



                </ItemTemplate>
            </asp:FormView>
            <asp:Label ID="LabelIsPersonDataValid" runat="server" Visible="False"></asp:Label>
            <br /><br />
        </asp:Panel>
        <asp:Button ID="ButtonFinishedLogin" runat="server" Text="Next Step >>" Visible="False" CssClass="btn btn-primary" />
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="ButtonFinishedLogin" />
        <asp:PostBackTrigger ControlID="ButtonCheckParticipationID" />
    </Triggers>
</asp:UpdatePanel>



