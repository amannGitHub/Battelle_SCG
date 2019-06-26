<%@ Page Title="Onsite Booth Staff and Tech Reg Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="OnSiteStaffTechRegReport.aspx.vb" Inherits="Battelle.OnSiteStaffTechRegReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSourceExhibitors" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ExhibitorStaffRemainingByConference" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvExhibitor" DataSourceID="SqlDataSourceExhibitors" runat="server" AllowSorting="True" AutoGenerateColumns="True" CssClass="table table-striped" >
    </asp:GridView>

    <br />
    <br />
    <asp:Panel ID="PanelSponsorExhibitorNoBooth" runat="server" Visible="False"> 
    <h2>Sponsor Exhibitors Without Booths</h2>
    <asp:GridView ID="SponsorExhibitorNoBooth" runat="server" AllowSorting="True" AutoGenerateColumns="True" CssClass="table table-striped">
    </asp:GridView>
    </asp:Panel>
</asp:Content>