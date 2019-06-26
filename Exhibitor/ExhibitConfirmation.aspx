<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Exhibit.Master" CodeBehind="ExhibitConfirmation.aspx.vb" Inherits="Battelle.ExhibitConfirmation" %>
<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><!--Sponsor--><%=ExhibitorOrSponsor%> Confirmation</h1>
    <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ExhibitorBoothInfoGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
            <asp:Parameter Name="ConferenceID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceLedger" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="ConferenceLedgerInsert" InsertCommandType="StoredProcedure" SelectCommand="ConferenceFeeGetByType" SelectCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="FeeTypeID" DefaultValue="6" Type="Int32" />
            <asp:Parameter Name="Amount" Type="Decimal" />
            <asp:Parameter Name="Notes" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter DefaultValue="6" Name="FeeTypeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceItemCount" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerFeeTypeCount" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
            <asp:Parameter DefaultValue="6" Name="FeeTypeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:Panel ID="PanelProgress" runat="server" Visible="False">
        <div class="progress">
            <asp:Label ID="lblProgress" runat="server" Text=""></asp:Label>
        </div>
    </asp:Panel>
    <asp:Label ID="lblAlert" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Panel ID="PanelInstructions" runat="server" Visible="false">
        Instructions go here.
    </asp:Panel>
    <asp:Panel ID="PanelParticipationControl" runat="server" Visible="False">
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" OnFinishedLogin="ParticipationIDLogin_FinishedLogin" />
    </asp:Panel>
    <asp:Panel ID="PanelExhibitor" runat="server" Visible="False">
        <asp:Label ID="lblCompanyName" runat="server" Text=""></asp:Label>
        <asp:SqlDataSource ID="SqlDataSourceOrgID" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ExhibitorCheckbyOrganizationID" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="OrganizationID" Type="String" />
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hdnFee" runat="server" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-4">

                    <div class="form-group">

                        <asp:Label ID="lblOrgID" runat="server" Text="Enter your Organization ID:" AssociatedControlID="txtOrgID"></asp:Label><br />
                        <div class="input-group">
                            <asp:TextBox ID="txtOrgID" runat="server" CssClass="form-control"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnOrgID" runat="server" Text="Look Up Organization" CssClass="btn btn-default" /></span>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </asp:Panel>
    <asp:Panel ID="PanelBooth" runat="server">
        <asp:SqlDataSource ID="SqlDataSourceConfirmation" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothConfirmationGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="ConferenceID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        <h3>Reservation Confirmation</h3>
        <div class="alert alert-info" role="alert">Please print this page for your records. If you have any special dietary needs or 
            require disability accommodations 
            please contact Susie Warner at <a href="mailto:swarner@scgcorp.com">swarner@scgcorp.com</a>.</div>
        <p>You  are the person listed as the booth point of contact for your organization and  will receive all correspondence and 
            important information regarding the upcoming 
            <asp:Label ID="lblConferenceType" runat="server" Text="Conference"></asp:Label>. 
            Please note that you will need to forward
            <asp:Label ID="lblConferenceType2" runat="server" Text="Conference"></asp:Label> information to other company staff as necessary.</p>
    <asp:FormView ID="FormViewConfirmation" runat="server" DataSourceID="SqlDataSourceConfirmation" RenderOuterTable="False">
        <EmptyDataTemplate>
            There is a problem retrieving your data.
        </EmptyDataTemplate>
        <ItemTemplate>
           <h4>Booth Selection:<br />
            <asp:Label ID="BoothNumberLabel" runat="server" Text='<%# Bind("BoothNumber") %>' /><br />
            <asp:Label ID="BoothNumber2Label" runat="server" Text='<%# Bind("BoothNumber2") %>' />
           </h4> 
            <br />
            <h4>Point of Contact</h4>
            Participant Code:
            <asp:Label ID="ParticipationIDLabel" runat="server" Text='<%# Bind("ParticipationID") %>' />
            <br />
            First Name:
            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
            <br />
            Last Name:
            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
            <br />
            Address Line 1: 
            <asp:Label ID="AddressLine1Label" runat="server" Text='<%# Bind("AddressLine1") %>' />
            <br />Line 2: 
            <asp:Label ID="AddressLine2Label" runat="server" Text='<%# Bind("AddressLine2") %>' />
            <br />Line 3: 
            <asp:Label ID="AddressLine3Label" runat="server" Text='<%# Bind("AddressLine3") %>' />
            <br />
            City:
            <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />
            <br />
            State/Province:
            <asp:Label ID="StateProvinceLabel" runat="server" Text='<%# Bind("StateProvince") %>' />
            <br />
            Zip/Postal Code:
            <asp:Label ID="ZipPostalLabel" runat="server" Text='<%# Bind("ZipPostal") %>' />
            <br />
            Country:
            <asp:Label ID="CountryLabel" runat="server" Text='<%# Bind("Country") %>' />
            <br />
            Office Phone Number:
            <asp:Label ID="PhoneNumLabel" runat="server" Text='<%# Bind("PhoneNum") %>' />
            <br />
            Cell Phone Number:
            <asp:Label ID="CellNumLabel" runat="server" Text='<%# Bind("CellNum") %>' />
            <br />
            Email:
            <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
            <h4>Organization Information</h4>
            Exhibitor:
            <asp:Label ID="ExhibitorLabel" runat="server" Text='<%# Bind("Exhibitor") %>' />
            <br />
            Organization ID:
            <asp:Label ID="OrganizationIDLabel" runat="server" Text='<%# Bind("OrganizationID") %>' />
            <br />
            Address Line 1: 
            <asp:Label ID="ExhibAddressLine1Label" runat="server" Text='<%# Bind("ExhibAddressLine1") %>' />
            <br />Line 2: 
            <asp:Label ID="ExhibAddressLine2Label" runat="server" Text='<%# Bind("ExhibAddressLine2") %>' />
            <br />Line 3: 
            <asp:Label ID="ExhibAddressLine3Label" runat="server" Text='<%# Bind("ExhibAddressLine3") %>' />
            <br />
            City:
            <asp:Label ID="ExhibCityLabel" runat="server" Text='<%# Bind("ExhibCity") %>' />
            <br />
            State/Province:
            <asp:Label ID="ExhibStateProvinceLabel" runat="server" Text='<%# Bind("ExhibStateProvince") %>' />
            <br />
            Zip/Postal Code:
            <asp:Label ID="ExhibZipPostalLabel" runat="server" Text='<%# Bind("ExhibZipPostal") %>' />
            <br />
            Country:
            <asp:Label ID="ExhibCountryLabel" runat="server" Text='<%# Bind("ExhibCountry") %>' />

        </ItemTemplate>
    </asp:FormView>
    </asp:Panel>
    <asp:Panel ID="PanelStaff" runat="server" Visible="false">
        <h3>Booth Staff</h3>
        <asp:SqlDataSource ID="SqlDataSourceStaff" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothStaffGet" SelectCommandType="StoredProcedure" InsertCommand="BoothStaffInsert" InsertCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
                <asp:Parameter Name="ExhibitorID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="gvStaff" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceStaff" EmptyDataText="You organization has not added any staff." CssClass="table">
            <Columns>
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                <asp:BoundField DataField="PhoneNum" HeaderText="Phone Number" SortExpression="PhoneNum" />
                <asp:BoundField DataField="CellNum" HeaderText="Cell Number" SortExpression="CellNum" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            </Columns>
        </asp:GridView>
    </asp:Panel>
    <asp:Panel ID="PanelBalance" runat="server" Visible="False">
        <asp:SqlDataSource ID="SqlDataSourceBalance" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerGetTotal" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h3>Exhibitor Selections and Fees</h3>
        <asp:GridView ID="gvBalance" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceBalance" CssClass="table" DataKeyNames="SumTotal">
            <Columns>
                <asp:TemplateField HeaderText="Transaction Date" SortExpression="TransactionDate">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("TransactionDate") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label0" runat="server" Text='<%# Bind("TransactionDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fee Type" SortExpression="FeeType">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FeeType") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("FeeType") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        US <asp:Label ID="Label2" runat="server" Text='<%# Bind("Amount", "{0:c}")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


            </Columns>
        </asp:GridView>
        Total Balance: US $<asp:Label ID="lblSumTotal" runat="server" Text="Label"></asp:Label><br />
        
    </asp:Panel>
    <asp:HiddenField ID="hdnNewStart" runat="server" />
    <asp:HiddenField ID="hdnEmail" runat="server" />
    <br />
    <br />
    </asp:Content>