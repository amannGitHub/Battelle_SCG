Public Class Review
    Inherits System.Web.UI.MasterPage
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'lnkReview.NavigateUrl = ("~/" & ConferenceControl.ConferenceURLString & "/review")
    End Sub

End Class