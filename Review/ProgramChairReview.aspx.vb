Imports System.Web.Routing
Public Class ProgramChairReview
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL
    Dim Searched As Boolean = False
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")

        If Not IsPostBack Then
            lblConferenceType.Text = ConferenceControl.ConferenceShortName
            lnkReturn.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/programchair"
            lnkNeedsEdits.NavigateUrl = "~/" & ConferenceControl.ConferenceURLString & "/review/programchair"
        End If
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then

            'SqlDataSourceFinalized.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        Else
            'Redirect to dashboard
            Response.Redirect("~/" & ConferenceControl.ConferenceURLString & "/review")
        End If
        If Not Session("ProgramChair") Is Nothing Then
            SqlDataSourceTopicGroup.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
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

        'If abstract is locked from editing by all program chair staff, hide review form
        If hdnAbstractTypeID.Value.ToString.Contains("1") Then

            PanelLock.Visible = False
            PanelLockMessage.Text = "Abstract Locked, no further edits can be made. If you need assistance please contact either Sarah Phipps or Gina Melaragno."
            PanelLockMessage.Visible = True
            FormViewReview.ChangeMode(FormViewMode.ReadOnly)
        Else
            PanelLock.Visible = True
            PanelLockMessage.Visible = False

        End If

    End Sub


    Protected Sub btnFinalize_Click(sender As Object, e As EventArgs) Handles btnFinalize.Click
        Dim ddlTopic As DropDownList = FormViewReview.FindControl("ddlTopic")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
        Dim bFinalize As Boolean = True
        If ddlTopic.SelectedIndex = 0 Then 'No selection
            If chkDecline.Checked = False Then 'Not declined
                bFinalize = False
            End If
        End If
        If ddlTopic.SelectedIndex <> 0 Then 'selection made
            If chkDecline.Checked = True Then 'declined
                bFinalize = False
                Me.lblFinalize.Text = "You must only select Decline OR a Theme.<br />"
            End If
        End If
        If bFinalize = True Then
            SqlDataSourceFinalize.UpdateParameters("AbstractReviewID").DefaultValue = FormViewReview.DataKey(0)
            SqlDataSourceFinalize.UpdateParameters("Decline").DefaultValue = chkDecline.Checked
            SqlDataSourceFinalize.UpdateParameters("AbstractID").DefaultValue = Page.RouteData.Values("abstractid")
            SqlDataSourceFinalize.UpdateParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
            SqlDataSourceFinalize.UpdateParameters("SessionID").DefaultValue = ddlSession.SelectedValue
            SqlDataSourceFinalize.Update()
            'Redirect to Review overview
            Dim sURL As String = "~/" & ConferenceControl.ConferenceURLString & "/review/programchair"
            Response.Redirect(sURL, True)
        Else
            lblFinalize.Visible = True
        End If




    End Sub

    Protected Sub FormViewReview_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormViewReview.ItemUpdated
        gvOtherReviews.DataBind()
        PanelFinalize.Visible = True
    End Sub

    Protected Sub FormViewReview_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles FormViewReview.ItemInserted
        gvOtherReviews.DataBind()
        PanelFinalize.Visible = True
        Progress.Visible = False
    End Sub



    Protected Sub FormViewReview_DataBound(sender As Object, e As EventArgs) Handles FormViewReview.DataBound
        If FormViewReview.DataItemCount > 0 Then 'has data
            If FormViewReview.CurrentMode <> FormViewMode.Edit Then
                FormViewReview.ChangeMode(FormViewMode.Edit)
            End If
            PanelFinalize.Visible = True
        Else
            If FormViewReview.CurrentMode <> FormViewMode.Insert Then
                FormViewReview.ChangeMode(FormViewMode.Insert)
            End If
            PanelFinalize.Visible = False
        End If
        If FormViewReview.CurrentMode = FormViewMode.Edit Then

            Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
            Dim ddlTopic As DropDownList = FormViewReview.FindControl("ddlTopic")
            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            ddlSession.DataBind()

            Dim dvProfile As DataView = SqlDataSourceReview.Select(DataSourceSelectArguments.Empty)
            Dim drProfile As DataRow = dvProfile.Table.Rows(0)

            If drProfile("SessionID").ToString() = "" Then
                ddlSession.SelectedIndex = 0
            Else
                ddlSession.SelectedValue = drProfile("SessionID").ToString()
            End If

        End If
    End Sub

    Protected Sub FormViewReview_ModeChanged(sender As Object, e As EventArgs) Handles FormViewReview.ModeChanged
        Progress.Visible = False
    End Sub

    Protected Sub ddlTopic_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlTopic As DropDownList = FormViewReview.FindControl("ddlTopic")
        Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
        Dim chkDecline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")

        If ddlTopic.SelectedIndex <> 0 Then
            ddlSession.Enabled = True
            chkDecline.Checked = False
            'Clear existing items
            ddlSession.Items.Clear()
            'Add new blank and rebind
            Dim liSelectOne As New ListItem("")
            ddlSession.Items.Insert(0, liSelectOne)
            SqlDataSourceSession.SelectParameters("TopicGroupID").DefaultValue = ddlTopic.SelectedValue
            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            ddlSession.DataBind()
        Else
            ddlSession.Enabled = False
        End If



    End Sub

    Protected Sub FormViewReview_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormViewReview.ItemUpdating
        Progress.Visible = True
        Success.Visible = True
        Success.Text = "Review successfully updated"

        'Get Value of ddlSession
        Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
        e.NewValues("SessionID") = ddlSession.SelectedValue
    End Sub

    Protected Sub FormViewReview_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles FormViewReview.ItemInserting
        Progress.Visible = True
        Success.Visible = True
        Success.Text = "Review successfully recorded"

        'Get Value of ddlSession
        Dim ddlSession As DropDownList = FormViewReview.FindControl("ddlSession")
        e.Values("SessionID") = ddlSession.SelectedValue
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

    Protected Sub DeclineCheckBox_CheckedChanged(sender As Object, e As EventArgs)
        Dim topic As DropDownList = FormViewReview.FindControl("ddlTopic")
        Dim decline As CheckBox = FormViewReview.FindControl("DeclineCheckBox")
        Dim validator As RequiredFieldValidator = FormViewReview.FindControl("DeclineCommentsValidator")
        topic.SelectedIndex = 0

        If decline.Checked Then
            validator.Enabled = True
        Else
            validator.Enabled = False
        End If
    End Sub


    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        Searched = True
    End Sub
End Class