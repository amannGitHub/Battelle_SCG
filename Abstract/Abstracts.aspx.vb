Imports System.Data
Imports System.Data.SqlClient
Imports System.IO


Public Class AbstractsForm
    Inherits System.Web.UI.Page

    Dim ConferenceControl As New ConferenceFromURL

    Public sConferenceType As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.Form.Attributes.Add("enctype", "multipart/form-data")

        'Find Conference Global Variables from ConferenceFromURL user control in Master page
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not ConferenceControl Is Nothing Then
            Dim hdnExampleAbstract As New HiddenField
            hdnExampleAbstract = CType(ConferenceControl.FindControl("hdnExampleAbstract"), HiddenField)
            If Not hdnExampleAbstract Is Nothing Then
                Me.lnkExampleAbstract.NavigateUrl = hdnExampleAbstract.Value
            End If
            Dim hdnConfShortName As New HiddenField
            hdnConfShortName = CType(ConferenceControl.FindControl("hdnConfShortName"), HiddenField)
            If Not hdnConfShortName Is Nothing Then
                Me.lblConference2.Text = hdnConfShortName.Value
                Me.lblConference3.Text = hdnConfShortName.Value
            End If

            Me.lnkTechProgScope.NavigateUrl = ConferenceControl.ConferenceTechnicalScope



            sConferenceType = ConferenceControl.ConferenceType

            Dim hdnFinalPlacement As New HiddenField
            hdnFinalPlacement = CType(ConferenceControl.FindControl("hdnFinalPlacement"), HiddenField)
            If Not hdnFinalPlacement Is Nothing Then
                lblFinalPlacement.Text = hdnFinalPlacement.Value
            End If
            Dim hdnPreliminaryProgram As New HiddenField
            hdnPreliminaryProgram = CType(ConferenceControl.FindControl("hdnPreliminaryProgram"), HiddenField)
            If Not hdnPreliminaryProgram Is Nothing Then
                'lblPreliminaryProgram.Text = hdnPreliminaryProgram.Value
            End If
            Dim hdnConferenceEmail As New HiddenField
            hdnConferenceEmail = CType(ConferenceControl.FindControl("hdnConferenceEmail"), HiddenField)
            If Not hdnConferenceEmail Is Nothing Then
                'lblFinalPlacement.Text = hdnConferenceEmail.Value
            End If
            lnkTechnicalScope.NavigateUrl = ConferenceControl.ConferenceTechnicalScope
            lblMeetingPlannerEmail.Text = ConferenceControl.ConferencePlannerEmail

            With lnkSubjectEmail
                .NavigateUrl = "mailto:" & ConferenceControl.ConferenceSubjectEmail
                .Text = ConferenceControl.ConferenceSubjectEmail
            End With
            With lnkSubjectEmail2
                .NavigateUrl = "mailto:" & ConferenceControl.ConferenceSubjectEmail
                .Text = ConferenceControl.ConferenceSubjectEmail
            End With
            With lnkSubjectEmail3
                .NavigateUrl = "mailto:" & ConferenceControl.ConferenceSubjectEmail
                .Text = ConferenceControl.ConferenceSubjectEmail
            End With
            lblPlacementDate.Text = ConferenceControl.ConferenceFinalPlacement
            hdnEmail.Value = ConferenceControl.ConferenceSubjectEmail
            hdnEmail2.Value = "mailto:" & ConferenceControl.ConferenceSubjectEmail

            SqlDataSourceSession.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceRequested.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

            'If Not IsPostBack Then
            '    Dim dv As DataView = CType(SqlDataSourceRequested.Select(DataSourceSelectArguments.Empty), DataView)

            '    'format ddlRequestedBy to show all relevant information. data value is FirstName + LastName
            '    For Each rv As DataRowView In dv
            '        Dim row As DataRow = rv.Row
            '        Dim item As ListItem
            '        Dim name As String = row.Item("FirstName") + " " + row.Item("LastName") + " (" + row.Item("Employer") + ") - " + row.Item("TopicCode") + ": " & row.Item("SessionName")
            '        item = New ListItem((row.Item("LastName") & ", " & row.Item("FirstName") & " (" & row.Item("Employer") & ") - " & row.Item("TopicCode") & ": " & row.Item("SessionName")), name)
            '        ddlRequestedBy.Items.Add(item)
            '    Next
            'End If
        End If




    End Sub


    Protected Sub ParticipationIDLoginAbstracts_FinishedLogin() Handles ParticipationIDLoginAbstracts.FinishedLogin
        EnterAbstract()
    End Sub

    'Protected Sub handler1_RenewSession() Handles handler1.RenewSession
    '    PanelAbstractTop.Visible = False
    '    PanelAbstractsMain.Visible = False
    '    PanelParticipationControl.Visible = True
    '    ParticipationIDLoginAbstracts.Visible = True
    'End Sub

    Protected Sub EnterAbstract()
        Dim PersonID As Integer = ParticipationIDLoginAbstracts.UserPersonID()
        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        ParticipationIDLoginAbstracts.Visible = False
        PanelParticipationControl.Visible = False
        If Not IsNothing(PersonData) Then
            AbstractAuthorsAdd(PersonData("FirstName"), PersonData("LastName"), PersonID)
            lblCorPresAuthor.Text = PersonData("FirstName") + " " + PersonData("LastName")
            hdnCorPres.Value = PersonID
        End If

        PanelAbstractsMain.Visible = True
        PanelAbstractConfirmation.Visible = False

        RadEditorAbstractApproach.Content = "<b>Approach/Activities.</b>&nbsp;"
        RadEditorAbstractResults.Content = "<b>Results/Lessons Learned.</b>&nbsp;"
    End Sub

    Protected Sub LinkButtonPersonLookup_Click(sender As Object, e As EventArgs) Handles LinkButtonPersonLookup2.Click
        FormViewPersonLookup.Visible = True
        FormViewPersonLookup.DataBind()
        If FormViewPersonLookup.SelectedValue Is Nothing Then
            LabelPersonLookupResult.Text = "<div class=""alert alert-warning"" role=""alert"">This email address was not found in our system. Please carefully check what you typed and correct if necessary. Also, consider if the co-author may have used an alternate email address (e.g., email related to a previous employer, personal email). Otherwise, click the &quot;Enter co-author information&quot; button below to enter the co-author&#39;s contact information.</div>"
        Else
            LabelPersonLookupResult.Text = "<div class=""alert alert-success"" role=""alert"">Co-author located!</div>"
        End If
    End Sub

    Protected Sub SelectButton_Click(sender As Object, e As EventArgs)
        FormViewPersonLookup.DataBind()
        Dim DataRow As DataRowView = CType(FormViewPersonLookup.DataItem, DataRowView)
        Dim DataKey As Integer = DataRow("PersonID")
        AbstractAuthorsAdd(DataRow("FirstName"), DataRow("LastName"), DataKey)
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
        'ListBoxAbstractAuthors.Focus()
        Dim sm As ScriptManager = ScriptManager.GetCurrent(Me)
        sm.SetFocus(ListBoxAbstractAuthors)
    End Sub





    Protected Sub ButtonSubmitAbstract_Click(sender As Object, e As EventArgs) Handles ButtonSubmitAbstract.Click
        Dim IsValidAbstract As Boolean = True
        Dim ValidationFailures As NameValueCollection = New NameValueCollection()
        LabelAbstractValidation.Text = String.Empty

        If FormViewPersonLookup.Visible = True Then
            'A person lookup is in progress
            IsValidAbstract = False
            ValidationFailures.Add("Author Lookup in Progress", "You have initiated an author lookup. Please complete or cancel the lookup.")
        End If

        
        If String.IsNullOrWhiteSpace(RadEditorAbstractTitle.Content) Then
            IsValidAbstract = False
            ValidationFailures.Add("Title", "Please provide a Title.")
        End If
        If String.IsNullOrWhiteSpace(TextBoxAuthorList.Text) Then
            IsValidAbstract = False
            ValidationFailures.Add("Formatted Author List", "Please provide formatted authors list.")
        End If
        If RadioButtonListAbstractFormat.SelectedValue = "" Then
            IsValidAbstract = False
            ValidationFailures.Add("Preferred Format ", "Please select your placement preference.")
        End If
        If ListBoxAbstractAuthors.Items.Count = 0 Then
            IsValidAbstract = False
            ValidationFailures.Add("Author List", "Please add at least one author.")
        End If
        If Len(RadEditorAbstractTitleAuthorBlock.Content) <= 10 Then '<b>Title Author Block.</b>&nbsp; (35)
            IsValidAbstract = False
            ValidationFailures.Add("Abstract Title/Author Block", "Please expand upon your Title/Author Block.")
        End If
        If Len(RadEditorAbstractBackground.Content) <= 200 Then '<b>Background/Objectives.</b>&nbsp; (35)
            IsValidAbstract = False
            ValidationFailures.Add("Abstract Background/Objectives", "Please expand upon your Background/Objectives.")
        End If
        If Len(RadEditorAbstractApproach.Content) <= 200 Then '<b>Approach/Activities.</b>&nbsp; (33)
            IsValidAbstract = False
            ValidationFailures.Add("Abstract Approach/Activities", "Please expand upon your Approach/Activities.")
        End If
        If Len(RadEditorAbstractResults.Content) <= 200 Then '<b>Results/Lessons Learned.</b>&nbsp; (37)
            IsValidAbstract = False
            ValidationFailures.Add("Abstract Results/Lessons", "Please expand upon your Results/Lessons Learned.")
        End If
        If Not FileUploadAbstract.HasFile() Then
            IsValidAbstract = False
            ValidationFailures.Add("File", "Please select a file (.doc or .docx) to upload for your abstract.")
        Else
            Dim AbstractFile As IO.Stream = FileUploadAbstract.PostedFile.InputStream
            Dim FileExt As String = Path.GetExtension(FileUploadAbstract.PostedFile.FileName)
            Select Case FileExt
                Case ".doc", ".docx", ".txt", ".pdf"
                    'IsValidAbstract = True
                Case Else
                    IsValidAbstract = False
                    ValidationFailures.Add("File", "Please select a file (.doc or .docx) to upload for your abstract.")
            End Select
        End If
        If IsValidAbstract Then
            Dim PersonID As Integer = ParticipationIDLoginAbstracts.UserPersonID()
            Dim PersonData = BattellePersonGetAsDataRow(PersonID)
            Dim topics = ""
            Dim topicsCodes = ""

            If ddlApplicableTopics1.SelectedValue <> "" Then
                topics = topics & ddlApplicableTopics1.SelectedValue
                topicsCodes = topicsCodes & ddlApplicableTopics1.SelectedItem.Text.Split(New Char() {" "c})(0)
                If ddlApplicableTopics2.SelectedValue <> "" Then
                    topics = topics & ", " & ddlApplicableTopics2.SelectedValue
                    topicsCodes = topicsCodes & "," & ddlApplicableTopics2.SelectedItem.Text.Split(New Char() {" "c})(0)
                End If
            End If

            'File Upload
            Dim AbstractFile As IO.Stream = FileUploadAbstract.PostedFile.InputStream
                Dim FileLength As Integer = FileUploadAbstract.PostedFile.ContentLength
                Dim FileName As String = FileUploadAbstract.FileName 'FileUploadAbstract.PostedFile.FileName
                Dim FileExt As String = Path.GetExtension(FileUploadAbstract.PostedFile.FileName)
                Dim FileContentType As String = FileUploadAbstract.PostedFile.ContentType
            'Dim FileContentType As String = String.Empty
            'Select Case FileExt
            '    Case ".doc", ".docx"
            '        FileContentType = "application/vnd.ms-word"
            '        'Case ".pdf"
            '        '    FileContentType = "application/pdf"
            '    Case Else
            '        ' Unsupported type?
            'End Select

            'clean up querystring issues in name when downloading later
            FileName = Replace(FileName, " ", "_")
            FileName = Replace(FileName, "'", "_")
            FileName = Replace(FileName, "&", "_")

            Dim FileData(FileLength - 1) As Byte
                AbstractFile.Read(FileData, 0, FileLength)
                'If FileData.Length > 0 Then  SCGTODO change to abstract check
                'DB ops only here

                Dim UploadAbstractCommand As SqlCommand = New SqlCommand("AbstractInsert")
                UploadAbstractCommand.Parameters.AddWithValue("UploadedFile", FileData)
                UploadAbstractCommand.Parameters.AddWithValue("FileSize", FileLength)
                UploadAbstractCommand.Parameters.AddWithValue("FileName", FileName)
                UploadAbstractCommand.Parameters.AddWithValue("ContentType", FileContentType)

                ' Set rest of parameters using form data
                UploadAbstractCommand.Parameters.AddWithValue("PersonID", PersonID)
                UploadAbstractCommand.Parameters.AddWithValue("Title", RadEditorAbstractTitle.Content.Trim())
                UploadAbstractCommand.Parameters.AddWithValue("AuthorList", TextBoxAuthorList.Text.Trim())
                UploadAbstractCommand.Parameters.AddWithValue("PreferredFormat", RadioButtonListAbstractFormat.SelectedValue.ToLower())
            UploadAbstractCommand.Parameters.AddWithValue("SubmissionRequestedBy", ddlRequestedBy.SelectedValue.ToString())
            UploadAbstractCommand.Parameters.AddWithValue("AuthorComments", DBNull.Value)
            UploadAbstractCommand.Parameters.AddWithValue("ApplicableTopics", topics)
            UploadAbstractCommand.Parameters.AddWithValue("NewTopicArea", TextBoxAbstractNewTopicArea.Text.Trim())
                UploadAbstractCommand.Parameters.AddWithValue("AbstractTitleAuthorBlock", RadEditorAbstractTitleAuthorBlock.Content.Trim())
                UploadAbstractCommand.Parameters.AddWithValue("AbstractBG", RadEditorAbstractBackground.Content.Trim())
                UploadAbstractCommand.Parameters.AddWithValue("AbstractApproach", RadEditorAbstractApproach.Content.Trim())
                UploadAbstractCommand.Parameters.AddWithValue("AbstractResults", RadEditorAbstractResults.Content.Trim())

                ' conf id

                UploadAbstractCommand.Parameters.AddWithValue("ConferenceID", ConferenceControl.ConferenceID)

                Dim DSReturnData As DataSet
                Dim PresenterPersonID As Integer

                DSReturnData = BattelleExecuteCommand(UploadAbstractCommand)
                If DSReturnData.Tables(0).Rows.Count > 0 Then
                    Dim AbstractID = DSReturnData.Tables(0).Rows(0)(0)
                    For Each LI As ListItem In ListBoxAbstractAuthors.Items

                        Dim Presenter As Boolean = False

                        If Integer.Parse(LI.Value) = hdnCorPres.Value Then
                            Presenter = True
                            PresenterPersonID = hdnCorPres.Value
                        End If
                        BattelleAbstractAuthorsInsert(AbstractID, Integer.Parse(LI.Value), Presenter)
                    Next
                Else
                    ' Fail due to database issue
                End If

                Dim SubmittedConfirmationHTML As String = String.Empty

                SubmittedConfirmationHTML += "<p align=""left"">"
                SubmittedConfirmationHTML += "Conference: <b>" + ConferenceControl.ConferenceName + "</b><br />"
                SubmittedConfirmationHTML += "Title: <b>" + UploadAbstractCommand.Parameters("Title").Value.ToString() + "</b><br />"
                SubmittedConfirmationHTML += "Authors: <b>" + UploadAbstractCommand.Parameters("AuthorList").Value.ToString() + "</b><br />"
                SubmittedConfirmationHTML += "Preferred Format: <b>" + UploadAbstractCommand.Parameters("PreferredFormat").Value.ToString() + "</b><br />"
            'SubmittedConfirmationHTML += "Submission Requested By: <b>" + UploadAbstractCommand.Parameters("SubmissionRequestedBy").Value.ToString() + "</b><br />"
            'SubmittedConfirmationHTML += "Author Comments: <b>" + UploadAbstractCommand.Parameters("AuthorComments").Value.ToString() + "</b><br />"
            SubmittedConfirmationHTML += "Applicable Topics: <b>" + topicsCodes + "</b><br />"
            SubmittedConfirmationHTML += "New Topic Area?: <b>" + UploadAbstractCommand.Parameters("NewTopicArea").Value.ToString() + "</b><br />"
                SubmittedConfirmationHTML += "Uploaded Abstract File Name: " + UploadAbstractCommand.Parameters("FileName").Value.ToString() + "<br />"
                'SubmittedConfirmationHTML += "Uploaded Abstract File Size: " + UploadAbstractCommand.Parameters("FileSize").Value.ToString()



                SubmittedConfirmationHTML += "</p>"
                SubmittedConfirmationHTML += "<h3>Abstract</h3>"
                SubmittedConfirmationHTML += UploadAbstractCommand.Parameters("AbstractTitleAuthorBlock").Value.ToString() + "<br /><br />"
                SubmittedConfirmationHTML += UploadAbstractCommand.Parameters("AbstractBG").Value.ToString() + "<br /><br />"
                SubmittedConfirmationHTML += UploadAbstractCommand.Parameters("AbstractApproach").Value.ToString() + "<br /><br />"
                SubmittedConfirmationHTML += UploadAbstractCommand.Parameters("AbstractResults").Value.ToString() + "<br /><br />"

                Dim AbstractSubmissionEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_abstract_submission")
                Dim AbstractSubmissionEmailHTML As String
                If AbstractSubmissionEmail Is Nothing Then
                    AbstractSubmissionEmail = BattelleEmailGetByNameAsDataRow("abstract_submission")
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
                AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
                AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[abstract_confirmation_content]}", SubmittedConfirmationHTML)



                'If abstract has a presenting author who is different than user who submitted, send abstract email confirmation to both'
                If PresenterPersonID > 0 And PresenterPersonID <> PersonID Then
                    Dim PresenterData = BattellePersonGetAsDataRow(PresenterPersonID)
                    AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[first_name]}", PresenterData("FirstName"))
                    AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[last_name]}", PresenterData("LastName"))
                    BattelleSendMail(AbstractSubmissionEmailHTML, PersonData("Email"), "Abstract Submission for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)
                    BattelleSendMail(AbstractSubmissionEmailHTML, PresenterData("Email"), "Abstract Submission for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)
                Else
                    AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[first_name]}", PersonData("FirstName"))
                    AbstractSubmissionEmailHTML = AbstractSubmissionEmailHTML.Replace("{[last_name]}", PersonData("LastName"))
                    BattelleSendMail(AbstractSubmissionEmailHTML, PersonData("Email"), "Abstract Submission for " + ConferenceControl.ConferenceShortName, Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)
                End If


                PanelAbstractTop.Visible = False
                PanelAbstractsMain.Visible = False
                LabelAbstractConfirmationResult.Text = SubmittedConfirmationHTML
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


    Protected Sub ButtonAuthorsAdd_Click(sender As Object, e As EventArgs) Handles ButtonAuthorsAdd.Click
        TextBoxPersonEmail.Text = ""
        LabelPersonLookupResult.Text = String.Empty
        FormViewPersonLookup.DataBind()
        PanelPersonAdd.Visible = True
        FormViewPersonLookup.Visible = False
    End Sub

    Protected Sub ListBoxAbstractAuthors_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListBoxAbstractAuthors.SelectedIndexChanged
        ButtonAuthorsRemove.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
        ButtonCorPresAuthorSet.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
    End Sub

    Protected Sub ButtonAuthorsRemove_Click(sender As Object, e As EventArgs) Handles ButtonAuthorsRemove.Click
        If ListBoxAbstractAuthors.SelectedIndex >= 0 Then
            'Check for presenting author
            If ListBoxAbstractAuthors.SelectedItem.ToString <> lblCorPresAuthor.Text Then
                ListBoxAbstractAuthors.Items.RemoveAt(ListBoxAbstractAuthors.SelectedIndex)
                ListBoxAbstractAuthors.ClearSelection()
                ButtonAuthorsRemove.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
                ButtonCorPresAuthorSet.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
            Else
                'Alert
                LiteralAlertDivOpen.Text = "<div class=""alert alert-danger"" role=""alert"">"
                lblCorPresAuthorWarning.Visible = True

            End If
            
        Else
            'Weird?
        End If
    End Sub

    Protected Sub ButtonCorPresAuthorSet_Click(sender As Object, e As EventArgs) Handles ButtonCorPresAuthorSet.Click
        If ListBoxAbstractAuthors.SelectedIndex >= 0 Then
            lblCorPresAuthor.Text = ListBoxAbstractAuthors.SelectedItem.ToString
            hdnCorPres.Value = ListBoxAbstractAuthors.SelectedValue
            ListBoxAbstractAuthors.ClearSelection()
            ButtonCorPresAuthorSet.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
            ButtonAuthorsRemove.Visible = ListBoxAbstractAuthors.SelectedIndex >= 0
            LiteralAlertDivOpen.Text = "<div class=""alert alert-success"" role=""alert"">"
            lblCorPresAuthorWarning.Visible = False
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
        End If
        ' Else the item already exists in the list box.

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
        AbstractAuthorsAdd(DataRow("FirstName"), DataRow("LastName"), DataKey)
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
        'ListBoxAbstractAuthors.Focus()
    End Sub

    Protected Sub EmailTextBox_Init(sender As Object, e As EventArgs)
        Dim EmailTextBox As TextBox = CType(sender, TextBox)
        EmailTextBox.Text = TextBoxPersonEmail.Text
    End Sub

    Protected Sub btnBegin_Click(sender As Object, e As EventArgs) Handles btnBegin.Click
        PanelAbstractTop.Visible = False
        PanelParticipationControl.Visible = True
    End Sub

    'Protected Sub CountryDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
    '    ' Add code to switch the state
    '    Dim StateDDL As DropDownList = CType(FormViewPersonLookup.FindControl("StateProvinceDropDownList"), DropDownList)

    '    Dim HoldTopItem As ListItem = StateDDL.Items(0)
    '    StateDDL.Items.Clear()
    '    StateDDL.Items.Add(HoldTopItem)
    '    StateDDL.DataBind()


    'End Sub




    Protected Sub HtmlDecode_PreRender(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
            item.Value = Server.HtmlDecode(item.Value)
        Next
    End Sub


    Protected Sub lnkNewAbstractKeepAuthors_Click(sender As Object, e As EventArgs) Handles lnkNewAbstractKeepAuthors.Click
        ResetForm()
    End Sub

    Protected Sub lnkNewAbstractNewAuthors_Click(sender As Object, e As EventArgs) Handles lnkNewAbstractNewAuthors.Click
        
        ResetForm()
        ListBoxAbstractAuthors.Items.Clear()
        TextBoxAuthorList.Text = ""
        EnterAbstract()
    End Sub
    Protected Sub ResetForm()
        PanelAbstractConfirmation.Visible = False
        PanelAbstractsMain.Visible = True
        RadEditorAbstractTitle.Content = ""
        RadioButtonListAbstractFormat.ClearSelection()
        ddlRequestedBy.SelectedIndex = 0
        ddlApplicableTopics1.SelectedIndex = 0
        ddlApplicableTopics2.SelectedIndex = 0
        TextBoxAbstractNewTopicArea.Text = ""
        RadEditorAbstractTitleAuthorBlock.Content = ""
        RadEditorAbstractBackground.Content = "<b>Background/Objectives.</b>&nbsp;"
        RadEditorAbstractApproach.Content = "<b>Approach/Activities.</b>&nbsp;"
        RadEditorAbstractResults.Content = "<b>Results/Lessons Learned.</b>&nbsp;"

    End Sub


    Protected Sub RadioButtonListAbstractFormat_DataBound(sender As Object, e As EventArgs) Handles RadioButtonListAbstractFormat.DataBound
        For Each LI As ListItem In RadioButtonListAbstractFormat.Items
            LI.Text = Char.ToUpper(LI.Text(0)) + LI.Text.Substring(1)
        Next
    End Sub



    Protected Sub ButtonSearchCancel_Click(sender As Object, e As EventArgs) Handles ButtonSearchCancel.Click
        PanelPersonAdd.Visible = False
        FormViewPersonLookup.Visible = False
    End Sub
End Class