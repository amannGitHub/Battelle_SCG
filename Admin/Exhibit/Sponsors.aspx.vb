Imports System.IO
Imports System.Data.SqlClient
Imports System.Data.Common
Public Class Sponsors
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Page.Form.Enctype = "multipart/form-data"
    End Sub

    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        gvSponsors.Visible = True
    End Sub



    Protected Sub SqlDataSourceSponsor_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceSponsor.Updating
        'If FileUploadLogo.HasFile() = True Then
        '    Dim AbstractFile As IO.Stream = FileUploadLogo.PostedFile.InputStream
        '    Dim FileLength As Integer = FileUploadLogo.PostedFile.ContentLength
        '    Dim FileName As String = FileUploadLogo.FileName 'FileUploadAbstract.PostedFile.FileName
        '    Dim FileExt As String = Path.GetExtension(FileUploadLogo.PostedFile.FileName)
        '    Dim FileContentType As String = FileUploadLogo.PostedFile.ContentType
        '    Dim FileData(FileLength - 1) As Byte
        '    AbstractFile.Read(FileData, 0, FileLength)

        '    Dim UploadAbstractCommand As SqlCommand = New SqlCommand("SponsorFileInsert")
        '    UploadAbstractCommand.Parameters.AddWithValue("ExhibitorID", CompanyInfo.ExhibitorID)
        '    UploadAbstractCommand.Parameters.AddWithValue("ConferenceID", ConferenceControl.ConferenceID)
        '    UploadAbstractCommand.Parameters.AddWithValue("UploadedFile", FileData)
        '    UploadAbstractCommand.Parameters.AddWithValue("FileSize", FileLength)
        '    UploadAbstractCommand.Parameters.AddWithValue("FileName", FileName)
        '    UploadAbstractCommand.Parameters.AddWithValue("ContentType", FileContentType)

        '    BattelleExecuteCommand(UploadAbstractCommand)
        'End If
    End Sub

    Protected Sub gvSponsors_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvSponsors.RowUpdating
        Dim sString As String
        sString = "Test"
        'Dim FileUploadLogo As FileUpload = TryCast(e.FindControl("FileUploadLogo"), FileUpload)
        Dim row As GridViewRow = CType(gvSponsors.Rows(e.RowIndex), GridViewRow)
        Dim FileUploadLogo As FileUpload = CType(row.FindControl("FileUploadLogo"), FileUpload)

        Dim FileName As String = DirectCast(row.FindControl("FileUploadLogo"), FileUpload).FileName
        If FileUploadLogo.HasFile() = True Then
            Dim AbstractFile As IO.Stream = FileUploadLogo.PostedFile.InputStream
            Dim FileLength As Integer = FileUploadLogo.PostedFile.ContentLength
            'Dim FileName As String = FileUploadLogo.FileName 'FileUploadAbstract.PostedFile.FileName
            Dim FileExt As String = Path.GetExtension(FileUploadLogo.PostedFile.FileName)
            Dim FileContentType As String = FileUploadLogo.PostedFile.ContentType
            Dim FileData(FileLength - 1) As Byte
            AbstractFile.Read(FileData, 0, FileLength)

            Dim UploadAbstractCommand As SqlCommand = New SqlCommand("SponsorFileInsert")
            UploadAbstractCommand.Parameters.AddWithValue("ExhibitorID", gvSponsors.DataKeys(0).Value)
            UploadAbstractCommand.Parameters.AddWithValue("ConferenceID", ddlConfList.SelectedValue)
            UploadAbstractCommand.Parameters.AddWithValue("UploadedFile", FileData)
            UploadAbstractCommand.Parameters.AddWithValue("FileSize", FileLength)
            UploadAbstractCommand.Parameters.AddWithValue("FileName", FileName)
            UploadAbstractCommand.Parameters.AddWithValue("ContentType", FileContentType)

            BattelleExecuteCommand(UploadAbstractCommand)
        End If
    End Sub
End Class