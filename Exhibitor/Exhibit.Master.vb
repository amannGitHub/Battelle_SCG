Public Class Exhibit
    Inherits System.Web.UI.MasterPage


    Private Const AntiXsrfTokenKey As String = "__AntiXsrfToken"
    Private Const AntiXsrfUserNameKey As String = "__AntiXsrfUserName"
    Private _antiXsrfTokenValue As String



    Protected Sub Page_Init(sender As Object, e As EventArgs)
        ' The code below helps to protect against XSRF attacks
        Dim requestCookie = Request.Cookies(AntiXsrfTokenKey)
        Dim requestCookieGuidValue As Guid
        If requestCookie IsNot Nothing AndAlso Guid.TryParse(requestCookie.Value, requestCookieGuidValue) Then
            ' Use the Anti-XSRF token from the cookie
            _antiXsrfTokenValue = requestCookie.Value
            Page.ViewStateUserKey = _antiXsrfTokenValue
        Else
            ' Generate a new Anti-XSRF token and save to the cookie
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N")
            Page.ViewStateUserKey = _antiXsrfTokenValue

            Dim responseCookie = New HttpCookie(AntiXsrfTokenKey) With {
                 .HttpOnly = True,
                 .Value = _antiXsrfTokenValue
            }
            If FormsAuthentication.RequireSSL AndAlso Request.IsSecureConnection Then
                responseCookie.Secure = True
            End If
            Response.Cookies.[Set](responseCookie)
        End If

        AddHandler Page.PreLoad, AddressOf master_Page_PreLoad
    End Sub

    Protected Sub master_Page_PreLoad(sender As Object, e As EventArgs)
        If Not IsPostBack Then
            ' Set Anti-XSRF token
            ViewState(AntiXsrfTokenKey) = Page.ViewStateUserKey
            ViewState(AntiXsrfUserNameKey) = If(Context.User.Identity.Name, [String].Empty)
        Else
            ' Validate the Anti-XSRF token
            If DirectCast(ViewState(AntiXsrfTokenKey), String) <> _antiXsrfTokenValue OrElse DirectCast(ViewState(AntiXsrfUserNameKey), String) <> (If(Context.User.Identity.Name, [String].Empty)) Then
                Throw New InvalidOperationException("Validation of Anti-XSRF token failed.")
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sExhibOrSponsor As String = Page.RouteData.Values("type").ToString



        lnkHome.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/exhibit/" & sExhibOrSponsor
        lnkTerms.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/exhibit/" & sExhibOrSponsor & "/terms"
        If ConferenceFromURL.ExhibitPageOpen = True Then
            lnkReturn.Visible = True
            lnkReturn.NavigateUrl = ConferenceFromURL.ConferenceReturnURL
            lnkReturn.Target = "_blank"

            lnkSponsorOpp.Visible = True
            lnkSponsorOpp.NavigateUrl = ConferenceFromURL.SponsorOpportunityURL
            lnkSponsorOpp.Target = "_blank"

            lnkLayout.Visible = True
            lnkLayout.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/exhibit/" & sExhibOrSponsor & "/layout"


            lnkBoothRes.Visible = True
            lnkBoothStaff.Visible = True
            lnkTechReg.Visible = True

            If Left(sExhibOrSponsor, 4) = "spon" Then
                lnkBoothStaff.Visible = False
                lnkTechReg.Visible = False

                If Now >= ConferenceFromURL.SponsorOpenDate Then
                    lnkBoothRes.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/exhibit/" & sExhibOrSponsor & "/booth"
                    lnkBoothStaff.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/exhibit/booth/staff/" & sExhibOrSponsor
                    lnkTechReg.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/register/techreg"
                Else
                    lnkBoothRes.Visible = False
                    lnkBoothStaff.Visible = False
                    lnkTechReg.Visible = False
                End If
            Else
                If Now >= ConferenceFromURL.ExhibitOpenDate Then
                    lnkBoothRes.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/exhibit/" & sExhibOrSponsor & "/booth"
                    lnkBoothStaff.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/exhibit/booth/staff/" & sExhibOrSponsor
                    lnkTechReg.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/register/techreg"
                Else
                    lnkBoothRes.Visible = False
                    lnkBoothStaff.Visible = False
                    lnkTechReg.Visible = False
                End If
            End If
            lnkTechReg.Target = "_blank"
        Else
            lnkReturn.Visible = False
            lnkSponsorOpp.Visible = False
            lnkLayout.Visible = False
            lnkBoothRes.Visible = False
            lnkBoothStaff.Visible = False
            lnkTechReg.Visible = False
        End If

    End Sub

    Protected Sub Unnamed_LoggingOut(sender As Object, e As LoginCancelEventArgs)
        Context.GetOwinContext().Authentication.SignOut()
    End Sub

    Protected Sub ConferenceFromURL_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles ConferenceFromURL.Load
        Dim hdnConfShortName As HiddenField = TryCast(ConferenceFromURL.FindControl("hdnConfShortName"), HiddenField)

        lblConferenceName.Text = hdnConfShortName.Value
    End Sub

End Class