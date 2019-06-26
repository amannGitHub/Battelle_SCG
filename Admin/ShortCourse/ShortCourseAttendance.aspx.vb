Public Class ShortCourseAttendance
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'Allows export of control to Word
    End Sub

    Protected Sub gvShortCourse_DataBound(sender As Object, e As EventArgs) Handles gvShortCourse.DataBound
        If gvShortCourse.Rows.Count > 0 Then
            btnExport.Visible = True
        Else
            btnExport.Visible = False
        End If

    End Sub

    Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click

        Dim sTitle As String = "ShortCourseReg" & Now().ToShortDateString()
        sTitle = sTitle.Replace("/", "")

        'Dim lblTitle As Label = DirectCast(FormView1.Row.Cells(0).FindControl("lblTitle"), Label)

        'If lblTitle.Text <> "" Then
        'sTitle = lblTitle.Text
        'End If

        ' Clear the response  
        Response.Clear()

        Dim iCt As Integer
        Dim sHeader As String

        'Remove header links
        For iCt = 0 To Me.gvShortCourse.HeaderRow.Cells.Count - 1
            'Save initial text if found
            sHeader = Me.gvShortCourse.HeaderRow.Cells(iCt).Text

            'Check for controls in header
            If Me.gvShortCourse.HeaderRow.Cells(iCt).HasControls = True Then
                'Check for link button
                If Me.gvShortCourse.HeaderRow.Cells(iCt).Controls(0).GetType.ToString = "System.Web.UI.WebControls.DataControlLinkButton" Then
                    'link button found, get text
                    sHeader = DirectCast(gvShortCourse.HeaderRow.Cells(iCt).Controls(0), LinkButton).Text
                End If

                'Remove controls from header
                Me.gvShortCourse.HeaderRow.Cells(iCt).Controls.Clear()

            End If
            'Reassign header text
            Me.gvShortCourse.HeaderRow.Cells(iCt).Text = sHeader
        Next

        ' Set the type and filename  
        Response.AddHeader("content-disposition", "attachment;filename=" & sTitle & ".xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"

        'Special Character fix
        Response.ContentEncoding = Encoding.Unicode
        Response.BinaryWrite(Encoding.Unicode.GetPreamble())

        'This not working - add EnableEventValidation="false" to <%@ Page %>
        ' Add the HTML from the GridView to a StringWriter so we can write it out later  
        Dim sw As System.IO.StringWriter = New System.IO.StringWriter
        Dim hw As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(sw)
        gvShortCourse.RenderControl(hw)

        ' Write out the data  
        Response.Write(sw.ToString)
        Response.End()




    End Sub
End Class