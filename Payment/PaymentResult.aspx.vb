Public Class PaymentResult
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrWhiteSpace(Request.QueryString("msg")) Then
            LiteralGoBackURL.Text = "<span class=""btn btn-primary""><a style=""color:white;"" href=""" + HttpUtility.UrlDecode(Request.QueryString("goback")) + """>View your Confirmation</a></span>"
            PanelPaymentSuccess.Visible = True
            PanelPaymentError.Visible = False
        Else
            PanelPaymentSuccess.Visible = False
            PanelPaymentError.Visible = True
        End If
    End Sub

End Class