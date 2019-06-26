<%@ Page Title="Abstract View" Language="vb" AutoEventWireup="false" MasterPageFile="~/Review/Review.Master" CodeBehind="AbstractView.aspx.vb" Inherits="Battelle.AbstractView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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
                                <br />
 

                            </ItemTemplate>


                        </asp:FormView>
                            
                    </div>
                     <div class="col-lg-12 col-md-12 col-sm-12">
                        <h4>Review Results</h4>
                        <asp:GridView ID="gvOtherReviews" runat="server" AutoGenerateColumns="False" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceOtherReviews" EmptyDataText="You are the first to review this abstract." CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="ReviewType" HeaderText="Review Type" SortExpression="ReviewType" />
                                <asp:BoundField DataField="SubmissionRequestedBy" HeaderText="Submission Requested By" SortExpression="SubmissionRequestedBy" />
                                <asp:BoundField DataField="TopicGroupCode" HeaderText="Theme" SortExpression="TopicGroupCode" />
                                <asp:BoundField DataField="TopicCode" HeaderText="Topic" SortExpression="TopicCode" />
                                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                                <asp:CheckBoxField DataField="Decline" HeaderText="Decline" SortExpression="Decline" />
                                <asp:BoundField DataField="Reviewer" HeaderText="Reviewer" SortExpression="Reviewer" /> 
                                <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate" /> 
                                <asp:BoundField DataField="FinalDate" HeaderText="Final Review" SortExpression="FinalDate" />           
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceOtherReviews" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractReviewsGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        
                        
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:GridView ID="gvSessionChairReviews" runat="server" AutoGenerateColumns="False" Visible="false" DataKeyNames="AbstractReviewID" DataSourceID="SqlDataSourceSessionChairReviews" EmptyDataText="You are the first to review this abstract." CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="ReviewType" HeaderText="Review Type" SortExpression="ReviewType" />
                                <asp:BoundField DataField="PresentationFormat" HeaderText="Suggested Format" SortExpression="ReviewType" />
                                <%--<asp:BoundField DataField="GeneralComments" HeaderText="Review Notes for Co-Chair" SortExpression="TopicCode" />--%>
                                <asp:CheckBoxField DataField="Decline" HeaderText="Returned to Program Chairs" SortExpression="Decline" />
                                <asp:BoundField DataField="Comments" HeaderText="Reason Returned" SortExpression="Comments" />
                                <asp:BoundField DataField="Reviewer" HeaderText="Reviewer" SortExpression="Reviewer" /> 
                                <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate" /> 
                                <asp:BoundField DataField="FinalDate" HeaderText="Final Review" SortExpression="FinalDate" />           
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceSessionChairReviews" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AbstractSessionReviewsGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="AbstractID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        
                        
                    </div>


                </div>
                    </div>

                


</asp:Content>
