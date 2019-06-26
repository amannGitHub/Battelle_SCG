<%@ Page Title="Balance Summary" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="BalanceSummary.aspx.vb" Inherits="Battelle.BalanceSummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
    <asp:SqlDataSource ID="SqlDataSourceReg" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerAttendanceBalanceGet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <h3>Registration:</h3>
    <asp:GridView ID="gvReg" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="PersonID" DataSourceID="SqlDataSourceReg">
        <Columns>
            <asp:BoundField DataField="PersonID" HeaderText="PersonID" InsertVisible="False" ReadOnly="True" SortExpression="PersonID" />
            <asp:BoundField DataField="ParticipationID" HeaderText="ParticipationID" SortExpression="ParticipationID" />
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
            <asp:BoundField DataField="TotalExpenses" HeaderText="TotalExpenses" ReadOnly="True" SortExpression="TotalExpenses" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="AmountPaid" HeaderText="AmountPaid" ReadOnly="True" SortExpression="AmountPaid" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="Balance" HeaderText="Balance" ReadOnly="True" SortExpression="Balance" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="RegistrationType" HeaderText="RegistrationType" SortExpression="RegistrationType" />
        </Columns>
    </asp:GridView>
     <asp:SqlDataSource ID="SqlDataSourceBooth" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerBoothStaffBalanceGet" SelectCommandType="StoredProcedure">
         <SelectParameters>
             <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
         </SelectParameters>
    </asp:SqlDataSource>
    <h3>Exhibitors:</h3>
    <asp:GridView ID="gvBooth" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="PersonID" DataSourceID="SqlDataSourceBooth">
        <Columns>
            <asp:BoundField DataField="PersonID" HeaderText="PersonID" InsertVisible="False" ReadOnly="True" SortExpression="PersonID" />
            <asp:BoundField DataField="ParticipationID" HeaderText="ParticipationID" SortExpression="ParticipationID" />
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
            <asp:BoundField DataField="TotalExpenses" HeaderText="TotalExpenses" ReadOnly="True" SortExpression="TotalExpenses" DataFormatString="{0:c}" />
            <asp:BoundField DataField="AmountPaid" HeaderText="AmountPaid" ReadOnly="True" SortExpression="AmountPaid" DataFormatString="{0:c}" />
            <asp:BoundField DataField="Balance" HeaderText="Balance" ReadOnly="True" SortExpression="Balance" DataFormatString="{0:c}" />
        </Columns>
    </asp:GridView>
     <asp:SqlDataSource ID="SqlDataSourceShortCourse" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerShorCourseBalanceGet" SelectCommandType="StoredProcedure">
         <SelectParameters>
             <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
         </SelectParameters>
    </asp:SqlDataSource>
    <h3>Short Course:</h3>
    <asp:GridView ID="gvShortCourse" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="PersonID" DataSourceID="SqlDataSourceShortCourse">
        <Columns>
            <asp:BoundField DataField="PersonID" HeaderText="PersonID" InsertVisible="False" ReadOnly="True" SortExpression="PersonID" />
            <asp:BoundField DataField="ParticipationID" HeaderText="ParticipationID" SortExpression="ParticipationID" />
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
            <asp:BoundField DataField="TotalExpenses" HeaderText="TotalExpenses" ReadOnly="True" SortExpression="TotalExpenses" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="AmountPaid" HeaderText="AmountPaid" ReadOnly="True" SortExpression="AmountPaid" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="Balance" HeaderText="Balance" ReadOnly="True" SortExpression="Balance" DataFormatString="{0:c}" />
        </Columns>
    </asp:GridView>
</asp:Content>
