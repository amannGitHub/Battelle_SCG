Public Class AbstractList
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
                PanelAbstractList.Visible = True

                SqlDataSourceAbstracts.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                SqlDataSourceAbstracts.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            Else
                PanelParticipationControl.Visible = True
            End If

        End If
    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        ParticipationIDLogin.Visible = False
        PanelParticipationControl.Visible = False
        SqlDataSourceAbstracts.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        SqlDataSourceAbstracts.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        PanelAbstractList.Visible = True

    End Sub

End Class