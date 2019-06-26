Imports System.Data.SqlClient
Public Class OnSiteBadgeReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub

    Protected Sub gvAttendeeList_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim thisRow As GridViewRow = e.Row
            Dim PersonID As String = CType(thisRow.Cells(7).FindControl("hdnPersonID"), HiddenField).Value
            Dim ConferenceID As String = CType(thisRow.Cells(7).FindControl("hdnConferenceID"), HiddenField).Value
            Dim badgeButton As Button = thisRow.Cells(7).FindControl("btnBadged")

            badgeButton.CommandArgument = PersonID & ";" & ConferenceID
            PersonID = 0
        End If
    End Sub

    Protected Sub gvAttendeeList_DataBound(sender As Object, e As EventArgs)
        btnRefresh.Visible = True

    End Sub

    Protected Sub gvAttendeeBadged_DataBound(sender As Object, e As EventArgs)
        lblBadgeCount.Text = gvAttendeeBadged.Rows.Count
    End Sub

    Protected Sub btnBadged_Click(sender As Object, e As EventArgs)
        Dim b As Button = sender
        Dim conn As New SqlConnection
        Dim arg As String = b.CommandArgument
        Dim delim As Char() = ";"

        conn.ConnectionString = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        conn.Open()

        Dim PersonID As String = arg.Split(delim)(0)
        Dim ConferenceID As String = arg.Split(delim)(1)
        Dim cmd As New SqlCommand("AttendanceOnSiteBadgeIssued", conn)

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("PersonID", PersonID)
        cmd.Parameters.AddWithValue("ConferenceID", ConferenceID)
        cmd.ExecuteNonQuery()
        gvAttendeeList.DataBind()
        gvAttendeeBadged.DataBind()
        lblBadgeCount.Text = gvAttendeeBadged.Rows.Count
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs)
        gvAttendeeList.DataBind()
        gvAttendeeBadged.DataBind()
    End Sub

End Class