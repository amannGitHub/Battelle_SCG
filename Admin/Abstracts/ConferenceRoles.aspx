<%@ Page Title="Conference Roles Manager" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="ConferenceRoles.aspx.vb" Inherits="Battelle.ConferenceRoles" %>

<%@ Register Src="~/ConferenceFromURL.ascx" TagPrefix="uc1" TagName="ConferenceFromURL" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
        .Hide {
            display: none;
        }
    </style>



    <h1><%=Page.Title%></h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceConferenceRole" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferencePersonRolesGet" SelectCommandType="StoredProcedure" UpdateCommand="ConferencePersonRolesUpdate" UpdateCommandType="StoredProcedure" DeleteCommand="ConferencePersonRolesDelete" DeleteCommandType="StoredProcedure" FilterExpression="RoleName LIKE '{0}' OR FirstName LIKE '{0}' OR LastName LIKE '{0}'">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="gvConferenceRole" Name="PersonRoleID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="gvConferenceRole" Name="LeadChair" PropertyName="SelectedValue" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="gvConferenceRole" Name="PersonRoleID" PropertyName="SelectedValue" />
                </DeleteParameters>
                <FilterParameters>
                    <asp:ControlParameter ControlID="SearchBox" PropertyName="Text" />
                </FilterParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>

            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID" OnSelectedIndexChanged="ddlConfList_SelectedIndexChanged">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList><br />
            <br />

            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div id="divGrid" style="width: 100%; height: 600px; overflow: auto;">

                            <div style="text-align: center; padding-top: 5px; padding-bottom: 5px;">
                                <asp:Label ID="lblSearchBox" runat="server" Text="Search" AssociatedControlID="SearchBox" Visible="false"></asp:Label>
                                <asp:TextBox runat="server" ID="SearchBox" Text="*" Visible="false" />
                                <asp:Button runat="server" ID="FilterButton" Text="Filter Results" Visible="false" />
                            </div>

                            <asp:GridView ID="gvConferenceRole" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceConferenceRole" AutoGenerateColumns="False" Visible="False" CssClass="table" DataKeyNames="PersonRoleID" SelectedRowStyle-CssClass="active">
                                <EditRowStyle CssClass="info" />
                                <HeaderStyle CssClass="HeaderFreeze" />
                                <Columns>
                                    <asp:CommandField ShowEditButton="True" EditText="Update Lead/ Accepted" />
                                    <asp:CheckBoxField DataField="LeadChair" HeaderText="Lead Chair" SortExpression="LeadChair" />
                                    <asp:CheckBoxField DataField="Accepted" HeaderText="Invitation Accepted" SortExpression="Accepted" />
                                    <asp:BoundField DataField="RoleName" HeaderText="Role" SortExpression="RoleName" ReadOnly="true" />
                                    <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" HtmlEncode="false" ReadOnly="true" />
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" ReadOnly="true" />
                                    <asp:BoundField DataField="TopicGroup" HeaderText="Topic Group" SortExpression="TopicGroup" ReadOnly="true" />
                                    <asp:BoundField DataField="TopicGroupCode" HeaderText="Topic Group Code" SortExpression="TopicGroupCode" ReadOnly="true" />
                                    <asp:BoundField DataField="TopicCode" HeaderText="Topic" SortExpression="TopicCode" ReadOnly="true" />
                                    <asp:BoundField DataField="SessionName" HeaderText="Session" SortExpression="SessionName" ReadOnly="true" />
                                    <asp:CommandField ShowDeleteButton="true" EditText="Delete Record" />
                                </Columns>
                                <SelectedRowStyle CssClass="info" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <br />
                    <br />
                    <asp:Button ID="ButtonConferenceAdd" runat="server" Text="Add Conference Role" CssClass="btn btn-primary" Visible="false" OnClick="ButtonConferenceAdd_Click" />
                    <br />
                    <br />
                </div>

                <div class="row" id="labelConference" runat="server" visible="false">
                    <br />
                    <br />
                    <div class="col-md-12">
                        <b>
                            <asp:Label ID="lblConferenceResults" runat="server" ForeColor="Red" Text=""></asp:Label></b>
                    </div>
                </div>


                <asp:Panel ID="PanelConferenceRoleAdd" runat="server" Visible="false" Style="border: 1px solid #808080;">
                    <asp:SqlDataSource ID="SqlDataSourceConferenceRoleList" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceRoleGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourcePersonFullName" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGetFullNameAndCompany" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceTopicGroup" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="TopicGroupGet" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceSession" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SessionGetByTopic" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="TopicGroupList" Name="TopicGroupID" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>


                    <div class="form-group">
                        <div class="container">
                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                            <div class="row">
                                <div class="col-md-12">
                                    <h4>Add Conference Role Form</h4>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 20px;">
                                <div class="col-md-2">
                                    <asp:Label ID="lblConferenceRole" runat="server" Text="Select Conference Role" AssociatedControlID="ConferenceRoleList"></asp:Label>
                                </div>
                                <div class="col-md-2">
                                    <asp:DropDownList ID="ConferenceRoleList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConferenceRoleList" DataTextField="RoleName" DataValueField="RoleID" OnSelectedIndexChanged="ConferenceRoleList_Changed">
                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-2">
                                    <asp:CheckBox ID="chkLeadChair" runat="server" />
                                    <asp:Label ID="Label1" runat="server" Text="Lead Chair?" AssociatedControlID="chkLeadChair"></asp:Label>
                                </div>
                                <div class="col-md-2">
                                    <asp:CheckBox ID="chkAccepted" runat="server" />
                                    <asp:Label ID="Label2" runat="server" Text="Invitation Accepted?" AssociatedControlID="chkAccepted"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <asp:RequiredFieldValidator ID="ConferenceValidator"
                                    ControlToValidate="ConferenceRoleList"
                                    Text="Please select a role from the above 'Select Conference Role' drop-down menu."
                                    runat="server" ForeColor="Red" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">
                                <asp:Label ID="lblPersonList" runat="server" Text="Select Person" AssociatedControlID="txtPersonLookup"></asp:Label>
                            </div>
                            <div class="col-md-4">
                                <telerik:RadAutoCompleteBox ID="txtPersonLookup" runat="server" DataSourceID="SqlDataSourcePersonFullName" DataTextField="FullName" DataValueField="PersonID" InputType="Token" Width="350" DropDownWidth="400">
                                    <TextSettings SelectionMode="Single" />
                                </telerik:RadAutoCompleteBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <asp:Label ID="lblPersonCheck" runat="server" Text="Please enter a name in the 'Select Person' box." Visible="false" ForeColor="Red"></asp:Label>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 20px;">
                            <div class="col-md-2">
                                <asp:Label ID="lblTopicGroup" runat="server" Text="Select Topic Group" AssociatedControlID="TopicGroupList" Visible="false"></asp:Label>
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="TopicGroupList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicGroup" DataValueField="TopicGroupID" Visible="false" OnSelectedIndexChanged="TopicGroupList_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <asp:RequiredFieldValidator ID="TopicValidator"
                                ControlToValidate="TopicGroupList"
                                Text="Please select a topic from the above 'Select Topic Group' drop-down menu."
                                runat="server" ForeColor="Red" Enabled="false" />
                        </div>
                        <div class="row">
                            <div class="col-md-2">
                                <asp:Label ID="lblSession" runat="server" Text="Select Topic Session" AssociatedControlID="SessionList" Visible="false"></asp:Label>
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="SessionList" runat="server" AppendDataBoundItems="False" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="SessionID" Visible="false">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <asp:RequiredFieldValidator ID="SessionValidator"
                                ControlToValidate="SessionList"
                                Text="Please select a session from the 'Select Topic Session' drop-down menu."
                                runat="server" ForeColor="Red" Enabled="false" />
                        </div>
                    </div>
                    <div class="row" style="padding: 15px;">
                        <%--<asp:Label ID="testLabel" runat="server"></asp:Label>--%>
                        <div class="col-md-2">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary btn-block" CausesValidation="true" />
                        </div>

                    </div>
            </div>
            </div>
            <asp:HiddenField ID="hdnCtrls" runat="server" />

            </asp:Panel>
             
            </div>

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
