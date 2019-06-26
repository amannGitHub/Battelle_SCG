<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Payment/Payment.Master" CodeBehind="PaymentResult.aspx.vb" Inherits="Battelle.PaymentResult" EnableViewState="False" EnableViewStateMac="False" ViewStateMode="Disabled" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    
    <h1>Payment</h1>
    <asp:Panel ID="PanelPaymentError" runat="server">    <p>&nbsp;</p>
    <p><%= Request("msg")%></p>
    <p>&nbsp;</p>
    <p>Purchase ID: <%= Session("PurchaseID") %></p>
    <p>&nbsp;</p></asp:Panel>

    <asp:Panel ID="PanelPaymentSuccess" runat="server">
        <br />
        Thank you for making your payment. A receipt has been sent to the billing email address specified.<br />
        <br />
        <asp:Literal ID="LiteralGoBackURL" runat="server"><span class="btn btn-primary">View your Confirmation</span></asp:Literal><br /> </asp:Panel>
</asp:Content>
