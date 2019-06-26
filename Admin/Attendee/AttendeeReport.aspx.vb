Imports System.Text
Public Class AttendeeReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click

        Dim sTitle As String = "AttendeeReport" & Now().ToShortDateString()
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
        For iCt = 0 To Me.gvAttendeeList.HeaderRow.Cells.Count - 1
            'Save initial text if found
            sHeader = Me.gvAttendeeList.HeaderRow.Cells(iCt).Text

            'Check for controls in header
            If Me.gvAttendeeList.HeaderRow.Cells(iCt).HasControls = True Then
                'Check for link button
                If Me.gvAttendeeList.HeaderRow.Cells(iCt).Controls(0).GetType.ToString = "System.Web.UI.WebControls.DataControlLinkButton" Then
                    'link button found, get text
                    sHeader = DirectCast(gvAttendeeList.HeaderRow.Cells(iCt).Controls(0), LinkButton).Text
                End If

                'Remove controls from header
                Me.gvAttendeeList.HeaderRow.Cells(iCt).Controls.Clear()

            End If
            'Reassign header text
            Me.gvAttendeeList.HeaderRow.Cells(iCt).Text = sHeader
        Next

        ' Set the type and filename  
        Response.AddHeader("content-disposition", "attachment;filename=" & sTitle & ".xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"

        '
        '
        '               @@@@@@@@@@@@  ----------- IF THE FILE IS CORRUPT ON OPEN: ------------  @@@@@@@@@@@@
        '
        '               1. import the "corrupt" .xls file into Google Sheets (as a Google Sheets file)
        '               2. take the raw markup you get from doing that and save it as an .html file
        '               3. open that .html file in excel (it should open fine)
        '               4. save that .html file as an .xls. This new .xls should open fine. Fuck Excel.
        '
        '
        '                           -CB
        '
        '               P.S. If you need to find a non-ASCII character, CTRL+F the html file with this regex: [^\x00-\x7F]+
        '                           that will find any non-ASCII for you
        '
        '


        'Special Character fix
        Response.ContentEncoding = Encoding.Unicode
        Response.BinaryWrite(Encoding.Unicode.GetPreamble())

        'This not working...
        ' Add the HTML from the GridView to a StringWriter so we can write it out later  
        Dim sw As System.IO.StringWriter = New System.IO.StringWriter
        Dim hw As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(sw)
        gvAttendeeList.RenderControl(hw)

        ' Write out the data  
        Response.Write(sw.ToString)
        Response.End()

        'Dim writer As New System.IO.StringWriter()

        'Dim html As New System.Web.UI.HtmlTextWriter(writer)
        'gvAttendeeList.RenderControl(html)

        'Response.Write(writer)

        'Response.End()


    End Sub

    Protected Sub gvAttendeeList_DataBound(sender As Object, e As EventArgs) Handles gvAttendeeList.DataBound
        If gvAttendeeList.Rows.Count > 0 Then
            btnExport.Visible = True
        Else
            btnExport.Visible = False
        End If

    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'Allows export of control to Word
    End Sub
End Class