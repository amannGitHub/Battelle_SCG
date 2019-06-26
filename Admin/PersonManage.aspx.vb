Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Text.RegularExpressions

Public Class PersonManage
    Inherits System.Web.UI.Page

    Private _array As String
    Dim personIDGet As Integer = 0

    Dim ParticipationIDInsert As TextBox
    Dim firstNameInsert As TextBox
    Dim LastNameInsert As TextBox
    Dim EmployerInsert As TextBox
    Dim EmailInsert As TextBox
    Dim AltPOCEmailInsert As TextBox
    Dim OmitInsert As TextBox
    Dim Address1Insert As TextBox
    Dim Address2Insert As TextBox
    Dim Address3Insert As TextBox
    Dim CityInsert As TextBox
    Dim StateInsert As DropDownList
    Dim ZipInsert As TextBox
    Dim CountryInsert As DropDownList
    Dim OfficeNumberInsert As TextBox
    Dim CellNumberInsert As TextBox
    Dim EnteredByInsert As TextBox
    Dim EnteredSourceInsert As TextBox
    Dim EnteredDateInsert As TextBox
    Dim ModifiedByInsert As TextBox
    Dim ModifiedSourceInsert As TextBox
    Dim ModifiedDateInsert As TextBox
    Dim NotesInsert As TextBox
    Dim ExhibitInsert As TextBox
    Dim SpecialNeedsInsert As TextBox
    Dim SedCorrPresInsert As TextBox
    Dim SedCoAuthInsert As TextBox
    Dim SedChrProspectInsert As TextBox
    Dim SedOtherRoleInsert As TextBox
    Dim BioChrProspectInsert As TextBox
    Dim BioOtherRoleInsert As TextBox

    Dim IsValidAbstract As Boolean = True
    Dim ValidationFailures As NameValueCollection = New NameValueCollection()

    Private Property array(item As GridViewRow) As String
        Get
            Return _array
        End Get
        Set(value As String)
            _array = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub HtmlDecode_PreRender(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
            item.Value = Server.HtmlDecode(item.Value)
        Next
    End Sub

    Public Sub VerifyPerson()

        firstNameInsert = FormViewPersonLookup.FindControl("FirstNameTextBox")
        LastNameInsert = FormViewPersonLookup.FindControl("LastNameTextBox")
        EmployerInsert = FormViewPersonLookup.FindControl("EmployerTextBox")
        EmailInsert = FormViewPersonLookup.FindControl("EmailTextBox")
        AltPOCEmailInsert = FormViewPersonLookup.FindControl("AltPOCEmailTextBox")
        OmitInsert = FormViewPersonLookup.FindControl("OmitTextBox")
        Address1Insert = FormViewPersonLookup.FindControl("AddressLine1TextBox")
        Address2Insert = FormViewPersonLookup.FindControl("AddressLine2TextBox")
        Address3Insert = FormViewPersonLookup.FindControl("AddressLine3TextBox")
        CityInsert = FormViewPersonLookup.FindControl("CityTextBox")
        StateInsert = FormViewPersonLookup.FindControl("StateProvinceDropDownList")
        ZipInsert = FormViewPersonLookup.FindControl("ZipPostalTextBox")
        CountryInsert = FormViewPersonLookup.FindControl("CountryDropDownList")
        OfficeNumberInsert = FormViewPersonLookup.FindControl("PhoneNumTextBox")
        CellNumberInsert = FormViewPersonLookup.FindControl("CellNumTextBox")
        EnteredByInsert = FormViewPersonLookup.FindControl("EnteredByTextBox")
        EnteredSourceInsert = FormViewPersonLookup.FindControl("EnteredSourceTextBox")
        EnteredDateInsert = FormViewPersonLookup.FindControl("EnteredDateTextBox")
        ModifiedByInsert = FormViewPersonLookup.FindControl("ModifiedByTextBox")
        ModifiedSourceInsert = FormViewPersonLookup.FindControl("ModifiedSourceTextBox")
        ModifiedDateInsert = FormViewPersonLookup.FindControl("ModifiedDateTextBox")
        NotesInsert = FormViewPersonLookup.FindControl("NotesTextBox")
        ExhibitInsert = FormViewPersonLookup.FindControl("ExhibitInfoTextBox")
        SpecialNeedsInsert = FormViewPersonLookup.FindControl("SpecialNeedsTextBox")
        SedCorrPresInsert = FormViewPersonLookup.FindControl("SedCorrPresTextBox")
        SedCoAuthInsert = FormViewPersonLookup.FindControl("SedCoAuthTextBox")
        SedChrProspectInsert = FormViewPersonLookup.FindControl("SedChrProspectTextBox")
        SedOtherRoleInsert = FormViewPersonLookup.FindControl("SedOtherRoleTextBox")
        BioChrProspectInsert = FormViewPersonLookup.FindControl("BioChrProspectTextBox")
        BioOtherRoleInsert = FormViewPersonLookup.FindControl("BioOtherRoleTextBox")

        If String.IsNullOrWhiteSpace(firstNameInsert.Text) Then
            IsValidAbstract = False
            ValidationFailures.Add("First Name", "Please provide a first name.")
        End If
        If String.IsNullOrWhiteSpace(LastNameInsert.Text) Then
            IsValidAbstract = False
            ValidationFailures.Add("Last Name", "Please provide a last name.")
        End If
        If String.IsNullOrWhiteSpace(EmployerInsert.Text) Then
            IsValidAbstract = False
            ValidationFailures.Add("Employer", "Please provide an employer.")
        End If
        'If String.IsNullOrWhiteSpace(EmailInsert.Text) Then
        '    IsValidAbstract = False
        '    ValidationFailures.Add("Email", "Please provide an email address.")
        'End If
        If (Not String.IsNullOrWhiteSpace(EmailInsert.Text) And validatePersonEmail(EmailInsert.Text) = False) Then
            IsValidAbstract = False
            ValidationFailures.Add("Email", "Please provide a valid email address.")
        End If
        If Not String.IsNullOrWhiteSpace(AltPOCEmailInsert.Text) And validatePersonEmail(AltPOCEmailInsert.Text) = False Then
            IsValidAbstract = False
            ValidationFailures.Add("Alternate Email", "The alternate email address you provided is not valid.")
        End If
        If String.IsNullOrWhiteSpace(Address1Insert.Text) Then
            IsValidAbstract = False
            ValidationFailures.Add("Address line 1", "Please provide a line 1 address.")
        End If
        If String.IsNullOrWhiteSpace(CityInsert.Text) Then
            IsValidAbstract = False
            ValidationFailures.Add("City", "Please provide a city.")
        End If
        'If StateInsert.SelectedValue = "" Then
        '    IsValidAbstract = False
        '    ValidationFailures.Add("State", "Please select a state.")
        'End If
        If CountryInsert.SelectedValue = "" Then
            IsValidAbstract = False
            ValidationFailures.Add("Country", "Please select a country.")
        End If
        'If String.IsNullOrWhiteSpace(OfficeNumberInsert.Text) Then
        '    IsValidAbstract = False
        '    ValidationFailures.Add("Office Phone Number", "Please provide an office phone number.")
        'End If
    End Sub


    Protected Sub ButtonInsert_ItemInserting(sender As Object, e As EventArgs)
        VerifyPerson()

        If IsValidAbstract Then

            SqlDataSourcePerson.InsertParameters("FirstName").DefaultValue = firstNameInsert.Text
            SqlDataSourcePerson.InsertParameters("LastName").DefaultValue = LastNameInsert.Text
            SqlDataSourcePerson.InsertParameters("Employer").DefaultValue = EmployerInsert.Text
            SqlDataSourcePerson.InsertParameters("AddressLine1").DefaultValue = Address1Insert.Text
            SqlDataSourcePerson.InsertParameters("AddressLine2").DefaultValue = Address2Insert.Text
            SqlDataSourcePerson.InsertParameters("AddressLine3").DefaultValue = Address3Insert.Text
            SqlDataSourcePerson.InsertParameters("City").DefaultValue = CityInsert.Text
            SqlDataSourcePerson.InsertParameters("StateProvince").DefaultValue = StateInsert.SelectedValue
            SqlDataSourcePerson.InsertParameters("ZipPostal").DefaultValue = ZipInsert.Text
            SqlDataSourcePerson.InsertParameters("Country").DefaultValue = CountryInsert.SelectedValue
            SqlDataSourcePerson.InsertParameters("PhoneNum").DefaultValue = OfficeNumberInsert.Text
            SqlDataSourcePerson.InsertParameters("CellNum").DefaultValue = CellNumberInsert.Text
            SqlDataSourcePerson.InsertParameters("Email").DefaultValue = EmailInsert.Text
            SqlDataSourcePerson.InsertParameters("AltPOC").DefaultValue = AltPOCEmailInsert.Text
            SqlDataSourcePerson.InsertParameters("Omit").DefaultValue = OmitInsert.Text
            SqlDataSourcePerson.InsertParameters("EnteredSource").DefaultValue = EnteredSourceInsert.Text
            SqlDataSourcePerson.InsertParameters("EnteredBy").DefaultValue = EnteredByInsert.Text
            SqlDataSourcePerson.InsertParameters("ModifiedBy").DefaultValue = ModifiedByInsert.Text
            SqlDataSourcePerson.InsertParameters("Notes").DefaultValue = NotesInsert.Text
            SqlDataSourcePerson.InsertParameters("InvalidAddress").DefaultValue = False
            SqlDataSourcePerson.InsertParameters("ExhibitInfo").DefaultValue = ExhibitInsert.Text
            SqlDataSourcePerson.InsertParameters("SpecialNeeds").DefaultValue = SpecialNeedsInsert.Text
            SqlDataSourcePerson.InsertParameters("SedCorrPres").DefaultValue = SedCorrPresInsert.Text
            SqlDataSourcePerson.InsertParameters("SedCoAuth").DefaultValue = SedCoAuthInsert.Text
            SqlDataSourcePerson.InsertParameters("SedChrProspect").DefaultValue = SedChrProspectInsert.Text
            SqlDataSourcePerson.InsertParameters("SedOtherRole").DefaultValue = SedOtherRoleInsert.Text
            SqlDataSourcePerson.InsertParameters("BioChrProspect").DefaultValue = BioChrProspectInsert.Text
            SqlDataSourcePerson.InsertParameters("BioOtherRole").DefaultValue = BioOtherRoleInsert.Text

            SqlDataSourcePerson.Insert()
            SqlDataSourcePerson.DataBind()
            SqlDataSource1.FilterExpression = ""
            SqlDataSource1.DataBind()
            GridView1.DataBind()
            PanelGrid.Visible = True
            PanelPerson.Visible = False
            FormViewPersonLookup.Visible = False
            btnGridView.Visible = False

            LabelPersonValidation.Text = String.Empty
            lblResults.Text = "User successfully added."
            'insertParticipationID()
        Else
            'Is valid is false!

            LabelPersonValidation.Text = String.Empty
            LabelPersonValidation.Text = "<div class=""panel panel-danger""><div class=""panel-heading"">Please correct the following items</div><div class=""panel-body"">"
            For Each Item As String In ValidationFailures
                If Not String.IsNullOrWhiteSpace(LabelPersonValidation.Text) Then
                    LabelPersonValidation.Text += "<br />"
                End If
                LabelPersonValidation.Text += ValidationFailures(Item)
            Next
            LabelPersonValidation.Text += "</div></div>"
        End If


    End Sub

    Public Function validatePersonEmail(emailAddress) As Boolean
        Dim email As New Regex("([\w-+]+(?:\.[\w-+]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7})")
        If email.IsMatch(emailAddress) Then
            Return True
        Else
            Return False
        End If
    End Function


    Protected Sub insertParticipationID()

        If personIDGet <> 0 Then
            Dim PersonData = BattellePersonGetAsDataRow(personIDGet)
            Dim NewParticipationID As String = BattelleGenerateParticipationID(PersonData("FirstName"), PersonData("LastName"))
            BattelleSetParticipationID(personIDGet, NewParticipationID)
        End If


    End Sub

    Protected Sub ButtonUpdate_Cancel(sender As Object, e As EventArgs)
        LabelPersonValidation.Text = String.Empty
        lblResults.Text = String.Empty
    End Sub



    Protected Sub ButtonUpdate_ItemUpdating(sender As Object, e As EventArgs)

        Dim personIDUpdate As HiddenField = FormViewPersonLookup.FindControl("hdnPersonID")

        VerifyPerson()

        If IsValidAbstract Then

            ParticipationIDInsert = FormViewPersonLookup.FindControl("ParticipationIDTextBox")
            SqlDataSourcePerson.UpdateParameters("ParticipationID").DefaultValue = ParticipationIDInsert.Text
            SqlDataSourcePerson.UpdateParameters("FirstName").DefaultValue = firstNameInsert.Text
            SqlDataSourcePerson.UpdateParameters("LastName").DefaultValue = LastNameInsert.Text
            SqlDataSourcePerson.UpdateParameters("Employer").DefaultValue = EmployerInsert.Text
            SqlDataSourcePerson.UpdateParameters("AddressLine1").DefaultValue = Address1Insert.Text
            SqlDataSourcePerson.UpdateParameters("AddressLine2").DefaultValue = Address2Insert.Text
            SqlDataSourcePerson.UpdateParameters("AddressLine3").DefaultValue = Address3Insert.Text
            SqlDataSourcePerson.UpdateParameters("City").DefaultValue = CityInsert.Text
            SqlDataSourcePerson.UpdateParameters("StateProvince").DefaultValue = StateInsert.SelectedValue
            SqlDataSourcePerson.UpdateParameters("ZipPostal").DefaultValue = ZipInsert.Text
            SqlDataSourcePerson.UpdateParameters("Country").DefaultValue = CountryInsert.SelectedValue
            SqlDataSourcePerson.UpdateParameters("PhoneNum").DefaultValue = OfficeNumberInsert.Text
            SqlDataSourcePerson.UpdateParameters("CellNum").DefaultValue = CellNumberInsert.Text
            SqlDataSourcePerson.UpdateParameters("Email").DefaultValue = EmailInsert.Text
            SqlDataSourcePerson.UpdateParameters("AltPOC").DefaultValue = AltPOCEmailInsert.Text
            SqlDataSourcePerson.UpdateParameters("Omit").DefaultValue = OmitInsert.Text
            SqlDataSourcePerson.UpdateParameters("ModifiedSource").DefaultValue = ModifiedSourceInsert.Text
            SqlDataSourcePerson.UpdateParameters("ModifiedBy").DefaultValue = ModifiedByInsert.Text
            SqlDataSourcePerson.UpdateParameters("Notes").DefaultValue = NotesInsert.Text
            SqlDataSourcePerson.UpdateParameters("InvalidAddress").DefaultValue = False
            SqlDataSourcePerson.UpdateParameters("ExhibitInfo").DefaultValue = ExhibitInsert.Text
            SqlDataSourcePerson.UpdateParameters("SpecialNeeds").DefaultValue = SpecialNeedsInsert.Text
            SqlDataSourcePerson.UpdateParameters("SedCorrPres").DefaultValue = SedCorrPresInsert.Text
            SqlDataSourcePerson.UpdateParameters("SedCoAuth").DefaultValue = SedCoAuthInsert.Text
            SqlDataSourcePerson.UpdateParameters("SedChrProspect").DefaultValue = SedChrProspectInsert.Text
            SqlDataSourcePerson.UpdateParameters("SedOtherRole").DefaultValue = SedOtherRoleInsert.Text
            SqlDataSourcePerson.UpdateParameters("BioChrProspect").DefaultValue = BioChrProspectInsert.Text
            SqlDataSourcePerson.UpdateParameters("BioOtherRole").DefaultValue = BioOtherRoleInsert.Text
            SqlDataSourcePerson.UpdateParameters("PersonID").DefaultValue = Integer.Parse(personIDUpdate.Value)

            SqlDataSourcePerson.Update()
            SqlDataSourcePerson.DataBind()
            SqlDataSource1.FilterExpression = ""
            SqlDataSource1.DataBind()
            GridView1.DataBind()
            PanelGrid.Visible = True
            PanelPerson.Visible = False
            FormViewPersonLookup.Visible = False
            btnGridView.Visible = False

            LabelPersonValidation.Text = String.Empty
            lblResults.Text = "User successfully updated."
            'insertParticipationID()
        Else
            'Is valid is false!

            LabelPersonValidation.Text = String.Empty
            LabelPersonValidation.Text = "<div class=""panel panel-danger""><div class=""panel-heading"">Please correct the following items</div><div class=""panel-body"">"
            For Each Item As String In ValidationFailures
                If Not String.IsNullOrWhiteSpace(LabelPersonValidation.Text) Then
                    LabelPersonValidation.Text += "<br />"
                End If
                LabelPersonValidation.Text += ValidationFailures(Item)
            Next
            LabelPersonValidation.Text += "</div></div>"
        End If

    End Sub



    Protected Sub CountryDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        'StateProvinceAppend(True)
    End Sub

    Protected Sub CountryDropDownList_DataBound(sender As Object, e As EventArgs)

    End Sub


    Protected Sub StateProvinceDropDownList_DataBinding(sender As Object, e As EventArgs)
        'StateProvinceAppend(False)
    End Sub

    Protected Sub StateProvinceDropDownList_DataBound(sender As Object, e As EventArgs)

    End Sub


    Sub StateProvinceAppend(bRebind As Boolean)
        Dim ddlState As DropDownList = CType(FormViewPersonLookup.FindControl("StateProvinceDropDownList"), DropDownList)
        Dim ddlCountry As DropDownList = CType(FormViewPersonLookup.FindControl("CountryDropDownList"), DropDownList)

        SqlDataSourceLookupStateProvince.SelectParameters("CountryName").DefaultValue = ddlCountry.SelectedValue
        If bRebind = True Then
            ddlState.DataBind()
        End If

    End Sub


    Protected Sub LinkButtonAdd1_Click(sender As Object, e As EventArgs) Handles LinkButtonAdd1.Click
        PanelPerson.Visible = True
        FormViewPersonLookup.Visible = True
        FormViewPersonLookup.DataBind()
        FormViewPersonLookup.ChangeMode(FormViewMode.Insert)
        PanelGrid.Visible = False
    End Sub

    Protected Sub LinkButtonAdd_Click(sender As Object, e As EventArgs) Handles LinkButtonAdd.Click
        PanelPerson.Visible = True
        FormViewPersonLookup.Visible = True
        FormViewPersonLookup.DataBind()
        FormViewPersonLookup.ChangeMode(FormViewMode.Insert)
        PanelGrid.Visible = False
    End Sub


    Protected Sub ButtonInsertCancel_Click(sender As Object, e As EventArgs)
        personIDGet = 0
        btnGridView.Visible = False
        GridView1.DataBind()
        PanelGrid.Visible = True
        PanelPerson.Visible = False
        FormViewPersonLookup.Visible = False
        lblResults.Text = ""
        LabelPersonValidation.Text = String.Empty
    End Sub


    Protected Sub LinkButtonExecute_Click(sender As Object, e As EventArgs) Handles LinkButtonExecute.Click

        Dim personIDGet As Integer = Request.Form("idSelect")

        If personIDGet <> 0 Then
            GridView1.DataBind()
            PanelGrid.Visible = False

            SqlDataSourcePerson.SelectParameters("PersonID").DefaultValue = personIDGet
            PanelPerson.Visible = True
            FormViewPersonLookup.Visible = True

            btnGridView.Visible = True

            lblResults.Text = ""
            LabelPersonValidation.Text = String.Empty

            If FormViewPersonLookup.CurrentMode <> FormViewMode.ReadOnly Then
                FormViewPersonLookup.ChangeMode(FormViewMode.ReadOnly)
            End If
        Else
            lblResults.Text = "Please select a record to update."
        End If

    End Sub



    Protected Sub LinkButtonExecute1_Click(sender As Object, e As EventArgs) Handles LinkButtonExecute1.Click

        Dim personIDGet As Integer = Request.Form("idSelect")

        If personIDGet <> 0 Then
            GridView1.DataBind()
            PanelGrid.Visible = False

            SqlDataSourcePerson.SelectParameters("PersonID").DefaultValue = personIDGet
            PanelPerson.Visible = True
            FormViewPersonLookup.Visible = True

            btnGridView.Visible = True

            lblResults.Text = ""
            LabelPersonValidation.Text = String.Empty

            If FormViewPersonLookup.CurrentMode <> FormViewMode.ReadOnly Then
                FormViewPersonLookup.ChangeMode(FormViewMode.ReadOnly)
            End If
        Else
            lblResults.Text = "Please select a record to update."
        End If


    End Sub


    Protected Sub LinkButtonClear_Click(ByVal container As Control)

        For Each ctrl As Control In container.Controls
            If TypeOf ctrl Is RadioButton Then
                DirectCast(ctrl, RadioButton).Checked = False
            End If
        Next

        SqlDataSource1.FilterExpression = ""
        LabelPersonValidation.Text = String.Empty
        SqlDataSource1.DataBind()
        GridView1.DataBind()

    End Sub

    Protected Sub LinkButtonClear1_Click(ByVal container As Control)

        For Each ctrl As Control In container.Controls
            If TypeOf ctrl Is RadioButton Then
                DirectCast(ctrl, RadioButton).Checked = False
            End If
        Next

        SqlDataSource1.FilterExpression = ""
        LabelPersonValidation.Text = String.Empty
        SqlDataSource1.DataBind()
        GridView1.DataBind()

    End Sub






    Protected Sub btnGridView_Click(sender As Object, e As EventArgs) Handles btnGridView.Click
        personIDGet = 0
        btnGridView.Visible = False
        GridView1.DataBind()
        PanelGrid.Visible = True
        PanelPerson.Visible = False
        FormViewPersonLookup.Visible = False
        lblResults.Text = ""
        LabelPersonValidation.Text = String.Empty
    End Sub


End Class