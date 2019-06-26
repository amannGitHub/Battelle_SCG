Imports System.Data
Imports System.Data.SqlClient
Imports System.IO


Public Class AbstractLock
    Inherits System.Web.UI.Page

    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsPostBack Then
            'If (User.Identity.IsAuthenticated) Then
            'SqlDataSourcePerson.UpdateParameters("ModifiedBy").DefaultValue = User.Identity.Name
            'Else
            'SqlDataSourcePerson.UpdateParameters("ModifiedBy").DefaultValue = "Unauthorized User"
            'End If

        End If

    End Sub


    Protected Sub gvAbstract_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvAbstract.SelectedIndexChanged


    End Sub



    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        gvAbstract.Visible = True
        TotalResults.Visible = True
        PanelLock.Visible = False
        PanelLockAllButtons.Visible = True
        If ddlConfList.SelectedIndex <> 0 Then
        Else
            gvAbstract.Visible = False
            TotalResults.Visible = False
            PanelLockAllButtons.Visible = False
        End If
    End Sub


    Protected Sub HtmlDecode_PreRender(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
            item.Value = Server.HtmlDecode(item.Value)
        Next


    End Sub


    Protected Sub btnLock_Click(sender As Object, e As EventArgs)
        Dim b As Button = sender
        Dim gvr As GridViewRow = b.NamingContainer

        Dim counter As Integer = 0
        Dim result As String

        Dim ReviewGroupStrList As CheckBoxList = gvr.FindControl("ReviewGroupChkBox")
        Dim AbstractID As String = gvr.Cells(0).Text
        Dim AbstractTitle As String = gvr.Cells(1).Text

        Dim sb As StringBuilder = New StringBuilder()

        For Each item As ListItem In ReviewGroupStrList.Items
            If item.Selected Then
                If counter = 0 Then
                    sb.Append(item.Value)
                    counter = counter + 1
                Else
                    sb.Append("," + item.Value)
                    counter = counter + 1
                End If

            End If
        Next
        result = sb.ToString()
        lblLockResults.Text = "The following abstract was updated:"
        lblAbstractID.Text = "AbstractID: " + AbstractID
        lblAbstractTitle.Text = "Abstract Title: " + AbstractTitle
        lblLockedReviewGroups.Text = "ReviewGroupIDs locked: " + result
        PanelLock.Visible = True

        'Update Abstract Review Group Lock
        BattelleAbstractReviewGroupLock(ddlConfList.SelectedValue, Convert.ToInt32(AbstractID), result, 0)
        gvAbstract.DataBind()

    End Sub


    Protected Sub gvAbstract_DataBound(sender As Object, e As EventArgs)

        'Loops through and checks the appropriate checkboxes in the Locked Review Groups column of the gvAbstract gridview
        For Each row As GridViewRow In gvAbstract.Rows

            Dim ReviewGroupStrList As CheckBoxList = row.FindControl("ReviewGroupChkBox")
            Dim getReviewGroupIDs As Label = row.FindControl("lblAbstractGroupIDsLocked")

            For Each item As ListItem In ReviewGroupStrList.Items
                If getReviewGroupIDs.Text.Contains(item.Value) Then
                    ReviewGroupStrList.Items.FindByValue(item.Value).Selected = True
                End If
            Next

        Next

    End Sub

    Protected Sub btnLockAll_Click(sender As Object, e As EventArgs) Handles LinkButtonUpdatePC.Click, LinkButtonUpdatePCReview.Click, LinkButtonUpdateSC.Click, LinkButtonUpdateSession.Click

        Dim getGroupLinkButton As LinkButton = CType(sender, LinkButton)

        Dim getGroupID As String
        Dim getGroupName As String

        Select Case getGroupLinkButton.Text
            Case "Program Chair Lock All"
                getGroupID = "1"
                getGroupName = "Program Chairs"
            Case "Steering Committee Lock All"
                getGroupID = "2"
                getGroupName = "Steering Committee Members"
            Case "Session Chair Lock All"
                getGroupID = "3"
                getGroupName = "Session Chairs"
            Case "Program Chair Re-Review Lock All"
                getGroupID = "4"
                getGroupName = "Program Chair Re-Reviews"
            Case Else
                getGroupID = ""
                getGroupName = "None"
        End Select


        Dim gvAbstractRowCount As Integer
        gvAbstract.AllowPaging = False
        gvAbstract.DataBind()

        gvAbstractRowCount = gvAbstract.Rows.Count

        For Each row As GridViewRow In gvAbstract.Rows
            Dim AbstractID As String = row.Cells(0).Text
            BattelleAbstractReviewGroupLock(ddlConfList.SelectedValue, Convert.ToInt32(AbstractID), getGroupID, 1)
        Next

        gvAbstract.AllowPaging = True
        gvAbstract.DataBind()
        lblLockResults.Text = "All " + getGroupName + " are now locked."
        lblAbstractID.Text = ""
        lblAbstractTitle.Text = ""
        lblLockedReviewGroups.Text = ""
        PanelLock.Visible = True

    End Sub

End Class