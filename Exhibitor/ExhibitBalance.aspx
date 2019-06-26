<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Exhibit.Master" CodeBehind="ExhibitBalance.aspx.vb" Inherits="Battelle.ExhibitBalance" %>

<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=ExhibitorOrSponsor%> Payment Review</h1>
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
            <asp:Parameter Name="FeeTypeID" DefaultValue="13" Type="Int32" />
            <asp:Parameter Name="Amount" Type="Decimal" />
            <asp:Parameter Name="Notes" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter DefaultValue="13" Name="FeeTypeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceItemCount" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerFeeTypeCount" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
            <asp:Parameter DefaultValue="6" Name="FeeTypeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:HiddenField ID="hdnItemCount" runat="server" />

    <asp:Panel ID="PanelProgress" runat="server" Visible="False">
        <div class="progress">
            <asp:Label ID="lblProgress" runat="server" Text=""></asp:Label>
        </div>
    </asp:Panel>
    <asp:Label ID="lblAlert" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Panel ID="PanelInstructions" runat="server">
        Please review the information below to ensure it is correct. If there is an error, please contact Susie Warner at 301-670-4990 for 
        immediate assistance. If all is correct, please select your payment method and click <span class="label label-primary">Next Step >></span>. <br /><br />
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
    <asp:Panel ID="PanelBalance" runat="server" Visible="False">
        <asp:SqlDataSource ID="SqlDataSourceBalance" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerGetTotal" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="gvBalance" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceBalance" CssClass="table" DataKeyNames="SumTotal">
            <Columns>
                <asp:TemplateField HeaderText="TransactionDate" SortExpression="TransactionDate">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTansactionDate" runat="server" Text='<%# Bind("TransactionDate") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblTransactionDate" runat="server" Text='<%# Bind("TransactionDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="FeeType" SortExpression="FeeType">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FeeType") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblFeeType" runat="server" Text='<%# Bind("FeeType") %>'></asp:Label>
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
    <asp:Panel ID="PanelPayment" runat="server">
    Payment Method:
        <asp:RadioButtonList ID="radPayment" runat="server" RepeatDirection="Vertical">
            <asp:ListItem Text=" Credit Card" Value="Credit Card" Selected="True"></asp:ListItem>
            <asp:ListItem Text=" Check/Purchase Order/Electronic Funds Transfer (EFT)" Value="Check" Enabled="true"></asp:ListItem>
        </asp:RadioButtonList>
    <asp:HiddenField ID="hdnNewStart" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="radPayment" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
    <br />
    <br />
    </asp:Panel>
    <asp:Button ID="btnNext" runat="server" Text="Next Step>>" CssClass="btn btn-primary" />

    
</asp:Content>
