<%@ Page Title="Ledger By POC"Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="LedgerByPOC.aspx.vb" Inherits="Battelle.LedgerByPOC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceParticipant" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT LastName + ', ' + FirstName + ' - ' + Employer AS FullName, PersonID, ParticipationID FROM Person WHERE PersonArchive = 0"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceFee" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceFeeGetByType" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlFeeType" Name="FeeTypeID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceFeeType" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceFeeTypeGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourcePOC" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="LedgerGetByPOC" SelectCommandType="StoredProcedure" DeleteCommand="ConferenceLedgerDelete" DeleteCommandType="StoredProcedure" InsertCommand="ConferenceLedgerInsert" InsertCommandType="StoredProcedure" UpdateCommand="ConferenceLedgerEdit" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblPersonID" Name="PersonID" PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="LedgerID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="lblPersonID" Name="PersonID" PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlFeeType" Name="FeeTypeID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="txtAmount" Name="Amount" PropertyName="Text" Type="Decimal" />
                    <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" Type="String" ConvertEmptyStringToNull="True" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Amount" Type="Decimal" />
                    <asp:Parameter Name="TransactionDate" Type="DateTime" />
                    <asp:Parameter Name="Notes" Type="String" ConvertEmptyStringToNull="True" />
                    <%--<asp:Parameter Name="LedgerID" Type="Int32" />--%>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblPerson" runat="server" Text="Search People:&nbsp;"></asp:Label>
            <telerik:RadAutoCompleteBox ID="txtPersonLookup" runat="server" DataSourceID="SqlDataSourceParticipant" DataTextField="FullName" InputType="Token" Width="400" DropDownWidth="400"></telerik:RadAutoCompleteBox>
            <asp:Button ID="btnLedgerLookup" runat="server" Text="Find Ledgers"/>
            <asp:Label ID="lblPersonID" runat="server" Visible="false"></asp:Label>
            <br />
            <br />
            <asp:Label ID="lblName" runat="server" Visible="true"></asp:Label>
            <asp:Label ID="lblBalance" runat="server" Visible="true"></asp:Label>
            <div class="container">
                <div class="row">
                    <div class="col-md-6" style="width:70%; padding:0px;">
                        <div id="divGrid" style="width: 100%; height: 600px; overflow: auto;">                            
                            <asp:GridView ID="gvLedgers" runat="server" AllowSorting="true" DataSourceID="SqlDataSourcePOC" AutoGenerateColumns="false" Visible="True" CssClass="table" DataKeyNames="LedgerID" SelectedRowStyle-CssClass="active">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButtonEdit" runat="server" CausesValidation="False" CommandName="Edit"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButtonUpdate" runat="server" CausesValidation="False" CommandName="Update"><span class="glyphicon glyphicon-ok"></span></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButtonCancel" runat="server" CausesValidation="False" CommandName="Cancel"><span class="glyphicon glyphicon-remove"></span></asp:LinkButton>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="LedgerID" HeaderText="Ledger ID" SortExpression="LedgerID" ReadOnly="true" />
                                    <asp:BoundField DataField="Exhibitor" HeaderText="Exhibitor" SortExpression="Exhibitor" ReadOnly="true"/>
                                    <asp:BoundField DataField="Conference" HeaderText="Conference" SortExpression="Conference" ReadOnly="true"/>
                                    <asp:BoundField DataField="TransactionDate" HeaderText="TransactionDate" SortExpression="TransactionDate" />
                                    <asp:BoundField DataField="FeeType" HeaderText="FeeType" SortExpression="FeeType" ReadOnly="True" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" DataFormatString="{0:c}" />
                                    <asp:TemplateField HeaderText="Notes">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Notes") %>' TextMode="MultiLine" Rows="5"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Notes") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="small" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButtonDelete" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?');"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <asp:Panel ID="pnlAddItem" runat="server" Visible="false">
                        <div class="col-md-6" style="width: 30%;">
                            <h3 style="margin-top: 0px;">Add Ledger Item</h3>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8" style="width: 100%;">
                                        <asp:DropDownList ID="ddlFeeType" runat="server" CssClass="form-control" AutoPostBack="True" DataSourceID="SqlDataSourceFeeType" DataTextField="FeeType" DataValueField="FeeTypeID" AppendDataBoundItems="True">
                                                <asp:ListItem Value="" Text=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>                                
                                </div>
                                <div class="row" style="margin-top: 15px">
                                    <div class="col-md-6">
                                        <asp:DropDownList ID="ddlConfList" runat="server" CssClass="form-control" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                                            <asp:ListItem Value="" Text=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-6" style="padding-left: 0px;">
                                        <div class="input-group">
                                            <span class="input-group-addon">$</span>
                                            <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control"></asp:TextBox>
                                            <span class="input-group-btn">
                                                <asp:Button ID="btnAddAmount" runat="server" Text="Add" CssClass="btn btn-default" />
                                            </span>
                                        </div>
                                    </div>                                
                                </div>
                                <asp:Label ID="lblNotes" runat="server" Text="Notes:" AssociatedControlID="txtNotes"></asp:Label><br />
                                <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>
                                <div class="alert alert-warning" role="alert">Don't forget payments (check/credit card) are negative amounts!</div>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
