<%@ Page Title="Organization Info" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="OrganizationInfo.aspx.vb" Inherits="Battelle.OrganizationInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title %></h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceExhibitor" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Exhibitor, OrganizationID, POCPersonID FROM Exhibitor"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourcePOC" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT ParticipationID, LastName + ', ' + FirstName AS FullName, PhoneNum, CellNum, AddressLine1, AddressLine2, AddressLine3, City, StateProvince, ZipPostal, Country FROM Person WHERE PersonID=@PersonID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblPersonID" Name="PersonID" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <telerik:RadAutoCompleteBox ID="txtExhibitorLookup" runat="server" DataSourceID="SqlDataSourceExhibitor" DataTextField="Exhibitor" InputType="Token" Width="400" DropDownWidth="400"></telerik:RadAutoCompleteBox>
            <asp:Button ID="btnExhibitorLookup" runat="server" Text="Get Info" />
            <br />
            <asp:Label ID="lblOrgID" runat="server" Visible="true" Text="OrganizationID:"></asp:Label>
            <asp:Label ID="lblPersonID" runat="server" Visible="false"></asp:Label>
            <div class="container" style="margin-top: 15px;">
                <div class="row">
                    <div class="col-md-6" style="width: 100%">
                        <asp:GridView ID="gvPOC" runat="server" AllowSorting="true" DataSourceID="SqlDataSourcePOC" AutoGenerateColumns="false" CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="FullName" HeaderText="POC Name" SortExpression="Name" />
                                <asp:BoundField DataField="ParticipationID" HeaderText="ParticipationID" SortExpression="ParticipationID" />
                                <asp:BoundField DataField="PhoneNum" HeaderText="Phone Number" SortExpression="PhoneNum" />
                                <asp:BoundField DataField="CellNum" HeaderText="Cell Number" SortExpression="CellNum" />
                                <asp:BoundField DataField="AddressLine1" HeaderText="Address Line 1" SortExpression="AddressLine1" />
                                <asp:BoundField DataField="AddressLine2" HeaderText="Address Line 2" SortExpression="AddressLine2" />
                                <asp:BoundField DataField="AddressLine3" HeaderText="Address Line 3" SortExpression="AddressLine3" />
                                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                                <asp:BoundField DataField="StateProvince" HeaderText="State/Province" SortExpression="StateProvince" />
                                <asp:BoundField DataField="ZipPostal" HeaderText="Zip" SortExpression="ZipPostal" />
                                <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
                            </Columns>                            
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>