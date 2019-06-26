<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SessionHandler.ascx.vb" Inherits="Battelle.SessionHandler" %>

<%@ Register Src="~/ParticipationIDLogin.ascx" TagPrefix="uc1" TagName="ParticipationIDLogin" %>

<script type="text/javascript">

    //Set timeouts for when the warning message
    //should be displayed, and what should happen 
    //when the session actually expires.
    function StartTimers()
    {
        setTimeout('ShowSessionTimeoutWarning()', '<%=WarningTimeoutInMilliseconds%>');
        setTimeout('ShowSessionExpiredNotification()', '<%=SessionTimeoutInMilliseconds%>');
        console.log("test start");
    }

    //Notify the user that his session is ABOUT to expire.
    //Do so by making our warning div tag visible.
    function ShowSessionTimeoutWarning()
    {
        var divSessionTimeoutWarning = document.getElementById('<%=divSessionTimeoutWarning.ClientID%>');        
        var divOverlay = document.getElementById('<%=divOverlay.ClientID%>');

        divSessionTimeoutWarning.style.display = 'inline';
        divOverlay.style.display = 'inline';

        var seconds_left = 60;
        var interval = setInterval(function () {
            if (seconds_left <= 1) {
                clearInterval(interval);
            }
            document.getElementById('timerLabel').innerHTML = --seconds_left;
        }, 1000);
        console.log("test warning");
    }

    //Notify the user that his session HAS expired.
    function ShowSessionExpiredNotification() {
        if('<%=AutomaticRedirect%>' == "True"){
            var divSessionTimeoutWarning = document.getElementById('<%=divSessionTimeoutWarning.ClientID%>');
            
            //Send the user to a new page.
            window.location = '<%=TargetURLForSessionTimeout%>';
        } else{

            //To tell the user that his session has expired, WITHOUT redirecting, 
            //remove the above line, and uncomment this section:
            //Re-use the existing label, but change the text.
            var lblSessionWarning = document.getElementById('<%=lblSessionWarning.ClientID%>');
            lblSessionWarning.innerText = 'Your session has expired. Please log in again to continue working.';

            //Hide continue working button, show log in button
            var btnContinueWorking = document.getElementById('<%=btnContinueWorking.ClientID%>');
            var btnLogIn = document.getElementById('<%=btnLogInAgain.ClientID%>');
            btnContinueWorking.style.display = 'none';
            btnLogIn.style.display = 'inline';

            //Hide countdown.
            var lblSessionWarning2 = document.getElementById('<%=lblSessionWarning2.ClientID%>');
            var lblSessionWarning3 = document.getElementById('<%=lblSessionWarning3.ClientID%>');
            var timer = document.getElementById('timerLabel');

            lblSessionWarning2.innerText = '';
            lblSessionWarning3.innerText = '';
            timer.style.display = 'none';
        }
        console.log("test exp");
        //RaiseEvent('SessionTimeOut');
    }

    function ResetClientSideSessionTimers()
    {
        var divSessionTimeoutWarning = document.getElementById('<%=divSessionTimeoutWarning.ClientID%>');
        var divOverlay = document.getElementById('<%=divOverlay.ClientID%>');

        divSessionTimeoutWarning.style.display = 'none';
        divOverlay.style.display = 'none';

        //Reset timers so we can warn the user the NEXT time the session is about to expire.
        setTimeout('ShowSessionTimeoutWarning()', '<%=WarningTimeoutInMilliseconds%>');
        setTimeout('ShowSessionExpiredNotification()', '<%=SessionTimeoutInMilliseconds%>');
        document.getElementById('timerLabel').innerHTML = '60';
        console.log("test reset");
    }

    function StartNewSession()
    {
        var divSessionTimeoutWarning = document.getElementById('<%=divSessionTimeoutWarning.ClientID%>');
        var divOverlay = document.getElementById('<%=divOverlay.ClientID%>');

        divSessionTimeoutWarning.style.display = 'none';
        divOverlay.style.display = 'none';
        console.log("test new");
        __doPostBack('btnLogInAgain');
    }
</script>
<asp:Panel ID="PanelParticipationControlHandler" runat="server" Visible="False">
    <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" />
</asp:Panel>
<div id="divOverlay" runat="server" style="background: #e9e9e9;
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    opacity: 0.6;">
</div>
<div id="divSessionTimeoutWarning" runat="server" 
            style="position: fixed; 
            left: 50%; 
            margin-left: -260px;
            top: 50%; 
            margin-top: -50px; 
            border-style: solid; 
            text-align: center; 
            background: #e9e9e9">
    <asp:UpdatePanel ID="UpdatePanelHandler1" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblSessionWarning" runat="server" Text="Your server session is about to expire due to inactivity."></asp:Label>
            <br />
            <asp:Label ID="lblSessionWarning2" runat="server" Text="Click 'Continue Working' within the next "></asp:Label>
            <span ID="timerLabel">60</span>
            <asp:Label ID="lblSessionWarning3" runat="server" Text=" seconds to prolong your session."></asp:Label>
            <br />
            <asp:Button ID="btnContinueWorking" runat="server" Text="Continue Working" 
                OnClientClick="ResetClientSideSessionTimers()" 
                OnClick="btnContinueWorking_Click" 
                Style="margin: 10px;"/>
            <asp:Button ID="btnLogInAgain" runat="server" Text="Log In"
                OnClientClick="StartNewSession()"
                OnClick="btnLogInAgain_Click"
                Style="margin: 10px;display: none;" /> 
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        StartTimers();
    </script>
</div>