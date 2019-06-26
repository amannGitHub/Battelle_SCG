Public Class PaymentTest
    Inherits System.Web.UI.Page

    Dim ConferenceControl As ConferenceFromURL
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        Session.Clear()
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Session("pFirstName") = "John"
        Session("pLastName") = "Doe"
        Session("pAddress") = "656 Quince Orchard Road Suite 210"
        Session("pCity") = "Gaithersburg"
        Session("pState") = "Maryland"
        Session("pZip") = "20878"
        Session("pCountry") = "USA"

        Session("pTransactionAmount") = "9.99"
        Session("pPersonID") = "1"
        Session("pTransactionTimestamp") = Now.ToBinary.ToString()
        Session("pOrigin") = Request.Url.ToString
        Session("pTestRequest") = "TestTrue"
        Response.Redirect("~/" + ConferenceControl.ConferenceURLString + "/payment/confirm", True)
    End Sub
End Class