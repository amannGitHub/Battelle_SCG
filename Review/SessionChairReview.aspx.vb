Imports System.Web.Routing
Public Class SessionChairReview
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL
    Dim Searched As Boolean = False
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit

        '/* 
        'Why does this need to be here? Duplicating it in Page Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then

            lblConferenceType.Text = ConferenceControl.ConferenceShortName
            lnkReturn.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/sessionchair"

        End If
        If ConferenceControl.ConferenceID = 2 Or ConferenceControl.ConferenceID = 5 Then
            Dim lbl1 As Label = FormViewReview.FindControl("lblConf")
            Dim lbl2 As Label = FormViewReview.FindControl("lblConf2")
            lbl1.Text = "Symposium"
            lbl2.Text = "Symposium"
        End If
        '/*




        'If Not Session("SessionChair") Is Nothing Then
        SqlDataSourceTopicGroup.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID


            SqlDataSourceAbstractSelected.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceReview.UpdateParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.UpdateParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceReview.InsertParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.InsertParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceOtherReviews.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceOtherReviews.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        'SqlDataSourceSearch.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        ' Else
        ''Redirect to dashboard
        ' Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        'End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'This is lame, but for some reason removing this part from PreInit caused the Parameter assignments to break, so we decided to leave it in. But it doesn't work up there, so we just do it again here. And yes, we feel dirty.
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then

            lblConferenceType.Text = ConferenceControl.ConferenceShortName
            lnkReturn.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/sessionchair"

        End If

        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then

            'SqlDataSourceFinalized.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        Else
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If

        If ConferenceControl.ConferenceID = 2 Or ConferenceControl.ConferenceID = 5 Then
            Dim lbl1 As Label = FormViewReview.FindControl("lblConf")
            Dim lbl2 As Label = FormViewReview.FindControl("lblConf2")
            lbl1.Text = "Symposium"
            lbl2.Text = "Symposium"
        End If

        If Session("SessionChair") Is Nothing Then
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
    End Sub

    Protected Sub SqlDataSourceReview_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceReview.Selected

        Dim hdnAbstractTypeID As HiddenField = FormView1.FindControl("hdnAbstractTypeID")

        'If abstract is locked from editing by all session chair staff, hide review form
        If hdnAbstractTypeID.Value.ToString.Contains("3") Then

            PanelLock.Visible = False
            PanelLockMessage.Text = "Abstract Locked, no further edits can be made. If you need assistance please contact either Sarah Phipps or Gina Melaragno."
            PanelLockMessage.Visible = True
            FormViewReview.ChangeMode(FormViewMode.ReadOnly)
        Else
            PanelLock.Visible = True
            PanelLockMessage.Visible = False

            'Check for value
            If e.AffectedRows > 0 Then
                'Data found, set to Read Only
                If FormViewReview.CurrentMode <> FormViewMode.Edit Then
                    FormViewReview.ChangeMode(FormViewMode.Edit)
                End If
                ShowFinalize()
            Else
                'No data
                FormViewReview.ChangeMode(FormViewMode.Insert)
            End If

        End If

    End Sub


    Protected Sub btnFinalize_Click(sender As Object, e As EventArgs) Handles btnFinalize.Click
        Dim ddlFormat As DropDownList = FormViewReview.FindControl("ddlFormat")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim bFinalize As Boolean = True
        If ddlFormat.SelectedIndex = 0 Then 'No selection
            If chkDecline.Checked = False Then 'Not declined
                bFinalize = False
            End If
        End If
        If ddlFormat.SelectedIndex <> 0 Then 'selection made
            If chkDecline.Checked = True Then 'declined
                bFinalize = False
                Me.lblFinalize.Text = "You must only select Decline OR a Platform.<br />"
            End If
        End If
        If bFinalize = True Then
            SqlDataSourceFinalize.UpdateParameters("AbstractReviewID").DefaultValue = FormViewReview.DataKey(0)
            SqlDataSourceFinalize.Update()
            'Redirect to Review overview
            Dim sURL As String = "~/" & ConferenceControl.ConferenceURLString & "/review/sessionchair"
            Response.Redirect(sURL, True)
        Else
            lblFinalize.Visible = True
        End If

    End Sub


    Protected Sub FormViewReview_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormViewReview.ItemUpdated
        gvOtherReviews.DataBind()
        ShowFinalize()
    End Sub

    Protected Sub FormViewReview_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles FormViewReview.ItemInserted
        gvOtherReviews.DataBind()
        ShowFinalize()
    End Sub

    Protected Sub FormViewReview_DataBound(sender As Object, e As EventArgs) Handles FormViewReview.DataBound
        If FormViewReview.CurrentMode = FormViewMode.Insert Then
            'Dim hdnTopicGroup As HiddenField = CType(FormViewReview.FindControl("hdnTopicGroup"), HiddenField)
            'hdnTopicGroup.Value = Page.RouteData.Values("theme")
            Dim hdnSessionID As HiddenField = CType(FormViewReview.FindControl("hdnSessionID"), HiddenField)
            hdnSessionID.Value = Page.RouteData.Values("topic")
        Else
            Dim ddlSelFormat As DropDownList = FormViewReview.FindControl("ddlFormat")
            Dim chkAccept As CheckBox = FormViewReview.FindControl("AcceptAbstractCheckBox")
            Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
            Dim txtComments As TextBox = FormViewReview.FindControl("CommentsTextBox")
            Dim lblCommentsLabel As Label = FormViewReview.FindControl("CommentDeclineLabel")
            Dim PanelAccept As Panel = FormViewReview.FindControl("PanelAccept")
            If ddlSelFormat.SelectedIndex <> 0 Then
                chkAccept.Checked = True
                txtComments.Visible = False
                lblCommentsLabel.Visible = False
                FormViewReview.FindControl("declineReasons").Visible = False
                PanelAccept.Visible = True
            End If

            If chkDecline.Checked = True Then
                txtComments.Visible = True
                lblCommentsLabel.Visible = True
                FormViewReview.FindControl("declineReasons").Visible = True
            End If

        End If
    End Sub

    Protected Sub ShowFinalize()
        'If Session("SessionChair") = "2" Then
        PanelFinalize.Visible = True
        'End If
    End Sub

    Protected Sub FormViewReview_ModeChanged(sender As Object, e As EventArgs) Handles FormViewReview.ModeChanged
        Progress.Visible = False
    End Sub

    Protected Sub FormViewReview_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormViewReview.ItemUpdating
        Progress.Visible = True
        Success.Visible = True
        Success.Text = "Review successfully updated"
        Dim chkAccept As CheckBox = FormViewReview.FindControl("AcceptAbstractCheckBox")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim CoChairCommentsTextBox As TextBox = FormViewReview.FindControl("CoChairCommentsTextBox")
        Dim CommentsTextBox As TextBox = FormViewReview.FindControl("CommentsTextBox")
        If chkAccept.Checked = True Then
            SqlDataSourceReview.UpdateParameters("Comments").DefaultValue = CoChairCommentsTextBox.Text
        End If
        If chkDecline.Checked = True Then
            SqlDataSourceReview.UpdateParameters("Comments").DefaultValue = CommentsTextBox.Text
        End If
    End Sub

    Protected Sub FormViewReview_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles FormViewReview.ItemInserting
        Dim DeclineComments As TextBox = FormViewReview.FindControl("CommentsTextBox")
        Dim AcceptComments As TextBox = FormViewReview.FindControl("CommentsTextBox")
        Progress.Visible = True
        Success.Visible = True
        Success.Text = "Review successfully recorded"
        Dim chkAccept As CheckBox = FormViewReview.FindControl("AcceptAbstractCheckBox")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim CoChairCommentsTextBox As TextBox = FormViewReview.FindControl("CoChairCommentsTextBox")
        Dim CommentsTextBox As TextBox = FormViewReview.FindControl("CommentsTextBox")
        If chkAccept.Checked = True Then
            SqlDataSourceReview.InsertParameters("Comments").DefaultValue = CoChairCommentsTextBox.Text
        End If
        If chkDecline.Checked = True Then
            SqlDataSourceReview.InsertParameters("Comments").DefaultValue = CommentsTextBox.Text
        End If
    End Sub

    Protected Sub CustomValidator1_ServerValidate(sender As Object, e As ServerValidateEventArgs)
        Dim chkAccept As CheckBox = FormViewReview.FindControl("AcceptAbstractCheckBox")
        Dim chkSelFormat As DropDownList = FormViewReview.FindControl("ddlFormat")
        Dim chkCustomValidation As CustomValidator = FormViewReview.FindControl("CustomValidator1")

        If chkSelFormat.SelectedIndex > 0 And chkAccept.Checked = False Then
            e.IsValid = False
            chkCustomValidation.ErrorMessage = "The 'Accept this abstract as a presentation in this session' checkbox must be selected when a format is selected."
        ElseIf chkAccept.Checked = True And chkSelFormat.SelectedIndex <= 0 Then
            e.IsValid = False
            chkCustomValidation.ErrorMessage = "Please assign a format."
        Else
            e.IsValid = True
            chkCustomValidation.ErrorMessage = ""
        End If

    End Sub


    Protected Sub AcceptAbstractCheckBox_CheckedChanged(sender As Object, e As System.EventArgs) 'Handles AcceptAbstractCheckBox.CheckedChanged
        Dim chkSelFormat As DropDownList = FormViewReview.FindControl("ddlFormat")
        Dim chkAccept As CheckBox = FormViewReview.FindControl("AcceptAbstractCheckBox")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim chkComments As TextBox = FormViewReview.FindControl("CommentsTextBox")
        Dim chkRequired As RequiredFieldValidator = FormViewReview.FindControl("RequiredFieldValidator1")
        Dim chkCustomRequired As CustomValidator = FormViewReview.FindControl("CustomValidator1")
        Dim PanelAccept As Panel = FormViewReview.FindControl("PanelAccept")
        Dim CoChairCommentsTextBox As TextBox = FormViewReview.FindControl("CoChairCommentsTextBox")



        If chkAccept.Checked = True Then
            CoChairCommentsTextBox.Enabled = True
            chkDecline.Checked = False
            FormViewReview.FindControl("CommentDeclineLabel").Visible = False
            FormViewReview.FindControl("declineReasons").Visible = False
            chkComments.Enabled = False
            chkComments.Visible = False
            chkComments.Text = ""
            chkRequired.Enabled = False
            PanelAccept.Visible = True
        Else
            PanelAccept.Visible = False
            CoChairCommentsTextBox.Enabled = False
            chkComments.Enabled = True
        End If

    End Sub


    Protected Sub DeclineCheckBox_CheckedChanged(sender As Object, e As System.EventArgs) 'Handles DeclineCheckBox.CheckedChanged
        Dim chkSelFormat As DropDownList = FormViewReview.FindControl("ddlFormat")
        Dim chkAccept As CheckBox = FormViewReview.FindControl("AcceptAbstractCheckBox")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim chkRequired As RequiredFieldValidator = FormViewReview.FindControl("RequiredFieldValidator1")
        Dim chkComments As TextBox = FormViewReview.FindControl("CommentsTextBox")
        'Dim chkGeneralComments As TextBox = FormViewReview.FindControl("GeneralCommentsTextBox")
        Dim PanelAccept As Panel = FormViewReview.FindControl("PanelAccept")
        Dim CoChairCommentsTextBox As TextBox = FormViewReview.FindControl("CoChairCommentsTextBox")

        If chkDecline.Checked = True Then
            chkAccept.Checked = False
            chkSelFormat.SelectedIndex = -1
            'chkGeneralComments.Text = ""
            FormViewReview.FindControl("CommentDeclineLabel").Visible = True
            chkComments.Visible = True
            chkComments.Enabled = True
            CoChairCommentsTextBox.Enabled = False
            FormViewReview.FindControl("declineReasons").Visible = True
            chkRequired.Enabled = True
            PanelAccept.Visible = False
            SqlDataSourceReview.UpdateParameters("Comments").DefaultValue = chkComments.Text
            SqlDataSourceReview.InsertParameters("Comments").DefaultValue = chkComments.Text
        Else
            FormViewReview.FindControl("CommentDeclineLabel").Visible = False
            chkComments.Visible = False
            chkComments.Enabled = False
            CoChairCommentsTextBox.Enabled = True
            chkComments.Text = ""
            chkRequired.Enabled = False
            FormViewReview.FindControl("declineReasons").Visible = False
        End If

    End Sub
    Protected Sub GridViewSearch(sender As Object, e As EventArgs) Handles gvSearch.DataBound
        If Searched Then
            If gvSearch.Rows.Count > 0 Then
                PanelNoResults.Visible = False
            Else
                PanelNoResults.Visible = True
            End If
        End If
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        Searched = True
    End Sub

    Protected Sub btnHelp_Click(sender As Object, e As EventArgs)
        If pnlHelp.Visible = True Then
            pnlHelp.Visible = False
        Else
            pnlHelp.Visible = True
        End If

    End Sub


End Class