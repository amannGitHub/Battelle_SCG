Imports System.Web.Routing
Public Class AbstractView
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        Dim bValid As Boolean = False
        'Make sure only athorized view
        If Not Session("ProgramChair") Is Nothing Then
            bValid = True
        End If
        If bValid = False Then
            If Not Session("SteeringCommittee") Is Nothing Then
                bValid = True
            End If
        End If
        If bValid = False Then
            If Not Session("sessionChair") Is Nothing Then
                bValid = True
            End If
        End If


        If bValid = True Then
            SqlDataSourceAbstractSelected.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceOtherReviews.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceSessionChairReviews.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")

            If Not Page.RouteData.Values("sessionChair") Is Nothing Then
                'SqlDataSourceOtherReviews.FilterExpression = "ReviewType = 'Session Chair Review'"
                gvOtherReviews.Visible = False
                gvSessionChairReviews.Visible = True
                SqlDataSourceSessionChairReviews.FilterExpression = "ReviewType = 'Session Chair Review'"
            End If

        Else
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
    End Sub

End Class