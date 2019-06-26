<%@ Page Title="Abstract Review Group Lock" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="AbstractLock.aspx.vb" Inherits="Battelle.AbstractLock" %>

<%@ Register Src="~/ConferenceFromURL.ascx" TagPrefix="uc1" TagName="ConferenceFromURL" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .PanelLock {margin-bottom:20px; border:1px solid black; padding:10px; background-color:#ebfce5}
        .rowStyle {
            padding:5px;
        }
        .highlight
        {
        color:red;
        font-weight:bold;
        }
        .pageSpace td{
         padding-left: 4px;
	     padding-right: 4px;
	     padding-top: 1px;
	     padding-bottom: 2px;
        }
        .table {overflow:hidden;
        }
    </style>

    <h1><%=Page.Title%></h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceAbstract" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractGetByConferenceID" SelectCommandType="StoredProcedure" UpdateCommand="AbstractReviewTypeLockedUpdate" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourcePerson" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"  SelectCommand="PersonGet" SelectCommandType="StoredProcedure" UpdateCommand="PersonUpdateByID" UpdateCommandType="StoredProcedure"></asp:SqlDataSource>


            <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>
            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList>&nbsp;&nbsp;&nbsp;<br /><br />

           
            <div class="container">
                <asp:Panel ID="PanelLockAllButtons" runat="server" Visible="false">
                <div class="row" style="padding-bottom:10px;">
                 <div class="col-md-12" style="text-align:right;">
                 <asp:LinkButton ID="LinkButtonUpdatePC" runat="server" CssClass="btn btn-warning" Text="ProgramLockAll" OnClick="btnLockAll_Click">Program Chair Lock All</asp:LinkButton>
                 <asp:LinkButton ID="LinkButtonUpdateSC" runat="server" CssClass="btn btn-warning" Text="SteeringLockAll" OnClick="btnLockAll_Click">Steering Committee Lock All</asp:LinkButton>
                 <asp:LinkButton ID="LinkButtonUpdateSession" runat="server" CssClass="btn btn-warning" Text="SessionLockAll" OnClick="btnLockAll_Click">Session Chair Lock All</asp:LinkButton>
                 <asp:LinkButton ID="LinkButtonUpdatePCReview" runat="server" CssClass="btn btn-warning" Text="Program2LockAll" OnClick="btnLockAll_Click">Program Chair Re-Review Lock All</asp:LinkButton>
                </div>
                </div>
                </asp:Panel>


                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">

                        <asp:Panel ID="PanelLock" runat="server" Visible="false" CssClass="PanelLock">
                            <asp:Label ID="lblLockResults" Text="" runat="server"></asp:Label><br />
                            <asp:Label ID="lblAbstractID" runat="server"></asp:Label><br />
                            <asp:Label ID="lblAbstractTitle" runat="server"></asp:Label><br />
                            <asp:Label ID="lblLockedReviewGroups" runat="server"></asp:Label>
                        </asp:Panel>

                        <asp:GridView ID="gvAbstract" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceAbstract" AutoGenerateColumns="False" Visible="False" CssClass="table" DataKeyNames="AbstractID" SelectedRowStyle-CssClass="active" AllowPaging="True" PageSize="20" OnRowDataBound="gvAbstract_DataBound"  >
                            <AlternatingRowStyle BackColor="#EAE8E8" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="true" ForeColor="White" />
                            <PagerSettings Mode="NumericFirstLast" PreviousPageText="Previous" NextPageText="Next" PageButtonCount="5" Position="TopAndBottom"  />
                            <PagerStyle ForeColor="Black" HorizontalAlign="center" BackColor="#C6C3C6" CssClass="pageSpace" ></PagerStyle>
                            <Columns>
                                <asp:BoundField DataField="AbstractID" HeaderText="AbstractID" SortExpression="AbstractID" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
                                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" HtmlEncode="false" ItemStyle-Width="40%" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle" />
                                <asp:TemplateField HeaderText="AbstractGroupIDsLocked" Visible="false">
                                <ItemTemplate>
                                <asp:Label ID="lblAbstractGroupIDsLocked" runat="server" Text='<%#Eval("AbstractGroupIDsLocked") %>'></asp:Label>
                                </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Locked Review Groups" HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle">
                                <ItemTemplate>
                                <asp:CheckBoxList ID="ReviewGroupChkBox" runat="server" RepeatDirection="vertical" Font-Size="Small" CellPadding="5" CellSpacing="5">
                                <asp:ListItem Text="&nbsp;&nbsp;Program Chair Review" Value="1"> </asp:ListItem>
                                <asp:ListItem Text="&nbsp;&nbsp;Steering Committee Review" Value="2"> </asp:ListItem>
                                <asp:ListItem Text="&nbsp;&nbsp;Session Chair Review" Value="3"> </asp:ListItem>
                                <asp:ListItem Text="&nbsp;&nbsp;Program Chair Re-Review" Value="4"> </asp:ListItem>
                                </asp:CheckBoxList>
                                </ItemTemplate>                       
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-CssClass="rowStyle" ItemStyle-CssClass="rowStyle">
                                <ItemTemplate>
                                    <asp:Button ID="btnLock" Text="Update" runat="server" OnClick="btnLock_Click" />
                                </ItemTemplate>
                                </asp:TemplateField>                               
                            </Columns>
                            <SelectedRowStyle CssClass="info" />
                        </asp:GridView>
                        <asp:Panel ID="TotalResults" runat="server" Visible="false">
                            <div style="text-align:center;">
                            <i>You are viewing page <%=gvAbstract.PageIndex + 1%> of <%=gvAbstract.PageCount%> total pages</i>
                            </div>
                        </asp:Panel>
                    </div>

                                                                    
                    </div>
                    
                       
 </ContentTemplate>

</asp:UpdatePanel>

    
</asp:Content>

