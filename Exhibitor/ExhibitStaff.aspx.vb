Imports Microsoft.AspNet.Identity

Public Class ExhibitorStaff
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Dim iSteps As Integer = 9
    Dim dv As DataView
    Dim gb As DataView
    Dim irows As Integer
    Dim brows As Integer

    Dim sExhibOrSponsor As String = Page.RouteData.Values("type").ToString

    Public Property ExhibitorOrSponsor() As String
        Get
            If (ViewState("ExhibitorOrSponsor") IsNot Nothing) Then
                Return CType(ViewState("ExhibitorOrSponsor"), String)
            Else
                Return "Exhibitor"
            End If
        End Get
        Set(value As String)
            ViewState("ExhibitorOrSponsor") = value
        End Set
    End Property
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        'If Not Session("BoothID").ToString = "" Then
        '    SqlDataSourceStaff.DeleteParameters("BoothID").DefaultValue = Session("BoothID")
        '    SqlDataSourceStaff.InsertParameters("BoothID").DefaultValue = Session("BoothID")
        'End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
                hdnNewStart.Value = "No"
                GetExhibInfo()
                GetFee()
                'PanelStaff.Visible = True
                'gvStaff.DataBind()
                PanelProgress.Visible = False 'Continuing from Booth Reservation
                UpdateProgress(iProgress(6), 6, iSteps, "")
                'btnNext.Visible = True
            Else
                PanelParticipationControl.Visible = True
                PanelProgress.Visible = False
                btnNext.Visible = False
                hdnNewStart.Value = "Yes"
                iSteps = 3
                UpdateProgress(iProgress(1), 1, iSteps, "")
            End If



            If sExhibOrSponsor = "sponsor" Then
                ExhibitorOrSponsor = "Sponsor"
            End If




        End If


    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
        'Response.Cookies("battelle")("PersonID") = PersonID 'removed Session("PersonID") on 8/25/2015
        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        ParticipationIDLogin.Visible = False
        PanelParticipationControl.Visible = False
        'If Session("ExhibitorID") <> "" Then
        If Session("ExhibitorID") Then
            PanelStaff.Visible = True
            btnNext.Visible = True
            'gvStaff.DataBind()
        Else
            GetExhibInfo()
        End If

        GetFee()

        'If Not IsNothing(PersonData) Then

        'End If

        UpdateProgress(iProgress(2), 2, 3, "")
        'btnNext.Visible = True
        lblAlert.Visible = False

    End Sub

    Sub GetExhibInfo()
        SqlDataSourceCompany.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        SqlDataSourceCompany.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID


        SqlDataSourceConfirmation.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        SqlDataSourceConfirmation.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID




        Dim islandBooth As String = "False"
        Dim booth1, booth2 As String
        Dim boothCount As Integer = 0

        gb = CType(SqlDataSourceConfirmation.Select(DataSourceSelectArguments.Empty), DataView)
        brows = gb.Table.Rows.Count
        If brows > 0 Then
            booth1 = gb.Table.Rows(0).Item("BoothNumber").ToString
            booth2 = gb.Table.Rows(0).Item("BoothNumber2").ToString

            If Not String.IsNullOrEmpty(booth1) Then
                boothCount = boothCount + 1
            End If

            If Not String.IsNullOrEmpty(booth2) Then
                boothCount = boothCount + 1
            End If
        End If


        dv = CType(SqlDataSourceCompany.Select(DataSourceSelectArguments.Empty), DataView)
        irows = dv.Table.Rows.Count
        If irows > 0 Then ' Data found is an exhibitor POC
            lblCompanyName.Text = dv.Table.Rows(0).Item("Exhibitor").ToString

            'Recreate cookie to preserve PersonID when adding Exhibitor and Booth ID values.
            'Response.Cookies("battelle")("PersonID") = Request.Cookies("battelle")("PersonID")
            Dim ExhibitorID As Integer = dv.Table.Rows(0).Item("ExhibitorID").ToString
            If Not Session("ExhibitorID") Then
                Session("ExhibitorID") = ExhibitorID
            End If
            Dim BoothID As Integer = dv.Table.Rows(0).Item("BoothID").ToString
            If Not Session("BoothID") Then
                Session("BoothID") = BoothID
            End If

            PanelStaff.Visible = True
            SqlDataSourceStaff.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceStaff.SelectParameters("ExhibitorID").DefaultValue = ExhibitorID 'Session("ExhibitorID")

            'SqlDataSourceStaff.DeleteParameters("BoothID").DefaultValue = dv.Table.Rows(0).Item("BoothID").ToString 'Request.Cookies("battelle")("BoothID")

            '****Likely need to delete this
            'gvStaff.DataBind()
            'islandBooth = dv.Table.Rows(0).Item("IslandBooth").ToString
            'If islandBooth = "True" Then
            '    lblComplimentary.Text = "six"
            '    hdnStaffSlots.Value = 6
            'ElseIf boothCount = 2 Then
            '    lblComplimentary.Text = "four"
            '    hdnStaffSlots.Value = 4
            'ElseIf boothCount = 1 Then
            '    lblComplimentary.Text = "two"
            '    hdnStaffSlots.Value = 2
            'End If



            btnNext.Visible = True
            'if closed remove Add Staff button
            If Not Context.User.Identity.GetUserName() = "SCGadmin" Then
                If ConferenceControl.BoothStaffRegisterByDate <= Now() Then
                    btnAddStaff.Visible = False
                    lblAlert.Text = "<div class=""alert alert-warning"" role=""alert"">Booth Staff online reservation is now closed. Please see the registration desk on site.</div>"
                    lblAlert.Visible = True
                End If
            End If
        Else 'Not an Exhbitor POC
            PanelExhibitor.Visible = True
            'lblMessage.Visible = True
            PanelStaff.Visible = False
            btnNext.Visible = False
        End If
    End Sub

    Sub GetFee()
        

        hdnFee.Value = 0
        lblFee.Text = 0
        'Only a fee after 2 staff

        SqlDataSourceLedger.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

        SqlDataSourceLedger.SelectParameters("PersonID").DefaultValue = Session("PersonID").ToString 'ParticipationIDLogin.UserPersonID() 'Request.Cookies("battelle")("PersonID")

        dv = CType(SqlDataSourceLedger.Select(DataSourceSelectArguments.Empty), DataView)

        irows = CType(dv.Table.Rows.Count, Integer)
        If irows > 0 Then ' Data found
            hdnItemCount.Value = dv.Table.Rows(0).Item("FeeCount").ToString
        Else
            hdnItemCount.Value = 0
        End If

        'Get fee to add Staff
        SqlDataSourceFees.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        dv = CType(SqlDataSourceFees.Select(DataSourceSelectArguments.Empty), DataView)
        hdnFee.Value = dv.Table.Rows(0).Item("Fee").ToString
        hdnLateFeeAmount.Value = dv.Table.Rows(0).Item("LateFeeAmount").ToString
        hdnLateFeeDate.Value = dv.Table.Rows(0).Item("LateFeeDate")
        If hdnLateFeeDate.Value <= Date.Now Then
            lblFee.Text = hdnLateFeeAmount.Value
        End If
        ltlFee.Text = hdnFee.Value

        'If hdnItemCount.Value >= 2 Then 'two staff registered for free
        '    lblFee.Text = hdnFee.Value
        'End If
        PanelInstructions.Visible = True
        PanelPreInstructions.Visible = False



    End Sub

    Protected Sub btnAddStaff_Click(sender As Object, e As EventArgs) Handles btnAddStaff.Click
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            TextBoxPersonEmail.Text = ""
            LabelPersonLookupResult.Text = String.Empty
            FormViewPersonLookup.DataBind()
            PanelPersonAdd.Visible = True
            FormViewPersonLookup.Visible = False
            btnNext.Visible = False
            btnCancel.Visible = True
            btnAddStaff.Visible = False
        Else
            'Session timeout
            SessionTimeout()
        End If

    End Sub

    Protected Sub SelectButton_Click(sender As Object, e As EventArgs)
        If Not Session("BoothID").ToString = "" Then
            FormViewPersonLookup.DataBind()
            Dim DataRow As DataRowView = CType(FormViewPersonLookup.DataItem, DataRowView)
            Dim DataKey As Integer = DataRow("PersonID")
            'AbstractAuthorsAdd(DataRow("FirstName"), DataRow("LastName"), DataKey)



            'This was moved from NextButton_Click to stop somebody from adding staff without paying
            'Tally staff vs. ledger

            Dim iStaffCount As Integer = 0
            Dim iLedger As Integer = 0
            Dim iFee As Integer = lblFee.Text
            iStaffCount = hdnStaffCount.Value
            iLedger = hdnItemCount.Value 'Number of staff in the ledger

            '---No longer need to add the fee if late. The lable updates properly, so this was duplicating the amount owed.
            'If hdnLateFeeDate.Value <= Date.Now Then
            'iFee = iFee + hdnLateFeeAmount.Value
            'End If


            SqlDataSourceStaff.InsertParameters("PersonID").DefaultValue = DataKey
            SqlDataSourceStaff.Insert()
            iStaffCount += 1 'Just added a staff member, increase count

            If iLedger < iStaffCount Then
                'For i As Integer = (iLedger + 1) To iStaffCount


                'If hdnStaffSlots.Value = 2 Then 'If Request.Cookies("battelle")("FreeStaffSlots") = 2 Then 'Session("StaffCount") = 2 Then
                '    If i > 2 Then
                '        iFee = hdnFee.Value
                '    End If
                'ElseIf hdnStaffSlots.Value = 4 Then
                '    If i > 4 Then
                '        iFee = hdnFee.Value
                '    End If
                'ElseIf hdnStaffSlots.Value = 6 Then
                '    If i > 6 Then
                '        iFee = hdnFee.Value
                '    End If
                'End If

                SqlDataSourceLedger.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                    SqlDataSourceLedger.InsertParameters("PersonID").DefaultValue = Session("PersonID") 'removed Session("PersonID") on 8/25/2015
                    SqlDataSourceLedger.InsertParameters("Amount").DefaultValue = iFee
                    SqlDataSourceLedger.Insert()
                    hdnItemCount.Value = hdnItemCount.Value + 1
                'Next
            End If
            btnCancel.Visible = False
            'btnAddStaff.Visible = True
            btnNext.Visible = True
        Else
            'Session timeout
            SessionTimeout()
        End If


    End Sub

    Protected Sub UpdateProgress(iProgress As Integer, iStep As Integer, iSteps As Integer, sStatus As String)

        lblProgress.Text = "<div class=""progress-bar" & sStatus & """ role=""progressbar"" aria-valuenow=""" & iProgress & """ aria-valuemin=""0"" aria-valuemax=""100"" style=""width: " & iProgress & "%;"">Step " & iStep & " of " & iSteps & "</div>"
    End Sub

    Function iProgress(iCurrent As Integer) As Integer
        If hdnNewStart.Value = "Yes" Then
            iSteps = 3
        End If
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
        Dim iLedger, iStaffCount As Integer
        Dim FreeFee As Integer = 0

        If hdnLateFeeDate.Value <= Date.Now Then
            FreeFee = hdnLateFeeAmount.Value
        End If

        iStaffCount = e.AffectedRows 'Number of current staff
        hdnStaffCount.Value = iStaffCount
        iLedger = hdnItemCount.Value
        lblLedgerHasMoreStaff.Visible = False


        'Calculate Staff fees based on Matrix
        SqlDataSourceStaffMatrix.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        SqlDataSourceStaffMatrix.SelectParameters("ExhibitorID").DefaultValue = Session("ExhibitorID")

        dv = CType(SqlDataSourceStaffMatrix.Select(DataSourceSelectArguments.Empty), DataView)
        irows = dv.Table.Rows.Count
        If irows > 0 Then ' Data found is an exhibitor POC
            Dim iBoothStaffLimit As Integer = dv.Table.Rows(0).Item("BoothStaffLimit").ToString
            hdnStaffSlots.Value = iBoothStaffLimit
            Dim iRemainingFreeBoothStaff As Integer = dv.Table.Rows(0).Item("RemainingFreeBoothStaff").ToString
            lblComplimentary.Text = iRemainingFreeBoothStaff
            If iRemainingFreeBoothStaff > 0 Then
                lblFee.Text = FreeFee
            Else
                'If more staff in ledger than in staff table, somebody was removed, so next person free (already purchased)
                If iLedger > iStaffCount Then
                    lblFee.Text = "0" 'Added staff before deadline or already paid late fee
                    lblLedgerHasMoreStaff.Visible = True
                Else
                    lblFee.Text = hdnFee.Value
                End If
            End If
            Dim iRemainingTotalBoothStaff As Integer = dv.Table.Rows(0).Item("RemainingTotalBoothStaff").ToString
            If iRemainingTotalBoothStaff > 0 Then
                btnAddStaff.Visible = True
                lblFee.Visible = True
                lblFeeLabel.Visible = True
                lblStaffLimitReached.Visible = False
            Else
                btnAddStaff.Visible = False
                lblFee.Visible = False
                lblFeeLabel.Visible = False
                lblStaffLimitReached.Visible = True
            End If
        End If


        'If iLedger >= 2 Then 'two or more staff paid for
        '    If iStaffCount >= iLedger Then 'More staff added than paid for
        '        lblFee.Text = hdnFee.Value
        '    Else
        '        lblFee.Text = FreeFee
        '    End If
        'Else 'less than 2 staff paid for



        '    If hdnStaffSlots.Value = 2 Then
        '        'If Request.Cookies("battelle")("FreeStaffSlots") = 2 Then 'If Session("StaffCount") = 2 Then
        '        If iStaffCount >= 2 Then
        '            lblFee.Text = hdnFee.Value
        '        Else
        '            lblFee.Text = FreeFee
        '        End If
        '    ElseIf hdnStaffSlots.Value = 4 Then
        '        If iStaffCount >= 4 Then 'if 2 staff members are already selected
        '            lblFee.Text = hdnFee.Value
        '        Else
        '            lblFee.Text = FreeFee
        '        End If
        '    ElseIf hdnStaffSlots.Value = 6 Then
        '        If iStaffCount >= 6 Then 'if 2 staff members are already selected
        '            lblFee.Text = hdnFee.Value
        '        Else
        '            lblFee.Text = FreeFee
        '        End If
        '    End If



        'End If


        'If iStaffCount >= 4 And hdnStaffSlots.Value = 2 Then 'Session("StaffCount") = 2 Then
        '    btnAddStaff.Visible = False
        '    lblFee.Visible = False
        '    lblFeeLabel.Visible = False
        'ElseIf iStaffCount >= 6 And hdnStaffSlots.Value = 4 Then
        '    btnAddStaff.Visible = False
        '    lblFee.Visible = False
        '    lblFeeLabel.Visible = False
        'ElseIf iStaffCount >= 8 And hdnStaffSlots.Value = 6 Then
        '    btnAddStaff.Visible = False
        '    lblFee.Visible = False
        '    lblFeeLabel.Visible = False
        'Else
        '    btnAddStaff.Visible = True
        'End If


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
            ValidationSummary.Text = "<div Class=""alert alert-danger"" role=""alert"">"

            For Each Item As String In ValidationFailures
                If Not String.IsNullOrWhiteSpace(ValidationSummary.Text) Then
                    ValidationSummary.Text += "<br />"
                End If
                ValidationSummary.Text += ValidationFailures(Item)
            Next
            ValidationSummary.Text += "</div>"
        End If
    End Sub

    'Protected Sub btnOrgID_Click(sender As Object, e As EventArgs) Handles btnOrgID.Click
    '    If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
    '        If txtOrgID.Text.Trim <> "" Then
    '            SqlDataSourceOrgID.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
    '            SqlDataSourceOrgID.SelectParameters("OrganizationID").DefaultValue = txtOrgID.Text
    '            dv = CType(SqlDataSourceOrgID.Select(DataSourceSelectArguments.Empty), DataView)
    '            irows = CType(dv.Table.Rows.Count, Integer)
    '            If irows > 0 Then ' Data found
    '                Dim iExhibID, iSessionID As Integer
    '                iExhibID = dv.Table.Rows(0).Item("ExhibitorID").ToString
    '                iSessionID = dv.Table.Rows(0).Item("BoothID").ToString

    '                If Not IsNothing(iExhibID) Then
    '                    GetExhibInfo()
    '                End If

    '            Else
    '                lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your organization has not reserved a booth. Ensure you have the correct Organization ID.</div>"
    '                lblAlert.Visible = True
    '            End If
    '        End If
    '    Else
    '        SessionTimeout()
    '    End If

    'End Sub


    Protected Sub LinkButtonPersonLookup2_Click(sender As Object, e As EventArgs) Handles LinkButtonPersonLookup2.Click
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            If TextBoxPersonEmail.Text.Trim <> "" Then
                PanelPersonLookup.Visible = True
                FormViewPersonLookup.Visible = True
                FormViewPersonLookup.DataBind()
                If FormViewPersonLookup.SelectedValue Is Nothing Then
                    LabelPersonLookupResult.Text = "<div class=""alert alert-warning"" role=""alert"">Staff member not found. Try an alternate email address or enter their infomation by clicking the ""Enter Staff Member information"" button below.</div>"
                Else
                    LabelPersonLookupResult.Text = String.Empty
                End If
            Else
                PanelPersonLookup.Visible = True
                LabelPersonLookupResult.Text = "<div class=""alert alert-danger"" role=""alert"">Please enter an email address</div>"
            End If
        Else
            SessionTimeout()
        End If

    End Sub

    Protected Sub FormViewPersonLookup_PreRender(sender As Object, e As EventArgs) Handles FormViewPersonLookup.PreRender
        If FormViewPersonLookup.CurrentMode = FormViewMode.Insert Then
            Dim EmailTextBox As HiddenField = FormViewPersonLookup.FindControl("EmailTextBox")
            Dim EmailTextBoxDisabled As TextBox = FormViewPersonLookup.FindControl("EmailTextBoxDisabled") 'fake textbox to match formatting
            EmailTextBox.Value = TextBoxPersonEmail.Text.Trim
            EmailTextBoxDisabled.Text = TextBoxPersonEmail.Text.Trim
        End If
    End Sub

    Protected Sub FormViewPersonLookup_ModeChanged(sender As Object, e As EventArgs) Handles FormViewPersonLookup.ModeChanged
        PanelPersonAdd.Visible = False
    End Sub


    Protected Sub btnNext_Click(sender As Object, e As EventArgs) Handles btnNext.Click
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then



            'THIS IS WHERE IT WAS UPDATING LEDGER - MOVED TO ADD STAFF



            If hdnNewStart.Value = "Yes" Then
                'Go to Payment
                'Dim sURL As String = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/balance"
                Dim sURL As String = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/exhibitor/balance"
                Response.Redirect(sURL, True)
            Else
                'SCGTODO - go to Technical Reg
                'Dim sURL As String = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/balance"
                Dim sURL As String = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/exhibitor/balance"
                Response.Redirect(sURL, True)
            End If
        Else
            'Session timeout
            SessionTimeout()
        End If
    End Sub

    Protected Sub SqlDataSourceStaff_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceStaff.Inserted


        'SqlDataSourceStaff.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        'SqlDataSourceStaff.SelectParameters("ExhibitorID").DefaultValue = Session("ExhibitorID")


        gvStaff.DataBind()

        PanelPersonAdd.Visible = False
        PanelPersonLookup.Visible = False
    End Sub

    Protected Sub SqlDataSourceStaff_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceStaff.Deleted
        'Show option to add staff after deletion
        btnAddStaff.Visible = True
        lblStaffLimitReached.Visible = False
    End Sub

    Protected Sub SessionTimeout()
        ParticipationIDLogin.Visible = True
        PanelParticipationControl.Visible = True
        PanelStaff.Visible = False
        lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your session has timed out. Please re-enter your Participation Code.</div>"
        lblAlert.Visible = True
        btnNext.Visible = False
        PanelInstructions.Visible = False
        btnCancel.Visible = False
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        btnCancel.Visible = False
        btnNext.Visible = True
        btnAddStaff.Visible = True
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
    End Sub
End Class