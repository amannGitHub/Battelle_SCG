﻿<%@ Page Title="Learning Lab Manager" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="LearningLabManager.aspx.vb" Inherits="Battelle.LearningLabManager" EnableEventValidation ="false" %>
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
    <div style="float:right;"><br /><asp:LinkButton ID="ButtonLearningLabExport" runat="server" Text="Export To Excel" CssClass="btn btn-success" OnClick="ButtonLearningLabExport_Click" /></div>
    <div style="clear: both;" />
    </div>
   
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceLearningLab" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LearningLabGetByConferenceID" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceLearningLabExport" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LearningLabGetByConferenceID_Export" SelectCommandType="StoredProcedure">
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
                        <div id="divGrid" style="width: 100%; max-height: 400px; overflow: auto;">
                            <asp:GridView ID="gvLab" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceLearningLab" AutoGenerateColumns="False" Visible="False" CssClass="table" DataKeyNames="LearningLabID" SelectedRowStyle-CssClass="active" >
                            <HeaderStyle CssClass="HeaderFreeze" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" SelectText="Select" />
                                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                                <asp:BoundField DataField="FirstName" HeaderText="Submitter First Name" SortExpression="FirstName"/>
                                <asp:BoundField DataField="LastName" HeaderText="Submitter Last Name" SortExpression="LastName"/>
                                <asp:BoundField DataField="Email" HeaderText="Submitter Email" SortExpression="Email"/>
                                <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                                <asp:BoundField DataField="ExhibitorYN" HeaderText="Company is an Exhibitor?" SortExpression="ExhibitorYN" />
                                <asp:BoundField DataField="ShippingFreightYN" HeaderText="Shipping Freight?" SortExpression="ShippingFreightYN" />
                                <asp:BoundField DataField="FreightTruckYN" HeaderText="Require a Freight Truck?" SortExpression="FreightTruckYN" />
                                <asp:BoundField DataField="FreightStorageYN" HeaderText="Require Freight Storage?" SortExpression="FreightStorageYN" />
                                <asp:BoundField DataField="LabApproved" HeaderText="Lab Approved?" SortExpression="LabApproved" />
                            </Columns>
                            <SelectedRowStyle CssClass="info" />
                        </asp:GridView>

                            <asp:GridView ID="gvLearningLabAll" runat="server" DataSourceID="SqlDataSourceLearningLabExport" AutoGenerateColumns="False" DataKeyNames="LearningLabID" Visible="False">
                                <Columns>
                                    <asp:BoundField DataField="LearningLabID" HeaderText="LearningLabID" InsertVisible="False" ReadOnly="True" SortExpression="LearningLabID" />
                                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                                    <asp:BoundField DataField="FirstName" HeaderText="Submitter First Name" SortExpression="FirstName"/>
                                    <asp:BoundField DataField="LastName" HeaderText="Submitter Last Name" SortExpression="LastName"/>
                                    <asp:BoundField DataField="Email" HeaderText="Submitter Email Address" SortExpression="Email"/>                                
                                    <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                                    <asp:BoundField DataField="InstructorFirstName" HeaderText="Instructor First Name" SortExpression="InstructorFirstName"/>
                                    <asp:BoundField DataField="InstructorLastName" HeaderText="Instructor Last Name" SortExpression="InstructorLastName"/>
                                    <asp:BoundField DataField="InstructorEmail" HeaderText="Instructor Email Address" SortExpression="InstructorEmail"/>
                                    <asp:BoundField DataField="POCInstructor" HeaderText="Is POC?" SortExpression="POCInstructor"/>
                                    <asp:BoundField DataField="ExhibitorYN" HeaderText="Company is an Exhibitor?" SortExpression="ExhibitorYN" />
                                    <asp:BoundField DataField="ShippingFreightYN" HeaderText="Shipping Freight?" SortExpression="ShippingFreightYN" />
                                    <asp:BoundField DataField="FreightTruckYN" HeaderText="Require a Freight Truck?" SortExpression="FreightTruckYN" />
                                    <asp:BoundField DataField="FreightStorageYN" HeaderText="Require Freight Storage?" SortExpression="FreightStorageYN" />
                                    <asp:BoundField DataField="Objective" HeaderText="Objective" SortExpression="Objective" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                    <asp:BoundField DataField="LabApproved" HeaderText="Lab Approved?" SortExpression="LabApproved" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="row">

                </div>

                <!--start of authors code-->

                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                         <asp:SqlDataSource ID="SqlDataSourceCo" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LearningLabInstructorsGet" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvLab" Name="LearningLabID" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <h2 runat="server" id="LearningLabHeader" visible="false">Learning Lab Submission</h2>
                                <h4 runat="server" id="gvCourseAuthorsLbl" visible="false">Learning Lab - Instructors</h4>
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
                                            <asp:Button ID="ButtonSelect" runat="server" CausesValidation="False" CommandName="Select"  OnClick="SelectButton_Click" Text="Add to co-instructor list" CssClass="btn btn-success" UseSubmitBehavior="False" OnClientClick="SetFocus(1)" />                                           
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

                <!--end of authors code-->


                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:SqlDataSource ID="SqlDataSourceLabSelected" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LearningLabGetByLearningLabID" SelectCommandType="StoredProcedure" UpdateCommand="LearningLabUpdate" UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvLab" Name="LearningLabID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="LearningLabID" Type="Int32" />
                                <asp:Parameter Name="Title" Type="String" />                 
                                <asp:Parameter Name="ExhibitorYN" Type="Boolean" />
                                <asp:Parameter Name="ShippingFreightYN" Type="Boolean" />
                                <asp:Parameter Name="FreightTruckYN" Type="Boolean" />
                                <asp:Parameter Name="FreightStorageYN" Type="Boolean" />
                                <asp:Parameter Name="Objective" Type="String" />
                                <asp:Parameter Name="Description" Type="String" />
                                <asp:Parameter Name="LabApproved" Type="Boolean" />
                            </UpdateParameters>
                        </asp:SqlDataSource>

                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="LearningLabID" DataSourceID="SqlDataSourceLabSelected" RenderOuterTable="False" Visible="False">
                            <HeaderTemplate>
                            <h4>Learning Lab Information</h4>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnLearningLabID" runat="server" Value='<%# Bind("LearningLabID")%>' />
                                <strong>Title:</strong>
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>' />
                                <br /><br />
                                <strong>My company is also an Exhibitor:</strong>
                                <asp:Label ID="ExhibitorYNCheckBox" runat="server" Text='<%# Bind("ExhibitorYN") %>' />
                                <br />
                                <strong>I will be shipping freight with my equipment for the Learning Lab demonstration:</strong>
                                <asp:Label ID="ShippingFreightYNCheckBox" runat="server" Text='<%# Bind("ShippingFreightYN") %>' />
                                <br />
                                <strong>Will you require a freight truck to move your equipment to the Learning Lab space on-site at your assigned demonstration time?</strong>
                                <asp:Label ID="FreightTruckYNCheckBox" runat="server" Text='<%# Bind("FreightTruckYN") %>' />     
                                <br />
                                <strong>Will you require freight storage for your equipment on-site or will you be able to store your equipment in an exhibit booth?</strong>
                                <asp:Label ID="FreightStorageYNCheckBox" runat="server" Text='<%# Bind("FreightStorageYN") %>' />
                                <br /><br />
                                <strong>Objective:</strong>
                                <asp:Label ID="ObjectiveLabel" runat="server" Text='<%# Bind("Objective") %>' />
                                <br /><br />
                                <strong>Description:</strong>
                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>' />
                                <br /><br />
                                <strong>Submitter:</strong>
                                <asp:Label ID="SubmitterLabel" runat="server" Text='<%# Bind("Submitter") %>' />
                                <br />
                                <strong>Employer:</strong>
                                <asp:Label ID="EmployerLabel" runat="server" Text='<%# Bind("Employer") %>' />
                                <br /><br />
                                <strong>Lab Approved:</strong>
                                <asp:Label ID="CourseApprovedLabel" runat="server" Text='<%# Bind("LabApproved") %>' />
                                <br />
                                <br /><br />                    
                                <asp:Button ID="ButtonEdit" runat="server" CssClass="btn btn-primary" CausesValidation="False" CommandName="Edit" Text="Edit Learning Lab" />
                          </ItemTemplate>
                          <EditItemTemplate>
                                <strong>Title:</strong>
                                <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' CssClass="form-control" />
                                <br /><br />
                                <strong>My company is also an Exhibitor:</strong>
                                <asp:CheckBox ID="ExhibitorYNCheckBox" runat="server" Checked='<%# Bind("ExhibitorYN") %>' />
                                <br />
                                <strong>I will be shipping freight with my equipment for the Learning Lab demonstration:</strong>
                                <asp:CheckBox ID="ShippingFreightYNCheckBox" runat="server" Checked='<%# Bind("ShippingFreightYN") %>'  />
                                <br />
                                <strong>Will you require a freight truck to move your equipment to the Learning Lab space on-site at your assigned demonstration time?</strong>
                                <asp:CheckBox ID="FreightTruckYNCheckBox" runat="server" Checked='<%# Bind("FreightTruckYN") %>'  />
                                <br />
                                <strong>Will you require freight storage for your equipment on-site or will you be able to store your equipment in an exhibit booth?</strong>
                                <asp:CheckBox ID="FreightStorageYNCheckBox" runat="server" Checked='<%# Bind("FreightStorageYN") %>'  />                        
                                <br /><br />
                                <strong>Learning Lab Objective.</strong> Provide only <strong>a sentence or two</strong> that will give an overview of the information you believe the participants will gain from the demonstration. Describe the audience that would benefit most from the material you will be presenting (e.g., engineers, site managers, regulators).
                                <asp:TextBox ID="ObjectiveTextBox" runat="server" Text='<%# Bind("Objective") %>' CssClass="form-control" TextMode="MultiLine" Rows="5" />
                                <br /><br />
                                <strong>Learning Lab Description.</strong> Provide a concise <strong>(maximum 300 words)</strong> description below of the product, technology, software, tool, etc., that will be demonstrated:
                                <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control" TextMode="MultiLine" Rows="5" />
                                <br /><br />
                                <strong>Lab Approved:</strong>
                                <asp:CheckBox ID="LabApprovedCheckBox" runat="server" Checked='<%# Bind("LabApproved") %>' />
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

</asp:Content>
