<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Payment/Payment.Master" CodeBehind="PaymentConfirm.aspx.vb" Inherits="Battelle.PaymentConfirm" ClientIDMode="Predictable" EnableViewState="False" EnableViewStateMac="False" ViewStateMode="Disabled" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Payment Form</h1>
    <h4>Billing Information</h4>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelFirstNameD" runat="server" Text="First Name:" style="font-weight: 700"></asp:Label><br />
                    <asp:Label ID="LabelFirstName" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelLastNameD" runat="server" Text="Last Name:" style="font-weight: 700"></asp:Label><br />
                    <asp:Label ID="LabelLastName" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelAddressD" runat="server" Text="Address:" style="font-weight: 700"></asp:Label><br />
                    <asp:Label ID="LabelAddress" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelCityD" runat="server" Text="City:" style="font-weight: 700"></asp:Label><br />
                    <asp:Label ID="LabelCity" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelZipD" runat="server" Text="Zip/Postal Code:" style="font-weight: 700"></asp:Label><br />
                    <asp:Label ID="LabelZip" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelStateProvinceD" runat="server" Text="State/Province:" style="font-weight: 700"></asp:Label><br />
                    <asp:Label ID="LabelState" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LabelCountryD" runat="server"  Text="Country:" style="font-weight: 700"></asp:Label><br />
                    <asp:Label ID="LabelCountry" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">

                <asp:Button ID="ButtonGoBack" runat="server" Text="I'd like to change this information." UseSubmitBehavior="False" CssClass="btn btn-default" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <strong>Amount to pay today:</strong>
            US $<asp:Label ID="LabelTransactionAmount" runat="server"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                    <h4>Card information:</h4>
            </div>
        </div>

        <div class="row">
            <div class="col-md-7">
                <div class="form-group"><p>
                        <strong>Card number:</strong></p>
                    <input class="form-control" type="text" id="x_card_num" name="x_card_num" value=""  autocomplete="off"/>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-md-4">
                <div class="form-group"><p>
                        <strong>Card expiration:</strong></p>
                    <input class="form-control" type="text" id="x_exp_date" name="x_exp_date" maxlength="10" value=""  autocomplete="off"/><br />
                    <small>e.g. MM/YYYY</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group"><p>
                        <strong>Card security code:</strong></p>
                    <input class="form-control" type="text" id="x_card_code" name="x_card_code" maxlength="5" value=""  autocomplete="off"/>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-7">
                <div class="form-group"><p>
                        <strong>Email receipt to:</strong></p>
                    <input class="form-control" type="text" id="x_email" name="x_email" maxlength="255" value=""  autocomplete="off"/>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-7">
                <div class="form-group">

<asp:Button ID="ButtonSubmitPayment" runat="server" Text="Submit Payment" ClientIDMode="Static" ViewStateMode="Disabled" CssClass="btn btn-primary" />


                </div>
            </div>
        </div>


    </div>



</asp:Content>
