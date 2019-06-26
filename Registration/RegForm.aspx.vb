Imports System.Globalization
Imports System.Web.Routing
Imports Microsoft.AspNet.Identity

Public Class RegForm
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")

        'lnkbtnPrivacy.OnClientClick = "window.open('privacy','Privacy','resizeable=yes,scrollbars=yes,width=700,height=600');return false;"
        If Not IsPostBack Then
            'If Not Left(Page.RouteData.Values("regtype"), 8) = "scgadmin" Then
            If Not Context.User.Identity.GetUserName() = "SCGadmin" Then
                If ConferenceControl.RegistrationCloseDate <= Now() Then
                    Dim sURL As String
                    sURL = "~/" & ConferenceControl.ConferenceURLString & "/registrationclosed"
                    Response.Redirect(sURL, True)
                End If
            End If

            If PanelParticipationControl.Visible = True Then
                If Page.RouteData.Values("regtype") = "techreg" Then
                    PanelParticipationControlTechReg.Visible = True
                End If
            End If

            Dim sConference As String = ConferenceControl.ConferenceShortName
            lblConference.Text = sConference
            lblConference2.Text = sConference
            lblConference3.Text = sConference
            lblEmail.Text = ConferenceControl.ConferencePlannerEmail

            Dim dt = ConferenceControl.ConferenceStartDate
            Dim sdt As String
            While dt <= ConferenceControl.ConferenceEndDate

                sdt = dt.ToString("D", CultureInfo.CurrentCulture)
                'ddlDate.Items.Add(New ListItem(sdt, dt))
                chkOneTimeDate.Items.Add(New ListItem(sdt, dt))
                chkExhibPassDate.Items.Add(New ListItem(sdt, dt))
                dt = dt.AddDays(1)
            End While
            lblAdminDiv.Text = "<div class=""form-group"">"

            lblConferenceType.Text = ConferenceControl.ConferenceType
            lblConferenceType2.Text = ConferenceControl.ConferenceType
            lblConferenceType3.Text = ConferenceControl.ConferenceType
            lblConferenceType4.Text = ConferenceControl.ConferenceType
            lblConferenceType5.Text = ConferenceControl.ConferenceType
            lblConferenceType6.Text = ConferenceControl.ConferenceType
            lblConferenceType7.Text = ConferenceControl.ConferenceType
            Dim dRegFeeIncrease = ConferenceControl.RegistrationFeeIncreaseDate
            dRegFeeIncrease = dRegFeeIncrease.AddDays(-1)
            lblRegFeeIncrease.Text = dRegFeeIncrease.ToString("D", CultureInfo.CurrentCulture) & "."
            Dim dRegCancelBy = ConferenceControl.RegistrationCancelByDate
            'lblCancellation.Text = dRegCancelBy.ToString("D", CultureInfo.CurrentCulture)
            Dim dRefund = ConferenceControl.NoRefundDate
            Dim d75PercentRefund = ConferenceControl.RegistrationCancelBy75PercentDate
            Dim d50PercentRefund = ConferenceControl.RegistrationCancelBy50PercentDate.ToString("D", CultureInfo.CurrentCulture)
            'lblRefund.Text = dRefund.ToString("D", CultureInfo.CurrentCulture)
            ltl75PercentDate.Text = d75PercentRefund.ToString("D", CultureInfo.CurrentCulture)
            ltl50PercentFromDate.Text = d75PercentRefund.AddDays(1).ToString("D", CultureInfo.CurrentCulture)
            ltl50PercentToDate.Text = d50PercentRefund
            ltl50PercentToDate2.Text = d50PercentRefund
            ltl50PercentToDate3.Text = d50PercentRefund
            Dim iServiceFee = ConferenceControl.TechSessionCancelServiceFee
            ltlServiceFee1.Text = iServiceFee
            ltlServiceFee2.Text = iServiceFee



            TextBoxOrgEmail.Text = ""
            PanelOrgEmail.Visible = False
        Else


            'PanelOrgEmail.Visible = True

        End If
        'lblCancellation.Text = ConferenceControl.CancelByDate SCGTODO - make this
        'lblRefund.Text = ConferenceControl.ConferenceRefundDate  SCGTODO - make this





    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()

        'First check to see if the person is registered for this conference
        SqlDataSourceReg.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        SqlDataSourceReg.SelectParameters("PersonID").DefaultValue = PersonID
        Session("PersonID") = PersonID
        Dim dv As DataView
        Dim iRows As Integer

        dv = CType(SqlDataSourceReg.Select(DataSourceSelectArguments.Empty), DataView)
        iRows = CType(dv.Table.Rows.Count, Integer)

        If iRows > 0 Then ' Data found - person is registered
            If Page.RouteData.Values("regtype") = "balance" Then
                ParticipationIDLogin.Visible = False
                PanelParticipationControl.Visible = False
                PanelForm.Visible = False
                PanelPayment.Visible = True
                'Check to see if pay by check is allowed
                If ConferenceControl.PayByCheckAllowed = False Then
                    radPayment.Items(0).Selected = True
                    radPayment.Items(1).Enabled = False 'Assumes Check is second item in list
                End If
            Else
                Dim sURL As String
                sURL = "~/" & ConferenceControl.ConferenceURLString & "/regconfirm"
                Response.Redirect(sURL, True)
            End If


        Else
            Dim PersonData = BattellePersonGetAsDataRow(PersonID)
            'ParticipationIDLogin.Visible = False
            PanelParticipationControl.Visible = False
            PanelForm.Visible = True

            SqlDataSourceFees.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

            'Set T&C URL
            With lnkRegTC
                .Text = ConferenceControl.RegistrationTermsConditionsURL
                .NavigateUrl = ConferenceControl.RegistrationTermsConditionsURL
            End With

            dv = CType(SqlDataSourceFees.Select(DataSourceSelectArguments.Empty), DataView)
            iRows = CType(dv.Table.Rows.Count, Integer)

            Dim sOption As String = Page.RouteData.Values("regtype")

            'Dim DataRow As DataRow = BattelleGovNonProfitBoothsGet(ConferenceControl.ConferenceID)
            'Dim DataKey As String = DataRow("GovNonProfitPersonIDs").ToString()

            'Check to see if the user registering gets the Government/Non-Profit Discount, if so then show discounted tech reg price, if not then show regular tech reg price
            Dim govView As DataView
            Dim govRows As Integer
            Dim iGovtEmployee As String = "No"
            Dim GovNonProfitRate As String = "False"

            If Session("PersonID") IsNot Nothing Then
                SqlDataSourceGovNonProfit.SelectParameters("PersonID").DefaultValue = Session("PersonID")
                SqlDataSourceGovNonProfit.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                SqlDataSourceGovNonProfit.SelectParameters("ShortCoursePromoCode_IN").DefaultValue = "Empty"
                SqlDataSourceGovNonProfit.SelectParameters("CourseID").DefaultValue = 0

                govView = CType(SqlDataSourceGovNonProfit.Select(DataSourceSelectArguments.Empty), DataView)
                govRows = CType(govView.Table.Rows.Count, Integer)

                'If DataKey.Contains(Session("PersonID").ToString()) Then
                If govRows > 0 Then
                    iGovtEmployee = govView.Table.Rows(0)("GovtEmployee")

                    If iGovtEmployee = "Yes" Then
                        GovNonProfitRate = "True"
                        techRegFee.Visible = False
                        rblTechReg.Checked = False
                        techRegGovNonProfitFee.Visible = True
                        rblTechRegGovNonProfit.Checked = True
                    Else
                        GovNonProfitRate = "False"
                        techRegFee.Visible = True
                        rblTechReg.Checked = True
                        techRegGovNonProfitFee.Visible = False
                        rblTechRegGovNonProfit.Checked = False
                    End If

                End If
            End If


            If iRows > 0 Then ' Data found
                Select Case sOption
                    Case "onedaypass"
                        PanelOneTime.Visible = True
                        PanelMain.Visible = False
                        PanelTechReg.Visible = False
                        PanelWaived.Visible = False
                        PanelExhibPass.Visible = False
                        lblOneTimeFee.Text = dv.Table.Rows(0)("OneTimeFee")
                        rblOneTime.Checked = True
                    Case "techreg", "tech", "technical"
                        PanelOneTime.Visible = False
                        PanelMain.Visible = False
                        PanelTechReg.Visible = True
                        PanelWaived.Visible = False
                        PanelExhibPass.Visible = False
                        lblTechRegFee.Text = dv.Table.Rows(0)("TechRegFee")
                        lblTechRegGovNonProfitRegFee.Text = dv.Table.Rows(0)("TechRegGovNonProfitFee")
                        'rblTechReg.Checked = True
                        btnNext.Enabled = False
                        lblMessage.Visible = True
                    Case "waiver"
                        PanelOneTime.Visible = False
                        PanelMain.Visible = False
                        PanelTechReg.Visible = False
                        PanelWaived.Visible = True
                        PanelExhibPass.Visible = False
                        rblWaived.Checked = True
                        btnNext.Enabled = True
                        lblMessage.Visible = False
                    Case "exhibpass", "exhibitpass", "exhibitonly", "exhibonly", "exhibit"
                        lblFeesHeader.Text = "Exhibit Hall Only Pass"
                        lblFeesCover.Text = "The following fee covers admission to all exhibits, poster sessions, group lunches, " &
                            "receptions, and daily continental breakfasts and refreshment breaks. No registration materials will be provided.  " &
                            "No access to platform sessions will be allowed."
                        lblRegFeeIncrease.Visible = False
                        PanelOneTime.Visible = False
                        PanelMain.Visible = False
                        PanelTechReg.Visible = False
                        PanelWaived.Visible = False
                        PanelExhibPass.Visible = True
                        lblExhibPassFee.Text = dv.Table.Rows(0)("ExhibPassFee")
                        lblExhibPassWeekFee.Text = dv.Table.Rows(0)("ExhibPassWeekFee")
                        rblExhibPass.Checked = True
                        btnNext.Enabled = True
                        lblMessage.Visible = False
                    Case "scgadmin"
                        PanelOneTime.Visible = True
                        PanelMain.Visible = True
                        PanelTechReg.Visible = True
                        PanelWaived.Visible = True
                        lblStudentFee.Text = dv.Table.Rows(0)("StudentFee")
                        lblGovtFee.Text = dv.Table.Rows(0)("GovtFee")
                        lblUnivFee.Text = dv.Table.Rows(0)("UnivFee")
                        lblIndustryFee.Text = dv.Table.Rows(0)("IndustryFee")
                        lblTechRegFee.Text = dv.Table.Rows(0)("TechRegFee")
                        lblTechRegGovNonProfitRegFee.Text = dv.Table.Rows(0)("TechRegGovNonProfitFee")
                        lblOneTimeFee.Text = dv.Table.Rows(0)("OneTimeFee")
                    Case Else
                        PanelOneTime.Visible = False
                        PanelMain.Visible = True
                        PanelTechReg.Visible = False
                        PanelWaived.Visible = False
                        lblStudentFee.Text = dv.Table.Rows(0)("StudentFee")
                        lblGovtFee.Text = dv.Table.Rows(0)("GovtFee")
                        lblUnivFee.Text = dv.Table.Rows(0)("UnivFee")
                        lblIndustryFee.Text = dv.Table.Rows(0)("IndustryFee")
                End Select

                'If short courses are available give option to select them now
                If Now() > ConferenceControl.ShortCourseOpenDate And Now() < ConferenceControl.ShortCourseClosedDate Then
                    pnlShortCourse.Visible = True
                Else
                    pnlShortCourse.Visible = False
                End If

            End If
        End If



    End Sub


    Protected Sub ButtonOrgEmail_Click(sender As Object, e As EventArgs) Handles ButtonOrgEmail.Click
        TextBoxOrgEmail.ReadOnly = False
        TextBoxOrgEmail.Text = ""
        PanelOrgEmail.Visible = True
        LabelCheckEmailResult.Visible = False
    End Sub

    Protected Sub ButtonCheckOrgEmail_Click(sender As Object, e As EventArgs) Handles ButtonCheckOrgEmail.Click
        Dim PersonData As DataRow
        Dim PersonID As Integer
        Dim PersonDataView As DataView = CType(SqlDataSourcePersonIDFromEmail.Select(DataSourceSelectArguments.Empty), DataView)
        If PersonDataView.Table.Rows.Count > 0 Then
            PersonData = PersonDataView.Table.Rows(0)
            PersonDataView.Dispose()
            PersonID = CType(PersonData("PersonID"), Integer)
            Dim OrganizationID As String
            OrganizationID = PersonData("OrganizationID")

            If Not IsDBNull(PersonData("OrganizationID")) Then
                LabelCheckEmailResult.Text = "<div class=""alert alert-success"" role=""alert"">Your email address exists in our system. Your Organization ID will be sent to your email address, please retain this Organization ID as it is required for other members of your organization to use it when signing up as a technical registrant.</div>"
                LabelCheckEmailResult.Visible = True
                'SENDMAIL begin
                'Dim ConferenceControl As ConferenceFromURL = CType(Me.Parent.Page.Master.FindControl("ConferenceFromURL"), ConferenceFromURL)
                Dim OrganizationSummaryHTML As String = String.Empty

                OrganizationSummaryHTML += "<p align=""left"">"
                OrganizationSummaryHTML += "Name: " + PersonData("FirstName") + " " + PersonData("LastName") + "<br />"
                If Not IsDBNull(PersonData("OrganizationID")) Then
                    OrganizationSummaryHTML += "Organization ID: <b style='color:red;'>" + PersonData("OrganizationID") + "</b><br /><br />"
                    OrganizationSummaryHTML += "<i>Important:</i> Retain this Organization ID as it is required for other members of your organization to use it when signing up as a technical registrant. <br />"
                End If
                OrganizationSummaryHTML += "</p>"


                Dim OrganizationEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_organizationID_confirmation")
                Dim OrganizationEmailHTML As String
                If OrganizationEmail Is Nothing Then
                    OrganizationEmail = BattelleEmailGetByNameAsDataRow("organizationID_confirmation")
                End If
                OrganizationEmailHTML = OrganizationEmail("EmailHTML")
                OrganizationEmailHTML = OrganizationEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
                OrganizationEmailHTML = OrganizationEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
                OrganizationEmailHTML = OrganizationEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
                OrganizationEmailHTML = OrganizationEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
                OrganizationEmailHTML = OrganizationEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
                OrganizationEmailHTML = OrganizationEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
                OrganizationEmailHTML = OrganizationEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
                OrganizationEmailHTML = OrganizationEmailHTML.Replace("{[participation_content]}", OrganizationSummaryHTML)

                BattelleSendMail(OrganizationEmailHTML, PersonData("Email"), "Your Organization ID is", Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)

                'END send mail

                PanelOrgEmail.Visible = False
                '#If DEBUG Then
                '                LabelCheckEmailResult.Text += " (DEBUG: PersonID=" + PersonID.ToString() + ")"
                '#End If
            Else
                LabelCheckEmailResult.Visible = True
                LabelCheckEmailResult.Text = "<div class=""alert alert-warning"" role=""alert"">We could not locate your Organization ID in our system. Please verify that you typed your email correctly. If you think you may have used a different email previously, please try that one. If your record is retrieved, you will be able to revise your contact information as needed on the next screen. If you are a new user, please click the NEW USER button below.</div>"
                'TextBoxEmail.ReadOnly = True

            End If
        Else
            BattelleSecurityFailure(Request.UserHostAddress)
            LabelCheckEmailResult.Visible = True
            LabelCheckEmailResult.Text = "<div class=""alert alert-warning"" role=""alert"">We could not locate your email address in our system. Please verify that you typed your email correctly. If you think you may have used a different email previously, please try that one.</div>"

        End If

    End Sub





    Protected Sub btnNext_Click(sender As Object, e As EventArgs) Handles btnNext.Click
        If chkRegTC.Checked = False Then
            ltlRegTCAlert.Visible = True
            lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">You must indicate that you have read and agree to the Terms and Conditions.</div>"
        Else
            ltlRegTCAlert.Visible = False
            Dim bValid As Boolean = False
            Dim bOneTime As Boolean = False
            Dim iFee As Integer = 0
            Dim iFeeTypeID As Integer = 0
            Dim sFeeType As String = ""
            Dim dOneTime As String 'Date (Changed from single select to string)
            If Me.rblStudent.Checked = True Then
                iFee = lblStudentFee.Text
                bValid = True
                iFeeTypeID = 1 'SCGTODO - can these be made dynamic? (Values from ConferenceFeeType table)
                sFeeType = lblStudent.Text
            End If
            If Me.rblGovt.Checked = True Then
                iFee = lblGovtFee.Text
                bValid = True
                iFeeTypeID = 2
                sFeeType = lblGovt.Text
            End If
            If Me.rblUniv.Checked = True Then
                iFee = lblUnivFee.Text
                bValid = True
                iFeeTypeID = 18
                sFeeType = lblUniv.Text
            End If
            If Me.rblIndustry.Checked = True Then
                iFee = lblIndustryFee.Text
                bValid = True
                iFeeTypeID = 3
                sFeeType = lblIndustry.Text
            End If

            If Me.rblOneTime.Checked = True Then
                iFee = lblOneTimeFee.Text
                bValid = True
                iFeeTypeID = 10
                sFeeType = lblOneTime.Text
                bOneTime = True
                'dOneTime = ddlDate.SelectedValue
                For Each li As ListItem In chkOneTimeDate.Items
                    If li.Selected Then
                        If dOneTime = "" Then
                            dOneTime = li.Text
                        Else
                            dOneTime = dOneTime & "; " & li.Text
                            iFee = iFee + lblOneTimeFee.Text
                        End If
                    End If
                Next
            End If
            If Me.rblExhibPass.Checked = True Then
                iFee = lblExhibPassFee.Text
                bValid = True
                iFeeTypeID = 20
                sFeeType = lblExhibPass.Text
                bOneTime = True
                'dOneTime = ddlDate.SelectedValue
                For Each li As ListItem In chkExhibPassDate.Items
                    If li.Selected Then
                        If dOneTime = "" Then
                            dOneTime = li.Text
                        Else
                            dOneTime = dOneTime & "; " & li.Text
                            iFee = iFee + lblExhibPassFee.Text
                        End If
                    End If
                Next
            End If
            If rblExhibPassWeek.Checked = True Then
                iFee = lblExhibPassWeekFee.Text
                bValid = True
                iFeeTypeID = 35
                sFeeType = lblExhibPassWeek.Text
                bOneTime = False
            End If
            If Me.rblTechReg.Checked = True Then
                iFee = lblTechRegFee.Text
                bValid = True
                iFeeTypeID = 6
                sFeeType = lblTechReg.Text

            End If

            If Me.rblTechRegGovNonProfit.Checked = True Then
                iFee = lblTechRegGovNonProfitRegFee.Text
                bValid = True
                iFeeTypeID = 48
                sFeeType = lblTechRegGovNonProfit.Text
            End If

            If Me.rblWaived.Checked = True Then
                iFee = 0
                bValid = True
                iFeeTypeID = 16
                sFeeType = lblWaived.Text
                hdnFee.Value = iFee
            End If
            If bValid = True Then
                PanelPayment.Visible = True
                'Check to see if pay by check is allowed
                If ConferenceControl.PayByCheckAllowed = False Then
                    radPayment.Items(0).Selected = True
                    radPayment.Items(1).Enabled = False 'Assumes Check is second item in list
                End If
                PanelForm.Visible = False
                lblFee.Text = iFee
                If iFee <> 0 Then
                    hdnFee.Value = iFee
                End If

                lblRegistration.Text = sFeeType
                If bOneTime = True Then
                    lblSpacer.Visible = True
                    lblSelectedDate.Visible = True
                    lblSelectedDate.Text = dOneTime 'ddlDate.SelectedItem.ToString
                    hdnDate.Value = dOneTime 'ddlDate.SelectedValue
                End If
                If chkOptin.Checked = True Then
                    lblOptIn2.Text = "Yes"
                Else
                    lblOptIn2.Text = "No"
                End If
                lblSpecialNeeds2.Text = txtSpecialNeeds.Text
                hdnVal.Value = iFeeTypeID
                If iFee = 0 Then
                    radPayment.Visible = False
                End If

                'Insert details before moving to payment
                'Insert Registration Attendance Details
                SqlDataSourceAttendance.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                SqlDataSourceAttendance.InsertParameters("PersonID").DefaultValue = ParticipationIDLogin.UserPersonID() 'Session("PersonID")
                SqlDataSourceAttendance.InsertParameters("FeeTypeID").DefaultValue = hdnVal.Value
                SqlDataSourceAttendance.InsertParameters("Amount").DefaultValue = hdnFee.Value
                If Me.txtWaiveNotes.Text <> "" Then
                    SqlDataSourceAttendance.InsertParameters("Notes").DefaultValue = txtWaiveNotes.Text
                End If

                Dim bOptOut As Boolean 'This used to be a prechecked opt out. It is now an opt in, but the database still uses opt out. So a Yes = False (They are opting in) and No = True (they are opting out)
                If lblOptIn2.Text = "Yes" Then
                    bOptOut = False 'Yes, include them
                Else
                    bOptOut = True 'No, they are opting out
                End If
                If hdnExhibID.Value <> "" Then
                    SqlDataSourceAttendance.InsertParameters("ExhibitorID").DefaultValue = hdnExhibID.Value
                End If
                SqlDataSourceAttendance.InsertParameters("RegListOptOut").DefaultValue = bOptOut
                SqlDataSourceAttendance.InsertParameters("SpecialNeeds").DefaultValue = lblSpecialNeeds2.Text
                SqlDataSourceAttendance.InsertParameters("RegistrationType").DefaultValue = lblRegistration.Text
                If lblSelectedDate.Text <> "" Then
                    SqlDataSourceAttendance.InsertParameters("OneDayPassDate").DefaultValue = lblSelectedDate.Text
                End If
                SqlDataSourceAttendance.InsertParameters("CouponCode").DefaultValue = txtAdminCode.Text
                SqlDataSourceAttendance.Insert()

                'Redirect to short course
                If chkShourtCourse.Checked = True Then
                    Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/ShortCourse", True)
                End If
            Else
                    lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">You must choose the appropriate registration option.</div>"
            End If
        End If
    End Sub

    Protected Sub btnNextPay_Click(sender As Object, e As EventArgs) Handles btnNextPay.Click

        'If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
        '    Session("PersonID") = ParticipationIDLogin.UserPersonID()
        'End If

        If Session("PersonID") IsNot Nothing And Session("PersonID").ToString <> "" Then
            'Nothing, all good
        Else
            Session("PersonID") = ParticipationIDLogin.UserPersonID()
        End If



        'if techreg insert row into Exhibitor ledger?
        'Or count by techreg associated with company

        'Pay or confirmation
        Dim sURL As String
        sURL = "~/" & ConferenceControl.ConferenceURLString & "/regconfirm"
        If lblFee.Text <> 0 Then
            If radPayment.SelectedValue = "Check" Then
                'Go directly to Confirmation

                SqlDataSourceLedger.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                SqlDataSourceLedger.InsertParameters("PersonID").DefaultValue = ParticipationIDLogin.UserPersonID() 'Session("PersonID")
                SqlDataSourceLedger.InsertParameters("Amount").DefaultValue = 0
                SqlDataSourceLedger.Insert()

            Else
                'Go to CC Payment
                'Set sessions
                Session("pTransactionAmount") = lblFee.Text
                Session("pPersonID") = ParticipationIDLogin.UserPersonID() 'Session("PersonID")
                Session("pConferenceID") = ConferenceControl.ConferenceID
                Session("pTransactionTimestamp") = Now.ToBinary.ToString()
                Session("pOrigin") = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/regconfirm/"
                Session("pDescription") = "Conference Registration: " & ConferenceControl.ConferenceShortName

                sURL = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/payment"
                If InStr(sURL, "https") = 0 Then
                    sURL = sURL.Replace("http", "https")
                End If
            End If
        Else
            If hdnFee.Value <> 0 Then 'if zero, it is a Waived fee, not a discount.
                'Coupon code (Changed to Admin code for obscurity)
                Dim tAmount As Decimal = Decimal.Parse(hdnFee.Value)
                tAmount = Decimal.Negate(tAmount)

                SqlDataSourceLedger.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                SqlDataSourceLedger.InsertParameters("PersonID").DefaultValue = ParticipationIDLogin.UserPersonID() 'Session("PersonID")
                SqlDataSourceLedger.InsertParameters("Amount").DefaultValue = tAmount
                SqlDataSourceLedger.InsertParameters("FeeTypeID").DefaultValue = 15 'Discount
                SqlDataSourceLedger.Insert()
            End If

        End If
        Response.Redirect(sURL, True)





    End Sub

    Protected Sub btnAdminCheck_Click(sender As Object, e As EventArgs) Handles btnAdminCheck.Click
        If Trim(txtAdminCode.Text) <> "" Then
            SqlDataSourceAttendance.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceAttendance.SelectParameters("CouponCode").DefaultValue = txtAdminCode.Text

            Dim dv As DataView
            Dim iRows As Integer
            Dim iValid As Integer = 0

            dv = CType(SqlDataSourceAttendance.Select(DataSourceSelectArguments.Empty), DataView)
            iRows = CType(dv.Table.Rows.Count, Integer)

            If iRows > 0 Then ' Data found
                iValid = dv.Table.Rows(0)("CouponValid")
                lblAdminValid.Visible = True
            End If

            If iValid = 1 Then
                lblAdminDiv.Text = "<div class=""form-group has-success has-feedback"">"
                lblFee.Text = 0
                lblAdminValid.Text = "Admin code validated!"
                lblAdminValid.CssClass = "text-success"
                btnAdminCheck.Enabled = False
                txtAdminCode.ReadOnly = True
                radPayment.Visible = False
            Else
                lblAdminDiv.Text = "<div class=""form-group has-error has-feedback"">"
                lblAdminValid.Text = "Admin code not valid."
                lblAdminValid.CssClass = "text-danger"
            End If

        End If

    End Sub

    Protected Sub lnkbtnShowAdmin_Click(sender As Object, e As EventArgs) Handles lnkbtnShowAdmin.Click
        If PanelAdminCode.Visible = False Then
            PanelAdminCode.Visible = True
        Else
            PanelAdminCode.Visible = False
        End If
    End Sub

    Protected Sub btnOrgValidate_Click(sender As Object, e As EventArgs) Handles btnOrgValidate.Click

        If rblTechReg.Checked Then
            hdnFee.Value = lblTechRegFee.Text
        ElseIf rblTechRegGovNonProfit.Checked Then
            hdnFee.Value = lblTechRegGovNonProfitRegFee.Text
        Else
            hdnFee.Value = lblTechRegFee.Text
        End If


        If Trim(txtOrgID.Text) <> "" Then

            'added 5/24/2019 to set variables to check for sponsor govt discount
            SqlDataSourceFees.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            Dim dvGov As DataView
            Dim iRowsGov As Integer
            Dim iSponsorOrExhibitor As String
            Dim iGovSponsor As String
            Dim govDiscount As Integer = 700 'Set to normal registration fee by default
            dvGov = CType(SqlDataSourceFees.Select(DataSourceSelectArguments.Empty), DataView)
            iRowsGov = CType(dvGov.Table.Rows.Count, Integer)
            If iRowsGov > 0 Then ' Data found
                If Not String.IsNullOrEmpty(dvGov.Table.Rows(0)("TechRegGovNonProfitFee")) Then
                    govDiscount = dvGov.Table.Rows(0)("TechRegGovNonProfitFee")
                End If
            End If
            'end

            SqlDataSourceOrgValidate.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceOrgValidate.SelectParameters("OrganizationID").DefaultValue = txtOrgID.Text

            Dim dv As DataView
            Dim iRows As Integer
            Dim iValid As Integer = 0
            Dim iReturn As Integer = 0
            Dim iFee As Integer = 1

            dv = CType(SqlDataSourceOrgValidate.Select(DataSourceSelectArguments.Empty), DataView)
            iRows = CType(dv.Table.Rows.Count, Integer)

            If iRows > 0 Then ' Data found
                iReturn = dv.Table.Rows(0)("ReturnCode")
                lblAdminValid.Visible = True
            End If

            Select Case iReturn
                Case 0 'bad exhib
                    iValid = 0
                Case 1 'no booth
                    iValid = 0
                Case 2 'reg full
                    iValid = 0
                Case Else 'space available
                    iValid = 1
                    hdnExhibID.Value = dv.Table.Rows(0)("ExhibitorID")

                    iSponsorOrExhibitor = dv.Table.Rows(0)("SponsorOrExhibitor")
                    iGovSponsor = dv.Table.Rows(0)("isGovSponsor")
                    iFee = dv.Table.Rows(0)("FeeCode")
                    If iFee = 0 Then 'no fee
                        lblFee.Text = 0
                        lblTechRegFee.Text = 0
                        lblTechRegGovNonProfitRegFee.Text = 0
                    ElseIf iSponsorOrExhibitor = "Sponsor" And iGovSponsor = "Yes" 'give sponor government discount
                        lblFee.Text = govDiscount
                        lblTechRegFee.Text = govDiscount
                        lblTechRegGovNonProfitRegFee.Text = govDiscount
                        techRegFee.Visible = False
                        rblTechReg.Checked = False
                        techRegGovNonProfitFee.Visible = True
                        rblTechRegGovNonProfit.Checked = True
                    End If
            End Select

            lblOrgValid.Visible = True
            If iValid = 1 Then
                lblTechRegDiv.Text = "<div class=""form-group has-success has-feedback"">"
                lblFee.Text = 0
                lblOrgValid.Text = "Organization ID validated!"
                lblOrgValid.CssClass = "text-success"
                btnOrgValidate.Enabled = False
                txtOrgID.ReadOnly = True
                btnNext.Enabled = True
                lblMessage.Visible = False
            Else
                lblTechRegDiv.Text = "<div class=""form-group has-error has-feedback"">"
                lblOrgValid.Text = "Organization ID not valid or your company has no remaining technical registration space."
                lblOrgValid.CssClass = "text-danger"
            End If

        End If

        LabelCheckEmailResult.Text = ""
        LabelCheckEmailResult.Visible = False

    End Sub
End Class