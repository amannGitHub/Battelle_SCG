Public Class OverallStandings
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        SqlDataSourceProgChair.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        SqlDataSourceSteeringComm.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        SqlDataSourceSessionChair.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        SqlDataSourceSteeringComm.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        SqlDataSourceSessionChair.SelectParameters("PersonID").DefaultValue = Session("PersonID")

        If Session("SessionChair") IsNot Nothing And Session("SteeringCommittee") IsNot Nothing And Session("ProgramChair") IsNot Nothing Then  'Admin
            gvProgChair.Visible = True
        ElseIf Session("SessionChair") IsNot Nothing Then
            gvSessionChair.Visible = True
        ElseIf Session("SteeringCommittee") IsNot Nothing Then
            gvSteeringComm.Visible = True
        ElseIf Session("ProgramChair") IsNot Nothing Then
            gvProgChair.Visible = True
        End If

    End Sub

End Class