<%@ Page Title="Exhibitor & Sponsor Ledgers" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="List.aspx.vb" Inherits="Battelle.ExhibitorLists" MaintainScrollPositionOnPostback="true" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <div class="container">
                <div class="row">
                    <div class="col-md-7">
                        <div id="divGrid" style="width: 100%; height: 600px; overflow: auto;">
                            <asp:SqlDataSource ID="SqlDataSourceExhibitors" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ExhibitorGetByConference" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvExhibList" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceExhibitors" AutoGenerateColumns="False" Visible="False" CssClass="table" DataKeyNames="PersonID" SelectedRowStyle-CssClass="active">
                                <HeaderStyle CssClass="HeaderFreeze" />
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" SelectText="<span class='glyphicon glyphicon-eye-open'></span>"  />
                                    <asp:BoundField DataField="Exhibitor" HeaderText="Exhibitor" SortExpression="Exhibitor" />
                                    
                                    <asp:TemplateField HeaderText="POC" SortExpression="LastName">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFName" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>&nbsp;
                                            <asp:Label ID="lblLName" runat="server" Text='<%# Bind("LastName")%>'></asp:Label>
                                            <asp:Label ID="lblPartID" runat="server" Text='<%# Bind("ParticipationID")%>'></asp:Label>
                                            <div style="display: none">
                                                <asp:Label ID="lblPersonID" runat="server" Text='<%# Bind("PersonID")%>'></asp:Label>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ExhibBalance" HeaderText="Balance" ReadOnly="True" SortExpression="ExhibBalance" DataFormatString="{0:c}" />
                                    <asp:BoundField DataField="BoothNumber" HeaderText="Booth Number" SortExpression="BoothNumber" />
                                    <asp:BoundField DataField="StaffCount" HeaderText="Staff Count" SortExpression="StaffCount" />
                                    <asp:BoundField DataField="SponsorType" HeaderText="Sponsor" SortExpression="SponsorType" />
                                </Columns>
                                <SelectedRowStyle CssClass="info" />
                            </asp:GridView>
                        </div>
                        <asp:LinkButton ID="lnkRefresh" runat="server"><span class="glyphicon glyphicon-refresh"></span></asp:LinkButton>
                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh Exhibitor List" AssociatedControlID="lnkRefresh"></asp:Label>
                        <asp:Panel ID="PanelPOC" runat="server" Visible="False">
                            <h3>Point of Contact</h3>
                            <asp:SqlDataSource ID="SqlDataSourcePOC" runat="server"></asp:SqlDataSource>
                            <asp:FormView ID="FormViewPOC" runat="server"></asp:FormView>
                            <asp:LinkButton ID="LinkButton1" runat="server">Change POC</asp:LinkButton>
                        </asp:Panel>
                        <asp:Panel ID="PanelNewPOC" runat="server" Visible="False">
                            <div class="form-group">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <h3>New POC</h3>
                                            <asp:Label ID="lblEnterEmail" runat="server" Text="Enter POC email address to make them the POC. This will take effect immediately." AssociatedControlID="TextBoxEmail"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="form-control" ValidationGroup="EmailValidate"></asp:TextBox>
                                                <span class="input-group-btn">
                                                    <asp:Button ID="ButtonCheckEmail" runat="server" Text="Go" CssClass="btn btn-default" ValidationGroup="EmailValidate" /></span>
                                            </div>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="Please enter a valid email." ControlToValidate="TextBoxEmail" ValidationGroup="EmailValidate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Label ID="LabelCheckEmailResult" runat="server" Text=""></asp:Label><br />
                                            <br />
                                            <asp:Button ID="ButtonPersonEmptyInsert" runat="server" Text="New User" CssClass="btn btn-primary" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="col-md-5">
                        <asp:Panel ID="PanelDetails" runat="server" Visible="False">
                            <h3>Exhibitor Details <small>
                                <asp:LinkButton ID="LinkButtonHide" runat="server">Hide</asp:LinkButton></small></h3>
                            <asp:SqlDataSource ID="SqlDataSourceBalance" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceLedgerGetTotal" SelectCommandType="StoredProcedure" DeleteCommand="ConferenceLedgerDelete" DeleteCommandType="StoredProcedure" InsertCommand="ConferenceLedgerInsert" InsertCommandType="StoredProcedure" UpdateCommand="ConferenceLedgerEdit" UpdateCommandType="StoredProcedure">
                                <DeleteParameters>
                                    <asp:Parameter Name="LedgerID" Type="Int32" />
                                    <asp:Parameter Name="SumTotal" Type="Decimal" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="gvExhibList" Name="PersonID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlFeeType" Name="FeeTypeID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="txtAmount" Name="Amount" PropertyName="Text" Type="Decimal" />
                                    <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" Type="String" ConvertEmptyStringToNull="True" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvExhibList" Name="PersonID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
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

                            Total: $<asp:Label ID="lblSumTotal" runat="server" Text="0"></asp:Label><br />
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
                            Current Session: <i><asp:Label ID="lblSession" runat="server" Text="None - Copy Participant Code or select different Exhibitor"></asp:Label></i>&nbsp;<asp:LinkButton ID="lnkbtnSession" runat="server" Visible="False">Clear Session</asp:LinkButton><br />
                            <asp:HyperLink ID="lnkStaff" runat="server" Target="_blank">Staff</asp:HyperLink><br />
                            <asp:HyperLink ID="lnkBalance" runat="server" Target="_blank">Balance</asp:HyperLink><br />
                            <asp:HyperLink ID="lnkConfirm" runat="server" Target="_blank">View <b>Exhibitor</b> Booth Reservation Confirmation</asp:HyperLink><br />OR<br />
                            <asp:HyperLink ID="linkSponsorRegConfirm" runat="server" Target="_blank">View <b>Sponsor</b> Registration Confirmation</asp:HyperLink><br />
                            <br />
                            <asp:HyperLink ID="lnkSendEmail" runat="server" Target="_blank">Send Booth Confirmation Email to Exhibitor/Sponsor</asp:HyperLink><br />
                            <asp:HyperLink ID="lnkSendSponsorRegEmail" runat="server" Target="_blank">Send Sponsor Registration Email to Sponsor</asp:HyperLink>
  
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
