<cfoutput>

	<span style="margin-top:50px;"></span>
	
	#rc.result.message#<br/>

	<cfif structKeyExists(rc.result, "userUID")>
		<cfmail to="#rc.user.getEmail()#"
			from="kordicdanilo@gmail.com"
			subject="Welcome to Me"
			type="html">
			<h2>Dear #rc.user.getFirstName()# #rc.user.getLastName()#</h2>

			We, here at ME, would like to thank you for joining.<br/><br/>

			Please click this link to <a href="http://localhost/fw1Test/index.cfm?action=users.confirm&userUID=#rc.result.userUID#">confirm</a> your account
			<br/><br/><br/>
			Best wishes
			Danilo
		</cfmail>


		A confirmation email has been sent to your email!<br/>
		<a href="#buildUrl('main')#">Go to home page!</a>	
	<cfelse>
		<a href="#buildUrl('main')#">Go to home page!</a>
	</cfif>	



</cfoutput>