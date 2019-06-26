<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="Importer.aspx.vb" Inherits="Battelle.Importer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="ImportAbstract" InsertCommandType="StoredProcedure" SelectCommand="ImportAbstract" SelectCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="txtConferenceID" Name="ConferenceID" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="ImportID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
        </SelectParameters>
    </asp:SqlDataSource>
    Numbers only 
    <br />
    Conference ID:<asp:TextBox ID="txtConferenceID" runat="server"></asp:TextBox>
    <br />
    From (low): <asp:TextBox ID="txtLow" runat="server"></asp:TextBox><br />
    To (high): <asp:TextBox ID="txtHigh" runat="server"></asp:TextBox><br />
    <asp:Button ID="btnImporter" runat="server" Text="Run Importer" />
    <br />
    <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>
</asp:Content>
