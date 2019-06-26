Public Class Sponsor
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UpdateProgress(20, 1, 5, "")
        If PanelParticipationControl.Visible = True Then
            UpdateProgress(40, 2, 5, "")
        End If
        ConferenceControl = Master.FindControl("ConferenceFromURL")
       
        'Don't allow booth selection until open date
        Dim hdnRegType As New HiddenField
        hdnRegType = CType(BoothLayout.FindControl("hdnRegType"), HiddenField)
        hdnRegType.Value = "sponsor"




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
        PanelExhibitorInfo.Visible = True
        UpdateProgress(60, 3, 5, "")
    End Sub

    Protected Sub CompanyInfo_Finished() Handles CompanyInfo.FinishedLogin
        Dim hdnVal As New HiddenField
        hdnVal = CType(BoothLayout.FindControl("hdnVal"), HiddenField)
        If Not hdnVal Is Nothing Then
            hdnVal.Value = CompanyInfo.ExhibitorID
        End If

        PanelExhibitorInfo.Visible = False
        PanelBoothLayout.Visible = True

        

        UpdateProgress(80, 4, 5, "")
    End Sub

    Protected Sub btnAgree_Click(sender As Object, e As EventArgs) Handles btnAgree.Click
        Dim bPass As Boolean = True
        If chkTerms.Checked = False Then
            Me.lblTermsMessage.Text = "<div class=""alert alert-danger"" role=""alert"">You must indicate that you have read and agree to the Terms and Conditions.</div>"
            Me.lblTermsMessage.Visible = True
            bPass = False
        Else
            Me.lblTermsMessage.Visible = False
        End If
        If chkLiability.Checked = False Then

            Me.lblLiability.Text = "<div class=""alert alert-danger"" role=""alert"">You must indicate that you have read and agree to the Release of Liability paragraph.</div>"
            Me.lblLiability.Visible = True
            bPass = False
        Else
            Me.lblLiability.Visible = False
        End If
        If bPass = True Then
            PanelInstructions.Visible = False
            PanelParticipationControl.Visible = True
            UpdateProgress(40, 2, 5, "")
        Else
            UpdateProgress(20, 1, 5, " progress-bar-danger")
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

        

        PanelBoothLayout.Visible = False
        PanelConfirmation.Visible = True
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        Dim ConferenceID As Integer = ConferenceControl.ConferenceID

        lblConference.Text = ConferenceControl.ConferenceName
        lblConferenceShortName.Text = ConferenceControl.ConferenceShortName
        Dim sType As String = ConferenceControl.ConferenceType
        lblConferenceType.Text = sType
        lblConferenceType2.Text = sType
        lblConferenceType3.Text = sType
        lblConferenceType4.Text = sType
        lblConferenceType5.Text = sType
        lblLocation.Text = ConferenceControl.ConferenceLocation
        lblMeetingPlanner.Text = "Susie Warner" 'SCGTODO - add meeting planner to ConferenceFromURL
        With lnkMeetingPlannerEmail
            .NavigateUrl = "mailto:" + ConferenceControl.ConferencePlannerEmail
            .Text = ConferenceControl.ConferencePlannerEmail
        End With

        SqlDataSourceConfirmation.SelectParameters("PersonID").DefaultValue = PersonID.ToString
        SqlDataSourceConfirmation.SelectParameters("ConferenceID").DefaultValue = ConferenceID.ToString

        Dim lnkReturn As HyperLink
        lnkReturn = CType(Master.FindControl("lnkReturn"), HyperLink)
        Me.lnkMainConf.NavigateUrl = lnkReturn.NavigateUrl

        'Insert ledger info for sponsors
        'Booth first
        SqlDataSourceConfirmation.InsertParameters("PersonID").DefaultValue = PersonID.ToString
        SqlDataSourceConfirmation.InsertParameters("ConferenceID").DefaultValue = ConferenceID.ToString
        SqlDataSourceConfirmation.InsertParameters("FeeTypeID").DefaultValue = 12
        SqlDataSourceConfirmation.Insert()

        'two free technical registrations per booth
        For i As Integer = 0 To 1
            SqlDataSourceConfirmation.InsertParameters("FeeTypeID").DefaultValue = 6
            SqlDataSourceConfirmation.Insert()
        Next




        UpdateProgress(100, 5, 5, " progress-bar-success")
    End Sub

    Protected Sub Booth_Fail() Handles BoothLayout.BoothFail
        UpdateProgress(80, 4, 5, " progress-bar-danger")
    End Sub

    Protected Sub UpdateProgress(iProgress As Integer, iStep As Integer, iSteps As Integer, sStatus As String)

        lblProgress.Text = "<div class=""progress-bar" & sStatus & """ role=""progressbar"" aria-valuenow=""" & iProgress & """ aria-valuemin=""0"" aria-valuemax=""100"" style=""width: " & iProgress & "%;"">Step " & iStep & " of " & iSteps & "</div>"
    End Sub




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


        Dim BoothReservationEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_sponsor_reservation")
        Dim BoothReservationEmailHTML As String
        If BoothReservationEmail Is Nothing Then
            BoothReservationEmail = BattelleEmailGetByNameAsDataRow("sponsor_reservation")
        End If
        BoothReservationEmailHTML = BoothReservationEmail("EmailHTML")
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[first_name]}", PersonData("FirstName"))
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_name]}", ConferenceControl.ConferenceName)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_meeting_planner]}", ConferenceControl.MeetingPlanner)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[booth_reservation_content]}", BoothReservationConfirmationHTML)

        BattelleSendMail(BoothReservationEmailHTML, PersonData("Email"), "Booth Reservation for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)

        ' END SENDMAIL
    End Sub
End Class