Imports Telerik.Web.UI
Imports Telerik.Web.UI.Calendar
Public Class Sessions
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If IsPostBack Then
            gvSessions.DataBind()
        End If
    End Sub


    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        If ddlConfList.SelectedValue <> "" Then
            FormViewSessions.Visible = True
        Else
            FormViewSessions.Visible = False
        End If
    End Sub


    'Protected Sub StartTime_SelectedDateChanged(sender As Object, e As SelectedDateChangedEventArgs)
    '    Dim Start As RadDateTimePicker = DirectCast(FormViewSessions.FindControl("StartTime"), RadDateTimePicker)
    '    SqlDataSourceSessions.InsertParameters("StartTime").DefaultValue = Start.DbSelectedDate

    'End Sub

    'Protected Sub EndTime_SelectedDateChanged(sender As Object, e As SelectedDateChangedEventArgs)
    '    Dim EndT As RadDateTimePicker = DirectCast(FormViewSessions.FindControl("EndTime"), RadDateTimePicker)
    '    SqlDataSourceSessions.InsertParameters("EndTime").DefaultValue = EndT.DbSelectedDate

    'End Sub
End Class