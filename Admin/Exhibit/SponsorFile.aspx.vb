Imports System.IO

Public Class SponsorFile
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dv As DataView
        Dim iRows As Integer
        Dim sFileName As String

        dv = CType(SqlDataSource1.Select(DataSourceSelectArguments.Empty), DataView)
        iRows = CType(dv.Table.Rows.Count, Integer)



        If iRows > 0 Then ' there is a file
            'Using fs As FileStream = dv.Table.Rows(0).Item("UploadedFile")
            Dim length As Integer = (CInt(dv.Table.Rows(0).Item("FileSize").ToString())) - 1




            Response.Clear()
            sFileName = Replace(dv.Table.Rows(0).Item("FileName"), " ", "_")
            sFileName = Replace(sFileName, "'", "_")
            sFileName = Replace(sFileName, "&", "_")
            Response.AddHeader("Content-Disposition ", "attachment; filename=" & sFileName)
            Response.AddHeader("Transfer-Encoding", "identity") 'This line added 06-08-2018 to fix Chrome file download Network Failed error
            Response.ContentType = dv.Table.Rows(0).Item("ContentType").ToString()

            Response.BinaryWrite(dv.Table.Rows(0).Item("UploadedFile"))
            Response.Flush()
            Response.Close()
            Response.End() 'Needed for .docx
        Else 'No file
            Me.lblNoFile.Visible = True
        End If
    End Sub


End Class