Public Class RegClosed
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ConferenceControl = Master.FindControl("ConferenceFromURL")

        If Not IsPostBack Then
            Dim sConference As String = ConferenceControl.ConferenceShortName
            lblConference.Text = sConference
            lblConferenceType.Text = ConferenceControl.ConferenceType
        End If


    End Sub

End Class