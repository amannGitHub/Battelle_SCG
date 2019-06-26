Imports System.Data
Imports System.Data.SqlClient
Imports System.IO


Public Class Manager
    Inherits System.Web.UI.Page

    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsPostBack Then
            If (User.Identity.IsAuthenticated) Then
                SqlDataSourcePerson.UpdateParameters("ModifiedBy").DefaultValue = User.Identity.Name
            Else
                SqlDataSourcePerson.UpdateParameters("ModifiedBy").DefaultValue = "Unauthorized User"
            End If
            If ltlAlert.Visible = True Then
                ltlAlert.Visible = False
            End If
        End If

    End Sub


    Protected Sub SqlDataSourceAbstract_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAbstract.Updating
        SqlDataSourceAbstract.UpdateParameters("AbstractID").DefaultValue = FormView1.DataKey.ToString

    End Sub

    Protected Sub gvAbstract_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvAbstract.SelectedIndexChanged
        FormView1.Visible = True
        gvAuthors.Visible = True
        gvReviews.Visible = True

        labelCorrespondingAuthor.Visible = True
        listCorrespondingAuthor.Visible = True

        lblCorPresAuthor.Text = ""
        hdnCorPres.Value = ""
        lblAuthorResults.Text = ""

        For i As Integer = 0 To gvAuthors.Rows.Count - 1
            Dim row = gvAuthors.Rows(i)
            Dim cbox As CheckBox = DirectCast(row.Cells(0).Controls(0), CheckBox)
            Dim rowHeaderCell = row.Cells(1)
            Dim rowHeaderCell2 = row.Cells(2)
            Dim rowHeaderCell14 = row.Cells(14)

            If cbox.Checked Then
                lblCorPresAuthor.Text = rowHeaderCell.Text & " " & rowHeaderCell2.Text
                hdnCorPres.Value = rowHeaderCell14.Text
            End If
        Next

    End Sub



    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        gvAbstract.Visible = True
        If ddlConfList.SelectedIndex <> 0 Then
            btnMakeReadyForReview.Visible = True
            btnMakeReadyForSessionChairs.Visible = True
        Else
            gvAbstract.Visible = False
            btnMakeReadyForReview.Visible = False
            btnMakeReadyForSessionChairs.Visible = False
        End If
    End Sub

    Protected Sub SqlDataSourceAbstractSelected_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceAbstractSelected.Selecting

    End Sub

    Protected Sub SqlDataSourceAbstractSelected_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceAbstractSelected.Selected

    End Sub



    'Added code
    Protected Sub CountryDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)

        'StateProvinceAppend(True)

    End Sub

    Protected Sub CountryDropDownList_DataBound(sender As Object, e As EventArgs)

    End Sub

    Protected Sub StateProvinceDropDownList_DataBound(sender As Object, e As EventArgs)

    End Sub
    Protected Sub StateProvinceDropDownList_DataBinding(sender As Object, e As EventArgs)
        'StateProvinceAppend(False)
    End Sub

    Protected Sub GetCurrentPresenter(sender As Object, e As EventArgs)
        lblCorPresAuthor.Text = ""
        hdnCorPres.Value = ""

        For i As Integer = 0 To gvAuthors.Rows.Count - 1
            Dim row = gvAuthors.Rows(i)
            Dim cbox As CheckBox = DirectCast(row.Cells(0).Controls(0), CheckBox)
            Dim rowHeaderCell = row.Cells(1)
            Dim rowHeaderCell2 = row.Cells(2)
            Dim rowHeaderCell14 = row.Cells(14)

            If cbox.Checked Then
                lblCorPresAuthor.Text = rowHeaderCell.Text & " " & rowHeaderCell2.Text
                hdnCorPres.Value = rowHeaderCell14.Text
            End If
        Next

    End Sub


    Protected Sub LinkButtonPersonLookup_Click(sender As Object, e As EventArgs) Handles LinkButtonPersonLookup2.Click
        FormViewPersonLookup.Visible = True
        FormViewPersonLookup.DataBind()
        If FormViewPersonLookup.SelectedValue Is Nothing Then
            LabelPersonLookupResult.Text = "<div class=""alert alert-warning"" role=""alert"">No entry for this co-author was found. Please carefully check what you typed and correct if necessary. Otherwise, click the &quot;Enter co-author information&quot; button below to enter the co-author&#39;s contact information.</div>"
        Else
            LabelPersonLookupResult.Text = "<div class=""alert alert-success"" role=""alert"">Co-author located!</div>"
        End If
    End Sub



    Protected Sub ButtonAuthorsEdit_Click(sender As Object, e As EventArgs) Handles ButtonAuthorsEdit.Click
        PanelPersonUpdate.Visible = True
        lblAuthorResults.Text = ""
        If ListBoxAbstractAuthors.SelectedIndex >= 0 Then
            SqlDataSourcePerson.SelectParameters("PersonID").DefaultValue = ListBoxAbstractAuthors.SelectedValue
            SqlDataSourcePerson.UpdateParameters("PersonID").DefaultValue = ListBoxAbstractAuthors.SelectedValue
        End If
    End Sub


    Protected Sub SelectButton_Click(sender As Object, e As EventArgs)
        FormViewPersonLookup.DataBind()
        Dim DataRow As DataRowView = CType(FormViewPersonLookup.DataItem, DataRowView)
        Dim DataKey As Integer = DataRow("PersonID")
        AbstractAuthorsAdd(DataRow("FirstName"), DataRow("LastName"), DataKey)
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
        Dim sm As ScriptManager = ScriptManager.GetCurrent(Me)

        AbstractAuthorsUpdate_Click()
        sm.SetFocus(ListBoxAbstractAuthors)
    End Sub


    Protected Sub ButtonAuthorsAdd_Click(sender As Object, e As EventArgs) Handles ButtonAuthorsAdd.Click
        TextBoxPersonEmail.Text = ""
        LabelPersonLookupResult.Text = String.Empty
        FormViewPersonLookup.DataBind()
        PanelPersonAdd.Visible = True
        FormViewPersonLookup.Visible = False
        lblAuthorResults.Text = ""
    End Sub

    Protected Sub ListBoxAbstractAuthors_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListBoxAbstractAuthors.SelectedIndexChanged
        ButtonAuthorsRemove.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
        ButtonCorPresAuthorSet.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0

        ButtonAuthorsEdit.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0

    End Sub

    Protected Sub ButtonAuthorsRemove_Click(sender As Object, e As EventArgs) Handles ButtonAuthorsRemove.Click
        If ListBoxAbstractAuthors.SelectedIndex >= 0 Then
            lblAuthorResults.Text = ""

            Dim newListItem As ListItem
            newListItem = New ListItem(ListBoxAbstractAuthors.SelectedValue)
            listofDeletedAuthors.Items.Add(newListItem)

            If ListBoxAbstractAuthors.SelectedValue = hdnCorPres.Value Then
                lblCorPresAuthor.Text = ""
                hdnCorPres.Value = ""
            Else
                'Weird?
            End If

            ListBoxAbstractAuthors.Items.RemoveAt(ListBoxAbstractAuthors.SelectedIndex)
            ListBoxAbstractAuthors.ClearSelection()
            ButtonAuthorsRemove.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
            ButtonCorPresAuthorSet.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0

            AbstractAuthorsUpdate_Click()

        Else
            'Weird?
        End If
    End Sub


    Protected Sub ButtonCorPresAuthorSet_Click(sender As Object, e As EventArgs) Handles ButtonCorPresAuthorSet.Click
        If ListBoxAbstractAuthors.SelectedIndex >= 0 Then

            lblAuthorResults.Text = ""

            If ListBoxAbstractAuthors.SelectedValue = hdnCorPres.Value Then
                lblCorPresAuthor.Text = ""
                hdnCorPres.Value = ""
            Else
                lblCorPresAuthor.Text = ListBoxAbstractAuthors.SelectedItem.ToString
                hdnCorPres.Value = ListBoxAbstractAuthors.SelectedValue
                ListBoxAbstractAuthors.ClearSelection()
                ButtonCorPresAuthorSet.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
                ButtonAuthorsRemove.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
            End If
            AbstractAuthorsUpdate_Click()
        Else
            'Weird?
        End If
    End Sub

    Private Sub AbstractAuthorsAdd(FirstName As String, LastName As String, PersonID As Integer)
        If ListBoxAbstractAuthors.Items.FindByValue(PersonID.ToString()) Is Nothing Then
            Dim NewItem As ListItem = New ListItem(FirstName + " " + LastName, PersonID.ToString())

            '#If DEBUG Then
            '            NewItem.Text += " (DEBUG: " + PersonID.ToString() + ")"
            '#End If

            ListBoxAbstractAuthors.Items.Add(NewItem)

            AbstractAuthorsUpdate_Click()
        End If
        ' Else the item already exists in the list box.

    End Sub

    Protected Sub FormViewPersonLookup_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles FormViewPersonLookup.ItemInserting
        e.Values("Country") = HttpUtility.HtmlEncode(e.Values("Country"))
        e.Values("StateProvince") = HttpUtility.HtmlEncode(e.Values("StateProvince"))

        Dim ValidationFailures As NameValueCollection = New NameValueCollection()
        e.Cancel = Not BattelleValidatePersonDataDictionary(e.Values, True, ValidationFailures)
        If e.Cancel Then
            Dim ValidationSummary As Label = FormViewPersonLookup.FindControl("LabelDataValidationSummary")
            ValidationSummary.Text = String.Empty
            ValidationSummary.Text += "<div class=""panel panel-danger""><div class=""panel-heading"">Please correct the following items</div><div class=""panel-body"">"
            For Each Item As String In ValidationFailures
                If Not String.IsNullOrWhiteSpace(ValidationSummary.Text) Then
                    ValidationSummary.Text += "<br />"
                End If
                ValidationSummary.Text += ValidationFailures(Item)
            Next
            ValidationSummary.Text += "</div></div>"
        End If
    End Sub

    Protected Sub FormViewPersonLookup_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles FormViewPersonLookup.ItemInserted
        Dim DataRow As DataRow = BattellePersonGetByEmailAsDataRow(e.Values("Email"))
        Dim DataKey As Integer = DataRow("PersonID")
        AbstractAuthorsAdd(DataRow("FirstName"), DataRow("LastName"), DataKey)
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
    End Sub

    Protected Sub EmailTextBox_Init(sender As Object, e As EventArgs)
        Dim EmailTextBox As TextBox = CType(sender, TextBox)
        EmailTextBox.Text = TextBoxPersonEmail.Text
    End Sub


    Protected Sub HtmlDecode_PreRender(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
            item.Value = Server.HtmlDecode(item.Value)
        Next
    End Sub


    Protected Sub ButtonSearchCancel_Click(sender As Object, e As EventArgs) Handles ButtonSearchCancel.Click
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
    End Sub


    Protected Sub GetAbstractPresenter()

    End Sub

    Protected Sub AbstractAuthorsUpdate_Click()

        Dim abstractID As Integer = FormView1.DataKey.Value

        If hdnCorPres.Value = Nothing Then
            hdnCorPres.Value = 0
        End If

        'Delete authors from associated abstract
        For Each LA As ListItem In listofDeletedAuthors.Items
            BattelleAbstractAuthorsDelete(abstractID, Integer.Parse(LA.Value))
        Next


        'Update authors from associated abstract
        For Each LI As ListItem In ListBoxAbstractAuthors.Items
            Dim Presenter As Boolean = False

            If hdnCorPres.Value > 0 And Integer.Parse(LI.Value) = hdnCorPres.Value Then
                Presenter = True
            End If

            BattelleAbstractAuthorsUpdate(abstractID, Integer.Parse(LI.Value), Presenter)
        Next

        'Notify user of update, rebind grids and listbox
        gvAuthors.DataBind()
        SqlDataSourceCo.DataBind()
        ListBoxAbstractAuthors.DataBind()
        lblAuthorResults.Text = "Author-list successfully updated"
        PanelPersonUpdate.Visible = False


    End Sub

    Protected Sub PersonInfoUpdate_Click(sender As Object, e As EventArgs)
        gvAuthors.DataBind()
        SqlDataSourceCo.DataBind()
        ListBoxAbstractAuthors.DataBind()
    End Sub

    Protected Sub btnMakeReadyForReview_Click(sender As Object, e As EventArgs) Handles btnMakeReadyForReview.Click
        'Just executing stored procedure
        SqlDataSourceMakeReadyForReview.Update()
        ltlAlert.Visible = True
        ltlAlert.Text = "<div class=""alert alert-success"" role=""alert"">All abstracts have been released for review.</div>"
    End Sub

    Protected Sub btnMakeReadyForSessionChairs_Click(sender As Object, e As EventArgs) Handles btnMakeReadyForSessionChairs.Click
        'Not really deleting anything, just using the delete method to execute the stored procedure
        SqlDataSourceMakeReadyForReview.Delete()
        ltlAlert.Visible = True
        ltlAlert.Text = "<div class=""alert alert-success"" role=""alert"">All abstracts have been released for Session Chair review.</div>"
    End Sub
End Class