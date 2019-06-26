<%@ Control Language="vb" ClassName="WebUserControl" CodeBehind="SearchAbstracts.ascx.vb" Inherits="Battelle.ConferenceFromURL"%>


<div class="form-group">   


    <asp:Panel ID="PanelSearch" runat="server" Visible="True">                            
        <h3>Search Abstracts</h3>
        <div class="input-group">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" MaxLength="500"></asp:TextBox>
            <span class="input-group-btn">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-default"  /></span>
        </div>

        <br />
        <asp:GridView ID="gvSearch" runat="server" CssClass="table" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceSearch1">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <itemtemplate>
                            <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsReviewViewRoute", New With {
                                                        Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>' Target="_blank" />
                    </itemtemplate>
                </asp:TemplateField>
                                  
                <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                <asp:BoundField DataField="Title" HeaderText="Title" HtmlEncode="False" />
                <asp:BoundField DataField="AuthorList" HeaderText="Author List" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceSearch1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractSearchFullText" SelectCommandType="StoredProcedure" >

            <SelectParameters>
                <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String" />
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>

        </asp:SqlDataSource>
    </asp:Panel>

</div>