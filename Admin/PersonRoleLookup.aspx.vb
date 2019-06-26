Imports System.Data.SqlClient

Public Class PersonRoleLookup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnPersonLookup_Click(sender As Object, e As EventArgs)
        If ddlConfList.SelectedIndex = 0 Then
            lblWarning.Visible = True
        Else
            lblWarning.Visible = False
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
            Dim adapter As New SqlDataAdapter()
            Dim command As New SqlCommand("SELECT 
	                                        FirstName,
	                                        LastName,
	                                        RoleName AS Role,
	                                        CAST(TopicGroupCode AS VARCHAR(3)) + ' - ' + TopicGroup AS Theme,
	                                        SessionCode + ' - ' + SessionName AS Session
	                                        FROM Person INNER JOIN ConferencePersonRoles ON Person.PersonID = ConferencePersonRoles.PersonID LEFT JOIN
	                                        ConferenceRole ON ConferencePersonRoles.RoleID = ConferenceRole.RoleID LEFT JOIN
	                                        TopicGroup ON ConferencePersonRoles.TopicGroupID = TopicGroup.TopicGroupID LEFT JOIN
	                                        Session ON ConferencePersonRoles.SessionID = Session.SessionID
	                                        WHERE ConferencePersonRoles.ConferenceID = @ConferenceID AND Person.PersonID = @PersonID", con)
            command.Parameters.AddWithValue("@ConferenceID", ddlConfList.SelectedValue)
            command.Parameters.AddWithValue("@PersonID", txtPersonLookup.Entries(0).Value)
            adapter.SelectCommand = command

            Dim dataTable As New DataTable
            adapter.Fill(dataTable)
            GridView1.DataSource = dataTable
            GridView1.DataBind()
        End If
    End Sub
End Class