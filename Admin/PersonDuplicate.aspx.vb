Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Public Class PersonDuplicate
    Inherits System.Web.UI.Page

    Private _array As String
    Dim personIDCompare1 As Integer = 0
    Dim personIDCompare2 As Integer = 0

    Private Property array(item As GridViewRow) As String
        Get
            Return _array
        End Get
        Set(value As String)
            _array = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            GridView1.DataBind()
        End If
    End Sub

    Protected Sub HtmlDecode_PreRender(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
            item.Value = Server.HtmlDecode(item.Value)
        Next
    End Sub

    Protected Sub HtmlDecode_PreRender1(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
            item.Value = Server.HtmlDecode(item.Value)
        Next
    End Sub


    Protected Sub FormViewPersonLookup_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormViewPersonLookup.ItemUpdating

        e.NewValues("Country") = HttpUtility.HtmlEncode(e.NewValues("Country"))
        e.NewValues("StateProvince") = HttpUtility.HtmlEncode(e.NewValues("StateProvince"))

        Dim ValidationFailures As NameValueCollection = New NameValueCollection()
        e.Cancel = Not BattelleValidatePersonDataDictionary(e.NewValues, True, ValidationFailures)
        If e.Cancel Then
            Dim ValidationSummary As Label = FormViewPersonLookup.FindControl("LabelDataValidationSummary")
            ValidationSummary.Text = String.Empty
            ValidationSummary.Text += "<div class=""panel panel-danger""><div class=""panel-heading"">Please correct the following items</div><div class=""panel-body"">"

            For Each Item As String In ValidationFailures

                ValidationSummary.Text += ValidationFailures(Item) & "<br />"
            Next
            ValidationSummary.Text += "</div></div>"
        End If
    End Sub


    Protected Sub FormViewPersonLookup1_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormViewPersonLookup1.ItemUpdating

        e.NewValues("Country") = HttpUtility.HtmlEncode(e.NewValues("Country"))
        e.NewValues("StateProvince") = HttpUtility.HtmlEncode(e.NewValues("StateProvince"))

        Dim ValidationFailures1 As NameValueCollection = New NameValueCollection()
        e.Cancel = Not BattelleValidatePersonDataDictionary(e.NewValues, True, ValidationFailures1)
        If e.Cancel Then
            Dim ValidationSummary1 As Label = FormViewPersonLookup1.FindControl("LabelDataValidationSummary1")
            ValidationSummary1.Text = String.Empty
            ValidationSummary1.Text += "<div class=""panel panel-danger""><div class=""panel-heading"">Please correct the following items</div><div class=""panel-body"">"

            For Each Item As String In ValidationFailures1

                ValidationSummary1.Text += ValidationFailures1(Item) & "<br />"
            Next
            ValidationSummary1.Text += "</div></div>"
        End If
    End Sub



    Protected Sub CountryDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)

        'StateProvinceAppend(True)

    End Sub

    Protected Sub CountryDropDownList_DataBound(sender As Object, e As EventArgs)

    End Sub

    Protected Sub CountryDropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs)

        'StateProvinceAppend(True)

    End Sub

    Protected Sub CountryDropDownList1_DataBound(sender As Object, e As EventArgs)

    End Sub


    Protected Sub StateProvinceDropDownList_DataBinding(sender As Object, e As EventArgs)
        'StateProvinceAppend(False)
    End Sub

    Protected Sub StateProvinceDropDownList_DataBound(sender As Object, e As EventArgs)

    End Sub

    Protected Sub StateProvinceDropDownList1_DataBinding(sender As Object, e As EventArgs)
        'StateProvinceAppend(False)
    End Sub

    Protected Sub StateProvinceDropDownList1_DataBound(sender As Object, e As EventArgs)

    End Sub

    Sub StateProvinceAppend(bRebind As Boolean)
        Dim ddlState As DropDownList = CType(FormViewPersonLookup.FindControl("StateProvinceDropDownList"), DropDownList)
        Dim ddlCountry As DropDownList = CType(FormViewPersonLookup.FindControl("CountryDropDownList"), DropDownList)

        SqlDataSourceLookupStateProvince.SelectParameters("CountryName").DefaultValue = ddlCountry.SelectedValue
        If bRebind = True Then
            ddlState.DataBind()
        End If

    End Sub


    Protected Sub LinkButtonExecute_Click(sender As Object, e As EventArgs)

        Dim count As Integer = 0

        'Loop through gridview, retrieving the two personIDs to compare
        For Each item As GridViewRow In GridView1.Rows
            If TryCast(item.Cells(0).FindControl("cbSelect"), CheckBox).Checked Then

                Dim theID As Integer = Integer.Parse(item.Cells(3).Text)

                If count = 0 Then
                    personIDCompare1 = theID
                    hdnBackID.Value = theID
                ElseIf count = 1 Then
                    personIDCompare2 = theID
                End If

                count = count + 1

            End If

        Next

        'Ensure that only 2 people were selected and show person comparison panels, otherwise throw error
        If count >= 3 Then
            lblResults.Text = "Please select only two records to compare."

        ElseIf count = 2 Then
            lblResults.Text = ""

            PanelGrid.Visible = False

            SqlDataSourcePerson.SelectParameters("PersonID").DefaultValue = personIDCompare1
            PanelPerson.Visible = True
            FormViewPersonLookup.Visible = True

            SqlDataSourcePerson1.SelectParameters("PersonID").DefaultValue = personIDCompare2
            PanelPerson1.Visible = True
            FormViewPersonLookup1.Visible = True
            btnGridView.Visible = True

            lblResults.Text = ""

            If FormViewPersonLookup.CurrentMode <> FormViewMode.ReadOnly Then
                FormViewPersonLookup.ChangeMode(FormViewMode.ReadOnly)
            End If

            If FormViewPersonLookup1.CurrentMode <> FormViewMode.ReadOnly Then
                FormViewPersonLookup1.ChangeMode(FormViewMode.ReadOnly)
            End If
        Else
            lblResults.Text = "Please select two records to compare."

        End If

    End Sub



    Protected Sub LinkButtonExecute1_Click(sender As Object, e As EventArgs) Handles LinkButtonExecute1.Click

        Dim count As Integer = 0

        'Loop through gridview, retrieving the two personIDs to compare
        For Each item As GridViewRow In GridView1.Rows
            If TryCast(item.Cells(0).FindControl("cbSelect"), CheckBox).Checked Then

                Dim theID As Integer = Integer.Parse(item.Cells(3).Text)

                If count = 0 Then
                    personIDCompare1 = theID
                    hdnBackID.Value = theID
                ElseIf count = 1 Then
                    personIDCompare2 = theID
                End If

                count = count + 1

            End If

        Next

        'Ensure that only 2 people were selected and show person comparison panels, otherwise throw error
        If count >= 3 Then
            lblResults.Text = "Please select only two records to compare."

        ElseIf count = 2 Then
            lblResults.Text = ""

            PanelGrid.Visible = False

            SqlDataSourcePerson.SelectParameters("PersonID").DefaultValue = personIDCompare1
            PanelPerson.Visible = True
            FormViewPersonLookup.Visible = True

            SqlDataSourcePerson1.SelectParameters("PersonID").DefaultValue = personIDCompare2
            PanelPerson1.Visible = True
            FormViewPersonLookup1.Visible = True
            btnGridView.Visible = True

            lblResults.Text = ""

            If FormViewPersonLookup.CurrentMode <> FormViewMode.ReadOnly Then
                FormViewPersonLookup.ChangeMode(FormViewMode.ReadOnly)
            End If

            If FormViewPersonLookup1.CurrentMode <> FormViewMode.ReadOnly Then
                FormViewPersonLookup1.ChangeMode(FormViewMode.ReadOnly)
            End If
        Else
            lblResults.Text = "Please select two records to compare."

        End If

    End Sub


    Protected Sub LinkButtonClear_Click(sender As Object, e As EventArgs) Handles LinkButtonClear.Click

        For Each item As GridViewRow In GridView1.Rows
            If TryCast(item.Cells(0).FindControl("cbSelect"), CheckBox).Checked Then
                TryCast(item.Cells(0).FindControl("cbSelect"), CheckBox).Checked = False
            End If
        Next

        SqlDataSource1.FilterExpression = ""
        SqlDataSource1.DataBind()
        lblResults.Text = ""

    End Sub

    Protected Sub LinkButtonClear1_Click(sender As Object, e As EventArgs) Handles LinkButtonClear1.Click

        For Each item As GridViewRow In GridView1.Rows
            If TryCast(item.Cells(0).FindControl("cbSelect"), CheckBox).Checked Then
                TryCast(item.Cells(0).FindControl("cbSelect"), CheckBox).Checked = False
            End If
        Next

        SqlDataSource1.FilterExpression = ""
        SqlDataSource1.DataBind()
        lblResults.Text = ""

    End Sub

    Protected Sub DeletePersonButton(sender As Object, e As EventArgs)
        SqlDataSourcePerson.DeleteParameters("PersonID_Delete").DefaultValue = SqlDataSourcePerson.SelectParameters("PersonID").DefaultValue
        SqlDataSourcePerson.DeleteParameters("PersonID_Update").DefaultValue = SqlDataSourcePerson1.SelectParameters("PersonID").DefaultValue
        SqlDataSourcePerson.Delete()
        SqlDataSourcePerson.DataBind()

        SqlDataSource1.FilterExpression = ""
        SqlDataSource1.DataBind()

        PanelGrid.Visible = True
        PanelPerson.Visible = False
        FormViewPersonLookup.Visible = False
        PanelPerson1.Visible = False
        FormViewPersonLookup1.Visible = False
        btnGridView.Visible = False

        lblResults.Text = "User has been deleted."
    End Sub


    Protected Sub DeletePersonButton1(sender As Object, e As EventArgs)
        SqlDataSourcePerson1.DeleteParameters("PersonID_Delete").DefaultValue = SqlDataSourcePerson1.SelectParameters("PersonID").DefaultValue
        SqlDataSourcePerson1.DeleteParameters("PersonID_Update").DefaultValue = SqlDataSourcePerson.SelectParameters("PersonID").DefaultValue
        SqlDataSourcePerson1.Delete()
        SqlDataSourcePerson1.DataBind()

        SqlDataSource1.FilterExpression = ""
        SqlDataSource1.DataBind()

        PanelGrid.Visible = True
        PanelPerson.Visible = False
        FormViewPersonLookup.Visible = False
        PanelPerson1.Visible = False
        FormViewPersonLookup1.Visible = False
        btnGridView.Visible = False

        lblResults.Text = "User has been deleted."
    End Sub


    'Protected Sub DeletePerson(sender As Object, e As EventArgs)
    '    Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)
    '    SqlDataSourcePerson.DeleteParameters("PersonID").DefaultValue = lnkRemove.CommandArgument
    '    SqlDataSourcePerson.Delete()
    '    SqlDataSourcePerson.DataBind()
    '    GridView1.DataBind()
    'End Sub


    Protected Sub btnGridView_Click(sender As Object, e As EventArgs) Handles btnGridView.Click
        Dim personIDlinkID As Integer
        personIDlinkID = personIDCompare1

        Dim sURL As String
        'sURL = "PersonDuplicate#PersonID_" & hdnBackID.Value
        'Response.Redirect(sURL, True)

        sURL = "#PersonID_" & hdnBackID.Value
        ClientScript.RegisterStartupScript(Me.[GetType](), "hash", "location.hash = '" & sURL & "';", True)

        btnGridView.Visible = False
        PanelGrid.Visible = True
        PanelPerson.Visible = False
        FormViewPersonLookup.Visible = False
        PanelPerson1.Visible = False
        FormViewPersonLookup1.Visible = False
        lblResults.Text = ""

        clearCompareIDs()

    End Sub

    Protected Sub clearCompareIDs()
        personIDCompare1 = 0
        personIDCompare2 = 0
    End Sub


End Class