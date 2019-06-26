Public Class AttendeeView
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        gvAttendeeList.Visible = True
        lnkRegister.Visible = True
        Dim sApproval As New StringBuilder
        sApproval.Append(Now().ToString)
        sApproval.Replace(" ", "")
        sApproval.Replace(":", "")
        sApproval.Replace("/", "")
        sApproval.Replace("PM", "$")
        sApproval.Replace("AM", "!")
        sApproval.Replace("1", "x")
        sApproval.Replace("2", "j")
        sApproval.Replace("3", "scg")
        sApproval.Replace("4", "z")
        sApproval.Replace("9", "9!")
        lnkRegister.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/register/scgadmin" '& sApproval.ToString (removed because it breaks the select case - use iframe onsite)

    End Sub

    Protected Sub gvAttendeeList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvAttendeeList.SelectedIndexChanged
        PanelDetails.Visible = True
        PanelLinks.Visible = True
        SqlDataSourceFee.SelectParameters("ConferenceID").DefaultValue = ddlConfList.SelectedValue
        'Session.Abandon()

        lnkBalance.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/balance"
        lnkConfirm.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/regconfirm"
        lnkSendEmail.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/regconfirm/adminconfirm/admin"
        lnkBarcode.NavigateUrl = "~/admin/attendee/attendeebarcode"
        Dim row As GridViewRow = gvAttendeeList.SelectedRow
        Dim PersonID As Integer
        Dim cLabel As Label
        cLabel = CType(row.Cells(3).FindControl("lblPersonID"), Label)
        PersonID = cLabel.Text
        Session("PersonID") = PersonID 'removed Session("PersonID") on 8/25/2015
        'Populate name badge text
        SqlDataSourceAttendee.SelectParameters("PersonID").DefaultValue = PersonID
        Dim dvAttendee As DataView = DirectCast(SqlDataSourceAttendee.Select(DataSourceSelectArguments.Empty), DataView)
        If dvAttendee.Count > 0 Then
            Dim sFirstName As String = dvAttendee.Table.Rows(0).Item("FirstName")
            Dim sLastName As String = dvAttendee.Table.Rows(0).Item("LastName")
            Dim sOrg As String = dvAttendee.Table.Rows(0).Item("Employer")

            Dim sCity As String = ""

            If Not IsDBNull(dvAttendee.Table.Rows(0).Item("City")) Then
                sCity = dvAttendee.Table.Rows(0).Item("City")
            End If
            Dim sState As String = ""
            If Not IsDBNull(dvAttendee.Table.Rows(0).Item("StateProvince")) Then
                sState = dvAttendee.Table.Rows(0).Item("StateProvince")
            End If
            Dim sCountry As String = dvAttendee.Table.Rows(0).Item("Country")
            Dim sNameBadge As New StringBuilder
            sNameBadge.Append(sFirstName & " " & sLastName & "<br />" & sOrg & "<br />")
            sNameBadge.AppendLine(sCity)
            If sState <> "" Then
                sNameBadge.AppendLine(", " & sState)
            End If
            If sCountry <> "USA" Then
                sNameBadge.AppendLine(", " & sCountry)
            End If

            LiteralNameBadge.Text = sNameBadge.ToString
        Else
            txtAmount.Text = ""
        End If
    End Sub

    Protected Sub LinkButtonHide_Click(sender As Object, e As EventArgs) Handles LinkButtonHide.Click
        PanelDetails.Visible = False

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


    Protected Sub ddlFeeType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlFeeType.SelectedIndexChanged
        If ddlFeeType.SelectedValue <> "" Then
            Dim dvSql As DataView = DirectCast(SqlDataSourceFee.Select(DataSourceSelectArguments.Empty), DataView)
            If dvSql.Count > 0 Then
                Dim iFee As Integer = dvSql.Table.Rows(0).Item("Fee")
                txtAmount.Text = iFee
            Else
                txtAmount.Text = ""
            End If
        End If

    End Sub

    Protected Sub btnAddAmount_Click(sender As Object, e As EventArgs) Handles btnAddAmount.Click
        If ddlFeeType.SelectedValue <> "" And txtAmount.Text <> "" Then
            SqlDataSourceBalance.Insert()
            gvBalance.DataBind()
            txtAmount.Text = ""
            ddlFeeType.SelectedValue = ""
            txtNotes.Text = ""
        End If


    End Sub

    Protected Sub lnkRefresh_Click(sender As Object, e As EventArgs) Handles lnkRefresh.Click
        gvAttendeeList.DataBind()

    End Sub

End Class