<%@ Page Title="Person Ledger" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="PersonLedger.aspx.vb" Inherits="Battelle.PersonLedger" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <h1><%=Page.Title%></h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <br />
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <asp:Panel ID="PanelDetails" runat="server" Visible="True">
                            <h3>Attendee Details </h3>
                            <asp:SqlDataSource ID="SqlDataSourceAttendee" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGet" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="PersonID" QueryStringField="pid" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Literal ID="LiteralNameBadge" runat="server"></asp:Literal>
                            <asp:SqlDataSource ID="SqlDataSourceBalance" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerGetTotalAllConferences" SelectCommandType="StoredProcedure" DeleteCommand="ConferenceLedgerDelete" DeleteCommandType="StoredProcedure" InsertCommand="ConferenceLedgerInsert" InsertCommandType="StoredProcedure" UpdateCommand="ConferenceLedgerEdit" UpdateCommandType="StoredProcedure">
                                <DeleteParameters>
                                    <asp:Parameter Name="LedgerID" Type="Int32" />
                                    <asp:Parameter Name="SumTotal" Type="Decimal" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="gvAttendeeList" Name="PersonID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlFeeType" Name="FeeTypeID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="txtAmount" Name="Amount" PropertyName="Text" Type="Decimal" />
                                    <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" Type="String" ConvertEmptyStringToNull="True" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="PersonID" QueryStringField="pid" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="LedgerID" Type="Int32" />
                                    <asp:Parameter Name="Amount" Type="Decimal" />
                                    <asp:Parameter Name="TransactionDate" Type="DateTime" />
                                    <asp:Parameter Name="Notes" Type="String" ConvertEmptyStringToNull="True" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <h4>Ledger</h4>
                            <asp:GridView ID="gvBalance" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceBalance" CssClass="table" DataKeyNames="LedgerID" EmptyDataText='No items recorded in the ledger.'>
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
                                    <asp:BoundField DataField="TransactionDate" HeaderText="TransactionDate" SortExpression="TransactionDate" />
                                    <asp:BoundField DataField="FeeType" HeaderText="FeeType" SortExpression="FeeType" ReadOnly="True" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" DataFormatString="{0:c}" />
                                    <asp:BoundField DataField="ShortName" HeaderText="Conference" SortExpression="ShortName"  />
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
                                            <div style="display: none;">
                                                <asp:Label ID="lblSumTotal" runat="server" Text='<%# Eval("SumTotal")%>'></asp:Label>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                            Total: $<asp:Label ID="lblSumTotal" runat="server" Text="0"></asp:Label><br /></asp:Panel>
                        <asp:Panel ID="PanelAdd" runat="server" Visible="false">
                            <h4>Add Ledger Item</h4>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-7">
                                        <asp:DropDownList ID="ddlFeeType" runat="server" CssClass="form-control" AutoPostBack="True" DataSourceID="SqlDataSourceFeeType" DataTextField="FeeType" DataValueField="FeeTypeID" AppendDataBoundItems="True">
                                            <asp:ListItem Value="" Text=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-5">
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
                            <asp:SqlDataSource ID="SqlDataSourceFeeType" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceFeeTypeGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                            <asp:SqlDataSource ID="SqlDataSourceFee" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceFeeGetByType" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter Name="ConferenceID" Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlFeeType" Name="FeeTypeID" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            </asp:Panel>
                        
                        <asp:Panel ID="PanelLinks" runat="server" Visible="false">
                            <asp:HyperLink ID="lnkBalance" runat="server" Target="_blank">Balance</asp:HyperLink><br />
                            <asp:HyperLink ID="lnkConfirm" runat="server" Target="_blank">View Confirmation</asp:HyperLink><br />
                            <asp:HyperLink ID="lnkBarcode" runat="server" Target="_blank">Barcode Table</asp:HyperLink><br />
                            <br />
                            <asp:HyperLink ID="lnkSendEmail" runat="server" Target="_blank">Send Confirmation Email to Attendee</asp:HyperLink>

                            
                        </asp:Panel>
                    </div>
                </div>
            </div>
            <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>




        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        /* This Script is used to maintain Grid Scroll on Partial Postback */
        var scrollTop;
        /* Register Begin Request and End Request */
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        /* Get The Div Scroll Position */
        function BeginRequestHandler(sender, args) {
            var m = document.getElementById('divGrid');
            scrollTop = m.scrollTop;
        }
        /* Set The Div Scroll Position */
        function EndRequestHandler(sender, args) {
            var m = document.getElementById('divGrid');
            m.scrollTop = scrollTop;
        }
    </script>
</asp:Content>

