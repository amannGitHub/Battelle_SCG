Imports System.IO
Imports System.Data
Imports System.Drawing
Imports System.Data.SqlClient
Imports System.Configuration

Public Class ShortCourseManager
    Inherits System.Web.UI.Page

    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsPostBack Then
            SqlDataSourceShortCourse.DataBind()
            gvCourse.DataBind()
            gvShortCourseAll.DataBind()
            ButtonShortCourseExport.Visible = True
            If (User.Identity.IsAuthenticated) Then
                SqlDataSourcePerson.UpdateParameters("ModifiedBy").DefaultValue = User.Identity.Name
            Else
                SqlDataSourcePerson.UpdateParameters("ModifiedBy").DefaultValue = "Unauthorized User"
            End If
        End If

    End Sub

    Protected Sub SqlDataSourceShortCourse_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceShortCourse.Updating
        SqlDataSourceShortCourse.UpdateParameters("courseID").DefaultValue = FormView1.DataKey.ToString

    End Sub


    Protected Sub gvCourse_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvCourse.SelectedIndexChanged
        FormView1.Visible = True
        gvAuthors.Visible = True
        ShortCourseHeader.Visible = True
        gvCourseAuthorsLbl.Visible = True
        gvAuthorsButton.Text = "Hide Grid View"
        gvAuthorsButton.Visible = True

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


    Protected Sub gvAuthorsButton_Click(sender As Object, e As EventArgs)

        If gvAuthorsButton.Text = "Hide Grid View" Then
            gvAuthors.Visible = False
            gvCourseAuthorsLbl.Visible = False
            gvAuthorsButton.Text = "Show Grid View"
        ElseIf gvAuthorsButton.Text = "Show Grid View" Then
            gvAuthors.Visible = True
            gvCourseAuthorsLbl.Visible = True
            gvAuthorsButton.Text = "Hide Grid View"
        End If

    End Sub



    Protected Sub ddlConfList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConfList.SelectedIndexChanged
        gvCourse.Visible = True 'Code reused from Abstract manager, keeping the name for simplicity
        gvAuthorsButton.Visible = False
        HdnConferenceID.Value = ddlConfList.SelectedValue
        ShortCourseHeader.Visible = False
        gvCourseAuthorsLbl.Visible = False
        labelCorrespondingAuthor.Visible = False
        listCorrespondingAuthor.Visible = False
        gvAuthors.Visible = False
        FormView1.Visible = False
        ButtonShortCourseExport.Visible = True
    End Sub

    Protected Sub SqlDataSourceCourseSelected_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceCourseSelected.Selecting

    End Sub

    Protected Sub SqlDataSourceCourseSelected_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceCourseSelected.Selected
        Dim authorCount As Integer
        authorCount = gvAuthors.Rows.Count()
        If authorCount = 0 Then
            gvAuthorsButton.Visible = False
            gvCourseAuthorsLbl.Visible = False
        Else
            gvAuthorsButton.Visible = True
            gvCourseAuthorsLbl.Visible = True
        End If




    End Sub

    Protected Sub SqlDataSourceCourseSelected_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceCourseSelected.Updated
        'SqlDataSourceShortCourse.SelectParameters("ConferenceID").DefaultValue = FormView1.DataKey.ToString
        SqlDataSourceShortCourse.SelectParameters("ConferenceID").DefaultValue = HdnConferenceID.Value
        SqlDataSourceShortCourse.DataBind()
        gvCourse.DataBind()

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
        FormViewPerson.Visible = True
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

        Dim courseID As Integer = FormView1.DataKey.Value

        If hdnCorPres.Value = Nothing Then
            hdnCorPres.Value = 0
        End If

        'Delete instructors from associated short course
        For Each LA As ListItem In listofDeletedAuthors.Items
            BattelleShortCourseInstructorsDelete(courseID, Integer.Parse(LA.Value))
        Next


        'Update instructors from associated short course
        For Each LI As ListItem In ListBoxAbstractAuthors.Items
            Dim Presenter As Boolean = False

            If hdnCorPres.Value > 0 And Integer.Parse(LI.Value) = hdnCorPres.Value Then
                Presenter = True
            End If

            BattelleShortCourseInstructorsUpdate(courseID, Integer.Parse(LI.Value), Presenter)
        Next

        'Notify user of update, rebind grids and listbox
        gvAuthors.DataBind()
        SqlDataSourceCo.DataBind()
        ListBoxAbstractAuthors.DataBind()
        lblAuthorResults.Text = "Instructor-list successfully updated"
        PanelPersonUpdate.Visible = False


    End Sub

    Protected Sub PersonInfoUpdate_Click(sender As Object, e As EventArgs)
        gvAuthors.DataBind()
        SqlDataSourceCo.DataBind()
        ListBoxAbstractAuthors.DataBind()
    End Sub


    Protected Sub ButtonUpdate_Click(sender As Object, e As EventArgs)
        gvCourse.DataBind()
        SqlDataSourceShortCourse.DataBind()
    End Sub

    Protected Sub CloseAuthorButton_Click(sender As Object, e As EventArgs)
        FormViewPerson.Visible = False
    End Sub

    Protected Sub FormView1_ItemUpdated(sender As Object, e As EventArgs)

    End Sub


    Protected Sub ButtonShortCourseExport_Click(sender As Object, e As EventArgs) Handles ButtonShortCourseExport.Click

        Dim regDate As Date = Date.Now()
        Dim strDate As String = regDate.ToString("ddMMMyyyy")
        Dim fileName As String = "ShortCourseManager_Export" + strDate + ".xls"

        'activate the full data GridView
        gvShortCourseAll.Visible = True


        ' Let's hide all unwanted stuffing
        gvShortCourseAll.AllowPaging = False
        gvShortCourseAll.AllowSorting = False
        'gvShortCourseAll.Columns(0).Visible = False


        ' Let's bind data to GridView
        SqlDataSourceShortCourse.DataBind()
        gvShortCourseAll.DataBind()

        ' Let's output HTML of GridView
        Response.Clear()

        Response.AddHeader("Transfer-Encoding", "identity") 'This line added 06-08-2018 to fix Chrome file download Network Failed error
        Response.ContentType = "application/vnd.xls"
        Response.ContentEncoding = System.Text.Encoding.Unicode
        Response.AddHeader("content-disposition", "attachment;filename=" + fileName)
        Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble())

        Dim swriter As New StringWriter()
        Dim hwriter As New HtmlTextWriter(swriter)

        Dim frm As New HtmlForm()
        Me.gvShortCourseAll.Parent.Controls.Add(frm)
        frm.Attributes("runat") = "server"
        frm.Controls.Add(Me.gvShortCourseAll)
        frm.RenderControl(hwriter)

        Response.Write(swriter.ToString())
        Response.[End]()

        gvShortCourseAll.Visible = False

    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As System.Web.UI.Control)
    End Sub





End Class