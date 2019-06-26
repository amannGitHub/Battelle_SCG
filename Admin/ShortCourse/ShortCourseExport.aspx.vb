Imports System.IO
Imports System.Data
Imports System.Drawing
Imports System.Data.SqlClient
Imports System.Configuration


Public Class ShortCourseExport
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


    End Sub


    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        If ddlConfList.SelectedIndex > 0 Then
            lblSearchBox.Visible = True
            SearchBox.Visible = True
            FilterButton.Visible = True
            gvShortCourse.Visible = True
            ButtonExport.Visible = True
            labelExport.Visible = True
        Else
            lblSearchBox.Visible = False
            SearchBox.Visible = False
            FilterButton.Visible = False
            gvShortCourse.Visible = False
            ButtonExport.Visible = False
            labelExport.Visible = False
        End If

    End Sub



    Protected Sub ButtonExport_Click(sender As Object, e As EventArgs) Handles ButtonExport.Click

        Dim regDate As Date = Date.Now()
        Dim strDate As String = regDate.ToString("ddMMMyyyy")
        Dim fileName As String = "ShortCourse_Export" + strDate + ".xls"

        ' Let's hide all unwanted stuffing
        Me.gvShortCourse.AllowPaging = False
        Me.gvShortCourse.AllowSorting = False
        Me.gvShortCourse.EditIndex = -1

        ' Let's bind data to GridView
        SqlDataSourceShortCourse.DataBind()
        gvShortCourse.DataBind()

        ' Let's output HTML of GridView
        Response.Clear()
        Response.ContentType = "application/vnd.xls"
        Response.AddHeader("content-disposition", "attachment;filename=" + fileName)

        Dim swriter As New StringWriter()
        Dim hwriter As New HtmlTextWriter(swriter)

        Dim frm As New HtmlForm()
        Me.gvShortCourse.Parent.Controls.Add(frm)
        frm.Attributes("runat") = "server"
        frm.Controls.Add(Me.gvShortCourse)
        frm.RenderControl(hwriter)

        Response.Write(swriter.ToString())
        Response.[End]()

    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As System.Web.UI.Control)
    End Sub



End Class