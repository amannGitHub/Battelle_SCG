Imports System.IO
Public Class PaymentConfirm
    Inherits System.Web.UI.Page

    Dim ConferenceControl As ConferenceFromURL
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")

        Session("pTransactionAmount") = Session("pTransactionAmount")
        'Session("pPersonID") = Session("pPersonID")
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            Session("pPersonID") = Session("PersonID")
        Else
            Response.Redirect("~/Error.aspx?error=personsession&code=2", True)
        End If
        Session("pConferenceID") = Session("pConferenceID")
        Session("pTransactionTimestamp") = Session("pTransactionTimestamp")
        Session("pOrigin") = Session("pOrigin")
        Session("pTestRequest") = Session("pTestRequest")

        'Request.Form.Clear()

        Dim PersonID As Integer
        Dim PersonData As DataRow
        Dim FirstName As String = ""
        Dim LastName As String = ""
        Dim Address As String = ""
        Dim City As String = ""
        Dim State As String = ""
        Dim Zip As String = ""
        Dim Country As String = ""
        Dim EmailCustomer As String

        Dim TransactionAmount As Decimal

        Dim AuthorizeNetLogin As String

        Dim AuthorizeTestRequest As String = "FALSE"
        Dim AuthorizeRelayResponse As String

        Dim AuthorizeRelayURL As String

        Dim FingerprintTimestamp As String
        Dim FingerprintSequence As String
        Dim FingerprintHash As String

        Dim AuthorizeMethod As String = "CC"
        Dim AuthorizeMethodType As String = "AUTH_CAPTURE"

        Dim AuthorizeInvoiceID As String = ConferenceControl.ConferenceSCGCode

        Dim SCGReceiptLink As String


        Dim PaymentSessionTimestampL As Long
        Dim PaymentSessionTimestamp As DateTime

        Dim IsValidPaymentSession As Boolean
        IsValidPaymentSession = Decimal.TryParse(Session("pTransactionAmount"), TransactionAmount) 'TransactionAmount is now set, should be.
        If Not IsValidPaymentSession Then
            Response.Redirect("~/Error.aspx?error=paymentsession&code=1", True)
        End If
        IsValidPaymentSession = Integer.TryParse(Session("pPersonID"), PersonID)
        If Not IsValidPaymentSession Then
            Response.Redirect("~/Error.aspx?error=paymentsession&code=2", True)
        End If
        PersonData = BattellePersonGetAsDataRow(PersonID)
        IsValidPaymentSession = Not IsNothing(PersonData)
        If Not IsValidPaymentSession Then
            Response.Redirect("~/Error.aspx?error=paymentsession&code=3", True)
        End If

        IsValidPaymentSession = Long.TryParse(Session("pTransactionTimestamp"), PaymentSessionTimestampL)
        If Not IsValidPaymentSession Then
            Response.Redirect("~/Error.aspx?error=paymentsession&code=4", True)
        End If
        PaymentSessionTimestamp = DateTime.FromBinary(PaymentSessionTimestampL)

        If (Now - PaymentSessionTimestamp).Seconds > 60 Then ' Safeguard to ensure users are only going to pay for current transactions
            IsValidPaymentSession = False
        End If

        If Not IsValidPaymentSession Then
            Response.Redirect("~/Error.aspx?error=paymentsession&code=5", True)
        End If

        If Session.Count > 0 Then
            FirstName = Session("pFirstName")
            LastName = Session("pLastName")
            Address = Session("pAddress")
            City = Session("pCity")
            State = Session("pState")
            Zip = Session("pZip")
            Country = Session("pCountry")
        End If

        LabelFirstName.Text = IIf(FirstName Is Nothing, String.Empty, FirstName)
        LabelLastName.Text = IIf(LastName Is Nothing, String.Empty, LastName)
        LabelAddress.Text = IIf(Address Is Nothing, String.Empty, Address)
        LabelCity.Text = IIf(City Is Nothing, String.Empty, City)
        LabelState.Text = IIf(State Is Nothing, String.Empty, State)
        LabelCountry.Text = IIf(Country Is Nothing, String.Empty, Country)
        LabelZip.Text = IIf(Zip Is Nothing, String.Empty, Zip)

        LabelTransactionAmount.Text = TransactionAmount.ToString


        EmailCustomer = "TRUE"

        AuthorizeNetLogin = ConfigurationManager.AppSettings("AUTHORIZE_NET_API_LOGIN")
        If Not String.IsNullOrWhiteSpace(Session("pTestRequest")) Then
            If Session("pTestRequest") = "TestTrue" Then
                AuthorizeTestRequest = "TRUE"
            End If
        End If

        AuthorizeRelayResponse = "TRUE"
        AuthorizeRelayURL = BattelleGetApplicationURL() + "SIM" ' this should be a custom thing...
        'AuthorizeRelayURL = "https://developer.authorize.net/tools/paramdump/index.php"

        SCGReceiptLink = BattelleGetApplicationURL() + ConferenceControl.ConferenceURLString + "/payment/result"


        FingerprintTimestamp = AuthorizeNet.Crypto.GenerateTimestamp().ToString()
        FingerprintSequence = AuthorizeNet.Crypto.GenerateSequence()
        FingerprintHash = AuthorizeNet.Crypto.GenerateFingerprint(ConfigurationManager.AppSettings("AUTHORIZE_NET_TRANSACTION_KEY"), AuthorizeNetLogin, TransactionAmount, FingerprintSequence, FingerprintTimestamp)

        'AuthorizeInvoiceID += "-" + FirstName.Trim.Chars(0) + LastName.Trim.Chars(0) + Now.Month.ToString + Now.Day.ToString + Now.Hour.ToString + Now.Minute.ToString
        'AuthroizeInvoiceID cannot be over 20 characters. Prefix "BATTELLE" + maximum 12 characters from above = 20
        'AuthorizeInvoiceID = Left(AuthorizeInvoiceID, 20)


        BattelleTransactionLogInsert(AuthorizeInvoiceID, PersonData("ParticipationID"), Nothing, Nothing, ConferenceControl.ConferenceID, PersonID, TransactionAmount, False)

        ClientScript.RegisterHiddenField("x_cust_id", PersonData("ParticipationID"))


        ClientScript.RegisterHiddenField("x_email_customer", EmailCustomer)

        ClientScript.RegisterHiddenField("x_first_name", FirstName)
        ClientScript.RegisterHiddenField("x_last_name", LastName)
        ClientScript.RegisterHiddenField("x_address", Address)
        ClientScript.RegisterHiddenField("x_city", City)
        ClientScript.RegisterHiddenField("x_state", State)
        ClientScript.RegisterHiddenField("x_country", Country)
        ClientScript.RegisterHiddenField("x_zip", Zip)

        ClientScript.RegisterHiddenField("x_method", AuthorizeMethod)
        ClientScript.RegisterHiddenField("x_type", AuthorizeMethodType)

        ClientScript.RegisterHiddenField("x_login", AuthorizeNetLogin)
        ClientScript.RegisterHiddenField("x_test_request", AuthorizeTestRequest)
        ClientScript.RegisterHiddenField("x_relay_response", AuthorizeRelayResponse)
        ClientScript.RegisterHiddenField("x_relay_url", AuthorizeRelayURL)

        ClientScript.RegisterHiddenField("scg_receipt", SCGReceiptLink)
        ClientScript.RegisterHiddenField("scg_origin", Session("pOrigin"))
        ClientScript.RegisterHiddenField("scg_battelle_conference", ConferenceControl.ConferenceURLString)

        ClientScript.RegisterHiddenField("x_invoice_num", AuthorizeInvoiceID)

        ClientScript.RegisterHiddenField("x_fp_timestamp", FingerprintTimestamp)
        ClientScript.RegisterHiddenField("x_fp_sequence", FingerprintSequence)
        ClientScript.RegisterHiddenField("x_fp_hash", FingerprintHash)

        ClientScript.RegisterHiddenField("x_amount", TransactionAmount.ToString)
        ClientScript.RegisterHiddenField("x_description", Session("pDescription"))

        'Add company
        Dim sEmployer As String
        sEmployer = PersonData("Employer").ToString
        ClientScript.RegisterHiddenField("x_company", sEmployer)


        'ButtonSubmitPayment.PostBackUrl = "https://test.authorize.net/gateway/transact.dll"
        ButtonSubmitPayment.PostBackUrl = "https://secure.authorize.net/gateway/transact.dll"
        'ButtonSubmitPayment.PostBackUrl = "https://developer.authorize.net/tools/paramdump/index.php"


    End Sub

    Protected Sub ButtonGoBack_Click(sender As Object, e As EventArgs) Handles ButtonGoBack.Click
        Dim NewURL = "~/" + ConferenceControl.ConferenceURLString + "/payment"

        Response.Redirect(NewURL, True)
    End Sub

    Protected Overrides Sub Render(output As HtmlTextWriter)
        Dim stringWriter As New StringWriter()

        Dim textWriter As New HtmlTextWriter(stringWriter)
        MyBase.Render(textWriter)

        textWriter.Close()

        Dim strOutput As String = stringWriter.GetStringBuilder().ToString()

        strOutput = Regex.Replace(strOutput, "<input[^>]*id=""__[^>]*""[^>]*>", "", RegexOptions.Singleline)
        strOutput = Regex.Replace(strOutput, "<input type=""hidden""[^>]*name=""ct[^>]*""[^>]*>", "", RegexOptions.Singleline)

        output.Write(strOutput)
    End Sub


End Class