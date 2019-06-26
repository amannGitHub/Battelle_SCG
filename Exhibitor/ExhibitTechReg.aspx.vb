Public Class ExhibitTechReg
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Dim iSteps As Integer = 9
    Dim dv As DataView
    Dim irows As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
                hdnNewStart.Value = "No"
                GetExhibInfo()
                PanelStaff.Visible = True
                PanelProgress.Visible = True 'Continuing from Booth Reservation
                UpdateProgress(iProgress(6, iSteps), 6, iSteps, "")
            Else
                PanelParticipationControl.Visible = True
                PanelProgress.Visible = True
                hdnNewStart.Value = "Yes"
                iSteps = 3
                UpdateProgress(iProgress(1, iSteps), 1, iSteps, "")
            End If


        End If

        'Only a fee after 2 staff
        SqlDataSourceItemCount.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        dv = CType(SqlDataSourceItemCount.Select(DataSourceSelectArguments.Empty), DataView)

        irows = CType(dv.Table.Rows.Count, Integer)
        If irows > 0 Then ' Data found
            hdnItemCount.Value = dv.Table.Rows(0).Item("FeeCount").ToString
        Else
            hdnItemCount.Value = 0
        End If

        If hdnItemCount.Value >= 2 Then
            hdnFee.Value = 0
        Else
            'Get fee to add Staff
            SqlDataSourceLedger.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            dv = CType(SqlDataSourceLedger.Select(DataSourceSelectArguments.Empty), DataView)
            hdnFee.Value = dv.Table.Rows(0).Item("Fee").ToString
        End If


    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        ParticipationIDLogin.Visible = False
        PanelParticipationControl.Visible = False
        If Session("ExhibitorID") <> "" Then
            PanelStaff.Visible = True
        Else
            GetExhibInfo()
        End If


        'If Not IsNothing(PersonData) Then

        'End If

        UpdateProgress(iProgress(2, iSteps), 2, 3, "")

    End Sub

    Sub GetExhibInfo()
        SqlDataSourceCompany.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        SqlDataSourceCompany.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        dv = CType(SqlDataSourceCompany.Select(DataSourceSelectArguments.Empty), DataView)
        irows = CType(dv.Table.Rows.Count, Integer)
        If irows > 0 Then ' Data found
            lblCompanyName.Text = dv.Table.Rows(0).Item("Exhibitor").ToString
            Session("ExhibitorID") = dv.Table.Rows(0).Item("ExhibitorID").ToString
            Session("BoothID") = dv.Table.Rows(0).Item("BoothID").ToString
            SqlDataSourceStaff.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceStaff.SelectParameters("ExhibitorID").DefaultValue = Session("ExhibitorID")
            PanelStaff.Visible = True
        Else
            PanelExhibitor.Visible = True
        End If
    End Sub

    Protected Sub btnAddStaff_Click(sender As Object, e As EventArgs) Handles btnAddStaff.Click
        TextBoxPersonEmail.Text = ""
        LabelPersonLookupResult.Text = String.Empty
        FormViewPersonLookup.DataBind()
        PanelPersonAdd.Visible = True
        FormViewPersonLookup.Visible = False
    End Sub

    Protected Sub SelectButton_Click(sender As Object, e As EventArgs)
        FormViewPersonLookup.DataBind()
        Dim DataRow As DataRowView = CType(FormViewPersonLookup.DataItem, DataRowView)
        Dim DataKey As Integer = DataRow("PersonID")
        'AbstractAuthorsAdd(DataRow("FirstName"), DataRow("LastName"), DataKey)

        SqlDataSourceStaff.InsertParameters("BoothID").DefaultValue = Session("BoothID")
        SqlDataSourceStaff.InsertParameters("PersonID").DefaultValue = DataKey
        SqlDataSourceStaff.Insert()

    End Sub

    Protected Sub UpdateProgress(iProgress As Integer, iStep As Integer, iSteps As Integer, sStatus As String)

        lblProgress.Text = "<div class=""progress-bar" & sStatus & """ role=""progressbar"" aria-valuenow=""" & iProgress & """ aria-valuemin=""0"" aria-valuemax=""100"" style=""width: " & iProgress & "%;"">Step " & iStep & " of " & iSteps & "</div>"
    End Sub

    Function iProgress(iCurrent As Integer, iSteps As Integer) As Integer
        'If hdnNewStart.Value = "Yes" Then
        'iSteps = 3
        'End If
        iProgress = ((iCurrent / iSteps) * 100)
        Return iProgress
    End Function

    Protected Sub HtmlDecode_PreRender(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
        Next
    End Sub

    Protected Sub SqlDataSourceStaff_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceStaff.Selected
        If e.AffectedRows >= 2 Then
            Me.btnAddStaff.Visible = False
            lblFee.Visible = False
            lblFeeLabel.Visible = False
        End If
    End Sub

    Protected Sub FormViewPersonLookup_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles FormViewPersonLookup.ItemInserting
        'Dim CountryDDL As DropDownList = CType(FormViewPersonLookup.FindControl("CountryDropDownList"), DropDownList)
        'Dim StateDDL As DropDownList = CType(FormViewPersonLookup.FindControl("StateProvinceDropDownList"), DropDownList)
        'e.Values("Country") = CountryDDL.SelectedItem.Text
        'e.Values("StateProvince") = StateDDL.SelectedValue
        e.Values("Country") = HttpUtility.HtmlEncode(e.Values("Country"))
        e.Values("StateProvince") = HttpUtility.HtmlEncode(e.Values("StateProvince"))

        Dim ValidationFailures As NameValueCollection = New NameValueCollection()
        e.Cancel = Not BattelleValidatePersonDataDictionary(e.Values, False, ValidationFailures)
        If e.Cancel Then
            Dim ValidationSummary As Label = FormViewPersonLookup.FindControl("LabelDataValidationSummary")
            ValidationSummary.Text = String.Empty

            For Each Item As String In ValidationFailures
                If Not String.IsNullOrWhiteSpace(ValidationSummary.Text) Then
                    ValidationSummary.Text += "<br />"
                End If
                ValidationSummary.Text += ValidationFailures(Item)
            Next
        End If
    End Sub

    Protected Sub btnOrgID_Click(sender As Object, e As EventArgs) Handles btnOrgID.Click
        If txtOrgID.Text.Trim <> "" Then
            SqlDataSourceOrgID.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceOrgID.SelectParameters("OrganizationID").DefaultValue = txtOrgID.Text
            dv = CType(SqlDataSourceOrgID.Select(DataSourceSelectArguments.Empty), DataView)
            irows = CType(dv.Table.Rows.Count, Integer)
            If irows > 0 Then ' Data found
                Dim iExhibID As Integer
                iExhibID = dv.Table.Rows(0).Item("ExhibitorID").ToString
                If Not IsNothing(iExhibID) Then
                    Session("ExhibitorID") = iExhibID
                    GetExhibInfo()
                End If
                Session("BoothID") = dv.Table.Rows(0).Item("BoothID").ToString
            Else
                lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your organization has not reserved a booth. Ensure you have the correct Organization ID.</div>"
                lblAlert.Visible = True
            End If
        End If
    End Sub


    Protected Sub LinkButtonPersonLookup2_Click(sender As Object, e As EventArgs) Handles LinkButtonPersonLookup2.Click
        PanelPersonLookup.Visible = True
        FormViewPersonLookup.Visible = True
        FormViewPersonLookup.DataBind()
        If FormViewPersonLookup.SelectedValue Is Nothing Then
            LabelPersonLookupResult.Text = "Staff member not found. Try an alternate email address or enter their infomation by clicking the ""Enter Staff Member information"" button below."
        Else
            LabelPersonLookupResult.Text = String.Empty
        End If
    End Sub



    Protected Sub FormViewPersonLookup_ModeChanged(sender As Object, e As EventArgs) Handles FormViewPersonLookup.ModeChanged
        PanelPersonAdd.Visible = False
    End Sub


    Protected Sub btnNext_Click(sender As Object, e As EventArgs) Handles btnNext.Click
        'Go to payment tally page

        Dim sURL As String = "~/" & ConferenceControl.ConferenceURLString & "/payment"
        Response.Redirect(sURL, True)


    End Sub

    Protected Sub SqlDataSourceStaff_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceStaff.Inserted
        If hdnItemCount.Value < 2 Then 'Only add to ledger if not ful for this item (allows edits)
            SqlDataSourceLedger.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceLedger.InsertParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourceLedger.InsertParameters("Amount").DefaultValue = Me.lblFee.Text
            SqlDataSourceLedger.Insert()

            SqlDataSourceStaff.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceStaff.SelectParameters("ExhibitorID").DefaultValue = Session("ExhibitorID")

        End If
        gvStaff.DataBind()

        PanelPersonAdd.Visible = False
        PanelPersonLookup.Visible = False
    End Sub

    Protected Sub SqlDataSourceItemCount_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceItemCount.Selected

    End Sub
End Class
