Public Class ExhibitorList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim ConferenceControl As New ConferenceFromURL
            ConferenceControl = Me.FindControl("ConferenceFromURL")
            SqlDataSourceExhibList.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        End If
    End Sub

End Class