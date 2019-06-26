Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Public Class OnSiteStaffTechRegReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


    End Sub

    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged

        Dim ConferenceID As Integer = ddlConfList.SelectedValue
        Dim SelectExhibitorStaffRemainingByConferenceCommand As SqlCommand = New SqlCommand("ExhibitorStaffRemainingByConference")
        SelectExhibitorStaffRemainingByConferenceCommand.Parameters.AddWithValue("ConferenceID", ConferenceID)

        Dim DSReturnData As DataSet

        DSReturnData = BattelleExecuteCommand(SelectExhibitorStaffRemainingByConferenceCommand)

        If DSReturnData.Tables(0).Rows.Count > 0 Then

            SponsorExhibitorNoBooth.DataSource = DSReturnData.Tables(1)
            SponsorExhibitorNoBooth.DataBind()
            PanelSponsorExhibitorNoBooth.Visible = True

        Else
            ' No Records found
            PanelSponsorExhibitorNoBooth.Visible = False
        End If
    End Sub



End Class