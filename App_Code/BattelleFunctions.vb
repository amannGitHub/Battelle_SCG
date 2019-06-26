Imports System.Data
Imports System.Data.SqlClient


Module BattelleFunctions
    Public Function BattelleGetApplicationURL() As String
        Return ConfigurationManager.AppSettings("MainWebURL")
    End Function

    Public Function BattelleGenerateParticipationID(FirstName As String, LastName As String) As String
        Dim ParticipationID As String
        ParticipationID = Now.Year.ToString() + Now.Month.ToString() + Now.Day.ToString() + FirstName.Trim().Chars(0) + LastName.ToString().Trim().Chars(0) + Now.Hour.ToString() + Now.Minute.ToString()
        Return ParticipationID
    End Function

    Public Sub BattelleSetParticipationID(PersonID As Integer, ParticipationID As String)
        Dim Command As SqlCommand = New SqlCommand("PersonSetParticipationID")
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Command.Parameters.AddWithValue("ParticipationID", ParticipationID)
        BattelleExecuteCommand(Command)
    End Sub

    Public Function BattelleGenerateOrganizationID(Exhibitor As String) As String
        Dim OrganizationID As String
        Dim sExhibCode As String
        Exhibitor = Exhibitor.Replace("The ", "")
        sExhibCode = Left(Exhibitor, 3)
        OrganizationID = Now.Year.ToString() + Now.Month.ToString() + Now.Day.ToString() + sExhibCode + Now.Hour.ToString() + Now.Minute.ToString()
        Return OrganizationID.ToUpper
    End Function

    Public Sub BattelleSendMail(ByVal Content As String, ByVal Email As String, Optional Subject As String = "New Message", Optional Priority As System.Net.Mail.MailPriority = Net.Mail.MailPriority.Normal, Optional FromName As String = "Battelle Conference", Optional FromEmail As String = "webmaster@scgcorp.com", Optional BattelleEmail As String = "")

        Dim smtp As New System.Net.Mail.SmtpClient("mail.scgcorp.com")
        Dim mail As New System.Net.Mail.MailMessage

        mail.From = New System.Net.Mail.MailAddress(FromEmail, FromName, System.Text.Encoding.UTF8)
        If (Email = "scg") Then
            mail.To.Add("amann@scgcorp.com")
            mail.To.Add("jkaufman@scgcorp.com")
            mail.To.Add("akeller@scgcorp.com")
        Else
            mail.To.Add(New System.Net.Mail.MailAddress(Email))
            'Add code to support semicolon'd list ?

            mail.To.Add(FromEmail)
            If Not Email.Contains("@scgcorp.com") Then 'This is to filter out test emails from SCG
                'mail.To.Add(FromEmail) '(Removed scgcorp filter, Susie wants To see test emails) - still in place for Battelle
                If BattelleEmail <> "" Then
                    'Add Sarah to emails as requested (as of 5/31/2018 only Sponsor Registration)
                    'check for multiple emails (as requested 9/12/2018 to add both Gina and Sarah)
                    Dim BattelleEmails As String() = BattelleEmail.Split(",")
                    Dim BattelleEmailAddress As String
                    For Each BattelleEmailAddress In BattelleEmails
                        mail.To.Add(BattelleEmailAddress)
                    Next
                End If
            End If


        End If

            mail.Subject = Subject
        mail.Priority = Priority

        mail.IsBodyHtml = True
        mail.Body = Content
        Try
            smtp.Send(mail)
        Catch
            BattelleError("Email failure to " & Email & "; Subject: " & Subject)
        Finally
            mail.Dispose()
            smtp = Nothing
        End Try

    End Sub

    Public Sub BattelleError(ByVal ErrorMessage As String)
        BattelleLogDiagnostic("Error logged: " + ErrorMessage)
        BattelleSendMail(ErrorMessage, "scg", "Battelle Error", Net.Mail.MailPriority.High)
    End Sub


    Function BattelleExecuteCommand(ByRef Command As SqlCommand) As DataSet
        Dim ConnectionString As String = ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString
        Dim ds As New DataSet()

        Try
            Dim Connection As New SqlConnection(ConnectionString)
            Command.Connection = Connection

            If Command.CommandText.Contains(" ") Then
                Command.CommandType = CommandType.Text
            Else
                Command.CommandType = CommandType.StoredProcedure
            End If

            Dim Adapter As New SqlDataAdapter(Command)
            Adapter.SelectCommand.CommandTimeout = 300

            Adapter.Fill(ds)
            Connection.Close()

        Catch ex As Exception
            BattelleError("Error executing stored procedure.<br />" + ex.Message)
        End Try

        Return ds
    End Function

    Sub BattelleLogDiagnostic(Data As String)
        Dim Command As SqlCommand = New SqlCommand("DiagnosticInsert")
        Dim Parameter As SqlParameter = New SqlParameter("DiagData", Data)
        Command.Parameters.Add(Parameter)

        BattelleExecuteCommand(Command)
    End Sub

    Function BattelleParticipationIDByPerson(PersonID As Integer) As String
        Dim Command As SqlCommand = New SqlCommand("ParticipationIDGetByPerson")
        Dim Parameter As SqlParameter = New SqlParameter("PersonID", PersonID)
        Command.Parameters.Add(Parameter)

        Return BattelleExecuteCommand(Command).Tables(0).Rows(0)("ParticipationID")

    End Function

    Function BattelleEmailGetByNameAsDataRow(EmailName As String) As DataRow
        Dim Command As SqlCommand = New SqlCommand("EmailGetByName")
        Command.Parameters.AddWithValue("EmailName", EmailName)
        Dim ReturnData As DataSet = BattelleExecuteCommand(Command)
        If ReturnData.Tables(0).Rows.Count = 0 Then
            Return Nothing
        Else
            Return ReturnData.Tables(0).Rows(0)
        End If
    End Function

    Function BattellePersonGetAsDataRow(PersonID As Integer) As DataRow
        Dim Command As SqlCommand = New SqlCommand("PersonGet")
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Dim ReturnData As DataSet = BattelleExecuteCommand(Command)
        If ReturnData.Tables(0).Rows.Count = 0 Then
            Return Nothing
        Else
            Return ReturnData.Tables(0).Rows(0)
        End If
    End Function



    Function BattellePersonGetByParticipationIDAsDataRow(ParticipationID As String) As DataRow
        Dim Command As SqlCommand = New SqlCommand("PersonGetByParticipationID")
        Command.Parameters.AddWithValue("ParticipationID", ParticipationID)
        Dim ReturnData As DataSet = BattelleExecuteCommand(Command)
        If ReturnData.Tables(0).Rows.Count = 0 Then
            Return Nothing
        Else
            Return ReturnData.Tables(0).Rows(0)
        End If
    End Function

    Function BattellePersonGetByEmailAsDataRow(Email As String) As DataRow
        Dim Command As SqlCommand = New SqlCommand("PersonGetByEmail")
        Command.Parameters.AddWithValue("Email", Email)
        Dim ReturnData As DataSet = BattelleExecuteCommand(Command)
        If ReturnData.Tables(0).Rows.Count = 0 Then
            Return Nothing
        Else
            Return ReturnData.Tables(0).Rows(0)
        End If
    End Function

    Function BattelleTransactionLogGetByInvoiceAsDataRow(Invoice As String, ParticipationID As String) As DataRow
        Dim Command As SqlCommand = New SqlCommand("TransactionLogGetByInvoice")
        Command.Parameters.AddWithValue("TransactionInvoice", Invoice)
        Command.Parameters.AddWithValue("TransactionParticipationID", ParticipationID)
        Dim ReturnData As DataSet = BattelleExecuteCommand(Command)
        If ReturnData.Tables(0).Rows.Count = 0 Then
            Return Nothing
        Else
            Return ReturnData.Tables(0).Rows(0)
        End If
    End Function

    Sub BattelleTransactionLogInsert(Invoice As String, ParticipationID As String, ResponseCode As Integer, ResponseReasonCode As Integer, ConferenceID As Integer, PersonID As Integer, Amount As Decimal, ReceivedByPaymentGateway As Boolean)
        Dim Command As SqlCommand = New SqlCommand("TransactionLogInsert")
        Command.Parameters.AddWithValue("TransactionInvoice", Invoice)
        Command.Parameters.AddWithValue("TransactionParticipationID", ParticipationID)
        Command.Parameters.AddWithValue("TransactionResponseCode", ResponseCode)
        Command.Parameters.AddWithValue("TransactionResponseReasonCode", ResponseReasonCode)
        Command.Parameters.AddWithValue("TransactionConferenceID", ConferenceID)
        Command.Parameters.AddWithValue("TransactionPersonID", PersonID)
        Command.Parameters.AddWithValue("TransactionAmount", Amount)
        Command.Parameters.AddWithValue("TransactionReceivedByPaymentGateway", ReceivedByPaymentGateway)
        BattelleExecuteCommand(Command)

    End Sub

    Sub BattelleTransactionLogUpdate(LogID As Integer, ResponseCode As Integer, ResponseReasonCode As Integer, ReceivedByPaymentGateway As Boolean)
        Dim Command As SqlCommand = New SqlCommand("TransactionLogUpdate")
        Command.Parameters.AddWithValue("TransactionLogID", LogID)
        Command.Parameters.AddWithValue("TransactionResponseCode", ResponseCode)
        Command.Parameters.AddWithValue("TransactionResponseReasonCode", ResponseReasonCode)
        Command.Parameters.AddWithValue("TransactionReceivedByPaymentGateway", ReceivedByPaymentGateway)
        BattelleExecuteCommand(Command)

    End Sub

    Sub BattelleSecurityFailure(UserHost As String)
        Dim Command As SqlCommand = New SqlCommand("SecurityFailureIncrement")
        Dim Parameter As SqlParameter = New SqlParameter("UserHost", UserHost)
        Command.Parameters.Add(Parameter)

        BattelleExecuteCommand(Command)
    End Sub

    Function BattelleSecurityFailureCheck(UserHost As String) As Boolean

        Dim SecurityFailureCount As Integer = 0
        Dim LastFailure As DateTime
        Dim DS As DataSet

        DS = BattelleExecuteCommand(New SqlCommand("SELECT FailureCount, LastFailure FROM SecurityFailure WHERE [UserHost]='" + UserHost + "'"))
        If DS.Tables(0).Rows.Count < 1 Then
            Return True
        Else
            SecurityFailureCount = DS.Tables(0).Rows(0)(0)
            LastFailure = DS.Tables(0).Rows(0)(1)
            'If their last failure was more than 5 minutes ago, delete their security failure record
            'If their last failure was less than 5 minutes ago, and less than or equal to 5 fail counts, return true
            'If less than 5 minutes and more than 5 fail counts, return false
            If (Now - LastFailure) > TimeSpan.FromMinutes(5) Then
                Dim Command As SqlCommand = New SqlCommand("SecurityFailureDelete")
                Dim Parameter As SqlParameter = New SqlParameter("UserHost", UserHost)
                Command.Parameters.Add(Parameter)

                BattelleExecuteCommand(Command)
                Return True
            Else
                If SecurityFailureCount < 5 Then
                    Return True
                End If
            End If

            Return False
        End If

        'BattelleExecuteCommand(Command)
    End Function

    Function BattelleAbstractAuthorsInsert(AbstractID As Integer, PersonID As Integer, Presenter As Boolean) As DataSet
        Dim Command As New SqlCommand("AbstractAuthorsInsert")
        Command.Parameters.AddWithValue("AbstractID", AbstractID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Command.Parameters.AddWithValue("Presenter", Presenter)
        Return BattelleExecuteCommand(Command)
    End Function



    Function BattelleAbstractAuthorsUpdate(AbstractID As Integer, PersonID As Integer, Presenter As Boolean) As DataSet
        Dim Command As New SqlCommand("AbstractAuthorsUpdate")
        Command.Parameters.AddWithValue("AbstractID", AbstractID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Command.Parameters.AddWithValue("Presenter", Presenter)
        Return BattelleExecuteCommand(Command)
    End Function


    Function BattelleShortCourseInstructorsUpdate(CourseID As Integer, PersonID As Integer, Presenter As Boolean) As DataSet
        Dim Command As New SqlCommand("ShortCourseInstructorsUpdate")
        Command.Parameters.AddWithValue("CourseID", CourseID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Command.Parameters.AddWithValue("Presenter", Presenter)
        Return BattelleExecuteCommand(Command)
    End Function


    Function BattelleAbstractAuthorsDelete(AbstractID As Integer, PersonID As Integer) As DataSet
        Dim Command As New SqlCommand("AbstractAuthorsDelete")
        Command.Parameters.AddWithValue("AbstractID", AbstractID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Return BattelleExecuteCommand(Command)
    End Function


    Function BattelleShortCourseInstructorsDelete(CourseID As Integer, PersonID As Integer) As DataSet
        Dim Command As New SqlCommand("ShortCourseInstructorsDelete")
        Command.Parameters.AddWithValue("CourseID", CourseID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Return BattelleExecuteCommand(Command)
    End Function



    Function BattelleShortCourseInstructorsInsert(LearningLabID As Integer, PersonID As Integer, POCInstructor As Boolean) As DataSet
        Dim Command As New SqlCommand("ShortCourseInstructorsInsert")
        Command.Parameters.AddWithValue("CourseID", LearningLabID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Command.Parameters.AddWithValue("POCInstructor", POCInstructor)
        Return BattelleExecuteCommand(Command)
    End Function



    Function BattelleLearningLabInstructorsUpdate(LearningLabID As Integer, PersonID As Integer, Instructor As Boolean) As DataSet
        Dim Command As New SqlCommand("LearningLabInstructorsUpdate")
        Command.Parameters.AddWithValue("LearningLabID", LearningLabID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Command.Parameters.AddWithValue("Instructor", Instructor)
        Return BattelleExecuteCommand(Command)
    End Function

    Function BattelleLearningLabInstructorsDelete(LearningLabID As Integer, PersonID As Integer) As DataSet
        Dim Command As New SqlCommand("LearningLabInstructorsDelete")
        Command.Parameters.AddWithValue("LearningLabID", LearningLabID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Return BattelleExecuteCommand(Command)
    End Function

    Function BattelleLearningLabInstructorsInsert(LearningLabID As Integer, PersonID As Integer, POCInstructor As Boolean) As DataSet
        Dim Command As New SqlCommand("LearningLabInstructorsInsert")
        Command.Parameters.AddWithValue("LearningLabID", LearningLabID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Command.Parameters.AddWithValue("POCInstructor", POCInstructor)
        Return BattelleExecuteCommand(Command)
    End Function


    Function BattelleGovNonProfitBoothsGet(ConferenceID As Integer) As DataRow
        Dim Command As SqlCommand = New SqlCommand("BoothGovNonProfitByConferenceID")
        Dim NoResults As String = ""
        Command.Parameters.AddWithValue("ConferenceID", ConferenceID)
        Dim ReturnData As DataSet = BattelleExecuteCommand(Command)
        If ReturnData.Tables(0).Rows.Count = 0 Then
            Return Nothing
        Else
            Return ReturnData.Tables(0).Rows(0)
        End If
    End Function



    Function BattelleConferencePersonRolesInsert(ConferenceID As Integer, RoleID As Integer, PersonID As Integer, TopicGroupID As Integer, SessionID As Integer, LeadChair As Boolean, ListOrder As Integer, Accepted As Boolean) As DataSet
        Dim Command As New SqlCommand("ConferencePersonRolesInsert")
        Command.Parameters.AddWithValue("ConferenceID", ConferenceID)
        Command.Parameters.AddWithValue("RoleID", RoleID)
        Command.Parameters.AddWithValue("PersonID", PersonID)
        Command.Parameters.AddWithValue("TopicGroupID", TopicGroupID)
        Command.Parameters.AddWithValue("SessionID", SessionID)
        Command.Parameters.AddWithValue("LeadChair", LeadChair)
        Command.Parameters.AddWithValue("ListOrder", ListOrder)
        Command.Parameters.AddWithValue("Accepted", Accepted)
        Return BattelleExecuteCommand(Command)
    End Function


    Function BattelleValidatePersonData(ByRef PersonData As DataRow, Optional PrimaryValidation As Boolean = True, Optional ByRef ValidationFailures As NameValueCollection = Nothing) As Boolean
        'Dim IsValid As Boolean = True

        'If IsValid AndAlso IsDBNull(PersonData("FirstName")) Then
        '    IsValid = False
        'End If
        'If IsValid AndAlso IsDBNull(PersonData("LastName")) Then
        '    IsValid = False
        'End If
        'If IsValid AndAlso IsDBNull(PersonData("AddressLine1")) Then
        '    IsValid = False
        'End If
        'If IsValid AndAlso IsDBNull(PersonData("City")) Then
        '    IsValid = False
        'End If
        'If IsValid AndAlso IsDBNull(PersonData("StateProvince")) Then
        '    IsValid = False
        'End If
        'If IsValid AndAlso IsDBNull(PersonData("ZipPostal")) Then
        '    IsValid = False
        'End If
        'If IsValid AndAlso IsDBNull(PersonData("Email")) Then
        '    IsValid = False
        'End If
        'If IsValid AndAlso (IsDBNull(PersonData("PhoneNum")) And IsDBNull(PersonData("CellNum"))) Then
        '    IsValid = False
        'End If

        If ValidationFailures Is Nothing Then
            ValidationFailures = New NameValueCollection()
        End If

        Dim PersonDataDict As System.Collections.Specialized.IOrderedDictionary = New OrderedDictionary()
        PersonDataDict.Add("FirstName", IIf(IsDBNull(PersonData("FirstName")), Nothing, PersonData("FirstName")))
        PersonDataDict.Add("LastName", IIf(IsDBNull(PersonData("LastName")), Nothing, PersonData("LastName")))
        PersonDataDict.Add("AddressLine1", IIf(IsDBNull(PersonData("AddressLine1")), Nothing, PersonData("AddressLine1")))
        PersonDataDict.Add("City", IIf(IsDBNull(PersonData("City")), Nothing, PersonData("City")))
        PersonDataDict.Add("StateProvince", IIf(IsDBNull(PersonData("StateProvince")), Nothing, PersonData("StateProvince")))
        PersonDataDict.Add("ZipPostal", IIf(IsDBNull(PersonData("ZipPostal")), Nothing, PersonData("ZipPostal")))
        PersonDataDict.Add("Country", IIf(IsDBNull(PersonData("Country")), Nothing, PersonData("Country")))
        PersonDataDict.Add("Email", IIf(IsDBNull(PersonData("Email")), Nothing, PersonData("Email")))
        PersonDataDict.Add("PhoneNum", IIf(IsDBNull(PersonData("PhoneNum")), Nothing, PersonData("PhoneNum")))
        PersonDataDict.Add("CellNum", IIf(IsDBNull(PersonData("CellNum")), Nothing, PersonData("CellNum")))


        Return BattelleValidatePersonDataDictionary(PersonDataDict, PrimaryValidation, ValidationFailures)
    End Function

    Function BattelleValidatePersonDataDictionary(ByRef PersonDataDict As System.Collections.Specialized.IOrderedDictionary, Optional PrimaryValidation As Boolean = True, Optional ByRef ValidationFailures As NameValueCollection = Nothing) As Boolean
        Dim IsValid As Boolean = True
        If ValidationFailures Is Nothing Then
            ValidationFailures = New NameValueCollection()
        End If


        If String.IsNullOrWhiteSpace(PersonDataDict("FirstName")) Then
            IsValid = False
            ValidationFailures.Add("FirstName", "First name is required")
        End If
        If String.IsNullOrWhiteSpace(PersonDataDict("LastName")) Then
            IsValid = False
            ValidationFailures.Add("LastName", "Last name is required")
        End If

        'Email and office phone no longer required

        'If String.IsNullOrWhiteSpace(PersonDataDict("Email")) Then
        '    IsValid = False
        '    ValidationFailures.Add("Email", "Email is required")
        'End If
        If PrimaryValidation Then
            If String.IsNullOrWhiteSpace(PersonDataDict("AddressLine1")) Then
                IsValid = False
                ValidationFailures.Add("Address Line 1", "Address line (at least one) is required")
            End If
            If String.IsNullOrWhiteSpace(PersonDataDict("City")) Then
                IsValid = False
                ValidationFailures.Add("City", "City is required")
            End If
            If String.IsNullOrWhiteSpace(PersonDataDict("ZipPostal")) Then
                IsValid = False
                ValidationFailures.Add("Zip/Postal", "Zip or postal code is required")
            End If
            If String.IsNullOrWhiteSpace(PersonDataDict("Country")) Or PersonDataDict("Country").ToString().Contains("select") Then
                IsValid = False
                ValidationFailures.Add("Country", "Country is required")
            Else
                If (PersonDataDict("Country") = "USA" Or PersonDataDict("Country") = "Canada" Or PersonDataDict("Country") = "Australia") And PersonDataDict("StateProvince") = "" Then
                    IsValid = False
                    ValidationFailures.Add("State/Province", "State or province selection is required if your country is USA, Canada, or Australia")
                End If
                'SCGTODO - this is a hack because it needs to launch
                If (PersonDataDict("Country").ToString.Contains("USACanadaAustralia")) And PersonDataDict("StateProvince") <> "" Then
                    IsValid = False
                    ValidationFailures.Add("State/Province", "State or province selection is only required if your country is USA, Canada, or Australia.")
                End If
               
            End If
            'If (String.IsNullOrWhiteSpace(PersonDataDict("PhoneNum"))) Then
            '    IsValid = False
            '    ValidationFailures.Add("Office Number", "Office Phone number is required")
            'End If
        End If

        Return IsValid
    End Function



End Module
