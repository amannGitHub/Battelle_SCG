Public Class SessionHandler
    Inherits System.Web.UI.UserControl
    'Public values here can be late-bound to javascript in the ASPX page.
    Public WarningTimeoutInMilliseconds As Integer
    Public SessionTimeoutInMilliseconds As Integer
    Public TargetURLForSessionTimeout As String
    Public AutomaticRedirect As Boolean

    Public Delegate Sub OnTimeOut()
    Public Event RenewSession As OnTimeOut

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim NumberOfMinutesBeforeSessionTimeoutToWarnUser As Integer = 1
        'Amount of warning to give user (in minutes) -- IF CHANGING THIS VALUE, MAKE APPROPRIATE CHANGES TO JS TIMER IN SessionTimeoutWarning()
        'Get the sessionState timeout (from web.config).
        'If not set there, the default is 20 minutes.
        Dim SessionTimeoutInMinutes As Integer = Session.Timeout

        'SessionTimeoutInMinutes = 1 '*** hardcode for development purposes
        'Compute our timeout values, one for
        'our warning, one for session termination.
        Dim WarningTimeoutInMinutes As Integer = SessionTimeoutInMinutes - NumberOfMinutesBeforeSessionTimeoutToWarnUser

        WarningTimeoutInMilliseconds = WarningTimeoutInMinutes * 60 * 1000

        SessionTimeoutInMilliseconds = SessionTimeoutInMinutes * 60 * 1000

        'WarningTimeoutInMilliseconds = 20000 '*** hardcode for development purposes -- shows up in 5 seconds instead of many minutes

        If Request("__EVENTTARGET") = "btnLogInAgain" Then
            RaiseEvent RenewSession()
        End If

        If Not Me.IsPostBack Then
            'Don't show the warning message div tag until later.
            'Setting the property here so we can see the div at design-time.
            divSessionTimeoutWarning.Style.Add("display", "none;")
            divOverlay.Style.Add("display", "none;")
        End If
    End Sub

    Protected Sub btnContinueWorking_Click(sender As Object, e As EventArgs)
        'Do nothing. But the Session will be refreshed as a result of 
        'this method being called, which is its entire purpose.
    End Sub

    Protected Sub btnLogInAgain_Click(sender As Object, e As EventArgs)
        PanelParticipationControlHandler.Visible = True
    End Sub

End Class