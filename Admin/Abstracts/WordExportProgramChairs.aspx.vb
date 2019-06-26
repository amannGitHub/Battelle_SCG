Imports System.IO
Imports System.Web
Public Class WordExportProgramChairs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        'Loop through GridView
        For Each row As GridViewRow In GridView1.Rows

            Dim sAbstractCode As String = row.Cells(0).Text
            Dim sAbstractTitle As String = row.Cells(1).Text
            Dim sAbstractTitleBlock As String = row.Cells(3).Text
            Dim sAbstractBGBlock As String = row.Cells(4).Text
            Dim sAbstractApproachBlock As String = row.Cells(5).Text
            Dim sAbstractResultsBlock As String = row.Cells(6).Text
            Dim sFinalFormat As String = row.Cells(8).Text
            'Dim sSessionCode As String = row.Cells(9).Text

            'Fields for Program Chair export
            Dim sCorrPresAuthor As String = row.Cells(10).Text
            Dim sPreferredFormat As String = row.Cells(11).Text
            Dim sSubmissionRequestedBy As String = row.Cells(12).Text
            Dim sAuthorComments As String = row.Cells(13).Text
            Dim sApplicableTopics As String = row.Cells(14).Text
            Dim sNewTopicArea As String = row.Cells(15).Text
            Dim sLoginNotes As String = row.Cells(16).Text
            Dim sEmployer As String = row.Cells(17).Text

            If sFinalFormat <> "platform" Then
                sFinalFormat = "pos"
            Else
                sFinalFormat = "plat"
            End If

            'Dim sFileTitle As String = sFinalFormat & "_" & sSessionCode & "_" & sAbstractCode
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
            strBuilder.Append("<html " &
            "xmlns:o='urn:schemas-microsoft-com:office:office' " &
            "xmlns:w='urn:schemas-microsoft-com:office:word'" &
            "xmlns='http://www.w3.org/TR/REC-html40'>" &
            "<head><title>Time</title>")

            'The setting specifies document's view after it is downloaded as Print
            'instead of the default Web Layout
            strBuilder.Append("<!--[if gte mso 9]>" &
                             "<xml>" &
                             "<w:WordDocument>" &
                             "<w:View>Print</w:View>" &
                             "<w:Zoom>100</w:Zoom>" &
                             "<w:DoNotOptimizeForBrowser/>" &
                             "</w:WordDocument>" &
                             "</xml>" &
                             "<![endif]-->")

            'Normal export
            'strBuilder.Append("<style>" &
            '            "<!-- /* Style Definitions */" &
            '            "@page Section1" &
            '            "   {size:8.5in 11.0in; " &
            '            "   margin:1.0in 1.0in 1.0in 1.0in ; " &
            '            "   mso-header-margin:.5in; " &
            '            "   mso-footer-margin:.5in; mso-paper-source:0; font-family: Arial !important; font-size: 11pt !important;}" &
            '            " div.Section1" &
            '            "   {page:Section1;}" &
            '            "-->" &
            '           "</style></head>")

            'Program chair review export
            strBuilder.Append("<style>" &
                        "<!-- /* Style Definitions */" &
                        "@page Section1" &
                        "   {size:8.5in 11.0in; " &
                        "   margin:0.5in 0.5in 0.5in 0.5in ; " &
                        "   mso-header-margin:.5in; " &
                        "   mso-footer-margin:.5in; mso-paper-source:0; font-family: Arial !important; font-size: 8.5pt !important;}" &
                        " div.Section1" &
                        "   {page:Section1;}" &
                        "-->" &
                       "</style></head>")

            strBuilder.Append("<body lang=EN-US style='tab-interval:.5in'><div class=Section1>")

            'Add Program Chair header
            strBuilder.Append("Abstract Code: ")
            strBuilder.Append(sAbstractCode)
            strBuilder.Append("<br />Corresponding/Presenting Author: ")
            strBuilder.Append(sCorrPresAuthor)
            strBuilder.Append("<br />Employer: ")
            strBuilder.Append(sEmployer)
            strBuilder.Append("<br />Preferred Format: ")
            strBuilder.Append(sPreferredFormat)
            strBuilder.Append("<br />Submission Requested By: ")
            strBuilder.Append(sSubmissionRequestedBy)
            strBuilder.Append("<br />Author Comments: ")
            strBuilder.Append(sAuthorComments)
            strBuilder.Append("<br />Applicable Topics: ")
            strBuilder.Append(sApplicableTopics)
            strBuilder.Append("<br />New Topic Area: ")
            strBuilder.Append(sNewTopicArea)
            strBuilder.Append("<br />Login Notes: ")
            strBuilder.Append(sLoginNotes)
            strBuilder.Append("<hr />")

            'Add the Abstract content
            strBuilder.Append(sAbstractTitle)
            strBuilder.Append("<br /><br />")
            strBuilder.Append(sAbstractTitleBlock)
            strBuilder.Append("<br /><br />")
            strBuilder.Append(sAbstractBGBlock)
            strBuilder.Append("<br /><br />")
            strBuilder.Append(sAbstractApproachBlock)
            strBuilder.Append("<br /><br />")
            strBuilder.Append(sAbstractResultsBlock)

            strBuilder.Append("</div></body></html>")

            Dim strPath As String =
            Request.PhysicalApplicationPath & "admin\abstracts\export\" & sAbstractCode & ".doc"

            'string strTextToWrite = TextBox1.Text;
            Dim fStream As FileStream = File.Create(strPath)
            fStream.Close()
            Dim sWriter As New StreamWriter(strPath)
            sWriter.Write(strBuilder)

            sWriter.Close()
        Next
    End Sub
End Class