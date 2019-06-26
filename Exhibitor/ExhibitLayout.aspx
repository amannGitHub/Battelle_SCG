<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Exhibitor/Exhibit.Master" CodeBehind="ExhibitLayout.aspx.vb" Inherits="Battelle.ExhibitLayout" %>

<%@ Register Src="~/Exhibitor/BoothLayout.ascx" TagPrefix="uc1" TagName="BoothLayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <uc1:BoothLayout runat="server" ID="BoothLayout" /><br />
    
</asp:Content>

