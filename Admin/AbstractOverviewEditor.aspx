<%@ Page Title="Abstract Review Placement Editor" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="AbstractOverviewEditor.aspx.vb" Inherits="Battelle.AbstractOverviewEditor" %>

<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%= Page.Title %></h1>
    <asp:UpdatePanel ID="UpdatePanel1"  runat="server">
        <ContentTemplate>


            <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>

            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <asp:Image ImageUrl="~/images/ajax-loader.gif" runat="server" />
                </ProgressTemplate>
            </asp:UpdateProgress>

            <asp:SqlDataSource ID="SqlDataSourceAbstracts" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractOverviewGet" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceTopicGroup" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="TopicGroupGet" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSession" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SessionGetByTopic" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="TopicGroupID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            

            <asp:GridView ID="gvAbstracts" runat="server" DataSourceID="SqlDataSourceAbstracts" OnRowDataBound="gvAbstracts_RowDataBound" AutoGenerateColumns="False" CssClass="table" AllowSorting="True" AllowPaging="True" PageSize="100">
                <Columns>
                    <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" ReadOnly="True" SortExpression="AbstractCode" />
                    <asp:BoundField DataField="ActiveType" HeaderText="Level of Current Review" ReadOnly="True" SortExpression="ActiveType" />
                    <asp:BoundField DataField="AcceptedType" HeaderText="Level of Last Finalized Review" ReadOnly="True" SortExpression="AcceptedType" />
                    <asp:BoundField DataField="TopicGroupCode" HeaderText="Last Final Theme" ReadOnly="True" SortExpression="TopicGroupCode" />
                    <asp:BoundField DataField="TopicCode" HeaderText="Last Final Topic Code" ReadOnly="True" SortExpression="TopicCode" />
                    <asp:BoundField DataField="TopicCode" HeaderText="Last Final Topic Code" ReadOnly="True" SortExpression="TopicCode" />
                    <asp:BoundField DataField="FinalFormat" HeaderText="Format" ReadOnly="True" SortExpression="FinalFormat" />
                    <asp:BoundField DataField="SessionCode" HeaderText="Last Final Session Code" ReadOnly="True" SortExpression="SessionCode" />
                    <asp:TemplateField AccessibleHeaderText="Unfinalize" HeaderText="Unfinalize">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnEdit" OnClick="btnEdit_Click" runat="server" ImageUrl="~/images/unlockbutton40x40.png" ToolTip="Unfinalize Abstract" />
                            <asp:HiddenField ID="hdnAbstractID" Value='<%# Bind("AbstractID")%>' runat="server" />
                            <asp:HiddenField ID="hdnAbstractReviewID" Value='<%# Bind("AbstractReviewID")%>' runat="server" />
                            <asp:HiddenField ID="hdnActiveTypeID" Value='<%# Bind("ActiveTypeID")%>' runat="server" />
                            <asp:HiddenField ID="hdnAcceptedTypeID" Value='<%# Bind("AcceptedTypeID")%>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>

                            <asp:DropDownList ID="ddlReviewType" AutoPostBack="True" OnSelectedIndexChanged="ddlReviewType_SelectedIndexChanged" runat="server">
                                <asp:ListItem Value="3" Text="Program Chair"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Steering Committee"></asp:ListItem>
                                <asp:ListItem Value="2" Text="Session Chair"></asp:ListItem>
                                <asp:ListItem Value="5" Text="Finalize for Conference"></asp:ListItem>
                            </asp:DropDownList><br />
                            <asp:DropDownList ID="ddlTopic" runat="server" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlTopic_SelectedIndexChanged">
                                <asp:ListItem Value=""></asp:ListItem>
                            </asp:DropDownList><br />
                            <asp:DropDownList ID="ddlSession" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="SessionID" AppendDataBoundItems="True" Enabled="false">
                                <asp:ListItem Value=""></asp:ListItem>
                            </asp:DropDownList><br />
                            <asp:DropDownList ID="ddlFormat" runat="server">
                                <asp:ListItem Value="" Text="Select a format"></asp:ListItem>
                                <asp:ListItem Value="platform" Text="Platform"></asp:ListItem>
                                <asp:ListItem Value="poster" Text="Poster"></asp:ListItem>
                                <asp:ListItem Value="platform alternate A" Text="Platform Alternate A"></asp:ListItem>
                                <asp:ListItem Value="platform alternate B" Text="Platform Alternate B"></asp:ListItem>
                                <asp:ListItem Value="platform alternate C" Text="Platform Alternate C"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtComments" placeholder="Comments"  runat="server"></asp:TextBox><br />
                            <asp:Button ID="btnReview" Text="Place" OnClick="btnReview_Click" runat="server" />
                            <%--<asp:CheckBox ID="chkFinal" runat="server" Text="Finalize" />&nbsp;--%>
                            <asp:CheckBox ID="chkDecline" runat="server" Text="Decline for Conference" />                            
                            <asp:HiddenField ID="hdnAbstractCode" Value='<%# Bind("AbstractCode")%>' runat="server" />
                            <asp:HiddenField ID="hdnSessionID" Value='<%# Bind("SessionID")%>' runat="server" />
                            <asp:HiddenField ID="hdnConferenceID" Value='<%# Bind("ConferenceID")%>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerSettings Mode="NumericFirstLast" />
                <PagerStyle CssClass="numericButtonCSS" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
