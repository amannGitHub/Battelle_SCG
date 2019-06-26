<%@ Page Title="Sponsor Logos/Descriptions" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="Sponsors.aspx.vb" Inherits="Battelle.Sponsors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:SqlDataSource ID="SqlDataSourceSponsor" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SponsorGetByConference" SelectCommandType="StoredProcedure" UpdateCommand="SponsorCompanyDescriptionUpdate" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ExhibitorID" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="CompanyDescription" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:GridView ID="gvSponsors" runat="server" DataSourceID="SqlDataSourceSponsor" AutoGenerateColumns="False" Visible="False" AllowSorting="True" CssClass="table" DataKeyNames="ExhibitorID">
                <Columns>
                    <asp:CommandField ShowEditButton="True" EditText="Edit" />
                    <asp:BoundField DataField="SponsorType" HeaderText="Sponsor Type" SortExpression="SponsorType" ReadOnly="True" InsertVisible="False" />
                    <asp:BoundField DataField="Exhibitor" HeaderText="Company" SortExpression="Exhibitor" ReadOnly="True" />
                    <asp:TemplateField HeaderText="POC" SortExpression="LastName">
                        <ItemTemplate>
                            <asp:Label ID="lblFName" runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>&nbsp;<asp:Label ID="lblLName" runat="server" Text='<%# Eval("LastName")%>'></asp:Label>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="File" SortExpression="FileName">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLinkAbstractFile" runat="server" NavigateUrl='<%# String.Format("~/Admin/Exhibit/SponsorFile.aspx?id={0}&conf={2}&name={1}", Eval("ExhibitorID"), Eval("FileName").ToString().Replace("&", "%26"), Eval("ConferenceID"))%>' download='<%# Eval("FileName")%>'><%# Eval("FileName")%></asp:HyperLink>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:FileUpload ID="FileUploadLogo" runat="server" Width="100%" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Size" InsertVisible="False" SortExpression="FileSize">
                        <EditItemTemplate>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("FileSize", "{0:N} mb") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type" InsertVisible="False" SortExpression="ContentType">
                        <EditItemTemplate>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("ContentType") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Upload Date" InsertVisible="False" SortExpression="FileUploadDate">
                        <EditItemTemplate>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("FileUploadDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Company Description" SortExpression="CompanyDescription">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CompanyDescription") %>' TextMode="MultiLine" Rows="8" Columns="50" CssClass="form-control"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("CompanyDescription") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="gvSponsors" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
