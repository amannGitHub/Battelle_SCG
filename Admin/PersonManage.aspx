<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="PersonManage.aspx.vb" Inherits="Battelle.PersonManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGetAll" SelectCommandType="StoredProcedure" FilterExpression="FirstName LIKE '{0}' OR LastName LIKE '{0}'">
    <FilterParameters>
       <asp:ControlParameter ControlID="SearchBox" PropertyName="Text" />
    </FilterParameters>
    </asp:SqlDataSource>

    <style type="text/css">
        .rowStyle {
            padding:5px;
        }
        .highlight
        {
        color:red;
        font-weight:bold;
        }
        .pageSpace td{
         padding-left: 4px;
	     padding-right: 4px;
	     padding-top: 1px;
	     padding-bottom: 2px;
        }
    </style>


    <!--This is the start of the panel-->

    <asp:SqlDataSource ID="SqlDataSourcePerson" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"  SelectCommand="PersonGet" SelectCommandType="StoredProcedure" InsertCommand="PersonInsert" InsertCommandType="StoredProcedure" UpdateCommand="PersonAdminUpdateByID" UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure" DeleteCommand="PersonDeleteByID"> 
        <SelectParameters>
          <asp:Parameter Name="PersonID" Type="Int32" />
       </SelectParameters>
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
                <asp:Parameter Name="AltPOC" Type="String" />
                <asp:Parameter Name="Omit" Type="String" />
                <asp:Parameter Name="EnteredBy" Type="String" />
                <asp:Parameter Name="EnteredSource" Type="String" />
                <asp:Parameter Name="EnteredDate" Type="DateTime" />
                <asp:Parameter Name="ModifiedBy" Type="String" />
                <asp:Parameter Name="ModifiedSource" Type="String" />
                <asp:Parameter Name="ModifiedDate" Type="DateTime" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="InvalidAddress" Type="Boolean" DefaultValue="False" />
                <asp:Parameter Name="ExhibitInfo" Type="String" />
                <asp:Parameter Name="SpecialNeeds" Type="String" />
                <asp:Parameter Name="SedCorrPres" Type="Double" />
                <asp:Parameter Name="SedCoAuth" Type="Double" />
                <asp:Parameter Name="SedChrProspect" Type="String" />
                <asp:Parameter Name="SedOtherRole" Type="String" />
                <asp:Parameter Name="BioChrProspect" Type="String" />
                <asp:Parameter Name="BioOtherRole" Type="String" />
       </InsertParameters>
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
                <asp:Parameter Name="Omit" Type="String" />
                <asp:Parameter Name="ModifiedBy" Type="String" />
                <asp:Parameter Name="ModifiedSource" Type="String" />
                <asp:Parameter Name="ModifiedDate" Type="DateTime" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="InvalidAddress" Type="Boolean" />
                <asp:Parameter Name="ExhibitInfo" Type="String" />
                <asp:Parameter Name="SpecialNeeds" Type="String" />
                <asp:Parameter Name="SedCorrPres" Type="Double" />
                <asp:Parameter Name="SedCoAuth" Type="Double" />
                <asp:Parameter Name="SedChrProspect" Type="String" />
                <asp:Parameter Name="SedOtherRole" Type="String" />
                <asp:Parameter Name="BioChrProspect" Type="String" />
                <asp:Parameter Name="BioOtherRole" Type="String" />
                <asp:Parameter Name="PersonID" Type="Int32" />
       </UpdateParameters> 
      </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [CountryName], [CountryCode] FROM [LookupCountry] Order By [ListOrder]"></asp:SqlDataSource>

      <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT     LookupStateProvince.StateProvinceAbbreviation, (LookupStateProvince.StateProvinceName + ' (' + LookupStateProvince.CountryCode + ')') as ListStateProvinceName
FROM         LookupStateProvince LEFT OUTER JOIN
                      LookupCountry ON LookupStateProvince.CountryCode = LookupCountry.CountryCode
ORDER BY LookupCountry.ListOrder, LookupStateProvince.StateProvinceName"></asp:SqlDataSource>


    <asp:Panel ID="PanelPerson" runat="server" Visible="False">

    <asp:Label ID="LabelPersonValidation" runat="server"></asp:Label>

<asp:FormView ID="FormViewPersonLookup" runat="server" DataKeyNames="PersonID" DataSourceID="SqlDataSourcePerson" RenderOuterTable="False" Visible="False">
    <InsertItemTemplate>

                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Label ID="LabelDataValidationSummary" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <h4>Enter Person Information</h4>
                                            <span class="text-danger">*</span> Indicates a required field.
                                            <h6>Please do not include professional or military titles (e.g., Dr., Professor, Ph.D., PE, PG) or other suffixes (e.g., Jr., Sr., II) in the name fields.</h6>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblFirstName" runat="server" Text="First/Middle Names" AssociatedControlID="FirstNameTextBox"></asp:Label></h5>
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
                                                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control"  MaxLength="100" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblOmitMass" runat="server" Text="Omit From Mass Emails" AssociatedControlID="OmitTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="OmitTextBox" runat="server" Text='<%# Bind("OmitFromMassEmails") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control"  MaxLength="100" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblAltPOCEmail" runat="server" Text="Alternate Email Address" AssociatedControlID="AltPOCEmailTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="AltPOCEmailTextBox" runat="server" Text='<%# Bind("AltPOC") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control"  MaxLength="100" />
                                            </div>
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
                                                <h5><asp:Label ID="lblStateProv" runat="server" Text="State/Province" AssociatedControlID="StateProvinceDropDownList"></asp:Label></h5>
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
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblEnteredBy" runat="server" Text="Entered By" AssociatedControlID="EnteredByTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="EnteredByTextBox" runat="server" Text='<%# Bind("EnteredBy") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblEnteredSource" runat="server" Text="Entered Source" AssociatedControlID="EnteredSourceTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="EnteredSourceTextBox" runat="server" Text='<%# Bind("EnteredSource") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblEnteredDate" runat="server" Text="Entered Date" AssociatedControlID="EnteredDateTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="EnteredDateTextBox" runat="server" Text='<%# Bind("EnteredDate") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50"  ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblModifiedBy" runat="server" Text="Modified by" AssociatedControlID="ModifiedByTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="ModifiedByTextBox" runat="server" Text='<%# Bind("ModifiedBy") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" ReadOnly="true"/>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblNotes" runat="server" Text="Notes" AssociatedControlID="NotesTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" TextMode="multiline" Columns="50" Rows="5" />
                                            </div>
                                        </div>
                                    </div>



                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblExhibitInfo" runat="server" Text="Exhibit Info" AssociatedControlID="ExhibitInfoTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="ExhibitInfoTextBox" runat="server" Text='<%# Bind("ExhibitInfo") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSpecialNeeds" runat="server" Text="Special Needs" AssociatedControlID="SpecialNeedsTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SpecialNeedsTextBox" runat="server" Text='<%# Bind("SpecialNeeds") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSedCorrPres" runat="server" Text="SedCorrPres" AssociatedControlID="SedCorrPresTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SedCorrPresTextBox" runat="server" Text='<%# Bind("SedCorrPres") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSedCoAuth" runat="server" Text="SedCoAuth" AssociatedControlID="SedCoAuthTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SedCoAuthTextBox" runat="server" Text='<%# Bind("SedCoAuth") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSedChrProspect" runat="server" Text="SedChrProspect" AssociatedControlID="SedChrProspectTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SedChrProspectTextBox" runat="server" Text='<%# Bind("SedChrProspect") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSedOtherRole" runat="server" Text="SedOtherRole" AssociatedControlID="SedOtherRoleTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SedOtherRoleTextBox" runat="server" Text='<%# Bind("SedOtherRole") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>



                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblBioChrProspect" runat="server" Text="BioChrProspect" AssociatedControlID="BioChrProspectTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="BioChrProspectTextBox" runat="server" Text='<%# Bind("BioChrProspect") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblBioOtherRole" runat="server" Text="BioOtherRole" AssociatedControlID="BioOtherRoleTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="BioOtherRoleTextBox" runat="server" Text='<%# Bind("BioOtherRole") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Button ID="ButtonInsert" CausesValidation="True" runat="server" Text="Add Person" CssClass="btn btn-primary" OnClientClick="SetFocus(1)" OnClick="ButtonInsert_ItemInserting"  />&nbsp;
                                            <asp:Button ID="ButtonInsertCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" OnClick="ButtonInsertCancel_Click" />
                                        </div>
                                    </div>
                                </div>
     </InsertItemTemplate>
    <EditItemTemplate>
        <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <h4>Update Person Information</h4>
                                            <span class="text-danger">*</span> Indicates a required field.
                                            <h6>Please do not include professional or military titles (e.g., Dr., Professor, Ph.D., PE, PG) or other suffixes (e.g., Jr., Sr., II) in the name fields.</h6>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblParticipationID" runat="server" Text="Participation ID" AssociatedControlID="ParticipationIDTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="ParticipationIDTextBox" runat="server" Text='<%# Bind("ParticipationID") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                &nbsp;
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><span class="text-danger">*</span><asp:Label ID="lblFirstName" runat="server" Text="First/Middle Names" AssociatedControlID="FirstNameTextBox"></asp:Label></h5>
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
                                                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control"  MaxLength="100" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblOmitMass" runat="server" Text="Omit From Mass Emails" AssociatedControlID="OmitTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="OmitTextBox" runat="server" Text='<%# Bind("OmitFromMassEmails") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control"  MaxLength="100" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblAltPOCEmail" runat="server" Text="Alternate Email Address" AssociatedControlID="AltPOCEmailTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="AltPOCEmailTextBox" runat="server" Text='<%# Bind("AltPOC") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control"  MaxLength="100" />
                                            </div>
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
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblEnteredBy" runat="server" Text="Entered By" AssociatedControlID="EnteredByTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="EnteredByTextBox" runat="server" Text='<%# Eval("EnteredBy") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" ReadOnly="true"/>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblEnteredSource" runat="server" Text="Entered Source" AssociatedControlID="EnteredSourceTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="EnteredSourceTextBox" runat="server" Text='<%# Eval("EnteredSource") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" ReadOnly="true"/>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblEnteredDate" runat="server" Text="Entered Date" AssociatedControlID="EnteredDateTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="EnteredDateTextBox" runat="server" Text='<%# Eval("EnteredDate") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblModifiedBy" runat="server" Text="Modified by" AssociatedControlID="ModifiedByTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="ModifiedByTextBox" runat="server" Text='<%# Bind("ModifiedBy") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>

                                         <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblModifiedSource" runat="server" Text="Modified Source" AssociatedControlID="ModifiedSourceTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="ModifiedSourceTextBox" runat="server" Text='<%# Bind("ModifiedSource") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50"/>
                                            </div>
                                        </div>
                                    </div>



                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblNotes" runat="server" Text="Notes" AssociatedControlID="NotesTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" TextMode="multiline" Columns="50" Rows="5" />
                                            </div>
                                        </div>
                                    </div>



                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblExhibitInfo" runat="server" Text="Exhibit Info" AssociatedControlID="ExhibitInfoTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="ExhibitInfoTextBox" runat="server" Text='<%# Bind("ExhibitInfo") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSpecialNeeds" runat="server" Text="Special Needs" AssociatedControlID="SpecialNeedsTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SpecialNeedsTextBox" runat="server" Text='<%# Bind("SpecialNeeds") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSedCorrPres" runat="server" Text="SedCorrPres" AssociatedControlID="SedCorrPresTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SedCorrPresTextBox" runat="server" Text='<%# Bind("SedCorrPres") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSedCoAuth" runat="server" Text="SedCoAuth" AssociatedControlID="SedCoAuthTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SedCoAuthTextBox" runat="server" Text='<%# Bind("SedCoAuth") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSedChrProspect" runat="server" Text="SedChrProspect" AssociatedControlID="SedChrProspectTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SedChrProspectTextBox" runat="server" Text='<%# Bind("SedChrProspect") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblSedOtherRole" runat="server" Text="SedOtherRole" AssociatedControlID="SedOtherRoleTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="SedOtherRoleTextBox" runat="server" Text='<%# Bind("SedOtherRole") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                    </div>



                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblBioChrProspect" runat="server" Text="BioChrProspect" AssociatedControlID="BioChrProspectTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="BioChrProspectTextBox" runat="server" Text='<%# Bind("BioChrProspect") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <h5><asp:Label ID="lblBioOtherRole" runat="server" Text="BioOtherRole" AssociatedControlID="BioOtherRoleTextBox"></asp:Label></h5>
                                                <asp:TextBox ID="BioOtherRoleTextBox" runat="server" Text='<%# Bind("BioOtherRole") %>' ValidationGroup="FormViewPersonInsert" CssClass="form-control" MaxLength="50" />

                                            </div>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-12"> 
                                        <asp:HiddenField ID="hdnPersonID" runat="server" Value='<%# Bind("PersonID")%>' />                                                  
                                        <asp:Button ID="ButtonUpdate" runat="server" CausesValidation="True"  Text="Update my information" CssClass="btn btn-success" OnClick="ButtonUpdate_ItemUpdating" />
                                        <asp:Button ID="ButtonUpdateCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-primary" OnClick="ButtonUpdate_Cancel" />                
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
                                <b>Omit From Mass Emails:</b>
                                <asp:Label ID="OmitLabel" runat="server" Text='<%# Bind("OmitFromMassEmails") %>' />
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
           <asp:LinkButton ID="LinkButtonExecute1" runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-star"></span> Update User</asp:LinkButton>
           <asp:LinkButton ID="LinkButtonClear1" runat="server" CssClass="btn btn-primary"><span class="glyphicon glyphicon-remove"></span> Clear</asp:LinkButton>
           <asp:LinkButton ID="LinkButtonAdd1" runat="server" CssClass="btn btn-warning" CommandName="Edit" Text="Edit"><span class="glyphicon glyphicon-pencil"></span> Add User</asp:LinkButton>
        </div>
    </div>        
    <div style="text-align:center;">
        <%-- %><i>You are viewing page <%=GridView1.PageIndex + 1%> of <%=GridView1.PageCount%> total pages</i>--%>
    </div>          
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="100"  >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <PagerSettings Mode="NumericFirstLast" PreviousPageText="Previous" NextPageText="Next" PageButtonCount="10" Position="TopAndBottom"  />
        <PagerStyle ForeColor="Black" HorizontalAlign="center" BackColor="#C6C3C6" CssClass="pageSpace" ></PagerStyle>
        <Columns>
            <asp:TemplateField HeaderText="Update" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle">
                <ItemTemplate>
                    <input name="idSelect" type="radio" value='<%# Eval("PersonID") %>' />
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
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="true" ForeColor="White" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="true" ForeColor="#333333" />
    </asp:GridView>
    <div style="text-align:center;">
        <i>You are viewing page <%=GridView1.PageIndex + 1%> of <%=GridView1.PageCount%> total pages</i>
    </div>

    <div class="row" style="padding-top:10px;">
        <div class="col-md-12">
           <asp:LinkButton ID="LinkButtonExecute" runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-star"></span> Update User</asp:LinkButton>
           <asp:LinkButton ID="LinkButtonClear" runat="server" CssClass="btn btn-primary"><span class="glyphicon glyphicon-remove"></span> Clear</asp:LinkButton>
            <asp:LinkButton ID="LinkButtonAdd" runat="server" CssClass="btn btn-warning"><span class="glyphicon glyphicon-pencil"></span> Add User</asp:LinkButton>
        </div>
    </div>
    </asp:Panel>

</asp:Content>
