Imports System.Data
Imports System.Data.Common
Imports System.Web.Routing

Public Class BoothLayout
    Inherits System.Web.UI.UserControl

    Delegate Sub OnFinishedLogin()

    Public Event FinishedLogin As OnFinishedLogin

    Delegate Sub OnBoothFail()

    Public Event BoothFail As OnBoothFail

    Delegate Sub OnBoothAlreadyReserved()

    Public Event BoothAlreadyReserved As OnBoothAlreadyReserved

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim ConferenceControl As ConferenceFromURL = CType(Me.Parent.Page.Master.FindControl("ConferenceFromURL"), ConferenceFromURL)
        SqlDataSourceReserve.UpdateParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        SqlDataSourceBoothFees.SelectParameters("ConferenceID").DefaultValue = ConferenceControl.ConferenceID
        btnShowExhibitors.OnClientClick = "window.open('list','Exhibitors','resizeable=yes,scrollbars=yes,width=400,height=600')"

        'Get booth fees
        Dim iRows As Integer
        Dim dv As DataView

        Dim iBoothFee, iExhibitorBoothFee, iSponsorBoothFee, iIslandFee, iSponsorIslandUpgradeFee, iExhibitorIslandUpgradeFee,
            iSecondBoothFee, iSponsorSecondBoothFee, iExhibitorSecondBoothFee, iCornerBoothFee, iPremiumBoothFee As Integer

        dv = CType(SqlDataSourceBoothFees.Select(DataSourceSelectArguments.Empty), DataView)
        iRows = CType(dv.Table.Rows.Count, Integer)
        If iRows > 0 Then ' Data found
            iExhibitorBoothFee = dv.Table.Rows(0)("ExhibitorBooth")
            iSponsorBoothFee = dv.Table.Rows(0)("SponsorBooth")
            If Not Convert.IsDBNull(dv.Table.Rows(0)("SponsorIslandUpgrade")) Then
                iSponsorIslandUpgradeFee = dv.Table.Rows(0)("SponsorIslandUpgrade")
            End If
            If Not Convert.IsDBNull(dv.Table.Rows(0)("ExhibitorIslandUpgrade")) Then
                iExhibitorIslandUpgradeFee = dv.Table.Rows(0)("ExhibitorIslandUpgrade")
            End If
            If Not Convert.IsDBNull(dv.Table.Rows(0)("SponsorSecondBooth")) Then
                iSponsorSecondBoothFee = dv.Table.Rows(0)("SponsorSecondBooth")
            End If
            If Not Convert.IsDBNull(dv.Table.Rows(0)("ExhibitorSecondBooth")) Then
                iExhibitorSecondBoothFee = dv.Table.Rows(0)("ExhibitorSecondBooth")
            End If
            If Not Convert.IsDBNull(dv.Table.Rows(0)("CornerBooth")) Then
                iCornerBoothFee = dv.Table.Rows(0)("CornerBooth")
            End If
            If Not Convert.IsDBNull(dv.Table.Rows(0)("PremiumBooth")) Then
                iPremiumBoothFee = dv.Table.Rows(0)("PremiumBooth")
            End If

        End If

        Me.lblServerTime.Text = " <i>Current Server Time: </i>" & Now()

        'Get open date
        Dim dOpenDate As Date

        If ConferenceControl.SponsorOpenDate > Now() Then 'Hide exhibitor list since nobody has registered yet
            btnShowExhibitors.Visible = False
        Else
            btnShowExhibitors.Visible = True
        End If

        'Sponsor or exhibitor?
        If hdnRegType.Value = "sponsor" Then
            dOpenDate = ConferenceControl.SponsorOpenDate
            iBoothFee = iSponsorBoothFee
            iSecondBoothFee = iSponsorSecondBoothFee
            iIslandFee = iSponsorIslandUpgradeFee
        Else
            dOpenDate = ConferenceControl.ExhibitOpenDate
            iBoothFee = iExhibitorBoothFee
            iSecondBoothFee = iBoothFee + iExhibitorSecondBoothFee
            iIslandFee = iBoothFee + iExhibitorIslandUpgradeFee
        End If

        'Enable selection based on date
        btnReserve.Enabled = (dOpenDate < Now())
        selBooth.Enabled = (dOpenDate < Now())
        selBooth2.Enabled = (dOpenDate < Now())

        'Change prominence of the refresh button (not as needed once the booths open for sale)
        If dOpenDate < Now() Then
            LinkButtonRefresh.CssClass = "btn btn-default  btn-sm" 'less prominent
        Else
            LinkButtonRefresh.CssClass = "btn btn-info  btn-sm" 'more prominent
        End If

        Dim dvMap, dvBooths As DataView
        'Dim iRows As Integer
        Dim iBoothWidth As Integer = 0
        Dim iBoothHeight As Integer = 0
        Dim iBoothWidthLayout As Integer = 0
        Dim iBoothHeightLayout As Integer = 0
        Dim sAvailable, sAvailableText As String
        Dim sPremium, sPremiumText As String
        Dim sCorner, sCornerText As String
        Dim sCornerPremium, sCornerPremiumText As String
        Dim sReserved, sReservedText As String
        Dim sDisabled, sDisabledText As String
        Dim iBooth, iBoothID, iFontSize As Integer
        Dim sBoothStatus As String
        Dim bVertical As Boolean = False
        Dim bUseImage As Boolean = False
        Dim bPremium As Boolean = False
        Dim bCorner As Boolean = False
        Dim bIsland As Boolean = False
        Dim iBoothsAllowed As Integer = 1
        Dim iRealWidth As Integer
        Dim iRealHeight As Integer



        dvMap = CType(SqlDataSourceBoothLayout.Select(DataSourceSelectArguments.Empty), DataView)
        iRows = CType(dvMap.Table.Rows.Count, Integer)


        'Look for Booth layout information
        If iRows > 0 Then ' Data found
            iBoothsAllowed = dvMap.Table.Rows(0).Item("BoothCount")

            Me.pnlBoothMap.Width = dvMap.Table.Rows(0).Item("ImageWidth").ToString
            Me.pnlBoothMap.Height = dvMap.Table.Rows(0).Item("ImageHeight").ToString
            Me.pnlBoothMap.BackImageUrl = "~/images/exhibits/" & dvMap.Table.Rows(0).Item("ImageName").ToString
            iBoothHeightLayout = dvMap.Table.Rows(0).Item("BoothHeight").ToString
            iBoothWidthLayout = dvMap.Table.Rows(0).Item("BoothWidth").ToString
            sAvailable = dvMap.Table.Rows(0).Item("ColorAvailable").ToString
            sAvailableText = dvMap.Table.Rows(0).Item("ColorAvailableText").ToString
            sPremium = dvMap.Table.Rows(0).Item("ColorPremium").ToString
            sPremiumText = dvMap.Table.Rows(0).Item("ColorPremiumText").ToString
            sCorner = dvMap.Table.Rows(0).Item("ColorCorner").ToString
            sCornerText = dvMap.Table.Rows(0).Item("ColorCornerText").ToString
            sCornerPremium = dvMap.Table.Rows(0).Item("ColorCornerPremium").ToString
            sCornerPremiumText = dvMap.Table.Rows(0).Item("ColorCornerPremiumText").ToString
            sReserved = dvMap.Table.Rows(0).Item("ColorReserved").ToString
            sReservedText = dvMap.Table.Rows(0).Item("ColorReservedText").ToString
            sDisabled = dvMap.Table.Rows(0).Item("ColorDisabled").ToString
            sDisabledText = dvMap.Table.Rows(0).Item("ColorDisabledText").ToString
            iFontSize = dvMap.Table.Rows(0).Item("FontSizePx").ToString
            iRealWidth = dvMap.Table.Rows(0).Item("RealWidthFeet").ToString
            iRealHeight = dvMap.Table.Rows(0).Item("RealHeightFeet").ToString
            'iPaddingLeft = dvMap.Table.Rows(0).Item("PaddingLeftPx").ToString

            'Register javascript
            Dim cs As ClientScriptManager = Page.ClientScript
            Dim cstype As Type = Me.GetType()
            Dim csname As String = "SelectBooth"
            If (Not cs.IsClientScriptBlockRegistered(cstype, csname)) Then

                Dim cstext As New StringBuilder()
                cstext.Append("<script type=""text/javascript""> function SelectBooth(n) {")
                cstext.Append("if (document.getElementById('" & Me.selBooth.ClientID & "').value == """") ")
                cstext.Append("{document.getElementById('" & Me.selBooth.ClientID & "').value = n;")
                If iBoothsAllowed > 1 Then
                    cstext.Append("document.getElementById('" & Me.selBooth2.ClientID & "').disabled=false;")
                End If
                cstext.Append("document.getElementById('" & Me.hdnIsland.ClientID & "').value = """";}")
                If iBoothsAllowed > 1 Then
                    cstext.Append("else if (document.getElementById('" & Me.selBooth2.ClientID & "').value == """" && !document.getElementById('" & Me.selBooth2.ClientID & "').disabled) ")
                    cstext.Append("{document.getElementById('" & Me.selBooth2.ClientID & "').value = n;")
                    cstext.Append("document.getElementById('" & Me.hdnBoothCount.ClientID & "').value = 2;")
                    cstext.Append("alert(""Please note, you have opted to reserve a double booth at the additional cost of $" & iExhibitorSecondBoothFee & " over the cost of a single booth. If you only want a single booth, click the Refresh Booth Layout button or use the drop down lists to modify your selection."");}")
                    cstext.Append("else alert(""You may only register for two booths or one island. Click the Refresh Booth Layout button or use the drop down list if you are trying to modify your selection."");")

                End If
                cstext.Append("}")
                cstext.Append(" function SelectIsland(n) {")
                cstext.Append("document.getElementById('" & Me.selBooth.ClientID & "').value = n;")
                If iBoothsAllowed > 1 Then
                    cstext.Append("document.getElementById('" & Me.selBooth2.ClientID & "').value = """";")
                    cstext.Append("document.getElementById('" & Me.selBooth2.ClientID & "').disabled=true;")
                End If
                cstext.Append("document.getElementById('" & Me.hdnIsland.ClientID & "').value = ""island"";")
                cstext.Append("} </script>")
                cs.RegisterClientScriptBlock(cstype, csname, cstext.ToString(), False)

            End If


            If iBoothsAllowed > 1 Then
                lblInstructions.Text = "To reserve a booth, please click on it or select from the drop-down list in the first drop-down box. To reserve a double booth (no endcaps and booths must be next to each other), please click on the two booths or use the second drop-down box below."
                selBooth2.Visible = True
                btnReserve.Text = "Reserve Booth(s)"
                'ltlDoubleBooth.Visible = True
                If hdnRegType.Value = "sponsor" Then
                    ltlDoubleBooth.Text = "<small>" & iRealWidth & "x" & (iRealHeight * 2) & " (+$" & iSecondBoothFee & ")&nbsp;&nbsp;</small>"
                Else
                    ltlDoubleBooth.Text = "<small>" & iRealWidth & "x" & (iRealHeight * 2) & " ($" & iSecondBoothFee & ")&nbsp;&nbsp;</small>"
                End If

            Else
                lblInstructions.Text = "Reserve your booth by clicking on it or using the dropdown list."
                selBooth2.Visible = False
            End If

            'If registration is not open override status
            If hdnRegType.Value = "sponsor" And ConferenceControl.SponsorOpenDate > Now() Then
                lblInstructions.Text = "Sponsor booth reservation will open beginning " & ConferenceControl.SponsorOpenDate
            End If
            If hdnRegType.Value = "exhibit" And ConferenceControl.ExhibitOpenDate > Now() Then
                sBoothStatus = "Disabled"
                lblInstructions.Text = "Exhibitor booth reservation will open beginning " & ConferenceControl.ExhibitOpenDate
            End If



            With btnLegendAvailable
                .BackColor = System.Drawing.ColorTranslator.FromHtml(sAvailable)
                .Width = (iBoothWidthLayout / 2)
                .Height = (iBoothHeightLayout / 2)
                .BorderStyle = BorderStyle.Solid
                .BorderWidth = 1
                .BorderColor = System.Drawing.ColorTranslator.FromHtml("black")
                .Enabled = False
                .Style.Add("vertical-align", "middle")
                '.Style.Add("padding", iBoothWidth & "px")
            End With

            With btnLegendPremium
                .BackColor = System.Drawing.ColorTranslator.FromHtml(sPremium)
                .Width = (iBoothWidthLayout / 2)
                .Height = (iBoothHeightLayout / 2)
                .BorderStyle = BorderStyle.Solid
                .BorderWidth = 1
                .BorderColor = System.Drawing.ColorTranslator.FromHtml("black")
                .Enabled = False
                .Style.Add("vertical-align", "middle")
                '.Style.Add("padding", iBoothWidth & "px")
            End With


            With btnLegendCorner
                .BackColor = System.Drawing.ColorTranslator.FromHtml(sCorner)
                .Width = (iBoothWidthLayout / 2)
                .Height = (iBoothHeightLayout / 2)
                .BorderStyle = BorderStyle.Solid
                .BorderWidth = 1
                .BorderColor = System.Drawing.ColorTranslator.FromHtml("black")
                .Enabled = False
                .Style.Add("vertical-align", "middle")
                '.Style.Add("padding", iBoothWidth & "px")
            End With

            With btnLegendCornerPremium
                .BackColor = System.Drawing.ColorTranslator.FromHtml(sCornerPremium)
                .Width = (iBoothWidthLayout / 2)
                .Height = (iBoothHeightLayout / 2)
                .BorderStyle = BorderStyle.Solid
                .BorderWidth = 1
                .BorderColor = System.Drawing.ColorTranslator.FromHtml("black")
                .Enabled = False
                .Style.Add("vertical-align", "middle")
                '.Style.Add("padding", iBoothWidth & "px")
            End With

            With btnLegendIsland
                .BackColor = System.Drawing.ColorTranslator.FromHtml(sPremium)
                .Width = iBoothWidthLayout
                .Height = iBoothHeightLayout
                .BorderStyle = BorderStyle.Solid
                .BorderWidth = 1
                .BorderColor = System.Drawing.ColorTranslator.FromHtml("black")
                .Enabled = False
                .Style.Add("vertical-align", "middle")
                '.Style.Add("padding", iBoothWidth & "px")
            End With

            With btnLegendReserved
                .BackColor = System.Drawing.ColorTranslator.FromHtml(sReserved)
                .Width = (iBoothWidthLayout / 2)
                .Height = (iBoothHeightLayout / 2)
                .BorderStyle = BorderStyle.Solid
                .BorderWidth = 1
                .BorderColor = System.Drawing.ColorTranslator.FromHtml("black")
                .Enabled = False
                .Style.Add("vertical-align", "middle")
                '.Style.Add("padding", iBoothWidth & "px")
            End With

            dvBooths = CType(SqlDataSourceBooths.Select(DataSourceSelectArguments.Empty), DataView)
            iRows = CType(dvBooths.Table.Rows.Count, Integer)

            For Each rowView As DataRowView In dvBooths
                ' Do something //
                Dim row As DataRow = rowView.Row
                'row.Item
            Next
            'selBooth.Items.Clear()

            'Loop through Booth table to populate the map
            For i = 0 To iRows - 1

                iBooth = dvBooths.Table.Rows(i).Item("BoothNumber").ToString
                iBoothID = dvBooths.Table.Rows(i).Item("BoothID").ToString
                bVertical = dvBooths.Table.Rows(i).Item("Vertical").ToString
                bPremium = dvBooths.Table.Rows(i).Item("PremiumBooth").ToString
                bCorner = dvBooths.Table.Rows(i).Item("CornerBooth").ToString


                sBoothStatus = dvBooths.Table.Rows(i).Item("BoothStatus").ToString
                'If ConferenceControl.SponsorOpenDate > Now() Then 'Show all booths as available up until Sponsor reservation opens
                '    sBoothStatus = "Available"
                'End If
                'If registration is not open override status
                If ConferenceControl.ExhibitPageOpen = True Then
                    If hdnRegType.Value = "sponsor" And ConferenceControl.SponsorOpenDate > Now() And sBoothStatus <> "Reserved" Then
                        sBoothStatus = "Disabled"
                    End If
                    If hdnRegType.Value = "exhibit" And ConferenceControl.ExhibitOpenDate > Now() And sBoothStatus <> "Reserved" Then
                        sBoothStatus = "Disabled"
                    End If
                End If



                'Make sure booth doesn't require an image button (skewed or odd shaped booths)
                bUseImage = dvBooths.Table.Rows(i).Item("UseImage").ToString
                'Check for booth size override, else use layout size
                If dvBooths.Table.Rows(i).Item("BoothWidth").ToString <> "" Then
                    iBoothWidth = dvBooths.Table.Rows(i).Item("BoothWidth").ToString
                    bIsland = True
                Else
                    iBoothWidth = iBoothWidthLayout
                    bIsland = False
                End If
                If dvBooths.Table.Rows(i).Item("BoothHeight").ToString <> "" Then
                    iBoothHeight = dvBooths.Table.Rows(i).Item("BoothHeight").ToString
                Else
                    iBoothHeight = iBoothHeightLayout
                End If



                If bUseImage = False Then 'Most cases

                    Dim btn As New Button()

                    With btn
                        .ID = "btn" & iBooth

                        If bVertical = True Then
                            .Width = iBoothHeight
                            .Height = iBoothWidth
                        Else
                            .Width = iBoothWidth
                            .Height = iBoothHeight
                        End If

                        .Style.Add("font-size", iFontSize & "px")
                        .Style.Add("padding", "0px")
                        .Style.Add("margin-left", dvBooths.Table.Rows(i).Item("MarginLeft").ToString & "px")
                        .Style.Add("margin-top", dvBooths.Table.Rows(i).Item("MarginTop").ToString & "px")
                        .Style.Add("position", "absolute")
                        .Style.Add("text-align", "center")
                        If bPremium = True Then
                            .Style.Add("font-weight", "bold")
                        End If
                        If bIsland = True Then
                            .Style.Add("font-weight", "bold")
                        End If
                        If bCorner = True Then
                            .Style.Add("font-style", "italic")
                        End If
                        .Text = iBooth
                        .BorderStyle = BorderStyle.None
                        .CausesValidation = False
                        .UseSubmitBehavior = False
                    End With

                    Select Case sBoothStatus
                        Case "Available"
                            'AddHandler btn.Click, AddressOf Me.btn_Click
                            'Handler no longer used, using Javascript to ensure faster response.


                            With btn
                                If bPremium = True And hdnRegType.Value <> "sponsor" Then
                                    If bCorner = True Then 'Premium Corner
                                        .BackColor = System.Drawing.ColorTranslator.FromHtml(sCornerPremium)
                                        .ForeColor = System.Drawing.ColorTranslator.FromHtml(sCornerPremiumText)
                                        If btnLegendCornerPremium.Visible = False Then
                                            btnLegendCornerPremium.Visible = True
                                            Dim iCornerPremiumFee As Integer
                                            iCornerPremiumFee = iCornerBoothFee + iPremiumBoothFee
                                            ltlLegendCornerPremium.Visible = True
                                            ltlLegendCornerPremium.Text = "<small><b><i>Corner/Premium</i></b> (+$" & iCornerPremiumFee & ")&nbsp;&nbsp;</small>"
                                        End If
                                    Else 'Premium
                                        .BackColor = System.Drawing.ColorTranslator.FromHtml(sPremium)
                                        .ForeColor = System.Drawing.ColorTranslator.FromHtml(sPremiumText)
                                        If btnLegendPremium.Visible = False Then
                                            btnLegendPremium.Visible = True
                                            ltlLegendPremium.Visible = True
                                            ltlLegendPremium.Text = "<small><b>Premium</b> (+$" & iPremiumBoothFee & ")&nbsp;&nbsp;</small>"
                                        End If
                                    End If
                                ElseIf bCorner = True And hdnRegType.Value <> "sponsor" 'Corner booth
                                    .BackColor = System.Drawing.ColorTranslator.FromHtml(sCorner)
                                    .ForeColor = System.Drawing.ColorTranslator.FromHtml(sCornerText)
                                    If btnLegendCorner.Visible = False Then
                                        btnLegendCorner.Visible = True
                                        ltlLegendCorner.Visible = True
                                        ltlLegendCorner.Text = "<small><i>Corner</i> (+$" & iCornerBoothFee & ")&nbsp;&nbsp;</small>"
                                    End If
                                ElseIf bIsland = True 'Island, color it like a Premium booth (for now no separate color for Islands)
                                    .BackColor = System.Drawing.ColorTranslator.FromHtml(sPremium)
                                    .ForeColor = System.Drawing.ColorTranslator.FromHtml(sPremiumText)
                                    If btnLegendIsland.Visible = False Then
                                        btnLegendIsland.Visible = True
                                        ltlLegendIsland.Visible = True
                                        If hdnRegType.Value = "sponsor" Then
                                            ltlLegendIsland.Text = "<small><b>" & (iRealWidth * 2) & "x" & (iRealHeight * 2) & "</b> (+$" & iIslandFee & ")&nbsp;&nbsp;</small>"
                                        Else
                                            ltlLegendIsland.Text = "<small><b>" & (iRealWidth * 2) & "x" & (iRealHeight * 2) & "</b> ($" & iIslandFee & ")&nbsp;&nbsp;</small>"
                                        End If

                                    End If
                                Else 'Normal booth
                                    .BackColor = System.Drawing.ColorTranslator.FromHtml(sAvailable)
                                    .ForeColor = System.Drawing.ColorTranslator.FromHtml(sAvailableText)
                                    If btnLegendAvailable.Visible = False Then
                                        btnLegendAvailable.Visible = True
                                        ltlLegendAvailable.Visible = True
                                        If hdnRegType.Value = "sponsor" Then
                                            ltlLegendAvailable.Text = "<small>Standard " & iRealWidth & "x" & iRealHeight & " (Included)&nbsp;&nbsp;</small>"
                                        Else
                                            ltlLegendAvailable.Text = "<small>Standard " & iRealWidth & "x" & iRealHeight & " ($" & iBoothFee & ")&nbsp;&nbsp;</small>"
                                        End If
                                        If iBoothsAllowed > 1 Then
                                            ltlDoubleBooth.Visible = True
                                        End If
                                    End If
                                End If

                                .ToolTip = "Available"
                                If Page.RouteData.Values("layout") = "view" Then 'Booth layout view page, disable click
                                    .OnClientClick = "return false;"
                                Else
                                    If bIsland = True Then
                                        .OnClientClick = "SelectIsland(" & iBoothID & "); return false;"

                                    Else
                                        .OnClientClick = "SelectBooth(" & iBoothID & "); return false;"
                                    End If

                                End If

                            End With
                        'If Not IsPostBack Then
                        '    With Me.selBooth
                        '        '.Items.Insert(0, New ListItem(iBooth, iBoothID))
                        '        '.Items.Add(New ListItem(iBooth, iBoothID))
                        '    End With
                        'End If

                        Case "Reserved"
                            With btn
                                .BackColor = System.Drawing.ColorTranslator.FromHtml(sReserved)
                                .ForeColor = System.Drawing.ColorTranslator.FromHtml(sReservedText)
                                .ToolTip = dvBooths.Table.Rows(i).Item("Exhibitor").ToString
                                .Style.Add("cursor", "default")
                                .OnClientClick = "return false;"
                            End With
                            If btnLegendReserved.Visible = False Then
                                btnLegendReserved.Visible = True
                                ltlLegendReserved.Visible = True
                            End If
                        'selBooth.Items.Remove(iBooth)
                        Case "Removed" 'Option to take booths off the map with ability to return them later
                            With btn
                                .Visible = False
                            End With
                        'selBooth.Items.Remove(iBooth)
                        Case Else 'Disabled
                            With btn
                                .BackColor = System.Drawing.ColorTranslator.FromHtml(sDisabled)
                                .ForeColor = System.Drawing.ColorTranslator.FromHtml(sDisabledText)
                                .ToolTip = "Available"
                                .Style.Add("cursor", "default")
                                .OnClientClick = "return false;"
                            End With
                            'selBooth.Items.Remove(iBooth)
                    End Select

                    PlaceHolder1.Controls.Add(btn)
                Else
                    Dim btn As New ImageButton()
                    With btn
                        .ID = "btn" & iBooth
                        .Style.Add("margin-left", dvBooths.Table.Rows(i).Item("MarginLeft").ToString & "px")
                        .Style.Add("margin-top", dvBooths.Table.Rows(i).Item("MarginTop").ToString & "px")
                        .Style.Add("position", "absolute")
                        .BorderStyle = BorderStyle.None
                        .CausesValidation = False
                    End With

                    Select Case sBoothStatus
                        Case "Available"
                            'AddHandler btn.Click, AddressOf Me.btn_Click
                            'Handler no longer used, using Javascript to ensure faster response.

                            With btn
                                .BackColor = System.Drawing.ColorTranslator.FromHtml(sAvailable)
                                .ForeColor = System.Drawing.ColorTranslator.FromHtml(sAvailableText)
                                .ToolTip = "Available"
                                If Page.RouteData.Values("layout") = "view" Then
                                    .OnClientClick = "return false;"
                                Else
                                    .OnClientClick = "SelectBooth(" & iBoothID & "); return false;"
                                End If

                            End With
                        'If Not IsPostBack Then
                        '    With Me.selBooth
                        '        '.Items.Insert(0, New ListItem(iBooth, iBoothID))
                        '        '.Items.Add(New ListItem(iBooth, iBoothID))
                        '    End With
                        'End If

                        Case "Reserved"
                            With btn
                                .BackColor = System.Drawing.ColorTranslator.FromHtml(sReserved)
                                .ForeColor = System.Drawing.ColorTranslator.FromHtml(sReservedText)
                                .ToolTip = dvBooths.Table.Rows(i).Item("Exhibitor").ToString
                                .Style.Add("cursor", "default")
                                .OnClientClick = "return false;"
                            End With
                        'selBooth.Items.Remove(iBooth)
                        Case "Removed" 'Option to take booths off the map with ability to return them later
                            With btn
                                .Visible = False
                            End With
                        'selBooth.Items.Remove(iBooth)
                        Case Else 'Disabled
                            With btn
                                .BackColor = System.Drawing.ColorTranslator.FromHtml(sDisabled)
                                .ForeColor = System.Drawing.ColorTranslator.FromHtml(sDisabledText)
                                .ToolTip = "Available"
                                .Style.Add("cursor", "default")
                                .OnClientClick = "return false;"
                            End With
                            'selBooth.Items.Remove(iBooth)
                    End Select

                    PlaceHolder1.Controls.Add(btn)
                End If
            Next
            'selBooth.Items.Insert(0, "")
        Else
            'Bad query string
            Response.Redirect("~/Error.aspx", True)

        End If


    End Sub


    Private Sub btn_Click(sender As Object, e As EventArgs)
        'No longer used - using Javascript OnClick to ensure faster response
        Dim btn As Button = TryCast(sender, Button)
        Dim sBooth = Replace(btn.ID, "btn", "")
    End Sub



    Protected Sub btnReserve_Click(sender As Object, e As EventArgs) Handles btnReserve.Click

        'Added on 8/20/2015 to fix bug to make sure hdnBoothCount equals 2 when selecting both booths from drop-down boxes instead of legend
        If selBooth.SelectedValue <> "" And selBooth2.SelectedValue <> "" Then
            hdnBoothCount.Value = "2"
        End If

        If selBooth.SelectedValue <> "" Then
            If (hdnBoothCount.Value = "2") Or (selBooth.SelectedValue <> "" And selBooth2.SelectedValue <> "") Then 'Check for 2 booths
                If selBooth2.SelectedValue <> "" Then '2nd booth Okay
                    SqlDataSourceReserve.Update()
                Else 'Second booth taken
                    BoothAlreadyTaken()
                End If
            Else
                SqlDataSourceReserve.Update()
            End If

        Else
            'First Booth has been removed from the dropdown list 
            BoothAlreadyTaken()
        End If
    End Sub

    Protected Sub SQLDataSourceReserve_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceReserve.Updated
        Dim command As DbCommand
        command = e.Command
        Dim iFail As Integer

        iFail = command.Parameters("@Fail").Value


        Select Case iFail
            Case 1 'near simulataneous clicks by different users
                BoothAlreadyTaken()
            Case 2 'Exhibitor already selected a booth
                ExhibHasBooth()
            Case 3 'End Cap
                EndCap()
            Case 4 'Second booth scooped with near simultaneous transactions
                SecondBoothTakenLikeWhoa()

            Case Else 'Success
                Session("BoothID") = Me.selBooth.SelectedValue
                RaiseEvent FinishedLogin()
        End Select


    End Sub

    Sub BoothAlreadyTaken() 'Case 1
        'Booth already selected
        Me.lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Unfortunately your booth choice has been selected by another company. Please try again.</div>"
        Me.lblAlert.Visible = True
        Me.selBooth.SelectedIndex = 0
        Me.selBooth2.SelectedIndex = 0
        hdnBoothCount.Value = ""
        RaiseEvent BoothFail()
    End Sub

    Sub SecondBoothTakenLikeWhoa() 'Case 4
        '2nd booth selected in an exact simultaneous event where planets aligned to conspire against the exhibitor
        Me.lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Unfortunately your second booth choice has been selected by another company. Would you like to choose different booths or keep the one that was successfully reserved?</div>"
        Me.lblAlert.Visible = True
        Me.selBooth.SelectedIndex = 0
        Me.selBooth2.SelectedIndex = 0
        hdnBoothCount.Value = ""
        RaiseEvent BoothFail() 'Whoa
    End Sub

    Sub EndCap() 'Case 3
        'Booth already selected
        Me.lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">Booths at the end of a row (endcaps) are not permitted. Please try again.</div>"
        Me.lblAlert.Visible = True
        Me.selBooth.SelectedIndex = 0
        Me.selBooth2.SelectedIndex = 0
        hdnBoothCount.Value = ""
        RaiseEvent BoothFail()
    End Sub

    Sub ExhibHasBooth() 'Case 2
        'Booth already selected
        Me.lblAlert.Text = "<div class=""alert alert-danger"" role=""alert"">You have already completed booth reservation for your company.</div>"
        Me.lblAlert.Visible = True
        RaiseEvent BoothAlreadyReserved()
    End Sub


    Protected Sub LinkButtonRefresh_Click(sender As Object, e As EventArgs) Handles LinkButtonRefresh.Click
        selBooth.SelectedIndex = 0
        selBooth2.SelectedIndex = 0
        hdnIsland.Value = ""
        hdnBoothCount.Value = ""
    End Sub
End Class