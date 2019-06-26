Imports System.Web.Routing
Imports System.Globalization
Imports System.TimeZoneInfo
Public Class SponsorHome
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ConferenceControl As New ConferenceFromURL
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            Dim dOpenDate As Date = ConferenceControl.SponsorOpenDate
            Me.lblOpenDate.Text = dOpenDate.ToString("dddd, MMMM d, yyyy", CultureInfo.CurrentCulture)
            Dim sTime As String = dOpenDate.ToString("t", CultureInfo.CurrentCulture)
            If sTime = "12:00 PM" Then
                sTime = "12:00 Noon"
            End If
            lblTime.Text = sTime
            lblConference.Text = ConferenceControl.ConferenceName
            lblConfType.Text = ConferenceControl.ConferenceType
            lblConfType2.Text = ConferenceControl.ConferenceType

            Dim sESTEDT As String = DisplayTimeZoneName(dOpenDate)
            If sESTEDT = "Eastern Daylight Time" Then
                lblESTEDT.Text = "EDT"
            Else
                lblESTEDT.Text = "EST"
            End If

            lblConfDates.Text = ConferenceControl.ConferenceDateSpanText
            lblVenue.Text = ConferenceControl.Venue + "<br />"
            lblVenueAddress.Text = ConferenceControl.VenueAddress + "<br />"
            lblCityState.Text = ConferenceControl.ConferenceLocation + "&nbsp;"
            lblZip.Text = ConferenceControl.VenueZip + "<br />"
            If ConferenceControl.VenuePhone <> "" Then
                lblPhone.Text = "Phone:&nbsp;" + ConferenceControl.VenuePhone
                lblPhone.Visible = True
            End If
            If ConferenceControl.VenueURL <> "" Then
                lblVenueURL.Text = ConferenceControl.VenueURL
                lblVenueURL.Visible = True
            End If
            With lnkConferenceSite
                .NavigateUrl = ConferenceControl.ConferenceReturnURL
                .Text = ConferenceControl.ConferenceReturnURL
                .Target = "_blank"
            End With
            lblWho.Text = ConferenceControl.WhoShouldExhibit
        End If

    End Sub

    Protected Sub ButtonBegin_Click(sender As Object, e As EventArgs) Handles ButtonBegin.Click
        Response.RedirectToRoute("SponsorBoothSelectionRoute", New With {.conference = Page.RouteData.Values("conference")})
    End Sub

    Private Function DisplayTimeZoneName(dOpenDate As Date) As String
        Dim timezone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Eastern Standard Time")
        If timezone.IsDaylightSavingTime(dOpenDate) Then
            Return timezone.DaylightName
        Else
            Return timezone.StandardName
        End If
    End Function
End Class