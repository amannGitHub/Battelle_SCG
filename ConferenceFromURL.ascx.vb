Imports System.Globalization
Imports System.Web.Routing
Public Class ConferenceFromURL
    Inherits System.Web.UI.UserControl

    Public Property ConferenceID() As Integer
        Get
            If (ViewState("ConferenceID") IsNot Nothing) Then
                Return CType(ViewState("ConferenceID"), Integer)
            Else
                Return 0
            End If
        End Get
        Set(value As Integer)
            ViewState("ConferenceID") = value
        End Set
    End Property

    Public Property ConferenceURLString() As String
        Get
            If (ViewState("ConferenceURLString") IsNot Nothing) Then
                Return CType(ViewState("ConferenceURLString"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceURLString") = value
        End Set
    End Property

    Public Property ConferenceSubjectEmail() As String
        Get
            If (ViewState("ConferenceSubjectEmail") IsNot Nothing) Then
                Return CType(ViewState("ConferenceSubjectEmail"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceSubjectEmail") = value
        End Set
    End Property

    Public Property ConferencePlannerEmail() As String
        Get
            If (ViewState("ConferencePlannerEmail") IsNot Nothing) Then
                Return CType(ViewState("ConferencePlannerEmail"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferencePlannerEmail") = value
        End Set
    End Property

    Public Property MeetingPlanner() As String
        Get
            If (ViewState("MeetingPlanner") IsNot Nothing) Then
                Return CType(ViewState("MeetingPlanner"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("MeetingPlanner") = value
        End Set
    End Property

    Public Property ConferenceName() As String
        Get
            If (ViewState("ConferenceName") IsNot Nothing) Then
                Return CType(ViewState("ConferenceName"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceName") = value
        End Set
    End Property

    Public Property ConferenceShortName() As String
        Get
            If (ViewState("ConferenceShortName") IsNot Nothing) Then
                Return CType(ViewState("ConferenceShortName"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceShortName") = value
        End Set
    End Property

    Public Property ConferenceType() As String
        Get
            If (ViewState("ConferenceType") IsNot Nothing) Then
                Return CType(ViewState("ConferenceType"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceType") = value
        End Set
    End Property

    Public Property ConferenceTechnicalScope() As String
        Get
            If (ViewState("ConferenceTechnicalScope") IsNot Nothing) Then
                Return CType(ViewState("ConferenceTechnicalScope"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceTechnicalScope") = value
        End Set
    End Property

    Public Property ConferenceFinalPlacement() As String
        Get
            If (ViewState("ConferenceFinalPlacement") IsNot Nothing) Then
                Return CType(ViewState("ConferenceFinalPlacement"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceFinalPlacement") = value
        End Set
    End Property

    Public Property ConferenceAbstractReturnURL() As String
        Get
            If (ViewState("ConferenceAbstractReturnURL") IsNot Nothing) Then
                Return CType(ViewState("ConferenceAbstractReturnURL"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceAbstractReturnURL") = value
        End Set
    End Property

    Public Property ConferenceReturnURL() As String
        Get
            If (ViewState("ConferenceReturnURL") IsNot Nothing) Then
                Return CType(ViewState("ConferenceReturnURL"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceReturnURL") = value
        End Set
    End Property

    Public Property ConferenceDateSpanText() As String
        Get
            If (ViewState("ConferenceDateSpanText") IsNot Nothing) Then
                Return CType(ViewState("ConferenceDateSpanText"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceDateSpanText") = value
        End Set
    End Property

    Public Property ConferenceLocation() As String
        Get
            If (ViewState("ConferenceLocation") IsNot Nothing) Then
                Return CType(ViewState("ConferenceLocation"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceLocation") = value
        End Set
    End Property

    Public Property Venue() As String
        Get
            If (ViewState("Venue") IsNot Nothing) Then
                Return CType(ViewState("Venue"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("Venue") = value
        End Set
    End Property

    Public Property VenueAddress() As String
        Get
            If (ViewState("VenueAddress") IsNot Nothing) Then
                Return CType(ViewState("VenueAddress"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("VenueAddress") = value
        End Set
    End Property

    Public Property VenueZip() As String
        Get
            If (ViewState("VenueZip") IsNot Nothing) Then
                Return CType(ViewState("VenueZip"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("VenueZip") = value
        End Set
    End Property

    Public Property VenuePhone() As String
        Get
            If (ViewState("VenuePhone") IsNot Nothing) Then
                Return CType(ViewState("VenuePhone"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("VenuePhone") = value
        End Set
    End Property

    Public Property VenueURL() As String
        Get
            If (ViewState("VenueURL") IsNot Nothing) Then
                Return CType(ViewState("VenueURL"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("VenueURL") = value
        End Set
    End Property

    Public Property PropertyAgreements() As String
        Get
            If (ViewState("PropertyAgreements") IsNot Nothing) Then
                Return CType(ViewState("PropertyAgreements"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("PropertyAgreements") = value
        End Set
    End Property

    Public Property WhoShouldExhibit() As String
        Get
            If (ViewState("WhoShouldExhibit") IsNot Nothing) Then
                Return CType(ViewState("WhoShouldExhibit"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("WhoShouldExhibit") = value
        End Set
    End Property

    Public Property ExhibMailingListFirstDate() As String
        Get
            If (ViewState("ExhibMailingListFirstDate") IsNot Nothing) Then
                Return CType(ViewState("ExhibMailingListFirstDate"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ExhibMailingListFirstDate") = value
        End Set
    End Property

    Public Property ExhibMailingListSecondDate() As String
        Get
            If (ViewState("ExhibMailingListSecondDate") IsNot Nothing) Then
                Return CType(ViewState("ExhibMailingListSecondDate"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ExhibMailingListSecondDate") = value
        End Set
    End Property

    Public Property ConferenceSCGCode() As String
        Get
            If (ViewState("ConferenceSCGCode") IsNot Nothing) Then
                Return CType(ViewState("ConferenceSCGCode"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("ConferenceSCGCode") = value
        End Set
    End Property

    Public Property ConferenceStartDate() As Date
        Get
            If (ViewState("ConferenceStartDate") IsNot Nothing) Then
                Return CType(ViewState("ConferenceStartDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("ConferenceStartDate") = value
        End Set
    End Property

    Public Property ConferenceEndDate() As Date
        Get
            If (ViewState("ConferenceEndDate") IsNot Nothing) Then
                Return CType(ViewState("ConferenceEndDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("ConferenceEndDate") = value
        End Set
    End Property


    Public Property RegistrationCancelByDate() As Date
        Get
            If (ViewState("RegistrationCancelByDate") IsNot Nothing) Then
                Return CType(ViewState("RegistrationCancelByDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("RegistrationCancelByDate") = value
        End Set
    End Property

    Public Property RegistrationFeeIncreaseDate() As Date
        Get
            If (ViewState("RegistrationFeeIncreaseDate") IsNot Nothing) Then
                Return CType(ViewState("RegistrationFeeIncreaseDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("RegistrationFeeIncreaseDate") = value
        End Set
    End Property

    Public Property RegistrationCancelBy75PercentDate() As Date
        Get
            If (ViewState("RegistrationCancelBy75PercentDate") IsNot Nothing) Then
                Return CType(ViewState("RegistrationCancelBy75PercentDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("RegistrationCancelBy75PercentDate") = value
        End Set
    End Property

    Public Property RegistrationCancelBy50PercentDate() As Date
        Get
            If (ViewState("RegistrationCancelBy50PercentDate") IsNot Nothing) Then
                Return CType(ViewState("RegistrationCancelBy50PercentDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("RegistrationCancelBy50PercentDate") = value
        End Set
    End Property


    Public Property NoRefundDate() As Date
        Get
            If (ViewState("NoRefundDate") IsNot Nothing) Then
                Return CType(ViewState("NoRefundDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("NoRefundDate") = value
        End Set
    End Property



    Public Property RegistrationCloseDate() As Date
        Get
            If (ViewState("RegistrationCloseDate") IsNot Nothing) Then
                Return CType(ViewState("RegistrationCloseDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("RegistrationCloseDate") = value
        End Set
    End Property

    Public Property RegistrationTermsConditionsURL() As String
        Get
            If (ViewState("RegistrationTermsConditionsURL") IsNot Nothing) Then
                Return CType(ViewState("RegistrationTermsConditionsURL"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("RegistrationTermsConditionsURL") = value
        End Set
    End Property


    Public Property SponsorOpenDate() As Date
        Get
            If (ViewState("SponsorOpenDate") IsNot Nothing) Then
                Return CType(ViewState("SponsorOpenDate"), Date)
            Else
                Return "01/01/1990"
            End If
        End Get
        Set(value As Date)
            ViewState("SponsorOpenDate") = value
        End Set
    End Property

    Public Property SponsorOpportunityURL() As String
        Get
            If (ViewState("SponsorOpportunityURL") IsNot Nothing) Then
                Return CType(ViewState("SponsorOpportunityURL"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("SponsorOpportunityURL") = value
        End Set
    End Property

    Public Property ExhibitPageOpen() As Boolean
        Get
            If (ViewState("ExhibitPageOpen") IsNot Nothing) Then
                Return CType(ViewState("ExhibitPageOpen"), Boolean)
            Else
                Return False
            End If
        End Get
        Set(value As Boolean)
            ViewState("ExhibitPageOpen") = value
        End Set
    End Property

    Public Property ExhibitOpenDate() As Date
        Get
            If (ViewState("ExhibitOpenDate") IsNot Nothing) Then
                Return CType(ViewState("ExhibitOpenDate"), Date)
            Else
                Return "01/01/1990"
            End If
        End Get
        Set(value As Date)
            ViewState("ExhibitOpenDate") = value
        End Set
    End Property

    Public Property ExhibitCloseDate() As Date
        Get
            If (ViewState("ExhibitCloseDate") IsNot Nothing) Then
                Return CType(ViewState("ExhibitCloseDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("ExhibitCloseDate") = value
        End Set
    End Property

    Public Property BoothStaffRegisterByDate() As Date
        Get
            If (ViewState("BoothStaffRegisterByDate") IsNot Nothing) Then
                Return CType(ViewState("BoothStaffRegisterByDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("BoothStaffRegisterByDate") = value
        End Set
    End Property

    Public Property ShortCourseOpenDate() As Date
        Get
            If (ViewState("ShortCourseOpenDate") IsNot Nothing) Then
                Return CType(ViewState("ShortCourseOpenDate"), Date)
            Else
                Return Now
            End If
        End Get
        Set(value As Date)
            ViewState("ShortCourseOpenDate") = value
        End Set
    End Property

    Public Property ShortCourseClosedDate() As Date
        Get
            If (ViewState("ShortCourseClosedDate") IsNot Nothing) Then
                Return CType(ViewState("ShortCourseClosedDate"), Date)
            Else
                Return "01/01/1990"
            End If
        End Get
        Set(value As Date)
            ViewState("ShortCourseClosedDate") = value
        End Set
    End Property


    Public Property ConferenceServiceFee() As Integer 'This is for booth sales
        Get
            If (ViewState("ConferenceServiceFee") IsNot Nothing) Then
                Return CType(ViewState("ConferenceServiceFee"), Integer)
            Else
                Return 150
            End If
        End Get
        Set(value As Integer)
            ViewState("ConferenceServiceFee") = value
        End Set
    End Property

    Public Property TechSessionCancelServiceFee() As Integer 'This is for registration service fees
        Get
            If (ViewState("TechSessionCancelServiceFee") IsNot Nothing) Then
                Return CType(ViewState("TechSessionCancelServiceFee"), Integer)
            Else
                Return 50
            End If
        End Get
        Set(value As Integer)
            ViewState("TechSessionCancelServiceFee") = value
        End Set
    End Property
    Public Property PayByCheckAllowed() As Boolean
        Get
            If (ViewState("PayByCheckAllowed") IsNot Nothing) Then
                Return CType(ViewState("PayByCheckAllowed"), Boolean)
            Else
                Return False
            End If
        End Get
        Set(value As Boolean)
            ViewState("PayByCheckAllowed") = value
        End Set
    End Property




    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Try
            Dim Conference As String = Page.RouteData.Values("conference")

            Me.imgBanner.ImageUrl = "~/images/banners/" & Page.RouteData.Values("conference") & ".jpg"

            Dim dv As DataView
            Dim iRows As Integer



            dv = CType(SqlDataSourceConf.Select(DataSourceSelectArguments.Empty), DataView)
            iRows = CType(dv.Table.Rows.Count, Integer)



            If iRows > 0 Then ' Data found

                ConferenceID = dv.Table.Rows(0)("ConferenceID")

                hdnConfName.Value = dv.Table.Rows(0).Item("Name").ToString
                hdnConfShortName.Value = dv.Table.Rows(0).Item("ShortName").ToString

                Dim sConfDates, sMailingFirst, sMailingSecond As String
                Dim dStart As DateTime
                Dim dEnd As DateTime

                Dim sRegistrationCancelByDate, sRegistrationCancelBy75PercentDate, sRegistrationCancelBy50PercentDate, sNoRefundDate As String
                Dim dMailingFirst, dMailingSecond As DateTime

                dStart = dv.Table.Rows(0).Item("StartDate").ToString
                dEnd = dv.Table.Rows(0).Item("EndDate").ToString

                sConfDates = dStart.ToString("MMMM d", CultureInfo.CurrentCulture) & "-" & dEnd.ToString("d, yyyy", CultureInfo.CurrentCulture)
                hdnConfDates.Value = sConfDates

                Dim sCity, sState As String

                sCity = dv.Table.Rows(0).Item("City").ToString
                sState = dv.Table.Rows(0).Item("State").ToString

                hdnConfLocation.Value = sCity & ", " & sState

                hdnExampleAbstract.Value = dv.Table.Rows(0).Item("ExampleAbstractURL").ToString
                hdnTechnicalScope.Value = dv.Table.Rows(0).Item("TechnicalProgramScopeURL").ToString
                ConferenceTechnicalScope = dv.Table.Rows(0).Item("TechnicalProgramScopeURL").ToString

                If dv.Table.Rows(0).Item("FinalPlacementDate").ToString <> "" Then
                    Dim dFinalPlacement As Date = dv.Table.Rows(0).Item("FinalPlacementDate").ToString
                    hdnFinalPlacement.Value = dFinalPlacement.ToString("MMMM d, yyyy", CultureInfo.CurrentCulture)
                    ConferenceFinalPlacement = dFinalPlacement.ToString("MMMM yyyy", CultureInfo.CurrentCulture)
                End If

                If dv.Table.Rows(0).Item("SponsorReservationDate").ToString <> "" Then
                    SponsorOpenDate = dv.Table.Rows(0).Item("SponsorReservationDate").ToString
                End If
                If dv.Table.Rows(0).Item("ExhibitRegistrationDate").ToString <> "" Then
                    ExhibitOpenDate = dv.Table.Rows(0).Item("ExhibitRegistrationDate").ToString
                End If
                If dv.Table.Rows(0).Item("ExhibitRegistrationCloseDate").ToString <> "" Then
                    ExhibitCloseDate = dv.Table.Rows(0).Item("ExhibitRegistrationCloseDate").ToString
                End If

                If dv.Table.Rows(0).Item("BoothStaffRegisterByDate").ToString <> "" Then
                    BoothStaffRegisterByDate = dv.Table.Rows(0).Item("BoothStaffRegisterByDate").ToString
                End If

                If dv.Table.Rows(0).Item("RegistrationCloseDate").ToString <> "" Then
                    RegistrationCloseDate = dv.Table.Rows(0).Item("RegistrationCloseDate").ToString
                End If

                If dv.Table.Rows(0).Item("RegistrationTermsConditionsURL").ToString <> "" Then
                    RegistrationTermsConditionsURL = dv.Table.Rows(0).Item("RegistrationTermsConditionsURL").ToString
                End If

                hdnConferenceEmail.Value = dv.Table.Rows(0).Item("SubjectEmail").ToString

                If dv.Table.Rows(0).Item("PreliminaryProgramDate").ToString <> "" Then
                    Dim dPrelim As Date
                    dPrelim = dv.Table.Rows(0).Item("PreliminaryProgramDate").ToString
                    hdnPreliminaryProgram.Value = dPrelim.ToString("MMMM yyyy", CultureInfo.CurrentCulture)
                End If
                

                ' Seperator 

                ConferenceName = dv.Table.Rows(0).Item("Name").ToString
                ConferenceShortName = dv.Table.Rows(0).Item("ShortName").ToString
                ConferenceDateSpanText = dStart.ToString("MMMM d", CultureInfo.CurrentCulture) & "-" & dEnd.ToString("d, yyyy", CultureInfo.CurrentCulture)
                ConferenceLocation = sCity & ", " & sState
                Venue = dv.Table.Rows(0).Item("Venue").ToString
                VenueAddress = dv.Table.Rows(0).Item("VenueAddress").ToString
                VenueZip = dv.Table.Rows(0).Item("ZipCode").ToString
                VenuePhone = dv.Table.Rows(0).Item("VenuePhone").ToString
                VenueURL = dv.Table.Rows(0).Item("VenueURL").ToString
                PropertyAgreements = dv.Table.Rows(0).Item("PropertyAgreements").ToString

                ExhibitPageOpen = dv.Table.Rows(0).Item("ExhibitPageOpen")
                WhoShouldExhibit = dv.Table.Rows(0).Item("WhoShouldExhibit").ToString

                ConferenceSubjectEmail = dv.Table.Rows(0).Item("SubjectEmail").ToString
                MeetingPlanner = dv.Table.Rows(0).Item("MeetingPlanner").ToString
                ConferencePlannerEmail = dv.Table.Rows(0).Item("ConferenceEmail").ToString

                ConferenceType = dv.Table.Rows(0).Item("ConferenceType").ToString
                ConferenceAbstractReturnURL = dv.Table.Rows(0).Item("AbstractReturnURL").ToString
                SponsorOpportunityURL = dv.Table.Rows(0).Item("SponsorOpportunityURL").ToString
                ConferenceReturnURL = dv.Table.Rows(0).Item("ReturnURL").ToString
                ConferenceURLString = Page.RouteData.Values("Conference")
                If dv.Table.Rows(0).Item("MailingListFirstDate").ToString <> "" Then
                    dMailingFirst = dv.Table.Rows(0).Item("MailingListFirstDate").ToString
                    sMailingFirst = dMailingFirst.ToString("MMMM d, yyyy", CultureInfo.CurrentCulture)
                    ExhibMailingListFirstDate = sMailingFirst
                End If
                If dv.Table.Rows(0).Item("MailingListSecondDate").ToString <> "" Then
                    dMailingSecond = dv.Table.Rows(0).Item("MailingListSecondDate").ToString
                    sMailingSecond = dMailingSecond.ToString("MMMM d, yyyy", CultureInfo.CurrentCulture)
                    ExhibMailingListSecondDate = sMailingSecond
                End If

                ConferenceSCGCode = dv.Table.Rows(0).Item("SCGContractCode").ToString
                If dv.Table.Rows(0).Item("RegistrationFeeIncreaseDate").ToString <> "" Then
                    RegistrationFeeIncreaseDate = dv.Table.Rows(0).Item("RegistrationFeeIncreaseDate").ToString
                End If

                If dv.Table.Rows(0).Item("ShortCourseOpen").ToString <> "" Then
                    ShortCourseOpenDate = dv.Table.Rows(0).Item("ShortCourseOpen").ToString
                End If


                If dv.Table.Rows(0).Item("ShortCourseClose").ToString <> "" Then
                    ShortCourseClosedDate = dv.Table.Rows(0).Item("ShortCourseClose").ToString
                End If


                ConferenceStartDate = dStart
                ConferenceEndDate = dEnd
                sRegistrationCancelByDate = dv.Table.Rows(0).Item("RegistrationCancelByDate").ToString
                If sRegistrationCancelByDate <> "" Then
                    RegistrationCancelByDate = sRegistrationCancelByDate
                End If

                sRegistrationCancelBy75PercentDate = dv.Table.Rows(0).Item("RegistrationCancelBy75PercentDate").ToString
                If sRegistrationCancelBy75PercentDate <> "" Then
                    RegistrationCancelBy75PercentDate = sRegistrationCancelBy75PercentDate
                End If

                sRegistrationCancelBy50PercentDate = dv.Table.Rows(0).Item("RegistrationCancelBy50PercentDate").ToString
                If sRegistrationCancelBy50PercentDate <> "" Then
                    RegistrationCancelBy50PercentDate = sRegistrationCancelBy50PercentDate
                End If

                sNoRefundDate = dv.Table.Rows(0).Item("NoRefundDate").ToString
                If sNoRefundDate <> "" Then
                    NoRefundDate = sNoRefundDate
                End If

                If dv.Table.Rows(0).Item("ServiceFee").ToString <> "" Then
                    ConferenceServiceFee = dv.Table.Rows(0).Item("ServiceFee").ToString
                End If

                If dv.Table.Rows(0).Item("TechSessionCancelServiceFee").ToString <> "" Then
                    TechSessionCancelServiceFee = dv.Table.Rows(0).Item("TechSessionCancelServiceFee").ToString
                Else
                    'Default to $50
                    TechSessionCancelServiceFee = 50
                End If

                PayByCheckAllowed = dv.Table.Rows(0).Item("PayByCheckAllowed")



            Else
                'Bad query string
                Response.Redirect("~/Error.aspx?NoConference", True)

            End If
        Catch ex As Exception
            'Bad query string
            Dim sBody As String
            sBody = "Message:<br />" + ex.Message + "<hr>"
            sBody += "Stack Trace:<br/>" + ex.StackTrace + "<hr>"
            BattelleSendMail(sBody, "scg", "Battelle Conference URL error", Net.Mail.MailPriority.High)
            Response.Redirect("~/Default.aspx", True)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


End Class