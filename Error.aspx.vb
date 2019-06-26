Public Class _Error
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("error") <> "" Then
            pnlError.Visible = True
            Select Case Request.QueryString("error")
                Case "paymentsession"
                    ltlErrorMessage.Text = "Payment gateway session has timed out. Code: " & Request.QueryString("code")
                Case "personsession"
                    ltlErrorMessage.Text = "There has been an error retrieving your information. Code: " & Request.QueryString("code")
                Case "personlogin"
                    ltlErrorMessage.Text = "The browser has rejected site cookie. Action: Enable cookies or try a different browser."
            End Select
        End If
    End Sub

End Class