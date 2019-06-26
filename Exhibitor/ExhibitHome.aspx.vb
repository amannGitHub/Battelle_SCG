Imports System.Globalization
Imports System.TimeZoneInfo
Imports System.Web.Routing
Public Class ExhibitHome
    Inherits System.Web.UI.Page

    'Check for Exhibit or Sponsor based onURL
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
        'If Not IsPostBack Then
        'Check for hanging slash (breaks images) 'SCGTODO - fix this without hack
        'Dim sURL As String
        'sURL = Request.ServerVariables("URL")
        'If Right(sURL, 1) = "/" Then
        '    sURL = "~" & Left(sURL, (Len(sURL) - 1))
        '    Response.Redirect(sURL, True)
        'End If
        Dim ConferenceControl As New ConferenceFromURL
        ConferenceControl = Master.FindControl("ConferenceFromURL")




        'Get open date
        Dim dOpenDate As Date


        If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
            ExhibitorOrSponsor = "Sponsor"
            dOpenDate = ConferenceControl.SponsorOpenDate
        Else
            dOpenDate = ConferenceControl.ExhibitOpenDate
        End If


        Dim sTime As String
        If dOpenDate = "01/01/1990" Then 'This value is set as default in ConferenceFromURL if no date is set in the database
            PanelExhibitOpenDate.Visible = False
        Else
            PanelExhibitOpenDate.Visible = True

            'Get TimeZone info
            Dim sESTEDT As String = DisplayTimeZoneName(dOpenDate)
            If sESTEDT = "Eastern Daylight Time" Then
                lblESTEDT.Text = "EDT"
            Else
                lblESTEDT.Text = "EST"
            End If

            Me.lblOpenDate.Text = dOpenDate.ToString("dddd, MMMM d, yyyy", CultureInfo.CurrentCulture)

            sTime = dOpenDate.ToString("t", CultureInfo.CurrentCulture)
            If sTime = "12:00 PM" Then
                sTime = "12:00 Noon"
            End If

            lblTime.Text = sTime
        End If


        lblConference.Text = ConferenceControl.ConferenceName
        lblConfType.Text = ConferenceControl.ConferenceType
        lblConfType2.Text = ConferenceControl.ConferenceType

        'Hotel warning
        lblShortConfName.Text = ConferenceControl.ConferenceShortName
        lblConfType3.Text = ConferenceControl.ConferenceType
        lblVenue2.Text = ConferenceControl.Venue

        lblConfDates.Text = ConferenceControl.ConferenceDateSpanText
        lblVenue.Text = ConferenceControl.Venue + "<br />"
        lblVenue2.Text = ConferenceControl.PropertyAgreements
        lblVenueAddress.Text = ConferenceControl.VenueAddress + "<br />"
        lblCityState.Text = ConferenceControl.ConferenceLocation + "&nbsp;"
        lblZip.Text = ConferenceControl.VenueZip + "<br />"
        If ConferenceControl.VenuePhone <> "" Then
            lblPhone.Text = "Phone:&nbsp;" + ConferenceControl.VenuePhone
        End If
        If ConferenceControl.VenueURL <> "" Then
            lblVenueURL.Text = ConferenceControl.VenueURL
        End If
        With lnkConferenceSite
            .NavigateUrl = ConferenceControl.ConferenceReturnURL
            .Text = ConferenceControl.ConferenceReturnURL
            .Target = "_blank"
        End With
        lblWho.Text = ConferenceControl.WhoShouldExhibit

        'Allow registraion to begin 15 minutes prior
        If Now() >= dOpenDate.AddMinutes(-15) Then
            'ButtonBegin.Visible = True
            ButtonBegin.Text = "Begin Booth Reservation Now"
            ButtonBegin.Enabled = True
            ButtonBegin.CssClass = "btn btn-primary"
            lblClosed.Visible = False
            lnkBtnRefresh.Visible = False
            lblServerTime.Visible = False
        Else
            'ButtonBegin.Visible = False
            ButtonBegin.Enabled = False
            ButtonBegin.Text = "Begin Booth Reservation"
            ButtonBegin.CssClass = "btn btn-default"
            lblClosed.Visible = True
            lblClosed.Text = "<div class=""alert alert-warning"" role=""alert"">You may begin the reservation process beginning " & Me.lblOpenDate.Text & " " & dOpenDate.AddMinutes(-15).ToString("t", CultureInfo.CurrentCulture) & " " & lblESTEDT.Text & ". Booth selection will begin at " & sTime & " " & lblESTEDT.Text & ".</div>"
            lnkBtnRefresh.Visible = True
            lblServerTime.Text = " <i>Current Server Time: </i>" & Now()
            lblServerTime.Visible = True
        End If

        'SqlDataSourceSponsors.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        'SqlDataSourceFoodBevSponsors.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        'If Left(sExhibOrSponsor, 4) <> "spon" Then

        If ConferenceControl.ExhibitPageOpen = True Then
            pnlWelcome.Visible = True
        Else
            'Show message
            pnlWelcome.Visible = False
            lblClosed.Visible = True
        End If
        'Else
        'pnlWelcome.Visible = True 'SCGTODO fix this mess
        'End If

        'End If

    End Sub
    Protected Sub ButtonBegin_Click(sender As Object, e As EventArgs) Handles ButtonBegin.Click
        Dim sExhibOrSponsor As String = Page.RouteData.Values("type")
        If sExhibOrSponsor = "sponsor" Then
            Response.RedirectToRoute("SponsorBoothSelectionRoute", New With {.conference = Page.RouteData.Values("conference")})
        Else
            Response.RedirectToRoute("ExhbitBoothSelectionRoute", New With {.conference = Page.RouteData.Values("conference")})
        End If

    End Sub

    Private Function DisplayTimeZoneName(dOpenDate As Date) As String
        Dim timezone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Eastern Standard Time")
        If timezone.IsDaylightSavingTime(dOpenDate) Then
            Return timezone.DaylightName
        Else
            Return timezone.StandardName
        End If
    End Function

    Protected Sub lnkBtnRefresh_Click(sender As Object, e As EventArgs) Handles lnkBtnRefresh.Click
        'lblServerTime.Text = " <i>Current Server Time: </i>" & Now()
    End Sub
End Class