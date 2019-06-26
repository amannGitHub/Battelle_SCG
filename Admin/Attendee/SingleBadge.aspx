<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SingleBadge.aspx.vb" Inherits="Battelle.SingleBadge" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="../../Content/BadgeFormat.css"/>
    <title>Print Single Badge</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="PersonID" QueryStringField="id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1">
            <%--Add Print CSS to match single badge printer--%>
            <ItemTemplate>
                <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
                <br />
                <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                <br />
                <asp:Label ID="EmployerLabel" runat="server" Text='<%# Bind("Employer") %>' />
                <br />
                <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />,&nbsp;<asp:Label ID="StateProvinceLabel" runat="server" Text='<%# Bind("StateProvince") %>' />
                <asp:Label ID="CountryLabel" runat="server" Text='<%# Bind("Country") %>' />
                <%--Hide USA?--%>
            </ItemTemplate>
        </asp:FormView>
    
    </div>
    </form>
</body>
</html>
