Imports System.Data.SqlClient

Public Class SIM
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' This page cannot use the normal error handling...
        '
        ' It is called by Authorize.NET and doesn't contain cookies (IE ALL Session info is missing).
        ' Whatever this page returns is "piped" through Authorize.NET and is rendered in the client browser. 
        ' So it is basically required to return a redirect, so we can return to "sanity" (IE valid 
        ' Session variables) as soon as possible.
        ' 
        ' ALSO: Anything you render in this page (IE if you fail to do the redirect), will be rendered 
        ' to the client browser... and because the browser's URL won't be pointing to this page, 
        ' links will likely break.
        ' 
        ' It's really easiest just to redirect as soon as possible.
        'Response.Write(Request.Form.ToString)
        Dim SCGReceiptLink As String = Request.Form("scg_receipt")

        If True Then
            Dim LogEntry As String = String.Empty
            For Each Item As String In Request.Form.AllKeys
                LogEntry += Item + ":" + Request.Form(Item) + "|"
            Next
            LogEntry += Request.ServerVariables.ToString() + "|"
            LogEntry += Request.FilePath + "|"


            BattelleLogDiagnostic(LogEntry)

            Try

                Dim sr = New AuthorizeNet.SIMResponse(Request.Form)
                If Not sr.Approved Then
                    EndWithRedirect(SCGReceiptLink + "?msg=" + HttpUtility.UrlEncode("Credit card authorization denied: " + sr.Message + ", ResponseCode:" + sr.ResponseCode))
                End If
                If Not sr.Validate(ConfigurationManager.AppSettings("AUTHORIZE_NET_MD5_HASH"), ConfigurationManager.AppSettings("AUTHORIZE_NET_API_LOGIN")) Then
                    EndWithRedirect(SCGReceiptLink + "?cc=1&msg=" + HttpUtility.UrlEncode("Validation failed:" + sr.Message + ", ResponseCode:" + sr.ResponseCode))
                End If


                ' pull the order ID from the order
                Dim InvoiceID As String = sr.InvoiceNumber
                Dim ParticipationID As String = Request.Form("x_cust_id")

                ' Make sure the purchase ID is valid...  if not...
                ' If Not drPurchase.Read Then
                '     EndWithRedirect(GetApplicationURL() + "Error.aspx?cc=1&msg=" + HttpUtility.UrlEncode("Your purchase was completed, but we cannot XXX."))
                ' End If

                ' I also write the purchase amount to my database prior to directing the user to Confirm.Aspx... 
                ' Here, you can cross reference the price to detect a hacking attempt.
                ' If dbTotalAmountCharged <> Decimal.Parse(Request("x_amount")) Then
                '    EndWithRedirect(GetApplicationURL() + "Error.aspx?cc=1&msg=" + HttpUtility.UrlEncode("Your purchase was completed, but the invoice price does not match the amount charged to your card."))
                ' End If

                ' Complete the purchase here within your database... I write sr.Message, sr.ResponseCode, Integer.Parse(Request("x_response_reason_code")), sr.TransactionID, sr.AuthorizationCode to the database.
                Dim TransactionLogItem As DataRow = BattelleTransactionLogGetByInvoiceAsDataRow(InvoiceID, ParticipationID)

                Dim LedgerInsertCommand As SqlCommand = New SqlCommand("ConferenceLedgerInsert")
                LedgerInsertCommand.Parameters.AddWithValue("ConferenceID", TransactionLogItem("TransactionConferenceID"))
                LedgerInsertCommand.Parameters.AddWithValue("PersonID", TransactionLogItem("TransactionPersonID"))
                LedgerInsertCommand.Parameters.AddWithValue("FeeTypeID", 8)
                Dim tAmount As Decimal = Decimal.Parse(Request.Form("x_amount"))
                tAmount = Decimal.Negate(tAmount)
                LedgerInsertCommand.Parameters.AddWithValue("Amount", tAmount)
                BattelleExecuteCommand(LedgerInsertCommand)

                'SCGTODO add TransactionID
                BattelleTransactionLogUpdate(TransactionLogItem("TransactionLogID"), Request.Form("x_response_code"), Request.Form("x_response_reason_code"), True)

                EndWithRedirect(SCGReceiptLink + "?goback=" + HttpUtility.UrlEncode(Request.Form("scg_origin")))

                'EndWithRedirect(SCGReceiptLink)
            Catch x As Threading.ThreadAbortException
                ' do nothing... this is likely just the Response.End() throwing...

            Catch x As Exception
                'Dim logger As ILog = log4net.LogManager.GetLogger(Me.GetType())
                'logger.Fatal("Exception thrown in SIM.aspx", x)
                Dim ExLogEntry As String = Request.Url.ToString + ": " + x.Message

                BattelleError(ExLogEntry)
                EndWithRedirect(SCGReceiptLink + "?cc=1&msg=" + HttpUtility.UrlEncode("Fatal error. This error has been logged and you will be contacted shortly."))
            End Try
        End If

    End Sub

    Private Sub EndWithRedirect(ByVal strURL As String)
        Response.Write("<html><head><script type='text/javascript' charset='utf-8'>" + vbCrLf)
        Response.Write("window.location='" + strURL + "';" + vbCrLf)
        Response.Write("</script><noscript><meta http-equiv='refresh' content='1;url=" + strURL + "'></noscript></head><body></body></html>" + vbCrLf)
        Response.End()
        'Response.Redirect(strURL, True)
    End Sub


End Class