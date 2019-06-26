<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Error.aspx.vb" Inherits="Battelle._Error" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    A system error has occurred. The webmaster has been notified. If you require technical assistance, please email Justin Kaufman at <asp:HyperLink ID="lnkEmailHelp" runat="server" NavigateUrl="mailto:jkaufman@scgcorp.com" Text="jkaufman@scgcorp.com"></asp:HyperLink>.<br /><br />
    If you are getting recurring errors, please close your browser and try again, or try using a different browser.<br /><br />
        <asp:Panel ID="pnlError" runat="server" Visible="False">
            <b></b><br />
            <div class="panel panel-default">
              <div class="panel-heading">Error details</div>
              <div class="panel-body">
                <asp:Literal ID="ltlErrorMessage" runat="server"></asp:Literal>
              </div>
            </div>
            
        </asp:Panel>

</asp:Content>
