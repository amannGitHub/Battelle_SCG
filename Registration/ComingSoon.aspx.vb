Imports System.Globalization
Public Class ComingSoon
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            'Check to see if Short Courses open


            If Now() < ConferenceControl.ShortCourseOpenDate Then 'Hasnt opened yet
                Dim dOpen As Date = ConferenceControl.ShortCourseOpenDate

                lblClosed.Text = "Coming in " & dOpen.ToString("MMMM yyyy", CultureInfo.CurrentCulture)
            End If
            If Now() > ConferenceControl.ShortCourseClosedDate Then 'Closed
                lblClosed.Text = "Short Course Registration is now closed."
            End If
        End If



    End Sub

End Class