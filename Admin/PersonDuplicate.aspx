<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="PersonDuplicate.aspx.vb" Inherits="Battelle.PersonDuplicate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGetDuplicates" SelectCommandType="StoredProcedure" FilterExpression="FirstName LIKE '{0}' OR LastName LIKE '{0}'">
    <FilterParameters>
       <asp:ControlParameter ControlID="SearchBox" PropertyName="Text" />
    </FilterParameters>
    </asp:SqlDataSource>

    <style type="text/css">
        .rowStyle {
            padding:5px;
        }
        .compareStyle{
            padding:5px;
            text-align:center;
        }
        .highlight
        {
        color:red;
        font-weight:bold;
        }

        .btnCompare 
        {
        display: inline-block;
        margin-bottom: 0;
        font-weight: normal;
        text-align: center;
        vertical-align: middle;
        cursor: pointer;
        background-image: none;
        border: 1px solid transparent;
        white-space: nowrap;
        padding: 2px 6px;
        font-size: 14px;
        line-height: 1.42857143;
        border-radius: 4px;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        }
    </style>

    <!--This is the start of the panel-->

    <asp:SqlDataSource ID="SqlDataSourcePerson" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"  SelectCommand="PersonGet" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE [Person] SET [ParticipationID] = @ParticipationID, [FirstName] = @FirstName, [LastName] = @LastName, [Employer] = @Employer, [AddressLine1] = @AddressLine1, [AddressLine2] = @AddressLine2, [AddressLine3] = @AddressLine3, [City] = @City, [StateProvince] = @StateProvince, [ZipPostal] = @ZipPostal, [Country] = @Country, [PhoneNum] = @PhoneNum, [CellNum] = @CellNum, [Email] = @Email, [AltPOC] = @AltPOC, [EnteredBy] = @EnteredBy, [EnteredSource] = @EnteredSource, [EnteredDate] = @EnteredDate, [ModifiedBy] = @ModifiedBy,[ModifiedSource] = @ModifiedSource,[ModifiedDate] = @ModifiedDate,[Notes] = @Notes,[InvalidAddress] = @InvalidAddress,[ExhibitInfo] = @ExhibitInfo,[OmitFromMassEmails] = @OmitFromMassEmails,[SpecialNeeds] = @SpecialNeeds, [SedCorrPres] = @SedCorrPres,[SedCoAuth] = @SedCoAuth,[SedChrProspect] = @SedChrProspect, [SedOtherRole] = @SedOtherRole,[BioChrProspect] = @BioChrProspect,[BioOtherRole] = @BioOtherRole WHERE [PersonID] = @PersonID" DeleteCommandType="StoredProcedure" DeleteCommand="PersonComparisonDeleteByID"> 
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
                <asp:Parameter Name="EnteredBy" Type="String" />
                <asp:Parameter Name="EnteredSource" Type="String" />
                <asp:Parameter Name="EnteredDate" Type="DateTime" />
                <asp:Parameter Name="ModifiedBy" Type="String" />
                <asp:Parameter Name="ModifiedSource" Type="String" />
                <asp:Parameter Name="ModifiedDate" Type="DateTime" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="InvalidAddress" Type="Boolean" />
                <asp:Parameter Name="ExhibitInfo" Type="String" />
                <asp:Parameter Name="OmitFromMassEmails" Type="String" />
                <asp:Parameter Name="SpecialNeeds" Type="String" />
                <asp:Parameter Name="SedCorrPres" Type="Double" />
                <asp:Parameter Name="SedCoAuth" Type="Double" />
                <asp:Parameter Name="SedChrProspect" Type="String" />
                <asp:Parameter Name="SedOtherRole" Type="String" />
                <asp:Parameter Name="BioChrProspect" Type="String" />
                <asp:Parameter Name="BioOtherRole" Type="String" />
                <asp:Parameter Name="PersonID" Type="Int32" />
       </UpdateParameters>
      <DeleteParameters>
          <asp:Parameter Name="PersonID_Delete" Type="Int32" />
          <asp:Parameter Name="PersonID_Update" Type="Int32" />
          <asp:Parameter Name="AttendanceCheck" Type="Boolean" />
          <asp:Parameter Name="Attendance_ConferenceID" Type="Int32" />
          <asp:Parameter Name="BoothCheck" Type="Boolean" />
          <asp:Parameter Name="BoothID" Type ="Int32" />
          <asp:Parameter Name="ConferenceRoleCheck" Type="Boolean" />
          <asp:Parameter Name="ConferenceRole_ConferenceID" Type="Int32" />
      </DeleteParameters>    
      </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePerson1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGet" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE [Person] SET [ParticipationID] = @ParticipationID, [FirstName] = @FirstName, [LastName] = @LastName, [Employer] = @Employer, [AddressLine1] = @AddressLine1, [AddressLine2] = @AddressLine2, [AddressLine3] = @AddressLine3, [City] = @City, [StateProvince] = @StateProvince, [ZipPostal] = @ZipPostal, [Country] = @Country, [PhoneNum] = @PhoneNum, [CellNum] = @CellNum, [Email] = @Email, [AltPOC] = @AltPOC, [EnteredBy] = @EnteredBy, [EnteredSource] = @EnteredSource, [EnteredDate] = @EnteredDate, [ModifiedBy] = @ModifiedBy,[ModifiedSource] = @ModifiedSource,[ModifiedDate] = @ModifiedDate,[Notes] = @Notes,[InvalidAddress] = @InvalidAddress,[ExhibitInfo] = @ExhibitInfo,[OmitFromMassEmails] = @OmitFromMassEmails,[SpecialNeeds] = @SpecialNeeds, [SedCorrPres] = @SedCorrPres,[SedCoAuth] = @SedCoAuth,[SedChrProspect] = @SedChrProspect, [SedOtherRole] = @SedOtherRole,[BioChrProspect] = @BioChrProspect,[BioOtherRole] = @BioOtherRole WHERE [PersonID] = @PersonID"  DeleteCommandType="StoredProcedure" DeleteCommand="PersonComparisonDeleteByID">
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
                <asp:Parameter Name="EnteredBy" Type="String" />
                <asp:Parameter Name="EnteredSource" Type="String" />
                <asp:Parameter Name="EnteredDate" Type="DateTime" />
                <asp:Parameter Name="ModifiedBy" Type="String" />
                <asp:Parameter Name="ModifiedSource" Type="String" />
                <asp:Parameter Name="ModifiedDate" Type="DateTime" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="InvalidAddress" Type="Boolean" />
                <asp:Parameter Name="ExhibitInfo" Type="String" />
                <asp:Parameter Name="OmitFromMassEmails" Type="String" />
                <asp:Parameter Name="SpecialNeeds" Type="String" />
                <asp:Parameter Name="SedCorrPres" Type="Double" />
                <asp:Parameter Name="SedCoAuth" Type="Double" />
                <asp:Parameter Name="SedChrProspect" Type="String" />
                <asp:Parameter Name="SedOtherRole" Type="String" />
                <asp:Parameter Name="BioChrProspect" Type="String" />
                <asp:Parameter Name="BioOtherRole" Type="String" />
                <asp:Parameter Name="PersonID" Type="Int32" />
       </UpdateParameters>
        <DeleteParameters>
          <asp:Parameter Name="PersonID_Delete" Type="Int32" />
          <asp:Parameter Name="PersonID_Update" Type="Int32" />
          <asp:Parameter Name="AttendanceCheck" Type="Boolean" />
          <asp:Parameter Name="Attendance_ConferenceID" Type="Int32" />
          <asp:Parameter Name="BoothCheck" Type="Boolean" />
          <asp:Parameter Name="BoothID" Type ="Int32" />
          <asp:Parameter Name="ConferenceRoleCheck" Type="Boolean" />
          <asp:Parameter Name="ConferenceRole_ConferenceID" Type="Int32" />
      </DeleteParameters>   
      </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [CountryName], [CountryCode] FROM [LookupCountry] Order By [ListOrder]"></asp:SqlDataSource>

      <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT     LookupStateProvince.StateProvinceAbbreviation, (LookupStateProvince.StateProvinceName + ' (' + LookupStateProvince.CountryCode + ')') as ListStateProvinceName
FROM         LookupStateProvince LEFT OUTER JOIN
                      LookupCountry ON LookupStateProvince.CountryCode = LookupCountry.CountryCode
ORDER BY LookupCountry.ListOrder, LookupStateProvince.StateProvinceName"></asp:SqlDataSource>


    <div style="float:left; width:50%">
    <asp:Panel ID="PanelPerson" runat="server" Visible="False">


<asp:FormView ID="FormViewPersonLookup" runat="server" DataKeyNames="PersonID" DataSourceID="SqlDataSourcePerson" RenderOuterTable="False" Visible="False">
    <EditItemTemplate>
    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <b>PersonID:</b>
                                <asp:Label ID="lblPersonID" runat="server" Text='<%# Bind("PersonID") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Participant Code:</b>
                                <asp:TextBox ID="ParticipationIDTextBox" runat="server" Text='<%# Bind("ParticipationID") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>First/Middle Names:</b>
                                <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Last Name:</b>
                                <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Employer:</b>
                                <asp:TextBox ID="EmployerTextBox" runat="server" Text='<%# Bind("Employer") %>' CssClass="form-control" MaxLength="100" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Mailing/Postal Address:</b><br />
                                <asp:TextBox ID="AddressLine1TextBox" runat="server" Text='<%# Bind("AddressLine1") %>' CssClass="form-control" MaxLength="50"/>
                                <br />
                                <asp:TextBox ID="AddressLine2TextBox" runat="server" Text='<%# Bind("AddressLine2") %>' CssClass="form-control" MaxLength="50"/>
                                <br />
                                <asp:TextBox ID="AddressLine3TextBox" runat="server" Text='<%# Bind("AddressLine3") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div> 
                        <div class="row">
                            <div class="col-md-12">
                                <b>City:</b>
                                <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' CssClass="form-control" MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>State/Province:</b>
                                <asp:DropDownList ID="StateProvinceDropDownList" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="SqlDataSourceLookupStateProvince" DataTextField="ListStateProvinceName" DataValueField="StateProvinceAbbreviation" OnPreRender="HtmlDecode_PreRender" SelectedValue='<%# Bind("StateProvince")%>' OnDataBound="StateProvinceDropDownList_DataBound" OnDataBinding="StateProvinceDropDownList_DataBinding">
                                        <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Zip/Postal Code:</b>
                                <asp:TextBox ID="ZipPostalTextBox" runat="server" Text='<%# Bind("ZipPostal") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Country:</b>
                                <asp:DropDownList ID="CountryDropDownList" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceLookupCountry" DataTextField="CountryName" DataValueField="CountryName" CssClass="form-control" OnPreRender="HtmlDecode_PreRender" SelectedValue='<%# Bind("Country") %>' OnSelectedIndexChanged="CountryDropDownList_SelectedIndexChanged" OnDataBound="CountryDropDownList_DataBound" AutoPostBack="False">
                                        <asp:ListItem Value="">Please select your country</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Phone Number:</b>
                                <asp:TextBox ID="PhoneNumTextBox" runat="server" Text='<%# Bind("PhoneNum") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Cell Phone Number:</b>
                                <asp:TextBox ID="CellNumTextBox" runat="server" Text='<%# Bind("CellNum") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Email Address:</b>
                                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Alternate Email Address:</b>
                                <asp:TextBox ID="AltPOCTextBox" runat="server" Text='<%# Bind("AltPOC") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered By:</b>
                                <asp:TextBox ID="EnteredByTextBox" runat="server" Text='<%# Bind("EnteredBy") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered Source:</b>
                                <asp:TextBox ID="EnteredSourceTextBox" runat="server" Text='<%# Bind("EnteredSource") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered Date:</b>
                                <asp:TextBox ID="EnteredDateTextBox" runat="server" Text='<%# Bind("EnteredDate") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified By:</b>
                                <asp:TextBox ID="ModifiedByTextBox" runat="server" Text='<%# Bind("ModifiedBy") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified Source:</b>
                                <asp:TextBox ID="ModifiedSourceTextBox" runat="server" Text='<%# Bind("ModifiedSource") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified Date:</b>
                                <asp:TextBox ID="ModifiedDateTextBox" runat="server" Text='<%# Bind("ModifiedDate") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Notes:</b>
                                <asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Invalid Address?:</b>
                                <asp:CheckBox ID="InvalidAddressCheckBox" runat="server" Checked='<%# Bind("InvalidAddress")%>'  />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Exhibit Info:</b>
                                <asp:TextBox ID="ExhibitInfoTextBox" runat="server" Text='<%# Bind("ExhibitInfo")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Omit From Mass Emails:</b>
                                <asp:TextBox ID="OmitEmailTextBox" runat="server" Text='<%# Bind("OmitFromMassEmails")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Special Needs:</b>
                                <asp:TextBox ID="SpecialNeedsTextBox" runat="server" Text='<%# Bind("SpecialNeeds")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedCorrPres:</b>
                                <asp:TextBox ID="SedCorrPresTextBox" runat="server" Text='<%# Bind("SedCorrPres")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedCoAuth:</b>
                                <asp:TextBox ID="SedCoAuthTextBox" runat="server" Text='<%# Bind("SedCoAuth")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedChrProspect:</b>
                                <asp:TextBox ID="SedChrProspectTextBox" runat="server" Text='<%# Bind("SedChrProspect")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedOtherRole:</b>
                                <asp:TextBox ID="SedOtherRoleTextBox" runat="server" Text='<%# Bind("SedOtherRole")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <b>BioChrProspect:</b>
                                <asp:TextBox ID="BioChrProspectTextBox" runat="server" Text='<%# Bind("BioChrProspect")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <b>BioOtherRole:</b>
                                <asp:TextBox ID="BioOtherRoleTextBox" runat="server" Text='<%# Bind("BioOtherRole")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-md-12">
                                &nbsp;
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
                                <asp:Button ID="ButtonUpdateCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-primary" />
                                <asp:Button ID="ButtonDelete" runat="server" CausesValidation="true" Text="Delete User" CssClass="btn btn-warning" OnClientClick = "return confirm('Do you want to delete?')" OnClick="DeletePersonButton" />
                            </div>
                        </div>
    </div>
    </EditItemTemplate>
    <ItemTemplate>
    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <b>Person ID:</b>
                                <asp:Label ID="PersonIDLabel" runat="server" Text='<%# Bind("PersonID") %>' />
                            </div>
                        </div>
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
                                <b>Entered By:</b>
                                <asp:Label ID="EnteredByLabel" runat="server" Text='<%# Bind("EnteredBy") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered Source:</b>
                                <asp:Label ID="EnteredSourceLabel" runat="server" Text='<%# Bind("EnteredSource") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered Date:</b>
                                <asp:Label ID="EnteredDateLabel" runat="server" Text='<%# Bind("EnteredDate") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified By:</b>
                                <asp:Label ID="ModifiedByLabel" runat="server" Text='<%# Bind("ModifiedBy") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified Source:</b>
                                <asp:Label ID="ModifiedSourceLabel" runat="server" Text='<%# Bind("ModifiedSource") %>' />
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <b>Modified Date:</b>
                                <asp:Label ID="ModifiedDateLabel" runat="server" Text='<%# Bind("ModifiedDate") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Notes:</b>
                                <asp:Label ID="NotesLabel" runat="server" Text='<%# Bind("Notes") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Invalid Address:</b>
                                <asp:Label ID="InvalidAddressLabel" runat="server" Text='<%# Bind("InvalidAddress") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Exhibit Info:</b>
                                <asp:Label ID="ExhibitInfoLabel" runat="server" Text='<%# Bind("ExhibitInfo") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Omit From Mass Emails:</b>
                                <asp:Label ID="OmitFromMassEmailsLabel" runat="server" Text='<%# Bind("OmitFromMassEmails") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Special Needs:</b>
                                <asp:Label ID="SpecialNeedsLabel" runat="server" Text='<%# Bind("SpecialNeeds") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedCorrPres:</b>
                                <asp:Label ID="SedCorrPresLabel" runat="server" Text='<%# Bind("SedCorrPres") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedCoAuth:</b>
                                <asp:Label ID="SedCoAuthLabel" runat="server" Text='<%# Bind("SedCoAuth") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedChrProspect:</b>
                                <asp:Label ID="SedChrProspectLabel" runat="server" Text='<%# Bind("SedChrProspect") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedOtherRole:</b>
                                <asp:Label ID="SedOtherRoleLabel" runat="server" Text='<%# Bind("SedOtherRole") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>BioChrProspect:</b>
                                <asp:Label ID="BioChrProspectLabel" runat="server" Text='<%# Bind("BioChrProspect") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>BioOtherRole:</b>
                                <asp:Label ID="BioOtherRoleLabel" runat="server" Text='<%# Bind("BioOtherRole") %>' />
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

    </asp:Panel>
        </div>

    <div style="float:right; width:50%;">
        <asp:Panel ID="PanelPerson1" runat="server" Visible="False">

<asp:FormView ID="FormViewPersonLookup1" runat="server" DataKeyNames="PersonID" DataSourceID="SqlDataSourcePerson1" RenderOuterTable="False" Visible="False">
    <EditItemTemplate>
    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <b>PersonID:</b>
                                <asp:Label ID="lblPersonID1" runat="server" Text='<%# Bind("PersonID") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Participant Code:</b>
                                <asp:TextBox ID="ParticipationIDTextBox1" runat="server" Text='<%# Bind("ParticipationID") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>First/Middle Names:</b>
                                <asp:TextBox ID="FirstNameTextBox1" runat="server" Text='<%# Bind("FirstName") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Last Name:</b>
                                <asp:TextBox ID="LastNameTextBox1" runat="server" Text='<%# Bind("LastName") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Employer:</b>
                                <asp:TextBox ID="EmployerTextBox1" runat="server" Text='<%# Bind("Employer") %>' CssClass="form-control" MaxLength="100" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Mailing/Postal Address:</b><br />
                                <asp:TextBox ID="AddressLine1TextBox1" runat="server" Text='<%# Bind("AddressLine1") %>' CssClass="form-control" MaxLength="50"/>
                                <br />
                                <asp:TextBox ID="AddressLine2TextBox1" runat="server" Text='<%# Bind("AddressLine2") %>' CssClass="form-control" MaxLength="50"/>
                                <br />
                                <asp:TextBox ID="AddressLine3TextBox1" runat="server" Text='<%# Bind("AddressLine3") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>City:</b>
                                <asp:TextBox ID="CityTextBox1" runat="server" Text='<%# Bind("City") %>' CssClass="form-control" MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>State/Province:</b>
                                <asp:DropDownList ID="StateProvinceDropDownList1" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="SqlDataSourceLookupStateProvince" DataTextField="ListStateProvinceName" DataValueField="StateProvinceAbbreviation" OnPreRender="HtmlDecode_PreRender1" SelectedValue='<%# Bind("StateProvince")%>' OnDataBound="StateProvinceDropDownList1_DataBound" OnDataBinding="StateProvinceDropDownList1_DataBinding">
                                        <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Zip/Postal Code:</b>
                                <asp:TextBox ID="ZipPostalTextBox1" runat="server" Text='<%# Bind("ZipPostal") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Country:</b>
                                <asp:DropDownList ID="CountryDropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceLookupCountry" DataTextField="CountryName" DataValueField="CountryName" CssClass="form-control" OnPreRender="HtmlDecode_PreRender1" SelectedValue='<%# Bind("Country") %>' OnSelectedIndexChanged="CountryDropDownList1_SelectedIndexChanged" OnDataBound="CountryDropDownList1_DataBound" AutoPostBack="False">
                                        <asp:ListItem Value="">Please select your country</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Phone Number:</b>
                                <asp:TextBox ID="PhoneNumTextBox1" runat="server" Text='<%# Bind("PhoneNum") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Cell Phone Number:</b>
                                <asp:TextBox ID="CellNumTextBox1" runat="server" Text='<%# Bind("CellNum") %>' CssClass="form-control" MaxLength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Email Address:</b>
                                <asp:TextBox ID="EmailTextBox1" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Alternate Email Address:</b>
                                <asp:TextBox ID="AltPOCTextBox1" runat="server" Text='<%# Bind("AltPOC") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered By:</b>
                                <asp:TextBox ID="EnteredByTextBox1" runat="server" Text='<%# Bind("EnteredBy") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered Source:</b>
                                <asp:TextBox ID="EnteredSourceTextBox1" runat="server" Text='<%# Bind("EnteredSource") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered Date:</b>
                                <asp:TextBox ID="EnteredDateTextBox1" runat="server" Text='<%# Bind("EnteredDate") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified By:</b>
                                <asp:TextBox ID="ModifiedByTextBox1" runat="server" Text='<%# Bind("ModifiedBy") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified Source:</b>
                                <asp:TextBox ID="ModifiedSourceTextBox1" runat="server" Text='<%# Bind("ModifiedSource") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified Date:</b>
                                <asp:TextBox ID="ModifiedDateTextBox1" runat="server" Text='<%# Bind("ModifiedDate") %>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Notes:</b>
                                <asp:TextBox ID="NotesTextBox1" runat="server" Text='<%# Bind("Notes")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Invalid Address?:</b>
                                <asp:CheckBox ID="InvalidAddressCheckBox1" runat="server" Checked='<%# Bind("InvalidAddress")%>'  />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Exhibit Info:</b>
                                <asp:TextBox ID="ExhibitInfoTextBox1" runat="server" Text='<%# Bind("ExhibitInfo")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Omit From Mass Emails:</b>
                                <asp:TextBox ID="OmitEmailTextBox1" runat="server" Text='<%# Bind("OmitFromMassEmails")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Special Needs:</b>
                                <asp:TextBox ID="SpecialNeedsTextBox1" runat="server" Text='<%# Bind("SpecialNeeds")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedCorrPres:</b>
                                <asp:TextBox ID="SedCorrPresTextBox1" runat="server" Text='<%# Bind("SedCorrPres")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedCoAuth:</b>
                                <asp:TextBox ID="SedCoAuthTextBox1" runat="server" Text='<%# Bind("SedCoAuth")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedChrProspect:</b>
                                <asp:TextBox ID="SedChrProspectTextBox1" runat="server" Text='<%# Bind("SedChrProspect")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedOtherRole:</b>
                                <asp:TextBox ID="SedOtherRoleTextBox1" runat="server" Text='<%# Bind("SedOtherRole")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <b>BioChrProspect:</b>
                                <asp:TextBox ID="BioChrProspectTextBox1" runat="server" Text='<%# Bind("BioChrProspect")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <b>BioOtherRole:</b>
                                <asp:TextBox ID="BioOtherRoleTextBox1" runat="server" Text='<%# Bind("BioOtherRole")%>' CssClass="form-control"  MaxLength="100"/>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-md-12">
                                &nbsp;
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">

                                <br />
                                <asp:Label ID="LabelDataValidationSummary1" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="ButtonUpdate1" runat="server" CausesValidation="True" CommandName="Update" Text="Update my information" CssClass="btn btn-success" />
                                <asp:Button ID="ButtonUpdateCancel1" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-primary" />
                                <asp:Button ID="ButtonDelete1" runat="server" CausesValidation="true" Text="Delete User" CssClass="btn btn-warning" OnClientClick = "return confirm('Do you want to delete?')" OnClick="DeletePersonButton1" />                                   
                            </div>
                        </div>
    </div>
    </EditItemTemplate>
    <ItemTemplate>
    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <b>Person ID:</b>
                                <asp:Label ID="PersonIDLabel1" runat="server" Text='<%# Bind("PersonID") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Participant Code:</b>
                                <asp:Label ID="ParticipationIDLabel1" runat="server" Text='<%# Bind("ParticipationID") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>First/Middle Names:</b>
                                <asp:Label ID="FirstNameLabel1" runat="server" Text='<%# Bind("FirstName") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Last Name:</b>
                                <asp:Label ID="LastNameLabel1" runat="server" Text='<%# Bind("LastName") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Employer:</b>
                                <asp:Label ID="EmployerLabel1" runat="server" Text='<%# Bind("Employer") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Mailing/Postal Address:</b><br />
                                <asp:Label ID="AddressLine1Label1" runat="server" Text='<%# Bind("AddressLine1") %>' />
                                <br />
                                <asp:Label ID="AddressLine2Label1" runat="server" Text='<%# Bind("AddressLine2") %>' />
                                <br />
                                <asp:Label ID="AddressLine3Label1" runat="server" Text='<%# Bind("AddressLine3") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>City:</b>
                                <asp:Label ID="CityLabel1" runat="server" Text='<%# Bind("City") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>State/Province:</b>
                                <asp:Label ID="StateProvinceLabel1" runat="server" Text='<%# Bind("StateProvince") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Zip/Postal Code:</b>
                                <asp:Label ID="ZipPostalLabel1" runat="server" Text='<%# Bind("ZipPostal") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Country:</b>
                                <asp:Label ID="CountryLabel1" runat="server" Text='<%# Bind("Country") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Phone Number:</b>
                                <asp:Label ID="PhoneNumLabel1" runat="server" Text='<%# Bind("PhoneNum") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Cell Phone Number:</b>
                                <asp:Label ID="CellNumLabel1" runat="server" Text='<%# Bind("CellNum") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Email Address:</b>
                                <asp:Label ID="EmailLabel1" runat="server" Text='<%# Bind("Email") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Alternate Email Address:</b>
                                <asp:Label ID="AltPOCLabel1" runat="server" Text='<%# Bind("AltPOC") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered By:</b>
                                <asp:Label ID="EnteredByLabel1" runat="server" Text='<%# Bind("EnteredBy") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered Source:</b>
                                <asp:Label ID="EnteredSourceLabel1" runat="server" Text='<%# Bind("EnteredSource") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Entered Date:</b>
                                <asp:Label ID="EnteredDateLabel1" runat="server" Text='<%# Bind("EnteredDate") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified By:</b>
                                <asp:Label ID="ModifiedByLabel1" runat="server" Text='<%# Bind("ModifiedBy") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Modified Source:</b>
                                <asp:Label ID="ModifiedSourceLabel1" runat="server" Text='<%# Bind("ModifiedSource") %>' />
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <b>Modified Date:</b>
                                <asp:Label ID="ModifiedDateLabel1" runat="server" Text='<%# Bind("ModifiedDate") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Notes:</b>
                                <asp:Label ID="NotesLabel1" runat="server" Text='<%# Bind("Notes") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Invalid Address:</b>
                                <asp:Label ID="InvalidAddressLabel1" runat="server" Text='<%# Bind("InvalidAddress") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Exhibit Info:</b>
                                <asp:Label ID="ExhibitInfoLabel1" runat="server" Text='<%# Bind("ExhibitInfo") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Omit From Mass Emails:</b>
                                <asp:Label ID="OmitFromMassEmailsLabel1" runat="server" Text='<%# Bind("OmitFromMassEmails") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Special Needs:</b>
                                <asp:Label ID="SpecialNeedsLabel1" runat="server" Text='<%# Bind("SpecialNeeds") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedCorrPres:</b>
                                <asp:Label ID="SedCorrPresLabel1" runat="server" Text='<%# Bind("SedCorrPres") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedCoAuth:</b>
                                <asp:Label ID="SedCoAuthLabel1" runat="server" Text='<%# Bind("SedCoAuth") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedChrProspect:</b>
                                <asp:Label ID="SedChrProspectLabel1" runat="server" Text='<%# Bind("SedChrProspect") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>SedOtherRole:</b>
                                <asp:Label ID="SedOtherRoleLabel1" runat="server" Text='<%# Bind("SedOtherRole") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>BioChrProspect:</b>
                                <asp:Label ID="BioChrProspectLabel1" runat="server" Text='<%# Bind("BioChrProspect") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>BioOtherRole:</b>
                                <asp:Label ID="BioOtherRoleLabel1" runat="server" Text='<%# Bind("BioOtherRole") %>' />
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-md-12">
                                &nbsp;
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:LinkButton ID="EditButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                            </div>
                        </div>
    </div>
        </ItemTemplate>
        </asp:FormView>

    </asp:Panel>

    </div>

    <div style="clear:both;padding-bottom:10px;">&nbsp;</div>

    <div style="width:100%; text-align:center;">
        <p><asp:Button ID="btnGridView" runat="server" Text="<< Back" CssClass="btn btn-default" UseSubmitBehavior="False" Visible="False" /></p>
    </div>

    
    <asp:Panel ID="PanelGrid" runat="server" Visible="True">
    <div style="text-align:center; padding-top:20px; padding-bottom:20px;"><asp:Label ID="lblSearchBox" runat="server" Text="Search" AssociatedControlID="SearchBox" Visible="false"></asp:Label> <asp:TextBox runat="server" id="SearchBox" Text="*" Visible="true" /> <asp:Button runat="server" id="FilterButton" Text="Filter Results" Visible="true" /></div> 
        
    <div style="width:100%; text-align:center;">
    <asp:Label ID="lblResults" runat="server" Text="" CssClass="highlight" ></asp:Label>
    </div>
    
        
    <div class="row" style="padding-bottom:10px;">
        <div class="col-md-12">
           <asp:LinkButton ID="LinkButtonExecute1" runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-transfer"></span> Compare</asp:LinkButton>
           <asp:LinkButton ID="LinkButtonClear1" runat="server" CssClass="btn btn-primary"><span class="glyphicon glyphicon-remove"></span> Clear</asp:LinkButton>
        </div>
    </div>                  
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="PersonID">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField HeaderText="Compare" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="compareStyle">
            <ItemTemplate>
            <a name="PersonID_<%# Eval("PersonID")%>" style="position:relative; top:-240px; display: block;"></a>
            <asp:LinkButton ID="lnkCompare" runat="server" CssClass="btnCompare btn-success" OnClick="LinkButtonExecute_Click"><span class="glyphicon glyphicon-transfer"></span></asp:LinkButton>
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Select" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" >
                <ItemTemplate>
                <asp:checkbox id="cbSelect" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ParticipationID" HeaderText="Participation ID"  SortExpression="ParticipationID" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
            <asp:BoundField DataField="PersonID" HeaderText="PersonID"  SortExpression="PersonID" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
            <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
            <asp:BoundField DataField="PhoneNum" HeaderText="Phone #" SortExpression="PhoneNum" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
            <asp:BoundField DataField="CellNum" HeaderText="Cell #" SortExpression="CellNum" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
            <%--<asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="rowStyle">
            <ItemTemplate>
            <asp:LinkButton ID="lnkRemove" runat="server" CommandArgument = '<%# Eval("PersonID")%>' OnClientClick = "return confirm('Do you want to delete?')" Text = "Delete" OnClick = "DeletePerson"></asp:LinkButton>
            </ItemTemplate>
            </asp:TemplateField>--%>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="true" ForeColor="White" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="true" ForeColor="#333333" />
    </asp:GridView>

    <div class="row" style="padding-top:10px;">
        <div class="col-md-12">
           <asp:LinkButton ID="LinkButtonExecute" runat="server" CssClass="btn btn-success" OnClick="LinkButtonExecute_Click"><span class="glyphicon glyphicon-transfer"></span> Compare</asp:LinkButton>
           <asp:LinkButton ID="LinkButtonClear" runat="server" CssClass="btn btn-primary"><span class="glyphicon glyphicon-remove"></span> Clear</asp:LinkButton>
           <asp:HiddenField ID="hdnBackID" runat="server" />
        </div>
    </div>
    </asp:Panel>

</asp:Content>
