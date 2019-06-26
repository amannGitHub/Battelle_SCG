Public Class LedgerByPOC
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnLedgerLookup_Click(sender As Object, e As EventArgs) Handles btnLedgerLookup.Click
        If txtPersonLookup.Text <> "" Then
            Dim dv As DataView = SqlDataSourceParticipant.Select(DataSourceSelectArguments.Empty)
            For i As Integer = 0 To dv.Count - 1
                If (dv(i).Row.Item(0).ToString.Equals(txtPersonLookup.Text.Split(";")(0))) Then
                    lblPersonID.Text = dv(i)("PersonID")
                    lblName.Text = dv(i)("FullName")

                    Exit For
                End If
            Next
            pnlAddItem.Visible = True
            Dim dv1 As DataView = SqlDataSourcePOC.Select(DataSourceSelectArguments.Empty)
            Try
                lblBalance.Text = " - Balance: $" + dv1(0)("Balance").ToString
            Catch ex As Exception
                'No worries, just means no ledger
                lblBalance.Text = " - Balance: $0 - No Ledger"
            End Try

        End If
    End Sub

    Protected Sub ddlFeeType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlFeeType.SelectedIndexChanged
        If ddlFeeType.SelectedValue <> "" And ddlConfList.SelectedValue <> "" Then
            Dim dvSql As DataView = SqlDataSourceFee.Select(DataSourceSelectArguments.Empty)
            If dvSql.Count > 0 Then
                Dim iFee As Integer = dvSql.Table.Rows(0).Item("Fee")
                txtAmount.Text = iFee
            Else
                txtAmount.Text = ""
            End If
        End If
    End Sub

    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        If ddlFeeType.SelectedValue <> "" And ddlConfList.SelectedValue <> "" Then
            Dim dvSql As DataView = SqlDataSourceFee.Select(DataSourceSelectArguments.Empty)
            If dvSql.Count > 0 Then
                Dim iFee As Integer = dvSql.Table.Rows(0).Item("Fee")
                txtAmount.Text = iFee
            Else
                txtAmount.Text = ""
            End If
        End If
    End Sub
    Protected Sub btnAddAmount_Click(sender As Object, e As EventArgs) Handles btnAddAmount.Click
        If txtAmount.Text <> "" Then
            SqlDataSourcePOC.Insert()
            gvLedgers.DataBind()
            txtAmount.Text = ""
            ddlFeeType.SelectedValue = ""
            txtNotes.Text = ""
        End If
    End Sub

End Class