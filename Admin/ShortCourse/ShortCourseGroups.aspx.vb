Imports System.IO
Imports System.Data.SqlClient

Public Class ShortCourseGroups
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsPostBack Then
            SqlDataSourceShortCourseGroups.DataBind()
        End If
    End Sub

    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        GridViewPanel.Visible = True
        gvShortCourseGroups.Visible = True 'Code reused from Abstract manager, keeping the name for simplicity
        HdnConferenceID.Value = ddlConfList.SelectedValue
        lblConferenceName.Text = ddlConfList.SelectedItem.Text
    End Sub


    Protected Sub ButtonShortCourseGroupAdd_Click(sender As Object, e As EventArgs) Handles ButtonShortCourseGroupAdd.Click
        FormView1.ChangeMode(FormViewMode.Insert)
        ShortCourseGroupsPanel.Visible = True
    End Sub


    Protected Sub gvShortCourseGroups_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvShortCourseGroups.RowUpdating
        gvShortCourseGroups.DataBind()
    End Sub


End Class