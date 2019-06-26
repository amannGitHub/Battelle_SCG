Public Class Conferences
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        Me.dvConference.Visible = True
        dvConference.ChangeMode(DetailsViewMode.Insert)
    End Sub

    Protected Sub gvConferences_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvConferences.SelectedIndexChanged
        dvConference.Visible = True
        dvConference.ChangeMode(DetailsViewMode.ReadOnly)
    End Sub

    Protected Sub dvConference_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs) Handles dvConference.ItemUpdated
        gvConferences.DataBind()
    End Sub

    Protected Sub dvConference_ItemInserted(sender As Object, e As DetailsViewInsertedEventArgs) Handles dvConference.ItemInserted
        gvConferences.DataBind()

    End Sub
End Class