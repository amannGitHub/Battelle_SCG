Public Class SponsorRegistrationConfirmation
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Dim dv As DataView
    Dim irows As Integer




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

                'Send email
            Else
                PanelParticipationControl.Visible = True


                PanelBalance.Visible = False
                PanelDetails.Visible = False

                hdnNewStart.Value = "Yes"



            End If


        End If
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            SqlDataSourceConfirmation.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceConfirmation.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

        End If
        lblConferenceType.Text = ConferenceControl.ConferenceType
        lblConferenceType2.Text = ConferenceControl.ConferenceType

    End Sub

    Protected Sub FormViewConfirmation_DataBound(sender As Object, e As EventArgs) Handles FormViewConfirmation.DataBound
        Dim DataRow As DataRowView = CType(FormViewConfirmation.DataItem, DataRowView)
        Dim PersonID As Integer = Session("PersonID")

        ' BEGIN SendEmail
        Dim PersonData = BattellePersonGetAsDataRow(PersonID)

        Dim SponsorRegistrationHTML As String = String.Empty

        SponsorRegistrationHTML += "<p align=""left"">"
        SponsorRegistrationHTML += "Conference: <b>" + ConferenceControl.ConferenceName + "</b><br /><br />"
        SponsorRegistrationHTML += "<b>Sponsor Point of Contact:</b> " + DataRow("FirstName").ToString + " " + DataRow("LastName").ToString + "<br />"
        SponsorRegistrationHTML += "<b>Participant Code:</b> <i>" + DataRow("ParticipationID").ToString + "</i><br />"
        SponsorRegistrationHTML += "<b>Company:</b> " + DataRow("Exhibitor").ToString + "<br />"
        SponsorRegistrationHTML += "<span style=""font-weight:bold; color:red; font-size:larger;""><b>Organization ID:</b> <i>" + DataRow("OrganizationID").ToString + "</i></span><br />"
        SponsorRegistrationHTML += "<b>Address Line 1:</b> " + DataRow("AddressLine1").ToString + "<br />"
        SponsorRegistrationHTML += "<b>Address Line 2:</b> " + DataRow("AddressLine2").ToString + "<br />"
        SponsorRegistrationHTML += "<b>Address Line 3:</b> " + DataRow("AddressLine3").ToString + "<br />"
        SponsorRegistrationHTML += "<b>City:</b> " + DataRow("City").ToString + "<br />"
        SponsorRegistrationHTML += "<b>State/Province:</b> " + DataRow("StateProvince").ToString + "<br />"
        SponsorRegistrationHTML += "<b>Zip/Postal Code:</b> " + DataRow("ZipPostal").ToString + "<br />"
        SponsorRegistrationHTML += "<b>Country:</b> " + DataRow("Country").ToString + "<br />"
        SponsorRegistrationHTML += "<b>Phone:</b> " + DataRow("PhoneNum").ToString + "<br />"
        SponsorRegistrationHTML += "<b>Email:</b> " + DataRow("Email").ToString + "<br /><br />"
        SponsorRegistrationHTML += "Selected Sponsorship: <b>" + DataRow("SponsorType").ToString + "</b><br />"
        SponsorRegistrationHTML += "Sponsorship benefits:<br />" + DataRow("SponsorTypeDetails").ToString + "<br /><br />"
        SponsorRegistrationHTML += "<b>Company Description:</b> " + DataRow("CompanyDescription").ToString + "<br />"
        SponsorRegistrationHTML += "<b>Uploaded Image File:</b> " + DataRow("FileName").ToString + "<br />"
        SponsorRegistrationHTML += "<b>Registration Date:</b> " + DataRow("RegistrationDate").ToString + "<br />"
        'SponsorRegistrationHTML += "<b>Address Line 1:</b> " + DataRow("ExhibAddressLine1").ToString + "<br />"
        'SponsorRegistrationHTML += "<b>Address Line 2:</b> " + DataRow("ExhibAddressLine2").ToString + "<br />"
        ''SponsorRegistrationHTML += "<b>Address Line 3:</b> " + DataRow("ExhibAddressLine3").ToString + "<br />"
        'SponsorRegistrationHTML += "<b>City:</b> " + DataRow("ExhibCity").ToString + "<br />"
        'SponsorRegistrationHTML += "<b>State/Province:</b> " + DataRow("ExhibStateProvince").ToString + "<br />"
        'SponsorRegistrationHTML += "<b>Zip/Postal Code:</b> " + DataRow("ExhibZipPostal").ToString + "<br />"
        'SponsorRegistrationHTML += "<b>Country:</b> " + DataRow("ExhibCountry").ToString + "<br />"
        SponsorRegistrationHTML += "</p>"


        Dim SponsorRegistrationEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_sponsor_registration")
        Dim SponsorRegistrationEmailHTML As String
        If SponsorRegistrationEmail Is Nothing Then

            SponsorRegistrationEmail = BattelleEmailGetByNameAsDataRow("sponsor_registration")

        End If
        SponsorRegistrationEmailHTML = SponsorRegistrationEmail("EmailHTML")
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[first_name]}", PersonData("FirstName"))
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[last_name]}", PersonData("LastName"))
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_name]}", ConferenceControl.ConferenceName)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_type]}", ConferenceControl.ConferenceType)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_meeting_planner]}", ConferenceControl.MeetingPlanner)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
        'SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[conference_url_string]}", ConferenceControl.ConferenceURLString)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[booth_reservation_content]}", SponsorRegistrationHTML)
        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[battelle_conference_url]}", ConferenceControl.ConferenceReturnURL)

        'SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[exhibit_link_url]}", SponsorRegistrationHTML)

        'BattelleSendMail(SponsorRegistrationEmailHTML, PersonData("Email"), "Booth Reservation for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferenceEmail)
        hdnEmail.Value = SponsorRegistrationEmailHTML
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
            PanelDetails.Visible = True
        Else
            GetExhibInfo()
        End If




    End Sub

    Sub GetExhibInfo()
        SqlDataSourceCompany.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        'SqlDataSourceCompany.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        dv = CType(SqlDataSourceCompany.Select(DataSourceSelectArguments.Empty), DataView)
        irows = CType(dv.Table.Rows.Count, Integer)
        If irows > 0 Then ' Data found
            'lblCompanyName.Text = dv.Table.Rows(0).Item("Exhibitor").ToString
            Session("ExhibitorID") = dv.Table.Rows(0).Item("ExhibitorID").ToString

            SqlDataSourceBalance.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceBalance.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            PanelBalance.Visible = True
            PanelDetails.Visible = True


            SqlDataSourceConfirmation.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceConfirmation.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID


        Else
            'PanelExhibitor.Visible = True
        End If
    End Sub







    'Protected Sub btnOrgID_Click(sender As Object, e As EventArgs) Handles btnOrgID.Click
    '    If txtOrgID.Text.Trim <> "" Then
    '        SqlDataSourceOrgID.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
    '        SqlDataSourceOrgID.SelectParameters("OrganizationID").DefaultValue = txtOrgID.Text
    '        dv = CType(SqlDataSourceOrgID.Select(DataSourceSelectArguments.Empty), DataView)
    '        irows = CType(dv.Table.Rows.Count, Integer)
    '        If irows > 0 Then ' Data found
    '            Dim iExhibID As Integer
    '            iExhibID = dv.Table.Rows(0).Item("ExhibitorID").ToString
    '            If Not IsNothing(iExhibID) Then
    '                Session("ExhibitorID") = iExhibID
    '                GetExhibInfo()
    '            End If
    '            Session("BoothID") = dv.Table.Rows(0).Item("BoothID").ToString
    '        Else
    '            lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your organization has not reserved a booth. Ensure you have the correct Organization ID.</div>"
    '            lblAlert.Visible = True
    '        End If
    '    End If
    'End Sub




    Protected Sub gvBalance_DataBound(sender As Object, e As EventArgs) Handles gvBalance.DataBound
        Dim SumTotal As Decimal
        SumTotal = gvBalance.DataKeys(0).Value
        lblSumTotal.Text = SumTotal

        Dim ExhibFeeEmail, SponsorRegistrationEmailHTML As String
        Dim cLabel As Label
        ExhibFeeEmail = "<h3>Sponsor Registration Fees</h3>"
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
        ExhibFeeEmail += "<b>Total Balance:</b> US " + String.Format("{0:c}", lblSumTotal.Text) + "<br /><br />"

        SponsorRegistrationEmailHTML = hdnEmail.Value

        SponsorRegistrationEmailHTML = SponsorRegistrationEmailHTML.Replace("{[exhibitor_fee_content]}", ExhibFeeEmail)

        hdnEmail.Value = SponsorRegistrationEmailHTML
    End Sub



    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If hdnNewStart.Value = "No" Then
            Dim PersonID As Integer = Session("PersonID")
            Dim SponsorRegistrationEmailHTML As String
            SponsorRegistrationEmailHTML = hdnEmail.Value
            ' BEGIN SendEmail
            Dim PersonData = BattellePersonGetAsDataRow(PersonID)
            BattelleSendMail(SponsorRegistrationEmailHTML, PersonData("Email"), ConferenceControl.ConferenceShortName + " Sponsor Registration Confirmation", Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail, "phippss@battelle.org,melaragm@battelle.org")

        End If
        If Page.RouteData.Values("admin") <> "admin" Then
            Session.Abandon()
        End If
    End Sub


End Class