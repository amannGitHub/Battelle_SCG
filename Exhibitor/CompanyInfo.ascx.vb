Public Class CompanyInfo
    Inherits System.Web.UI.UserControl

    Delegate Sub OnFinishedLogin()

    Public Event FinishedLogin As OnFinishedLogin

    Public Property ExhibitorID() As Integer
        Get
            If (ViewState("ExhibitorID") IsNot Nothing) Then
                Return CType(ViewState("ExhibitorID"), Integer)
            Else
                Return 0
            End If
        End Get
        Set(value As Integer)
            ViewState("ExhibitorID") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Control requires Point of Contact PersonID to be added to hdnVal
    End Sub

    Protected Sub txtCompanyName_Init(sender As Object, e As EventArgs)
        Dim txtCompanyName As TextBox = CType(sender, TextBox)
        txtCompanyName.Text = hdnCom.Value
    End Sub

    Protected Sub FormViewCompany_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles FormViewCompany.ItemInserted
        btnContactInfo.Visible = False
    End Sub



    Protected Sub SQLDataSourceCompany_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceCompany.Selected
        If e.AffectedRows = 0 Then
            FormViewCompany.ChangeMode(FormViewMode.Insert)
            btnContactInfo.Visible = True
        End If
        If FormViewCompany.CurrentMode = FormViewMode.ReadOnly Then
            ButtonFinishedCompany.Visible = True
        Else
            ButtonFinishedCompany.Visible = False
        End If
    End Sub



    Protected Sub HTMLDecode_PreRender(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
        Next
    End Sub

    'Protected Sub CountryDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
    '    ' Add code to switch the state
    '    Dim StateDDL As DropDownList = CType(FormViewCompany.FindControl("StateProvinceDropDownList"), DropDownList)

    '    Dim HoldTopItem As ListItem = StateDDL.Items(0)
    '    StateDDL.Items.Clear()
    '    StateDDL.Items.Add(HoldTopItem)
    '    StateDDL.DataBind()


    'End Sub

    Protected Sub btnContactInfo_Click(sender As Object, e As EventArgs) Handles btnContactInfo.Click
        Dim PersonData = BattellePersonGetAsDataRow(hdnVal.Value)
        If FormViewCompany.CurrentMode <> FormViewMode.ReadOnly Then
            Dim Address1TextBox As TextBox = CType(FormViewCompany.FindControl("AddressLine1TextBox"), TextBox)
            Dim Address2TextBox As TextBox = CType(FormViewCompany.FindControl("AddressLine2TextBox"), TextBox)
            Dim Address3TextBox As TextBox = CType(FormViewCompany.FindControl("AddressLine3TextBox"), TextBox)
            Dim CityTextBox As TextBox = CType(FormViewCompany.FindControl("CityTextBox"), TextBox)
            Dim ZipPostalTextBox As TextBox = CType(FormViewCompany.FindControl("ZipPostalTextBox"), TextBox)
            Dim StateProvinceDropDownList As DropDownList = CType(FormViewCompany.FindControl("StateProvinceDropDownList"), DropDownList)
            Dim CountryDropDownList As DropDownList = CType(FormViewCompany.FindControl("CountryDropDownList"), DropDownList)

            Address1TextBox.Text = PersonData("AddressLine1")
            If PersonData("AddressLine2").ToString <> "" Then
                Address2TextBox.Text = PersonData("AddressLine2")
            End If
            If PersonData("AddressLine3").ToString <> "" Then
                Address3TextBox.Text = PersonData("AddressLine3")
            End If
            CityTextBox.Text = PersonData("City")
            ZipPostalTextBox.Text = PersonData("ZipPostal")


            CountryDropDownList.SelectedValue = PersonData("Country")
            StateProvinceDropDownList.SelectedValue = PersonData("StateProvince")
            'StateProvinceDropDownList.Items.Insert(0, New ListItem(PersonData("StateProvince"), PersonData("StateProvinceAbbreviation")))
            'StateProvinceDropDownList.SelectedIndex = 0


        End If

        btnContactInfo.Visible = False
    End Sub

    Protected Sub FormViewCompany_DataBound(sender As Object, e As EventArgs) Handles FormViewCompany.DataBound
        ExhibitorID = FormViewCompany.DataKey.Value
    End Sub


    Protected Sub ButtonFinishedCompany_Click(sender As Object, e As EventArgs) Handles ButtonFinishedCompany.Click
        Dim RaiseTheEvent As Boolean = False

        'Dim ValidationFailures As NameValueCollection = New NameValueCollection()

        'If FormViewPerson.SelectedValue IsNot Nothing Then
        '    Dim PersonID As Integer = FormViewPerson.SelectedValue
        '    Dim PersonData As DataRow = BattellePersonGetAsDataRow(PersonID)
        '    RaiseTheEvent = BattelleValidatePersonData(PersonData, True, ValidationFailures)

        'End If


        'If RaiseTheEvent Then
            RaiseEvent FinishedLogin()
        'Else
        '    LabelIsPersonDataValid.Text = String.Empty

        '    For Each Item As String In ValidationFailures
        '        If Not String.IsNullOrWhiteSpace(LabelIsPersonDataValid.Text) Then
        '            LabelIsPersonDataValid.Text += "<br />"
        '        End If
        '        LabelIsPersonDataValid.Text += ValidationFailures(Item)
        '    Next

        '    LabelIsPersonDataValid.Visible = True
        'End If

    End Sub

    Protected Sub FormViewCompany_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles FormViewCompany.ItemInserting
        Dim sOrgID As String
        Dim sExhibitor As TextBox = CType(FormViewCompany.FindControl("txtCompanyName"), TextBox)

        e.Values("Country") = HttpUtility.HtmlEncode(e.Values("Country"))
        e.Values("StateProvince") = HttpUtility.HtmlEncode(e.Values("StateProvince"))

        sOrgID = BattelleGenerateOrganizationID(sExhibitor.Text)
        SqlDataSourceCompany.InsertParameters.Add("OrganizationID", DbType.String, sOrgID)
    End Sub

    Protected Sub FormViewCompany_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormViewCompany.ItemUpdating
        e.NewValues("Country") = HttpUtility.HtmlEncode(e.NewValues("Country"))
        e.NewValues("StateProvince") = HttpUtility.HtmlEncode(e.NewValues("StateProvince"))
    End Sub
End Class