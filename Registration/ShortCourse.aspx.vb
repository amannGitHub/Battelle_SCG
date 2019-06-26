Imports System.Data.Common
Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports System.Drawing
Public Class ShortCourse
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim dv As DataView
        Dim iRows As Integer

        ConferenceControl = Master.FindControl("ConferenceFromURL")
        Dim lblLunchNote As New Label()
        If ConferenceControl.ConferenceID = 3 Then
            lblLunchNote.Text = "<small>(1-hour break at noon for lunch on own)</small><br/><br/>"
        End If
        SqlDataSourceFees.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        lblEmail.Text = ConferenceControl.ConferencePlannerEmail


        dv = CType(SqlDataSourceFees.Select(DataSourceSelectArguments.Empty), DataView)
        iRows = CType(dv.Table.Rows.Count, Integer)

        If iRows > 0 Then ' Data found

            Dim sGroupName As String = ""
            Dim iCourseID As Integer = 0


            For i = 0 To iRows - 1
                Dim rbl As New RadioButton()
                Dim lblGroup As New Label()
                Dim lblPresenter As New Label()

                'Add for fee change for promo code
                Dim lblFee As New Label()
                Dim feeSpan As New HtmlGenericControl

                Dim hdnFee As New HiddenField()
                Dim hdnFull As New HiddenField()
                Dim clickDiv As New HtmlGenericControl
                Dim descriptionDiv As New HtmlGenericControl

                Dim lblCourseDetailsBlock As New Label()
                Dim lblAltCourseDescriptionBlock As New Label()
                'Add note for full-day session 

                'Added lblCourseDetailsBlock on 10/3/2018 to get additional short course details
                lblCourseDetailsBlock.Text = "<strong>Course Length:</strong> " & dv.Table.Rows(i).Item("CourseLength") & " hours<br>"
                'Hiding these unless Battelle specifically decides to show them. Sediments added the information in the Agenda.
                'If dv.Table.Rows(i).Item("LaptopsRequired") = True Then
                '    lblCourseDetailsBlock.Text = lblCourseDetailsBlock.Text & "Laptops <strong><i>are required</i></strong>.<br>"
                'Else
                '    lblCourseDetailsBlock.Text = lblCourseDetailsBlock.Text & "Laptops are <strong><i>not</i> required</strong>.<br>"
                'End If


                'If dv.Table.Rows(i).Item("SpecialSoftwareRequired") = True Then
                '    lblCourseDetailsBlock.Text = lblCourseDetailsBlock.Text & "Special software <strong><i>is required</i></strong>.<br>"
                '    lblCourseDetailsBlock.Text = lblCourseDetailsBlock.Text & "<strong>Software:</strong> " & dv.Table.Rows(i).Item("Software") & "<br>"
                'Else
                '    lblCourseDetailsBlock.Text = lblCourseDetailsBlock.Text & "Special software is <strong><i>not</i> required</strong.><br>"
                'End If
                'lblCourseDetailsBlock.Text = lblCourseDetailsBlock.Text & "<strong>Internet Access Required:</strong> " & dv.Table.Rows(i).Item("InternetAccessRequired") & "<br>"
                'lblCourseDetailsBlock.Text = lblCourseDetailsBlock.Text & "<strong>Supplemental Materials Provided:</strong> " & dv.Table.Rows(i).Item("SupplementalMaterialsProvided") & "<br>"
                'lblCourseDetailsBlock.Text = lblCourseDetailsBlock.Text & "<strong>Supplemental Materials List:</strong> " & dv.Table.Rows(i).Item("SupplementalMaterialsList") & "<br>"
                lblCourseDetailsBlock.Text = lblCourseDetailsBlock.Text & "<br>"

                If Not IsDBNull(dv.Table.Rows(i).Item("CourseDescription")) Or Not IsDBNull(dv.Table.Rows(i).Item("CourseObjective")) Then
                    clickDiv.Attributes.Add("class", "show col-md-11 col-md-offset-1")
                    clickDiv.InnerHtml = "<p>Show Course description</p>"
                    clickDiv.Style.Add("margin-top", "1em")
                    clickDiv.Style.Add("color", "#5bb1e4")
                    clickDiv.Style.Add("cursor", "pointer")
                    descriptionDiv.Style.Add("display", "none")
                    descriptionDiv.Attributes.Add("class", "col-md-11 col-md-offset-1")

                    lblAltCourseDescriptionBlock.Style.Add("display", "none")
                    lblAltCourseDescriptionBlock.Attributes.Add("class", "col-md-11 col-md-offset-1")


                    If Not IsDBNull(dv.Table.Rows(i).Item("CourseDescription")) Then
                        descriptionDiv.InnerHtml = lblCourseDetailsBlock.Text & dv.Table.Rows(i).Item("CourseDescription")
                    ElseIf Not IsDBNull(dv.Table.Rows(i).Item("CourseObjective")) Then
                        lblAltCourseDescriptionBlock.Text = lblCourseDetailsBlock.Text & "<strong>Objective: </strong> " & dv.Table.Rows(i).Item("CourseObjective") & "</br></br>"
                        lblAltCourseDescriptionBlock.Text = lblAltCourseDescriptionBlock.Text & "<strong>Overview:</strong> " & dv.Table.Rows(i).Item("CourseOverview") & "</br></br>"
                        lblAltCourseDescriptionBlock.Text = lblAltCourseDescriptionBlock.Text & "<strong>Agenda:</strong> " & dv.Table.Rows(i).Item("DraftAgenda") & "</br></br>"
                    End If

                End If


                iCourseID = dv.Table.Rows(i).Item("CourseID").ToString


                If sGroupName <> dv.Table.Rows(i).Item("GroupName").ToString Then
                    sGroupName = dv.Table.Rows(i).Item("GroupName").ToString
                    lblGroup.Text = "<div Class=""row""><div Class=""col-md-12"">" &
                                    "<h3>" & sGroupName &
                                    "<!--<small> US $" & dv.Table.Rows(i).Item("CourseFee").ToString & "</small>--></h3>" & "</div></div><div class=""row""><div class=""col-md-12"">"
                    PlaceHolder1.Controls.Add(lblGroup)
                Else
                    lblGroup.Text = "<div class=""row""><div class=""col-md-12"">"
                    PlaceHolder1.Controls.Add(lblGroup)
                End If

                If i = 0 And ConferenceControl.ConferenceID = 3 Then   'Add below header for first session
                    PlaceHolder1.Controls.Add(lblLunchNote)
                End If

                AddHandler rbl.CheckedChanged, AddressOf Me.rbl_Checked
                With rbl
                    .ID = "rbl" & i
                    .GroupName = sGroupName
                    .Text = dv.Table.Rows(i).Item("CourseName").ToString
                    .LabelAttributes.CssStyle.Add("display", "block")
                    .LabelAttributes.CssStyle.Add("margin-left", "25px")
                    .InputAttributes.CssStyle.Add("float", "left")
                    .InputAttributes.CssStyle.Add("margin-right", "5px")
                    .InputAttributes.Add("value", iCourseID)
                    .InputAttributes.Add("fee", dv.Table.Rows(i).Item("CourseFee").ToString)
                    .InputAttributes.Add("fullday", dv.Table.Rows(i).Item("FullDay").ToString)
                    .InputAttributes.Add("coursedate", dv.Table.Rows(i).Item("CourseDate").ToString)
                    .InputAttributes.Add("feed", dv.Table.Rows(i).Item("FeeTypeID").ToString)
                    .AutoPostBack = True
                End With

                With lblFee
                    .ID = "lblFee" & i
                    .Text = "</div></div><div Class=""row""><div Class=""col-md-11 col-md-offset-1"">" & "<span runat='server' style='color:grey;' ID=""fee" & i & """>" & "Course Fee: US $" & dv.Table.Rows(i).Item("CourseFee").ToString & "</span></div></div>"
                End With


                lblPresenter.Text = "</div></div><div class=""row""><div class=""col-md-11 col-md-offset-1"">" &
                dv.Table.Rows(i).Item("CoursePresenter").ToString & "<br>"
                PlaceHolder1.Controls.Add(rbl)
                PlaceHolder1.Controls.Add(lblPresenter)
                PlaceHolder1.Controls.Add(lblFee)
                PlaceHolder1.Controls.Add(hdnFee)
                PlaceHolder1.Controls.Add(hdnFull)
                PlaceHolder1.Controls.Add(clickDiv)
                If Not IsDBNull(dv.Table.Rows(i).Item("CourseDescription")) Then
                    PlaceHolder1.Controls.Add(descriptionDiv)
                ElseIf Not IsDBNull(dv.Table.Rows(i).Item("CourseObjective")) Then
                    PlaceHolder1.Controls.Add(lblAltCourseDescriptionBlock)
                End If
            Next
            hdnCtrls.Value = iRows
        End If
    End Sub

    Private Sub rbl_Checked(sender As Object, e As EventArgs)
        'SCGTODO Consider making this a client side script
        Dim rbl As RadioButton = TryCast(sender, RadioButton)
        Dim sCourseDate As String = rbl.InputAttributes("coursedate").ToString

        For i = 0 To hdnCtrls.Value - 1

            Dim rblCheck As RadioButton
            Dim sRBL As String
            sRBL = "rbl" & i
            rblCheck = CType(PlaceHolder1.FindControl(sRBL), RadioButton)
            If rblCheck IsNot Nothing Then 'This is here in case a course fills up while user registers and it becomes removed from the list
                If rblCheck.ID <> rbl.ID Then 'Make sure we don't clear the RadioButton we clicked
                    If rblCheck.InputAttributes("coursedate").ToString = sCourseDate Then
                        If rblCheck.InputAttributes("fullday").ToString <> rbl.InputAttributes("fullday").ToString Then
                            rblCheck.Checked = False
                        End If

                    End If
                End If
            Else
                'A course was removed after page load
                lblAlert.Text = "We are sorry, a previously listed course is no longer available and has been removed."
                lblAlert.Visible = True
                hdnCtrls.Value = hdnCtrls.Value - 1
            End If


        Next
        ltlMessage.Visible = True
        ltlMessage.Text = "<div class=""alert alert-danger"" role=""alert""><span class=""label label-warning"">Warning</span> Once you hit the Submit button DO NOT hit the BACK button. You must contact " & ConferenceControl.MeetingPlanner & " at " & ConferenceControl.ConferencePlannerEmail & " to remove or change a course. However, you can add additional courses at any time.</div>"

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ConferenceControl = Master.FindControl("ConferenceFromURL")
        If Not IsPostBack Then
            'Check to see if Short Courses open or keep open if admin logged in
            If (Now() > ConferenceControl.ShortCourseOpenDate And Now() < ConferenceControl.ShortCourseClosedDate) Or (Context.User.Identity.GetUserName() = "SCGadmin") Then


                If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
                    PanelParticipationControl.Visible = False
                    PlaceHolderPromoCodeValidation.Visible = True
                    PanelForm.Visible = True
                    CheckUser()
                Else
                    PanelParticipationControl.Visible = True
                    PanelForm.Visible = False
                End If


            Else
                PanelParticipationControl.Visible = False
                PanelForm.Visible = False
                PanelClosed.Visible = True
                If Now() < ConferenceControl.ShortCourseOpenDate Then 'Hasnt opened yet
                    Dim dOpen As Date = ConferenceControl.ShortCourseOpenDate

                    lblClosed.Text = "Coming in " & dOpen.ToString("MMMM yyyy", CultureInfo.CurrentCulture)
                End If
                If Now() > ConferenceControl.ShortCourseClosedDate Then 'Closed
                    lblClosed.Text = "Short Course online registration is now closed. Walk in registration is accepted. Please go the the conference registration desk."
                End If
            End If

        End If

        'check if user is government employee, if so then show promo code button
        EmailPromoCode()

    End Sub

    Protected Sub ParticipationIDLogin_FinishedLogin() Handles ParticipationIDLogin.FinishedLogin
        Dim PersonID As Integer = ParticipationIDLogin.UserPersonID()

        PanelParticipationControl.Visible = False
        PanelForm.Visible = True
        CheckUser()
        EmailPromoCode()

    End Sub


    Protected Sub btnPromoCodeEmail_Click(sender As Object, e As EventArgs)

        Dim promoView As DataView
        Dim promoRows As Integer
        Dim pCourseID As Integer = 0
        Dim iGovtEmployee As String = "No"
        Dim govtEmailAddress As String
        Dim scPromoCode As String

        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            ConferenceControl = Master.FindControl("ConferenceFromURL")
            txtPromoCodeID.Text = DBNull.Value.ToString()

            SqlDataSourcePromoValidate.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourcePromoValidate.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourcePromoValidate.SelectParameters("ShortCoursePromoCode_IN").DefaultValue = "Empty"
            SqlDataSourcePromoValidate.SelectParameters("CourseID").DefaultValue = pCourseID

            promoView = CType(SqlDataSourcePromoValidate.Select(DataSourceSelectArguments.Empty), DataView)
            promoRows = CType(promoView.Table.Rows.Count, Integer)

            If promoRows > 0 Then
                iGovtEmployee = promoView.Table.Rows(0)("GovtEmployee")
                scPromoCode = promoView.Table.Rows(0)("PromoCode")

                Dim PersonData = BattellePersonGetAsDataRow(Session("PersonID"))

                If iGovtEmployee = "Yes" Then
                    lblEmailSent.Text = "<div class=""alert alert-success"" role=""alert""><p>Government employee verified, sending promo code to " + PersonData("Email") + ".</p></div>"

                    govtEmailAddress = PersonData("Email")


                    Dim ShortCoursePromoSummaryHTML As String = String.Empty

                    ShortCoursePromoSummaryHTML += "<p align=""left"">" + PersonData("FirstName") + " " + PersonData("LastName") + "</p>"
                    ShortCoursePromoSummaryHTML += "<p align=""left"">Please use promo code <strong>"
                    ShortCoursePromoSummaryHTML += scPromoCode
                    ShortCoursePromoSummaryHTML += "</strong> for great deals during your short course registration.</p>"

                    Dim PromoCodeEmail As DataRow = BattelleEmailGetByNameAsDataRow(ConferenceControl.ConferenceURLString + "_shortcoursepromocode_confirmation")
                    Dim PromoCodeEmailHTML As String
                    If PromoCodeEmail Is Nothing Then
                        PromoCodeEmail = BattelleEmailGetByNameAsDataRow("shortcoursepromocode_confirmation")
                    End If
                    PromoCodeEmailHTML = PromoCodeEmail("EmailHTML")
                    PromoCodeEmailHTML = PromoCodeEmailHTML.Replace("{[conference_banner_url]}", "http://www.scgcorp.com/Battelle/images/emailbanners/" + ConferenceControl.ConferenceURLString + ".jpg")
                    PromoCodeEmailHTML = PromoCodeEmailHTML.Replace("{[conference_email]}", ConferenceControl.ConferenceSubjectEmail)
                    PromoCodeEmailHTML = PromoCodeEmailHTML.Replace("{[conference_meeting_planner_email]}", ConferenceControl.ConferencePlannerEmail)
                    PromoCodeEmailHTML = PromoCodeEmailHTML.Replace("{[conference_short_name]}", ConferenceControl.ConferenceShortName)
                    PromoCodeEmailHTML = PromoCodeEmailHTML.Replace("{[conference_date_span_text]}", ConferenceControl.ConferenceDateSpanText)
                    PromoCodeEmailHTML = PromoCodeEmailHTML.Replace("{[conference_location]}", ConferenceControl.ConferenceLocation)
                    PromoCodeEmailHTML = PromoCodeEmailHTML.Replace("{[conference_final_placement]}", ConferenceControl.ConferenceFinalPlacement)
                    PromoCodeEmailHTML = PromoCodeEmailHTML.Replace("{[participation_content]}", ShortCoursePromoSummaryHTML)

                    BattelleSendMail(PromoCodeEmailHTML, govtEmailAddress, "Short Course Promo Code", Net.Mail.MailPriority.Normal, ConferenceControl.ConferenceShortName, ConferenceControl.ConferencePlannerEmail)

                Else
                    lblEmailSent.Text = "<div class=""alert alert-warning"" role=""alert""><p>No promo codes available at this time.</p></div>"
                End If

            End If

        Else
            lblEmailSent.Text = "<div class=""alert alert-warning"" role=""alert""><p>No promo codes available at this time.</p></div>"
        End If


    End Sub


    Protected Sub EmailPromoCode()
        Dim promoView As DataView
        Dim promoRows As Integer
        Dim pCourseID As Integer = 0
        Dim iGovtEmployee As String = "No"

        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            ConferenceControl = Master.FindControl("ConferenceFromURL")
            txtPromoCodeID.Text = DBNull.Value.ToString()

            SqlDataSourcePromoValidate.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourcePromoValidate.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourcePromoValidate.SelectParameters("ShortCoursePromoCode_IN").DefaultValue = "Empty"
            SqlDataSourcePromoValidate.SelectParameters("CourseID").DefaultValue = pCourseID

            promoView = CType(SqlDataSourcePromoValidate.Select(DataSourceSelectArguments.Empty), DataView)
            promoRows = CType(promoView.Table.Rows.Count, Integer)

            If promoRows > 0 Then
                iGovtEmployee = promoView.Table.Rows(0)("GovtEmployee")

                If iGovtEmployee = "Yes" Then
                    PanelPromoEmail.Visible = True
                Else
                    PanelPromoEmail.Visible = False
                End If
            End If

        End If


    End Sub




    Protected Sub btnPromoCodeValidate_Click(sender As Object, e As EventArgs)

        Dim pv As DataView
        Dim promoView As DataView
        Dim promoRows As Integer
        Dim pRows As Integer
        Dim pCourseID As Integer = 0
        Dim iValid As Integer = 0
        Dim iValidFee As Integer = 0


        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            ConferenceControl = Master.FindControl("ConferenceFromURL")

            SqlDataSourcePromoValidate.SelectParameters("PersonID").DefaultValue = Session("PersonID")
            SqlDataSourcePromoValidate.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            If txtPromoCodeID.Text = "" Then
                SqlDataSourcePromoValidate.SelectParameters("ShortCoursePromoCode_IN").DefaultValue = "Empty"
            Else
                SqlDataSourcePromoValidate.SelectParameters("ShortCoursePromoCode_IN").DefaultValue = txtPromoCodeID.Text
            End If

            pv = CType(SqlDataSourceFees.Select(DataSourceSelectArguments.Empty), DataView)
            pRows = CType(pv.Table.Rows.Count, Integer)
            If pRows > 0 Then ' Data found
                For i = 0 To pRows - 1
                    pCourseID = pv.Table.Rows(i).Item("CourseID")
                    SqlDataSourcePromoValidate.SelectParameters("CourseID").DefaultValue = pCourseID

                    promoView = CType(SqlDataSourcePromoValidate.Select(DataSourceSelectArguments.Empty), DataView)
                    promoRows = CType(promoView.Table.Rows.Count, Integer)

                    If promoRows > 0 Then ' Data found
                        iValid = promoView.Table.Rows(0)("PromoValid")
                        If iValid = 1 Then 'Promo code valid, exit loop                         
                            Exit For
                        End If

                    End If

                Next
            End If

            If iValid = 1 Then
                lblPromoDiv.Text = "<div class=""form-group has-success has-feedback"">"
                'lblFee.Text = 0
                lblPromoCodeValid.Visible = True
                lblPromoCodeValid.Text = "Promo code validated!"
                lblPromoCodeValid.CssClass = "text-success"
                hdnPromoCode.Value = txtPromoCodeID.Text
                hdnPromoValid.Value = "True"
                btnPromoCodeValidate.Enabled = False
                txtPromoCodeID.ReadOnly = True
                lblEmailSent.Text = ""
                lblEmailSent.Visible = False
            Else
                lblPromoDiv.Text = "<div class=""form-group has-error has-feedback"">"
                lblPromoCodeValid.Visible = True
                hdnPromoCode.Value = ""
                hdnPromoValid.Value = "False"
                lblPromoCodeValid.Text = "Promo code not valid."
                lblPromoCodeValid.CssClass = "text-danger"
            End If


            'course fee label
            Dim rbl As RadioButton = TryCast(sender, RadioButton)
            Dim promoViewFee As DataView
            Dim promoRowsFee As Integer

            For i = 0 To hdnCtrls.Value - 1

                Dim span = New HtmlGenericControl("span")
                Dim spanID As String
                spanID = "fee" & i

                Dim lblFee As Label
                Dim slblFee As String
                slblFee = "lblFee" & i
                lblFee = CType(Page.FindControl("slblFee"), Label)

                Dim rblCheck As RadioButton
                Dim sRBL As String
                sRBL = "rbl" & i
                rblCheck = CType(PlaceHolder1.FindControl(sRBL), RadioButton)
                If rblCheck IsNot Nothing Then

                    SqlDataSourcePromoValidate.SelectParameters("CourseID").DefaultValue = Int32.Parse(rblCheck.InputAttributes("Value"))
                    promoViewFee = CType(SqlDataSourcePromoValidate.Select(DataSourceSelectArguments.Empty), DataView)
                    promoRowsFee = CType(promoViewFee.Table.Rows.Count, Integer)

                    If promoRowsFee > 0 Then ' Data found
                        iValidFee = promoViewFee.Table.Rows(0)("PromoValid")
                        If iValidFee = 1 Then 'Promo code valid, exit loop   

                            Dim feePromo As Label = CType(PlaceHolder1.FindControl(slblFee), Label)
                            feePromo.Text = "</div></div><div Class=""row""><div Class=""col-md-11 col-md-offset-1"">" & "<span runat='server' style='color:green' ID=""fee" & i & """>" & "Course Fee: US $0 - Waived State/Fed. Govt.</span></div></div>"

                        End If

                    End If

                End If
            Next
        End If

    End Sub


    Private Function FindControlRecursive(ByVal root As Control, ByVal id As String) As Control
        If root.ID = id Then
            Return root
        End If
        Dim c As Control
        For Each c In root.Controls
            Dim t As Control = FindControlRecursive(c, id)
            If Not t Is Nothing Then
                Return t
            End If
        Next
        Return Nothing
    End Function





    Protected Sub CheckUser()
        Dim PersonID As Integer

        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then
            PersonID = Session("PersonID")

            'First check to see if the person is registered for short courses
            SqlDataSourceReg.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
            SqlDataSourceReg.SelectParameters("PersonID").DefaultValue = PersonID
            Dim dv As DataView
            Dim iRows As Integer

            dv = CType(SqlDataSourceReg.Select(DataSourceSelectArguments.Empty), DataView)
            iRows = CType(dv.Table.Rows.Count, Integer)

            If iRows > 0 Then ' Data found - person is registered
                Dim sURL As String
                sURL = "~/" & ConferenceControl.ConferenceURLString & "/shortcourse/confirm"

                Dim iCourseID As Integer
                Dim sGroup As String
                Dim sFull As String
                ' Response.Redirect(sURL, True)
                If hdnCtrls.Value <> 0 Then
                    For j = 0 To iRows - 1 'loop through dataset
                        iCourseID = dv.Table.Rows(j).Item("CourseID").ToString
                        sGroup = dv.Table.Rows(j).Item("GroupName").ToString
                        sFull = dv.Table.Rows(j).Item("FullDay").ToString
                        For i = 0 To hdnCtrls.Value - 1 'loop through controls to find selected
                            Dim sRBL As String
                            sRBL = "rbl" & i
                            Dim rbl As New RadioButton
                            rbl = CType(PlaceHolder1.FindControl(sRBL), RadioButton)
                            If rbl IsNot Nothing Then 'This is here in case a course fills up while user registers and it becomes removed from the list
                                If rbl.InputAttributes("fullday") <> sFull Then
                                    rbl.Enabled = False
                                End If
                                'If group found, disable 
                                If rbl.GroupName = sGroup Then
                                    rbl.Enabled = False
                                End If
                                'If CourseID found, Select
                                If rbl.InputAttributes("value") = iCourseID Then
                                    rbl.Checked = True
                                End If
                            Else
                                'A course was removed after page load
                                lblAlert.Text = "We are sorry, a previously listed course is no longer available and has been removed."
                                lblAlert.Visible = True
                                hdnCtrls.Value = hdnCtrls.Value - 1
                            End If
                        Next
                    Next


                End If
            End If
        Else
            PanelParticipationControl.Visible = True
            PanelForm.Visible = False
        End If


    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        lblAlert.Text = ""
        lblAlert.Visible = False
        Dim PersonID As Integer
        If Session("PersonID") IsNot Nothing AndAlso Session("PersonID").ToString <> "" Then

            PersonID = Session("PersonID")
            Dim bSelected As Boolean = False

            Dim promoIn As String = "false"

            'Check for short course promo code waived fee
            If String.IsNullOrEmpty(hdnPromoCode.Value) = False Then
                SqlDataSourcePromoValidate.SelectParameters("PersonID").DefaultValue = PersonID
                SqlDataSourcePromoValidate.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                SqlDataSourcePromoValidate.SelectParameters("ShortCoursePromoCode_IN").DefaultValue = hdnPromoCode.Value
            End If


            ' PersonID = Request.Cookies("battelle")("personid")
            If hdnCtrls.Value <> 0 Then
                    For i = 0 To hdnCtrls.Value - 1
                        'SCGTODO - add controls to stop full day and half day selections
                        'loop through each radio button

                        Dim iValid As Integer = 0

                        Dim sRBL As String
                        sRBL = "rbl" & i
                        Dim rbl As New RadioButton
                        rbl = CType(PlaceHolder1.FindControl(sRBL), RadioButton)


                        If rbl IsNot Nothing Then 'This is here in case a course fills up while user registers and it becomes removed from the list
                            If rbl.Enabled = True Then
                                If rbl.Checked = True Then 'Submit to databse
                                    SqlDataSourceReg.InsertParameters("PersonID").DefaultValue = PersonID
                                    SqlDataSourceReg.InsertParameters("CourseID").DefaultValue = rbl.InputAttributes("value").ToString
                                    SqlDataSourceReg.InsertParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
                                If String.IsNullOrEmpty(hdnPromoCode.Value) = False Then
                                    Dim promoView As DataView
                                    Dim promoRows As Integer
                                    SqlDataSourcePromoValidate.SelectParameters("CourseID").DefaultValue = Int32.Parse(rbl.InputAttributes("value"))
                                    promoView = CType(SqlDataSourcePromoValidate.Select(DataSourceSelectArguments.Empty), DataView)
                                    promoRows = CType(promoView.Table.Rows.Count, Integer)
                                    If promoRows > 0 Then ' Data found
                                        iValid = promoView.Table.Rows(0)("PromoValid")
                                        If iValid = 1 Then 'Promo code valid, set course fee to zero and fee type ID to 49 - Waived State/Fed. Govt. Short Course Fee
                                            SqlDataSourceReg.InsertParameters("FeeTypeID").DefaultValue = 49
                                            SqlDataSourceReg.InsertParameters("Amount").DefaultValue = 0
                                            SqlDataSourceReg.InsertParameters("Notes").DefaultValue = "Waived State/Fed. Govt. Short Course Fee"
                                        Else
                                            SqlDataSourceReg.InsertParameters("FeeTypeID").DefaultValue = rbl.InputAttributes("feed").ToString
                                            SqlDataSourceReg.InsertParameters("Amount").DefaultValue = rbl.InputAttributes("fee").ToString
                                            SqlDataSourceReg.InsertParameters("Notes").DefaultValue = ""
                                        End If

                                    End If
                                Else
                                    SqlDataSourceReg.InsertParameters("FeeTypeID").DefaultValue = rbl.InputAttributes("feed").ToString
                                    SqlDataSourceReg.InsertParameters("Amount").DefaultValue = rbl.InputAttributes("fee").ToString
                                    SqlDataSourceReg.InsertParameters("Notes").DefaultValue = ""
                                End If

                                SqlDataSourceReg.InsertParameters("Fail").DefaultValue = "No"
                                    SqlDataSourceReg.Insert()
                                    bSelected = True
                                End If
                            End If
                        Else
                            lblAlert.Text = "We are sorry, a previously listed course is no longer available and has been removed."
                            lblAlert.Visible = True
                            hdnCtrls.Value = hdnCtrls.Value - 1
                        End If




                    Next
                    'If bSelected = True Then
                    If txtSpecialNeeds.Text <> "" Then
                        SqlDataSourceSpecialNeeds.UpdateParameters("PersonID").DefaultValue = PersonID
                        SqlDataSourceSpecialNeeds.UpdateParameters("SpecialNeeds").DefaultValue = txtSpecialNeeds.Text

                        SqlDataSourceSpecialNeeds.Update()
                    End If


                    Dim sURL As String
                    sURL = "~/" & ConferenceControl.ConferenceURLString & "/shortcourse/balance"
                    If lblAlert.Text = "" Then 'No classes reached max capacity, proceed
                        Response.Redirect(sURL, True)
                    End If

                    ' Else
                    'No selection
                    'lblMessage.Visible = True
                    'End If

                End If
            Else
                PanelParticipationControl.Visible = True
            PanelForm.Visible = False
        End If
    End Sub


    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        For i = 0 To hdnCtrls.Value - 1
            Dim sRBL As String
            sRBL = "rbl" & i
            Dim rbl As New RadioButton
            rbl = CType(PlaceHolder1.FindControl(sRBL), RadioButton)
            rbl.Checked = False
        Next
    End Sub

    Protected Sub SqlDataSourceReg_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceReg.Inserted
        'Course reached max capacity before user submitted
        Dim command As DbCommand
        command = e.Command
        Dim sFail As String

        sFail = command.Parameters("@Fail").Value


        If sFail <> "No" Then
            lblAlert.Visible = True
            If lblAlert.Text = "" Then
                lblAlert.Text = "We are sorry, maximum capacity has been reached for the following and will no longer be available: <br><b>" & sFail & "</b>"
            Else
                lblAlert.Text += "<br><b>" & sFail & "</b>"
            End If
            lblAlert.Text += "<br>Please make an alternate selection."
            hdnCtrls.Value = hdnCtrls.Value - 1
            btnSubmit.Visible = False
            btnClear.Visible = False
            btnAlert.Visible = True
            PlaceHolder1.Visible = False
        End If

    End Sub

    Protected Sub btnAlert_Click(sender As Object, e As EventArgs) Handles btnAlert.Click
        btnAlert.Visible = False
        btnSubmit.Visible = True
        btnClear.Visible = True
        lblAlert.Text = ""
        lblAlert.Visible = False
        PlaceHolder1.Visible = True
        ClearForm()
    End Sub
End Class