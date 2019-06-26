<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExhibitorList.aspx.vb" Inherits="Battelle.ExhibitorList" %>

<%@ Register Src="~/ConferenceFromURL.ascx" TagPrefix="uc1" TagName="ConferenceFromURL" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Exhibitor List</title>
    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
</head>
<body class="popup">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <%--To learn more about bundling scripts in ScriptManager see http://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Framework Scripts--%>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="bootstrap" />
                <asp:ScriptReference Name="respond" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
                <%--Site Scripts--%>
            </Scripts>
        </asp:ScriptManager>

        <uc1:ConferenceFromURL runat="server" ID="ConferenceFromURL" Visible="false" />
        <asp:SqlDataSource ID="SqlDataSourceExhibList" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothReservationsGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <div class="panel panel-default">
            <div class="panel-heading">Exhibitor List</div>
          <div class="panel-body">
            You may sort the list by either Exhibitor Name or Booth Number.
          </div>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="table-striped" DataSourceID="SqlDataSourceExhibList" Width="100%">
            <Columns>
                <asp:BoundField DataField="Exhibitor" HeaderText="Exhibitor Name" SortExpression="Exhibitor" />
                <asp:BoundField DataField="BoothNumber" HeaderText="Booth Number" SortExpression="BoothNumber" />
            </Columns>
        </asp:GridView>
            </div>

    </form>
</body>
</html>
