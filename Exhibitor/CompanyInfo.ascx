<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CompanyInfo.ascx.vb" Inherits="Battelle.CompanyInfo" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Button ID="btnContactInfo" runat="server" Text="Use Point of Contact Information" CssClass="btn btn-warning" Visible="False" />
        <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="ExhibitorInsert" InsertCommandType="StoredProcedure" SelectCommand="ExhibitorGetByPersonID" SelectCommandType="StoredProcedure" UpdateCommand="ExhibitorUpdate" UpdateCommandType="StoredProcedure">
            <InsertParameters>
                <asp:ControlParameter ControlID="hdnVal" Name="PersonID" PropertyName="Value" Type="Int32" />
                <asp:Parameter Name="Exhibitor" Type="String" />
                <asp:Parameter Name="AddressLine1" Type="String" />
                <asp:Parameter Name="AddressLine2" Type="String" />
                <asp:Parameter Name="AddressLine3" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="StateProvince" Type="String" />
                <asp:Parameter Name="ZipPostal" Type="String" />
                <asp:Parameter Name="Country" Type="String" />
                <asp:Parameter Direction="InputOutput" Name="ExhibitorID" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnVal" Name="PersonID" PropertyName="Value" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="hdnVal" Name="PersonID" PropertyName="Value" Type="Int32" />
                <asp:Parameter Name="Exhibitor" Type="String" />
                <asp:Parameter Name="OrganizationID" Type="String" />
                <asp:Parameter Name="AddressLine1" Type="String" />
                <asp:Parameter Name="AddressLine2" Type="String" />
                <asp:Parameter Name="AddressLine3" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="StateProvince" Type="String" />
                <asp:Parameter Name="ZipPostal" Type="String" />
                <asp:Parameter Name="Country" Type="String" />
                <asp:Parameter Name="ExhibitorID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hdnVal" runat="server" />
        <asp:HiddenField ID="hdnCom" runat="server" />
        <asp:SqlDataSource ID="SqlDataSourceLookupCountry" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [CountryName], [CountryCode] FROM [LookupCountry] Order By [ListOrder]"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceLookupStateProvince" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT     LookupStateProvince.StateProvinceAbbreviation, (LookupStateProvince.StateProvinceName + ' (' + LookupStateProvince.CountryCode + ')') as ListStateProvinceName
FROM         LookupStateProvince LEFT OUTER JOIN
                      LookupCountry ON LookupStateProvince.CountryCode = LookupCountry.CountryCode
ORDER BY LookupCountry.ListOrder, LookupStateProvince.StateProvinceName"></asp:SqlDataSource>
        <asp:FormView ID="FormViewCompany" runat="server" DataKeyNames="ExhibitorID" DataSourceID="SqlDataSourceCompany" RenderOuterTable="False">
            <EditItemTemplate>
                <div class="form-group">



                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <span style="font-weight:bold; color:red;"><b>ORGANIZATION ID:</b> 
                                <asp:Label ID="lblOrgIDValue" runat="server"  Text='<%# Bind("OrganizationID")%>'></asp:Label></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <span style="font-weight:bold; color:red;">Your Organization ID is required when registering booth staff, discounted, or waived technical registrations. Please ensure the person responsible for these tasks has access to the ID number.</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblCompanyName" runat="server" Text="Organization:" AssociatedControlID="txtCompanyName"></asp:Label>
                                <i>(as it will appear on booth I.D. sign)</i><br />
                                <asp:TextBox ID="txtCompanyName" runat="server" Text='<%# Bind("Exhibitor")%>' CssClass="form-control" OnInit="txtCompanyName_Init"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Label ID="lblAddress1" runat="server" Text="*Mailing/Postal Address" AssociatedControlID="AddressLine1TextBox"></asp:Label>
                                    <asp:TextBox ID="AddressLine1TextBox" runat="server" Text='<%# Bind("AddressLine1") %>' CssClass="form-control" />

                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="AddressLine2TextBox" runat="server" Text='<%# Bind("AddressLine2") %>' CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="AddressLine3TextBox" runat="server" Text='<%# Bind("AddressLine3") %>' CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblCity" runat="server" Text="*City" AssociatedControlID="CityTextBox"></asp:Label><br />
                                    <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' CssClass="form-control" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblStateProv" runat="server" Text="State/Province" AssociatedControlID="StateProvinceDropDownList"></asp:Label><br />
                                    <asp:DropDownList ID="StateProvinceDropDownList" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="SqlDataSourceLookupStateProvince" DataTextField="ListStateProvinceName" DataValueField="StateProvinceAbbreviation" OnPreRender="HTMLDecode_PreRender" SelectedValue='<%# Bind("StateProvince")%>'>
                                        <asp:ListItem Selected="True" Value="NA">N/A</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">

                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblZipPostal" runat="server" Text="Zip/Postal Code" AssociatedControlID="ZipPostalTextBox"></asp:Label><br />
                                    <asp:TextBox ID="ZipPostalTextBox" runat="server" Text='<%# Bind("ZipPostal") %>' CssClass="form-control" />

                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblCountry" runat="server" Text="*Country" AssociatedControlID="CountryDropDownList"></asp:Label><br />
                                    <asp:DropDownList ID="CountryDropDownList" runat="server" AppendDataBoundItems="False" DataSourceID="SqlDataSourceLookupCountry" DataTextField="CountryName" DataValueField="CountryName" CssClass="form-control" OnPreRender="HTMLDecode_PreRender" SelectedValue='<%# Bind("Country") %>'>
                                        <asp:ListItem Selected="True" Value=" ">Please select your country</asp:ListItem>
                                    </asp:DropDownList>

                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Label ID="LabelDataValidationSummary" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="ButtonUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Update my information" CssClass="btn btn-success" />
                                <asp:Button ID="ButtonUpdateCanel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                            </div>
                        </div>
                    </div>

                </div>
            </EditItemTemplate>
            <InsertItemTemplate>
                <div class="form-group">



                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblCompanyName" runat="server" Text="Organization:" AssociatedControlID="txtCompanyName"></asp:Label>
                                <i>(as it will appear on booth I.D. sign)</i><br />
                                <asp:TextBox ID="txtCompanyName" runat="server" Text='<%# Bind("Exhibitor")%>' CssClass="form-control" OnInit="txtCompanyName_Init"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Label ID="lblAddress1" runat="server" Text="*Mailing/Postal Address" AssociatedControlID="AddressLine1TextBox"></asp:Label>
                                    <asp:TextBox ID="AddressLine1TextBox" runat="server" Text='<%# Bind("AddressLine1") %>' CssClass="form-control" />

                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="AddressLine2TextBox" runat="server" Text='<%# Bind("AddressLine2") %>' CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="AddressLine3TextBox" runat="server" Text='<%# Bind("AddressLine3") %>' CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblCity" runat="server" Text="*City" AssociatedControlID="CityTextBox"></asp:Label><br />
                                    <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblStateProv" runat="server" Text="State/Province" AssociatedControlID="StateProvinceDropDownList"></asp:Label><br />
                                     <asp:DropDownList ID="StateProvinceDropDownList" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="SqlDataSourceLookupStateProvince" DataTextField="ListStateProvinceName" DataValueField="StateProvinceAbbreviation" OnPreRender="HTMLDecode_PreRender" SelectedValue='<%# Bind("StateProvince")%>'>
                                        <asp:ListItem Selected="True" Value="NA">N/A</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblZipPostal" runat="server" Text="Zip/Postal Code" AssociatedControlID="ZipPostalTextBox"></asp:Label><br />
                                    <asp:TextBox ID="ZipPostalTextBox" runat="server" Text='<%# Bind("ZipPostal") %>' CssClass="form-control" />

                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="lblCountry" runat="server" Text="*Country" AssociatedControlID="CountryDropDownList"></asp:Label><br />
                                    <asp:DropDownList ID="CountryDropDownList" runat="server" AppendDataBoundItems="False" DataSourceID="SqlDataSourceLookupCountry" DataTextField="CountryName" DataValueField="CountryName" CssClass="form-control" OnPreRender="HTMLDecode_PreRender" SelectedValue='<%# Bind("Country") %>'>
                                        <asp:ListItem Selected="True" Value=" ">Please select your country</asp:ListItem>
                                    </asp:DropDownList>

                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Label ID="LabelDataValidationSummary" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <asp:Button ID="ButtonInsert" runat="server" CausesValidation="True" CommandName="Insert" Text="Submit Company Information" CssClass="btn btn-success" />
                            </div>
                        </div>
                    </div>

                </div>
            </InsertItemTemplate>
            <ItemTemplate>


                <div class="container-fluid">
                    <div class="row">
                            <div class="col-md-12">
                                <span style="font-weight:bold; color:red; font-size:larger;"><b>ORGANIZATION ID:</b> 
                                <asp:Label ID="lblOrgIDValue" runat="server"  Text='<%# Bind("OrganizationID")%>'></asp:Label></span>
                            </div>
                        </div>
                    <div class="row">
                            <div class="col-md-12">
                                <span style="font-weight:bold; color:red;">Your Organization ID is required when registering booth staff, discounted, or waived technical registrations. Please ensure the person responsible for these tasks has access to the ID number.</span>
                            </div>
                        </div>
                    <div class="row">
                        <div class="col-md-12">
                            <b>Organization:</b> <i>(as it will appear on booth I.D. sign)</i><br />
                            <asp:Label ID="lblCompanyName" runat="server" Text='<%# Bind("Exhibitor")%>' />
                            <asp:Label ID="lblTempID" runat="server" Text='<%# Bind("ExhibitorID")%>' Visible="False" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <b>Mailing/Postal Address:</b><br />
                            <asp:Label ID="AddressLine1Label" runat="server" Text='<%# Bind("AddressLine1") %>' />
                            <br />
                            <asp:Label ID="AddressLine2Label" runat="server" Text='<%# Bind("AddressLine2") %>' />
                            <br />
                            <asp:Label ID="AddressLine3Label" runat="server" Text='<%# Bind("AddressLine3") %>' />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <b>City:</b>
                            <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <b>State/Province:</b>
                            <asp:Label ID="StateProvinceLabel" runat="server" Text='<%# Bind("StateProvince") %>' />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <b>Zip/Postal Code:</b>
                            <asp:Label ID="ZipPostalLabel" runat="server" Text='<%# Bind("ZipPostal") %>' />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <b>Country:</b>
                            <asp:Label ID="CountryLabel" runat="server" Text='<%# Bind("Country") %>' />
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        </div>
                    </div>
                </div>
            </ItemTemplate>

        </asp:FormView>
        <br />
        <asp:Button ID="ButtonFinishedCompany" runat="server" Text="Next Step >>" CssClass="btn btn-primary" Visible="False" />
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="ButtonFinishedCompany" />
    </Triggers>
</asp:UpdatePanel>
