<%@ Page Title="Session Chair Review" Language="vb" AutoEventWireup="false" MasterPageFile="~/Review/Review.Master" CodeBehind="SessionChairReview.aspx.vb" Inherits="Battelle.SessionChairReview" %>
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
                        <h4>Session Chair Review Results</h4>
                        <asp:GridView ID="gvOtherReviews" runat="server" AutoGenerateColumns="False" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceOtherReviews" EmptyDataText="You are the first to review this abstract." CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="ReviewType" HeaderText="Review Type" SortExpression="ReviewType" />
                                <%--<asp:BoundField DataField="RelatedAbstracts" HeaderText="Related Abstracts" SortExpression="RelatedAbstracts" /> 
                                <asp:BoundField DataField="TopicGroupCode" HeaderText="Suggested Theme" SortExpression="TopicGroupCode" />
                                <asp:BoundField DataField="TopicCode" HeaderText="Suggested Topic" SortExpression="TopicCode" />--%>
                                <asp:BoundField DataField="PresentationFormat" HeaderText="Suggested Format" SortExpression="PresentationFormat" />
                                <asp:CheckBoxField DataField="Decline" HeaderText="Returned to Program Chairs" SortExpression="Decline" />
                                <asp:BoundField DataField="Comments" HeaderText="Reason" SortExpression="Comments" />
                                <asp:BoundField DataField="Reviewer" HeaderText="Reviewer" SortExpression="Reviewer" /> 
                                <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate" />  
                                <asp:BoundField DataField="FinalDate" HeaderText="Final Review" SortExpression="FinalDate" />          
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceOtherReviews" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractSessionChairReviewOthersGet" SelectCommandType="StoredProcedure">
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
                        <asp:SqlDataSource ID="SqlDataSourceReview" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="AbstractSessionChairReviewInsert" InsertCommandType="StoredProcedure" SelectCommand="AbstractSessionChairReviewGet" SelectCommandType="StoredProcedure" UpdateCommand="AbstractSessionChairReviewUpdate" UpdateCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                                <asp:Parameter Name="RelatedAbstracts" Type="String" />
                                <asp:Parameter Name="TopicGroupID" Type="Int32" />
                                <asp:Parameter Name="SessionID" Type="Int32" />
                                <asp:Parameter Name="PresentationFormat" Type="String" />
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
                                <asp:Parameter Name="PresentationFormat" Type="String" />
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
                        <asp:SqlDataSource ID="SqlDataSourceFormat" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewFormatGet" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        <h3 style="float:left;">Review Form</h3><asp:LinkButton ID="btnHelp" runat="server" Text="Help" CssClass="btnHelp" OnClick="btnHelp_Click"></asp:LinkButton><br /><br /><br />
                        <asp:Panel ID="pnlHelp" runat="server" Visible="false">
                            <h4><strong>General Instructions.</strong></h4>
                            <ul>
                                <li>Click on any blue column heading to sort by the information in that column.</li>
                                <li>Use “Ctrl+F” to bring up a search box to search by key word.</li>
                                <li>Abstracts must be “finalized” to be confirmed for your session. If there are abstracts showing in your “To Review” or “My Reviews” queues they have not been finalized by you or your co-chair.</li>
                                <li>Once you or your co-chair have “finalized” any abstract you will no longer be able to enter/change a review for that abstract.</li>
                            </ul>
                            <h4><strong>Abstracts in your Queue.</strong> You will see only the abstracts that have been assigned to your session.</h4>
                            <ul>
                                <li>
                                    <strong>To Review:</strong> Abstracts that have not been reviewed by you but may have been reviewed by your co-chair.
                                    <ul>
                                        <li>Click on <strong>“Review”</strong> for any abstract to see it and additional information about it as well as to enter your review. Clicking either the “Accept this abstract as a presentation in this session” or “Return to Program Chairs” box will then prompt you to assign a format to the presentation or enter a reason for the return to the Program Chairs. </li>
                                        <li>The “Reviews” column shows how many reviews (including yours) have been done for that abstract.</li>
                                        <li>Make sure to <strong>SAVE</strong> your review.</li>
                                    </ul>
                                </li>
                                <li>
                                    <strong>My Reviews:</strong> Abstracts that you have reviewed but neither you nor your co-chair have finalized. You can still change your review for these abstracts.
                                    <ul>
                                        <li>
                                            <strong>How do I change a review?</strong>
                                            <ul>
                                                <li>Click “Review: on the abstract you want to change. </li>
                                                <li>Uncheck the box that you initially selected and check the other box to make the selections appear. </li>
                                                <li>Input your revised review and click “Update Review.” If your selection should be final for all Session Chairs for the session make sure to finalize the abstract by clicking the green button “Accept my Review as Final for the entire Session.” </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                <li><strong>Finalized:</strong> Abstracts (read-only) that have been finalized by you or your co-chair as accepted for your session. <strong>Do not finalize abstracts without first having discussed and agreed upon the preferred format and placement for each with your co-chair.</strong> Reviews cannot be changed for these abstracts so once either of you have finalized the placement for an abstract your co-chair will not be able to input a review.</li>
                                <li><strong>Returned to Program Chairs:</strong> Abstracts (read-only) that you or your co-chair have declined for your session and returned to the Program Chairs for re-review.</li>
                            </ul>
                            <h4><strong>Review your Selections.</strong> Please make sure to do a final review of all the abstracts showing in your “Finalized” queue and verify the following:</h4>  
                            <ul>
                                <li><strong>Platform Presentations</strong>—verify that you have finalized the correct number of platforms for your session. Please do not finalize more, or less, than the number of platforms communicated to you by the Conference Office. If we are able to assign more platform slots to your session we will use your platform alternates.</li>
                                <li><strong>Platform Alternates</strong>—verify that you have chosen only one alternate of each selection (A, B, and C).</li>
                                <li><strong>Posters</strong>—verify that all other abstracts in your “To Review” or “My Review” queues have been finalized as posters unless you have returned some abstracts to the Program Chairs for re-review.</li>
                            </ul>  
                            <h4><strong>FAQs.</strong></h4>
                            <ul>
                                <li><strong>Why is “To Review” showing abstracts I’ve already reviewed?</strong><br />As you review abstracts and record your decisions, you may find that when you return to the Summary Screen, the abstracts you’ve just reviewed are still in the “To Review” queue. To update the Summary, right-click your mouse and select “refresh” or click the “refresh” icon in your browser bar.</li>
                                <li><strong>How can I return to a specific item on the Summary Screen?</strong><br />When viewing the Summary Screen, you can return to the link for an abstract by using “Ctrl+F” to bring up a search box in the upper-left or upper-right corner of the screen, depending on your browser. In that box, type the abstract code number or a portion of the title or author list and hit “Enter.”</li>
                            </ul>
                            <asp:LinkButton ID="btnCloseHelp" runat="server" Text="Close" OnClick="btnHelp_Click" CssClass="btnCloseHelp"></asp:LinkButton>
                        </asp:Panel>
                        <br />
                        <br />
                        <br />
                        <asp:FormView ID="FormViewReview" runat="server" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceReview" RenderOuterTable="False" DefaultMode="Edit">
                            <EditItemTemplate>
                                <%--Related Abstracts (by Code):
                                <asp:TextBox ID="RelatedAbstractsTextBox" runat="server" Text='<%# Bind("RelatedAbstracts") %>' CssClass="form-control" />
                                <br />--%>
                                <asp:CheckBox ID="AcceptAbstractCheckBox" runat="server" AutoPostBack="true" OnCheckedChanged="AcceptAbstractCheckBox_CheckedChanged" />&nbsp;Accept this abstract as a presentation in this session.<br /><br />
                                <asp:Panel ID="PanelAccept" runat="server" Visible="False">
                                Assign a presentation format:<br />
                                <ul>
                                    <li>Select "platform" for the number of abstracts specified in the email you received from the <asp:Label ID="lblConf" runat="server" Text="Conference"></asp:Label> office.</li>
                                    <li>Select "platform alternate" for up to three; A, B, and C indicate the order in which you would want them moved to platform in the event an additional platform slot becomes available and/or a presentation is withdrawn from your session before the <asp:Label ID="lblConf2" runat="server" Text="Conference"></asp:Label>. The alternates will be scheduled as posters until such time as a platform slot might become available.</li>
                                    <li>Select "poster" for the remaining abstracts you accept for your session. If "poster" appears in the <strong>Preferred Format</strong> field above, the author requested poster placement.</li>
                                </ul>
                                <br />
                                Assign a presentation format:
                                <asp:DropDownList ID="ddlFormat" runat="server" DataSourceID="SqlDataSourceFormat" DataTextField="PresentationFormat" DataValueField="PresentationFormat" SelectedValue='<%# Bind("PresentationFormat")%>' AppendDataBoundItems="True" CssClass="form-control">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList><asp:HiddenField ID="hdnTopicGroup" runat="server" Value='<%# Bind("TopicGroupID")%>' />
                                <asp:CustomValidator ID="CustomValidator1" runat="server"  
                                onservervalidate="CustomValidator1_ServerValidate" ErrorMessage="" ForeColor="Red">
                                </asp:CustomValidator>
                                <br /><br />
                                Review Notes for Co-chair (optional):
                                <asp:TextBox ID="CoChairCommentsTextBox" runat="server" Text='<%# Eval("Comments")%>'  CssClass="form-control" TextMode="MultiLine" />
                                <asp:HiddenField ID="hdnSessionID" runat="server" Value='<%# Bind("SessionID")%>' /></asp:Panel>
                                <br />
                                <br />
                                <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Decline") %>' AutoPostBack="true" OnCheckedChanged="DeclineCheckBox_CheckedChanged" />&nbsp;Return to Program Chairs.<br /><br />
                                <asp:Label ID="CommentDeclineLabel" runat="server" Text='Common reasons for return to Program Chairs are listed below. Enter one of these or another reason in the comments box. Provide additional information as needed.' /><br />
                                <ul runat="server" id="declineReasons" visible="false">
                                    <li>Advise declining for <asp:Literal ID="ltlConferenceType" runat="server" Text="Conference"></asp:Literal>.</li>
                                    <li>Reroute abstract to Session __ (provide session code).</li>
                                    <li>Consider adding a new session topic __ (provide recommended session title) under Theme __ (provide theme number).</li>
                                    <li>This abstract is closely related to another abstract I reviewed. Consider having this combined with Abstract __ (provide abstract code).</li>
                                </ul>
                                <br />
                                <asp:TextBox ID="CommentsTextBox" runat="server" Text='<%# Eval("Comments") %>'  CssClass="form-control" TextMode="MultiLine" />
                                <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                                ControlToValidate="CommentsTextBox"
                                ErrorMessage="Please provide comments."
                                ForeColor="Red"
                                Enabled="false">
                                </asp:RequiredFieldValidator>
                                <br />
                                <br />
                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update Review" CssClass="btn btn-primary" />
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <%--Related Abstracts (by Code):
                                <asp:TextBox ID="RelatedAbstractsTextBox" runat="server" Text='<%# Bind("RelatedAbstracts") %>' CssClass="form-control" />
                                <br />--%>
                                <asp:CheckBox ID="AcceptAbstractCheckBox" runat="server" AutoPostBack="true" OnCheckedChanged="AcceptAbstractCheckBox_CheckedChanged" />&nbsp;Accept this abstract as a presentation in this session.<br /><br />
                               <asp:Panel ID="PanelAccept" runat="server" Visible="False">
                                 Assign a presentation format:<br />
                                <ul>
                                    <li>Select "platform" for the number of abstracts specified in the email you received from the <asp:Label ID="lblConf" runat="server" Text="Conference"></asp:Label> office.</li>
                                    <li>Select "platform alternate" for up to three; A, B, and C indicate the order in which you would want them moved to platform in the event an additional platform slot becomes available and/or a presentation is withdrawn from your session before the <asp:Label ID="lblConf2" runat="server" Text="Conference"></asp:Label>. The alternates will be scheduled as posters until such time as a platform slot might become available.</li>
                                    <li>Select "poster" for the remaining abstracts you accept for your session. If "poster" appears in the <strong>Preferred Format</strong> field above, the author requested poster placement.</li>
                                </ul>
                                <br />
                                Assign a presentation format:
                                <asp:DropDownList ID="ddlFormat" runat="server" DataSourceID="SqlDataSourceFormat" DataTextField="PresentationFormat" DataValueField="PresentationFormat" SelectedValue='<%# Bind("PresentationFormat")%>' AppendDataBoundItems="True" CssClass="form-control">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:CustomValidator ID="CustomValidator1" runat="server"  
                                onservervalidate="CustomValidator1_ServerValidate" ErrorMessage="" ForeColor="Red">
                                </asp:CustomValidator>
                                <br /><br />
                                Review Notes for Co-chair (optional):
                                <asp:TextBox ID="CoChairCommentsTextBox" runat="server" Text='<%# Eval("Comments")%>'  CssClass="form-control" TextMode="MultiLine" />
                                <asp:HiddenField ID="hdnTopicGroup" runat="server" Value='<%# Bind("TopicGroupID")%>' />
                                <asp:HiddenField ID="hdnSessionID" runat="server" Value='<%# Bind("SessionID")%>' /></asp:Panel>
                                <br />
                                <br />
                                <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Decline") %>' AutoPostBack="true" OnCheckedChanged="DeclineCheckBox_CheckedChanged" />&nbsp;Return to Program Chairs.<br />
                                <asp:Label ID="CommentDeclineLabel" runat="server" Text='Common reasons for return to Program Chairs are listed below. Enter one of these or another reason in the comments box. Provide additional information as needed.' Visible="false" /><br />
                                <ul runat="server" id="declineReasons" visible="false">
                                    <li>Advise declining for <asp:Literal ID="ltlConferenceType" runat="server" Text="Conference"></asp:Literal>.</li>
                                    <li>Reroute abstract to Session __ (provide session code).</li>
                                    <li>Consider adding a new session topic __ (provide recommended session title) under Theme __ (provide theme number).</li>
                                    <li>This abstract is closely related to another abstract I reviewed. Consider having this combined with Abstract __ (provide abstract code).</li>
                                </ul>
                                <br />
                                <asp:TextBox ID="CommentsTextBox" runat="server" Text='<%# Eval("Comments") %>' CssClass="form-control" TextMode="MultiLine" Visible="false" Enabled="False" />
                                <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                                ControlToValidate="CommentsTextBox"
                                ErrorMessage="Please provide comments."
                                ForeColor="Red"
                                Enabled="false">
                                </asp:RequiredFieldValidator>
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
                                Decline: <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Decline") %>' Enabled="false" />
                                <br />
                                Review Date:
                                <asp:Label ID="ReviewDateLabel" runat="server" Text='<%# Eval("ReviewDate")%>' />

                                <br />
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-primary" />
                            </ItemTemplate>
                        </asp:FormView><br /><br />
                        <asp:HyperLink ID="lnkReturn" runat="server">Return to Session Chair Review Overview</asp:HyperLink>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:Image ID="Progress" runat="server" ImageUrl="~/images/ajax-loader.gif" Visible="false"/>
                        <asp:Label ID="Success" runat="server" Text="Review successfully recorded" Visible="false"></asp:Label>
                        <asp:Panel ID="PanelFinalize" runat="server" Visible="false">
                            <hr />
                            When your review reflects the final placement decision it must be finalized for the abstract to move to the next round.<br />
                            <asp:Label ID="lblFinalize" runat="server" Text="You must select a Topic or Decline the abstract.<br />" Visible="False" CssClass="text-danger"></asp:Label>
                            <asp:Button ID="btnFinalize" runat="server" Text="Accept My Review as Final for the entire Session" CssClass="btn btn-success" />
                            <%--<asp:HyperLink ID="lnkNeedsEdits" runat="server" CssClass="btn btn-warning">This Review Requires Further Discussion/Edits</asp:HyperLink>--%>
                            <asp:SqlDataSource ID="SqlDataSourceFinalize" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" UpdateCommand="AbstractReviewSessionChairFinalUpdate" UpdateCommandType="StoredProcedure">
                                <UpdateParameters>
                                    <asp:Parameter Name="AbstractReviewID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <hr />
                        </asp:Panel>
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
                                                <asp:HyperLink ID="hlMID" runat="server" Text="View" NavigateUrl='<%#GetRouteUrl("AbstractsReviewViewRoute", New With {
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
