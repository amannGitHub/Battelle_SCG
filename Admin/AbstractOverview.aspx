<%@ Page Title="Abstract Overview" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="AbstractOverview.aspx.vb" Inherits="Battelle.AbstractOverview" %>

<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%= Page.Title %></h1>

    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>

    <asp:SqlDataSource ID="SqlDataSourceSession" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AdminAbstractOverviewSession" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceAssigned" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AdminAbstractOverviewAssigned" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceReturned" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AdminAbstractOverviewReturned" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <telerik:RadGrid ID ="RadGrid0" runat="server">
        <MasterTableView>
            <ItemTemplate>
                
            </ItemTemplate>
        </MasterTableView>
    </telerik:RadGrid>

    <table> <%--do this to make it look like one big table--%>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSourceSession" AutoGenerateColumns="false" CssClass="table">
                    <RowStyle Height="50px" />
                    <Columns>
                        <asp:BoundField DataField="TopicCode" HeaderText="Session Code" ReadOnly="True" SortExpression="TopicCode" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" /> 
                        <asp:BoundField DataField="SessionName" HeaderText="Session Name" ReadOnly="True" SortExpression="SessionName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" /> 
                        <asp:BoundField DataField="SessionChair1" HeaderText="Session Chair" ReadOnly="True" SortExpression="SessionChair1" HeaderStyle-Wrap="false" ItemStyle-Wrap="false"/> 
                        <asp:BoundField DataField="SessionChair2" HeaderText="Session Chair" ReadOnly="True" SortExpression="SessionChair2" HeaderStyle-Wrap="false" ItemStyle-Wrap="false"/> 
                    </Columns>
                </asp:GridView>
            </td>
            <td>
                <asp:GridView ID="gvAssigned" runat="server" DataSourceID="SqlDataSourceAssigned" AutoGenerateColumns="false" CssClass="table">
                    <RowStyle Height="50px" />
                    <Columns>
                        <asp:BoundField DataField="Assigned" HeaderText="Abstracts Assigned" ReadOnly="True" SortExpression="Assigned" HeaderStyle-Wrap="false" ItemStyle-Wrap="false"/> 
                        <asp:BoundField DataField="FinalAbstracts" HeaderText="Finalized Abstracts" ReadOnly="True" SortExpression="FinalAbstracts" HeaderStyle-Wrap="false" ItemStyle-Wrap="false"/> 
                        <asp:BoundField DataField="NotFinal" HeaderText="Not Finalized Abstracts" ReadOnly="True" SortExpression="NotFinal" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" /> 
                        <asp:BoundField DataField="Poster" HeaderText="Poster" ReadOnly="True" SortExpression="Poster" HeaderStyle-Wrap="false" ItemStyle-Wrap="false"/> 
                        <asp:BoundField DataField="Platform" HeaderText="Platform" ReadOnly="True" SortExpression="Platform" HeaderStyle-Wrap="false" ItemStyle-Wrap="false"/> 
                        <asp:BoundField DataField="PlatformAlternate" HeaderText="Platform Alternate" ReadOnly="True" SortExpression="PlatformAlternate" HeaderStyle-Wrap="false" ItemStyle-Wrap="false"/> 
                    </Columns>
                </asp:GridView>
            </td>
            <td>
                <asp:GridView ID="gvReturnedToProgramChairs" runat="server" DataSourceID="SqlDataSourceReturned" AutoGenerateColumns="false" CssClass="table">
                    <RowStyle Height="50px" />
                    <Columns>
                        <asp:BoundField DataField="Returned" HeaderText="Returned to Program Chairs" ReadOnly="true" SortExpression="Returned" HeaderStyle-Wrap="false" ItemStyle-Wrap="false"/>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    
</asp:Content>