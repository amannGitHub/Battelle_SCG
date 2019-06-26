<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BoothLayout.ascx.vb" Inherits="Battelle.BoothLayout" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:SqlDataSource ID="SqlDataSourceBoothLayout" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothLayoutGetByURLString" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:RouteParameter Name="URLString" RouteKey="conference" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceBooths" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothGetByURLString" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:RouteParameter Name="URLString" RouteKey="conference" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblAlert" runat="server" Text="" Visible="False"></asp:Label>
        <div class="boothLayout">
            <asp:Panel ID="PanelForm" runat="server">
                <div class="panel panel-default">
                    <div class="panel-heading" style="color: red">
                        <asp:Label ID="lblInstructions" runat="server" Text="Reserve your booth by clicking on it or using the dropdown list."></asp:Label>
                    </div>
                    <div class="panel-body">
                        <asp:Label ID="lblBooth" runat="server" Text="Selected Booth(s):" AssociatedControlID="selBooth"></asp:Label>
                        <asp:DropDownList ID="selBooth" runat="server" Height="28px" AppendDataBoundItems="True" DataSourceID="SqlDataSourceAvailableBooths" DataTextField="BoothNumber" DataValueField="BoothID" ViewStateMode="Disabled">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="selBooth2" runat="server" Height="28px" AppendDataBoundItems="True" DataSourceID="SqlDataSourceAvailableBooths" DataTextField="BoothNumber" DataValueField="BoothID" ViewStateMode="Disabled">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                        <asp:HiddenField ID="hdnBoothCount" runat="server" />
                        <asp:HiddenField ID="hdnIsland" runat="server" />

                        <asp:Button ID="btnReserve" runat="server" Text="Reserve Booth" CssClass="btn btn-primary btn-sm" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select a booth." ControlToValidate="selBooth" CssClass="text-danger"></asp:RequiredFieldValidator>
                        &nbsp;
                    &nbsp; 
                <asp:LinkButton ID="LinkButtonRefresh" runat="server" CssClass="btn btn-info  btn-sm" CausesValidation="False">Refresh the Booth Layout <span class="glyphicon glyphicon-refresh"></span></asp:LinkButton>
                        <small>
                            <asp:Label ID="lblServerTime" runat="server" Text="Current Server Time: "></asp:Label>
                            <asp:HiddenField ID="hdnVal" runat="server" />
                        </small>
                        <asp:SqlDataSource ID="SqlDataSourceReserve" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothUpdateExhibitor" SelectCommandType="StoredProcedure" UpdateCommand="BoothUpdateExhibitor" UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="ConferenceID" Type="Int32" />
                                <asp:ControlParameter ControlID="hdnVal" Name="ExhibitorID" PropertyName="Value" Type="Int32" />
                                <asp:ControlParameter ControlID="selBooth" Name="BoothID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="selBooth2" Name="BoothID2" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ConferenceID" Type="Int32" />
                                <asp:ControlParameter ControlID="hdnVal" Name="ExhibitorID" PropertyName="Value" Type="Int32" />
                                <asp:ControlParameter ControlID="selBooth" Name="BoothID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="selBooth2" Name="BoothID2" PropertyName="SelectedValue" Type="Int32" />
                                <asp:Parameter Direction="InputOutput" Name="Fail" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceAvailableBooths" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="BoothGetAvailableByURLString" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:RouteParameter Name="URLString" RouteKey="conference" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
                <asp:HiddenField ID="hdnRegType" runat="server" />
            </asp:Panel>
            <asp:Panel ID="pnlBoothMap" runat="server">
                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
            </asp:Panel>
            <asp:Panel ID="pnlLegend" runat="server">
                <div class="legend">
                    <asp:Button ID="btnLegendAvailable" runat="server" Text=" " Visible="false" />
                    <asp:Literal ID="ltlLegendAvailable" runat="server" Visible="false"></asp:Literal>
                    <asp:Literal ID="ltlDoubleBooth" runat="server" Visible="false"></asp:Literal>
                    <asp:Button ID="btnLegendCorner" runat="server" Text=" " Visible="false" />
                    <asp:Literal ID="ltlLegendCorner" runat="server" Visible="false"></asp:Literal>
                    <asp:Button ID="btnLegendPremium" runat="server" Text=" " Visible="false" />
                    <asp:Literal ID="ltlLegendPremium" runat="server" Visible="false"></asp:Literal>
                    <asp:Button ID="btnLegendCornerPremium" runat="server" Text=" " Visible="false" />
                    <asp:Literal ID="ltlLegendCornerPremium" runat="server" Visible="false"></asp:Literal> 
                    <asp:Button ID="btnLegendIsland" runat="server" Text=" " Visible="false" />
                    <asp:Literal ID="ltlLegendIsland" runat="server" Visible="false"></asp:Literal> 
                    <asp:Button ID="btnLegendReserved" runat="server" Text=" " Visible="false" />
                    <asp:Literal ID="ltlLegendReserved" runat="server" Visible="false" Text="<small>Reserved</small>"></asp:Literal>
                    
                </div>
            </asp:Panel>
            <div class="form-group">
                <asp:Button ID="btnShowExhibitors" runat="server" Text="Show Exhibitor List" CssClass="btn btn-primary" />
            </div>
            <asp:SqlDataSource ID="SqlDataSourceBoothFees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceFeeGetForBooth" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="ConferenceID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="btnReserve" />
    </Triggers>
</asp:UpdatePanel>
