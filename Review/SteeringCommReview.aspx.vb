Imports System.Web.Routing
Imports System.Net.Mail

Public Class SteeringCommReview
    Inherits System.Web.UI.Page

    Dim ConferenceControl As New ConferenceFromURL
    Dim Searched As Boolean = False
    Dim sConferenceType As String

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        sConferenceType = ConferenceControl.ConferenceType
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then

            lblConferenceType.Text = ConferenceControl.ConferenceShortName
            lnkReturn.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/steeringcomm"
            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = Page.RouteData.Values("theme")


        End If
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then

            'SqlDataSourceFinalized.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        Else
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
        If Not Session("SteeringCommittee") Is Nothing Then
            SqlDataSourceTopicGroup.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

            SqlDataSourceProgramChairReviews.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceAbstractSelected.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceReview.UpdateParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.UpdateParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceReview.InsertParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceReview.InsertParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceOtherReviews.SelectParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceOtherReviews.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceSearch.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

        Else
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
    End Sub

    Protected Sub SqlDataSourceReview_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceReview.Selected

        Dim hdnAbstractTypeID As HiddenField = FormView1.FindControl("hdnAbstractTypeID")

        'If abstract is locked from editing by all steering committee staff, hide review form
        If hdnAbstractTypeID.Value.ToString.Contains("2") Then

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

    Protected Sub update_Click(sender As Object, e As EventArgs)
        'Page.Response.Redirect(Page.Request.Url.ToString(), True)
    End Sub

    Protected Sub btnFinalize_Click(sender As Object, e As EventArgs) Handles btnFinalize.Click
        Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim hdnTopicGroup As HiddenField = FormViewReview.FindControl("hdnTopicGroup")

        Dim bFinalize As Boolean = True
        If ddlSession.SelectedIndex = 0 Then 'No selection
            If chkDecline.Checked = False Then 'Not declined
                bFinalize = False
            End If
        End If
        If ddlSession.SelectedIndex <> 0 Then 'selection made
            If chkDecline.Checked = True Then 'declined
                bFinalize = False
                Me.lblFinalize.Text = "You must only select Decline OR a Topic.<br />"
            End If
        End If
        If bFinalize = True Then

            SqlDataSourceFinalize.UpdateParameters("AbstractReviewID").DefaultValue = FormViewReview.DataKey(0)
            SqlDataSourceFinalize.UpdateParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceFinalize.UpdateParameters("Decline").DefaultValue = chkDecline.Checked
            SqlDataSourceFinalize.UpdateParameters("SessionID").DefaultValue = ddlSession.SelectedValue
            SqlDataSourceFinalize.Update()
            'Redirect to Review overview
            Dim sURL As String = "~/" & ConferenceControl.ConferenceURLString & "/review/steeringcomm"
            Response.Redirect(sURL, True)
        Else
            lblFinalize.Visible = True
        End If

    End Sub

    Protected Sub FormViewReview_ModeChanged(sender As Object, e As EventArgs) Handles FormViewReview.ModeChanged
        Progress.Visible = False
    End Sub

    Protected Sub FormViewReview_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormViewReview.ItemUpdated
        gvOtherReviews.DataBind()
        ShowFinalize()
    End Sub

    Protected Sub FormViewReview_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles FormViewReview.ItemInserted
        gvOtherReviews.DataBind()
        ShowFinalize()
    End Sub

    Protected Sub FormViewReview_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormViewReview.ItemUpdating
        Progress.Visible = True
        Success.Visible = True
        Success.Text = "Review successfully updated"
    End Sub

    Protected Sub FormViewReview_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles FormViewReview.ItemInserting
        Progress.Visible = True
        Success.Visible = True
        Success.Text = "Review successfully recorded"
    End Sub

    Protected Sub FormViewReview_DataBound(sender As Object, e As EventArgs) Handles FormViewReview.DataBound
        If FormViewReview.CurrentMode = FormViewMode.Insert Then
            Dim hdnTopicGroup As HiddenField = CType(FormViewReview.FindControl("hdnTopicGroup"), HiddenField)
            hdnTopicGroup.Value = Page.RouteData.Values("theme")
        End If
        If FormViewReview.CurrentMode <> FormViewMode.ReadOnly Then
            Dim ltlConferenceType As Literal = CType(FormViewReview.FindControl("ltlConferenceType"), Literal)
            ltlConferenceType.Text = ConferenceControl.ConferenceType
        End If
    End Sub

    Protected Sub ShowFinalize()
        If Session("SteeringCommittee") = "2" Then
            PanelFinalize.Visible = True
        End If
    End Sub


    Protected Sub CustomValidator1_ServerValidate(sender As Object, e As ServerValidateEventArgs)
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim chkComments As TextBox = FormViewReview.FindControl("CommentsTextBox")
        'Dim chkRequired As RequiredFieldValidator = FormViewReview.FindControl("RequiredFieldValidator1")

        If chkComments.Text.Trim.Length > 0 Then
            e.IsValid = chkDecline.Checked
            'chkRequired.Enabled = True
        End If

        If chkDecline.Checked = True And chkComments.Text.Trim.Length = 0 Then
            'chkRequired.Enabled = True
            'chkRequired.ErrorMessage = "Please provide comments."
        Else
            'chkRequired.Enabled = False
        End If
    End Sub



    Protected Sub DeclineCheckBox_CheckedChanged(sender As Object, e As EventArgs) 'Handles DeclineCheckBox.CheckedChanged
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim chkRequired As RequiredFieldValidator = FormViewReview.FindControl("DeclineCommentsValidator")
        Dim chkComments As TextBox = FormViewReview.FindControl("CommentsTextBox")
        Dim chkSelTopic As DropDownList = FormViewReview.FindControl("ddlSession")

        If chkDecline.Checked = True Then
            chkSelTopic.SelectedIndex = -1
            chkRequired.Enabled = True
        Else
            chkRequired.Enabled = False
        End If

    End Sub


    Protected Sub ddlSession_Changed(sender As Object, e As System.EventArgs) 'Handles ddlSession.SelectedIndexChanged
        Dim chckSelTopic As DropDownList = FormViewReview.FindControl("ddlSession")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim chkComments As TextBox = FormViewReview.FindControl("CommentsTextBox")
        'Dim chkRequired As RequiredFieldValidator = FormViewReview.FindControl("RequiredFieldValidator1")
        Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
        'If chckSelTopic.SelectedIndex > -1 Then
        chkDecline.Checked = False
        'FormViewReview.FindControl("CommentDeclineLabel").Visible = False
        'chkComments.Visible = False
        'chkComments.Text = ""
        'chkRequired.Enabled = False
        'End If

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