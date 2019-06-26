Public Class ShortCourseBalance
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
                PanelParticipationControl.Visible = False

                CheckUser()
                ltlMessage.Text = "<div class=""alert alert-danger"" role=""alert""><span class=""label label-warning"">Warning</span> DO NOT hit the BACK button to attempt to edit your course selection. You must contact " & ConferenceControl.MeetingPlanner & " at " & ConferenceControl.ConferencePlannerEmail & " to remove or change a course. However, you can add additional courses at any time.</div>"
            Else
                PanelParticipationControl.Visible = True
                PanelBalance.Visible = False
            End If

            'PanelParticipationControl.Visible = False
            ' PanelForm.Visible = False
            'PanelClosed.Visible = True

        End If
    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()

        PanelParticipationControl.Visible = False


        CheckUser()




    End Sub

    Private Sub CheckUser()
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            SqlDataSourceBalance.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceBalance.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            PanelBalance.Visible = True
            PanelPayment.Visible = True
            'Check to see if pay by check is allowed
            If ConferenceControl.PayByCheckAllowed = False Then
                radPayment.Items(0).Selected = True
                radPayment.Items(1).Enabled = False 'Assumes Check is second item in list
            End If
            btnNext.Visible = True

        Else
            PanelParticipationControl.Visible = True
            PanelBalance.Visible = False
        End If
    End Sub

    Protected Sub gvBalance_DataBound(sender As Object, e As EventArgs) Handles gvBalance.DataBound
        Dim SumTotal As Decimal = 0
        If gvBalance.Rows.Count > 0 Then
            SumTotal = gvBalance.DataKeys(0).Value

        End If
        If Not SumTotal > 0 Then
            PanelPayment.Visible = False
        End If
        lblSumTotal.Text = SumTotal
    End Sub

    Protected Sub btnNext_Click(sender As Object, e As EventArgs) Handles btnNext.Click
        Dim PersonID As Integer
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            PersonID = Session("PersonID")



            'Pay or confirmation
            Dim sURL As String

            If PanelPayment.Visible = True Then
                If radPayment.SelectedValue = "Check" Then
                    'Go directly to Confirmation
                    sURL = "~/" & ConferenceControl.ConferenceURLString & "/shortcourse/confirm"
                    'If hdnNewStart.Value = "No" Then
                    SqlDataSourceLedger.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                    SqlDataSourceLedger.InsertParameters("PersonID").DefaultValue = Session("PersonID")
                    SqlDataSourceLedger.InsertParameters("Amount").DefaultValue = 0
                    SqlDataSourceLedger.Insert()
                    'End If
                Else
                    'Go to CC Payment
                    'Set sessions
                    Session("pTransactionAmount") = lblSumTotal.Text
                    Session("pPersonID") = PersonID
                    Session("pConferenceID") = ConferenceControl.ConferenceID
                    Session("pTransactionTimestamp") = Now.ToBinary.ToString()
                    Session("pOrigin") = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/shortcourse/confirm/"
                    Session("pDescription") = "Registration/Short Course Balance Payment: " & ConferenceControl.ConferenceShortName


                    sURL = "~/" & ConferenceControl.ConferenceURLString & "/payment"
                    If InStr(sURL, "https") = 0 Then
                        sURL = sURL.Replace("http", "https")
                    End If
                End If
            Else
                sURL = "~/" & ConferenceControl.ConferenceURLString & "/shortcourse/confirm"
            End If



            Response.Redirect(sURL, True)

        Else
            PanelParticipationControl.Visible = True
            PanelBalance.Visible = False
            PanelPayment.Visible = False
        End If
    End Sub


End Class