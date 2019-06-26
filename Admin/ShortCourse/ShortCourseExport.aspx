<%@ Page Title="Short Course Export Manager" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="ShortCourseExport.aspx.vb" Inherits="Battelle.ShortCourseExport" EnableEventValidation ="false"  %>

<%@ Register Src="~/ConferenceFromURL.ascx" TagPrefix="uc1" TagName="ConferenceFromURL" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
    .Hide
    {
        display: none;
    }
    </style>

    

    <h1><%=Page.Title%></h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceShortCourse" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCoursePersonGet" SelectCommandType="StoredProcedure" FilterExpression="FirstName LIKE '{0}' OR LastName LIKE '{0}' OR Employer LIKE '{0}' OR Email LIKE '{0}'">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlConfList" Name="ConferenceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <FilterParameters>
                    <asp:ControlParameter ControlID="SearchBox" PropertyName="Text" />
                </FilterParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource ID="SqlDataSourceConference" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceGet" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:Label ID="lblConference" runat="server" Text="Conference:&nbsp;" AssociatedControlID="ddlConfList"></asp:Label>

            <asp:DropDownList ID="ddlConfList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceConference" DataTextField="URLString" DataValueField="ConferenceID" OnSelectedIndexChanged="ddlConfList_SelectedIndexChanged">
                <asp:ListItem Value="" Text=""></asp:ListItem>
            </asp:DropDownList><br /><br />

            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">  
                        <div id="divGrid" style="width: 100%; height: 600px; overflow: auto;">

                        <div style="text-align:center; padding-top:5px; padding-bottom:5px;"><asp:Label ID="lblSearchBox" runat="server" Text="Search" AssociatedControlID="SearchBox" Visible="false"></asp:Label> <asp:TextBox runat="server" id="SearchBox" Text="*" Visible="false" /> <asp:Button runat="server" id="FilterButton" Text="Filter Results" Visible="false" /></div>

                        <asp:GridView ID="gvShortCourse" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceShortCourse" AutoGenerateColumns="False" Visible="False" CssClass="table" SelectedRowStyle-CssClass="active">
                            <EditRowStyle CssClass="info" />
                            <HeaderStyle CssClass="HeaderFreeze" />
                            <Columns>
                                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" HtmlEncode="false" ReadOnly="true"/>
                                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" ReadOnly="true" />
                                <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" ReadOnly="true" />
                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ReadOnly="true" />
                                <asp:BoundField DataField="ReservationDate" HeaderText="Reservation Date" SortExpression="ReservationDate" ReadOnly="true" />
                                <asp:BoundField DataField="CourseName" HeaderText="Course Name" SortExpression="CourseName" ReadOnly="true" />
                                <asp:BoundField DataField="GroupName" HeaderText="Group Name" SortExpression="GroupName" ReadOnly="true" />
                            </Columns>
                            <SelectedRowStyle CssClass="info" />
                        </asp:GridView>
                        </div>
                    </div>
                </div>


           

                <div class="row" id="labelExport" runat="server" visible="false">
                 <br /><br />
                    <div class="col-md-12">
                       <b><asp:Label ID="lblExportResults" runat="server" ForeColor="Red" Text=""></asp:Label></b>
                    </div>
                </div>

      
             
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>

        <div class="row">
                 <asp:Button ID="ButtonExport" runat="server" Text="Export To Excel" CssClass="btn btn-primary"  OnClick="ButtonExport_Click" />
        </div>
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
