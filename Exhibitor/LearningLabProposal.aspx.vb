Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Public Class LearningLabProposal
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL
    Public sConferenceType As String

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        ConferenceControl = Master.FindControl("ConferenceFromURL")
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.Form.Attributes.Add("enctype", "multipart/form-data")

    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()

        PanelParticipationControl.Visible = False

        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        If Not IsNothing(PersonData) Then
            Dim hdnVal As New HiddenField
            hdnVal = CType(CompanyInfo.FindControl("hdnVal"), HiddenField)
            If Not hdnVal Is Nothing Then
                hdnVal.Value = PersonID
            End If
            Dim hdnCom As New HiddenField
            hdnCom = CType(CompanyInfo.FindControl("hdnCom"), HiddenField)
            If Not hdnCom Is Nothing Then
                hdnCom.Value = PersonData("Employer")
            End If
        End If
        'PanelExhibitorInfo.Visible = True

        Session("PersonID") = PersonID

        'Set Form variables
        With lnkConferenceEmail
            .NavigateUrl = "mailto:" & ConferenceControl.ConferenceSubjectEmail
            .Text = ConferenceControl.ConferenceSubjectEmail
        End With

        PanelForm.Visible = True
        PanelInstructions.Visible = False

        '***THIS HERE?
        EnterAbstract()

    End Sub

    'Protected Sub CompanyInfo_Finished() Handles CompanyInfo.FinishedLogin

    '    If Not hdnVal Is Nothing Then
    '        hdnVal.Value = CompanyInfo.ExhibitorID
    '    End If
    '    Session("ExhibitorID") = CompanyInfo.ExhibitorID

    '    PanelForm.Visible = True

    '    'Set Form variables
    '    With lnkConferenceEmail
    '        .NavigateUrl = "mailto:" & ConferenceControl.ConferenceSubjectEmail
    '        .Text = ConferenceControl.ConferenceSubjectEmail
    '    End With

    '    PanelExhibitorInfo.Visible = False
    '    PanelInstructions.Visible = False

    '    '***THIS HERE?
    '    EnterAbstract()

    'End Sub

    Protected Sub btnAgree_Click(sender As Object, e As EventArgs) Handles btnAgree.Click


        Dim bPass As Boolean = True
        If chkTerms.Checked = False Then
            Me.lblTermsMessage.Text = "<div class=""alert alert-danger"" role=""alert"">You must indicate that you have read and agree to the Terms and Conditions.</div>"
            Me.lblTermsMessage.Visible = True
            bPass = False
        Else
            Me.lblTermsMessage.Visible = False
        End If

        If bPass = True Then
            PanelTerms.Visible = False
            PanelParticipationControl.Visible = True
            'Page.Title = "Sponsorship Selection"
            'ltlConferenceType.Text = ConferenceControl.ConferenceType
            'lnkConferenceEmail.Text = ConferenceControl.ConferenceSubjectEmail
            'lnkConferenceEmail.NavigateUrl = "mailto:" & ConferenceControl.ConferenceSubjectEmail
        End If

    End Sub

    'Protected Sub CheckUser()
    '    Dim PersonID As Integer

    '    If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
    '        PersonID = Session("PersonID")

    '        PanelParticipationControl.Visible = False
    '        PanelForm.Visible = True
    '    Else
    '        PanelParticipationControl.Visible = True
    '        PanelForm.Visible = False
    '    End If


    'End Sub

    Protected Sub EnterAbstract()
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        ParticipationIDLogin.Visible = False
        PanelParticipationControl.Visible = False
        If Not IsNothing(PersonData) Then
            AbstractInstructorsAdd(PersonData("FirstName"), PersonData("LastName"), PersonID)
            lblCorPresInstructor.Text = PersonData("FirstName") + " " + PersonData("LastName")
            hdnCorPres.Value = PersonID
        End If

        PanelForm.Visible = True
        PanelAbstractConfirmation.Visible = False

    End Sub

    Protected Sub LinkButtonPersonLookup_Click(sender As Object, e As EventArgs) Handles LinkButtonPersonLookup2.Click
        FormViewPersonLookup.Visible = True
        FormViewPersonLookup.DataBind()
        If FormViewPersonLookup.SelectedValue Is Nothing Then
            LabelPersonLookupResult.Text = "<div class=""alert alert-warning"" role=""alert"">This email address was not found in our system. Please carefully check what you typed and correct if necessary. Also, consider if the co-Instructor may have used an alternate email address (e.g., email related to a previous employer, personal email). Otherwise, click the &quot;Enter Co-Instructor information&quot; button below to enter the Co-Instructor&#39;s contact information.</div>"
        Else
            LabelPersonLookupResult.Text = "<div class=""alert alert-success"" role=""alert"">Co-Instructor located!</div>"
        End If
    End Sub

    Protected Sub SelectButton_Click(sender As Object, e As EventArgs)
        FormViewPersonLookup.DataBind()
        Dim DataRow As DataRowView = CType(FormViewPersonLookup.DataItem, DataRowView)
        Dim DataKey As Integer = DataRow("PersonID")
        AbstractInstructorsAdd(DataRow("FirstName"), DataRow("LastName"), DataKey)
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
        'ListBoxAbstractInstructors.Focus()
        Dim sm As ScriptManager = ScriptManager.GetCurrent(Me)
        sm.SetFocus(ListBoxAbstractInstructors)
    End Sub

    Protected Sub ButtonSubmitAbstract_Click(sender As Object, e As EventArgs) Handles ButtonSubmitAbstract.Click
        Dim IsValidAbstract As Boolean = True
        Dim ValidationFailures As NameValueCollection = New NameValueCollection()
        LabelAbstractValidation.Text = String.Empty

        If FormViewPersonLookup.Visible = True Then
            'A person lookup is in progress
            IsValidAbstract = False
            ValidationFailures.Add("Instructor Lookup in Progress", "You have initiated an Instructor lookup. Please complete or cancel the lookup.")
        End If


        If String.IsNullOrWhiteSpace(txtTitle.Text) Then
            IsValidAbstract = False
            ValidationFailures.Add("Title", "Please provide a Title.")
        End If

        If rblExhibitorYN.SelectedValue = "" Then
            IsValidAbstract = False
            ValidationFailures.Add("Exhibitor", "Please indicate if your company is also an Exhibitor.")
        End If
        If rblShippingFreightYN.SelectedValue = "" Then
            IsValidAbstract = False
            ValidationFailures.Add("Shipping Freight", "Please indicate if you will be shipping freight with my equipment for the Learning Lab demonstration.")
        End If
        If rblFreightTruckYN.SelectedValue = "" Then
            IsValidAbstract = False
            ValidationFailures.Add("Freight Truck", "Please indicate if you require a freight truck to move your equipment.")
        End If
        If rblFreightStorageYN.SelectedValue = "" Then
            IsValidAbstract = False
            ValidationFailures.Add("Exhibitor ", "Please indicate if you require freight storage for your equipment on-site.")
        End If
        If String.IsNullOrWhiteSpace(txtObjective.Text) Then
            IsValidAbstract = False
            ValidationFailures.Add("Objective", "Please provide an Objective.")
        End If
        If String.IsNullOrWhiteSpace(txtDescription.Text) Then
            IsValidAbstract = False
            ValidationFailures.Add("Description", "Please provide a Description.")
        End If


        If IsValidAbstract Then
            Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
            Dim PersonData = BattellePersonGetAsDataRow(PersonID)
            Dim topics = ""
            Dim topicsCodes = ""




            Dim InsertLearningLabCommand As SqlCommand = New SqlCommand("LearningLabInsert")

            ' Set rest of parameters using form data
            InsertLearningLabCommand.Parameters.AddWithValue("PersonID", PersonID)
            InsertLearningLabCommand.Parameters.AddWithValue("Title", txtTitle.Text.Trim())
            InsertLearningLabCommand.Parameters.AddWithValue("ExhibitorYN", rblExhibitorYN.SelectedValue)
            InsertLearningLabCommand.Parameters.AddWithValue("ShippingFreightYN", rblShippingFreightYN.SelectedValue)
            InsertLearningLabCommand.Parameters.AddWithValue("FreightTruckYN", rblFreightTruckYN.SelectedValue)
            InsertLearningLabCommand.Parameters.AddWithValue("FreightStorageYN", rblFreightStorageYN.SelectedValue)
            InsertLearningLabCommand.Parameters.AddWithValue("Objective", txtObjective.Text.Trim())
            InsertLearningLabCommand.Parameters.AddWithValue("Description", txtDescription.Text.Trim())

            ' conf id

            InsertLearningLabCommand.Parameters.AddWithValue("ConferenceID", ConferenceControl.ConferenceID)

            Dim DSReturnData As DataSet
            Dim PresenterPersonID As Integer
            Dim InstructorList As String = ""

            DSReturnData = BattelleExecuteCommand(InsertLearningLabCommand)
            If DSReturnData.Tables(0).Rows.Count > 0 Then
                Dim AbstractID = DSReturnData.Tables(0).Rows(0)(0)
                For Each LI As ListItem In ListBoxAbstractInstructors.Items

                    Dim POCInstructor As Boolean = False

                    If Integer.Parse(LI.Value) = hdnCorPres.Value Then
                        POCInstructor = True
                        PresenterPersonID = hdnCorPres.Value
                    End If
                    BattelleLearningLabInstructorsInsert(AbstractID, Integer.Parse(LI.Value), POCInstructor)
                    If InstructorList = "" Then
                        InstructorList = LI.Text
                    Else
                        InstructorList += ", " & LI.Text
                    End If
                Next
            Else
                ' Fail due to database issue
            End If

            Dim SubmittedConfirmationHTML As String = String.Empty

            SubmittedConfirmationHTML += "<p align=""left"">"
            SubmittedConfirmationHTML += "Title:<br /><b>" + InsertLearningLabCommand.Parameters("Title").Value.ToString() + "</b><br /><br />"
            SubmittedConfirmationHTML += "Instructors:<br /><b>" + InstructorList + "</b><br /><br />"
            SubmittedConfirmationHTML += "My company Is also an Exhibitor.<br /><b>" + rblExhibitorYN.SelectedItem.Text + "</b><br /><br />"
            SubmittedConfirmationHTML += "I will be shipping freight with my equipment for the Learning Lab demonstration.<br /><b>" + rblShippingFreightYN.SelectedItem.Text + "</b><br /><br />"
            SubmittedConfirmationHTML += "Will you require a freight truck to move your equipment to the Learning Lab space on-site at your assigned demonstration time?<br /><b>" + rblFreightTruckYN.SelectedItem.Text + "</b><br /><br />"
            SubmittedConfirmationHTML += "Will you require freight storage for your equipment on-site or will you be able to store your equipment in an exhibit booth?<br /><b>" + rblFreightStorageYN.SelectedItem.Text + "</b><br /><br />"
            SubmittedConfirmationHTML += "Learning Lab Objective.<br /><b>" + txtObjective.Text + "</b><br /><br />"
            SubmittedConfirmationHTML += "Learning Lab Description.<br /><b>" + txtDescription.Text + "</b><br /><br />"
            SubmittedConfirmationHTML += "</p>"

            SubmittedConfirmationHTML += "<br /><br />"


            Dim AbstractSubmissionEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_learninglab_submission")
            Dim AbstractSubmissionEmailHTML As String
            If AbstractSubmissionEmail Is Nothing Then
                AbstractSubmissionEmail = BattelleEmailGetByNameAsDataRow("learninglab_submission")
            End If
            AbstractSubmissionEmailHTML = AbstractSubmissionEmail("EmailHTML")
            AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
            'AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[first_name]}", PersonData("FirstName"))
            'AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[last_name]}", PersonData("LastName"))
            AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
            AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
            AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
            AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
            AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
            ' AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
            AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[conference_type]}", ConferenceControl.ConferenceType)
            AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[learninglab_confirmation_content]}", SubmittedConfirmationHTML)



            'If abstract has a presenting Instructor who is different than user who submitted, send Learning Lab email confirmation to both'
            If PresenterPersonID > 0 And PresenterPersonID <> PersonID Then
                Dim PresenterData = BattellePersonGetAsDataRow(PresenterPersonID)
                AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[first_name]}", PresenterData("FirstName"))
                AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[last_name]}", PresenterData("LastName"))
                BattelleSendMail(AbstractSubmissionEmailHTML, PersonData("Email"), "Learning Lab Submission for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail, "phippss@battelle.org,melaragm@battelle.org")
                BattelleSendMail(AbstractSubmissionEmailHTML, PresenterData("Email"), "Learning Lab Submission for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)
            Else
                AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[first_name]}", PersonData("FirstName"))
                AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[last_name]}", PersonData("LastName"))
                BattelleSendMail(AbstractSubmissionEmailHTML, PersonData("Email"), "Learning Lab Submission for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail, "phippss@battelle.org,melaragm@battelle.org")
            End If


            PanelTerms.Visible = False
            PanelForm.Visible = False
            LabelAbstractConfirmationResult.Text = SubmittedConfirmationHTML

            lblMeetingPlannerEmail.Text = ConferenceControl.ConferencePlannerEmail
            With lnkSubjectEmail2
                .Text = ConferenceControl.ConferenceSubjectEmail
                .NavigateUrl = "mailto:" & ConferenceControl.ConferenceSubjectEmail
            End With
            ltlConferenceType.Text = ConferenceControl.ConferenceType
            ltlConferenceType2.Text = ConferenceControl.ConferenceType
            PanelAbstractConfirmation.Visible = True

            'Else
            '    'Fail due to 0 file length
            'End If
        Else
            'Is valid is false!

            LabelAbstractValidation.Text = String.Empty
            LabelAbstractValidation.Text = "<div class=""panel panel-danger""><div class=""panel-heading"">Please correct the following items</div><div class=""panel-body"">"
            For Each Item As String In ValidationFailures
                If Not String.IsNullOrWhiteSpace(LabelAbstractValidation.Text) Then
                    LabelAbstractValidation.Text += "<br />"
                End If
                LabelAbstractValidation.Text += ValidationFailures(Item)
            Next
            LabelAbstractValidation.Text += "</div></div>"
            ButtonSubmitAbstract.CssClass = "btn btn-danger"
        End If

    End Sub

    Protected Sub ButtonInstructorsAdd_Click(sender As Object, e As EventArgs) Handles ButtonInstructorsAdd.Click
        TextBoxPersonEmail.Text = ""
        LabelPersonLookupResult.Text = String.Empty
        FormViewPersonLookup.DataBind()
        PanelPersonAdd.Visible = True
        FormViewPersonLookup.Visible = False
    End Sub

    Protected Sub ListBoxAbstractInstructors_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListBoxAbstractInstructors.SelectedIndexChanged
        ButtonInstructorsRemove.Visible = ListBoxAbstractInstructors.SelectedIndex >= 0
        ButtonCorPresInstructorSet.Visible = ListBoxAbstractInstructors.SelectedIndex >= 0
    End Sub

    Protected Sub ButtonInstructorsRemove_Click(sender As Object, e As EventArgs) Handles ButtonInstructorsRemove.Click
        If ListBoxAbstractInstructors.SelectedIndex >= 0 Then
            'Check for presenting Instructor
            If ListBoxAbstractInstructors.SelectedItem.ToString <> lblCorPresInstructor.Text Then
                ListBoxAbstractInstructors.Items.RemoveAt(ListBoxAbstractInstructors.SelectedIndex)
                ListBoxAbstractInstructors.ClearSelection()
                ButtonInstructorsRemove.Visible = ListBoxAbstractInstructors.SelectedIndex >= 0
                ButtonCorPresInstructorSet.Visible = ListBoxAbstractInstructors.SelectedIndex >= 0
            Else
                'Alert
                LiteralAlertDivOpen.Text = "<div class=""alert alert-danger"" role=""alert"">"
                lblCorPresInstructorWarning.Visible = True

            End If

        Else
            'Weird?
        End If
    End Sub

    Protected Sub ButtonCorPresInstructorSet_Click(sender As Object, e As EventArgs) Handles ButtonCorPresInstructorSet.Click
        If ListBoxAbstractInstructors.SelectedIndex >= 0 Then
            lblCorPresInstructor.Text = ListBoxAbstractInstructors.SelectedItem.ToString
            hdnCorPres.Value = ListBoxAbstractInstructors.SelectedValue
            ListBoxAbstractInstructors.ClearSelection()
            ButtonCorPresInstructorSet.Visible = ListBoxAbstractInstructors.SelectedIndex >= 0
            ButtonInstructorsRemove.Visible = ListBoxAbstractInstructors.SelectedIndex >= 0
            LiteralAlertDivOpen.Text = "<div class=""alert alert-success"" role=""alert"">"
            lblCorPresInstructorWarning.Visible = False
        Else
            'Weird?
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
        AbstractInstructorsAdd(DataRow("FirstName"), DataRow("LastName"), DataKey)
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
        'ListBoxAbstractInstructors.Focus()
        Dim sm As ScriptManager = ScriptManager.GetCurrent(Me)
        sm.SetFocus(ListBoxAbstractInstructors)
    End Sub

    Private Sub AbstractInstructorsAdd(FirstName As String, LastName As String, PersonID As Integer)
        If ListBoxAbstractInstructors.Items.FindByValue(PersonID.ToString()) Is Nothing Then
            Dim NewItem As ListItem = New ListItem(FirstName + " " + LastName, PersonID.ToString())

            '#If DEBUG Then
            '            NewItem.Text += " (DEBUG: " + PersonID.ToString() + ")"
            '#End If

            ListBoxAbstractInstructors.Items.Add(NewItem)
        End If
        ' Else the item already exists in the list box.

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


    Protected Sub lnkNewAbstractKeepInstructors_Click(sender As Object, e As EventArgs) Handles lnkNewAbstractKeepInstructors.Click
        ResetForm()
    End Sub

    Protected Sub lnkNewAbstractNewInstructors_Click(sender As Object, e As EventArgs) Handles lnkNewAbstractNewInstructors.Click

        ResetForm()
        ListBoxAbstractInstructors.Items.Clear()
        EnterAbstract()
    End Sub
    Protected Sub ResetForm()
        PanelAbstractConfirmation.Visible = False
        PanelForm.Visible = True
        txtTitle.Text = ""
        rblExhibitorYN.ClearSelection()
        rblShippingFreightYN.ClearSelection()
        rblFreightTruckYN.ClearSelection()
        rblFreightStorageYN.ClearSelection()
        txtDescription.Text = ""
        txtObjective.Text = ""

    End Sub


    'Protected Sub RadioButtonListAbstractFormat_DataBound(sender As Object, e As EventArgs) Handles RadioButtonListAbstractFormat.DataBound
    '    For Each LI As ListItem In RadioButtonListAbstractFormat.Items
    '        LI.Text = Char.ToUpper(LI.Text(0)) + LI.Text.Substring(1)
    '    Next
    'End Sub



    Protected Sub ButtonSearchCancel_Click(sender As Object, e As EventArgs) Handles ButtonSearchCancel.Click
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
    End Sub

    Protected Sub SqlDataSourcePersonLookup_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourcePersonLookup.Selecting

    End Sub
End Class