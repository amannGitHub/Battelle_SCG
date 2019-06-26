Imports System.Data
Imports System.Data.SqlClient
Imports System.IO


Public Class ConferenceRoles
    Inherits System.Web.UI.Page

    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


    End Sub


    Protected Sub TopicGroupList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles TopicGroupList.SelectedIndexChanged

        SqlDataSourceSession.DataBind()
        SessionList.DataBind()
        If TopicGroupList.SelectedIndex > 0 Then
            SessionList.Items.Insert(0, New ListItem("- Select -", [String].Empty))
        End If
        SessionList.SelectedIndex = 0
    End Sub


    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        If ddlConfList.SelectedIndex > 0 Then
            gvConferenceRole.Visible = True
            ButtonConferenceAdd.Visible = True
            lblSearchBox.Visible = True
            SearchBox.Visible = True
            FilterButton.Visible = True
        Else
            gvConferenceRole.Visible = False
            ButtonConferenceAdd.Visible = False
            lblSearchBox.Visible = False
            SearchBox.Visible = False
            FilterButton.Visible = False
        End If
        
    End Sub

    Protected Sub ButtonConferenceAdd_Click(sender As Object, e As EventArgs) Handles ButtonConferenceAdd.Click
        Dim chkLeadChair As CheckBox = PanelConferenceRoleAdd.FindControl("chkLeadChair")
        Dim chkAccepted As CheckBox = PanelConferenceRoleAdd.FindControl("chkAccepted")
        PanelConferenceRoleAdd.Visible = True
        ConferenceRoleList.SelectedIndex = -1
        'PersonList.SelectedIndex = -1
        chkLeadChair.Checked = False
        chkAccepted.Checked = False
        lblTopicGroup.Visible = False
        TopicGroupList.SelectedIndex = -1
        TopicGroupList.Visible = False
        lblSession.Visible = False
        SessionList.SelectedIndex = -1
        SessionList.Visible = False
        labelConference.Visible = False
        lblConferenceResults.Text = ""
        'testLabel.Text = TopicGroupList.Items.Count

    End Sub



    Protected Sub ConferenceRoleList_Changed(sender As Object, e As System.EventArgs) Handles ConferenceRoleList.SelectedIndexChanged


        If ConferenceRoleList.SelectedIndex <= 0 Or ConferenceRoleList.SelectedIndex = 1 Then
            TopicGroupList.SelectedIndex = -1
            lblTopicGroup.Visible = False
            TopicGroupList.Visible = False
            SessionList.SelectedIndex = -1
            lblSession.Visible = False
            SessionList.Visible = False
            TopicValidator.Enabled = False
            SessionValidator.Enabled = False
        ElseIf ConferenceRoleList.SelectedIndex = 2 Then
            lblTopicGroup.Visible = True
            TopicGroupList.Visible = True
            lblSession.Visible = True
            SessionList.Visible = True
            TopicValidator.Enabled = True
        ElseIf ConferenceRoleList.SelectedIndex = 3 Then
            lblTopicGroup.Visible = True
            TopicGroupList.Visible = True
            lblSession.Visible = True
            SessionList.Visible = True
            SessionValidator.Enabled = True
        Else
            lblTopicGroup.Visible = True
            TopicGroupList.Visible = True
            lblSession.Visible = True
            SessionList.Visible = True
            TopicValidator.Enabled = False
            SessionValidator.Enabled = False
        End If


    End Sub


    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        Dim chkLeadChair As CheckBox = PanelConferenceRoleAdd.FindControl("chkLeadChair")
        Dim chkAccepted As CheckBox = PanelConferenceRoleAdd.FindControl("chkAccepted")
        Dim chkValid As Integer = 0

        If (txtPersonLookup.Text.Equals("")) Then
            lblPersonCheck.Visible = True

        Else
            lblPersonCheck.Visible = False

            If (User.Identity.IsAuthenticated) Then

                Dim ConferenceID As Integer = ddlConfList.SelectedValue
                Dim RoleID As Integer = ConferenceRoleList.SelectedValue
                Dim PersonID As Integer
                For Each entry As Telerik.Web.UI.AutoCompleteBoxEntry In txtPersonLookup.Entries
                    PersonID = entry.Value
                Next
                Dim TopicGroupID As Integer
                Dim SessionID As Integer
                Dim LeadChair As Boolean
                Dim Accepted As Boolean
                Dim ListOrder As Integer = 1

                If chkLeadChair.Checked = True Then
                    LeadChair = True
                Else
                    LeadChair = False
                End If

                If chkAccepted.Checked = True Then
                    Accepted = True
                Else
                    Accepted = False
                End If

                If ConferenceRoleList.SelectedValue = 1 Then
                    TopicGroupID = 0
                    SessionID = 0
                    chkValid = 1
                ElseIf ConferenceRoleList.SelectedValue = 2 Then
                    TopicGroupID = TopicGroupList.SelectedValue
                    If SessionList.SelectedIndex <= 0 Then
                        SessionID = 0
                    Else
                        SessionID = SessionList.SelectedValue
                    End If

                    chkValid = 1
                ElseIf ConferenceRoleList.SelectedValue = 3 Then
                    SessionID = SessionList.SelectedValue
                    If TopicGroupList.SelectedIndex <= 0 Then
                        TopicGroupID = 0
                    Else
                        TopicGroupID = TopicGroupList.SelectedValue
                    End If
                    chkValid = 1
                Else
                    TopicGroupID = 0
                    SessionID = 0
                    chkValid = 1
                End If


                If chkValid = 1 Then
                    BattelleConferencePersonRolesInsert(ConferenceID, RoleID, PersonID, TopicGroupID, SessionID, LeadChair, ListOrder, Accepted)
                    SqlDataSourceConferenceRole.DataBind()
                    gvConferenceRole.DataBind()
                    labelConference.Visible = True
                    lblConferenceResults.Text = "Conference Role Successfully Added."
                    PanelConferenceRoleAdd.Visible = False
                End If


            Else
                PanelConferenceRoleAdd.Visible = False
                labelConference.Visible = True
                lblConferenceResults.Text = "I am not a valid user"
            End If
        End If
    End Sub





End Class