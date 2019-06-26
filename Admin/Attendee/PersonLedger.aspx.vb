Imports System.Web.Routing
Public Class PersonLedger
    Inherits System.Web.UI.Page


    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Not IsPostBack Then
            If Request.QueryString("cid") <> "" Then
                SqlDataSourceBalance.SelectCommand = "ConferenceLedgerGetTotal"
                SqlDataSourceBalance.SelectParameters.Add("ConferenceID", Request.QueryString("cid"))
            End If
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


    End Sub

    Protected Sub gvBalance_DataBound(sender As Object, e As EventArgs) Handles gvBalance.DataBound
        Dim SumTotal As Decimal
        Try
            Dim cLabel As Label
            cLabel = CType(gvBalance.Rows(0).Cells(gvBalance.Columns.Count - 1).FindControl("lblSumTotal"), Label)
            SumTotal = cLabel.Text
        Catch ex As Exception
            'No worries, just means no ledger
            SumTotal = 0
        End Try
        lblSumTotal.Text = SumTotal
    End Sub
End Class