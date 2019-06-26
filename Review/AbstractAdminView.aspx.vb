Imports System.Web.Routing
Public Class AbstractAdminView
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then

            lblConferenceType.Text = ConferenceControl.ConferenceShortName
            lnkReturn.NavigateUrl = "~/Admin/AbstractOverviewEditor"
            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = Page.RouteData.Values("theme")

            SqlDataSourceAdminReview.SelectParameters("abstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceAdminReview.DataBind()
            gvAdminReview.DataBind()
            If gvAdminReview.Rows.Count > 0 Then
                FormViewReview.DataSourceID = "SqlDataSourceReview"
            Else
                FormViewReview.DataSourceID = "SqlDataSourceSessionReview"
            End If

            SqlDataSourceProgramChairReviews.SelectParameters("abstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceProgramChairReviews.DataBind()
            gvProgramChairReviews.DataBind()
            If gvProgramChairReviews.Rows.Count > 0 Then
                ButtonUnfinalize1.Visible = True
            End If


            SqlDataSourceCommitteeReviews.SelectParameters("abstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceCommitteeReviews.DataBind()

            For Each item As GridViewRow In gvCommitteeReviews.Rows
                If item.Cells(0).Text = "Steering Committee Review" Then
                    ButtonUnfinalize2.Visible = True
                End If
            Next

            SqlDataSourceSessionChairReviews.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceSessionChairReviews.DataBind()
            gvSessionChairReviews.DataBind()

            If gvSessionChairReviews.Rows.Count > 0 Then
                ButtonUnfinalize3.Visible = True
            End If


        End If

        SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

        Dim bValid As Boolean = False
        'Make sure only authorized view
        If Not Session("ProgramChair") Is Nothing Then
            bValid = True
        End If
        If bValid = False Then
            If Not Session("SteeringCommittee") Is Nothing Then
                bValid = True
            End If
        End If


        If bValid = True Then

            SqlDataSourceTopicGroup.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

            SqlDataSourceAbstractSelected.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceProgramChairReviews.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceCommitteeReviews.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceSessionChairReviews.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceAdminReview.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")

            SqlDataSourceReview.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.InsertParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.InsertParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceReview.UpdateParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.UpdateParameters("PersonID").DefaultValue = Session("PersonID")

            SqlDataSourceSessionReview.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceSessionReview.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")



            If Not Page.RouteData.Values("admin") Is Nothing Then
                'SqlDataSourceOtherReviews.FilterExpression = "ReviewType = 'Session Chair Review'"
                gvSessionChairReviews.Visible = True
                gvAdminReview.Visible = True

                SqlDataSourceProgramChairReviews.FilterExpression = "ReviewType = 'Program Chair Review'"
                SqlDataSourceCommitteeReviews.FilterExpression = "ReviewType = 'Steering Committee Review'"
                SqlDataSourceSessionChairReviews.FilterExpression = "ReviewType = 'Session Chair Review'"
            End If


        Else
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
    End Sub


    Protected Sub ddlTopic_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlTopic As DropDownList = FormViewReview.FindControl("ddlTopic")
        Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim lblDeclineComments As Label = FormViewReview.FindControl("CommentDeclineLabel")
        Dim txtDeclineNotes As TextBox = FormViewReview.FindControl("DeclineTextBox")
        Dim reqDeclineValidator As RequiredFieldValidator = FormViewReview.FindControl("DeclineValidator")

        If ddlTopic.SelectedIndex <> 0 Then

            SqlDataSourceReview.UpdateParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedIndex
            'ddlSession.Enabled = True

            'Clear existing items
            ddlSession.Items.Clear()
            'Add new blank and rebind
            Dim liSelectOne As New ListItem("")
            ddlSession.Items.Insert(0, liSelectOne)
            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

            ddlSession.DataBind()

            'hide decline textbox
            chkDecline.Checked = False
            lblDeclineComments.Visible = False
            txtDeclineNotes.Visible = False
            txtDeclineNotes.Text = ""
            reqDeclineValidator.Enabled = False


        Else
            'ddlSession.Enabled = False
        End If

    End Sub


    Protected Sub FormViewReview_DataBound(sender As Object, e As EventArgs) Handles FormViewReview.DataBound
        If FormViewReview.DataItemCount > 0 Then 'has data
            'If FormViewReview.CurrentMode <> FormViewMode.Edit Then
            'FormViewReview.ChangeMode(FormViewMode.Edit)
            'End If
            'FormViewReview.ChangeMode(FormViewMode.Edit)
            PanelFinalize.Visible = True
        Else
            'If FormViewReview.CurrentMode <> FormViewMode.Insert Then
            'FormViewReview.ChangeMode(FormViewMode.Insert)
            'End If
            PanelFinalize.Visible = False
        End If

        If FormViewReview.CurrentMode = FormViewMode.ReadOnly Then

            If gvAdminReview.Rows.Count > 0 Then

                'When a bound GridView cell contains no data, ASP.NET fills it with &nbsp; and has a length of 6. Check FinalDate column, if not empty or "&nbsp;" it has been finalized
                If Not gvAdminReview.Rows(0).Cells(8).Text = "&nbsp;" Then

                    'Adam commented out 1/26/2015
                    'FormViewReview.Visible = False
                    'PanelFinalize.Visible = False
                Else
                    FormViewReview.Visible = True
                    PanelFinalize.Visible = True
                End If

            Else
                If (Not gvSessionChairReviews.Rows.Count > 0) Then

                    FormViewReview.ChangeMode(FormViewMode.Insert)
                Else
                    'If gvSessionChairReviews.Rows(0).Cells(9).Text = "&nbsp;" Then

                    'FormViewReview.ChangeMode(FormViewMode.Insert)
                    'Else
                    'FormViewReview.ChangeMode(FormViewMode.ReadOnly)
                    Dim dtCheck As Integer = 0

                    For i As Integer = 0 To gvSessionChairReviews.Rows.Count - 1


                        Dim row = gvSessionChairReviews.Rows(i)
                        Dim rowTxtCell = row.Cells(6)

                        If rowTxtCell.Text <> "&nbsp;" And rowTxtCell.Text <> "" Then
                            dtCheck = 1
                        End If
                    Next

                    If dtCheck = 0 Then
                        FormViewReview.ChangeMode(FormViewMode.Insert)
                    Else
                        FormViewReview.ChangeMode(FormViewMode.ReadOnly)
                    End If

                End If

            End If

        End If


        If FormViewReview.CurrentMode = FormViewMode.Edit Then

            Dim chkAssignedTopic As HiddenField = FormViewReview.FindControl("hdnTopicGroupID")

            Dim ddlTopic As DropDownList = FormViewReview.FindControl("ddlTopic")
            Dim reqTopicValidator As RequiredFieldValidator = FormViewReview.FindControl("TopicValidator")
            Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
            Dim reqSessionValidator As RequiredFieldValidator = FormViewReview.FindControl("SessionValidator")
            Dim chkSelFormat As DropDownList = FormViewReview.FindControl("ddlFormat")
            Dim reqFormatValidator As RequiredFieldValidator = FormViewReview.FindControl("FormatValidator")
            Dim chkComments As TextBox = FormViewReview.FindControl("CommentsTextBox")


            Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
            Dim lblDeclineComments As Label = FormViewReview.FindControl("CommentDeclineLabel")

            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            ddlSession.DataBind()

            If FormViewReview.DataSourceID = "SqlDataSourceReview" Then
                Dim dvProfile As DataView = SqlDataSourceReview.Select(DataSourceSelectArguments.Empty)
                Dim drProfile As DataRow = dvProfile.Table.Rows(0)
                If drProfile("SessionID").ToString() = "" Then
                    ddlSession.SelectedIndex = 0
                Else
                    ddlSession.SelectedValue = drProfile("SessionID").ToString()
                End If
            Else
                Dim dvProfile As DataView = SqlDataSourceSessionReview.Select(DataSourceSelectArguments.Empty)
                Dim drProfile As DataRow = dvProfile.Table.Rows(0)
                If drProfile("SessionID").ToString() = "" Then
                    ddlSession.SelectedIndex = 0
                Else
                    ddlSession.SelectedValue = drProfile("SessionID").ToString()
                End If
            End If


            If chkDecline.Checked = True Then
                ddlTopic.SelectedIndex = -1
                reqTopicValidator.Enabled = False
                ddlSession.SelectedIndex = -1
                reqSessionValidator.Enabled = False
                chkSelFormat.SelectedIndex = -1
                reqFormatValidator.Enabled = False
                chkComments.Text = ""
                lblDeclineComments.Visible = True
                FormViewReview.FindControl("DeclineTextBox").Visible = True
            End If

            SqlDataSourceAdminReview.DataBind()
            gvAdminReview.DataBind()



            'Adam commented out 1/26/2015
            'If gvAdminReview.Rows.Count > 0 Then

            'If Not gvAdminReview.Rows(0).Cells(8).Text = "&nbsp;" Then
            'AdminReview_GetDataSource()
            'FormViewReview.Visible = False
            'PanelFinalize.Visible = False
            'End If

            'End If




        End If


    End Sub

    Protected Sub InsertButton_Click(sender As Object, e As System.EventArgs)
        Dim ddlTopic As DropDownList = FormViewReview.FindControl("ddlTopic")
        Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
        Dim chkAssignedFormat As DropDownList = FormViewReview.FindControl("ddlFormat")
        Dim txtReviewNotes As TextBox = FormViewReview.FindControl("CommentsTextBox")
        Dim chkDeclined As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim txtDeclineNotes As TextBox = FormViewReview.FindControl("DeclineTextBox")


        If chkDeclined.Checked = True Then
            ddlTopic.SelectedIndex = -1
            ddlSession.SelectedIndex = -1
            chkAssignedFormat.SelectedIndex = -1
            txtReviewNotes.Text = ""
        End If

        SqlDataSourceReview.InsertParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
        SqlDataSourceReview.InsertParameters("SessionID").DefaultValue = ddlSession.SelectedValue
        SqlDataSourceReview.InsertParameters("FinalFormat").DefaultValue = chkAssignedFormat.SelectedValue
        SqlDataSourceReview.InsertParameters("ReviewNotes").DefaultValue = txtReviewNotes.Text
        SqlDataSourceReview.InsertParameters("Declined").DefaultValue = chkDeclined.Checked
        SqlDataSourceReview.InsertParameters("DeclineNotes").DefaultValue = txtDeclineNotes.Text
        SqlDataSourceReview.Insert()


        FormViewReview.DataSourceID = "SqlDataSourceReview"
        SqlDataSourceReview.DataBind()
        FormViewReview.DataBind()

        FormViewReview.ChangeMode(FormViewMode.ReadOnly)
        PanelFinalize.Visible = True


        SqlDataSourceAdminReview.DataBind()
        gvAdminReview.DataBind()
    End Sub


    Protected Sub UpdateButton_Click(sender As Object, e As EventArgs)

        Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
        Dim ddlTopic As DropDownList = FormViewReview.FindControl("ddlTopic")
        Dim chkAssignedFormat As DropDownList = FormViewReview.FindControl("ddlFormat")
        Dim txtReviewNotes As TextBox = FormViewReview.FindControl("CommentsTextBox")
        Dim chkDeclined As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim txtDeclineNotes As TextBox = FormViewReview.FindControl("DeclineTextBox")

        If chkDeclined.Checked = True Then
            ddlTopic.SelectedIndex = -1
            ddlSession.SelectedIndex = -1
            chkAssignedFormat.SelectedIndex = -1
            txtReviewNotes.Text = ""
        End If

        SqlDataSourceReview.UpdateParameters("abstractID").DefaultValue = FormViewReview.DataKey(0)
        SqlDataSourceReview.UpdateParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
        SqlDataSourceReview.UpdateParameters("SessionID").DefaultValue = ddlSession.SelectedValue
        SqlDataSourceReview.UpdateParameters("FinalFormat").DefaultValue = chkAssignedFormat.SelectedValue
        SqlDataSourceReview.UpdateParameters("ReviewNotes").DefaultValue = txtReviewNotes.Text
        SqlDataSourceReview.UpdateParameters("Declined").DefaultValue = chkDeclined.Checked
        SqlDataSourceReview.UpdateParameters("DeclineNotes").DefaultValue = txtDeclineNotes.Text
        SqlDataSourceReview.Update()

        PanelFinalize.Visible = True

        SqlDataSourceAdminReview.DataBind()
        gvAdminReview.DataBind()

    End Sub


    Protected Sub CancelButton_Click(sender As Object, e As EventArgs)
        FormViewReview.ChangeMode(FormViewMode.ReadOnly)
    End Sub





    Protected Sub FormViewReview_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormViewReview.ItemUpdated
        PanelFinalize.Visible = True
    End Sub


    Protected Sub btnFinalize_Click(sender As Object, e As EventArgs) Handles btnFinalize.Click

        Dim chkAssignedTopic As HiddenField = FormViewReview.FindControl("hdnTopicGroupID")
        Dim chkAssignedSession As HiddenField = FormViewReview.FindControl("hdnSessionID")
        Dim chkAssignedFormat As Label = FormViewReview.FindControl("AssignedPresentationLabel")
        Dim chkReviewNotes As Label = FormViewReview.FindControl("ReviewNotesLabel")
        Dim lblDeclined As Label = FormViewReview.FindControl("DeclineLabel")
        Dim txtDeclineNotes As Label = FormViewReview.FindControl("DeclineLabelNotes")


        If FormViewReview.CurrentMode = FormViewMode.ReadOnly Then

            SqlDataSourceReview.UpdateParameters("abstractID").DefaultValue = FormViewReview.DataKey(0)
            SqlDataSourceReview.UpdateParameters("TopicGroupID").DefaultValue = chkAssignedTopic.Value
            SqlDataSourceReview.UpdateParameters("SessionID").DefaultValue = chkAssignedSession.Value
            SqlDataSourceReview.UpdateParameters("FinalFormat").DefaultValue = chkAssignedFormat.Text
            SqlDataSourceReview.UpdateParameters("ReviewNotes").DefaultValue = chkReviewNotes.Text

            If lblDeclined.Text = "True" Then
                SqlDataSourceReview.UpdateParameters("Declined").DefaultValue = True
            Else
                SqlDataSourceReview.UpdateParameters("Declined").DefaultValue = False
            End If

            SqlDataSourceReview.UpdateParameters("DeclineNotes").DefaultValue = txtDeclineNotes.Text

            If lblDeclined.Text = "False" And (chkAssignedTopic.Value = "" Or chkAssignedSession.Value = "" Or chkAssignedFormat.Text = "") Then
                lblFinalize.Visible = True
                lblFinalize.Text = "Values for one or more required fields is missing. Please select the 'Edit' link and provide the appropriate values to finalize."

            Else
                SqlDataSourceReview.Update()
                SqlDataSourceFinalize.UpdateParameters("abstractID").DefaultValue = FormViewReview.DataKey(0)
                SqlDataSourceFinalize.Update()
                Dim sURL As String = "~/" & ConferenceControl.ConferenceURLString & "/review/adminlist"
                Response.Redirect(sURL, True)
            End If

        ElseIf FormViewReview.CurrentMode = FormViewMode.Edit Then
            SqlDataSourceFinalize.UpdateParameters("abstractID").DefaultValue = FormViewReview.DataKey(0)
            SqlDataSourceFinalize.Update()
            Dim sURL As String = "~/Admin/AbstractOverviewEditor"
            Response.Redirect(sURL, True)
        End If

        'Redirect to Review overview

        'Else
        'lblFinalize.Visible = True
        'lblFinalize.Text = "You must select a session topic."
        'End If

    End Sub


    Protected Sub AdminReview_GetDataSource()
        'FormViewSessionReview.Visible = False
        FormViewReview.DataSourceID = "SqlDataSourceReview"
        SqlDataSourceReview.DataBind()
        FormViewReview.DataBind()

        If FormViewReview.DataItemCount = 0 Then
            FormViewReview.DataSourceID = "SqlDataSourceSessionReview"
            SqlDataSourceSessionReview.DataBind()
            FormViewReview.DataBind()
        End If

    End Sub



    Protected Sub AdminReviewEdit_Click(sender As Object, e As System.EventArgs)
        'FormViewSessionReview.Visible = False

        FormViewReview.DataSourceID = "SqlDataSourceReview"
        SqlDataSourceReview.DataBind()
        FormViewReview.DataBind()
        lblFinalize.Visible = False
        lblFinalize.Text = ""

        If FormViewReview.DataItemCount = 0 Then
            FormViewReview.DataSourceID = "SqlDataSourceSessionReview"
            SqlDataSourceSessionReview.DataBind()
            FormViewReview.DataBind()
        End If
        FormViewReview.ChangeMode(FormViewMode.Edit)

    End Sub






    Protected Sub DeclineCheckBox_CheckedChanged(sender As Object, e As System.EventArgs) 'Handles DeclineCheckBox.CheckedChanged
        Dim chkSelTopic As DropDownList = FormViewReview.FindControl("ddlTopic")
        Dim reqTopicValidator As RequiredFieldValidator = FormViewReview.FindControl("TopicValidator")
        Dim chkSelSession As DropDownList = FormViewReview.FindControl("ddlSession")
        Dim reqSessionValidator As RequiredFieldValidator = FormViewReview.FindControl("SessionValidator")
        Dim chkSelFormat As DropDownList = FormViewReview.FindControl("ddlFormat")
        Dim reqFormatValidator As RequiredFieldValidator = FormViewReview.FindControl("FormatValidator")
        Dim chkComments As TextBox = FormViewReview.FindControl("CommentsTextBox")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim txtDeclineReason As TextBox = FormViewReview.FindControl("DeclineTextBox")
        Dim reqDeclineValidator As RequiredFieldValidator = FormViewReview.FindControl("DeclineValidator")


        If chkDecline.Checked = True Then
            chkSelTopic.SelectedIndex = -1
            reqTopicValidator.Enabled = False
            chkSelSession.SelectedIndex = -1
            reqSessionValidator.Enabled = False
            chkSelFormat.SelectedIndex = -1
            reqFormatValidator.Enabled = False
            chkComments.Text = ""
            FormViewReview.FindControl("CommentDeclineLabel").Visible = True
            FormViewReview.FindControl("DeclineTextBox").Visible = True
            reqDeclineValidator.Enabled = True
        Else
            FormViewReview.FindControl("CommentDeclineLabel").Visible = False
            FormViewReview.FindControl("DeclineTextBox").Visible = False
            txtDeclineReason.Text = ""
            reqTopicValidator.Enabled = True
            reqSessionValidator.Enabled = True
            reqFormatValidator.Enabled = True
            reqDeclineValidator.Enabled = False
        End If

    End Sub


    'Program Chair Admin Review Code - Added by A.Mann on 9/30/2015
    Protected Sub ButtonUnfinalize1_Click(sender As Object, e As System.EventArgs)
        UpdatePanelProgramChair.Visible = True
        ButtonUnfinalize1.Visible = False
    End Sub

    Protected Sub ddlTopicProgramChairs_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlTopic As DropDownList = ProgramChairFormReview.FindControl("ddlTopic")
        Dim ddlSession As DropDownList = ProgramChairFormReview.FindControl("ddlSession")

        If ddlTopic.SelectedIndex <> 0 Then

            SqlDataSourceProgramChairReviews.InsertParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedIndex
            'ddlSession.Enabled = True

            ddlSession.Items.Clear()
            Dim liSelectOne As New ListItem("")
            ddlSession.Items.Insert(0, liSelectOne)
            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            ddlSession.DataBind()

        Else
            'ddlSession.Enabled = False
        End If

    End Sub

    Protected Sub ProgramChairInsertButton_Click(sender As Object, e As System.EventArgs)

        Dim RelatedAbstracts As TextBox = ProgramChairFormReview.FindControl("RelatedAbstractsTextBox")
        Dim ddlTopic As DropDownList = ProgramChairFormReview.FindControl("ddlTopic")
        Dim ddlSession As DropDownList = ProgramChairFormReview.FindControl("ddlSession")
        Dim Comments As TextBox = ProgramChairFormReview.FindControl("CommentsTextBox")
        Dim chkDecline As CheckBox = ProgramChairFormReview.FindControl("DeclineCheckBox")

        SqlDataSourceUnfinalize.UpdateParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
        SqlDataSourceUnfinalize.UpdateParameters("ReviewType").DefaultValue = 1
        SqlDataSourceUnfinalize.Update()

        SqlDataSourceProgramChairReviews.InsertParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
        SqlDataSourceProgramChairReviews.InsertParameters("PersonID").DefaultValue = Session("PersonID")
        SqlDataSourceProgramChairReviews.InsertParameters("RelatedAbstracts").DefaultValue = RelatedAbstracts.Text
        SqlDataSourceProgramChairReviews.InsertParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
        SqlDataSourceProgramChairReviews.InsertParameters("SessionID").DefaultValue = ddlSession.SelectedValue
        If chkDecline.Checked = True Then
            SqlDataSourceProgramChairReviews.InsertParameters("Decline").DefaultValue = True
        Else
            SqlDataSourceProgramChairReviews.InsertParameters("Decline").DefaultValue = False
        End If
        SqlDataSourceProgramChairReviews.InsertParameters("Comments").DefaultValue = Comments.Text
        SqlDataSourceProgramChairReviews.Insert()

        SqlDataSourceProgramChairReviews.SelectParameters("abstractID").DefaultValue = Page.RouteData.Values("abstractid")
        SqlDataSourceProgramChairReviews.DataBind()
        gvProgramChairReviews.DataBind()
        UpdatePanelProgramChair.Visible = False
        ButtonUnfinalize1.Visible = True

    End Sub

    Protected Sub ProgramChairCancelButton_Click(sender As Object, e As System.EventArgs)
        UpdatePanelProgramChair.Visible = False
        ButtonUnfinalize1.Visible = True
    End Sub

    Protected Sub ProgramChairFormReview_DataBound(sender As Object, e As EventArgs) Handles ProgramChairFormReview.DataBound
        If ProgramChairFormReview.DataItemCount > 0 Then 'has data
            If ProgramChairFormReview.CurrentMode <> FormViewMode.Insert Then
                ProgramChairFormReview.ChangeMode(FormViewMode.Insert)
            End If
        End If
        If ProgramChairFormReview.CurrentMode = FormViewMode.Insert Then

            Dim ddlSession As DropDownList = ProgramChairFormReview.FindControl("ddlSession")
            Dim ddlTopic As DropDownList = ProgramChairFormReview.FindControl("ddlTopic")
            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            ddlSession.DataBind()

            Dim dvProfile As DataView = SqlDataSourceProgramChairReviews.Select(DataSourceSelectArguments.Empty)
            Dim drProfile As DataRow = dvProfile.Table.Rows(0)

            If drProfile("SessionID").ToString() = "" Then
                ddlSession.SelectedIndex = 0
            Else
                ddlSession.SelectedValue = drProfile("SessionID").ToString()
            End If

        End If

    End Sub


    'Steering Committee Admin Review Code - Added by A.Mann on 9/30/2015
    Protected Sub ButtonUnfinalize2_Click(sender As Object, e As System.EventArgs)
        UpdatePanelSteeringCommittee.Visible = True
        ButtonUnfinalize2.Visible = False
    End Sub

    Protected Sub ddlSession_SteeringCommitteeChanged(sender As Object, e As System.EventArgs)
        Dim chckSelTopic As DropDownList = SteeringCommitteeFormReview.FindControl("ddlSession")
        Dim chkDecline As CheckBox = SteeringCommitteeFormReview.FindControl("DeclineCheckBox")
        Dim chkComments As TextBox = SteeringCommitteeFormReview.FindControl("CommentsTextBox")
        Dim chkRequired As RequiredFieldValidator = SteeringCommitteeFormReview.FindControl("RequiredFieldValidator1")

        'If chckSelTopic.SelectedIndex > -1 Then
        chkDecline.Checked = False
        SteeringCommitteeFormReview.FindControl("CommentDeclineLabel").Visible = False
        chkComments.Visible = False
        chkComments.Text = ""
        chkRequired.Enabled = False
        'End If

    End Sub


    Protected Sub ddlTopicSteeringCommittee_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlTopic As DropDownList = SteeringCommitteeFormReview.FindControl("ddlTopic")
        Dim ddlSession As DropDownList = SteeringCommitteeFormReview.FindControl("ddlSession")
        Dim chckSelTopic As DropDownList = SteeringCommitteeFormReview.FindControl("ddlSession")
        Dim chkDecline As CheckBox = SteeringCommitteeFormReview.FindControl("DeclineCheckBox")
        Dim chkComments As TextBox = SteeringCommitteeFormReview.FindControl("CommentsTextBox")
        Dim chkRequired As RequiredFieldValidator = SteeringCommitteeFormReview.FindControl("RequiredFieldValidator1")

        If ddlTopic.SelectedIndex <> 0 Then

            SqlDataSourceCommitteeReviews.InsertParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedIndex
            'ddlSession.Enabled = True

            ddlSession.Items.Clear()
            Dim liSelectOne As New ListItem("")
            ddlSession.Items.Insert(0, liSelectOne)
            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            ddlSession.DataBind()

            chkDecline.Checked = False
            SteeringCommitteeFormReview.FindControl("CommentDeclineLabel").Visible = False
            chkComments.Visible = False
            chkComments.Text = ""
            chkRequired.Enabled = False

        Else
            'ddlSession.Enabled = False
        End If

    End Sub



    Protected Sub SteeringCommitteeCancelButton_Click(sender As Object, e As System.EventArgs)
        UpdatePanelSteeringCommittee.Visible = False
        ButtonUnfinalize2.Visible = True
    End Sub

    Protected Sub CustomValidator1_SteeringCommitteeServerValidate(sender As Object, e As ServerValidateEventArgs)
        Dim chkDecline As CheckBox = SteeringCommitteeFormReview.FindControl("DeclineCheckBox")
        Dim chkComments As TextBox = SteeringCommitteeFormReview.FindControl("CommentsTextBox")
        Dim chkRequired As RequiredFieldValidator = SteeringCommitteeFormReview.FindControl("RequiredFieldValidator1")

        If chkComments.Text.Trim.Length > 0 Then
            e.IsValid = chkDecline.Checked
            chkRequired.Enabled = True
        End If

        If chkDecline.Checked = True And chkComments.Text.Trim.Length = 0 Then
            chkRequired.Enabled = True
            chkRequired.ErrorMessage = "Please provide comments."
        Else
            chkRequired.Enabled = False
        End If
    End Sub

    Protected Sub DeclineCheckBox_SteeringCommitteeCheckedChanged(sender As Object, e As EventArgs)
        Dim chkDecline As CheckBox = SteeringCommitteeFormReview.FindControl("DeclineCheckBox")
        Dim chkRequired As RequiredFieldValidator = SteeringCommitteeFormReview.FindControl("RequiredFieldValidator1")
        Dim chkComments As TextBox = SteeringCommitteeFormReview.FindControl("CommentsTextBox")
        Dim chkSelTopic As DropDownList = SteeringCommitteeFormReview.FindControl("ddlSession")

        If chkDecline.Checked = True Then
            chkSelTopic.SelectedIndex = -1
            SteeringCommitteeFormReview.FindControl("CommentDeclineLabel").Visible = True
            SteeringCommitteeFormReview.FindControl("CommentsTextBox").Visible = True
            chkRequired.Enabled = True
        Else
            SteeringCommitteeFormReview.FindControl("CommentDeclineLabel").Visible = False
            chkComments.Visible = False
            chkComments.Text = ""
            chkRequired.Enabled = False
        End If

    End Sub

    Protected Sub SteeringCommitteeInsertButton_Click(sender As Object, e As System.EventArgs)

        Dim RelatedAbstracts As TextBox = SteeringCommitteeFormReview.FindControl("RelatedAbstractsTextBox")
        Dim ddlSession As DropDownList = SteeringCommitteeFormReview.FindControl("ddlSession")
        Dim ddlTopic As DropDownList = SteeringCommitteeFormReview.FindControl("ddlTopic")
        Dim GeneralComments As TextBox = SteeringCommitteeFormReview.FindControl("GeneralCommentsTextBox")
        Dim chkDecline As CheckBox = SteeringCommitteeFormReview.FindControl("DeclineCheckBox")
        Dim Comments As TextBox = SteeringCommitteeFormReview.FindControl("CommentsTextBox")

        SqlDataSourceUnfinalize.UpdateParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
        SqlDataSourceUnfinalize.UpdateParameters("ReviewType").DefaultValue = 2
        SqlDataSourceUnfinalize.Update()

        SqlDataSourceCommitteeReviews.InsertParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
        SqlDataSourceCommitteeReviews.InsertParameters("PersonID").DefaultValue = Session("PersonID")
        SqlDataSourceCommitteeReviews.InsertParameters("RelatedAbstracts").DefaultValue = RelatedAbstracts.Text
        SqlDataSourceCommitteeReviews.InsertParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
        SqlDataSourceCommitteeReviews.InsertParameters("SessionID").DefaultValue = ddlSession.SelectedValue
        SqlDataSourceCommitteeReviews.InsertParameters("Comments").DefaultValue = Comments.Text

        If chkDecline.Checked = True Then
            SqlDataSourceCommitteeReviews.InsertParameters("Decline").DefaultValue = True
        Else
            SqlDataSourceCommitteeReviews.InsertParameters("Decline").DefaultValue = False
        End If
        SqlDataSourceCommitteeReviews.InsertParameters("GeneralComments").DefaultValue = GeneralComments.Text


        SqlDataSourceCommitteeReviews.Insert()

        SqlDataSourceCommitteeReviews.SelectParameters("abstractID").DefaultValue = Page.RouteData.Values("abstractid")
        SqlDataSourceCommitteeReviews.DataBind()
        gvCommitteeReviews.DataBind()
        UpdatePanelSteeringCommittee.Visible = False
        ButtonUnfinalize2.Visible = True

    End Sub

    Protected Sub ButtonUnfinalize3_Click(sender As Object, e As System.EventArgs)
        UpdatePanelSessionChair.Visible = True
        ButtonUnfinalize3.Visible = False
    End Sub

    'Protected Sub ddlSession_SessionChairChanged(sender As Object, e As System.EventArgs)
    '    Dim chckSelTopic As DropDownList = SessionChairFormReview.FindControl("SessionChairddlSession")
    '    Dim chkDecline As CheckBox = SessionChairFormReview.FindControl("SessionChairDeclineCheckBox")
    '    Dim chkComments As TextBox = SessionChairFormReview.FindControl("SessionChairCommentsTextBox")
    '    Dim chkRequired As RequiredFieldValidator = SessionChairFormReview.FindControl("SessionChairRequiredFieldValidator1")

    '    'If chckSelTopic.SelectedIndex > -1 Then
    '    chkDecline.Checked = False
    '    SessionChairFormReview.FindControl("SessionChairCommentDeclineLabel").Visible = False
    '    chkComments.Visible = False
    '    chkComments.Text = ""
    '    chkRequired.Enabled = False
    '    'End If

    'End Sub


    'Protected Sub ddlTopicSessionChair_SelectedIndexChanged(sender As Object, e As EventArgs)
    '    Dim ddlTopic As DropDownList = SessionChairFormReview.FindControl("ddlSessionChairTopic")
    '    Dim ddlSession As DropDownList = SessionChairFormReview.FindControl("ddlSessionChairSession")
    '    Dim chckSelTopic As DropDownList = SessionChairFormReview.FindControl("ddlSessionChairSession")
    '    Dim chkDecline As CheckBox = SessionChairFormReview.FindControl("SessionChairDeclineCheckBox")
    '    Dim chkComments As TextBox = SessionChairFormReview.FindControl("SessionChairCommentsTextBox")
    '    Dim chkRequired As RequiredFieldValidator = SessionChairFormReview.FindControl("SessionChairRequiredFieldValidator1")

    '    If ddlTopic.SelectedIndex <> 0 Then

    '        SqlDataSourceSessionChairReviews.InsertParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedIndex
    '        'ddlSession.Enabled = True

    '        ddlSession.Items.Clear()
    '        Dim liSelectOne As New ListItem("")
    '        ddlSession.Items.Insert(0, liSelectOne)
    '        SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
    '        SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
    '        ddlSession.DataBind()

    '        chkDecline.Checked = False
    '        SessionChairFormReview.FindControl("SessionChairCommentDeclineLabel").Visible = False
    '        chkComments.Visible = False
    '        chkComments.Text = ""
    '        chkRequired.Enabled = False

    '    Else
    '        'ddlSession.Enabled = False
    '    End If

    'End Sub

    Protected Sub SessionChairCancelButton_Click(sender As Object, e As System.EventArgs)
        UpdatePanelSessionChair.Visible = False
        ButtonUnfinalize3.Visible = True
    End Sub

    Protected Sub CustomValidator1_SessionChairServerValidate(sender As Object, e As ServerValidateEventArgs)
        Dim chkDecline As CheckBox = SessionChairFormReview.FindControl("SessionChairDeclineCheckBox")
        Dim chkComments As TextBox = SessionChairFormReview.FindControl("SessionChairCommentsTextBox")
        Dim chkRequired As RequiredFieldValidator = SessionChairFormReview.FindControl("SessionChairRequiredFieldValidator1")

        If chkComments.Text.Trim.Length > 0 Then
            e.IsValid = chkDecline.Checked
            chkRequired.Enabled = True
        End If

        If chkDecline.Checked = True And chkComments.Text.Trim.Length = 0 Then
            chkRequired.Enabled = True
            chkRequired.ErrorMessage = "Please provide comments."
        Else
            chkRequired.Enabled = False
        End If
    End Sub

    Protected Sub DeclineCheckBox_SessionChairCheckedChanged(sender As Object, e As EventArgs)
        Dim chkDecline As CheckBox = SessionChairFormReview.FindControl("SessionChairDeclineCheckBox")
        Dim chkRequired As RequiredFieldValidator = SessionChairFormReview.FindControl("SessionChairRequiredFieldValidator1")
        Dim chkComments As TextBox = SessionChairFormReview.FindControl("SessionChairGeneralCommentsTextBox")
        'Dim chkSelTopic As DropDownList = SessionChairFormReview.FindControl("ddlSessionChairSession")

        If chkDecline.Checked = True Then
            'chkSelTopic.SelectedIndex = -1
            SessionChairFormReview.FindControl("SessionChairCommentDeclineLabel").Visible = True
            SessionChairFormReview.FindControl("SessionChairCommentsTextBox").Visible = True
            chkRequired.Enabled = True
        Else
            SessionChairFormReview.FindControl("SessionChairCommentDeclineLabel").Visible = False
            chkComments.Visible = False
            chkComments.Text = ""
            chkRequired.Enabled = False
        End If
    End Sub

    Protected Sub SessionChairInsertButton_Click(sender As Object, e As System.EventArgs)

        Dim ddlPresentationFormat As DropDownList = SessionChairFormReview.FindControl("ddlSessionChairPresentationFormat")
        'Dim ddlSession As DropDownList = SessionChairFormReview.FindControl("ddlSessionChairSession")
        'Dim ddlTopic As DropDownList = SessionChairFormReview.FindControl("ddlSessionChairTopic")
        Dim GeneralComments As TextBox = SessionChairFormReview.FindControl("SessionChairGeneralCommentsTextBox")
        Dim chkDecline As CheckBox = SessionChairFormReview.FindControl("SessionChairDeclineCheckBox")
        Dim Comments As TextBox = SessionChairFormReview.FindControl("SessionChairCommentsTextBox")

        SqlDataSourceUnfinalize.UpdateParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
        SqlDataSourceUnfinalize.UpdateParameters("ReviewType").DefaultValue = 3
        SqlDataSourceUnfinalize.Update()

        SqlDataSourceSessionChairReviews.InsertParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
        SqlDataSourceSessionChairReviews.InsertParameters("PersonID").DefaultValue = Session("PersonID")
        'SqlDataSourceCommitteeReviews.InsertParameters("RelatedAbstracts").DefaultValue = RelatedAbstracts.Text
        'SqlDataSourceSessionChairReviews.InsertParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
        'SqlDataSourceSessionChairReviews.InsertParameters("SessionID").DefaultValue = ddlSession.SelectedValue
        SqlDataSourceSessionChairReviews.InsertParameters("Comments").DefaultValue = Comments.Text

        If chkDecline.Checked = True Then
            SqlDataSourceSessionChairReviews.InsertParameters("Decline").DefaultValue = True
        Else
            SqlDataSourceSessionChairReviews.InsertParameters("Decline").DefaultValue = False
        End If


        SqlDataSourceSessionChairReviews.InsertParameters("GeneralComments").DefaultValue = GeneralComments.Text
        SqlDataSourceSessionChairReviews.Insert()

        SqlDataSourceSessionChairReviews.SelectParameters("abstractID").DefaultValue = Page.RouteData.Values("abstractid")
        SqlDataSourceSessionChairReviews.DataBind()
        gvSessionChairReviews.DataBind()
        UpdatePanelSessionChair.Visible = False
        ButtonUnfinalize3.Visible = True

    End Sub

End Class