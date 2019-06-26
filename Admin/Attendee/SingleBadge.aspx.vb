Public Class SingleBadge
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim country As Label = FormView1.FindControl("CountryLabel")
        If country.Text.Equals("USA") Then
            country.Text = ""
        End If
    End Sub

End Class