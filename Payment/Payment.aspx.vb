Public Class Payment
    Inherits System.Web.UI.Page

    Dim ConferenceControl As ConferenceFromURL
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")

        Session("pTransactionAmount") = Session("pTransactionAmount")
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            Session("pPersonID") = Session("PersonID")
        Else
            Response.Redirect("~/Error.aspx?error=personsession&code=1", True)
        End If

        Session("pTransactionTimestamp") = Session("pTransactionTimestamp")
        Session("pOrigin") = Session("pOrigin")
        Session("pTestRequest") = Session("pTestRequest")
        Session("pDescription") = Session("pDescription")
        Dim PaymentSessionTimestampL As Long
        Dim PaymentSessionTimestamp As DateTime

        Dim IsValidPaymentSession As Boolean
        IsValidPaymentSession = IsNumeric(Session("pTransactionAmount"))
        IsValidPaymentSession = IsNumeric(Session("pPersonID"))
        IsValidPaymentSession = Long.TryParse(Session("pTransactionTimestamp"), PaymentSessionTimestampL)
        PaymentSessionTimestamp = DateTime.FromBinary(PaymentSessionTimestampL)

        If (Now - PaymentSessionTimestamp).Seconds > 60 Then
            IsValidPaymentSession = False
        End If

        If Not IsValidPaymentSession Then
            Response.Redirect("~/Error.aspx", True)
        End If

        LabelTransactionAmount.Text = Session("pTransactionAmount")


    End Sub

    Protected Sub ButtonConfirm_Click(sender As Object, e As EventArgs) Handles ButtonConfirm.Click
        Session("pFirstName") = TextBoxFirstName.Text
        Session("pLastName") = TextBoxLastName.Text
        Session("pAddress") = TextBoxAddress.Text
        Session("pCity") = TextBoxCity.Text
        Session("pState") = StateProvinceDropDownList.SelectedValue
        Session("pCountry") = CountryDropDownList.SelectedValue
        Session("pZip") = TextBoxZip.Text
        'Session("pZip") = TextBoxZip.Text
        Session("pTransactionTimestamp") = Now.ToBinary.ToString()
        Dim sURL As String = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/payment/confirm"
        Response.Redirect(sURL, True)

    End Sub

    Protected Sub HtmlDecode_PreRender(sender As Object, e As EventArgs)
        Dim CDropDownList As DropDownList = CType(sender, DropDownList)

        For Each item As ListItem In CDropDownList.Items
            item.Text = Server.HtmlDecode(item.Text)
        Next
    End Sub

End Class