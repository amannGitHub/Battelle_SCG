Imports System.IO
Imports System.Web
Public Class WordExport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then
            If ddlConfList.SelectedIndex <> 0 Then
                btnExport.Visible = True
            Else
                btnExport.Visible = False
            End If
        End If

    End Sub

    Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        'Loop through GridView
        For Each row As GridViewRow In GridView1.Rows

            Dim sAbstractCode As String = row.Cells(0).Text
            Dim sAbstractTitle As String = row.Cells(1).Text
            'tmp
            'Dim CorrPres As String = row.Cells(3).Text & "<br/>"
            'Dim Employer As String = row.Cells(4).Text & "<br/>"
            Dim Preferred As String = row.Cells(3).Text & "<br/>"
            Dim SubmissionReq As String = row.Cells(4).Text & "<br/>"
            Dim AuthorComments As String = row.Cells(5).Text & "<br/>"
            Dim Applicable As String = row.Cells(6).Text & "<br/>"
            Dim NewTopicArea As String = row.Cells(7).Text & "<br/>"

            Dim sAbstractTitleBlock As String = row.Cells(8).Text
            Dim sAbstractBGBlock As String = row.Cells(9).Text
            Dim sAbstractApproachBlock As String = row.Cells(10).Text
            Dim sAbstractResultsBlock As String = row.Cells(11).Text
            Dim sFinalFormat As String = row.Cells(12).Text
            Dim sSessionCode As String = row.Cells(13).Text

            'Fields for Program Chair export
            'Dim sCorrPresAuthor As String = row.Cells(10).Text
            'Dim sPreferredFormat As String = row.Cells(11).Text
            'Dim sSubmissionRequestedBy As String = row.Cells(12).Text
            'Dim sAuthorComments As String = row.Cells(13).Text
            'Dim sApplicableTopics As String = row.Cells(14).Text
            'Dim sNewTopicArea As String = row.Cells(15).Text
            'Dim sLoginNotes As String = row.Cells(16).Text
            'Dim sEmployer As String = row.Cells(17).Text

            sFinalFormat = sFinalFormat.Replace(" ", "")
            'If sFinalFormat = "poster" Then
            '    sFinalFormat = "pos"
            'Else
            '    sFinalFormat = "plat"
            'End If

            'Dim sFileTitle As String = sAbstractCode & "_" & sSessionCode & "_" & sFinalFormat
            Dim sFileTitle As String = sAbstractCode

            sAbstractTitle = Server.HtmlDecode(sAbstractTitle)
            sAbstractTitleBlock = Server.HtmlDecode(sAbstractTitleBlock)
            sAbstractBGBlock = Server.HtmlDecode(sAbstractBGBlock)
            sAbstractApproachBlock = Server.HtmlDecode(sAbstractApproachBlock)
            sAbstractResultsBlock = Server.HtmlDecode(sAbstractResultsBlock)

            'Save row as file
            Dim strBuilder As New StringBuilder()

            'build the content for the dynamic Word document
            'in HTML alongwith some Office specific style properties.
            strBuilder.Append("<html " & _
            "xmlns:o='urn:schemas-microsoft-com:office:office' " & _
            "xmlns:w='urn:schemas-microsoft-com:office:word'" & _
            "xmlns='http://www.w3.org/TR/REC-html40'>" & _
            "<head><title>Time</title>")

            'The setting specifies document's view after it is downloaded as Print
            'instead of the default Web Layout
            strBuilder.Append("<!--[if gte mso 9]>" & _
                             "<xml>" & _
                             "<w:WordDocument>" & _
                             "<w:View>Print</w:View>" & _
                             "<w:Zoom>100</w:Zoom>" & _
                             "<w:DoNotOptimizeForBrowser/>" & _
                             "</w:WordDocument>" & _
                             "</xml>" & _
                             "<![endif]-->")


            strBuilder.Append("<style>" &
                        "<!-- /* Style Definitions */" &
                        "@page Section1" &
                        "   {size:8.5in 11.0in; " &
                        "   margin:1.0in 1.0in 1.0in 1.0in ; " &
                        "   mso-header-margin:.5in; " &
                        "   mso-footer-margin:.5in; mso-paper-source:0; font-family: Arial !important; font-size: 11pt !important;}" &
                        " div.Section1" &
                        "   {page:Section1;}" &
                        "-->" &
                       "</style></head>")



            strBuilder.Append("<body lang=EN-US style='tab-interval:.5in'><div class=Section1>")

            'Add extra info to the top (1/18/2017 request)
            'strBuilder.Append("Abstract Code: " & sAbstractCode & "<br/>" & "Corresponding/Presenting Author: " & CorrPres & "Employer: " & Employer & "Preferred Format: " & Preferred & "Submission Requested By: " & SubmissionReq & "Author Comments: " & AuthorComments & "Applicable Topics: " & Applicable)

            'Add extra info to the top (7/16/2018 request)
            strBuilder.Append("Abstract Code: " & sAbstractCode & "<br/>" & "Preferred Format: " & Preferred & "Submission Requested By: " & SubmissionReq & "Author Comments: " & AuthorComments & "Applicable Topics: " & Applicable & "New Topic Area: " & NewTopicArea)


            'Add the Abstract content
            'strBuilder.Append("Abstract code: <b>")
            'strBuilder.Append(sAbstractCode)
            'strBuilder.Append("</b><br /><br />")
            'strBuilder.Append(sAbstractTitle)
            'strBuilder.Append("<br /><br />")
            strBuilder.Append(sAbstractTitleBlock)
            strBuilder.Append("<br /><br />")
            strBuilder.Append(sAbstractBGBlock)
            strBuilder.Append("<br /><br />")
            strBuilder.Append(sAbstractApproachBlock)
            strBuilder.Append("<br /><br />")
            strBuilder.Append(sAbstractResultsBlock)

            strBuilder.Append("</div></body></html>")

            Dim strPath As String =
            Request.PhysicalApplicationPath & "admin\abstracts\export\" & sFileTitle & ".doc"

            'string strTextToWrite = TextBox1.Text;
            Dim fStream As FileStream = File.Create(strPath)
            fStream.Close()
            Dim sWriter As New StreamWriter(strPath)
            sWriter.Write(strBuilder)

            sWriter.Close()
        Next
    End Sub
End Class