Public Class Participant
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        PanelLogin.Visible = False
        PanelForm.Visible = True
    End Sub

End Class