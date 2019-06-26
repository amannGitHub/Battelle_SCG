Public Class OrganizationInfo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnExhibitorLoockup_Click(sender As Object, e As EventArgs) Handles btnExhibitorLookup.Click
        Dim dv As DataView = SqlDataSourceExhibitor.Select(DataSourceSelectArguments.Empty)
        For i As Integer = 0 To dv.Count - 1
            If (txtExhibitorLookup.Text.Split(";")(0).Equals(dv(i)("Exhibitor"))) Then
                lblOrgID.Text += " - " + dv(i)("OrganizationID")
                lblPersonID.Text = dv(i)("POCPersonID")
                Exit For
            End If
        Next
        gvPOC.DataBind()
    End Sub

End Class