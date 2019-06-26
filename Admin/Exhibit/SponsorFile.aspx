<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SponsorFile.aspx.vb" Inherits="Battelle.SponsorFile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SponsorFileGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="ExhibitorID" QueryStringField="id" Type="Int32" />
                <asp:QueryStringParameter Name="ConferenceID" QueryStringField="conf" Type="Int32" />
                <asp:QueryStringParameter DefaultValue="" Name="FileName" QueryStringField="name" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblNoFile" runat="server" Text="Unable to retrieve the requested file."></asp:Label>
    </div>
    </form>
</body>
</html>
