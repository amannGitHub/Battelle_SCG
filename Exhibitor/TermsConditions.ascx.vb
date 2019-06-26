'Imports System.Globalization
Public Class TermsConditions
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ConferenceControl As ConferenceFromURL = CType(Me.Parent.Page.Master.FindControl("ConferenceFromURL"), ConferenceFromURL)
        If Not IsPostBack Then
            'Dim ci As New CultureInfo("en-us")

            Dim sExhibOrSponsor As String = Page.RouteData.Values("type").ToString()

            SqlDataSourceTermsConditions.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            Dim iRows As Integer
            Dim dv As DataView
            dv = CType(SqlDataSourceTermsConditions.Select(DataSourceSelectArguments.Empty), DataView)
            iRows = CType(dv.Table.Rows.Count, Integer)
            If iRows > 0 Then ' Data found


                If sExhibOrSponsor = "sponsor" Then
                    lblTermsConditions.Text = dv.Table.Rows(0)("SponsorTermsConditions")
                Else
                    lblTermsConditions.Text = dv.Table.Rows(0)("TermsConditions")
                End If


            End If
        End If
    End Sub

End Class