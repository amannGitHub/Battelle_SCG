Imports Korzh.EasyQuery
Imports Korzh.EasyQuery.Db
Imports Korzh.EasyQuery.WebControls
Imports System.IO
Imports System.Data
Imports System.Drawing
Imports System.Data.SqlClient
Imports System.Configuration
Public Class QueryBuilder
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim query As DbQuery = DirectCast(Session("QUERY"), DbQuery)
        If query Is Nothing Then
            'we didn't open this page before

            Dim modelPath As String = Me.MapPath("~/Models/BattelleDB.xml")

            Dim model As Korzh.EasyQuery.DataModel = New DbModel()
            model.LoadFromFile(modelPath)

            query = New Korzh.EasyQuery.Db.DbQuery()
            query.Model = model

            query.Formats.SetDefaultFormats(FormatType.MsSqlServer)
            Session("QUERY") = query
        End If

        QueryPanel1.Query = query
        QueryColumnsPanel1.Query = QueryPanel1.Query

        'Only if you have placed EntitiesPanel and SortColumnsPanel on your form  
        EntitiesPanel1.Query = QueryPanel1.Query
        'SortColumnsPanel1.Query = QueryPanel1.Query


    End Sub



    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered
    End Sub


    Protected Sub LinkButtonExport_Click(sender As Object, e As EventArgs) Handles LinkButtonExport.Click
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"

        'Special Character fix
        Response.ContentEncoding = Encoding.Unicode
        Response.BinaryWrite(Encoding.Unicode.GetPreamble())

        'Special Character fix
        Response.ContentEncoding = Encoding.Unicode
        Response.BinaryWrite(Encoding.Unicode.GetPreamble())

        ' Add the HTML from the GridView to a StringWriter so we can write it out later  
        Dim sw As System.IO.StringWriter = New System.IO.StringWriter
        Dim hw As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(sw)
        GridView1.RenderControl(hw)

        ' Write out the data  
        Response.Write(sw.ToString)
        Response.End()
    End Sub



    Sub BuildQuery()
        Dim builder As New SqlQueryBuilder(QueryPanel1.Query)
        If builder.CanBuild Then
            builder.BuildSQL()
            Dim sql As String = builder.Result.SQL
            SqlDataSource1.SelectCommand = sql
            'executes the query and shows result. 
            PanelResult.Visible = True
            GridView1.DataBind()
        Else
            PanelResult.Visible = False
        End If
    End Sub



    Protected Sub LinkButtonClear_Click(sender As Object, e As EventArgs) Handles LinkButtonClear.Click
        Dim query As DbQuery = DirectCast(Session("QUERY"), DbQuery)
        If query.Root.Conditions.Count() > 0 Then
            query.Root.Conditions.Clear()
        End If

        If query.Columns.Count() > 0 Then
            query.Columns.Clear()
        End If

        QueryPanel1.Query = query
        QueryColumnsPanel1.Query = QueryPanel1.Query

        'Only if you have placed EntitiesPanel and SortColumnsPanel on your form  
        EntitiesPanel1.Query = QueryPanel1.Query
        'SortColumnsPanel1.Query = QueryPanel1.Query
        BuildQuery()
    End Sub

    Protected Sub LinkButtonExecute_Click(sender As Object, e As EventArgs) Handles LinkButtonExecute.Click
        BuildQuery()
    End Sub
End Class