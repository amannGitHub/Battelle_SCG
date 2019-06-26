Public Class AdminList
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then

            lblConferenceType.Text = ConferenceControl.ConferenceShortName
            lnkReturn.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review"

        End If
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            SqlDataSourceSessionFinalizedAccepted.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceSessionFinalizedDeclined.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceAdminFinalized.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceSessionNotFinalized.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        Else
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
        If Session("SessionChair") Is Nothing Then
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
    End Sub

End Class