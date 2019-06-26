Public Class Balance
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then 'removed Session("PersonID") on 8/25/2015
                PanelParticipationControl.Visible = False

                CheckUser()

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
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()

            PanelParticipationControl.Visible = False


            CheckUser()
        Else
            Response.Redirect("~/Error.aspx?error=personlogin&code=1", True)
        End If





    End Sub

    Private Sub CheckUser()
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
        'Dim PersonID As Integer
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            'PersonID = Request.Cookies("battelle")("PersonID") 'removed Session("PersonID") on 8/25/2015



            'Pay or confirmation
            Dim sURL As String
            If PanelPayment.Visible = True Then
                If radPayment.SelectedValue = "Check" Then
                    'Go directly to Confirmation
                    sURL = "~/" & ConferenceControl.ConferenceURLString & "/balance/confirm"
                    'If hdnNewStart.Value = "No" Then
                    SqlDataSourceLedger.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                    SqlDataSourceLedger.InsertParameters("PersonID").DefaultValue = Session("PersonID")  'removed PersonID on 8/25/2015
                    SqlDataSourceLedger.InsertParameters("Amount").DefaultValue = 0
                    SqlDataSourceLedger.Insert()
                    'End If
                Else
                    'Go to CC Payment
                    'Set sessions
                    Session("pTransactionAmount") = lblSumTotal.Text
                    Session("pPersonID") = Session("PersonID")
                    Session("pConferenceID") = ConferenceControl.ConferenceID
                    Session("pTransactionTimestamp") = Now.ToBinary.ToString()
                    Session("pOrigin") = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/balance/confirm"
                    Session("pDescription") = "Registration Balance Payment: " & ConferenceControl.ConferenceShortName

                    sURL = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/payment"
                    If InStr(sURL, "https") = 0 Then
                        sURL = sURL.Replace("http", "https")
                    End If
                End If
            Else
                sURL = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/balance/confirm"
            End If



            Response.Redirect(sURL, True)

        Else
            PanelParticipationControl.Visible = True
            PanelBalance.Visible = False
            PanelPayment.Visible = False
        End If
    End Sub

End Class