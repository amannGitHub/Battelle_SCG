Imports System.Data.SqlClient
Imports Microsoft.AspNet.Identity
Public Class AbstractOverviewEditor
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnEdit_Click(sender As Object, e As EventArgs)
        Dim b As ImageButton = sender
        Dim conn As New SqlConnection
        Dim arg As String = b.CommandArgument
        Dim delim As Char() = ";"

        conn.ConnectionString = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        conn.Open()

        Dim AbstractID As String = arg.Split(delim)(0)
        Dim ReviewType As String = arg.Split(delim)(1)
        Dim cmd As New SqlCommand("AbstractAdminReviewUnFinalizeUpdate", conn)

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("AbstractID", AbstractID)
        cmd.Parameters.AddWithValue("ReviewType", ReviewType)
        cmd.ExecuteNonQuery()
        gvAbstracts.DataBind()

    End Sub

    Protected Sub btnReview_Click(sender As Object, e As EventArgs)
        Dim b As Button = sender
        Dim conn As New SqlConnection
        Dim arg As String = b.CommandArgument
        Dim delim As Char() = ";"
        Dim gvr As GridViewRow = b.NamingContainer
        Dim ddlReviewType As DropDownList = gvr.FindControl("ddlReviewType")
        Dim ddlTopic As DropDownList = gvr.FindControl("ddlTopic")
        Dim ddlSession As DropDownList = gvr.FindControl("ddlSession")
        Dim ddlFormat As DropDownList = gvr.FindControl("ddlFormat")
        Dim txtComments As TextBox = gvr.FindControl("txtComments")
        Dim chkDecline As CheckBox = gvr.FindControl("chkDecline")

        'Set up parameters
        Dim AbstractID As String = arg.Split(delim)(0)
        Dim PersonID As Integer
        Select Case Context.User.Identity.GetUserName()
            Case "Sarah"
                PersonID = 217
            Case "Gina"
                PersonID = 218
            Case Else
                PersonID = 1
        End Select

        Dim TopicGroupID As String = ddlTopic.SelectedValue
        Dim SessionID As String = ddlSession.SelectedValue
        Dim Format As String = ddlFormat.SelectedValue
        Dim Comments As String = txtComments.Text
        Dim LastAccepted As String = ddlReviewType.SelectedValue '(review type ID)
        Dim Decline As String = chkDecline.Checked.ToString
        Dim ReviewTypeID = ddlReviewType.SelectedValue

        conn.ConnectionString = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        conn.Open()

        Dim cmd As New SqlCommand("AbstractOverviewUpdate", conn)

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("AbstractID", AbstractID)
        cmd.Parameters.AddWithValue("PersonID", PersonID)
        If TopicGroupID = "" Then
            cmd.Parameters.AddWithValue("TopicGroupID", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("TopicGroupID", TopicGroupID)
        End If
        If SessionID = "" Then
            cmd.Parameters.AddWithValue("SessionID", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("SessionID", SessionID)
        End If
        If Format = "" Then
            cmd.Parameters.AddWithValue("Format", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("Format", Format)
        End If
        cmd.Parameters.AddWithValue("Comments", Comments)
        cmd.Parameters.AddWithValue("LastAccepted", LastAccepted)
        cmd.Parameters.AddWithValue("Decline", Decline)
        cmd.ExecuteNonQuery()
        gvAbstracts.DataBind()


        'Dim type As String = ""

        'If ddl.SelectedValue = 1 Then
        '    type = "programchair"
        '    If arg.Split(delim)(3) = "5" Then
        '        Response.Redirect("~/bio2017/review/" & type & "/abstract/" & arg.Split(delim)(0) & "/code/" & arg.Split(delim)(1))
        '    ElseIf arg.Split(delim)(3) = "4" Then
        '        Response.Redirect("~/sediments2017/review/" & type & "/abstract/" & arg.Split(delim)(0) & "/code/" & arg.Split(delim)(1))       'TODO: Remove conference hardcode
        '    End If
        'ElseIf ddl.SelectedValue = 2
        '    type = "steeringcommittee"
        '    If arg.Split(delim)(3) = "5" Then
        '        Response.Redirect("~/bio2017/review/" & type & "/abstract/" & arg.Split(delim)(0) & "/code/" & arg.Split(delim)(1))
        '    ElseIf arg.Split(delim)(3) = "4" Then
        '        Response.Redirect("~/sediments2017/review/" & type & "/abstract/" & arg.Split(delim)(0) & "/code/" & arg.Split(delim)(1))       'TODO: Remove conference hardcode
        '    End If
        'ElseIf ddl.SelectedValue = 3
        '    type = "sessionchair"
        '    If arg.Split(delim)(3) = "5" Then
        '        Response.Redirect("~/bio2017/review/" & type & "/abstract/" & arg.Split(delim)(0) & "/" & arg.Split(delim)(2) & "/code/" & arg.Split(delim)(1))
        '    ElseIf arg.Split(delim)(3) = "4" Then
        '        Response.Redirect("~/sediments2017/review/" & type & "/abstract/" & arg.Split(delim)(0) & "/" & arg.Split(delim)(2) & "/code/" & arg.Split(delim)(1))       'TODO: Remove conference hardcode
        '    End If
        'End If




    End Sub

    Protected Sub gvAbstracts_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim thisRow As GridViewRow = e.Row
            Dim lastActive As String = CType(thisRow.Cells(6).FindControl("hdnActiveTypeID"), HiddenField).Value
            Dim lastAccepted As String = CType(thisRow.Cells(6).FindControl("hdnAcceptedTypeID"), HiddenField).Value
            Dim ReviewID As String = CType(thisRow.Cells(6).FindControl("hdnAbstractReviewID"), HiddenField).Value
            Dim AbstractID As String = CType(thisRow.Cells(6).FindControl("hdnAbstractID"), HiddenField).Value
            Dim AbstractCode As String = CType(thisRow.Cells(7).FindControl("hdnAbstractCode"), HiddenField).Value
            Dim CurrentSessionID As String = CType(thisRow.Cells(7).FindControl("hdnSessionID"), HiddenField).Value
            Dim ConferenceID As String = CType(thisRow.Cells(7).FindControl("hdnConferenceID"), HiddenField).Value
            Dim editButton As ImageButton = thisRow.Cells(6).FindControl("btnEdit")
            Dim reviewButton As Button = thisRow.Cells(7).FindControl("btnReview")

            If lastAccepted = "" Then
                editButton.Visible = False
            End If

            Dim ddlSession As DropDownList = thisRow.Cells(7).FindControl("ddlSession")
            Dim ddlFormat As DropDownList = thisRow.Cells(7).FindControl("ddlFormat")
            Dim chkDecline As CheckBox = thisRow.Cells(7).FindControl("chkDecline")
            ddlSession.Visible = False
            ddlFormat.Visible = False
            chkDecline.Visible = False

            editButton.CommandArgument = AbstractID & ";" & lastAccepted
            reviewButton.CommandArgument = AbstractID & ";" & AbstractCode & ";" & CurrentSessionID & ";" & ConferenceID

        End If
    End Sub

    Protected Sub ddlTopic_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlTopic As DropDownList = DirectCast(sender, DropDownList)
        Dim row As GridViewRow = DirectCast(ddlTopic.NamingContainer, GridViewRow)

        Dim ddlSession As DropDownList = DirectCast(row.FindControl("ddlSession"), DropDownList)


        'Dim chkDecline As CheckBox = gvAbstracts.FindControl("DeclineCheckBox")

        If ddlTopic.SelectedIndex <> 0 Then
            ddlSession.Enabled = True
            'chkDecline.Checked = False
            'Clear existing items
            ddlSession.Items.Clear()
            'Add new blank and rebind
            Dim liSelectOne As New ListItem("")
            ddlSession.Items.Insert(0, liSelectOne)
            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ddlConfList.SelectedValue
            ddlSession.DataBind()
        Else
            ddlSession.Enabled = False
        End If
    End Sub

    Protected Sub ddlReviewType_SelectedIndexChanged(sender As Object, e As EventArgs)
        'System.Threading.Thread.Sleep(2000)
        Dim ddl As DropDownList = DirectCast(sender, DropDownList)
        Dim row As GridViewRow = DirectCast(ddl.NamingContainer, GridViewRow)
        Dim ddlSession As DropDownList = DirectCast(row.FindControl("ddlSession"), DropDownList)
        Dim ddlFormat As DropDownList = DirectCast(row.FindControl("ddlFormat"), DropDownList)
        Dim chkDecline As CheckBox = DirectCast(row.FindControl("chkDecline"), CheckBox)

        If ddl.SelectedIndex <> 0 Then
            ddlSession.Visible = True
        ElseIf ddl.SelectedIndex = 0 Then
            ddlSession.Visible = False
        End If

        If ddl.SelectedIndex = 3 Then 'Finalize for conference
            chkDecline.Visible = True
            ddlFormat.Visible = True
        ElseIf ddl.SelectedIndex = 2 Then 'Session chair
            chkDecline.Visible = False
            ddlFormat.Visible = True
        Else
            chkDecline.Visible = False
            ddlFormat.Visible = False
        End If
    End Sub
End Class