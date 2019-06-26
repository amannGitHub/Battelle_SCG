Public Class ExhibitBooth
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Dim iSteps As Integer = 9
    Dim iRows As Integer
    Dim dv As DataView

    Dim sExhibOrSponsor As String = Page.RouteData.Values("type").ToString

    Public Property ExhibitorOrSponsor() As String
        Get
            If (ViewState("ExhibitorOrSponsor") IsNot Nothing) Then
                Return CType(ViewState("ExhibitorOrSponsor"), String)
            Else
                Return "Exhibitor"
            End If
        End Get
        Set(value As String)
            ViewState("ExhibitorOrSponsor") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If PanelParticipationControl.Visible = True Then
                UpdateProgress(iProgress(1), 1, iSteps, "")
            End If
        End If
        ConferenceControl = Master.FindControl("ConferenceFromURL")

        PanelProgress.Visible = False

        'Check for Exhibit or Sponsor based onURL
        Dim sExhibOrSponsor As String = Page.RouteData.Values("type")

        'Don't allow booth selection until open date
        Dim hdnRegType As New HiddenField
        hdnRegType = CType(BoothLayout.FindControl("hdnRegType"), HiddenField)

        If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
            sExhibOrSponsor = "sponsor"
            ExhibitorOrSponsor = "Sponsor"
            hdnRegType.Value = "sponsor"
        Else
            hdnRegType.Value = "exhibit"
        End If

    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()

        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        ParticipationIDLogin.Visible = False
        PanelParticipationControl.Visible = False
        If Not IsNothing(PersonData) Then
            Dim hdnVal As New HiddenField
            hdnVal = CType(CompanyInfo.FindControl("hdnVal"), HiddenField)
            If Not hdnVal Is Nothing Then
                hdnVal.Value = PersonID
            End If
            Dim hdnCom As New HiddenField
            hdnCom = CType(CompanyInfo.FindControl("hdnCom"), HiddenField)
            If Not hdnCom Is Nothing Then
                hdnCom.Value = PersonData("Employer")
            End If
        End If
        'PanelExhibitorInfo.Visible = True
        PanelGovernmentNonProfit.Visible = True

        UpdateProgress(iProgress(2), 2, iSteps, "")
    End Sub

    'Protected Sub handler1_RenewSession() Handles handler1.RenewSession
    '    PanelExhibitorInfo.Visible = False
    '    PanelTerms.Visible = False
    '    PanelParticipationControl.Visible = True
    '    ParticipationIDLogin.Visible = True
    'End Sub

    Protected Sub BtnFinishedGovNonProfit_Click(sender As Object, e As EventArgs) Handles BtnFinishedGovNonProfit.Click

        Dim DataRow As DataRow = BattelleGovNonProfitBoothsGet(ConferenceControl.ConferenceID)
        Dim DataKey As Integer = DataRow("GovNonProfitCount")

        Dim hdnValGovNonProfit As New HiddenField
        hdnValGovNonProfit = CType(PanelGovernmentNonProfit.FindControl("hdnValGovNonProfit"), HiddenField)

        If (orgFedBtnYes.Checked) And (DataKey < 5) Then
            hdnValGovNonProfit.Value = "true"
        Else
            hdnValGovNonProfit.Value = "false"
        End If

        If hdnValGovNonProfit.Value = "true" Then
            orgFedBtnYes.Checked = True
        ElseIf hdnValGovNonProfit.Value = "false"
            orgFedBtnNo.Checked = True
        Else
            orgFedBtnYes.Checked = False
            orgFedBtnNo.Checked = False
        End If
        PanelGovernmentNonProfit.Visible = False
        PanelExhibitorInfo.Visible = True
    End Sub


    Protected Sub CompanyInfo_Finished() Handles CompanyInfo.FinishedLogin
        Dim hdnVal As New HiddenField
        hdnVal = CType(BoothLayout.FindControl("hdnVal"), HiddenField)
        If Not hdnVal Is Nothing Then
            hdnVal.Value = CompanyInfo.ExhibitorID
        End If
        Session("ExhibitorID") = CompanyInfo.ExhibitorID

        PanelTerms.Visible = True
        PanelExhibitorInfo.Visible = False
        PanelInstructions.Visible = False
        UpdateProgress(iProgress(3), 3, iSteps, "")

        'Show booth fee
        SqlDataSourceLedger.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

        'Check for Exhibit or Sponsor based onURL
        'Dim sExhibOrSponsor As String = Page.RouteData.Values("type")

        If sExhibOrSponsor <> "sponsor" Or sExhibOrSponsor <> "sponsors" Then
            SqlDataSourceLedger.SelectParameters("FeeTypeID").DefaultValue = 4 'SCGTODO - Can this be made dynamic?
        Else
            SqlDataSourceLedger.SelectParameters("FeeTypeID").DefaultValue = 12 'SCGTODO - Can this be made dynamic?
        End If

        dv = CType(SqlDataSourceLedger.Select(DataSourceSelectArguments.Empty), DataView)
        iRows = CType(dv.Table.Rows.Count, Integer)
        If iRows > 0 Then ' Data found
            lblBoothFee.Text = dv.Table.Rows(0)("Fee")
        End If


        Dim selBooth2 As New DropDownList
        selBooth2 = CType(BoothLayout.FindControl("selBooth2"), DropDownList)
        If Not selBooth2 Is Nothing Then
            If selBooth2.Visible = True Then
                'More than one booth can be selected
                'Temporary fix for multiple booth sizes SCGTODO - make dynamic
                If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
                    lblBoothFee.Text += " (waived). Upgrade to a 10x20 (2 booths) for $3,300 or to a 20x20 island for $9,300, assuming early-bird payments."
                End If
            Else
                'Only one booth allowed
                If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
                    lblBoothFee.Text += " (waived)."
                End If
            End If
        End If


    End Sub

    Protected Sub btnAgree_Click(sender As Object, e As EventArgs) Handles btnAgree.Click
        'If chkTerms.Checked = True Then

        '    PanelTerms.Visible = False
        '    PanelBoothLayout.Visible = True
        '    UpdateProgress(iProgress(4), 4, iSteps, "")



        'Else
        '    Me.lblTermsMessage.Text = "<div class=""alert alert-danger"" role=""alert"">You must indicate that you have read and agree to the terms and conditions.</div>"
        '    Me.lblTermsMessage.Visible = True
        '    UpdateProgress(iProgress(3), 3, iSteps, " progress-bar-danger")
        'End If

        Dim bPass As Boolean = True
        If chkTerms.Checked = False Then
            Me.lblTermsMessage.Text = "<div class=""alert alert-danger"" role=""alert"">You must indicate that you have read and agree to the Terms and Conditions.</div>"
            Me.lblTermsMessage.Visible = True
            bPass = False
        Else
            Me.lblTermsMessage.Visible = False
        End If
        'If chkLiability.Checked = False Then

        '    Me.lblLiability.Text = "<div class=""alert alert-danger"" role=""alert"">You must indicate that you have read and agree to the Release of Liability paragraph.</div>"
        '    Me.lblLiability.Visible = True
        '    bPass = False
        'Else
        '    Me.lblLiability.Visible = False
        'End If
        If bPass = True Then
            PanelTerms.Visible = False
            PanelBoothLayout.Visible = True
            UpdateProgress(40, 2, 5, "")
        Else
            UpdateProgress(iProgress(3), 1, 5, " progress-bar-danger")
        End If

    End Sub

    Protected Sub Booth_Finished() Handles BoothLayout.FinishedLogin
        'Dim hdnVal As New HiddenField
        'hdnVal = CType(BoothLayout.FindControl("hdnVal"), HiddenField)
        'If Not hdnVal Is Nothing Then
        '    hdnVal.Value = CompanyInfo.ExhibitorID
        'End If

        'Get Booth/Org info from Formview
        'FormViewConfirmation.DataBind()

        'Dim SponsorData As DataRowView = CType(FormViewConfirmation.DataItem, DataRowView)
        'Dim OrganizationID As Integer = SponsorData("OrganizationID")

        'If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then



        Dim selBooth As New DropDownList
        selBooth = CType(BoothLayout.FindControl("selBooth"), DropDownList)

        Dim selBooth2 As New DropDownList
        selBooth2 = CType(BoothLayout.FindControl("selBooth2"), DropDownList)


        'Insert Booth Sale to Ledger
        SqlDataSourceBoothSelection.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        SqlDataSourceBoothSelection.InsertParameters("PersonID").DefaultValue = ParticipationIDLogin.UserPersonID()
        SqlDataSourceBoothSelection.InsertParameters("ExhibOrSponsor").DefaultValue = sExhibOrSponsor
        SqlDataSourceBoothSelection.InsertParameters("BoothID1").DefaultValue = selBooth.SelectedValue
        If selBooth2.Visible = True Then
            If selBooth2.SelectedIndex > 0 Then
                SqlDataSourceBoothSelection.InsertParameters("BoothID2").DefaultValue = selBooth2.SelectedValue
            End If
        End If

        SqlDataSourceBoothSelection.InsertParameters("govNonProfit").DefaultValue = hdnValGovNonProfit.Value
        SqlDataSourceBoothSelection.Insert()


        'Me.lnkMainConf.NavigateUrl = lnkReturn.NavigateUrl

        PrepConferencePage()

        UpdateProgress(iProgress(5), 5, iSteps, "")
        'Else
        '    PanelParticipationControl.Visible = True
        '    lblAlert.Visible = True
        '    lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your session has terminated unexpectedly. Please log in to continue.</div>"
        'End If
    End Sub

    Protected Sub Booth_Fail() Handles BoothLayout.BoothFail
        UpdateProgress(iProgress(4), 4, iSteps, " progress-bar-danger")

    End Sub

    Sub PrepConferencePage()
        PanelBoothLayout.Visible = False
        PanelConfirmation.Visible = True

        If sExhibOrSponsor <> "sponsor" Or sExhibOrSponsor <> "sponsors" Then
            lblMailingFirst.Text = ConferenceControl.ExhibMailingListFirstDate
            lblMailingSecond.Text = ConferenceControl.ExhibMailingListSecondDate

            'Get Mailing List Fee
            SqlDataSourceLedger.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceLedger.SelectParameters("FeeTypeID").DefaultValue = 11 'SCGTODO - Can this be made dynamic?
            dv = CType(SqlDataSourceLedger.Select(DataSourceSelectArguments.Empty), DataView)
            iRows = CType(dv.Table.Rows.Count, Integer)
            If iRows > 0 Then ' Data found
                lblMailingFee.Text = dv.Table.Rows(0)("Fee")
            End If
        Else
            PanelMail.Visible = False
        End If





        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        Dim ConferenceID As Integer = ConferenceControl.ConferenceID

        SqlDataSourceConfirmation.SelectParameters("PersonID").DefaultValue = PersonID.ToString
        SqlDataSourceConfirmation.SelectParameters("ConferenceID").DefaultValue = ConferenceID.ToString

        Dim lnkReturn As HyperLink
        lnkReturn = CType(Master.FindControl("lnkReturn"), HyperLink)
    End Sub

    Protected Sub Booth_Already_Reserved() Handles BoothLayout.BoothAlreadyReserved
        UpdateProgress(iProgress(5), 5, iSteps, " progress-bar-warning")
        lblAlert.Text = "<div class=""alert alert-warning"" role=""alert"">You have already reserved a booth for your company.</div>"
        lblAlert.Visible = True
        PrepConferencePage()
    End Sub

    Protected Sub UpdateProgress(iProgress As Integer, iStep As Integer, iSteps As Integer, sStatus As String)

        lblProgress.Text = "<div class=""progress-bar" & sStatus & """ role=""progressbar"" aria-valuenow=""" & iProgress & """ aria-valuemin=""0"" aria-valuemax=""100"" style=""width: " & iProgress & "%;"">Step " & iStep & " of " & iSteps & "</div>"
    End Sub

    Function iProgress(iCurrent As Integer) As Integer
        iProgress = ((iCurrent / iSteps) * 100)
        Return iProgress
    End Function


    Protected Sub FormViewConfirmation_DataBound(sender As Object, e As EventArgs) Handles FormViewConfirmation.DataBound
        Dim DataRow As DataRowView = CType(FormViewConfirmation.DataItem, DataRowView)
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()

        ' BEGIN SendEmail
        Dim PersonData = BattellePersonGetAsDataRow(PersonID)

        Dim BoothReservationConfirmationHTML As String = String.Empty

        BoothReservationConfirmationHTML += "<p align=""left"">"
        BoothReservationConfirmationHTML += "Conference: <b>" + ConferenceControl.ConferenceName + "</b><br /><br />"
        BoothReservationConfirmationHTML += "You have reserved Booth <b>" + DataRow("BoothNumber").ToString + "</b><br /><br />"
        BoothReservationConfirmationHTML += "<b>Participant Code:</b> " + DataRow("ParticipationID").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Name:</b> " + DataRow("FirstName").ToString + " " + DataRow("LastName").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Participant Code:</b> <i>" + DataRow("ParticipationID").ToString + "</i><br />"
        BoothReservationConfirmationHTML += "<b>Address Line 1:</b> " + DataRow("AddressLine1").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Address Line 2:</b> " + DataRow("AddressLine2").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Address Line 3:</b> " + DataRow("AddressLine3").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>City:</b> " + DataRow("City").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>State/Province:</b> " + DataRow("StateProvince").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Zip/Postal Code:</b> " + DataRow("ZipPostal").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Country:</b> " + DataRow("Country").ToString + "<br /><br>"

        BoothReservationConfirmationHTML += "<b>Organization:</b> " + DataRow("Exhibitor").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Organization ID:</b> <i>" + DataRow("OrganizationID").ToString + "</i><br />"
        BoothReservationConfirmationHTML += "<b>Address Line 1:</b> " + DataRow("ExhibAddressLine1").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Address Line 2:</b> " + DataRow("ExhibAddressLine2").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Address Line 3:</b> " + DataRow("ExhibAddressLine3").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>City:</b> " + DataRow("ExhibCity").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>State/Province:</b> " + DataRow("ExhibStateProvince").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Zip/Postal Code:</b> " + DataRow("ExhibZipPostal").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Country:</b> " + DataRow("ExhibCountry").ToString + "<br />"
        BoothReservationConfirmationHTML += "</p>"


        Dim BoothReservationEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_booth_reservation")
        Dim BoothReservationEmailHTML As String
        If BoothReservationEmail Is Nothing Then
            BoothReservationEmail = BattelleEmailGetByNameAsDataRow("exhibit_confirmation")
        End If
        BoothReservationEmailHTML = BoothReservationEmail("EmailHTML")
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[first_name]}", PersonData("FirstName"))
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_name]}", ConferenceControl.ConferenceName)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[booth_reservation_content]}", BoothReservationConfirmationHTML)

        'BattelleSendMail(BoothReservationEmailHTML, PersonData("Email"), "Booth Reservation for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferenceEmail)

        ' END SENDMAIL
    End Sub

    Protected Sub btnNextStep1_Click(sender As Object, e As EventArgs) Handles btnNextStep1.Click
        FinishReservation()
    End Sub


    Sub FinishReservation()
        If Me.chkBoxMailing.Checked Then
            'Add Mailing List to ledger
            SqlDataSourceLedger.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceLedger.InsertParameters("PersonID").DefaultValue = ParticipationIDLogin.UserPersonID()
            SqlDataSourceLedger.InsertParameters("FeeTypeID").DefaultValue = 11 'SCGTODO - make dynamic?
            SqlDataSourceLedger.InsertParameters("Amount").DefaultValue = Me.lblMailingFee.Text
            SqlDataSourceLedger.Insert()
        End If

        Dim sURL As String

        If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
            'sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/booth/staff"

            sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/balance"
        Else
            sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/booth/staff"
            'sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/balance"
            'sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/exhibitor/balance"


        End If

        Response.Redirect(sURL, True)
    End Sub

End Class