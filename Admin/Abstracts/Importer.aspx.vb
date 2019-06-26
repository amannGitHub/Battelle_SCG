Public Class Importer
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnImporter_Click(sender As Object, e As EventArgs) Handles btnImporter.Click
        For i As Integer = txtLow.Text To txtHigh.Text
            SqlDataSource1.InsertParameters("ImportID").DefaultValue = i

            SqlDataSource1.Insert()
            lblResult.Text = i & " imported<br>"
        Next
    End Sub
End Class