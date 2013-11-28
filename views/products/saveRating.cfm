<cfoutput>
	<cfset fRating=""/>
	<cfset fProductUID=""/>
	<cfset fUserUID=""/>
	
	<cfif isDefined("rc.rating")><cfset fRating="#rc.rating#" /></cfif>		
	<cfif isDefined("rc.puid")><cfset fProductUID="#rc.puid#" /></cfif>		
	<cfif isDefined("rc.uuid")><cfset fUserUID="#rc.uuid#" /></cfif>		

	<!--- add rating to DB --->

</cfoutput>