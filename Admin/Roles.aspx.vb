Imports Battelle.RoleActions
Public Class Roles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnCreate_Click(sender As Object, e As EventArgs) Handles btnCreate.Click
        Dim sRole As String = Trim(Me.txtRole.Text)
        If sRole <> "" Then
            Dim roleActions As New RoleActions()
            roleActions.createRole(sRole)

            Me.gvRoles.DataBind()

        End If

    End Sub
End Class