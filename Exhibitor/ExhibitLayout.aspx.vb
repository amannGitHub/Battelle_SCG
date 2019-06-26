Imports System.Web.Routing
Public Class ExhibitLayout
    Inherits System.Web.UI.Page

    Dim sExhibOrSponsor As String = Page.RouteData.Values("type").ToString

    Public Property ExhibitorOrSponsor() As String
        Get
            If (ViewState("ExhibitorOrSponsor") IsNot Nothing) Then
                Return CType(ViewState("ExhibitorOrSponsor"), String)
            Else
                Return "Exhibitor"
            End If
        End Get
        Set(value As String)
            ViewState("ExhibitorOrSponsor") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim PanelForm As New Panel
        PanelForm = CType(BoothLayout.FindControl("PanelForm"), Panel)
        If Not PanelForm Is Nothing Then
            PanelForm.Visible = False
        End If

        'Check for Exhibit or Sponsor based on URL - to show correct values
        Dim sExhibOrSponsor As String = Page.RouteData.Values("type")

        Dim hdnRegType As New HiddenField
        hdnRegType = CType(BoothLayout.FindControl("hdnRegType"), HiddenField)

        If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
            sExhibOrSponsor = "sponsor"
            ExhibitorOrSponsor = "Sponsor"
            hdnRegType.Value = "sponsor"
        Else
            hdnRegType.Value = "exhibit"
        End If
    End Sub


End Class