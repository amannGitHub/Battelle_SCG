Public Class SponsorLayout
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim PanelForm As New Panel
        PanelForm = CType(BoothLayout.FindControl("PanelForm"), Panel)
        If Not PanelForm Is Nothing Then
            PanelForm.Visible = False
        End If
    End Sub

End Class