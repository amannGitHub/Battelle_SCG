<%@ Page Title="Registration" Language="vb" AutoEventWireup="false" MasterPageFile="~/Registration/Registration.Master" CodeBehind="RegForm.aspx.vb" Inherits="Battelle.RegForm" %>

<%@ Register Src="../ParticipationIDLogin.ascx" TagName="ParticipationIDLogin" TagPrefix="uc1" %>
<%@ Register Src="~/SessionHandler.ascx" TagPrefix="controls" TagName="SessionHandler" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        <asp:Label ID="lblConferenceType" runat="server" Text="Conference"></asp:Label>
        Registration</h1>
    <asp:SqlDataSource ID="SqlDataSourceReg" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceAttendanceGetByPersonID" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="PersonID" Type="Int32" />
            <asp:Parameter Name="ConferenceID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel ID="PanelParticipationControl" runat="server" Visible="True">
        <asp:Panel ID="PanelParticipationControlTechReg" runat="server" Visible="false">
            <div class="container">
                <div class="row">

                    <div class="col-md-12">
                        <div class="alert alert-danger" role="alert">
                        <h3 class="text-danger">You must have the Participant Code of the person you are registering as a discounted technical registrant. If you are the POC for the booth, do not enter your own Participant Code unless you are attending the conference as a technical registrant.</h3>
                            </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" />
    </asp:Panel>

    <asp:Panel ID="PanelForm" runat="server" Visible="False">
        <asp:SqlDataSource ID="SqlDataSourceFees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ConferenceFeeGetForRegistration" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblAlert" runat="server" Text=""></asp:Label>
        <div class="form-group">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h3>
                            <asp:Label ID="lblFeesHeader" runat="server" Text="Technical Program Registration Fees"></asp:Label></h3>
                        <asp:Label ID="lblFeesCover" runat="server" Text="The following fees cover admission to all platform and poster sessions, exhibits, group lunches, 
                        receptions, and daily continental breakfasts and refreshment breaks. Registration materials will include the final program
                        and abstracts. Fees will increase after "></asp:Label>
                        <asp:Label ID="lblRegFeeIncrease" runat="server" Text="[Date]"></asp:Label>
                    </div>
                </div>
                <asp:Panel ID="PanelMain" runat="server">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:RadioButton ID="rblIndustry" runat="server" GroupName="RegGroup" />
                            <asp:Label ID="lblIndustry" runat="server" Text="Industry" AssociatedControlID="rblIndustry"></asp:Label>
                        </div>
                        <div class="col-md-2">
                            US $<asp:Label ID="lblIndustryFee" runat="server" Text="0"></asp:Label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <asp:RadioButton ID="rblGovt" runat="server" GroupName="RegGroup" />
                            <asp:Label ID="lblGovt" runat="server" Text="Government" AssociatedControlID="rblGovt"></asp:Label>
                        </div>
                        <div class="col-md-2">US $<asp:Label ID="lblGovtFee" runat="server" Text="0"></asp:Label></div>

                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <asp:RadioButton ID="rblUniv" runat="server" GroupName="RegGroup" />
                            <asp:Label ID="lblUniv" runat="server" Text="University" AssociatedControlID="rblGovt"></asp:Label>*
                        </div>
                        <div class="col-md-2">US $<asp:Label ID="lblUnivFee" runat="server" Text="0"></asp:Label></div>

                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <asp:RadioButton ID="rblStudent" runat="server" GroupName="RegGroup" />
                            <asp:Label ID="lblStudent" runat="server" Text="Student" AssociatedControlID="rblStudent"></asp:Label>**
                        </div>
                        <div class="col-md-2">US $<asp:Label ID="lblStudentFee" runat="server" Text="0"></asp:Label></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <small>*The university fee applies to <b>full-time faculty</b> and other teaching and research staff, including post-doctoral students.<br />
                                **The student fee is reserved for <b>full-time students through Ph.D. candidates</b> whose fees will be paid by their universities or who will not be reimbursed for out-of-pocket payment. Documentation of current enrollment is required.
                           <br />
                                <br />
                            </small>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="PanelOneTime" runat="server" Visible="false">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:RadioButton ID="rblOneTime" runat="server" GroupName="RegGroup" />
                            <asp:Label ID="lblOneTime" runat="server" Text="One Day Pass" AssociatedControlID="rblOneTime"></asp:Label>
                        </div>
                        <div class="col-md-2">US $<asp:Label ID="lblOneTimeFee" runat="server" Text="0"></asp:Label> per day</div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-sm-5">
                            <asp:Label ID="lblPickDate" runat="server" Text="Choose your day:" CssClass="sr-only"></asp:Label>
                            <asp:CheckBoxList ID="chkOneTimeDate"  CssClass="checkbox" runat="server"></asp:CheckBoxList>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="PanelExhibPass" runat="server" Visible="false">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:RadioButton ID="rblExhibPass" runat="server" GroupName="RegGroup" />
                            <asp:Label ID="lblExhibPass" runat="server" Text="Exhibit Hall Pass (per day)" AssociatedControlID="rblExhibPass"></asp:Label>
                        </div>
                        <div class="col-md-2">US $<asp:Label ID="lblExhibPassFee" runat="server" Text="0"></asp:Label></div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-sm-5">
                            <asp:Label ID="lblPickDateExhibPass" runat="server" Text="Choose your day:" CssClass="sr-only"></asp:Label>
                            <asp:CheckBoxList ID="chkExhibPassDate"  CssClass="checkbox" runat="server"></asp:CheckBoxList>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <asp:RadioButton ID="rblExhibPassWeek" runat="server" GroupName="RegGroup" />
                            <asp:Label ID="lblExhibPassWeek" runat="server" Text="Exhibit Hall Pass (full week)" AssociatedControlID="rblExhibPass"></asp:Label>
                        </div>
                        <div class="col-md-2">US $<asp:Label ID="lblExhibPassWeekFee" runat="server" Text="0"></asp:Label></div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="PanelTechReg" runat="server" Visible="false">
                    <asp:SqlDataSource ID="SqlDataSourceOrgValidate" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="AttendanceExhibitorCheck" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                           <asp:Parameter Name="ConferenceID" Type="Int32" />
                           <asp:ControlParameter ControlID="txtOrgID" Name="OrganizationID" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="SqlDataSourceGovNonProfit" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCoursePromoCodeCheck" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                        <asp:Parameter Name="PersonID" Type="Int32" />
                        <asp:Parameter Name="ConferenceID" Type="Int32" />
                        <asp:Parameter Name="CourseID" Type="Int32" /> 
                        <asp:Parameter Name="ShortCoursePromoCode_IN" Type="String" />
                    </SelectParameters>
                    </asp:SqlDataSource>

                    <div class="row" id="techRegFee" runat="server">
                        <div class="col-md-5">
                            <asp:RadioButton ID="rblTechReg" runat="server" GroupName="RegGroup" />
                            <asp:Label ID="lblTechReg" runat="server" Text="Technical Registration" AssociatedControlID="rblTechReg"></asp:Label>                       
                        </div>
                        <div class="col-md-2">US $<asp:Label ID="lblTechRegFee" runat="server" Text="0"></asp:Label></div><br /><br /> 
                    </div>
                    <div class="row" id="techRegGovNonProfitFee" runat="server">
                      <div class="col-md-5">
                        <asp:RadioButton ID="rblTechRegGovNonProfit" runat="server" GroupName="RegGroup" />
                        <asp:Label ID="lblTechRegGovNonProfit" runat="server" Text="Technical Registration - Non-Profit/Government Discount" AssociatedControlID="rblTechRegGovNonProfit"></asp:Label>
                       </div>
                       <div class="col-md-2">US $<asp:Label ID="lblTechRegGovNonProfitRegFee" runat="server" Text="0"></asp:Label></div><br /><br /> 
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label ID="lblTechRegDiv" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblOrgID" runat="server" Text="*Organization ID:" AssociatedControlID="txtOrgID"></asp:Label> 
                            <small>(Note: the organization ID can be found in the booth confirmation email, sent to your company’s point of contact at the time of booth reservation.)</small>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <asp:TextBox ID="txtOrgID" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:Button ID="btnOrgValidate" runat="server" Text="Validate" CssClass="btn btn-default" />                                   
                                </span>                                                        
                            </div>

                            <div class="help-block">
                                <asp:Label ID="lblOrgValid" runat="server" Text="" Visible="false"></asp:Label>
                            </div>

                            <span class="input-group-btn">
                               <asp:Button ID="ButtonOrgEmail" runat="server" Text="I need my Organization ID" CssClass="btn btn-primary" UseSubmitBehavior="False" />
                            </span>
                                                
                            <asp:Label ID="lblTechRegDivClose" runat="server" Text="</div>"></asp:Label>
                        </div>
                    </div>

                    <!--New code to send organization ID email-->
                    <asp:SqlDataSource ID="SqlDataSourcePersonIDFromEmail" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonGetByEmail" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="TextBoxOrgEmail" Name="Email" PropertyName="Text" Type="String" />
                    </SelectParameters>
                    </asp:SqlDataSource>

                    <div class="row">                      
                        <asp:Panel ID="PanelOrgEmail" runat="server" Visible="false">
                            <div class="form-group">                             
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12">
                                        <asp:Label ID="lblEnterEmail" runat="server" Text="Please enter your email address; use the email you use most commonly for professional activities." AssociatedControlID="TextBoxOrgEmail"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <asp:TextBox ID="TextBoxOrgEmail" runat="server" CssClass="form-control" ValidationGroup="EmailValidate"></asp:TextBox>
                                        <span class="input-group-btn"><asp:Button ID="ButtonCheckOrgEmail" runat="server" Text="Go" CssClass="btn btn-default" ValidationGroup="EmailValidate" /></span>
                                   </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="Please enter a valid email." ControlToValidate="TextBoxOrgEmail" ValidationGroup="EmailValidate"></asp:RequiredFieldValidator>
                                </div>
                                </div>
                                                             
                            </div>
                        </div>
                       </asp:Panel>                                                                    
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                           <asp:Label ID="LabelCheckEmailResult" runat="server" Text=""></asp:Label>
                      </div>
                    </div>
                    <!--end code to send organization ID Email-->

                </asp:Panel>
                <asp:Panel ID="PanelWaived" runat="server" Visible="false">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:RadioButton ID="rblWaived" runat="server" GroupName="RegGroup" />
                            <asp:Label ID="lblWaived" runat="server" Text="Waived Registration Fee" AssociatedControlID="rblWaived"></asp:Label>

                        </div>
                        <div class="col-md-2">US $<asp:Label ID="lblWaivedFee" runat="server" Text="0"></asp:Label></div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">

                            <asp:Label ID="lblWaivedNotes" runat="server" Text="*Reason for waiver:" AssociatedControlID="txtWaiveNotes"></asp:Label>

                            <asp:TextBox ID="txtWaiveNotes" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>


                        </div>
                    </div>
                </asp:Panel>

                <div class="row">
                    <div class="col-md-12">
                        <small>
                            <br />
                            Because registration fees are the major source of funding for the 
                            <asp:Label ID="lblConferenceType2" runat="server" Text="Conference"></asp:Label>
                            and a significant percentage 
                            of registrants will make presentations or 
                            chair sessions, <b><i>all presenting authors and session chairs are expected to register before the 
                            <asp:Label ID="lblConferenceType3" runat="server" Text="Conference"></asp:Label>
                                and pay the standard fees.</i></b>
                            No one under 18 years of age will be admitted to any 
                            <asp:Label ID="lblConferenceType4" runat="server" Text="Conference"></asp:Label>
                            event.
                        <br />
                            <br />
                        </small>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-12">
                        <asp:Panel ID="pnlDefunctSpecialNeeds" Visible="false" runat="server">
                            <asp:Label ID="lblSpecialNeeds" runat="server" Text="Special Needs" AssociatedControlID="txtSpecialNeeds"></asp:Label>
                            <small>(e.g. dietary, wheelchair access)</small>
                            <asp:TextBox ID="txtSpecialNeeds" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                        </asp:Panel>
                        <div class="alert alert-warning" role="alert">
                            <p>Food and beverage options for breaks, breakfasts, lunches, and receptions are selected to accommodate a wide range of culinary tastes and dietary restrictions, however, due to the large number of people being served at each function, special dietary requests may not be met. If you have severe food allergies please contact us at <asp:Label ID="lblEmail" runat="server"></asp:Label> to discuss your dietary needs. Also, please notify us if you have other special needs (e.g., wheelchair access).</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3>Privacy</h3>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <small>The Scientific  Consulting Group, Inc. (SCG) does not record or store credit card information. 
                            The contact information (affiliation, postal address, office telephone number, and email address) 
                            you enter on the registration form will be used as needed by SCG and Battelle environmental 
                            conferences staff to communicate with you and  send you updates before and during the 
                            <asp:Label ID="lblConference" runat="server" Text="[Conference Name Here]"></asp:Label>
                            and  to send you a link to an optional post-conference survey. By submitting your registration, 
                            you agree to the uses outlined above. SCG and/or Battelle  environmental conferences staff may contact you by mail or email to let you 
                                know about future conferences you may be interested in participating in. You will have the 
                                opportunity to opt out of subsequent contacts on a conference-by-conference basis.</small>
                             <br />
                            <br />
                            To see SCG&rsquo;s
                            <asp:Label ID="lblConferenceType5" runat="server" Text="Conference"></asp:Label>
                            Online Registration Privacy Statement, 
                                click
                            <asp:LinkButton ID="lnkbtnPrivacy" runat="server" OnClientClick="window.open('privacy','Privacy','resizeable=yes,scrollbars=yes,width=700,height=600');return false;">here</asp:LinkButton>. 
                                <small>(Be sure to allow pop-ups for this site.)</small><br />
                            <br />

                        <div class="panel panel-primary">    
                            <div class="panel-heading"><h3 class="panel-title">Conference Registration List Opt-In</h3></div>
                            <div class="panel-body alert-info">

                            If you want your name and contact information to be included in registration lists provided to other  
                            <asp:Label ID="lblConference2" runat="server" Text="[Conference Name Here]"></asp:Label>
                            attendees and exhibitors, <b>you must opt in</b>. To opt in, please check the box below. If you do not check the box below you will not be included in registration lists.
                                </div>
                            <div class="panel-footer">
                            <asp:CheckBox ID="chkOptin" runat="server" />&nbsp;
                            <asp:Label ID="lblOptOut" runat="server" Text="<u>YES, INCLUDE ME</u> in registration lists" AssociatedControlID="chkOptin"></asp:Label>
                            <b>for the 
                            <asp:Label ID="lblConference3" runat="server" Text="[Conference Name Here]"></asp:Label>.</b></div>


                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3>Refunds</h3>
                        <small>Registration cancellations and refund requests must be received in writing on or before the 
                            "cancellation requested date" below to qualify. Paid no-shows will receive all the materials covered by their 
                            registration fees. Refunds will be processed to the credit card used for payment. 
                            No refunds will be made after <asp:Literal ID="ltl50PercentToDate3" runat="server"></asp:Literal> for any reason. 
                            By registering for the <asp:Label ID="lblConferenceType6" runat="server" Text="Conference"></asp:Label>, you agree to the 
                            following registration cancellation refund policy:<br /><br /></small>
                        <table class="table">
                            <tr>
                                <th>Registration Cancellation Requested Date</th>
                                <th>Refund</th>
                            </tr>
                            <tr>
                                <td>By <asp:Literal ID="ltl75PercentDate" runat="server"></asp:Literal></td>
                                <td>75% of the registration fee (less a $<asp:Literal ID="ltlServiceFee1" runat="server"></asp:Literal> service fee)</td>
                            </tr>
                            <tr>
                                <td><asp:Literal ID="ltl50PercentFromDate" runat="server"></asp:Literal> to <asp:Literal ID="ltl50PercentToDate" runat="server"></asp:Literal></td>
                                <td>50% of the registration fee (less a $<asp:Literal ID="ltlServiceFee2" runat="server"></asp:Literal> service fee)</td>
                            </tr>
                            <tr>
                                <td>After <asp:Literal ID="ltl50PercentToDate2" runat="server"></asp:Literal></td>
                                <td>No refunds</td>
                            </tr>
                        </table>
                        <small>If Battelle cancels the 
                            <asp:Label ID="lblConferenceType7" runat="server" Text="Conference"></asp:Label>
                            due to circumstances 
                            beyond Battelle&rsquo;s reasonable control such as, but not limited to, acts of God, acts of war, 
                            government emergency, labor strikes, and/or unavailability of the event or exhibition facility, 
                            Battelle shall refund to attendee his/her previously paid registration fee(s) less a share of 
                            event cost incurred by Battelle. This refund shall be the attendee&rsquo;s exclusive remedy and 
                            Battelle&rsquo;s sole liability for cancellation of the event for reasons generally described 
                            in this paragraph.</small><br />
                        <br />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12"><h3>Terms and Conditions</h3>
                        Terms and Conditions are located at <asp:HyperLink ID="lnkRegTC" runat="server" NavigateUrl="https://www.battelle.org/newsroom/conferences" Target="_blank">the Battelle Conferences Site</asp:HyperLink>.
                        <br /><br />
                        <asp:Literal ID="ltlRegTCAlert" runat="server" Visible="false">
                            <div class="alert alert-danger" role="alert">
                                <p>Please indicate that you have read and agree to the Registration Terms and Conditions listed in the link above.</p>
                            </div>
                        </asp:Literal>
                        <asp:CheckBox ID="chkRegTC" runat="server" />&nbsp;<asp:Label ID="lblRegTC" runat="server" Text="I have read and agree to the Terms and Conditions listed in the link above." AssociatedControlID="chkRegTC"></asp:Label>
                        <br /><br />
                    </div>
                </div>
                <asp:Panel ID="pnlShortCourse" runat="server">
                <div class="row">
                    <div class="col-md-12"><h3>Short Courses</h3>
                        <asp:Literal ID="ltlShortCourse" runat="server" Visible="true">
                            <div class="alert alert-success" role="alert">
                                <p>Please indicate if you would like to sign up for Short Courses at this time. You will be taken to the Short Course registration as part of the registration process.</p>
                            </div>
                        </asp:Literal>
                        <asp:CheckBox ID="chkShourtCourse" runat="server" />&nbsp;<asp:Label ID="lblShortCourse" runat="server" Text="I would like to sign up for Short Courses at this time" AssociatedControlID="chkShourtCourse"></asp:Label>
                        <br /><br />
                    </div>
                </div>
                </asp:Panel>
                <div class="row">
                    <div class="col-md-12">
                        <asp:Button ID="btnNext" runat="server" Text="Next Step >>" CssClass="btn btn-primary" />&nbsp;<asp:Label ID="lblMessage" runat="server" Text="Please enter your Organization ID (as provided by the Booth point of contact)." Visible="False"></asp:Label>
                    </div>
                </div>

            </div>

        </div>
    </asp:Panel>
    <asp:Panel ID="PanelPayment" runat="server" Visible="False">

        <h4>Payment</h4>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <b>Selected Registration:</b>
                    <asp:Label ID="lblRegistration" runat="server" Text=""></asp:Label>

                    <asp:Label ID="lblSpacer" runat="server" Text="&nbsp;-&nbsp;" Visible="False"></asp:Label>
                    <asp:Label ID="lblSelectedDate" runat="server" Text="" Visible="False"></asp:Label><asp:HiddenField ID="hdnDate" runat="server" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <b>Special Needs:</b>
                    <asp:Label ID="lblSpecialNeeds2" runat="server" Text="None"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <b>Include me in the Registration List:</b>
                    <asp:Label ID="lblOptIn2" runat="server" Text=""></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <b>Total Fee:</b> US $<asp:Label ID="lblFee" runat="server" Text="0"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <div class="form-group">
                        <asp:RadioButtonList ID="radPayment" runat="server" RepeatDirection="Vertical" CellPadding="2" CellSpacing="2">
                            <asp:ListItem Text=" Credit Card" Value="Credit Card"></asp:ListItem>
                            <asp:ListItem Text=" Check/Purchase Order/Electronic Funds Transfer (EFT)" Value="Check"></asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorPayment" runat="server" ErrorMessage="Please select a payment option." ControlToValidate="radPayment" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <asp:Button ID="btnNextPay" runat="server" Text="Next Step>>" CssClass="btn btn-primary" /><br />
                    If paying by Credit Card, please complete the transaction within 5 minutes to avoid payment errors.
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-6">
                    <br />
                    <br />
                    <small><small>
                        <asp:LinkButton ID="lnkbtnShowAdmin" runat="server" CausesValidation="False">Admin</asp:LinkButton></small></small>
                    <asp:Panel ID="PanelAdminCode" runat="server" Visible="False">
                        <asp:Label ID="lblAdminDiv" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblAdminCode" runat="server" Text="Admin Code:" AssociatedControlID="txtAdminCode"></asp:Label>
                        <div class="input-group">
                            <asp:TextBox ID="txtAdminCode" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnAdminCheck" runat="server" Text="Validate" CssClass="btn btn-default" CausesValidation="False" /></span>

                        </div>
                        <div class="help-block">
                            <asp:Label ID="lblAdminValid" runat="server" Text="" Visible="false"></asp:Label>
                        </div>
                        <asp:Label ID="lblAdminDivClose" runat="server" Text="</div>"></asp:Label>
                    </asp:Panel>

                </div>
            </div>
        </div>


        <asp:HiddenField ID="hdnNewStart" runat="server" />


        <asp:SqlDataSource ID="SqlDataSourceAttendance" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="ConferenceAttendanceInsert" InsertCommandType="StoredProcedure" SelectCommand="ConferenceCouponCheck" SelectCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
                <asp:Parameter Name="PersonID" Type="Int32" />
                <asp:Parameter Name="FeeTypeID" Type="Int32" />
                <asp:Parameter Name="Amount" Type="Decimal" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="ExhibitorID" Type="Int32" />
                <asp:Parameter Name="RegListOptOut" Type="Boolean" />
                <asp:Parameter Name="SpecialNeeds" Type="String" />
                <asp:Parameter Name="RegistrationType" Type="String" />
                <asp:Parameter Name="OneDayPassDate" Type="String" />
                <asp:Parameter Name="CouponCode" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
                <asp:Parameter Name="CouponCode" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceLedger" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" InsertCommand="ConferenceLedgerInsert" InsertCommandType="StoredProcedure" SelectCommand="ConferenceFeeGetByType" SelectCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
                <asp:Parameter Name="PersonID" Type="Int32" />
                <asp:Parameter Name="FeeTypeID" DefaultValue="13" Type="Int32" />
                <asp:Parameter Name="Amount" Type="Decimal" />
                <asp:Parameter Name="Notes" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
                <asp:Parameter DefaultValue="13" Name="FeeTypeID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    <asp:HiddenField ID="hdnVal" runat="server" />
    <asp:HiddenField ID="hdnFee" runat="server" />
    <asp:HiddenField ID="hdnExhibID" runat="server" />
    <%--<controls:SessionHandler id="handler1" TargetURLForSessionTimeout="" AutomaticRedirect="false" runat="server" OnTimeOut="SessionTimeout"/>--%>
</asp:Content>
