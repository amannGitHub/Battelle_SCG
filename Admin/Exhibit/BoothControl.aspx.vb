Public Class BoothControl
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ButtonOpen_Click(sender As Object, e As EventArgs) Handles ButtonOpen.Click
        SqlDataSource1.Update()
        GridView1.DataBind()
    End Sub

    Protected Sub ButtonClose_Click(sender As Object, e As EventArgs) Handles ButtonClose.Click
        SqlDataSource1.Delete()
        GridView1.DataBind()
    End Sub
End Class