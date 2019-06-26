<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Payment/Payment.Master" CodeBehind="Payment.aspx.vb" Inherits="Battelle.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [CountryName] FROM [LookupCountry] Order By [ListOrder]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT StateProvinceName, StateProvinceAbbreviation as StateProvince FROM LookupStateProvince ORDER BY StateProvinceName"></asp:SqlDataSource>
    <h1>Payment Form</h1>
    <h4>Billing Information</h4>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelFirstName" runat="server" AssociatedControlID="TextBoxFirstName" Text="First name:"></asp:Label><br />
                    <asp:TextBox ID="TextBoxFirstName" runat="server" MaxLength="50" ValidationGroup="pmt" CssClass="form-control" AutoCompleteType="FirstName"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirstName" runat="server" ErrorMessage="Please provide the first name associated with the card you will use." ControlToValidate="TextBoxFirstName" Display="None" ValidationGroup="pmt"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelLastName" runat="server" AssociatedControlID="TextBoxLastName" Text="Last name:"></asp:Label><br />
                    <asp:TextBox ID="TextBoxLastName" runat="server" MaxLength="50" ValidationGroup="pmt" CssClass="form-control" AutoCompleteType="LastName"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorLastName" runat="server" ErrorMessage="Please provide the last name associated with the card you will use." ControlToValidate="TextBoxLastName" Display="None" ValidationGroup="pmt"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelAddress" runat="server" AssociatedControlID="TextBoxAddress" Text="Address:"></asp:Label><br />
                    <asp:TextBox ID="TextBoxAddress" runat="server" MaxLength="60" ValidationGroup="pmt" CssClass="form-control" AutoCompleteType="BusinessStreetAddress"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorAddress" runat="server" ErrorMessage="Please provide the address associated with the card you will use." ControlToValidate="TextBoxAddress" Display="None" ValidationGroup="pmt"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelCity" runat="server" AssociatedControlID="TextBoxCity" Text="City:"></asp:Label><br />
                    <asp:TextBox ID="TextBoxCity" runat="server" MaxLength="40" ValidationGroup="pmt" CssClass="form-control" AutoCompleteType="BusinessCity"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorCity" runat="server" ErrorMessage="Please provide the city associated with the card you will use." ControlToValidate="TextBoxCity" Display="None" ValidationGroup="pmt"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelZip" runat="server" AssociatedControlID="TextBoxZip" Text="Zip/Postal Code:"></asp:Label><br />
                    <asp:TextBox ID="TextBoxZip" runat="server" MaxLength="20" CssClass="form-control" AutoCompleteType="BusinessZipCode"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorZip" runat="server" ErrorMessage="Please provide the postal (zip) code associated with the card you will use." ControlToValidate="TextBoxZip" Display="None" ValidationGroup="pmt"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelStateProvince" runat="server" AssociatedControlID="StateProvinceDropDownList" Text="State/Province:"></asp:Label><br />
                    <asp:DropDownList ID="StateProvinceDropDownList" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="SqlDataSourceLookupStateProvince" DataTextField="StateProvinceName" DataValueField="StateProvince" OnPreRender="HtmlDecode_PreRender">
                        <asp:ListItem Selected="True" Value="NA">N/A</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelCountry" runat="server" AssociatedControlID="CountryDropDownList" Text="Country:"></asp:Label><br />
                    <asp:DropDownList ID="CountryDropDownList" runat="server" AppendDataBoundItems="False" DataSourceID="SqlDataSourceLookupCountry" DataTextField="CountryName" DataValueField="CountryName" CssClass="form-control" OnPreRender="HtmlDecode_PreRender">
                        <asp:ListItem Selected="True" Value=" ">Please select your country</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">

                <asp:ValidationSummary ID="PaymentValidationSummary" runat="server" ValidationGroup="pmt" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                Amount to pay today:
            US $<asp:Label ID="LabelTransactionAmount" runat="server"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                On the next page, you will be able to confirm the information above is entered correctly, and enter your card information.
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <asp:Button ID="ButtonConfirm" runat="server" Text="Confirm payment and provide card information" ValidationGroup="pmt" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
