Public Class SponsorOpportunities
    Inherits System.Web.UI.Page
    Dim ConferenceControl As New ConferenceFromURL
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Not IsPostBack Then
        Dim dv As DataView
        Dim iRows As Integer

        ConferenceControl = Master.FindControl("ConferenceFromURL")

        SqlDataSourceFees.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        'lblEmail.Text = ConferenceControl.ConferencePlannerEmail


        dv = CType(SqlDataSourceFees.Select(DataSourceSelectArguments.Empty), DataView)
        iRows = CType(dv.Table.Rows.Count, Integer)


        If iRows > 0 Then ' Data found

            Dim sSponsorType As String = ""
            Dim iCourseID As Integer = 0
            Dim iMax As Integer = 0
            Dim bAvailable As Boolean = True
            Dim iSponsorCount As Integer = 0

            For i = 0 To iRows - 1
                Dim rbl As New RadioButton()
                Dim lblCloseDiv As New Label()
                Dim lblGroup As New Label()
                Dim lblSponsor As New Label()
                Dim hdnFee As New HiddenField()
                Dim hdnFull As New HiddenField()
                Dim clickDiv As New HtmlGenericControl
                Dim descriptionDiv As New HtmlGenericControl
                Dim lblMax As New Label()
                'Add note for full-day session 

                If Not IsDBNull(dv.Table.Rows(i).Item("SponsorTypeDetails")) Then
                    'clickDiv.Attributes.Add("class", "show col-md-11 col-md-offset-1")
                    'clickDiv.InnerHtml = "<p>Show Sponsorship description</p>"
                    'clickDiv.Style.Add("margin-top", "1em")
                    'clickDiv.Style.Add("color", "#5bb1e4")
                    'clickDiv.Style.Add("cursor", "pointer")
                    'descriptionDiv.Style.Add("display", "none")
                    descriptionDiv.Attributes.Add("class", "col-md-11 col-md-offset-1")

                    descriptionDiv.InnerHtml = dv.Table.Rows(i).Item("SponsorTypeDetails")
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
                PlaceHolderSponsorTypes.Controls.Add(lblSponsor)

                PlaceHolderSponsorTypes.Controls.Add(lblCloseDiv)
                'lblPresenter.Text = "</div></div><div class=""row""><div class=""col-md-11 col-md-offset-1"">" &
                '    dv.Table.Rows(i).Item("CoursePresenter").ToString & "</div></div>"

                'PlaceHolder1.Controls.Add(hdnFee)
                'PlaceHolder1.Controls.Add(hdnFull)

                PlaceHolderSponsorTypes.Controls.Add(clickDiv)
                PlaceHolderSponsorTypes.Controls.Add(descriptionDiv)
            Next
        End If

        'End If

    End Sub

End Class