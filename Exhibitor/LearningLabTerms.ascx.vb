Public Class LearningLabTerms
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ConferenceControl As ConferenceFromURL = CType(Me.Parent.Page.Master.FindControl("ConferenceFromURL"), ConferenceFromURL)
        If Not IsPostBack Then
            SqlDataSourceTermsConditions.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            Dim iRows As Integer
            Dim dv As DataView
            dv = CType(SqlDataSourceTermsConditions.Select(DataSourceSelectArguments.Empty), DataView)
            iRows = CType(dv.Table.Rows.Count, Integer)
            If iRows > 0 Then ' Data found

                lblTermsConditions.Text = dv.Table.Rows(0)("LearningLabTermsConditions")
                'If sExhibOrSponsor = "sponsor" Then
                '    lblTermsConditions.Text = dv.Table.Rows(0)("SponsorTermsConditions")
                'Else
                '    lblTermsConditions.Text = dv.Table.Rows(0)("TermsConditions")
                'End If


            End If
        End If
    End Sub

End Class