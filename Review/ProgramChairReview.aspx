<%@ Page Title="Program Chair Review" Language="vb" AutoEventWireup="false" MasterPageFile="~/Review/Review.Master" CodeBehind="ProgramChairReview.aspx.vb" Inherits="Battelle.ProgramChairReview" %>

<%@ Register Src="~/SearchAbstracts.ascx" TagPrefix="controls" TagName="SearchAbstracts" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><asp:Label ID="lblConferenceType" runat="server" Text="Conference"></asp:Label> 
        <%=Page.Title%></h1>
        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
           
            
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:SqlDataSource ID="SqlDataSourceAbstractSelected" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractGetByAbstractID" SelectCommandType="StoredProcedure" UpdateCommand="AbstractUpdate" UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:Parameter Name="AbstractCode" Type="Int32" />
                                <asp:Parameter Name="Title" Type="String" />
                                <asp:Parameter Name="AuthorList" Type="String" />
                                <asp:Parameter Name="DateReceived" Type="DateTime" />
                                <asp:Parameter Name="PreferredFormat" Type="String" />
                                <asp:Parameter Name="SubmissionRequestedBy" Type="String" />
                                <asp:Parameter Name="AuthorComments" Type="String" />
                                <asp:Parameter Name="ApplicableTopics" Type="String" />
                                <asp:Parameter Name="NewTopicArea" Type="String" />
                                <asp:Parameter Name="AbstractTitleAuthorBlock" Type="String" />
                                <asp:Parameter Name="AbstractBG" Type="String" />
                                <asp:Parameter Name="AbstractApproach" Type="String" />
                                <asp:Parameter Name="AbstractResults" Type="String" />
                                <asp:Parameter Name="LoginNotes" Type="String" />
                                <asp:Parameter Name="WithdrawnDate" Type="DateTime" />
                                <asp:Parameter Name="ReadyForReview" Type="DateTime" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceAbstractSelected" RenderOuterTable="False">
                           
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnAbstractID" runat="server" Value='<%# Bind("AbstractID")%>' />
                                <asp:HiddenField ID="hdnAbstractTypeID" runat="server" Value='<%# Bind("AbstractTypeID")%>' />

                                <b>Abstract:</b> <i>
                                    <asp:Label ID="LabelFileName" runat="server" Text='<%# Bind("FileName")%>'></asp:Label></i>
                                <div style="border: 1px solid #c7c4c4; box-shadow: 5px 5px 5px #c7c4c4; padding:5px;">
                                    <asp:Label ID="AbstractTitleAuthorBlockLabel" runat="server" Text='<%# Bind("AbstractTitleAuthorBlock")%>' />
                                    <br />
                                    <br />
                                    <asp:Label ID="AbstractBGLabel" runat="server" Text='<%# Bind("AbstractBG")%>' />
                                    <br />
                                    <br />
                                    <asp:Label ID="AbstractApproachLabel" runat="server" Text='<%# Bind("AbstractApproach")%>' />
                                    <br />
                                    <br />
                                    <asp:Label ID="AbstractResultsLabel" runat="server" Text='<%# Bind("AbstractResults")%>' />
                                </div>
                                <br />
                                <b>Abstract Code:</b>
                    <asp:Label ID="AbstractCodeLabel" runat="server" Text='<%# Bind("AbstractCode") %>' />
                                <br />
                                <b>Title:</b>
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>' />
                                <br />
                                <b>Formatted Author List:</b>
                    <asp:Label ID="AuthorListLabel" runat="server" Text='<%# Bind("AuthorList") %>' />
                                <br />
                                <b>Corresponding/Presenting Author:</b>
                    <asp:Label ID="CorrPresAuthLabel" runat="server" Text='<%# Bind("CorrPresAuth")%>' />
                                <br />
                                <b>Employer:</b>
                    <asp:Label ID="EmployerLabel" runat="server" Text='<%# Bind("Employer")%>' />
                                <br />
                                <b>Date Received:</b>
                    <asp:Label ID="DateReceivedLabel" runat="server" Text='<%# Bind("DateReceived") %>' />
                                <br />
                                <b>Preferred Format:</b>
                    <asp:Label ID="PreferredFormatLabel" runat="server" Text='<%# Bind("PreferredFormat") %>' />
                                <br />
                                <b>Submission Requested By:</b>
                    <asp:Label ID="SubmissionRequestedByLabel" runat="server" Text='<%# Bind("SubmissionRequestedBy") %>' />
                                <br />
                                <b>Author Comments:</b>
                    <asp:Label ID="AuthorCommentsLabel" runat="server" Text='<%# Bind("AuthorComments") %>' />
                                <br />
                                <b>Applicable Topics:</b>
                    <asp:Label ID="ApplicableTopicsLabel" runat="server" Text='<%# Bind("ApplicableTopics") %>' />
                                <br />
                                <b>New Topic Area:</b>
                    <asp:Label ID="NewTopicAreaLabel" runat="server" Text='<%# Bind("NewTopicArea") %>' />
                                <br />
                                <b>Login Notes:</b>
                    <asp:Label ID="LoginNotesLabel" runat="server" Text='<%# Bind("LoginNotes") %>' />
                                
                                <br />
                                 <b>Ready For Review Date:</b>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ReadyForReview") %>' />
                                <br />
 

                            </ItemTemplate>


                        </asp:FormView>
                            
                    </div>
                    </div>
                    <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <h4>Review Results</h4>
                        <asp:GridView ID="gvOtherReviews" runat="server" AutoGenerateColumns="False" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceOtherReviews" EmptyDataText="You are the first to review this abstract." CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="SubmissionRequestedBy" HeaderText="Submission Requested By" SortExpression="SubmissionRequestedBy" />
                                <asp:BoundField DataField="TopicGroupCode" HeaderText="Theme" SortExpression="TopicGroupCode" />
                                <asp:BoundField DataField="TopicCode" HeaderText="Topic" SortExpression="TopicCode" />
                                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                                <asp:CheckBoxField DataField="Decline" HeaderText="Decline" SortExpression="Decline" />
                                <asp:BoundField DataField="Reviewer" HeaderText="Reviewer" SortExpression="Reviewer" /> 
                                <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate" />  
                                <asp:BoundField DataField="FinalDate" HeaderText="Final Review Date" SortExpression="FinalDate" />         
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceOtherReviews" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractProgramChairReviewOthersGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        
                    </div>
                </div>

                <!--start panel--->
                <asp:Label ID="PanelLockMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                <asp:Panel ID="PanelLock" runat="server" Visible="true">


                <div class="row">
                    <div class="col-lg-8 col-md-8 col-sm-8">
                        <!--Form-->
                        <asp:SqlDataSource ID="SqlDataSourceReview" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="AbstractProgramChairReviewInsert" InsertCommandType="StoredProcedure" SelectCommand="AbstractProgramChairReviewGet" SelectCommandType="StoredProcedure" UpdateCommand="AbstractProgramChairReviewUpdate" UpdateCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                                <asp:Parameter Name="RelatedAbstracts" Type="String" />
                                <asp:Parameter Name="TopicGroupID" Type="Int32" />
                                <asp:Parameter Name="SessionID" Type="Int32" />
                                <asp:Parameter Name="Comments" Type="String" />
                                <asp:Parameter Name="Decline" Type="Boolean" DefaultValue="False" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                                <asp:Parameter Name="RelatedAbstracts" Type="String" />
                                <asp:Parameter Name="TopicGroupID" Type="Int32" />
                                <asp:Parameter Name="SessionID" Type="Int32" />
                                <asp:Parameter Name="Comments" Type="String" />
                                <asp:Parameter Name="Decline" Type="Boolean" DefaultValue="False"  />
                                <asp:Parameter Name="AbstractReviewID" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceTopicGroup" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="TopicGroupGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="ConferenceID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceSession" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SessionGetByTopic" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="ConferenceID" Type="Int32" />
                                <asp:Parameter Name="TopicGroupID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        
                        <h3>Review Form</h3>
                        <asp:FormView ID="FormViewReview" runat="server" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceReview" RenderOuterTable="False" DefaultMode="Edit">
                            <EditItemTemplate>
                                Related Abstracts (by Code):
                                <asp:TextBox ID="RelatedAbstractsTextBox" runat="server" Text='<%# Bind("RelatedAbstracts") %>' CssClass="form-control" />
                                <br />
                                Assign to a Theme (Select a code here or click "Decline" below):
                                <asp:DropDownList ID="ddlTopic" runat="server" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID" SelectedValue='<%# Bind("TopicGroupID") %>' AppendDataBoundItems="True" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlTopic_SelectedIndexChanged">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                Suggest a Topic (Optional):
                                <asp:DropDownList ID="ddlSession" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="SessionID" AppendDataBoundItems="True" CssClass="form-control">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList> 
                                <br />                             
                                Comments:
                                <asp:TextBox ID="CommentsTextBox" runat="server" Text='<%# Bind("Comments") %>'  CssClass="form-control"/>
                                <asp:RequiredFieldValidator id="DeclineCommentsValidator" runat="server" Enabled="false"
                                    ControlToValidate="CommentsTextBox"
                                    ErrorMessage="You must provide comments if declining for conference."
                                    ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <br /> 
                                Decline for Conference: <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Decline") %>' AutoPostBack="true" OnCheckedChanged="DeclineCheckBox_CheckedChanged" />
                                <br />
                               
                                <br />
                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update Review" CssClass="btn btn-primary" />                                
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                Related Abstracts (by Code):
                                <asp:TextBox ID="RelatedAbstractsTextBox" runat="server" Text='<%# Bind("RelatedAbstracts") %>' CssClass="form-control" />
                                <br />
                                Assign to a Theme (Select a code here or click "Decline" below):
                                <asp:DropDownList ID="ddlTopic" runat="server" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID" SelectedValue='<%# Bind("TopicGroupID") %>' AppendDataBoundItems="True" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlTopic_SelectedIndexChanged">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                Suggest a Topic (Optional):
                                <asp:DropDownList ID="ddlSession" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="SessionID"  AppendDataBoundItems="True" CssClass="form-control" Enabled="false">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList> 
                                <br />
                                Comments:
                                <asp:TextBox ID="CommentsTextBox" runat="server" Text='<%# Bind("Comments") %>'  CssClass="form-control"/>
                                <asp:RequiredFieldValidator id="DeclineCommentsValidator" runat="server" Enabled="false"
                                    ControlToValidate="CommentsTextBox"
                                    ErrorMessage="You must provide comments if declining for conference."
                                    ForeColor="Red">
                                </asp:RequiredFieldValidator>   
                                <br />
                                Decline for Conference: <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Decline") %>' AutoPostBack="true" OnCheckedChanged="DeclineCheckBox_CheckedChanged"/>                             
                                <br />

                                <br />
                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Save Review" CssClass="btn btn-primary" />                                
                            </InsertItemTemplate>
                            <ItemTemplate>
                                Related Abstracts:
                                <asp:Label ID="RelatedAbstractsLabel" runat="server" Text='<%# Bind("RelatedAbstracts") %>' />
                                <br />
                                Theme:
                                <asp:Label ID="TopicGroupIDLabel" runat="server" Text='<%# Eval("TopicGroupCode")%>' />
                                <br />
                                Topic:
                                <asp:Label ID="SessionIDLabel" runat="server" Text='<%# Eval("TopicCode")%>' />
                                <br />
                                Comments:
                                <asp:Label ID="CommentsLabel" runat="server" Text='<%# Bind("Comments") %>' />
                                <br />
                                Decline for Conference: <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Decline") %>' Enabled="false" AutoPostBack="true" OnCheckedChanged="DeclineCheckBox_CheckedChanged" />
                                <br />
                                Review Date:
                                <asp:Label ID="ReviewDateLabel" runat="server" Text='<%# Eval("ReviewDate")%>' />

                                <br />
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-primary" />
                            </ItemTemplate>
                        </asp:FormView>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:Image ID="Progress" runat="server" ImageUrl="~/images/ajax-loader.gif" Visible="false"/>
                        <asp:Label ID="Success" runat="server" Text="Review successfully recorded" Visible="false"></asp:Label>
                        <asp:Panel ID="PanelFinalize" runat="server" Visible="false">
                            <hr />
                            If this review has been agreed on by all Program Chairs, it must be finalized to move to the next round of review.<br />
                            <asp:Label ID="lblFinalize" runat="server" Text="You must select a Theme or Decline the abstract.<br />" Visible="False" CssClass="text-danger"></asp:Label>
                            <asp:Button ID="btnFinalize" runat="server" Text="Accept My Review as Final for All Program Chairs" CssClass="btn btn-success" />
                            <asp:HyperLink ID="lnkNeedsEdits" runat="server" CssClass="btn btn-warning">This Review Requires Further Discussion/Edits</asp:HyperLink>
                            <asp:SqlDataSource ID="SqlDataSourceFinalize" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" UpdateCommand="AbstractProgramChairReviewFinalUpdate" UpdateCommandType="StoredProcedure">
                                <UpdateParameters>
                                    <asp:Parameter Name="AbstractReviewID" Type="Int32" />
                                    <asp:Parameter Name="Decline" Type="boolean" DefaultValue="false" />
                                    <asp:Parameter Name="AbstractID" Type="Int32" />
                                    <asp:Parameter Name="TopicGroupID" Type="Int32" />
                                    <asp:Parameter Name="SessionID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <hr />
                        </asp:Panel>
                        <br />
                        <asp:HyperLink ID="lnkReturn" runat="server">Return to Program Chair Review Overview</asp:HyperLink>
                    </div>
                </div>

            </asp:Panel>
            <!---end panel--->
             
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractSearchFullText" SelectCommandType="StoredProcedure" >

                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String" />
                                    <asp:Parameter Name="ConferenceID" Type="Int32" />
                                </SelectParameters>

                            </asp:SqlDataSource>
                        <div class="form-group">
                        <asp:Panel ID="PanelSearch" runat="server" Visible="True">                            
                            <h3>Search Abstracts</h3>
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" MaxLength="500"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-default" OnClientClick="return Progress();"/></span>
                            </div>
                            <script type="text/javascript">
                                function Progress() {
                                    document.getElementById("SearchIndicator").style.display = "block";
                                }
                            </script>
                            <br />
                            <div id="SearchIndicator" style="display:none;margin-left:auto;margin-right:auto;width:32px;"><asp:Image ID="SearchIncicator" runat="server" ImageURL="~/Images/ajax-loader.gif" /></div>
                            <br />
                            <asp:GridView ID="gvSearch" runat="server" CssClass="table" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceSearch">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <itemtemplate>
                                                <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsReviewViewRoute", New With { _
                                                    Key .abstractid = Eval("AbstractID"), Key .code = Eval("AbstractCode")})%>' Target="_blank" />
                                        </itemtemplate>
                                    </asp:TemplateField>
                                  
                                    <asp:BoundField DataField="AbstractCode" HeaderText="Abstract Code" SortExpression="AbstractCode" />
                                    <asp:BoundField DataField="Title" HeaderText="Title" HtmlEncode="False" />
                                    <asp:BoundField DataField="AuthorList" HeaderText="Author List" />
                                </Columns>
                            </asp:GridView>
                            <asp:Panel ID="PanelNoResults" runat="server" Visible="false">
                                <p>Your search yielded no results.</p>
                            </asp:Panel>                            
                        </asp:Panel>

                        </div>
                        <br />
                    </div>
                </div>

               </div>
                
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
