Public Class Dashboard
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            lnkProgChairReview.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/programchair"
            lnkProgChairReReview.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/returned"
            lnkSteeringComm.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/steeringcomm"
            lnkSessionChairReview.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/sessionchair"
            lnkAdminReview.NavigateUrl = "~/Admin/AbstractOverviewEditor"
            lnkProgChairOverall.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/OverallStandings"
            lnkReReviewOverall.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/OverallStandings"
            lnkSteeringCommOverall.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/OverallStandings"
            lnkSessionChairOverall.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/OverallStandings"
            lnkAdminOverall.NavigateUrl = "~/Admin/AbstractOverview"

            lblConferenceType.Text = ConferenceControl.ConferenceShortName

            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
                PanelParticipationControl.Visible = False
                CheckUser()
            Else
                PanelParticipationControl.Visible = True


            End If
        End If

    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
        'Response.Cookies("battelle")("PersonID") = PersonID  'removed Session("PersonID") on 8/25/2015
        PanelParticipationControl.Visible = False

        CheckUser()




    End Sub

    Private Sub CheckUser()
        'see which panels to open
        Dim dv As DataView
        Dim iRows As Integer = 0

        SqlDataSourceRoles.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        SqlDataSourceRoles.SelectParameters("PersonID").DefaultValue = Session("PersonID")

        dv = CType(SqlDataSourceRoles.Select(DataSourceSelectArguments.Empty), DataView)
        iRows = dv.Table.Rows.Count

        If iRows > 0 Then ' Data found
            Dim iRoleID As Integer = 0
            For i = 0 To iRows - 1
                iRoleID = dv.Table.Rows(i).Item("RoleID").ToString
                Select Case iRoleID
                    Case 1 'Program Chair
                        SqlDataSourceProgChair.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceProgChair.SelectParameters("PersonID").DefaultValue = Session("PersonID")
                        SqlDataSourceReturned.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceReturned.SelectParameters("PersonID").DefaultValue = Session("PersonID")
                        PanelReturnedToProgramChairs.Visible = True
                        PanelProgramChair.Visible = True

                        Session("ProgramChair") = "1"
                    Case 2 'Steering Committee
                        SqlDataSourceSteeringComm.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceSteeringComm.SelectParameters("PersonID").DefaultValue = Session("PersonID")
                        PanelSteeringCommittee.Visible = True
                        Dim sLead As String
                        sLead = dv.Table.Rows(i).Item("LeadChair").ToString
                        If sLead = "True" Then
                            Session("SteeringCommittee") = "2"
                        Else
                            Session("SteeringCommittee") = "1"
                        End If

                    Case 3 'Session Chair
                        SqlDataSourceSessionChair.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceSessionChair.SelectParameters("PersonID").DefaultValue = Session("PersonID")
                        PanelSessionChair.Visible = True
                        Dim sLead As String
                        sLead = dv.Table.Rows(i).Item("LeadChair").ToString
                        If sLead = "True" Then
                            Session("SessionChair") = "2"
                        Else
                            Session("SessionChair") = "1"
                        End If

                    Case 4 'Admin
                        SqlDataSourceProgChair.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceProgChair.SelectParameters("PersonID").DefaultValue = Session("PersonID")
                        SqlDataSourceReturned.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceReturned.SelectParameters("PersonID").DefaultValue = Session("PersonID")
                        PanelReturnedToProgramChairs.Visible = True
                        PanelProgramChair.Visible = True
                        Session("ProgramChair") = "2"
                        SqlDataSourceSteeringComm.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceSteeringComm.SelectParameters("PersonID").DefaultValue = Session("PersonID")
                        PanelSteeringCommittee.Visible = True
                        Session("SteeringCommittee") = "2"
                        SqlDataSourceSessionChair.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceSessionChair.SelectParameters("PersonID").DefaultValue = Session("PersonID")
                        PanelSessionChair.Visible = True
                        Session("SessionChair") = "2"
                        PanelAdmin.Visible = True
                End Select
            Next
        End If
        lblMessage.Text = "<h4>If you believe you should have access to other topic areas please contact Gina.</h4>"
    End Sub
End Class