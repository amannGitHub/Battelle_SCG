Imports System.IO
Imports System.Data.SqlClient
Imports System.Data.Common
Public Class SponsorRegistration
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        'If Not IsPostBack Then
        Dim dv As DataView
        Dim iRows As Integer

        ConferenceControl = Master.FindControl("ConferenceFromURL")

        SqlDataSourceFees.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        'lblEmail.Text = ConferenceControl.ConferencePlannerEmail

        'All controls must be cloned to be shown on the T&C section

        dv = CType(SqlDataSourceFees.Select(DataSourceSelectArguments.Empty), DataView)
        iRows = CType(dv.Table.Rows.Count, Integer)

        'Set up sponsor list on T&C
        Dim lblSponsorHeader As New Label()
        lblSponsorHeader.Text = "<br /><div class=""panel panel-default""><div class=""panel-heading"">Sponsorship Opportunities Preview <i>(Selection occurs on the next page.)</i></div><div class=""panel-body"">"
        PlaceHolderSponsorTypesTC.Controls.Add(lblSponsorHeader)

        If iRows > 0 Then ' Data found

            Dim sSponsorType As String = ""
            Dim iCourseID As Integer = 0
            Dim iMax As Integer = 0
            Dim bAvailable As Boolean = True
            Dim iSponsorCount As Integer = 0

            For i = 0 To iRows - 1
                Dim rbl As New RadioButton()
                Dim lblCloseDiv As New Label()
                Dim lblCloseDivTC As New Label() 'Add Terms & Conditions duplicates
                Dim lblGroup As New Label()
                Dim lblSponsor As New Label()
                Dim lblSponsorTC As New Label()
                Dim hdnFee As New HiddenField()
                Dim hdnFull As New HiddenField()
                Dim clickDiv As New HtmlGenericControl
                Dim clickDivTC As New HtmlGenericControl
                Dim descriptionDiv As New HtmlGenericControl
                Dim descriptionDivTC As New HtmlGenericControl
                Dim lblMax As New Label()
                'Add note for full-day session 

                If Not IsDBNull(dv.Table.Rows(i).Item("SponsorTypeDetails")) Then
                    clickDiv.Attributes.Add("class", "show col-md-11 col-md-offset-1")
                    clickDiv.InnerHtml = "<p>Show Sponsorship description</p>"
                    clickDiv.Style.Add("margin-top", "1em")
                    clickDiv.Style.Add("color", "#5bb1e4")
                    clickDiv.Style.Add("cursor", "pointer")
                    descriptionDiv.Style.Add("display", "none")
                    descriptionDiv.Attributes.Add("class", "col-md-11 col-md-offset-1")
                    descriptionDiv.InnerHtml = dv.Table.Rows(i).Item("SponsorTypeDetails")

                    'Repeat for T&C
                    clickDivTC.Attributes.Add("class", "show col-md-11 col-md-offset-1")
                    clickDivTC.InnerHtml = "<p>Show Sponsorship description</p>"
                    clickDivTC.Style.Add("margin-top", "1em")
                    clickDivTC.Style.Add("color", "#5bb1e4")
                    clickDivTC.Style.Add("cursor", "pointer")
                    descriptionDivTC.Style.Add("display", "none")
                    descriptionDivTC.Attributes.Add("class", "col-md-11 col-md-offset-1")
                    descriptionDivTC.InnerHtml = dv.Table.Rows(i).Item("SponsorTypeDetails")
                End If

                lblCloseDiv.Text = "</div></div>"

                iCourseID = dv.Table.Rows(i).Item("SponsorTypeID").ToString
                iMax = dv.Table.Rows(i).Item("SponsorLimit").ToString
                iSponsorCount = dv.Table.Rows(i).Item("SponsorCount").ToString
                Dim sSponsorText As String = "Sponsors"
                Dim sShowFull As String = ""
                Dim sLabelColor As String = "black"
                Dim sLimitedText As String = ""

                'Check to see if limit and if full
                If iMax <> 0 Then 'there is a limit
                    If iMax = 1 Then sSponsorText = "Sponsor"

                    If iMax > iSponsorCount Then 'still room
                        bAvailable = True
                    Else 'All full
                        bAvailable = False
                        sShowFull = " - <i class=""text-danger"">Limit Reached</i>"
                        sLabelColor = "gray"
                    End If
                    sLimitedText = "<b><i>(Limited to " & iMax & " " & sSponsorText & sShowFull & ")</b></i><br /><br />"
                Else 'no limit
                    bAvailable = True
                End If

                Dim iFee As Integer = 0
                Dim sFee As String = ""
                iFee = dv.Table.Rows(i).Item("SponsorFee").ToString()
                sFee = String.Format("{0:c}", iFee)


                sSponsorType = dv.Table.Rows(i).Item("SponsorType").ToString
                lblSponsor.Text = "<div Class=""row""><div Class=""col-md-12"">" &
                                        "<h3>" & sSponsorType & "<small> US " &
                                        sFee & "</small></h3>"

                lblSponsor.Text += sLimitedText


                lblSponsor.Text += "</div></div><div class=""row""><div class=""col-md-12"">"
                PlaceHolder1.Controls.Add(lblSponsor)
                lblSponsorTC.Text = lblSponsor.Text
                PlaceHolderSponsorTypesTC.Controls.Add(lblSponsorTC)

                'AddHandler rbl.CheckedChanged, AddressOf Me.rbl_Checked
                With rbl
                    .ID = "rbl" & i
                    .GroupName = "SponsorTypes"
                    .Text = sSponsorType
                    .LabelAttributes.CssStyle.Add("display", "block")
                    .LabelAttributes.CssStyle.Add("margin-left", "25px")
                    .LabelAttributes.CssStyle.Add("color", sLabelColor)
                    .InputAttributes.CssStyle.Add("float", "left")
                    .InputAttributes.CssStyle.Add("margin-right", "5px")
                    .InputAttributes.Add("value", iCourseID)
                    .InputAttributes.Add("fee", dv.Table.Rows(i).Item("SponsorFee").ToString)
                    .InputAttributes.Add("feed", dv.Table.Rows(i).Item("FeeTypeID").ToString)
                    .AutoPostBack = False
                    .Enabled = bAvailable
                End With
                PlaceHolder1.Controls.Add(lblCloseDiv)
                lblCloseDivTC.Text = lblCloseDiv.Text
                PlaceHolderSponsorTypesTC.Controls.Add(lblCloseDivTC)
                'lblPresenter.Text = "</div></div><div class=""row""><div class=""col-md-11 col-md-offset-1"">" &
                '    dv.Table.Rows(i).Item("CoursePresenter").ToString & "</div></div>"
                PlaceHolder1.Controls.Add(rbl)
                'PlaceHolder1.Controls.Add(hdnFee)
                'PlaceHolder1.Controls.Add(hdnFull)

                PlaceHolder1.Controls.Add(clickDiv)
                PlaceHolderSponsorTypesTC.Controls.Add(clickDivTC)
                PlaceHolder1.Controls.Add(descriptionDiv)
                PlaceHolderSponsorTypesTC.Controls.Add(descriptionDivTC)

            Next
            hdnCtrls.Value = iRows
        End If
        Dim lblSponsorFooter As New Label()
        lblSponsorFooter.Text = "</div></div><br />"
        PlaceHolderSponsorTypesTC.Controls.Add(lblSponsorFooter)
        'End If


    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            '    If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            lnkSponsorshipOpportunities.NavigateUrl = "~/" & Page.RouteData.Values("conference") & "/exhibit/sponsor/registration/opportunities"
            PanelInstructions.Visible = True
            '        PanelTerms.Visible = True
            '        PanelForm.Visible = False
            '        CheckUser()

        Else
            PanelInstructions.Visible = False
            '        PanelTerms.Visible = False
            '        PanelForm.Visible = False
            '    End If
        End If


    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()

        PanelParticipationControl.Visible = False

        Dim PersonData = BattellePersonGetAsDataRow(PersonID)
        If Not IsNothing(PersonData) Then
            Dim hdnVal As New HiddenField
            hdnVal = CType(CompanyInfo.FindControl("hdnVal"), HiddenField)
            If Not hdnVal Is Nothing Then
                hdnVal.Value = PersonID
            End If
            Dim hdnCom As New HiddenField
            hdnCom = CType(CompanyInfo.FindControl("hdnCom"), HiddenField)
            If Not hdnCom Is Nothing Then
                hdnCom.Value = PersonData("Employer")
            End If
        End If
        PanelExhibitorInfo.Visible = True

        Session("PersonID") = PersonID

    End Sub

    Protected Sub CompanyInfo_Finished() Handles CompanyInfo.FinishedLogin

        If Not hdnVal Is Nothing Then
            hdnVal.Value = CompanyInfo.ExhibitorID
        End If
        Session("ExhibitorID") = CompanyInfo.ExhibitorID

        PanelTerms.Visible = True
        PanelExhibitorInfo.Visible = False
        PanelInstructions.Visible = False



    End Sub

    Protected Sub btnAgree_Click(sender As Object, e As EventArgs) Handles btnAgree.Click


        Dim bPass As Boolean = True
        If chkTerms.Checked = False Then
            Me.lblTermsMessage.Text = "<div class=""alert alert-danger"" role=""alert"">You must indicate that you have read and agree to the Terms and Conditions.</div>"
            Me.lblTermsMessage.Visible = True
            bPass = False
        Else
            Me.lblTermsMessage.Visible = False
        End If

        If bPass = True Then
            PanelTerms.Visible = False
            PanelForm.Visible = True
            Page.Title = "Sponsorship Selection"
            ltlConferenceType.Text = ConferenceControl.ConferenceType
            lnkConferenceEmail.Text = ConferenceControl.ConferenceSubjectEmail
            lnkConferenceEmail.NavigateUrl = "mailto:" & ConferenceControl.ConferenceSubjectEmail
        End If

    End Sub

    Protected Sub CheckUser()
        Dim PersonID As Integer

        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            PersonID = Session("PersonID")

            PanelParticipationControl.Visible = False
            PanelForm.Visible = True
        Else
            PanelParticipationControl.Visible = True
            PanelForm.Visible = False
        End If


    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        Dim PersonID As Integer
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then

            PersonID = Session("PersonID")
            Dim bSelected As Boolean = False



            ' PersonID = Request.Cookies("battelle")("personid")
            If hdnCtrls.Value <> 0 Then
                For i = 0 To hdnCtrls.Value - 1
                    'SCGTODO - add controls to stop full day and half day selections
                    'loop through each radio button

                    Dim sRBL As String
                    sRBL = "rbl" & i
                    Dim rbl As New RadioButton
                    rbl = CType(PlaceHolder1.FindControl(sRBL), RadioButton)

                    If rbl.Enabled = True Then
                        If rbl.Checked = True Then 'Submit to databse
                            SqlDataSourceReg.InsertParameters("PersonID").DefaultValue = PersonID
                            SqlDataSourceReg.InsertParameters("ExhibitorID").DefaultValue = CompanyInfo.ExhibitorID
                            SqlDataSourceReg.InsertParameters("SponsorTypeID").DefaultValue = rbl.InputAttributes("value").ToString
                            SqlDataSourceReg.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                            SqlDataSourceReg.InsertParameters("FeeTypeID").DefaultValue = rbl.InputAttributes("feed").ToString
                            SqlDataSourceReg.InsertParameters("Amount").DefaultValue = rbl.InputAttributes("fee").ToString
                            SqlDataSourceReg.InsertParameters("CompanyDescription").DefaultValue = txtCompanyDescription.Text


                            SqlDataSourceReg.Insert()

                            If hdnFail.Value = 0 Then
                                If FileUploadAbstract.HasFile() = True Then
                                    Dim AbstractFile As IO.Stream = FileUploadAbstract.PostedFile.InputStream
                                    Dim FileLength As Integer = FileUploadAbstract.PostedFile.ContentLength
                                    Dim FileName As String = FileUploadAbstract.FileName 'FileUploadAbstract.PostedFile.FileName

                                    Dim FileExt As String = Path.GetExtension(FileUploadAbstract.PostedFile.FileName)
                                    Dim FileContentType As String = FileUploadAbstract.PostedFile.ContentType
                                    Dim FileData(FileLength - 1) As Byte
                                    AbstractFile.Read(FileData, 0, FileLength)

                                    'clean up querystring issues in name when downloading later
                                    FileName = Replace(FileName, " ", "_")
                                    FileName = Replace(FileName, "'", "_")
                                    FileName = Replace(FileName, "&", "_")

                                    Dim UploadAbstractCommand As SqlCommand = New SqlCommand("SponsorFileInsert")
                                    UploadAbstractCommand.Parameters.AddWithValue("ExhibitorID", CompanyInfo.ExhibitorID)
                                    UploadAbstractCommand.Parameters.AddWithValue("ConferenceID", ConferenceControl.ConferenceID)
                                    UploadAbstractCommand.Parameters.AddWithValue("UploadedFile", FileData)
                                    UploadAbstractCommand.Parameters.AddWithValue("FileSize", FileLength)
                                    UploadAbstractCommand.Parameters.AddWithValue("FileName", FileName)
                                    UploadAbstractCommand.Parameters.AddWithValue("ContentType", FileContentType)

                                    BattelleExecuteCommand(UploadAbstractCommand)
                                End If
                                bSelected = True
                            ElseIf hdnFail.Value = 1 Then
                                rbl.Checked = False
                            End If
                        End If
                    Else
                        If rbl.Checked = True Then
                            hdnFail.Value = 1
                            rbl.Checked = False
                        End If
                    End If





                Next

                Dim sURL As String
                Select Case hdnFail.Value
                    Case 0 'No fail, woo hoo, keep going
                        sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/registration/balance"
                        Response.Redirect(sURL, True)
                    Case 1 'Limit reached between selection and submission
                        Me.lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Unfortunately another company has chosen that sponsorship and the limit has been reached.</div>"
                        Me.lblAlert.Visible = True
                    Case 2 'Sponsor selection already occurred (send to payment or confirmation? Let's try confirmation)
                        sURL = "~/" & ConferenceControl.ConferenceURLString & "/exhibit/sponsor/registration/confirm"
                        Response.Redirect(sURL, True)
                    Case Else 'No selection made
                        Me.lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">You must select a Sponsorship type.</div>"
                        Me.lblAlert.Visible = True
                End Select

            End If
        Else
            PanelParticipationControl.Visible = True
            PanelForm.Visible = False
        End If
    End Sub

    'Private Sub rbl_Checked(sender As Object, e As EventArgs)
    '    'SCGTODO Consider making this a client side script
    '    Dim rbl As RadioButton = TryCast(sender, RadioButton)
    '    'Dim sCourseDate As String = rbl.InputAttributes("coursedate").ToString

    '    For i = 0 To hdnCtrls.Value - 1

    '        Dim rblCheck As RadioButton
    '        Dim sRBL As String
    '        sRBL = "rbl" & i
    '        rblCheck = CType(PlaceHolder1.FindControl(sRBL), RadioButton)
    '        If rblCheck.ID <> rbl.ID Then 'Make sure we don't clear the RadioButton we clicked
    '            If rblCheck.InputAttributes("coursedate").ToString = sCourseDate Then
    '                If rblCheck.InputAttributes("fullday").ToString <> rbl.InputAttributes("fullday").ToString Then
    '                    rblCheck.Checked = False
    '                End If

    '            End If
    '        End If

    '    Next
    '    ltlMessage.Visible = True
    '    ltlMessage.Text = "<div class=""alert alert-danger"" role=""alert""><span class=""label label-warning"">Warning</span> Once you hit the Submit button DO NOT hit the BACK button. You must contact " & ConferenceControl.MeetingPlanner & " at " & ConferenceControl.ConferencePlannerEmail & " to remove or change a course. However, you can add additional courses at any time.</div>"

    'End Sub

    Protected Sub SQLDataSourceReserve_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceReg.Inserted
        Dim command As DbCommand
        command = e.Command
        Dim iFail As Integer

        iFail = command.Parameters("@Fail").Value
        hdnFail.Value = iFail




    End Sub


End Class