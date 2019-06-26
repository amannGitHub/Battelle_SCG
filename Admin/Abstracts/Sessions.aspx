<%@ Page Title="Sessions Manager" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="Sessions.aspx.vb" Inherits="Battelle.Sessions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <h1><%=Page.Title%></h1>
     <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
    <asp:SqlDataSource ID="SqlDataSourceSessions" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SessionGet" SelectCommandType="StoredProcedure" InsertCommand="SessionInsert" InsertCommandType="StoredProcedure" UpdateCommand="SessionUpdate" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="TopicGroupID" Type="Int32" />
            <asp:Parameter Name="TopicCode" Type="String" />
            <asp:Parameter Name="TemporarySessionCode" Type="String" />
            <asp:Parameter Name="SessionCode" Type="String" />
            <asp:Parameter Name="SessionName" Type="String" />
            <asp:Parameter Name="PlatformSlots" Type="Int32" />
            <asp:Parameter Name="StartTime" DbType="String" />
            <asp:Parameter Name="EndTime" DbType="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="SessionID" Type="Int32" />
            <asp:Parameter Name="TopicGroupID" Type="Int32" />
            <asp:Parameter Name="TopicCode" Type="String" />
            <asp:Parameter Name="TemporarySessionCode" Type="String" />
            <asp:Parameter Name="SessionCode" Type="String" />
            <asp:Parameter Name="SessionName" Type="String" />
            <asp:Parameter Name="PlatformSlots" Type="Int32" />
            <asp:Parameter Name="StartTime" DbType="String" />
            <asp:Parameter Name="EndTime" DbType="String" />
            <asp:Parameter DbType="Date" Name="PlatformDate" />
            <asp:Parameter DbType="Date" Name="PosterDate" />
            <asp:Parameter Name="PlatformBreakfast" Type="String" />
            <asp:Parameter Name="Deactivate" Type="Boolean" />
        </UpdateParameters>
     </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTopicGroup" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="TopicGroupGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
     <asp:FormView ID="FormViewSessions" runat="server" DataKeyNames="SessionID" DataSourceID="SqlDataSourceSessions" DefaultMode="Insert" Visible="False">

         <InsertItemTemplate>
             <div class="form-group">
                 <div class="container">
                     <div class="row">
                         <div class="col-md-3">
Topic Code:
             <asp:TextBox ID="TopicCodeTextBox" runat="server" Text='<%# Bind("TopicCode") %>' CssClass="form-control" MaxLength="10" />
                         </div>
                         <div class="col-md-3">
                             Temporary Session Code:
             <asp:TextBox ID="TemporarySessionCodeTextBox" runat="server" Text='<%# Bind("TemporarySessionCode") %>' MaxLength="20" CssClass="form-control" />
                             </div>
                         <div class="col-md-3">
                             Session Code:
             <asp:TextBox ID="SessionCodeTextBox" runat="server" Text='<%# Bind("SessionCode") %>' MaxLength="10" CssClass="form-control" />
                             </div> 
                         <div class="col-md-3">
                            Platform Slots:
             <asp:TextBox ID="PlatformSlotsTextBox" runat="server" Text='<%# Bind("PlatformSlots") %>' CssClass="form-control" />
                         </div>
                     </div>
                     <div class="row">
                         <div class="col-md-4">
                             Session Name:
             <asp:TextBox ID="SessionNameTextBox" runat="server" Text='<%# Bind("SessionName") %>' MaxLength="500" CssClass="form-control" />
                         </div>
                         <div class="col-md-4">
                             Start Time:
                             <telerik:RadTimePicker ID="StartTime" RenderMode="Lightweight" DbSelectedDate='<%# Bind("StartTime") %>' runat="server" Width="100%">
                                 <TimeView Interval="00:05:00"
                                     StartTime="06:00:00"
                                     EndTime="18:00:00"
                                     Columns="6"
                                     runat="server">
                                 </TimeView> 
                             </telerik:RadTimePicker>
                         </div>
                         <div class="col-md-4">
                             End Time:
                             <telerik:RadTimePicker ID="EndTime" RenderMode="Lightweight" DbSelectedDate='<%# Bind("EndTime") %>' runat="server" Width="100%">
                                 <TimeView Interval="00:05:00"
                                     StartTime="06:00:00"
                                     EndTime="18:00:00"
                                     Columns="6"
                                     runat="server">
                                 </TimeView> 
                             </telerik:RadTimePicker>
                         </div>
                     </div>

                     <div class="row">
                         <div class="col-md-12">
                              Theme:
             <asp:DropDownList ID="TopicGroupList" runat="server" AppendDataBoundItems="False" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID" SelectedValue='<%# Bind("TopicGroupID") %>' CssClass="form-control">

                        </asp:DropDownList>
                         </div>
                     </div>
                 </div>
             

             <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert"/>

             </div>
         </InsertItemTemplate>

     </asp:FormView>
    <asp:GridView ID="gvSessions" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="table" DataKeyNames="SessionID" DataSourceID="SqlDataSourceSessions">
        <Columns>
            <asp:CommandField ShowEditButton="True" />

            <asp:BoundField DataField="TopicCode" HeaderText="Topic Code" SortExpression="TopicCode" />
            <asp:BoundField DataField="SessionCode" HeaderText="Session Code" SortExpression="SessionCode" />
            <asp:BoundField DataField="SessionName" HeaderText="Session Name" SortExpression="SessionName" />
            <asp:TemplateField HeaderText="StartTime" SortExpression="StartTime">
                <EditItemTemplate>
                    <telerik:RadTimePicker ID="editStartTime" runat="server" DbSelectedDate='<%# Bind("StartTime") %>' RenderMode="Lightweight">
                        <TimeView Interval="00:05:00"
                                     StartTime="06:00:00"
                                     EndTime="18:00:00"
                                     Columns="6"
                                     runat="server">
                                 </TimeView> 
                    </telerik:RadTimePicker>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="LabelStartTime" runat="server" Text='<%# Eval("StartTime", "{0:g}")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="EndTime" SortExpression="EndTime">
                <EditItemTemplate>
                    <telerik:RadTimePicker ID="editEndTime" runat="server" DbSelectedDate='<%# Bind("EndTime") %>' RenderMode="Lightweight">
                        <TimeView Interval="00:05:00"
                                     StartTime="06:00:00"
                                     EndTime="18:00:00"
                                     Columns="6"
                                     runat="server">
                                 </TimeView> 
                    </telerik:RadTimePicker>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="LabelEndTime" runat="server" Text='<%# Eval("EndTime", "{0:g}")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="PlatformSlots" HeaderText="Platform Slots" SortExpression="PlatformSlots" />
            <asp:TemplateField HeaderText="PlatformDate" SortExpression="Platform Date">
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="RadDatePickerPlatformDate" runat="server" DbSelectedDate='<%# Bind("PlatformDate")%>' DateInput-CssClass="form-control">
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="LabelPlatformDate" runat="server" Text='<%# Eval("PlatformDate", "{0:MMM dd, yyyy}")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="PosterDate" SortExpression="Poster Date">
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="RadDatePickerPosterDate" runat="server" DbSelectedDate='<%# Bind("PosterDate")%>' DateInput-CssClass="form-control">
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="LabelPosterDate" runat="server" Text='<%# Eval("PosterDate", "{0:MMM dd, yyyy}")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="PlatformBreakfast" HeaderText="Platform Breakfast" SortExpression="PlatformBreakfast" />
            <asp:CheckBoxField DataField="Deactivate" HeaderText="Deactivate" SortExpression="Deactivate" />

                         <asp:TemplateField HeaderText="Theme" SortExpression="TopicGroupID">
                <EditItemTemplate>
                     <asp:DropDownList ID="TopicGroupList" runat="server" AppendDataBoundItems="False" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID" SelectedValue='<%# Bind("TopicGroupID") %>' >

                        </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("TopicGroupCode")%>'></asp:Label> 
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("TopicGroup")%>'></asp:Label>
                    <asp:HiddenField ID="hdnTopicGroupID" Value='<%# Bind("TopicGroupID")%>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
     </asp:GridView>
</asp:Content>
