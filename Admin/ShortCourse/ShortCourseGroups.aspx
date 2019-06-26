<%@ Page Title="Short Course Groups" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Admin.Master" CodeBehind="ShortCourseGroups.aspx.vb" Inherits="Battelle.ShortCourseGroups" %>

<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">

<asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
    <div class="row">
    <div style="float:left;"><h1><%=Page.Title%></h1></div>
    <div style="float:right;"><br /><asp:Button ID="ButtonShortCourseGroupAdd" runat="server" Text="Add Short Course Group" CssClass="btn btn-primary" UseSubmitBehavior="False" OnClick="ButtonShortCourseGroupAdd_Click" /></div>
    <div style="clear: both;" />
    </div>

    <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
    <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
        <asp:ListItem Value="" Text=""></asp:ListItem>
    </asp:DropDownList>
    <asp:HiddenField ID="HdnConferenceID" runat="server" />

    <asp:SqlDataSource ID="SqlDataSourceShortCourseGroups" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseGroupGetByConferenceID" SelectCommandType="StoredProcedure" InsertCommand="ShortCourseGroupInsert" InsertCommandType="StoredProcedure" UpdateCommand="ShortCourseGroupUpdate" UpdateCommandType="StoredProcedure" DeleteCommand="ShortCourseGroupDelete" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="ConferenceID" Type="Int32" />
            <asp:Parameter Name="GroupName" Type="String" />
            <asp:Parameter Name="FullDay" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="GroupID" Type="Int32" />
            <asp:Parameter Name="GroupName" Type="String"  />
            <asp:Parameter Name="FullDay" Type="Boolean" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="GroupID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <div class="row"><div class="col-md-12">&nbsp;</div></div>


    <asp:Panel ID="ShortCourseGroupsPanel" runat="server" Visible="false" BackColor="#f7f7f7">
    
    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSourceShortCourseGroups" RenderOuterTable="False">
        <InsertItemTemplate>
            
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-12">
                        <h4>Enter Short Course Group Information</h4>
                    </div>
                </div>

                <div class="row">
                      <div class="col-md-6">
                         <div class="form-group">
                            <h5><span class="text-danger">*</span><asp:Label ID="lblConferenceShortCourse" runat="server" Text="Conference:" AssociatedControlID="ddlConfListShortCourse" /></h5>
                            <asp:DropDownList ID="ddlConfListShortCourse" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID" CssClass="form-control" SelectedValue='<%# Bind("ConferenceID")%>'>
                            <asp:ListItem Value="" Text=""></asp:ListItem>
                          </asp:DropDownList>
                          </div>
                       </div>
                     <div class="col-md-6">
                        <div class="form-group">
                           <h5><span class="text-danger">*</span><asp:Label ID="lblShortGroupDate" runat="server" Text="Short Course Date/Time:" AssociatedControlID="ShortCourseGroupTextBox" /></h5>
                            <asp:TextBox ID="ShortCourseGroupTextBox" runat="server"  CssClass="form-control" Text='<%# Bind("GroupName") %>' />
                        </div>
                     </div>
                </div>

                <div class="row">
                      <div class="col-md-12">
                         <div class="form-group">
                            <h5><span class="text-danger">*</span><asp:Label ID="lblFullHalf" runat="server" Text="Full or Half Day:" AssociatedControlID="radioFullHalf" /></h5>
                             <asp:RadioButtonList id="radioFullHalf" runat="server" CssClass="radio" CellPadding="2" CellSpacing="2" SelectedValue='<%# Bind("FullDay")%>'>
                                <asp:ListItem Text="Full Day" Value="True" />
                                <asp:ListItem Text="Half Day" Value="False" />
                             </asp:RadioButtonList>
                         </div>
                     </div>
               </div>
  
                <div class="row">
                    <div class="col-md-12">
                       <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </div>
                </div>
           </div>
        </InsertItemTemplate>
    </asp:FormView>
    </asp:Panel>

    <div class="row"><div class="col-md-12">&nbsp;</div></div>

    <asp:Panel ID="GridViewPanel" runat="server" Visible="false">

    <h3>Conference: <asp:Label ID="lblConferenceName" runat="server" /></h3>
    <h4>Short Course Groups List Date/Time</h4>

    <asp:GridView ID="gvShortCourseGroups" DataSourceID="SqlDataSourceShortCourseGroups" Visible="false" runat="server" AutoGenerateColumns="false" CssClass="table" DataKeyNames="GroupID">
        <Columns>
            <asp:CommandField ShowEditButton="True" EditText="Edit" />
            <asp:TemplateField HeaderText="Short Course Group Date/Time" SortExpression="GroupName">
               <EditItemTemplate>
                  <asp:TextBox ID="gvGroupNameTextBox" runat="server" Text='<%# Bind("GroupName") %>' TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
               </EditItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="gvGroupNameLabel" runat="server" Text='<%# Bind("GroupName") %>'></asp:Label>
                </ItemTemplate>
             </asp:TemplateField>

            <asp:TemplateField HeaderText="Full Day/Half Day" SortExpression="FullDay">
               <EditItemTemplate>
                  <asp:RadioButtonList id="gvRadioFullHalf" runat="server" CssClass="radio" CellPadding="2" CellSpacing="2" SelectedValue='<%# Bind("FullDay")%>' >
                                <asp:ListItem Text="Full Day" Value=True />
                                <asp:ListItem Text="Half Day" Value=False />
                   </asp:RadioButtonList>
               </EditItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="gvRadioFullHalfLabel" runat="server" Text='<%# If(Eval("FullDay").ToString() = "True", "Full Day", "Half Day") %>'></asp:Label>
                </ItemTemplate>
             </asp:TemplateField>       
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this entry?');">Delete</asp:LinkButton>             
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </asp:Panel>
    </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="gvShortCourseGroups" />
        </Triggers>
    </asp:UpdatePanel>

</asp:Content>