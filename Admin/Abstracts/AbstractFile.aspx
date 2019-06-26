<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AbstractFile.aspx.vb" Inherits="Battelle.AbstractFile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractFileGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="AbstractID" QueryStringField="id" Type="Int32" />
                <asp:QueryStringParameter DefaultValue="" Name="AbstractFileName" QueryStringField="name" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblNoFile" runat="server" Text="Unable to retrieve the requested file."></asp:Label>
    </div>
    </form>
</body>
</html>
