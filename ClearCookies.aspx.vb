Public Class ClearCookies
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim myCookie As HttpCookie
        myCookie = New HttpCookie("battelle")
        myCookie.Expires = DateTime.Now.AddDays(-1)
        Response.Cookies.Add(myCookie)
    End Sub

End Class