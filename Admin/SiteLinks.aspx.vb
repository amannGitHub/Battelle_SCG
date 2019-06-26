Public Class SiteLinks
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        If ddlConfList.SelectedIndex <> 0 Then
            pnlLinks.Visible = True
            Dim sBaseURL As String = BattelleGetApplicationURL()
            Dim sConferenceURL As String = ddlConfList.SelectedItem.Text
            'Build URLs
            Dim sURL As String

            'Standard Registration
            sURL = sBaseURL & sConferenceURL & "/register"
            With lnkRegistration
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Discounted Technical Registration
            sURL = sURL & "/techreg"
            With lnkRegistrationTechReg
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'One day pass
            sURL = sBaseURL & sConferenceURL & "/register/onedaypass"
            With lnkRegistrationOneDayPass
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Exhibit hall only pass
            sURL = sBaseURL & sConferenceURL & "/register/exhibpass"
            With lnkRegistrationExhibPass
                .Text = sURL
                .NavigateUrl = sURL
            End With


            'Waiver
            sURL = sBaseURL & sConferenceURL & "/register/waiver"
            With lnkRegistrationWaiver
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Balance
            sURL = sBaseURL & sConferenceURL & "/balance"
            With lnkBalance
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Participant Code Retrival
            sURL = sBaseURL & sConferenceURL & "/participant"
            With lnkParticipant
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Exhibitor
            'Sponsor Registration
            sURL = sBaseURL & sConferenceURL & "/exhibit/sponsor/register"
            With lnkExhibitorSponsorRegistration
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Sponsor Booth Reservation
            sURL = sBaseURL & sConferenceURL & "/exhibit/sponsor"
            With lnkExhibitorSponsorBoothReservation
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Exhibitor Booth Reservation
            sURL = sBaseURL & sConferenceURL & "/exhibit"
            With lnkExhibitorBoothReservation
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Sponsor Booth Layout
            sURL = sBaseURL & sConferenceURL & "/sponsor/layout"
            With lnkExhibitorSponsorLayout
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Booth Layout
            sURL = sBaseURL & sConferenceURL & "/exhibit/exhibitor/layout"
            With lnkExhibitorBoothLayout
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Sponsor Terms & Conditions
            sURL = sBaseURL & sConferenceURL & "/exhibit/sponsor/terms"
            With lnkExhibitorSponsorTC
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Exhibitor Terms & Conditions
            sURL = sBaseURL & sConferenceURL & "/exhibit/exhibitor/terms"
            With lnkExhibitorTC
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Sponsor Balance
            sURL = sBaseURL & sConferenceURL & "/exhibit/sponsor/balance"
            With lnkExhibitorSponsorBalance
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Exhibitor Balance
            sURL = sBaseURL & sConferenceURL & "/exhibit/exhibitor/balance"
            With lnkExhibitorBalance
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Booth Staff
            sURL = sBaseURL & sConferenceURL & "/exhibit/booth/staff"
            With lnkExhibitorStaff
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Learning Lab
            sURL = sBaseURL & sConferenceURL & "/learninglab"
            With lnkLearningLab
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Short Courses
            'Short Course Poposal
            sURL = sBaseURL & sConferenceURL & "/shortcourseproposal"
            With lnkShortCourseProposal
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Short Course Selection
            sURL = sBaseURL & sConferenceURL & "/shortcourse"
            With lnkShortCourse
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Short Course Balance
            sURL = sBaseURL & sConferenceURL & "/shortcourse/balance"
            With lnkShortCourseBalance
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Abstracts
            'Abstract Submission
            sURL = sBaseURL & sConferenceURL & "/abstract"
            With lnkAbstract
                .Text = sURL
                .NavigateUrl = sURL
            End With

            'Abstract Review
            sURL = sBaseURL & sConferenceURL & "/review"
            With lnkAbstractReview
                .Text = sURL
                .NavigateUrl = sURL
            End With

        Else
            pnlLinks.Visible = False
        End If
    End Sub

End Class