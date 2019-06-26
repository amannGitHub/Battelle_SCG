Public Class ExhibitorLists
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'Register javascript
            'Dim cs As ClientScriptManager = Page.ClientScript
            'Dim cstype As Type = Me.GetType()
            'Dim csname As String = "ScrollLock"
            'If (Not cs.IsClientScriptBlockRegistered(cstype, csname)) Then

            '    Dim cstext As New StringBuilder()

            '    cstext.Append("<script language=""javascript"" type=""text/javascript"">" & vbLf)
            '    cstext.Append("/* This Script is used to maintain Grid Scroll on Partial Postback */" & vbLf)
            '    cstext.Append("var scrollTop;" & vbLf)
            '    cstext.Append("/* Register Begin Request and End Request */" & vbLf)
            '    cstext.Append("Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);" & vbLf)
            '    cstext.Append("Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);" & vbLf)
            '    cstext.Append("/* Get The Div Scroll Position */" & vbLf)
            '    cstext.Append("function BeginRequestHandler(sender, args)" & vbLf)
            '    cstext.Append("{" & vbLf)
            '    cstext.Append("var m = document.getElementById('divGrid');" & vbLf)
            '    cstext.Append("scrollTop=m.scrollTop;" & vbLf)
            '    cstext.Append("}" & vbLf)
            '    cstext.Append("/* Set The Div Scroll Position */" & vbLf)
            '    cstext.Append("function EndRequestHandler(sender, args)" & vbLf)
            '    cstext.Append("{" & vbLf)
            '    cstext.Append("var m = document.getElementById('divGrid');" & vbLf)
            '    cstext.Append("m.scrollTop = scrollTop;" & vbLf)
            '    cstext.Append("}" & vbLf)
            '    cstext.Append("</script>")

            '    cs.RegisterClientScriptBlock(cstype, csname, cstext.ToString(), False)

            'End If

        End If
    End Sub

    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        gvExhibList.Visible = True
    End Sub

    Protected Sub gvExhibList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvExhibList.SelectedIndexChanged
        PanelDetails.Visible = True
        SqlDataSourceFee.SelectParameters("ConferenceID").DefaultValue = ddlConfList.SelectedValue
        'Session.Abandon()
        lnkStaff.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/exhibit/booth/staff"
        lnkBalance.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/balance"
        lnkConfirm.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/exhibit/exhibitor/adminconfirm/admin"
        linkSponsorRegConfirm.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/exhibit/sponsor/registration/adminconfirm/admin"
        lnkSendEmail.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/exhibit/exhibitor/confirm"
        lnkSendSponsorRegEmail.NavigateUrl = "~/" & ddlConfList.SelectedItem.Text & "/exhibit/sponsor/registration/confirm"
        Dim row As GridViewRow = gvExhibList.SelectedRow
        Dim PersonID As Integer
        Dim cLabel As Label
        Dim lblFName As Label
        Dim lblLName As Label
        cLabel = CType(row.Cells(3).FindControl("lblPersonID"), Label)
        lblFName = CType(row.Cells(3).FindControl("lblFName"), Label)
        lblLName = CType(row.Cells(3).FindControl("lblLName"), Label)
        PersonID = cLabel.Text
        Session("PersonID") = PersonID 'removed Session("PersonID") on 8/25/2015
        lblSession.Text = lblFName.Text & " " & lblLName.Text
        lnkbtnSession.Visible = True
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
        gvExhibList.DataBind()

    End Sub

    Protected Sub lnkbtnSession_Click(sender As Object, e As EventArgs) Handles lnkbtnSession.Click
        Session.Abandon()
        lblSession.Text = "None - Copy Participant Code or select different Exhibitor"
        lnkbtnSession.Visible = False
    End Sub
End Class