Imports System.Data.SqlClient
Public Class SCGLinks
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then 'removed Session("PersonID") on 8/25/2015
            lblSession.Text = "Person ID: " & Session("PersonID") & " (Sorry not more descriptive) "
            lnkbtnSession.Visible = True
        End If
    End Sub

    Protected Sub lnkbtnSession_Click(sender As Object, e As EventArgs) Handles lnkbtnSession.Click
        Session.Abandon()
        'Response.Cookies("battelle")("PersonID") = ""
        lblSession.Text = "None (refresh page if unsure)"
        lnkbtnSession.Visible = False
    End Sub

    Protected Sub btnPersonLookup_Click(sender As Object, e As EventArgs) Handles btnPersonLookup.Click

        Dim dv As DataView = SqlDataSourceParticipant.Select(DataSourceSelectArguments.Empty)

        For i As Integer = 0 To dv.Count - 1
            If (dv(i).Row.Item(0).ToString.Equals(txtPersonLookup.Text.Split(";")(0))) Then
                If Not IsDBNull(dv(i)("ParticipationID")) Then
                    lblParticipationID.Text = dv(i)("ParticipationID")
                    Exit For
                Else
                    lblParticipationID.Text = "ParticipationID not found"
                End If
            End If
        Next

    End Sub

End Class