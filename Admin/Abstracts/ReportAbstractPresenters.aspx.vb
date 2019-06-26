Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports xi = Telerik.Web.UI.ExportInfrastructure
Imports System.Web.UI
Imports System.Web
Imports Telerik.Web.UI.GridExcelBuilder
Imports System.Drawing
Imports Telerik.Windows.Documents.Core
Imports Telerik.Windows.Documents.Spreadsheet
Imports Telerik.Windows.Zip
Imports Telerik.Windows.Documents.Spreadsheet.FormatProviders.OpenXml
Public Class ReportAbstractPresenters
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub RadGrid1_DataBound(sender As Object, e As EventArgs) Handles RadGrid1.DataBound
        If RadGrid1.MasterTableView.Items.Count > 0 Then
            ImageButtonExportXLS.Visible = True
        Else
            ImageButtonExportXLS.Visible = False
        End If

    End Sub

    Protected Sub ImageButtonExportXLS_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButtonExportXLS.Click
        RadGrid1.ExportSettings.Excel.Format = DirectCast([Enum].Parse(GetType(GridExcelExportFormat), "Xlsx"), GridExcelExportFormat)
        RadGrid1.ExportSettings.ExportOnlyData = True
        RadGrid1.ExportSettings.OpenInNewWindow = True
        RadGrid1.MasterTableView.ExportToExcel()
    End Sub
End Class