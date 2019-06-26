Imports System.Data.SqlClient
Imports System.Data.Common
Public Class SponsorRegistrationBalance
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Dim dv As DataView
    Dim irows As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
                hdnNewStart.Value = "No"

                GetExhibInfo()
            Else
                PanelParticipationControl.Visible = True
                btnNext.Visible = False
                hdnNewStart.Value = "Yes"
                PanelPayment.Visible = False
            End If

        End If


    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin

        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()
        'Response.Cookies("battelle")("PersonID") = PersonID 'removed Session("PersonID") on 8/25/2015
        'This should not be needed since it is set in Participation Login

        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        ParticipationIDLogin.Visible = False
        PanelParticipationControl.Visible = False

        If Session("ExhibitorID") <> "" Then
            PanelBalance.Visible = True
            PanelPayment.Visible = True
            'Check to see if pay by check is allowed
            If ConferenceControl.PayByCheckAllowed = False Then
                radPayment.Items(0).Selected = True
                radPayment.Items(1).Enabled = False 'Assumes Check is second item in list
            End If
            btnNext.Visible = True
        Else
            GetExhibInfo()
        End If


        'If Not IsNothing(PersonData) Then

        'End If


    End Sub

    Sub GetExhibInfo()

        SqlDataSourceCompany.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        'SqlDataSourceCompany.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

        dv = CType(SqlDataSourceCompany.Select(DataSourceSelectArguments.Empty), DataView)
        irows = CType(dv.Table.Rows.Count, Integer)
        If irows > 0 Then ' Data found
            lblCompanyName.Text = dv.Table.Rows(0).Item("Exhibitor").ToString
            Session("ExhibitorID") = dv.Table.Rows(0).Item("ExhibitorID").ToString
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


            '---
            Dim GetDepositFeeCommand As SqlCommand = New SqlCommand("ConferenceSponsorDepositFeeGet")
            GetDepositFeeCommand.Parameters.AddWithValue("PersonID", Session("PersonID"))
            GetDepositFeeCommand.Parameters.AddWithValue("ConferenceID", ConferenceControl.ConferenceID)

            Dim DSReturnData As DataSet

            DSReturnData = BattelleExecuteCommand(GetDepositFeeCommand)
            If DSReturnData.Tables(0).Rows.Count > 0 Then
                Dim iDepositFee = DSReturnData.Tables(0).Rows(0)(0)
                lblDeposit.Text = String.Format("{0:0.00}", iDepositFee)
                If lblDeposit.Text <> "" Then 'There is a deposit
                    lblDeposit.Visible = True
                    lblDepositText.Visible = True
                Else 'This should never really hit
                    radPayment.Items.Item(1).Selected = True
                    radPayment.Items.Remove(radPayment.Items.FindByValue("Deposit"))
                End If
            Else
                ' No data returned, no deposit
                radPayment.Items.Item(1).Selected = True
                radPayment.Items.Item(1).Text = "Credit Card"
                radPayment.Items.Remove(radPayment.Items.Item(0))
                'radPayment.Items.Remove(radPayment.Items.FindByValue("Deposit")) 'Remove deposit option (this method also works)
                'radPayment.Items.Remove(radPayment.Items.FindByValue("Check"))

            End If
            '---

        Else
            PanelExhibitor.Visible = True
        End If
    End Sub

    Protected Sub btnNext_Click(sender As Object, e As EventArgs) Handles btnNext.Click
        'Pay or confirmation
        'First check the Session
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then




            Dim sURL As String
            If PanelPayment.Visible = True Then
                If radPayment.SelectedValue = "Check" Then
                    'Go directly to Confirmation
                    'sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/confirm"
                    'sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/confirm"


                    sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/registration/confirm"




                    If hdnNewStart.Value = "No" Then
                        SqlDataSourceLedger.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceLedger.InsertParameters("PersonID").DefaultValue = Session("PersonID")
                        SqlDataSourceLedger.InsertParameters("Amount").DefaultValue = 0
                        SqlDataSourceLedger.Insert()
                    End If
                Else
                    If radPayment.SelectedValue = "Deposit" Then
                        Session("pTransactionAmount") = lblDeposit.Text
                        Session("pDescription") = "Sponsorship Deposit: " & ConferenceControl.ConferenceShortName
                    Else
                        Session("pTransactionAmount") = lblSumTotal.Text
                        Session("pDescription") = "Sponsorship Payment: " & ConferenceControl.ConferenceShortName
                    End If
                    'Go to CC Payment
                    'Set sessions

                    Session("pPersonID") = Session("PersonID")
                    Session("pConferenceID") = ConferenceControl.ConferenceID
                    Session("pTransactionTimestamp") = Now.ToBinary.ToString()
                    Session("pOrigin") = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/registration/confirm"


                    sURL = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/payment"

                    If InStr(sURL, "https") = 0 Then
                        sURL = sURL.Replace("http", "https")
                    End If
                End If
            Else

                sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/registration/confirm"


            End If



            Response.Redirect(sURL, True)
        Else
            PanelParticipationControl.Visible = True
            btnNext.Visible = False

            hdnNewStart.Value = "Yes"

            'UpdateProgress(iProgress(1), 1, iSteps, "")
            PanelPayment.Visible = False
            lblAlert.Visible = True
            lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your session has timed out. Please try again.</div>"
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

End Class