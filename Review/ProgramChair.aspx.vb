Public Class ProgramChair
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then

            lblConferenceType.Text = ConferenceControl.ConferenceShortName
            lnkReturn.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review"
            lnkProgramChair2.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/programchair2"

        End If
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            SqlDataSourceToReview.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceToReview.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceToFinalize.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceToFinalize.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceFinalized.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceFinalized.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            'SqlDataSourceReturned.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceDeclined.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceDeclined.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        Else
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
        If Session("ProgramChair") Is Nothing Then
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
    End Sub




End Class