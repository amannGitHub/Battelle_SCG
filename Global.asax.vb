Imports System.Web.Optimization
Imports Microsoft.AspNet.FriendlyUrls

Imports Battelle.RoleActions

Public Class Global_asax
    Inherits HttpApplication

    Sub Application_Start(sender As Object, e As EventArgs)
        ' Fires when the application is started
        RouteTable.Routes.Ignore("{resource}.axd/{*pathInfo}")
        RouteTable.Routes.Ignore("{resource}.ashx/{*pathInfo}")
        RouteConfig.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles(BundleTable.Bundles)

        'Add Routes
        RegisterCustomRoutes(RouteTable.Routes)

        'Create work around session for ASP.NET Idenity/OWNIN BS
        'Session("Workaround") = 0

        ' Create the administrator role and user.
        Dim roleActions As New RoleActions()
        roleActions.createAdmin()

    End Sub

    Shared Sub RegisterCustomRoutes(routes As RouteCollection)

        routes.MapPageRoute("DefaultRoute",
            "{conference}",
           "~/Default.aspx")

        routes.MapPageRoute("AbstractsRoute",
            "{conference}/abstracts",
           "~/Abstract/Abstracts.aspx")

        routes.MapPageRoute("AbstractsRouteNoS",
            "{conference}/abstract",
           "~/Abstract/Abstracts.aspx")

        routes.MapPageRoute("AbstractsListRoute",
            "{conference}/abstractlist",
           "~/Abstract/AbstractList.aspx")

        routes.MapPageRoute("AbstractsReviewRoute",
            "{conference}/review",
           "~/Review/Dashboard.aspx")

        routes.MapPageRoute("AbstractsProgramChairReviewRoute",
            "{conference}/review/programchair",
           "~/Review/ProgramChair.aspx")

        routes.MapPageRoute("AbstractsProgramChairReview2Route",
            "{conference}/review/programchair2",
           "~/Review/ProgramChairPart2.aspx")

        routes.MapPageRoute("AbstractsProgramChairReviewAbstractRoute",
            "{conference}/review/programchair/abstract/{abstractid}/code/{code}",
           "~/Review/ProgramChairReview.aspx")

        routes.MapPageRoute("AbstractsProgramChairReReviewRoute",
            "{conference}/review/returned",
           "~/Review/ReturnedToProgramChairs.aspx")

        routes.MapPageRoute("AbstractsProgramChairReReviewAbstractRoute",
            "{conference}/review/programchairrereview/abstract/{abstractid}/code/{code}",
           "~/Review/ProgramChairReReview.aspx")

        routes.MapPageRoute("AbstractsSteeringCommReviewRoute",
            "{conference}/review/steeringcomm",
           "~/Review/SteeringComm.aspx")

        routes.MapPageRoute("AbstractsSteeringCommReviewAbstractRoute",
            "{conference}/review/steeringcomm/abstract/{abstractid}/{theme}/code/{code}",
           "~/Review/SteeringCommReview.aspx")

        routes.MapPageRoute("AbstractsSessionChairReviewRoute",
            "{conference}/review/sessionchair",
           "~/Review/SessionChair.aspx")

        routes.MapPageRoute("AbstractsSessionChairReviewAbstractRoute",
            "{conference}/review/sessionchair/abstract/{abstractid}/{topic}/code/{code}",
           "~/Review/SessionChairReview.aspx")

        routes.MapPageRoute("AbstractsReviewViewRoute",
            "{conference}/review/abstract/{abstractid}/code/{code}",
           "~/Review/AbstractView.aspx")

        routes.MapPageRoute("AbstractsReviewSessionChairFinalViewRoute",
            "{conference}/review/abstract/{abstractid}/code/{code}/{sessionChair}",
           "~/Review/AbstractView.aspx")

        routes.MapPageRoute("AbstractsReviewFinalViewRoute",
            "{conference}/review/abstract/{abstractid}/code/{code}/{sessionChair}",
           "~/Review/AbstractView.aspx")

        routes.MapPageRoute("AbstractsAdminReviewRoute",
   "{conference}/review/adminlist",
  "~/Review/AdminList.aspx")

        routes.MapPageRoute("AbstractsAdminReviewFinalRoute",
           "{conference}/review/abstract/{abstractid}/code/{code}/admin/{admin}",
           "~/Review/AbstractAdminView.aspx")

        routes.MapPageRoute("AbstractsOverallStandingsRoute",
            "{conference}/review/OverallStandings",
            "~/Review/OverallStandings.aspx")

        'Payment

        routes.MapPageRoute("PaymentRoute",
            "{conference}/payment",
           "~/Payment/Payment.aspx")

        routes.MapPageRoute("PaymentConfirmRoute",
            "{conference}/payment/confirm",
           "~/Payment/PaymentConfirm.aspx")

        routes.MapPageRoute("PaymentResultRoute",
            "{conference}/payment/result",
           "~/Payment/PaymentResult.aspx")

        routes.MapPageRoute("PaymentTestRoute",
            "{conference}/payment/test",
           "~/Payment/PaymentTest.aspx")

        'Exhibitor routes

        routes.MapPageRoute("ExhibitDefaultRoute",
           "{conference}/exhibit/{type}",
          "~/Exhibitor/ExhibitHome.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "exhibitor"}))

        routes.MapPageRoute("SponsorHomeRoute",
           "{conference}/exhibit/{type}/home",
          "~/Exhibitor/ExhibitHome.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "sponsor"}))



        routes.MapPageRoute("ExhbitBoothSelectionRoute",
            "{conference}/exhibit/{type}/booth",
           "~/Exhibitor/ExhibitBooth.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "exhibitor"}))

        routes.MapPageRoute("SponsorBoothSelectionRoute",
            "{conference}/exhibit/sponsor/booth/{type}",
           "~/Exhibitor/ExhibitBooth.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "sponsor"}))



        'routes.MapPageRoute("ExhbitBoothStaffRoute",
        '  "{conference}/exhibit/booth/staff",
        ' "~/Exhibitor/ExhibitStaff.aspx")

        routes.MapPageRoute("ExhbitBoothStaffRoute",
            "{conference}/exhibit/booth/staff/{type}",
           "~/Exhibitor/ExhibitStaff.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "exhibitor"}))


        routes.MapPageRoute("SponsorBoothStaffRoute",
            "{conference}/exhibit/sponsor/booth/staff/{type}",
           "~/Exhibitor/ExhibitStaff.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "sponsor"}))

        routes.MapPageRoute("ExhbitTechRegRoute",
            "{conference}/exhibit/booth/tech",
           "~/Exhibitor/ExhibitTechReg.aspx")

        routes.MapPageRoute("ExhibitLayoutRoute",
            "{conference}/exhibit/{type}/layout",
           "~/Exhibitor/ExhibitLayout.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "exhibitor"}))

        routes.MapPageRoute("ExhibitTermsRoute",
            "{conference}/exhibit/{type}/terms/",
           "~/Exhibitor/ExhibitTerms.aspx",
            True,
            New RouteValueDictionary(New With
            {.type = "exhibitor"}))


        'routes.MapPageRoute("ExhibitBalanceRoute",
        '"{conference}/exhibit/balance",
        '"~/Exhibitor/ExhibitBalance.aspx")

        routes.MapPageRoute("ExhibitBalanceRoute",
           "{conference}/exhibit/exhibitor/balance/{type}",
          "~/Exhibitor/ExhibitBalance.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "exhibitor"}))


        routes.MapPageRoute("SponsorBalanceRoute",
           "{conference}/exhibit/sponsor/balance/{type}",
          "~/Exhibitor/ExhibitBalance.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "sponsor"}))
        'end

        routes.MapPageRoute("SponsorRegistrationRoute",
            "{conference}/exhibit/{type}/register",
           "~/Exhibitor/SponsorRegistration.aspx",
            True,
            New RouteValueDictionary(New With
            {.type = "sponsor"}))

        routes.MapPageRoute("SponsorRegistrationTermsRoute",
            "{conference}/exhibit/{type}/registration/terms/",
           "~/Exhibitor/SponsorRegistrationTerms.aspx",
            True,
            New RouteValueDictionary(New With
            {.type = "sponsor"}))

        routes.MapPageRoute("SponsorRegistrationBalanceRoute",
            "{conference}/exhibit/sponsor/registration/balance",
           "~/Exhibitor/SponsorRegistrationBalance.aspx")

        routes.MapPageRoute("SponsorRegistrationConfirmRoute",
            "{conference}/exhibit/sponsor/registration/confirm",
           "~/Exhibitor/SponsorRegistrationConfirmation.aspx")

        routes.MapPageRoute("SponsorRegistrationOpportunitiesRoute",
            "{conference}/exhibit/sponsor/registration/opportunities",
           "~/Exhibitor/SponsorOpportunities.aspx")

        'After booth reservation
        'routes.MapPageRoute("ExhibitConfirmationRoute",
        '"{conference}/exhibit/confirm/{type}",
        '"~/Exhibitor/ExhibitConfirmation.aspx",
        'True,
        'New RouteValueDictionary(New With _
        '{.type = "exhibitor"}))

        routes.MapPageRoute("ExhibitConfirmationRoute",
            "{conference}/exhibit/exhibitor/confirm/{type}",
           "~/Exhibitor/ExhibitConfirmation.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "exhibitor"}))

        routes.MapPageRoute("SponsorConfirmationRoute",
            "{conference}/exhibit/sponsor/confirm/{type}",
           "~/Exhibitor/ExhibitConfirmation.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "sponsor"}))
        'end






        routes.MapPageRoute("ExhibitListRoute",
            "{conference}/exhibit/{type}/list/",
           "~/Exhibitor/ExhibitorList.aspx",
            True,
            New RouteValueDictionary(New With _
            {.type = "exhibitor"}))

        'routes.MapPageRoute("SponsorHomeRoute",
        '    "{conference}/sponsor",
        '   "~/Exhibitor/ExhibitHome.aspx")

        'routes.MapPageRoute("SponsorBoothSelectionRoute",
        '    "{conference}/sponsor/booth/",
        '   "~/Exhibitor/Sponsor.aspx")

        routes.MapPageRoute("SponsorTermsRoute",
            "{conference}/sponsor/terms/",
           "~/Exhibitor/SponsorTerms.aspx")

        routes.MapPageRoute("SponsorLayoutRoute",
            "{conference}/sponsor/layout/",
           "~/Exhibitor/SponsorLayout.aspx")

        routes.MapPageRoute("SponsorListRoute",
           "{conference}/sponsor/list/",
          "~/Exhibitor/ExhibitorList.aspx")

        'Learning Lab


        routes.MapPageRoute("LearningLabProposalRoute",
            "{conference}/learninglab/{type}",
           "~/Exhibitor/LearningLabProposal.aspx",
            True,
            New RouteValueDictionary(New With
            {.type = "exhibitor"}))

        'Registration
        routes.MapPageRoute("RegistrationRoute",
           "{conference}/register",
          "~/Registration/RegForm.aspx")

        routes.MapPageRoute("RegistrationClosedRoute",
           "{conference}/registrationclosed",
          "~/Registration/RegClosed.aspx")

        routes.MapPageRoute("RegistrationPrivacyRoute2",
           "{conference}/register/privacy",
          "~/Registration/Privacy.aspx")

        routes.MapPageRoute("RegistrationOtherRoute",
           "{conference}/register/{regtype}",
          "~/Registration/RegForm.aspx")


        routes.MapPageRoute("RegistrationConfirmationRoute",
           "{conference}/regconfirm",
          "~/Registration/RegConfirm.aspx")

        routes.MapPageRoute("RegistrationPrivacyRoute",
           "{conference}/privacy",
          "~/Registration/Privacy.aspx")

        routes.MapPageRoute("RegistrationParticipantRoute",
           "{conference}/participant",
          "~/Registration/Participant.aspx")

        routes.MapPageRoute("RegistrationBalanceRoute",
           "{conference}/balance",
          "~/Registration/Balance.aspx")

        routes.MapPageRoute("RegistrationBalanceConfirmRoute",
           "{conference}/balance/confirm",
          "~/Registration/BalanceConfirm.aspx")

        'Short courses

        routes.MapPageRoute("RegistrationShortCourseRoute",
           "{conference}/shortcourse",
          "~/Registration/ShortCourse.aspx")

        routes.MapPageRoute("RegistrationShortCourseBalanceRoute",
           "{conference}/shortcourse/balance",
          "~/Registration/ShortCourseBalance.aspx")

        routes.MapPageRoute("RegistrationShortCourseConfirmRoute",
           "{conference}/shortcourse/confirm",
          "~/Registration/ShortCourseConfirm.aspx")

        routes.MapPageRoute("RegistrationShortCourseComingRoute",
           "{conference}/comingsoon",
          "~/Registration/ComingSoon.aspx")

        routes.MapPageRoute("ShortCourseProposalRoute",
           "{conference}/shortcourseproposal",
          "~/Registration/ShortCourseProposal.aspx")

        'Admin Pages

        routes.MapPageRoute("ExhibitViewConfirmationRoute",
           "{conference}/exhibit/{type}/adminconfirm/{admin}",
           "~/Exhibitor/ExhibitConfirmation.aspx",
            True,
            New RouteValueDictionary(New With
            {.type = "exhibitor"}))

        routes.MapPageRoute("SponsorRegistrationViewConfirmationRoute",
           "{conference}/exhibit/sponsor/registration/adminconfirm/{admin}",
         "~/Exhibitor/SponsorRegistrationConfirmation.aspx")

        routes.MapPageRoute("RegistrationViewConfirmationRoute",
           "{conference}/regconfirm/adminconfirm/{admin}",
         "~/Registration/RegConfirm.aspx")

        routes.MapPageRoute("PersonLedgerRoute",
           "Admin/Attendee/PersonLedger/{pid}",
         "~/Admin/Attendee/PersonLedger.aspx")

        routes.MapPageRoute("AbstractOverviewRoute",
            "Admin/AbstractOverview",
            "~/Admin/AbstractOverview.aspx")

        routes.MapPageRoute("AbstractOverviewEditorRoute",
            "Admin/AbstractOverviewEditor",
            "~/Admin/AbstractOverviewEditor.aspx")

        routes.MapPageRoute("ShortCourseOverviewRoute",
            "Admin/shortcourse/ShortCourseOverview",
            "~/Admin/ShortCourseOverview.aspx")

        routes.MapPageRoute("ReportPanelistsRoute",
            "Admin/ReportPanelists",
            "~/Admin/ReportPanelists.aspx")

        routes.MapPageRoute("ReportBadgeRoute",
            "Admin/ReportBadge",
            "~/Admin/ReportBadge.aspx")

        routes.MapPageRoute("ReportPersonRolesRoute",
            "Admin/PersonRoleLookup",
            "~/Admin/PersonRoleLookup.aspx")
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
        ' Fires when an error occurs
        Dim url As String = Request.Url.ToString
        Dim ErrorMessage = "The error description Is as follows :<br>" & Server.GetLastError.ToString
        ErrorMessage = ErrorMessage & "<br><br><b>IP Address:</b> <br>" & Request.UserHostAddress

        ErrorMessage = "<b>Error at " & Request.Url.ToString & "</b><br><br>" & ErrorMessage

        ErrorMessage += "<hr>Stack Trace:<br/>" & Server.GetLastError.StackTrace.ToString

        ErrorMessage += "<br/>Browser: " & Request.Browser.Type & ", " & Request.Browser.Version & ", " & Request.Browser.Platform & ", Javascript (supported if >1): " & Request.Browser.EcmaScriptVersion.ToString() & ", Cookies: " & Request.Browser.Cookies

        If Not Request.Browser.Crawler Then
            BattelleError(ErrorMessage)
        End If
    End Sub

    Protected Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        Session("PersonID") = ""
    End Sub



End Class