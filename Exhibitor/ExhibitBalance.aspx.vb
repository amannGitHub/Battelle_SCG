Public Class ExhibitBalance
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Dim iSteps As Integer = 9
    Dim dv As DataView
    Dim irows As Integer

    Dim sExhibOrSponsor As String = Page.RouteData.Values("type").ToString

    Public Property ExhibitorOrSponsor() As String
        Get
            If (ViewState("ExhibitorOrSponsor") IsNot Nothing) Then
                Return CType(ViewState("ExhibitorOrSponsor"), String)
            Else
                Return "Exhibitor"
            End If
        End Get
        Set(value As String)
            ViewState("ExhibitorOrSponsor") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
                hdnNewStart.Value = "No"

                GetExhibInfo()
                PanelProgress.Visible = False 'Continuing from Booth Reservation
                UpdateProgress(iProgress(6), 6, iSteps, "")
            Else
                PanelParticipationControl.Visible = True
                btnNext.Visible = False
                PanelProgress.Visible = False
                hdnNewStart.Value = "Yes"
                iSteps = 3
                UpdateProgress(iProgress(1), 1, iSteps, "")
                PanelPayment.Visible = False
            End If

        End If

        If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
            ExhibitorOrSponsor = "Sponsor"
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

        UpdateProgress(iProgress(2), 2, 3, "")

    End Sub

    Sub GetExhibInfo()

        SqlDataSourceCompany.SelectParameters("PersonID").DefaultValue = Session("PersonID")
        SqlDataSourceCompany.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID

        dv = CType(SqlDataSourceCompany.Select(DataSourceSelectArguments.Empty), DataView)
        irows = CType(dv.Table.Rows.Count, Integer)
        If irows > 0 Then ' Data found
            lblCompanyName.Text = dv.Table.Rows(0).Item("Exhibitor").ToString
            Session("ExhibitorID") = dv.Table.Rows(0).Item("ExhibitorID").ToString
            Session("BoothID") = dv.Table.Rows(0).Item("BoothID").ToString
            'Change SP if Sponsor to remove Sponsor Registration fees/deposits
            If sExhibOrSponsor = "sponsor" Then
                SqlDataSourceBalance.SelectCommand = "ConferenceLedgerGetTotalSponsorBooth"
            End If

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
            PanelExhibitor.Visible = True
        End If
    End Sub





    Protected Sub UpdateProgress(iProgress As Integer, iStep As Integer, iSteps As Integer, sStatus As String)

        lblProgress.Text = "<div class=""progress-bar" & sStatus & """ role=""progressbar"" aria-valuenow=""" & iProgress & """ aria-valuemin=""0"" aria-valuemax=""100"" style=""width: " & iProgress & "%;"">Step " & iStep & " of " & iSteps & "</div>"
    End Sub

    Function iProgress(iCurrent As Integer) As Integer
        If hdnNewStart.Value = "Yes" Then
            iSteps = 3
        End If
        iProgress = ((iCurrent / iSteps) * 100)
        Return iProgress
    End Function





    Protected Sub btnOrgID_Click(sender As Object, e As EventArgs) Handles btnOrgID.Click
        If txtOrgID.Text.Trim <> "" Then
            SqlDataSourceOrgID.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceOrgID.SelectParameters("OrganizationID").DefaultValue = txtOrgID.Text
            dv = CType(SqlDataSourceOrgID.Select(DataSourceSelectArguments.Empty), DataView)
            irows = CType(dv.Table.Rows.Count, Integer)
            If irows > 0 Then ' Data found
                Dim iExhibID As Integer
                iExhibID = dv.Table.Rows(0).Item("ExhibitorID").ToString
                If Not IsNothing(iExhibID) Then
                    Session("ExhibitorID") = iExhibID
                    GetExhibInfo()
                End If
                Session("BoothID") = dv.Table.Rows(0).Item("BoothID").ToString
            Else
                lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your organization has not reserved a booth. Ensure you have the correct Organization ID.</div>"
                lblAlert.Visible = True
            End If
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

                    If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
                        sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/confirm"
                    Else
                        sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/exhibitor/confirm"
                    End If



                    If hdnNewStart.Value = "No" Then
                        SqlDataSourceLedger.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                        SqlDataSourceLedger.InsertParameters("PersonID").DefaultValue = Session("PersonID")
                        SqlDataSourceLedger.InsertParameters("Amount").DefaultValue = 0
                        SqlDataSourceLedger.Insert()
                    End If
                Else
                    'Go to CC Payment
                    'Set sessions
                    Session("pTransactionAmount") = lblSumTotal.Text
                    Session("pPersonID") = Session("PersonID")
                    Session("pConferenceID") = ConferenceControl.ConferenceID
                    Session("pTransactionTimestamp") = Now.ToBinary.ToString()
                    If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
                        Session("pOrigin") = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/confirm"
                    Else
                        Session("pOrigin") = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/exhibit/exhibitor/confirm"
                    End If

                    Session("pDescription") = "Exhibit Registration: " & ConferenceControl.ConferenceShortName

                    sURL = BattelleGetApplicationURL() & ConferenceControl.ConferenceURLString & "/payment"
                    If InStr(sURL, "https") = 0 Then
                        sURL = sURL.Replace("http", "https")
                    End If
                End If
            Else
                If sExhibOrSponsor = "sponsor" Or sExhibOrSponsor = "sponsors" Then
                    sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/confirm"
                Else
                    sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/exhibitor/confirm"
                End If

            End If



            Response.Redirect(sURL, True)
        Else
            PanelParticipationControl.Visible = True
            btnNext.Visible = False
            PanelProgress.Visible = False
            hdnNewStart.Value = "Yes"
            iSteps = 3
            'UpdateProgress(iProgress(1), 1, iSteps, "")
            PanelPayment.Visible = False
            lblAlert.Visible = True
            lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Your session has timed out. Please try again.</div>"
        End If

    End Sub



    Protected Sub SqlDataSourceItemCount_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceItemCount.Selected

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