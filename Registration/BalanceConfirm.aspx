<%@ Page Title="Balance Confirmation" Language="vb" AutoEventWireup="false" MasterPageFile="~/Registration/Registration.Master" CodeBehind="BalanceConfirm.aspx.vb" Inherits="Battelle.BalanceConfirm" %>
<%@ Register Src="../ParticipationIDLogin.ascx" TagName="ParticipationIDLogin" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:Label ID="lblAlert" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Panel ID="PanelParticipationControl" runat="server" Visible="True">
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" />
    </asp:Panel>
    <asp:Panel ID="PanelContact" runat="server">
        <div class="alert alert-info hidden-print" role="alert">Please print this page for your records.</div>
        <asp:SqlDataSource ID="SqlDataSourceConfirmation" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h3>Contact Information</h3>
        <asp:FormView ID="FormViewConfirmation" runat="server" DataSourceID="SqlDataSourceConfirmation" RenderOuterTable="False">
            <EmptyDataTemplate>
                There is a problem retrieving your data.
            </EmptyDataTemplate>
            <ItemTemplate>
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
                <br />
                Line 2: 
            <asp:Label ID="AddressLine2Label" runat="server" Text='<%# Bind("AddressLine2") %>' />
                <br />
                Line 3: 
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
                <br />
                Special Needs:
            <asp:Label ID="SpecialNeedsLabel" runat="server" Text='<%# Bind("SpecialNeeds")%>' />

            </ItemTemplate>
        </asp:FormView>
    </asp:Panel>
   
    <asp:Panel ID="PanelBalance" runat="server">
        <asp:SqlDataSource ID="SqlDataSourceBalance" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerGetTotal" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="PersonID" Type="Int32" />
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h3>Registration Fees and Payment</h3>
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
                        US
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Amount", "{0:c}")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


            </Columns>
        </asp:GridView>
        Total Balance: US $<asp:Label ID="lblSumTotal" runat="server" Text="Label"></asp:Label><br />
        <br />
        <asp:Label ID="lblCancellation" runat="server" Text=""></asp:Label>
    </asp:Panel>
    <asp:Panel ID="PanelCheck" runat="server" Visible="false">
        <hr />
        <h3>Pay by Check</h3>
        <small>To send a check for payment, make check payable to:  <b>The Scientific Consulting Group, Inc.</b>
            <br />
            <br />
            Mail check and copy of your registration form to:
        <br />
            <br />
            Susie Warner<br />
            Attn: Battelle Conferences<br />
            The Scientific Consulting Group, Inc.<br />
            656 Quince Orchard Road, Suite 210<br />
            Gaithersburg, MD 20878-1409
            <br />
        </small>
    </asp:Panel>
    <asp:HiddenField ID="hdnNewStart" runat="server" />
    <asp:HiddenField ID="hdnEmail" runat="server" />
</asp:Content>
