Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.Data.SqlClient


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PersonAutocomplete
    Inherits System.Web.Services.WebService

    <System.Web.Script.Services.ScriptMethod(),
    System.Web.Services.WebMethod()>
    Public Shared Function SearchPeople(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim conn As SqlConnection = New SqlConnection
        conn.ConnectionString = ConfigurationManager _
         .ConnectionStrings("Data Source=SQL-DEV;Initial Catalog=Battelle;Persist Security Info=True;User ID=SA;Password=#5cgQ89!").ConnectionString
        Dim cmd As SqlCommand = New SqlCommand
        cmd.CommandText = "select LastName from Person where LastName like @SearchText + '%'"
        cmd.Parameters.AddWithValue("@SearchText", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim people As List(Of String) = New List(Of String)
        Dim sdr As SqlDataReader = cmd.ExecuteReader
        While sdr.Read
            people.Add(sdr("LastName").ToString)
        End While
        conn.Close()
        Console.Write(people.Count())
        Return people
    End Function

End Class