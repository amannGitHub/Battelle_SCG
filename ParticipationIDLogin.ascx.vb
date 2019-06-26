Imports System.Data.SqlClient


Public Class ParticipationIDLogin
    Inherits System.Web.UI.UserControl

    'Public Event ParticipationIDLogin_FinishedLogin(ByVal sender As System.Object, ByVal e As System.EventArgs)

    Delegate Sub OnFinishedLogin()

    Public Event FinishedLogin As OnFinishedLogin

    Public Property UserPersonID() As Integer
        Get
            If (ViewState("UserPersonID") IsNot Nothing) Then
                Return CType(ViewState("UserPersonID"), Integer)
            Else
                Return 0
            End If
        End Get
        Set(value As Integer)
            ViewState("UserPersonID") = value
        End Set
    End Property

    Public Property UserEmail() As String
        Get
            If (ViewState("UserEmail") IsNot Nothing) Then
                Return CType(ViewState("UserEmail"), String)
            Else
                Return 0
            End If
        End Get
        Set(value As String)
            ViewState("UserEmail") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If FormViewPerson.CurrentMode <> FormViewMode.ReadOnly Then
#If DEBUG Then
            TextBoxParticipationID.Attributes.Add("autocomplete", "on")
#Else
            TextBoxParticipationID.Attributes.Add("autocomplete", "off")
#End If


            ''Find Country DDL and get ClientID

            Dim CountryDDL As DropDownList = CType(FormViewPerson.FindControl("CountryDropDownList"), DropDownList)


                '' Create your ControlParameter
                'Dim Param As New ControlParameter()
                'Param.ControlID = CountryDDL.UniqueID
                'Param.PropertyName = "SelectedValue"
                'Param.Name = "CountryCode"
                'Param.Type = TypeCode.String
                '' Add it to your SelectParameters collection
                'SqlDataSourceLookupStateProvince.SelectParameters.Add(Param)
            End If

    End Sub

    Protected Sub ButtonCheckParticipationID_Click(sender As Object, e As EventArgs) Handles ButtonCheckParticipationID.Click
        If BattelleSecurityFailureCheck(Request.UserHostAddress) Then


            Dim dv As DataView
            Dim PersonID As Integer

            dv = CType(SqlDataSourcePersonIDFromParticipationID.Select(DataSourceSelectArguments.Empty), DataView)
            If dv.Table.Rows.Count > 0 Then
                PersonID = CType(dv.Table.Rows(0)(0), Integer)
                LabelCheckParticipationIDResult.Text = PersonID.ToString()

                SqlDataSourcePerson.SelectParameters.Clear()
                SqlDataSourcePerson.SelectParameters.Add("PersonID", DbType.Int32, PersonID.ToString())

                FormViewPerson.DataBind()

                PanelPerson.Visible = True
                PanelEmail.Visible = False
                PanelParticipationID.Visible = False
                ButtonFinishedLogin.Visible = True
                ButtonParticipationID.Visible = False
                ButtonEmail.Visible = False
                UserPersonID = PersonID

                'Response.Cookies("battelle")("PersonID") = PersonID
                'Response.Cookies("battelle").Expires = DateTime.Now.AddDays(30)
                Session("PersonID") = PersonID

                PanelParticipationOptions.Visible = False


                'lblParticipantCodeAction.Text = "Contact Information Review"
                lblParticipantCodeAction.Text = "Your Participant Information"
            Else
                BattelleSecurityFailure(Request.UserHostAddress)
                LabelCheckParticipationIDResult.Text = "<div class=""alert alert-warning"" role=""alert"">The Participant Code you have entered is invalid. If you do not remember your Participant Code, please click the ""I need a Participant Code"" button.</div>"
            End If

        Else
            LabelCheckParticipationIDResult.Text = "<div class=""alert alert-danger"" role=""alert"">There have been too many attempts. Please try again soon.</div>"
        End If

    End Sub

    Protected Sub ButtonCheckEmail_Click(sender As Object, e As EventArgs) Handles ButtonCheckEmail.Click
        If BattelleSecurityFailureCheck(Request.UserHostAddress) Then
            Dim PersonData As DataRow
            Dim PersonID As Integer
            Dim PersonDataView As DataView = CType(SqlDataSourcePersonIDFromEmail.Select(DataSourceSelectArguments.Empty), DataView)
            If PersonDataView.Table.Rows.Count > 0 Then
                PersonData = PersonDataView.Table.Rows(0)
                PersonDataView.Dispose()
                PersonID = CType(PersonData("PersonID"), Integer)
                Dim ParticipationID As String
                If IsDBNull(PersonData("ParticipationID")) Then
                    ' Generate a new p. ID, set in DB, and email user.
                    Dim NewParticipationID As String = BattelleGenerateParticipationID(PersonData("FirstName"), PersonData("LastName"))
                    BattelleSetParticipationID(PersonID, NewParticipationID)
                    ParticipationID = NewParticipationID
                    LabelCheckParticipationIDResult.Text = "<div class=""alert alert-success"" role=""alert"">Your email address exists in our system. A Participant Code was created and sent to your email address.</div>"
                Else
                    ParticipationID = PersonData("ParticipationID")
                    LabelCheckParticipationIDResult.Text = "<div class=""alert alert-success"" role=""alert"">Your email address exists in our system. Your Participant Code will be sent to your email address, please use that Participant Code to login.</div>"
                End If
                'BattelleSendMail("Your Participant Code is: " + BattelleParticipationIDByPerson(PersonID), TextBoxEmail.Text)
                'Admin
                Me.TextBoxParticipationID.Text = ""
                If Context.GetOwinContext().Authentication.User.Identity.Name = "SCGadmin" Then
                    TextBoxParticipationID.Text = ParticipationID
                Else

                    'SENDMAIL begin
                    Dim ConferenceControl As ConferenceFromURL = CType(Me.Parent.Page.Master.FindControl("ConferenceFromURL"), ConferenceFromURL)

                    Dim ParticipationSummaryHTML As String = String.Empty

                    ParticipationSummaryHTML += "<p align=""left"">"
                    ParticipationSummaryHTML += "Name: " + PersonData("FirstName") + " " + PersonData("LastName") + "<br />"
                    ParticipationSummaryHTML += "Participant Code: <b>" + ParticipationID + "</b><br />"
                    If Not IsDBNull(PersonData("OrganizationID")) Then
                        ParticipationSummaryHTML += "<br>You are listed as the Point of Contact (POC) for " + PersonData("Exhibitor") + "<br />"

                        ParticipationSummaryHTML += "Organization ID: <b style='color:red;'>" + PersonData("OrganizationID") + "</b><br /><br />"
                        ParticipationSummaryHTML += "<i>Important:</i> Retain this Organization ID as it is required for other members of your organization to use it when signing up as a technical registrant. <br />"
                    End If
                    ParticipationSummaryHTML += "</p>"


                    Dim ParticipationEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_participation")
                    Dim ParticipationEmailHTML As String
                    If ParticipationEmail Is Nothing Then
                        ParticipationEmail = BattelleEmailGetByNameAsDataRow("participation")
                    End If
                    ParticipationEmailHTML = ParticipationEmail("EmailHTML")
                    ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
                    ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
                    ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
                    ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
                    ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
                    ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
                    ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
                    ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[participation_content]}", ParticipationSummaryHTML)

                    BattelleSendMail(ParticipationEmailHTML, PersonData("Email"), "Your Participant Code", Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)

                    'END send mail
                End If
                PanelParticipationID.Visible = True

                PanelEmail.Visible = False
                '#If DEBUG Then
                '                LabelCheckEmailResult.Text += " (DEBUG: PersonID=" + PersonID.ToString() + ")"
                '#End If


            Else
                BattelleSecurityFailure(Request.UserHostAddress)
                LabelCheckEmailResult.Visible = True
                LabelCheckEmailResult.Text = "<div class=""alert alert-warning"" role=""alert"">We could not locate your email address in our system. Please verify that you typed your email correctly. If you think you may have used a different email previously, please try that one. If your record is retrieved, you will be able to revise your contact information as needed on the next screen. If you are a new user, please click the NEW USER button below.</div>"
                ButtonPersonEmptyInsert.Visible = True
                UserEmail = TextBoxEmail.Text
                'TextBoxEmail.ReadOnly = True

            End If
            Else
                LabelCheckParticipationIDResult.Text = "<div class=""alert alert-danger"" role=""alert"">There have been too many attempts. Please try again soon.</div>"
            End If
    End Sub

    Protected Sub ButtonParticipationID_Click(sender As Object, e As EventArgs) Handles ButtonParticipationID.Click

        PanelParticipationID.Visible = True
        PanelEmail.Visible = False
        PanelPerson.Visible = False
        LabelCheckEmailResult.Visible = False
        ButtonFinishedLogin.Visible = False


    End Sub

    Protected Sub ButtonEmail_Click(sender As Object, e As EventArgs) Handles ButtonEmail.Click

        PanelParticipationID.Visible = False
        PanelPerson.Visible = False
        ButtonPersonEmptyInsert.Visible = False
        ButtonFinishedLogin.Visible = False
        TextBoxEmail.ReadOnly = False
        PanelEmail.Visible = True
    End Sub

    Protected Sub ButtonFinishedLogin_Click(sender As Object, e As EventArgs) Handles ButtonFinishedLogin.Click
        Dim RaiseTheEvent As Boolean = False

        Dim ValidationFailures As NameValueCollection = New NameValueCollection()

        If FormViewPerson.SelectedValue IsNot Nothing Then
            Dim PersonID As Integer = FormViewPerson.SelectedValue
            Dim PersonData As DataRow = BattellePersonGetAsDataRow(PersonID)
            RaiseTheEvent = BattelleValidatePersonData(PersonData, True, ValidationFailures)
            Session("PersonID") = PersonID
        End If


        If RaiseTheEvent Then
            RaiseEvent FinishedLogin()
        Else
            LabelIsPersonDataValid.Text = String.Empty

            For Each Item As String In ValidationFailures
                If Not String.IsNullOrWhiteSpace(LabelIsPersonDataValid.Text) Then
                    LabelIsPersonDataValid.Text += "<br />"
                End If
                LabelIsPersonDataValid.Text += ValidationFailures(Item)
            Next

            LabelIsPersonDataValid.Visible = True
        End If

    End Sub


    Protected Sub ButtonPersonEmptyInsert_Click(sender As Object, e As EventArgs) Handles ButtonPersonEmptyInsert.Click
        FormViewPerson.ChangeMode(FormViewMode.Insert)
        PanelPerson.Visible = True
        ButtonFinishedLogin.Visible = False
        ButtonParticipationID.Visible = False
        ButtonEmail.Visible = False
        PanelParticipationID.Visible = False
        PanelEmail.Visible = False
        PanelParticipationOptions.Visible = False
    End Sub

    Protected Sub FormViewPerson_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles FormViewPerson.ItemInserted
        Dim PersonID As Integer = BattellePersonGetByParticipationIDAsDataRow(e.Values("ParticipationID"))("PersonID")
        Session("PersonID") = PersonID
        SqlDataSourcePerson.SelectParameters.Clear()
        SqlDataSourcePerson.SelectParameters.Add("PersonID", DbType.Int32, PersonID.ToString())
        FormViewPerson.ChangeMode(FormViewMode.ReadOnly)
        FormViewPerson.DataBind()
        UserPersonID = PersonID
        UserEmail = e.Values("Email")
        'TODO SendEmail to User
        Dim ConferenceControl As ConferenceFromURL = CType(Me.Parent.Page.Master.FindControl("ConferenceFromURL"), ConferenceFromURL)

        Dim ParticipationSummaryHTML As String = String.Empty

        ParticipationSummaryHTML += "<p align=""left"">"
        ParticipationSummaryHTML += "Name: " + e.Values("FirstName") + " " + e.Values("LastName") + "<br />"
        ParticipationSummaryHTML += "Participant Code: " + e.Values("ParticipationID") + "<br />"
        ParticipationSummaryHTML += "</p>"


        Dim ParticipationEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_participation")
        Dim ParticipationEmailHTML As String
        If ParticipationEmail Is Nothing Then
            ParticipationEmail = BattelleEmailGetByNameAsDataRow("participation")
        End If
        ParticipationEmailHTML = ParticipationEmail("EmailHTML")
        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[first_name]}", e.Values("FirstName"))
        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[participation_content]}", ParticipationSummaryHTML)

        ParticipationEmailHTML = ParticipationEmailHTML.Replace("{[participation_id]}", e.Values("ParticipationID"))
        If Context.GetOwinContext().Authentication.User.Identity.Name = "SCGadmin" Then
            'BattelleSendMail(ParticipationEmailHTML, e.Values("Email"), "Your Participant Code", Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)
            'Send an email if done by admin? SCGTODO
        Else
            BattelleSendMail(ParticipationEmailHTML, e.Values("Email"), "Your Participant Code", Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)
        End If


        'END SENDMAIL
        ButtonFinishedLogin.Visible = True
    End Sub

    Protected Sub FormViewPerson_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles FormViewPerson.ItemInserting
        'Dim CountryDDL As DropDownList = CType(FormViewPerson.FindControl("CountryDropDownList"), DropDownList)
        'Dim StateDDL As DropDownList = CType(FormViewPerson.FindControl("StateProvinceDropDownList"), DropDownList)
        'e.Values("Country") = CountryDDL.SelectedItem.Text
        'e.Values("StateProvince") = StateDDL.SelectedValue

        e.Values("Country") = HttpUtility.HtmlEncode(e.Values("Country"))
        e.Values("StateProvince") = HttpUtility.HtmlEncode(e.Values("StateProvince"))

        If e.Values("Country") = "USA" Then
            'format phone number
            e.Values("PhoneNum") = FormatPhoneNum(e.Values("PhoneNum"))
        End If

        Dim ValidationFailures As NameValueCollection = New NameValueCollection()
        e.Cancel = Not BattelleValidatePersonDataDictionary(e.Values, True, ValidationFailures)
        If e.Cancel Then
            Dim ValidationSummary As Label = FormViewPerson.FindControl("LabelDataValidationSummary")
            ValidationSummary.Text = String.Empty
            ValidationSummary.Text += "<div class=""panel panel-danger""><div class=""panel-heading"">Please correct the following items</div><div class=""panel-body"">"

                                
            For Each Item As String In ValidationFailures
                If Not String.IsNullOrWhiteSpace(ValidationSummary.Text) Then
                    ValidationSummary.Text += "<br />"
                End If
                ValidationSummary.Text += ValidationFailures(Item)
            Next
            ValidationSummary.Text += "</div></div>"
            Dim ButtonInsert As Button = TryCast(FormViewPerson.FindControl("ButtonInsert"), Button)
            ButtonInsert.CssClass = "btn btn-danger"

        Else

            e.Values("ParticipationID") = BattelleGenerateParticipationID(e.Values("FirstName"), e.Values("LastName"))
        End If
        'Most code here should match ItemUpdating
    End Sub



    Protected Sub FormViewPerson_ModeChanging(sender As Object, e As FormViewModeEventArgs) Handles FormViewPerson.ModeChanging
        If e.NewMode <> FormViewMode.ReadOnly Then
            LabelIsPersonDataValid.Visible = False
        End If
    End Sub

    Protected Sub EmailTextBox_Init(sender As Object, e As EventArgs)
        Dim EmailTextBox As TextBox = CType(sender, TextBox)
        EmailTextBox.Text = UserEmail
    End Sub


    Protected Sub FormViewPerson_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormViewPerson.ItemUpdating
        'Dim CountryDDL As DropDownList = CType(FormViewPerson.FindControl("CountryDropDownList"), DropDownList)
        'Dim StateDDL As DropDownList = CType(FormViewPerson.FindControl("StateProvinceDropDownList"), DropDownList)
        'e.NewValues("Country") = CountryDDL.SelectedItem.Text
        'e.NewValues("StateProvince") = StateDDL.SelectedValue

        e.NewValues("Country") = HttpUtility.HtmlEncode(e.NewValues("Country"))
        e.NewValues("StateProvince") = HttpUtility.HtmlEncode(e.NewValues("StateProvince"))

        If e.NewValues("Country") = "USA" Then
            'format phone number
            e.NewValues("PhoneNum") = FormatPhoneNum(e.NewValues("PhoneNum"))
        End If

        Dim ValidationFailures As NameValueCollection = New NameValueCollection()
        e.Cancel = Not BattelleValidatePersonDataDictionary(e.NewValues, True, ValidationFailures)
        If e.Cancel Then
            Dim ValidationSummary As Label = FormViewPerson.FindControl("LabelDataValidationSummary")
            ValidationSummary.Text = String.Empty
            ValidationSummary.Text += "<div class=""panel panel-danger""><div class=""panel-heading"">Please correct the following items</div><div class=""panel-body"">"

            For Each Item As String In ValidationFailures
                'If Not String.IsNullOrWhiteSpace(ValidationSummary.Text) Then
                '    ValidationSummary.Text += "<br />"
                'End If
                ValidationSummary.Text += ValidationFailures(Item) & "<br />"
            Next
            ValidationSummary.Text += "</div></div>"
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
        Dim ddlState As DropDownList = CType(FormViewPerson.FindControl("StateProvinceDropDownList"), DropDownList)
        Dim ddlCountry As DropDownList = CType(FormViewPerson.FindControl("CountryDropDownList"), DropDownList)

        'Dim HoldTopItem As ListItem = ddlState.Items(0)
        'ddlState.Items.Clear()
        'ddlState.Items.Add(HoldTopItem)

        SqlDataSourceLookupStateProvince.SelectParameters("CountryName").DefaultValue = ddlCountry.SelectedValue
        If bRebind = True Then
            ddlState.DataBind()
        End If

    End Sub



    Protected Sub FormViewPerson_DataBound(sender As Object, e As EventArgs) Handles FormViewPerson.DataBound
        If FormViewPerson.CurrentMode = FormViewMode.ReadOnly Then
            Dim ConferenceControl As ConferenceFromURL = CType(Me.Parent.Page.Master.FindControl("ConferenceFromURL"), ConferenceFromURL)
            Dim lblConference As Label = CType(FormViewPerson.FindControl("lblConference"), Label)
            lblConference.Text = ConferenceControl.ConferenceShortName
        End If

        'If FormViewPerson.CurrentMode = FormViewMode.Edit Then
        '    If FormViewPerson.SelectedValue IsNot Nothing Then
        '        Dim CountryDDL As DropDownList = CType(FormViewPerson.FindControl("CountryDropDownList"), DropDownList)
        '        Dim StateDDL As DropDownList = CType(FormViewPerson.FindControl("StateProvinceDropDownList"), DropDownList)
        '        Dim PersonID As Integer = FormViewPerson.SelectedValue
        '        Dim PersonData As DataRow = BattellePersonGetAsDataRow(PersonID)
        '        If Not IsDBNull(PersonData("Country")) Then
        '            CountryDDL.SelectedIndex = IIf(CountryDDL.Items.FindByText(PersonData("Country")) IsNot Nothing, CountryDDL.Items.IndexOf(CountryDDL.Items.FindByText(PersonData("Country"))), 0)
        '        End If
        '        StateDDL.DataBind()

        '        If Not IsDBNull(PersonData("StateProvince")) Then
        '            StateDDL.SelectedIndex = IIf(StateDDL.Items.FindByValue(PersonData("StateProvince")) IsNot Nothing, StateDDL.Items.IndexOf(CountryDDL.Items.FindByValue(PersonData("StateProvince"))), 0)
        '        End If
        '    End If
        'End If
    End Sub

    Protected Sub FormViewPerson_DataBinding(sender As Object, e As EventArgs) Handles FormViewPerson.DataBinding

    End Sub

    Protected Sub HtmlDecode_PreRender(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
            item.Value = Server.HtmlDecode(item.Value)
        Next
    End Sub

    Protected Sub SqlDataSourceLookupStateProvince_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceLookupStateProvince.Selecting

    End Sub

    Protected Function FormatPhoneNum(PhoneNum As String)
        'format phone number
        'Dim chkChar As String

        If Len(PhoneNum) = 12 Then 'No ext, check for dashes
            If CountCharacter(PhoneNum, "-") <> 2 Then '
                'something other than dashes
                PhoneNum = Replace(PhoneNum, " ", "-")
                PhoneNum = Replace(PhoneNum, "(", "")
                PhoneNum = Replace(PhoneNum, ")", "")
                PhoneNum = Replace(PhoneNum, ".", "-")
            End If
        End If
        'PhoneNum = Replace(PhoneNum, "-", "")

        Return PhoneNum
    End Function

    Public Function CountCharacter(ByVal value As String, ByVal ch As Char) As Integer
        Dim cnt As Integer = 0
        For Each c As Char In value
            If c = ch Then
                cnt += 1
            End If
        Next
        Return cnt
    End Function
End Class