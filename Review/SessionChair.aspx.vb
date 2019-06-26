Imports System.Web.Routing
Public Class SessionChair
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then

            lblConferenceType.Text = ConferenceControl.ConferenceShortName
            lnkReturn.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review"

        End If
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            SqlDataSourceToReview.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceToReview.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceReviewed.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceReviewed.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            'SqlDataSourceReviewed.SelectParameters("SessionID").DefaultValue = Page.RouteData.Values("topic")
            SqlDataSourceFinalized.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceFinalized.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceDeclined.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceDeclined.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        Else
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
        If Session("SessionChair") Is Nothing Then
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
    End Sub

    Protected Sub SqlDataSourceReviewed_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceReviewed.Selecting
        Dim IsThisThingOn As Boolean = False
        If IsThisThingOn = False Then
            IsThisThingOn = True
        End If
    End Sub
End Class