<%@ Page Title="Short Course Manager" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="ShortCourseManager.aspx.vb" Inherits="Battelle.ShortCourseManager" EnableEventValidation ="false" %>
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

    <div class="row">
    <div style="float:left;"><h1><%=Page.Title%></h1></div>
    <div style="float:right;"><br /><asp:LinkButton ID="ButtonShortCourseExport" runat="server" Text="Export To Excel" CssClass="btn btn-success" OnClick="ButtonShortCourseExport_Click" /></div>
    <div style="clear: both;" />
    </div>
   
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceShortCourse" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseGetByConferenceID" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceShortCourseGroup" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseGroupGetByConferenceID" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:HiddenField ID="HdnConferenceID" runat="server" />
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList><br />
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div id="divGrid" style="width: 100%; height: 400px; overflow: auto;">
                        <asp:GridView ID="gvCourse" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceShortCourse" AutoGenerateColumns="False" Visible="False" CssClass="table" DataKeyNames="CourseID" SelectedRowStyle-CssClass="active" >
                            <HeaderStyle CssClass="HeaderFreeze" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" SelectText="Select" />
                                <asp:BoundField DataField="CourseName" HeaderText="Course" SortExpression="CourseName" />
                                <asp:BoundField DataField="Submitter" HeaderText="Submitter" SortExpression="Submitter"/>
                                <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                                <asp:BoundField DataField="CourseLength" HeaderText="Length" SortExpression="CourseLength" />
                                <asp:BoundField DataField="Cancelled" HeaderText="Cancelled" SortExpression="Cancelled" />
                                <asp:BoundField DataField="CourseApproved" HeaderText="CourseApproved" SortExpression="CourseApproved" />
                            </Columns>
                            <SelectedRowStyle CssClass="info" />
                        </asp:GridView>  
                            <asp:GridView ID="gvShortCourseAll" runat="server" DataSourceID="SqlDataSourceShortCourse" AutoGenerateColumns="False" DataKeyNames="CourseID" Visible="False">
                                <Columns>
                                    <asp:BoundField DataField="CourseID" HeaderText="CourseID" InsertVisible="False" ReadOnly="True" SortExpression="CourseID" />
                                    <asp:BoundField DataField="CourseName" HeaderText="CourseName" SortExpression="CourseName" />
                                    <asp:BoundField DataField="CoursePresenter" HeaderText="CoursePresenter" SortExpression="CoursePresenter" />
                                    <asp:BoundField DataField="Cancelled" HeaderText="Cancelled" SortExpression="Cancelled" />
                                    <asp:BoundField DataField="MaxCapacity" HeaderText="Max Capacity" SortExpression="MaxCapacity" />
                                    <asp:BoundField DataField="CourseLength" HeaderText="CourseLength" SortExpression="CourseLength" />
                                    <asp:BoundField DataField="LaptopsRequired" HeaderText="LaptopsRequired" SortExpression="LaptopsRequired" />
                                    <asp:BoundField DataField="SpecialSoftwareRequired" HeaderText="SpecialSoftwareRequired" SortExpression="SpecialSoftwareRequired" />
                                    <asp:BoundField DataField="Software" HeaderText="Software" SortExpression="Software" />
                                    <asp:BoundField DataField="InternetAccessRequired" HeaderText="InternetAccessRequired" SortExpression="InternetAccessRequired" />
                                    <asp:BoundField DataField="SupplementalMaterialsProvided" HeaderText="SupplementalMaterialsProvided" SortExpression="SupplementalMaterialsProvided" />
                                    <asp:BoundField DataField="SupplementalMaterialsList" HeaderText="SupplementalMaterialsList" SortExpression="SupplementalMaterialsList" />
                                    <asp:BoundField DataField="CourseObjective" HeaderText="CourseObjective" SortExpression="CourseObjective" />
                                    <asp:BoundField DataField="CourseOverview" HeaderText="CourseOverview" SortExpression="CourseOverview" />
                                    <asp:BoundField DataField="DraftAgenda" HeaderText="DraftAgenda" SortExpression="DraftAgenda" />
                                    <asp:BoundField DataField="CourseApproved" HeaderText="CourseApproved" SortExpression="CourseApproved" />
                                    <asp:BoundField DataField="Submitter" HeaderText="Submitter" ReadOnly="True" SortExpression="Submitter" />
                                    <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                                    <asp:BoundField DataField="Instructors" HeaderText="Instructors" ReadOnly="True" SortExpression="Instructors" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    </div>
                <div class="row">
                    <br /><br />
                </div>
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                         <asp:SqlDataSource ID="SqlDataSourceCo" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseInstructorsGet" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvCourse" Name="CourseID" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <h2 runat="server" id="ShortCourseHeader" visible="false">Short Course Submission</h2>
                                <h4 runat="server" id="gvCourseAuthorsLbl" visible="false">Short Course - Instructors</h4>
                                <asp:GridView ID="gvAuthors" runat="server" DataSourceID="SqlDataSourceCo" AutoGenerateColumns="False" Visible="False" CssClass="table" OnDataBound="GetCurrentPresenter">
                                    <Columns>
                                        <asp:CheckBoxField DataField="POCInstructor" HeaderText="POC Instructor" SortExpression="POCInstructor" />
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
                                <asp:LinkButton ID="gvAuthorsButton" runat="server" CausesValidation="False" Text="Hide Grid View" CssClass="btn btn-default"  Visible="false" OnClick="gvAuthorsButton_Click"  />
                                <br /><br />

                                <div class="row" id="labelCorrespondingAuthor" runat="server" visible="false">
                                    <div class="col-md-12">
                                    <b><asp:Label ID="lblAuthorResults" runat="server" ForeColor="Red" Text=""></asp:Label></b>
                                    
                                    <asp:Literal ID="LiteralAlertDivOpen" runat="server" Text='<div class="alert alert-info" role="alert">'></asp:Literal>
                                    <h4>Point of Contact</h4>
                                    <b><asp:Label ID="lblCorPresAuthor" runat="server" Text=""></asp:Label></b>
                                    <asp:HiddenField ID="hdnCorPres" runat="server" />  
                                    <br />
                                    <br />
                                    <asp:ListBox ID="listofDeletedAuthors" runat="server" Visible="false"></asp:ListBox>
                                    <b><asp:Label ID="lblDelAuthor" EnableViewState="False" runat="server" Text=""></asp:Label></b>
                                    <asp:Literal ID="LiteralAlertDivClose" runat="server" Text="</div>"></asp:Literal> 
                                    </div>
                                </div>
                                
                                <div class="row" id="listCorrespondingAuthor" runat="server" visible="false">
                                    <div class="col-md-12">
                                <asp:Label ID="lblAuthors" runat="server" Text="*Co-Instructors" AssociatedControlID="ListBoxAbstractAuthors"></asp:Label><br />
                                If there are any additional instructors listed for this course, click the &quot;Add Co-Instructors&quot; button.
                                <br />
                                <asp:ListBox ID="ListBoxAbstractAuthors" runat="server" DataSourceID="SqlDataSourceCo" DataValueField="personID" DataTextField="FullName" AutoPostBack="True"  CssClass="form-control" Height="120px">
                                </asp:ListBox>
                                <asp:Button ID="ButtonAuthorsAdd" runat="server" Text="Add Co-Instructors" CssClass="btn btn-primary" UseSubmitBehavior="False" />&nbsp;
                                <asp:Button ID="ButtonCorPresAuthorSet" runat="server" Text="Set as Point-of-Contact" CssClass="btn btn-success" UseSubmitBehavior="False" Visible="False" />&nbsp;
                                <asp:Button ID="ButtonAuthorsRemove" runat="server" Text="Remove selected instructor" Visible="False" CssClass="btn btn-warning" UseSubmitBehavior="False" />&nbsp;
                                <asp:Button ID="ButtonAuthorsEdit" runat="server" Text="Edit selected instructor" Visible="False" CssClass="btn btn-warning" UseSubmitBehavior="False" />&nbsp;
                                <!--<asp:Button ID="ButtonUpdateAuthors" runat="server" Text="Refresh Instructors Table" OnClick="AbstractAuthorsUpdate_Click" CssClass="btn btn-default"  />&nbsp;-->
                                <br />
                                If you are not the corresponding/presenting instructor for this course, click another name in the box above to set as the corresponding/presenting instructor. If you are not one of the instructors, click your name to remove.<br /><br />
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
                    <h4>Edit Selected Instructor</h4>
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
                    <h4>Edit Selected Instructor</h4>
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
                                <asp:LinkButton ID="EditAuthorButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="CloseAuthorButton" runat="server" CausesValidation="False" Text="Close" OnClick="CloseAuthorButton_Click" />
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
                                            <asp:Label ID="lblPersonEmail" runat="server" Text="Co-instructor Email Address" AssociatedControlID="TextBoxPersonEmail"></asp:Label>
                                            First, check to see if the co-instructor exists in our system by entering his or her email address.
                                        </div>
                                        <div class="panel-body">
                                            <div class="input-group">
                                                <asp:TextBox ID="TextBoxPersonEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                                <span class="input-group-btn">
                                                    <asp:Button ID="LinkButtonPersonLookup2" runat="server" Text="Search for co-instructor" CssClass="btn btn-primary" UseSubmitBehavior="False" ValidationGroup="ValidateEmail" /></span>
                                               
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
                                            <asp:Button ID="ButtonNew" runat="server" Text="Enter co-instructor information" CausesValidation="False" CommandName="New" CssClass="btn btn-warning" /> 
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
                                            <h4>Enter Co-instructor Information</h4>
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
                                            <asp:Button ID="ButtonInsert" CausesValidation="True" CommandName="Insert" runat="server" Text="Add Co-instructor" CssClass="btn btn-primary" OnClientClick="SetFocus(1)" />&nbsp;
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
                                            If you believe your co-instructor’s information above should be updated, please send an email to 
                                            <p>ENTER HYPERLINK HERE</p>
                                             explaining what you believe should be corrected and providing the email and address for your co-instructor. Please copy and paste the information displayed into your email and include the title of your abstract.
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Button ID="ButtonSelect" runat="server" CausesValidation="False" CommandName="Select" OnClick="SelectButton_Click" Text="Add to co-instructor list" CssClass="btn btn-success" UseSubmitBehavior="False" OnClientClick="SetFocus(1)" />
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
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:SqlDataSource ID="SqlDataSourceCourseSelected" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseGetByCourseID" SelectCommandType="StoredProcedure" UpdateCommand="ShortCourseUpdate" UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvCourse" Name="courseID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="CourseID" Type="Int32" />
                                <asp:Parameter Name="CourseName" Type="String" />
                                <asp:Parameter Name="CoursePresenter" Type="String" />
                                <asp:Parameter Name="GroupID" Type="Int32" />
                                <asp:Parameter Name="Cancelled" Type="Boolean" />
                                <asp:Parameter Name="MaxCapacity" Type="Int32" />
                                <asp:Parameter Name="CourseDescription" Type="String" />
                                <asp:Parameter Name="CourseLength" Type="Int32" />
                                <asp:Parameter Name="LaptopsRequired" Type="Boolean" />
                                <asp:Parameter Name="SpecialSoftwareRequired" Type="Boolean" />
                                <asp:Parameter Name="Software" Type="String" />
                                <asp:Parameter Name="InternetAccessRequired" Type="Boolean" />
                                <asp:Parameter Name="SupplementalMaterialsProvided" Type="Boolean" />
                                <asp:Parameter Name="SupplementalMaterialsList" Type="String" />
                                <asp:Parameter Name="CourseObjective" Type="String" />
                                <asp:Parameter Name="CourseOverview" Type="String" />
                                <asp:Parameter Name="DraftAgenda" Type="String"  />
                                <asp:Parameter Name="CourseApproved" Type="Boolean" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        
                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="courseID" DataSourceID="SqlDataSourceCourseSelected" RenderOuterTable="False" Visible="False">
                            <HeaderTemplate>
                            <h4>Short Course Information</h4>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnAbstractID" runat="server" Value='<%# Bind("CourseID")%>' />
                                <strong>Title:</strong>
                                <asp:Label ID="CourseLabel" runat="server" Text='<%# Bind("CourseName") %>' />
                                <br />
                                <strong>Course Presenter:</strong>
                                <asp:Label ID="PresenterLabel" runat="server" Text='<%# Bind("CoursePresenter") %>' />
                                <br />
                                <strong>Short Course Date/Time:</strong>
                                <asp:Label ID="GroupLabel" runat="server" Text='<%# Bind("GroupName") %>' />
                                <br />
                                <strong>Cancelled:</strong>
                                <asp:CheckBox ID="CancelledCheckBox" runat="server" Checked='<%# Bind("Cancelled") %>' Enabled="false" />
                                <br />
                                <strong>Course Description:</strong>
                                <asp:Label ID="CourseDescriptionLabel" runat="server" Text='<%# Bind("CourseDescription") %>' />
                                <br />
                                <strong>Course Length:</strong>
                                <asp:Label ID="CourseLengthLabel" runat="server" Text='<%# Bind("CourseLength") %>' />
                                <br />
                                <strong>Laptops Required:</strong>
                                <asp:CheckBox ID="LaptopsRequiredCheckBox" runat="server" Checked='<%# Bind("LaptopsRequired") %>' Enabled="false" />
                                <br />
                                <strong>Special Software Required:</strong>
                                <asp:CheckBox ID="SpecialSoftwareRequiredCheckBox" runat="server" Checked='<%# Bind("SpecialSoftwareRequired") %>' Enabled="false" />
                                <br />
                                <strong>Software:</strong>
                                <asp:Label ID="SoftwareLabel" runat="server" Text='<%# Bind("Software") %>' />
                                <br />
                                <strong>Internet Access Required:</strong>
                                <asp:CheckBox ID="InternetAccessRequiredCheckBox" runat="server" Checked='<%# Bind("InternetAccessRequired") %>' Enabled="false" />
                                <br />
                                <strong>Supplemental Materials Provided:</strong>
                                <asp:CheckBox ID="SupplementalMaterialsProvidedCheckBox" runat="server" Checked='<%# Bind("SupplementalMaterialsProvided") %>' Enabled="false" />
                                <br />
                                <strong>Supplemental Materials List:</strong>
                                <asp:Label ID="SupplementalMaterialsListLabel" runat="server" Text='<%# Bind("SupplementalMaterialsList") %>' />
                                <br />
                                <strong>Course Objective:</strong>
                                <asp:Label ID="CourseObjectiveLabel" runat="server" Text='<%# Bind("CourseObjective") %>' />
                                <br />
                                <strong>Course Overview:</strong>
                                <asp:Label ID="CourseOverviewLabel" runat="server" Text='<%# Bind("CourseOverview") %>' />
                                <br />
                                <strong>Draft Agenda:</strong>
                                <asp:Label ID="DraftAgendaLabel" runat="server" Text='<%# Bind("DraftAgenda") %>' />
                                <br />
                                <strong>Submitter:</strong>
                                <asp:Label ID="SubmitterLabel" runat="server" Text='<%# Bind("Submitter") %>' />
                                <br />
                                <strong>Employer:</strong>
                                <asp:Label ID="EmployerLabel" runat="server" Text='<%# Bind("Employer") %>' />
                                <br />
                                <strong>Course Approved:</strong>
                                <asp:Label ID="CourseApprovedLabel" runat="server" Text='<%# Bind("CourseApproved") %>' />
                                <br />
                                <br /><br />                    
                                <asp:Button ID="ButtonEdit" runat="server" CssClass="btn btn-primary" CausesValidation="False" CommandName="Edit" Text="Edit Short Course" />
                          </ItemTemplate>
                          <EditItemTemplate>
                                <strong>Title:</strong>
                                <asp:TextBox ID="CourseTextBox" runat="server" Text='<%# Bind("CourseName") %>' CssClass="form-control" />
                                <br />
                                <strong>Course Presenter:</strong>
                                <asp:TextBox ID="PresenterTextBox" runat="server" Text='<%# Bind("CoursePresenter") %>' CssClass="form-control" />
                                <br />
                                <strong>Short Course Date/Time:</strong>
                                <asp:DropDownList ID="ddlShortGroupList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceShortCourseGroup" DataTextField="GroupName" DataValueField="GroupID" CssClass="form-control" SelectedValue='<%# Bind("GroupID") %>' >
                                   <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                <strong>Cancelled:</strong>
                                <asp:CheckBox ID="CancelledCheckBox" runat="server" Checked='<%# Bind("Cancelled") %>' />
                                <br /><br />
                                <strong>Course Length:</strong>
                                <asp:TextBox ID="CourseLength" runat="server" Text='<%# Bind("CourseLength") %>' CssClass="form-control" />
                                <br />
                                <strong>Laptops Required:</strong>
                                <asp:CheckBox ID="LaptopsRequiredCheckBox" runat="server" Checked='<%# Bind("LaptopsRequired") %>'  />
                                <br />
                                <strong>Special Software Required:</strong>
                                <asp:CheckBox ID="SpecialSoftwareRequiredCheckBox" runat="server" Checked='<%# Bind("SpecialSoftwareRequired") %>'  />
                                <br /><br />
                                <strong>Software:</strong>
                                <asp:TextBox ID="SoftwareTextBox" runat="server" Text='<%# Bind("Software") %>' CssClass="form-control" />
                                <br />
                                <strong>Internet Access Required:</strong>
                                <asp:CheckBox ID="InternetAccessRequiredCheckBox" runat="server" Checked='<%# Bind("InternetAccessRequired") %>'  />
                                <br />
                                <strong>Supplemental Materials Provided:</strong>
                                <asp:CheckBox ID="SupplementalMaterialsProvidedCheckBox" runat="server" Checked='<%# Bind("SupplementalMaterialsProvided") %>'  />
                                <br /><br />
                                <strong>Supplemental Materials List:</strong>
                                <asp:TextBox ID="SupplementalMaterialsListTextBox" runat="server" Text='<%# Bind("SupplementalMaterialsList") %>' CssClass="form-control" />
                                <br />
                                <strong>Course Objective:</strong>
                                <asp:TextBox ID="CourseObjectiveTextBox" runat="server" Text='<%# Bind("CourseObjective") %>' CssClass="form-control" TextMode="MultiLine" Rows="5" />
                                <br />
                                <strong>Course Overview:</strong>
                                <%--<asp:TextBox ID="CourseOverviewTextBox" runat="server" Text='<%# Bind("CourseOverview") %>' CssClass="form-control" TextMode="MultiLine" Rows="5" />--%>
                              <telerik:RadEditor ID="RadEditorCourseOverview" runat="server" ContentAreaMode="Div" Width="100%" AutoResizeHeight="true" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" Content='<%# Bind("CourseOverview")%>'>
                            </telerik:RadEditor>  
                              <br />
                                <strong>Draft Agenda:</strong>
                                <%--<asp:TextBox ID="DraftAgendaTextBox" runat="server" Text='<%# Bind("DraftAgenda") %>' CssClass="form-control" TextMode="MultiLine" Rows="5" />--%>
                                <telerik:RadEditor ID="RadEditorDraftAgenda" runat="server" ContentAreaMode="Div" Width="100%" AutoResizeHeight="true" ToolsFile="~/Content/ToolBars/AdvancedTools.xml" ContentFilters="MakeUrlsAbsolute, DefaultFilters" Content='<%# Bind("DraftAgenda")%>'>
                            </telerik:RadEditor>
                                <br />
                                <strong>Short Course Approved:</strong>
                                <asp:CheckBox ID="ShortCourseApprovedCheckBox" runat="server" Checked='<%# Bind("CourseApproved") %>' />
                                <br /><br />
                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-primary" OnClick="ButtonUpdate_Click" />
                                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                        </EditItemTemplate>
                    </asp:FormView>
                            
                    </div>
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
       </div>
</asp:Content>

