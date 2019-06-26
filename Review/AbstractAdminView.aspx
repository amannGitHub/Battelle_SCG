<%@ Page Title="Abstract Review - Admin" Language="vb" AutoEventWireup="false" MasterPageFile="~/Review/Review.Master" CodeBehind="AbstractAdminView.aspx.vb" Inherits="Battelle.AbstractAdminView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><asp:Label ID="lblConferenceType" runat="server" Text="Conference"></asp:Label> 
        <%=Page.Title%></h1>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>


     <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:SqlDataSource ID="SqlDataSourceAbstractSelected" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractGetByAbstractID" SelectCommandType="StoredProcedure" >
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceAbstractSelected" RenderOuterTable="False">
                           
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnAbstractID" runat="server" Value='<%# Bind("AbstractID")%>' />
                                <b>Abstract Code:</b>
                    <asp:Label ID="AbstractCodeLabel" runat="server" Text='<%# Bind("AbstractCode") %>' />
                                <br />
                                <b>Title:</b>
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>' />
                                <br />
                                <b>Formatted Author List:</b>
                    <asp:Label ID="AuthorListLabel" runat="server" Text='<%# Bind("AuthorList") %>' />
                                <br />

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
                                <br /><br />

                           </ItemTemplate>

                        </asp:FormView>
                            
                    </div>

                     <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:SqlDataSource ID="SqlDataSourceProgramChairReviews" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewsGet" SelectCommandType="StoredProcedure" InsertCommand="AbstractProgramChairReviewInsertAdmin" InsertCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                                <asp:Parameter Name="RelatedAbstracts" Type="String" />
                                <asp:Parameter Name="TopicGroupID" Type="Int32" />
                                <asp:Parameter Name="SessionID" Type="Int32" />
                                <asp:Parameter Name="Comments" Type="String" />
                                <asp:Parameter Name="Decline" Type="Boolean" DefaultValue="False" />
                            </InsertParameters>
                        </asp:SqlDataSource>

            
                        <h4>Program Chair Review Results</h4>
                        <asp:GridView ID="gvProgramChairReviews" runat="server" AutoGenerateColumns="False" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceProgramChairReviews" EmptyDataText="There are no program chair reviews for this abstract." CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="ReviewType" HeaderText="Review Type" SortExpression="ReviewType" />
                                <asp:BoundField DataField="RelatedAbstracts" HeaderText="Related Abstracts" SortExpression="RelatedAbstracts" />
                                <asp:BoundField DataField="TopicGroupCode" HeaderText="Theme" SortExpression="TopicGroupCode" />
                                <asp:BoundField DataField="TopicCode" HeaderText="Topic" SortExpression="TopicCode" />
                                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                                <asp:CheckBoxField DataField="Decline" HeaderText="Decline" SortExpression="Decline" />
                                <asp:BoundField DataField="Reviewer" HeaderText="Reviewer" SortExpression="Reviewer" /> 
                                <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate" /> 
                                <asp:BoundField DataField="FinalDate" HeaderText="Final Review" SortExpression="FinalDate" />           
                            </Columns>
                        </asp:GridView>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="ButtonUnfinalize1" runat="server" Text="Unfinalize" Visible="false" CssClass="btn btn-warning" OnClientClick = "return confirm('Do you want to un-finalize program chair?')" OnClick="ButtonUnfinalize1_Click" />
                                <asp:SqlDataSource ID="SqlDataSourceUnfinalize" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" UpdateCommand="AbstractAdminReviewUnFinalizeUpdate" UpdateCommandType="StoredProcedure">
                                    <UpdateParameters>
                                        <asp:Parameter Name="AbstractID" Type="Int32" />
                                        <asp:Parameter Name="ReviewType" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>                                   
                            </div>
                        </div>

                        <asp:Panel ID="UpdatePanelProgramChair" runat="server" Visible="false">
                            <ContentTemplate>
                        <div class="row">
                            <div class="col-md-12">
                         <h3>Program Chair Review Form - Finalize</h3>
                         <asp:FormView ID="ProgramChairFormReview" runat="server" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceProgramChairReviews" RenderOuterTable="False" DefaultMode="Insert">
                            <InsertItemTemplate>
                                Related Abstracts (by Code):
                                <asp:TextBox ID="RelatedAbstractsTextBox" runat="server" Text='<%# Bind("RelatedAbstracts") %>' CssClass="form-control" />
                                <br />
                                Assign to a Theme (Select a code here or click "Decline" below):
                                <asp:DropDownList ID="ddlTopic" runat="server" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID" SelectedValue='<%# Bind("TopicGroupID") %>' AppendDataBoundItems="True" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlTopicProgramChairs_SelectedIndexChanged">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                Suggest a Topic (Optional):
                                <asp:DropDownList ID="ddlSession" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="SessionID" AppendDataBoundItems="True" CssClass="form-control">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                Decline: <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Decline") %>' />
                                <br /><br />
                                Comments:
                                <asp:TextBox ID="CommentsTextBox" runat="server" Text='<%# Bind("Comments") %>'  CssClass="form-control"/>
                                <br />
                                <div style="border:1px solid black; background-color:gainsboro; padding:5px;">
                                <strong>Note: Clicking the Insert button below will insert and finalize this program chair abstract review.</strong><br />
                                </div>
                                <br /><br />
                                <asp:LinkButton ID="ProgramChairInsertButton" runat="server" CausesValidation="False" Text="Insert Review" CssClass="btn btn-primary" OnClick="ProgramChairInsertButton_Click" />
                                <asp:Button ID="ProgramChairCancelButton" runat="server" CausesValidation="False" Text="Cancel" CssClass="btn btn-primary" OnClick="ProgramChairCancelButton_Click" />
                                <br /><br />
                            </InsertItemTemplate>
                        </asp:FormView>
                                </div>
                        </div>
                            </ContentTemplate>
                        </asp:Panel>             
                    </div>
                    <br />



                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:SqlDataSource ID="SqlDataSourceCommitteeReviews" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewsGet" SelectCommandType="StoredProcedure" InsertCommand="AbstractSteeringCommReviewInsertAdmin" InsertCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                                <asp:Parameter Name="RelatedAbstracts" Type="String" />
                                <asp:Parameter Name="TopicGroupID" Type="Int32" />
                                <asp:Parameter Name="SessionID" Type="Int32" />
                                <asp:Parameter Name="Comments" Type="String" />
                                <asp:Parameter Name="Decline" Type="Boolean" DefaultValue="False" />
                                <asp:Parameter Name="GeneralComments" Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <h4>Steering Committee Review Results</h4>
                        <asp:GridView ID="gvCommitteeReviews" runat="server" AutoGenerateColumns="False" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceCommitteeReviews" EmptyDataText="There are no steering committee reviews for this abstract." CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="ReviewType" HeaderText="Review Type" SortExpression="ReviewType" />
                                <asp:BoundField DataField="RelatedAbstracts" HeaderText="Related Abstracts" SortExpression="RelatedAbstracts" />
                                <asp:BoundField DataField="TopicGroupCode" HeaderText="Theme" SortExpression="TopicGroupCode" />
                                <asp:BoundField DataField="TopicCode" HeaderText="Topic" SortExpression="TopicCode" />
                                <%--<asp:BoundField DataField="GeneralComments" HeaderText="Comments" SortExpression="Comments" />--%>
                                <asp:CheckBoxField DataField="Decline" HeaderText="Decline" SortExpression="Decline" />
                                <asp:BoundField DataField="Reviewer" HeaderText="Reviewer" SortExpression="Reviewer" /> 
                                <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate" /> 
                                <asp:BoundField DataField="FinalDate" HeaderText="Final Review" SortExpression="FinalDate" />           
                            </Columns>
                        </asp:GridView>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="ButtonUnfinalize2" runat="server" CausesValidation="true" Text="Unfinalize" Visible="false" CssClass="btn btn-warning" OnClientClick = "return confirm('Do you want to un-finalize steering committee?')" OnClick="ButtonUnfinalize2_Click"  />                                   
                            </div>
                        </div>

                        <asp:Panel ID="UpdatePanelSteeringCommittee" runat="server" Visible="false">
                            <ContentTemplate>
                        <div class="row">
                            <div class="col-md-12">
                         <h3>Steering Committee Review Form - Finalize</h3>
                         <asp:FormView ID="SteeringCommitteeFormReview" runat="server" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceCommitteeReviews" RenderOuterTable="False" DefaultMode="Insert">
                            <InsertItemTemplate>
                                Related Abstracts (by Code):
                                <asp:TextBox ID="RelatedAbstractsTextBox" runat="server" Text='<%# Bind("RelatedAbstracts") %>' CssClass="form-control" />
                                <br />
                                Assign to a Theme (Select a code here or click "Decline" below):
                                <asp:DropDownList ID="ddlTopic" runat="server" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID" SelectedValue='<%# Bind("TopicGroupID") %>' AppendDataBoundItems="True" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlTopicSteeringCommittee_SelectedIndexChanged">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                Suggest a Topic (Optional):
                                <asp:DropDownList ID="ddlSession" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="SessionID" AppendDataBoundItems="True" CssClass="form-control">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                Review Notes:
                                <%--<asp:TextBox ID="GeneralCommentsTextBox" runat="server" Text='<%# Bind("GeneralComments")%>'  CssClass="form-control" TextMode="MultiLine" />--%>
                                <br />
                                <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Decline") %>' AutoPostBack="true" OnCheckedChanged="DeclineCheckBox_SteeringCommitteeCheckedChanged" />&nbsp;Return to Program Chairs for rereview. Common reasons for return to Program Chairs are listed below. Enter one of these or another reason in the comments box that will appear below if you click "Return". Provide additional information as needed.<br />
                                <ul>
                                    <li>Advise declining for Symposium</li>
                                    <li>Advise abstract be rerouted to another theme for Steering Committee Review</li>
                                    <li>Consider adding new session topic under this theme.</li>
                                    <li>This abstract is closely related to another abstract I reviewed. Consider having this combined with Abstract __.</li>
                                </ul>
                                <br /><br />
                                <asp:Label ID="CommentDeclineLabel" runat="server" Text='Comments: Reason for Return to Program Chairs' Visible="false" />
                                <asp:TextBox ID="CommentsTextBox" runat="server" Text='<%# Bind("Comments") %>' CssClass="form-control" Visible="false" />
                                <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                                ControlToValidate="CommentsTextBox"
                                ErrorMessage="Please provide comments."
                                ForeColor="Red"
                                Enabled="false">
                                </asp:RequiredFieldValidator>
                                <br />
                                <asp:CustomValidator ID="CustomValidator1" runat="server" 
                                ErrorMessage="The 'Return to Program Chairs for rereview' checkbox must be selected when comments are provided." 
                                onservervalidate="CustomValidator1_SteeringCommitteeServerValidate"
                                ForeColor="Red">
                                </asp:CustomValidator>
                                <br />
                                <div style="border:1px solid black; background-color:gainsboro; padding:5px;">
                                <strong>Note: Clicking the Insert button below will insert and finalize this steering committee abstract review.</strong><br />
                                </div>
                                <br /><br />
                                <asp:LinkButton ID="SteeringCommitteeInsertButton" runat="server" CausesValidation="False" Text="Insert Review" CssClass="btn btn-primary" OnClick="SteeringCommitteeInsertButton_Click" />
                                <asp:Button ID="SteeringCommitteeCancelButton" runat="server" CausesValidation="False" Text="Cancel" CssClass="btn btn-primary" OnClick="SteeringCommitteeCancelButton_Click" />                
                            </InsertItemTemplate>
                        </asp:FormView>
                                </div>
                        </div>
                            </ContentTemplate>
                        </asp:Panel>
                             
                    </div>
                    <br />

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <h4>Session Chair Review Results</h4>
                        <asp:GridView ID="gvSessionChairReviews" runat="server" AutoGenerateColumns="False" Visible="false" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceSessionChairReviews" EmptyDataText="There are no session chair reviews for this abstract." CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="ReviewType" HeaderText="Review Type" SortExpression="ReviewType" />
                                <asp:BoundField DataField="PresentationFormat" HeaderText="Suggested Format" SortExpression="PresentationFormat" />
                                <%--<asp:BoundField DataField="TopicGroupCode" HeaderText="Theme" SortExpression="TopicGroupCode" />
                                <asp:BoundField DataField="TopicCode" HeaderText="Topic" SortExpression="TopicCode" />--%>
                                <%--<asp:BoundField DataField="GeneralComments" HeaderText="Review Notes for Co-Chair" SortExpression="TopicCode" />--%>
                                <asp:CheckBoxField DataField="Decline" HeaderText="Returned to Program Chairs" SortExpression="Decline" />
                                <asp:BoundField DataField="Comments" HeaderText="Reason Returned" SortExpression="Comments" />
                                <asp:BoundField DataField="Reviewer" HeaderText="Reviewer" SortExpression="Reviewer" /> 
                                <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate" /> 
                                <asp:BoundField DataField="FinalDate" HeaderText="Final Review" SortExpression="FinalDate" />           
                            </Columns>
                        </asp:GridView>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="ButtonUnfinalize3" runat="server" CausesValidation="false" Text="Unfinalize" Visible="false" CssClass="btn btn-warning" OnClientClick = "return confirm('Do you want to un-finalize session chair?')" OnClick="ButtonUnfinalize3_Click" />                                   
                            </div>
                        </div>
                        <asp:Panel ID="UpdatePanelSessionChair" runat="server" Visible="false">
                            <ContentTemplate>
                                <div class="row">
                                    <div class="col-md-12">
                                        <h3>Session Chair Review Form - Finalize</h3>
                                        <asp:FormView ID="SessionChairFormReview" runat="server" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceSessionChairReviews" RenderOuterTable="false" DefaultMode="Insert">
                                            <InsertItemTemplate>
                                                Presentation Format:
                                                <asp:DropDownList ID="ddlSessionChairPresentationFormat" runat="server" DataSourceID="SqlDataSourceFormat" DataTextField="PresentationFormat" SelectedValue='<%# Bind("PresentationFormat") %>' AppendDataBoundItems="true" CssClass="form-control" AutoPostBack="true">
                                                    <asp:ListItem Value=""></asp:ListItem>
                                                </asp:DropDownList>
                                                <br />
                                                <%--Assign to a Theme (Select a code here or click "Decline" below):
                                                <asp:DropDownList ID="ddlSessionChairTopic" runat="server" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID" SelectedValue='<%# Bind("TopicGroupID") %>' AppendDataBoundItems="True" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlTopicSessionChair_SelectedIndexChanged">
                                                    <asp:ListItem Value=""></asp:ListItem>
                                                </asp:DropDownList>
                                                <br />
                                                Suggest a Topic (Optional):
                                                <asp:DropDownList ID="ddlSessionChairSession" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="SessionID" AppendDataBoundItems="True" CssClass="form-control">
                                                    <asp:ListItem Value=""></asp:ListItem>
                                                </asp:DropDownList>
                                                <br />--%>
                                                Review Notes:
                                                <%--<asp:TextBox ID="SessionChairGeneralCommentsTextBox" runat="server" Text='<%# Bind("GeneralComments")%>'  CssClass="form-control" TextMode="MultiLine" />--%>
                                                <br />
                                                <asp:CheckBox ID="SessionChairDeclineCheckBox" runat="server" Checked='<%# Bind("Decline") %>' AutoPostBack="true" OnCheckedChanged="DeclineCheckBox_SessionChairCheckedChanged" />&nbsp;Return to Program Chairs for rereview. Common reasons for return to Program Chairs are listed below. Enter one of these or another reason in the comments box that will appear below if you click "Return". Provide additional information as needed.<br />
                                                <ul>
                                                    <li>Advise declining for Symposium</li>
                                                    <li>Advise abstract be rerouted to another theme for Steering Committee Review</li>
                                                    <li>Consider adding new session topic under this theme.</li>
                                                    <li>This abstract is closely related to another abstract I reviewed. Consider having this combined with Abstract __.</li>
                                                </ul>
                                                <br /><br />
                                                <asp:Label ID="SessionChairCommentDeclineLabel" runat="server" Text='Comments: Reason for Return to Program Chairs' Visible="false" />
                                                <asp:TextBox ID="SessionChairCommentsTextBox" runat="server" Text='<%# Bind("Comments") %>' CssClass="form-control" Visible="false" />
                                                <asp:RequiredFieldValidator id="SessionChairRequiredFieldValidator1" runat="server"
                                                ControlToValidate="SessionChairCommentsTextBox"
                                                ErrorMessage="Please provide comments."
                                                ForeColor="Red"
                                                Enabled="false">
                                                </asp:RequiredFieldValidator>
                                                <br />
                                                <asp:CustomValidator ID="SessionChairCustomValidator1" runat="server" 
                                                ErrorMessage="The 'Return to Program Chairs for rereview' checkbox must be selected when comments are provided." 
                                                onservervalidate="CustomValidator1_SteeringCommitteeServerValidate"
                                                ForeColor="Red">
                                                </asp:CustomValidator>
                                                <br />
                                                <div style="border:1px solid black; background-color:gainsboro; padding:5px;">
                                                <strong>Note: Clicking the Insert button below will insert and finalize this session chair abstract review.</strong><br />
                                                </div>
                                                <br /><br />
                                                <asp:LinkButton ID="SessionChairInsertButton" runat="server" CausesValidation="False" Text="Insert Review" CssClass="btn btn-primary" OnClick="SessionChairInsertButton_Click" />
                                                <asp:Button ID="SessionChairCancelButton" runat="server" CausesValidation="False" Text="Cancel" CssClass="btn btn-primary" OnClick="SessionChairCancelButton_Click" />                           
                                            </InsertItemTemplate>
                                        </asp:FormView>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:Panel>
                        <asp:SqlDataSource ID="SqlDataSourceSessionChairReviews" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractSessionReviewsGet" SelectCommandType="StoredProcedure" InsertCommand="AbstractSessionChairReviewInsertAdmin" InsertCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                                <asp:Parameter Name="PresentationFormat" Type="String" />
                                <%--<asp:Parameter Name="TopicGroupID" Type="Int32" />
                                <asp:Parameter Name="SessionID" Type="Int32" />--%>
                                <asp:Parameter Name="Comments" Type="String" />
                                <asp:Parameter Name="Decline" Type="Boolean" DefaultValue="False" />
                                <%--<asp:Parameter Name="GeneralComments" Type="String" />--%>
                            </InsertParameters>
                        </asp:SqlDataSource>
                            
                    </div>

                    <br />
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <h4>Admin Review Results</h4>
                        <asp:GridView ID="gvAdminReview" runat="server" AutoGenerateColumns="False" Visible="false" DataKeyNames="AbstractID" DataSourceID="SqlDataSourceAdminReview" EmptyDataText="There are no admin reviews for this abstract." CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="TopicGroupCode" HeaderText="Theme" SortExpression="TopicGroupCode" />
                                <asp:BoundField DataField="TopicCode" HeaderText="Topic" SortExpression="TopicCode" />
                                <asp:BoundField DataField="FinalFormat" HeaderText="Final Format" SortExpression="FinalFormat" />
                                <asp:BoundField DataField="Declined" HeaderText="Declined?" SortExpression="FinalFormat" />
                                <asp:BoundField DataField="DeclineNotes" HeaderText="Admin Declined Notes" SortExpression="DeclineNotes" />
                                <asp:BoundField DataField="ReviewNotes" HeaderText="Admin Review Notes" SortExpression="ReviewNotes" />  
                                <asp:BoundField DataField="Reviewer" HeaderText="Reviewer" SortExpression="Reviewer" /> 
                                <asp:BoundField DataField="AdminReviewDate" HeaderText="Admin Review Date" SortExpression="AdminReviewDate" /> 
                                <asp:BoundField DataField="FinalDate" HeaderText="Final Review Date" SortExpression="FinalDate" />           
                            </Columns>
                        </asp:GridView>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="ButtonUnfinalize4" runat="server" CausesValidation="true" Text="Unfinalize" Visible="false" CssClass="btn btn-warning" OnClientClick = "return confirm('Do you want to un-finalize admin review?')"  />                                   
                            </div>
                        </div>
                        <asp:SqlDataSource ID="SqlDataSourceAdminReview" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractAdminGetByAbstractID" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br /><br />
                            
                    </div>


                </div>


                <div class="row">
                    <div class="col-lg-8 col-md-8 col-sm-8">
                        <!--Form-->
                        <asp:SqlDataSource ID="SqlDataSourceSessionReview" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractAdminSessionGetByAbstractID" SelectCommandType="StoredProcedure" InsertCommand="AbstractAdminUpdate" InsertCommandType="StoredProcedure" UpdateCommand="AbstractAdminUpdate" UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="ConferenceID" Type="Int32" />
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:Parameter Name="abstractID" Type="Int32" />
                                <asp:Parameter Name="TopicGroupID" Type="Int32" />
                                <asp:Parameter Name="SessionID" Type="Int32" />
                                <asp:Parameter Name="Declined" Type="Boolean" DefaultValue="False"  />
                                <asp:Parameter Name="ReadyForSessionChair" Type="Boolean" DefaultValue="True"  />
                                <asp:Parameter Name="SessionChairFinal" Type="Boolean" DefaultValue="False"  />                 
                                <asp:Parameter Name="ReviewNotes" Type="String" />
                                <asp:Parameter Name="FinalFormat" Type="String" />
                                <asp:Parameter Name="IsFinal" Type="Boolean" DefaultValue="False"  />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                                <asp:Parameter Name="DeclineNotes" Type="String"  />
                            </InsertParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="SqlDataSourceReview" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractAdminGetByAbstractID" SelectCommandType="StoredProcedure" InsertCommand="AbstractAdminUpdate" InsertCommandType="StoredProcedure" UpdateCommand="AbstractAdminUpdate" UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>

                            <UpdateParameters>
                                <asp:Parameter Name="abstractID" Type="Int32" />
                                <asp:Parameter Name="TopicGroupID" Type="Int32" />
                                <asp:Parameter Name="SessionID" Type="Int32" />
                                <asp:Parameter Name="Declined" Type="Boolean" DefaultValue="False"  />
                                <asp:Parameter Name="ReadyForSessionChair" Type="Boolean" DefaultValue="True"  />
                                <asp:Parameter Name="SessionChairFinal" Type="Boolean" DefaultValue="False"  />                 
                                <asp:Parameter Name="ReviewNotes" Type="String" />
                                <asp:Parameter Name="FinalFormat" Type="String" />
                                <asp:Parameter Name="IsFinal" Type="Boolean" DefaultValue="False"  />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                                <asp:Parameter Name="DeclineNotes" Type="String"  />
                            </UpdateParameters>

                            <InsertParameters>
                                <asp:Parameter Name="abstractID" Type="Int32" />
                                <asp:Parameter Name="TopicGroupID" Type="Int32" />
                                <asp:Parameter Name="SessionID" Type="Int32" />
                                <asp:Parameter Name="Declined" Type="Boolean" DefaultValue="False"  />
                                <asp:Parameter Name="ReadyForSessionChair" Type="Boolean" DefaultValue="True"  />
                                <asp:Parameter Name="SessionChairFinal" Type="Boolean" DefaultValue="False"  />                 
                                <asp:Parameter Name="ReviewNotes" Type="String" />
                                <asp:Parameter Name="FinalFormat" Type="String" />
                                <asp:Parameter Name="IsFinal" Type="Boolean" DefaultValue="False"  />
                                <asp:CookieParameter Name="PersonID" CookieName="PersonID" Type="Int32" />
                                <asp:Parameter Name="DeclineNotes" Type="String"  />
                            </InsertParameters>
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


                        <asp:SqlDataSource ID="SqlDataSourceFormat" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewFormatGet" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>

                        <asp:FormView ID="FormViewReview" runat="server" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceSessionReview" RenderOuterTable="False" Visible="true" DefaultMode="ReadOnly" EmptyDataText="No Records">
                            <InsertItemTemplate>
                                <asp:Panel ID="PanelAdd" runat="server" Visible="True">
                                <asp:HiddenField ID="hdnTopicGroupID" runat="server" Value="" />

                                <h3>Admin Review Form</h3>
                                Assigned Topic:
                                <asp:DropDownList ID="ddlTopic" runat="server" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID"  AppendDataBoundItems="True" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlTopic_SelectedIndexChanged">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="TopicValidator"
                                ControlToValidate="ddlTopic"
                                Text="Please select a topic from the above 'Assigned Topic' drop-down menu."
                                runat="server" ForeColor="Red" />
                                <br />
                                Assigned Session:
                                <asp:DropDownList ID="ddlSession" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="SessionID"  AppendDataBoundItems="True" CssClass="form-control" Enabled="true">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="SessionValidator"
                                ControlToValidate="ddlSession"
                                Text="Please select a session from the above 'Assigned Session' drop-down menu."
                                runat="server" ForeColor="Red" Visible="False" Enabled="False" />
                                <br />           
                                Assigned presentation format:
                                <asp:DropDownList ID="ddlFormat" runat="server" DataSourceID="SqlDataSourceFormat" DataTextField="presentationFormat" DataValueField="presentationFormat"   AppendDataBoundItems="True" CssClass="form-control">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="FormatValidator"
                                ControlToValidate="ddlFormat"
                                Text="Please select a presentation format from the above 'Assigned presentation format' drop-down menu."
                                runat="server" ForeColor="Red" Visible="False" Enabled="False" />
                                <br />
                                Review Notes:
                                <asp:TextBox ID="CommentsTextBox" runat="server" Text= "" CssClass="form-control"/>
                                <asp:HiddenField ID="isFinal"  runat="server" />


                                <br />
                                <br />
                                <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Declined")%>' AutoPostBack="true" OnCheckedChanged="DeclineCheckBox_CheckedChanged" />&nbsp;Decline Abstract.<br /><br />
                                <asp:Label ID="CommentDeclineLabel" runat="server" Text='Comments: Reason for Decline' Visible="false" /><br />
                                <asp:TextBox ID="DeclineTextBox" runat="server" Text=''  CssClass="form-control" TextMode="MultiLine" Visible="false" />
                                <asp:RequiredFieldValidator id="DeclineValidator" runat="server"
                                ControlToValidate="DeclineTextBox"
                                ErrorMessage="Please provide decline comments."
                                ForeColor="Red"
                                Enabled="false">
                                </asp:RequiredFieldValidator>


                                <br />
                                <asp:LinkButton ID="AddButton" runat="server"  Text="Add Review" CssClass="btn btn-primary"  OnClick="InsertButton_Click"  />&nbsp;<asp:LinkButton ID="LinkButtonCancel" runat="server" CommandName="Cancel" CausesValidation="False" OnClick="CancelButton_Click" >Cancel</asp:LinkButton>

                                </asp:Panel>
                            </InsertItemTemplate>
                            <EditItemTemplate>
                                <asp:Panel ID="PanelAccept" runat="server" Visible="True">
                                <asp:HiddenField ID="hdnTopicGroupID" runat="server" Value='<%# Bind("TopicGroupID")%>' />

                                <h3>Admin Review Form</h3>
                                Assigned Topic:
                                <asp:DropDownList ID="ddlTopic" runat="server" DataSourceID="SqlDataSourceTopicGroup" DataTextField="TopicName" DataValueField="TopicGroupID" SelectedValue='<%# Bind("TopicGroupID") %>'  AppendDataBoundItems="True" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlTopic_SelectedIndexChanged">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="TopicValidator"
                                ControlToValidate="ddlTopic"
                                Text="Please select a topic from the above 'Assigned Topic' drop-down menu."
                                runat="server" ForeColor="Red" />
                                <br />
                                Assigned Session:
                                <asp:DropDownList ID="ddlSession" runat="server" DataSourceID="SqlDataSourceSession" DataTextField="TopicName" DataValueField="SessionID"  AppendDataBoundItems="True" CssClass="form-control" Enabled="true">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="SessionValidator"
                                ControlToValidate="ddlSession"
                                Text="Please select a session from the above 'Assigned Session' drop-down menu."
                                runat="server" ForeColor="Red" Enabled="False" Visible="False" />
                                <br />           
                                Assigned presentation format:
                                <asp:DropDownList ID="ddlFormat" runat="server" DataSourceID="SqlDataSourceFormat" DataTextField="presentationFormat" DataValueField="presentationFormat" SelectedValue= '<%# Bind("FinalFormat")%>'   AppendDataBoundItems="True" CssClass="form-control">
                                    <asp:ListItem Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="FormatValidator"
                                ControlToValidate="ddlFormat"
                                Text="Please select a presentation format from the above 'Assigned presentation format' drop-down menu."
                                runat="server" ForeColor="Red" Enabled="False" Visible="False" />
                                <br />
                                Review Notes:
                                <asp:TextBox ID="CommentsTextBox" runat="server" Text='<%# Bind("ReviewNotes")%>'  CssClass="form-control"/>
                                <asp:HiddenField ID="isFinal" Value= '<%# Bind("SessionChairFinal")%>'  runat="server" />
                                <br />
                                <br />
                                <asp:CheckBox ID="DeclineCheckBox" runat="server" Checked='<%# Bind("Declined")%>' AutoPostBack="true" OnCheckedChanged="DeclineCheckBox_CheckedChanged" />&nbsp;Decline Abstract.<br /><br />
                                <asp:Label ID="CommentDeclineLabel" runat="server" Text='Comments: Reason for Decline' Visible="false" /><br />
                                <asp:TextBox ID="DeclineTextBox" runat="server" Text='<%# Bind("DeclineNotes")%>'  CssClass="form-control" TextMode="MultiLine" Visible="false" />
                                
                                <asp:RequiredFieldValidator id="DeclineValidator" runat="server"
                                ControlToValidate="DeclineTextBox"
                                ErrorMessage="Please provide decline comments."
                                ForeColor="Red"
                                Enabled="false">
                                </asp:RequiredFieldValidator>
                                <br />
                                <asp:LinkButton ID="UpdateButton" runat="server"  Text="Update Review" CssClass="btn btn-primary" CausesValidation="true" OnClick="UpdateButton_Click"  />&nbsp;<asp:LinkButton ID="LinkButtonCancel" runat="server" CommandName="Cancel" CausesValidation="False" OnClick="CancelButton_Click" >Cancel</asp:LinkButton>
                                </asp:Panel>
                            </EditItemTemplate>
                            <ItemTemplate>

                              
                    Click &#39;Edit&#39; if you wish to update the information displayed here, otherwise click the "Accept My Admin Review as Final" button to finalize abstract session review.
                    <br />
                    <div class="container-fluid">
                        <asp:HiddenField ID="hdnAbstractID" runat="server" Value='<%# Bind("AbstractID")%>' />
                        <asp:HiddenField ID="hdnTopicGroupID" runat="server" Value='<%# Bind("TopicGroupID")%>' />
                        <asp:HiddenField ID="hdnSessionID" runat="server" Value='<%# Bind("SessionID")%>' />
                        <div class="row">
                            <div class="col-md-12">
                                <b>Assigned Topic:</b>
                                <asp:Label ID="AssignedTopicLabel" runat="server" Text='<%# Bind("TopicGroupCode")%>' />&nbsp;
                                <asp:Label ID="AssignedTopicGroupLabel" runat="server" Text='<%# Bind("TopicGroup")%>' /> 
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Assigned Session:</b>
                                <asp:Label ID="AssignedSessionLabel" runat="server" Text='<%# Bind("TopicCode")%>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <b>Assigned presentation format:</b>
                                <asp:Label ID="AssignedPresentationLabel" runat="server" Text='<%# Bind("FinalFormat")%>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <b>Review Notes for Co-Chair:</b>
                                <asp:Label ID="ReviewNotesLabel" runat="server" Text='<%# Bind("ReviewNotes")%>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <b>Declined?</b>
                                <asp:Label ID="DeclineLabel" runat="server" Text='<%# Bind("Declined")%>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <b>Declined Notes:</b>
                                <asp:Label ID="DeclineLabelNotes" runat="server" Text='<%# Bind("DeclineNotes")%>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <asp:LinkButton ID="EditAuthorButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" OnClick="AdminReviewEdit_Click" />
                            </div>
                        </div>

                    </div>
                            </ItemTemplate>
                        </asp:FormView>          
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:Panel ID="PanelFinalize" runat="server" Visible="false">
                            <hr />
                            <asp:Label ID="lblFinalize" runat="server" Text="" Visible="False" CssClass="text-danger"></asp:Label><br />
                            <asp:Button ID="btnFinalize" runat="server" Text="Accept My Admin Review as Final" CssClass="btn btn-success" />
                            <asp:SqlDataSource ID="SqlDataSourceFinalize" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" UpdateCommand="AbstractAdminFinalUpdate" UpdateCommandType="StoredProcedure">
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
                        <asp:HyperLink ID="lnkReturn" runat="server">Return to Admin Review Overview</asp:HyperLink>
                    </div>
                </div>






                    
           </div>


            </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
