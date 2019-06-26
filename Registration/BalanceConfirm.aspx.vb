Imports System.Globalization
Public Class BalanceConfirm
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then 'removed Session("PersonID") on 8/25/2015
                PanelParticipationControl.Visible = False

                CheckUser()
                If Page.RouteData.Values("admin") = "admin" Then
                    hdnNewStart.Value = "Yes"
                Else
                    hdnNewStart.Value = "No"
                End If

            Else
                PanelParticipationControl.Visible = True

                PanelContact.Visible = False
                PanelBalance.Visible = False


                hdnNewStart.Value = "Yes"
            End If
        End If
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then

            SqlDataSourceBalance.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceBalance.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceConfirmation.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        End If
    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()

        PanelParticipationControl.Visible = False

        CheckUser()

    End Sub

    Private Sub CheckUser()
        PanelContact.Visible = True
        PanelBalance.Visible = True
    End Sub

    Protected Sub FormViewConfirmation_DataBound(sender As Object, e As EventArgs) Handles FormViewConfirmation.DataBound
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            Dim DataRow As DataRowView = CType(FormViewConfirmation.DataItem, DataRowView)
            Dim PersonID As Integer = Session("PersonID")

            ' BEGIN SendEmail
            Dim PersonData = BattellePersonGetAsDataRow(PersonID)

            Dim RegistrationConfirmationHTML As String = String.Empty

            RegistrationConfirmationHTML += "<p align=""left"">"
            RegistrationConfirmationHTML += "Conference: <b>" + ConferenceControl.ConferenceName + "</b><br /><br />"
            RegistrationConfirmationHTML += "<b>Name:</b> " + DataRow("FirstName").ToString + " " + DataRow("LastName").ToString + "<br />"
            RegistrationConfirmationHTML += "<b>Participant Code:</b> <i>" + DataRow("ParticipationID").ToString + "</i><br />"
            RegistrationConfirmationHTML += "<b>Address Line 1:</b> " + DataRow("AddressLine1").ToString + "<br />"
            RegistrationConfirmationHTML += "<b>Address Line 2:</b> " + DataRow("AddressLine2").ToString + "<br />"
            RegistrationConfirmationHTML += "<b>Address Line 3:</b> " + DataRow("AddressLine3").ToString + "<br />"
            RegistrationConfirmationHTML += "<b>City:</b> " + DataRow("City").ToString + "<br />"
            RegistrationConfirmationHTML += "<b>State/Province:</b> " + DataRow("StateProvince").ToString + "<br />"
            RegistrationConfirmationHTML += "<b>Zip/Postal Code:</b> " + DataRow("ZipPostal").ToString + "<br />"
            RegistrationConfirmationHTML += "<b>Country:</b> " + DataRow("Country").ToString + "<br />"
            RegistrationConfirmationHTML += "<b>Special Needs:</b> " + DataRow("SpecialNeeds").ToString + "<br />"
            RegistrationConfirmationHTML += "</p>"


            Dim BoothReservationEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_balance_confirmation")
            Dim RegistrationEmailHTML As String
            If BoothReservationEmail Is Nothing Then
                BoothReservationEmail = BattelleEmailGetByNameAsDataRow("balance_confirmation")
            End If
            RegistrationEmailHTML = BoothReservationEmail("EmailHTML")
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[first_name]}", PersonData("FirstName"))
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[last_name]}", PersonData("LastName"))
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_name]}", ConferenceControl.ConferenceName)
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_meeting_planner]}", ConferenceControl.MeetingPlanner)
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[registration_confirmation_content]}", RegistrationConfirmationHTML)
            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[conference_url_string]}", ConferenceControl.ConferenceURLString)
            'RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[exhibit_link_url]}", RegistrationConfirmationHTML)

            'BattelleSendMail(RegistrationEmailHTML, PersonData("Email"), "Booth Reservation for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferenceEmail)
            hdnEmail.Value = RegistrationEmailHTML
            ' END SENDMAIL
        Else
            SessionTimeout()
        End If

    End Sub

    Protected Sub gvBalance_DataBound(sender As Object, e As EventArgs) Handles gvBalance.DataBound
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then


            Dim SumTotal As Decimal
            SumTotal = gvBalance.DataKeys(0).Value
            lblSumTotal.Text = SumTotal

            If SumTotal <> 0 Then
                PanelCheck.Visible = True
            End If

            Dim ExhibFeeEmail, RegistrationEmailHTML As String
            Dim cLabel As Label
            ExhibFeeEmail = "<h3>Registration Fees</h3>"
            ExhibFeeEmail += "<table border=""1"" cellpadding=""2"" cellspacing=""0""><tr>"
            For i As Integer = 0 To gvBalance.Columns.Count - 1
                ExhibFeeEmail += "<th>" + gvBalance.Columns(i).HeaderText + "</th>"
            Next
            ExhibFeeEmail += "</tr>"
            For i As Integer = 0 To gvBalance.Rows.Count - 1
                ExhibFeeEmail += "<tr>"
                For j As Integer = 0 To gvBalance.Columns.Count - 1
                    ExhibFeeEmail += "<td align=""right"">"
                    cLabel = CType(gvBalance.Rows(i).Cells(j).FindControl("Label" & j), Label) 'SCGTODO - this is a hack - how do I dynamically find the control by index?
                    ExhibFeeEmail += cLabel.Text + "</td>"
                Next
                ExhibFeeEmail += "</tr>"
            Next
            ExhibFeeEmail += "</table><br /><br />"
            ExhibFeeEmail += "<b>Total Balance:</b> US $" + lblSumTotal.Text + "<br /><br />"

            If SumTotal <> 0 Then
                ExhibFeeEmail += "<h3>Note: Payment is required to confirm your registration.</h3>"
            End If

            Dim sCancellation As String
            Dim sCancelBy As String = ConferenceControl.RegistrationCancelByDate.ToString("MMMM d, yyyy", CultureInfo.CurrentCulture)
            Dim sNoRefund As String = ConferenceControl.NoRefundDate.ToString("MMMM d, yyyy", CultureInfo.CurrentCulture)

            sCancellation = "<h3>Cancellation</h3><small>For Conference registration cancellations received by " + sCancelBy + ", the " +
                                "registration fee will be refunded less a $" + ConferenceControl.ConferenceServiceFee.ToString + " service fee. " +
                                "No refunds will be made after " + sNoRefund +
                                ", but paid no-shows " +
                                "will receive all materials covered by their registration fees. Substitutions for registrants will " +
                                "be accepted, preferably with advance notice. If Battelle cancels the Conference due to circumstances " +
                                "beyond Battelle&rsquo;s reasonable control such as, but not limited to, acts of God, acts of war, " +
                                "government emergency, labor strikes, and/or unavailability of the event or exhibition facility, " +
                                "Battelle shall refund to attendee his/her previously paid registration fee(s) less a share of " +
                                "event cost incurred by Battelle. This refund shall be the attendee’s exclusive remedy and " +
                                "Battelle&rsquo;s sole liability for cancellation of the event for reasons generally described " +
                                "in this paragraph.</small><br /><br />"

            ExhibFeeEmail += sCancellation

            lblCancellation.Text = sCancellation

            RegistrationEmailHTML = hdnEmail.Value

            RegistrationEmailHTML = RegistrationEmailHTML.Replace("{[registration_fee_content]}", ExhibFeeEmail)

            hdnEmail.Value = RegistrationEmailHTML
        Else
            SessionTimeout()
        End If
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If hdnNewStart.Value = "No" Then
            Dim PersonID As Integer = Session("PersonID")
            Dim RegistrationEmailHTML As String
            RegistrationEmailHTML = hdnEmail.Value
            ' BEGIN SendEmail
            Dim PersonData = BattellePersonGetAsDataRow(PersonID)
            BattelleSendMail(RegistrationEmailHTML, PersonData("Email"), ConferenceControl.ConferenceShortName + " Balance Confirmation", Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)

        End If
        If Page.RouteData.Values("admin") <> "admin" Then
            Session.Abandon()
        End If
    End Sub

    Protected Sub SessionTimeout()
        ParticipationIDLogin.Visible = True
        PanelParticipationControl.Visible = True
        PanelContact.Visible = False
        PanelBalance.Visible = False
        PanelCheck.Visible = False
        lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your session has timed out. Please re-enter your Participation Code.</div>"
        lblAlert.Visible = True
    End Sub

End Class