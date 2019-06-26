Public Class ExhibitConfirmation
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Dim iSteps As Integer = 9
    Dim dv As DataView
    Dim irows As Integer

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
        'Dim LogEntry As String
        'LogEntry = "Confirmation Page|pPersonID: " + Session("pPersonID") + "|"
        'LogEntry += "PersonID: " + Session("PersonID") + "|"
        'LogEntry += "pConferenceID: " + Session("pConferenceID")

        'BattelleLogDiagnostic(LogEntry)

        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then

            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
                If Page.RouteData.Values("admin") = "admin" Then
                    hdnNewStart.Value = "Yes"
                Else
                    hdnNewStart.Value = "No"
                End If
                GetExhibInfo()
                PanelProgress.Visible = False 'Continuing from Booth Reservation
                UpdateProgress(iProgress(6), 6, iSteps, "")
                'Send email
            Else
                PanelParticipationControl.Visible = True

                PanelProgress.Visible = False
                PanelBalance.Visible = False
                PanelBooth.Visible = False
                PanelStaff.Visible = False

                hdnNewStart.Value = "Yes"


                iSteps = 3
                UpdateProgress(iProgress(1), 1, iSteps, "")
            End If


        End If
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            SqlDataSourceConfirmation.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceConfirmation.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

            SqlDataSourceStaff.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceStaff.SelectParameters("ExhibitorID").DefaultValue = Session("ExhibitorID")
        End If
        lblConferenceType.Text = ConferenceControl.ConferenceType
        lblConferenceType2.Text = ConferenceControl.ConferenceType
        If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
            ExhibitorOrSponsor = "Sponsor"
        End If
    End Sub

    Protected Sub FormViewConfirmation_DataBound(sender As Object, e As EventArgs) Handles FormViewConfirmation.DataBound
        Dim DataRow As DataRowView = CType(FormViewConfirmation.DataItem, DataRowView)
        Dim PersonID As Integer = Session("PersonID")

        ' BEGIN SendEmail
        Dim PersonData = BattellePersonGetAsDataRow(PersonID)

        Dim BoothReservationConfirmationHTML As String = String.Empty

        BoothReservationConfirmationHTML += "<p align=""left"">"
        BoothReservationConfirmationHTML += "Conference: <b>" + ConferenceControl.ConferenceName + "</b><br /><br />"
        BoothReservationConfirmationHTML += "Booth Reservation: <br /><b>" + DataRow("BoothNumber").ToString + "</b><br />"
        BoothReservationConfirmationHTML += "<b>" + DataRow("BoothNumber2").ToString + "</b><br /><br />"
        BoothReservationConfirmationHTML += "<b>Exhibitor Point of Contact:</b> " + DataRow("FirstName").ToString + " " + DataRow("LastName").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Participant Code:</b> <i>" + DataRow("ParticipationID").ToString + "</i><br />"
        'BoothReservationConfirmationHTML += "<b>Address Line 1:</b> " + DataRow("AddressLine1").ToString + "<br />"
        'BoothReservationConfirmationHTML += "<b>Address Line 2:</b> " + DataRow("AddressLine2").ToString + "<br />"
        'BoothReservationConfirmationHTML += "<b>Address Line 3:</b> " + DataRow("AddressLine3").ToString + "<br />"
        'BoothReservationConfirmationHTML += "<b>City:</b> " + DataRow("City").ToString + "<br />"
        'BoothReservationConfirmationHTML += "<b>State/Province:</b> " + DataRow("StateProvince").ToString + "<br />"
        'BoothReservationConfirmationHTML += "<b>Zip/Postal Code:</b> " + DataRow("ZipPostal").ToString + "<br />"
        'BoothReservationConfirmationHTML += "<b>Country:</b> " + DataRow("Country").ToString + "<br /><br>"

        BoothReservationConfirmationHTML += "<b>Exhibiting Organization:</b> " + DataRow("Exhibitor").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Organization ID:</b> <b><i>" + DataRow("OrganizationID").ToString + "</i></b><br />"
        BoothReservationConfirmationHTML += "<b>Address Line 1:</b> " + DataRow("ExhibAddressLine1").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Address Line 2:</b> " + DataRow("ExhibAddressLine2").ToString + "<br />"
        'BoothReservationConfirmationHTML += "<b>Address Line 3:</b> " + DataRow("ExhibAddressLine3").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>City:</b> " + DataRow("ExhibCity").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>State/Province:</b> " + DataRow("ExhibStateProvince").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Zip/Postal Code:</b> " + DataRow("ExhibZipPostal").ToString + "<br />"
        BoothReservationConfirmationHTML += "<b>Country:</b> " + DataRow("ExhibCountry").ToString + "<br />"
        BoothReservationConfirmationHTML += "</p>"


        Dim BoothReservationEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_exhibit_confirmation")
        Dim BoothReservationEmailHTML As String
        If BoothReservationEmail Is Nothing Then
            If sExhibOrSponsor = "sponsor" Then
                BoothReservationEmail = BattelleEmailGetByNameAsDataRow("sponsor_reservation")
            Else
                BoothReservationEmail = BattelleEmailGetByNameAsDataRow("exhibit_confirmation")
            End If

        End If
        BoothReservationEmailHTML = BoothReservationEmail("EmailHTML")
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[first_name]}", PersonData("FirstName"))
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_name]}", ConferenceControl.ConferenceName)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_type]}", ConferenceControl.ConferenceType)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_meeting_planner]}", ConferenceControl.MeetingPlanner)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[conference_url_string]}", ConferenceControl.ConferenceURLString)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[battelle_conference_url]}", ConferenceControl.ConferenceReturnURL)
        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[booth_reservation_content]}", BoothReservationConfirmationHTML)

        'BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[exhibit_link_url]}", BoothReservationConfirmationHTML)

        'BattelleSendMail(BoothReservationEmailHTML, PersonData("Email"), "Booth Reservation for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferenceEmail)
        hdnEmail.Value = BoothReservationEmailHTML
        ' END SENDMAIL
    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
        'Response.Cookies("battelle")("PersonID") = PersonID  'removed Session("PersonID") on 8/25/2015
        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        ParticipationIDLogin.Visible = False
        PanelParticipationControl.Visible = False
        If Session("ExhibitorID") <> "" Then
            PanelBalance.Visible = True
            PanelBooth.Visible = True
            PanelStaff.Visible = True
        Else
            GetExhibInfo()
        End If


        'If Not IsNothing(PersonData) Then

        'End If

        UpdateProgress(iProgress(2), 2, 3, "")

    End Sub

    Sub GetExhibInfo()
        SqlDataSourceCompany.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        SqlDataSourceCompany.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        dv = CType(SqlDataSourceCompany.Select(DataSourceSelectArguments.Empty), DataView)
        irows = CType(dv.Table.Rows.Count, Integer)
        If irows > 0 Then ' Data found
            lblCompanyName.Text = dv.Table.Rows(0).Item("Exhibitor").ToString
            Session("ExhibitorID") = dv.Table.Rows(0).Item("ExhibitorID").ToString
            Session("BoothID") = dv.Table.Rows(0).Item("BoothID").ToString
            SqlDataSourceBalance.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceBalance.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            PanelBalance.Visible = True
            PanelBooth.Visible = True
            PanelStaff.Visible = True

            SqlDataSourceConfirmation.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceConfirmation.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

            SqlDataSourceStaff.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceStaff.SelectParameters("ExhibitorID").DefaultValue = Session("ExhibitorID")
        Else
            'PanelExhibitor.Visible = True
            lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your organization has not reserved a booth. Only the booth Point of Contact may view the confirmation information.</div>"
            lblAlert.Visible = True
            PanelBooth.Visible = False
        End If
    End Sub





    Protected Sub UpdateProgress(iProgress As Integer, iStep As Integer, iSteps As Integer, sStatus As String)

        lblProgress.Text = "<div class=""progress-bar" & sStatus & """ role=""progressbar"" aria-valuenow=""" & iProgress & """ aria-valuemin=""0"" aria-valuemax=""100"" style=""width: " & iProgress & "%;"">Step " & iStep & " of " & iSteps & "</div>"
    End Sub

    Function iProgress(iCurrent As Integer) As Integer
        If hdnNewStart.Value = "Yes" Then
            iSteps = 3
        End If
        iProgress = ((iCurrent / iSteps) * 100)
        Return iProgress
    End Function





    Protected Sub btnOrgID_Click(sender As Object, e As EventArgs) Handles btnOrgID.Click
        If txtOrgID.Text.Trim <> "" Then
            SqlDataSourceOrgID.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceOrgID.SelectParameters("OrganizationID").DefaultValue = txtOrgID.Text
            dv = CType(SqlDataSourceOrgID.Select(DataSourceSelectArguments.Empty), DataView)
            irows = CType(dv.Table.Rows.Count, Integer)
            If irows > 0 Then ' Data found
                Dim iExhibID As Integer
                iExhibID = dv.Table.Rows(0).Item("ExhibitorID").ToString
                If Not IsNothing(iExhibID) Then
                    Session("ExhibitorID") = iExhibID
                    GetExhibInfo()
                End If
                Session("BoothID") = dv.Table.Rows(0).Item("BoothID").ToString
            Else
                lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your organization has not reserved a booth. Ensure you have the correct Organization ID.</div>"
                lblAlert.Visible = True

            End If
        End If
    End Sub




    Protected Sub gvBalance_DataBound(sender As Object, e As EventArgs) Handles gvBalance.DataBound
        Dim SumTotal As Decimal
        SumTotal = gvBalance.DataKeys(0).Value
        lblSumTotal.Text = SumTotal

        Dim ExhibFeeEmail, BoothReservationEmailHTML As String
        Dim cLabel As Label
        ExhibFeeEmail = "<h3>Exhibitor Selections and Payment Fees</h3>"
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

        BoothReservationEmailHTML = hdnEmail.Value

        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[exhibitor_fee_content]}", ExhibFeeEmail)

        hdnEmail.Value = BoothReservationEmailHTML
    End Sub

    Protected Sub gvStaff_DataBound(sender As Object, e As EventArgs) Handles gvStaff.DataBound
        Dim BoothStaffEmail, BoothReservationEmailHTML As String
        BoothStaffEmail = "<h3>Registered Booth Staff</h3>"

        BoothStaffEmail += "<table border=""1"" cellpadding=""2"" cellspacing=""0""><tr>"
        For i As Integer = 0 To gvStaff.Columns.Count - 1
            BoothStaffEmail += "<th>" + gvStaff.Columns(i).HeaderText + "</th>"
        Next
        BoothStaffEmail += "</tr>"
        For i As Integer = 0 To gvStaff.Rows.Count - 1
            BoothStaffEmail += "<tr>"
            For j As Integer = 0 To gvStaff.Columns.Count - 1
                BoothStaffEmail += "<td>" + gvStaff.Rows(i).Cells(j).Text + "</td>"
            Next
            BoothStaffEmail += "</tr>"
        Next
        BoothStaffEmail += "</table><br />"

        BoothReservationEmailHTML = hdnEmail.Value

        BoothReservationEmailHTML = BoothReservationEmailHTML.Replace("{[booth_staff_content]}", BoothStaffEmail)

        hdnEmail.Value = BoothReservationEmailHTML

    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If hdnNewStart.Value = "No" Then
            Dim PersonID As Integer = Session("PersonID")
            Dim BoothReservationEmailHTML As String
            BoothReservationEmailHTML = hdnEmail.Value
            ' BEGIN SendEmail
            Dim PersonData = BattellePersonGetAsDataRow(PersonID)
            BattelleSendMail(BoothReservationEmailHTML, PersonData("Email"), ConferenceControl.ConferenceShortName + " Exhibitor Confirmation", Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)

        End If
        If Page.RouteData.Values("admin") <> "admin" Then
            Session.Abandon()
        End If
    End Sub


End Class