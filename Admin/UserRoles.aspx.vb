Imports Battelle.RoleActions
Public Class UserRoles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnAddRole_Click(sender As Object, e As EventArgs) Handles btnAddRole.Click
        Dim roleActions As New RoleActions()

        Dim sUserID As String = Request.QueryString("userid")
        Dim sRole As String = Me.ddlRoles.SelectedValue

        roleActions.addUsertoRole(sUserID, sRole)

        Me.gvUserRoles.DataBind()
    End Sub
End Class